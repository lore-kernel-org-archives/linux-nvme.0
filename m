Return-Path: <SRS0=2QKc=EB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5C5C2D0A3
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2020 08:20:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A5C720878
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2020 08:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W+/v9f+g";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="WIOCtT2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5C720878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:To:Subject:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5U+L7v37DvD0KuXWffb075JXYH4ckFhReDCFbvBLBls=; b=W+/v9f+gVodkDmKmCOdoqWVW5X
	Lg80Ad8jekvyP+OlNYQNRx3k4B/2rKT56o8kWAnwjyF11TTeBthyA8C1x4m0GaAwNDBEMNagkL6E0
	2lORel97EQJ0aMOdALN5TneuLjB12HL8s3rlDjFcBv93yiN81Z0kY8h95/DI+55ccWDgu/kqAtjJt
	LnToO4afLFfFIh/eoXHbd5wFmJhsFkW1HTpDW1O8MEzNSSMu9EXpMiuE1mZiE8pdm38bEIECVLKfi
	unDdzaRHZpinAPDzTH70emdRsFcO7nOjsilX4aaVWCXLYgw4QfR06xsm+J27rivjp9L4oUJMgVAmU
	+XT/99bA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kWxjY-0006xO-7p; Mon, 26 Oct 2020 08:20:04 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kWxjK-0006q0-PP
 for linux-nvme@lists.infradead.org; Mon, 26 Oct 2020 08:19:52 +0000
Received: by mail-pj1-x1030.google.com with SMTP id m3so2691469pjf.4
 for <linux-nvme@lists.infradead.org>; Mon, 26 Oct 2020 01:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google;
 h=from:subject:to:cc:message-id:date:user-agent:mime-version
 :content-transfer-encoding:content-language;
 bh=zLk7Ed613/Zom2AmnbWVVf1MWjumGguLj5QVlpWRcVY=;
 b=WIOCtT2o135FfdED1CjccfYr+DL8Ks0Ux59T9wXYifgd0xLonvqpmAwL+a0eMjWHZd
 ML2e9o0XUbaoJeN0+OauoNTgaJ6fUQJDAnGE7ROXEhLPQiEcHQhvYWievcD5XQ6pcYKs
 jKLEfTrB208WnCbQfRSSLDZLGinsMPIYO29+rHxHgTuuw7q81NlcbAZn3DmA5a0/X5YL
 GdzQZx6t8lyqHcRIXWKzXBUPHcg5Zx1P2tT2cGRpvzDpqFfwG0XNNTgZ6Br8NeD1umDW
 jqLODXCBWzwJ/rtkDn4DJKG6VKRpGfILqjYX+RWQRAXPV1XaNsxIJO2KgqpBuEfFRwhy
 eSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
 :mime-version:content-transfer-encoding:content-language;
 bh=zLk7Ed613/Zom2AmnbWVVf1MWjumGguLj5QVlpWRcVY=;
 b=QnjzzUwbDFH2oTPPCdoKV1dgTm4KwX4u0qO1AOVI9WVqo2/P3Vh4rysuhRFDnVRC5z
 dLXXGYeUyoZwnHAt3hjmWW5rVKHdQM5GGZ/zvuuee+pt/Rd4R15IlE2o8F0tgNxTmRmj
 GsCp/hjvwc0c679e6sYp7uUmAUxLlW8N4IZ9fUTpzur1Xa+E7Bj+zXyXuLqnhrt1zuNV
 2t/GQwnGBHOvRm0evtM0LQ7NAHgg6dndIBYR4tnHeooFwhSdXTEAE6OCHLaeI96M2/am
 B4lsmvZx8lyJ+49pPh7/VOq7jXTswGv/E9QQqDAcF1Wou1VRlyt+1gPYynnLAKIzqdrD
 YMRQ==
X-Gm-Message-State: AOAM531VC+q2sGPLX2m82c0jMEG/Iznsh5THqa1LfH0YC37PwEGtHb+C
 O9KZ7UYamnFEidlspM9kDU8Iaw==
X-Google-Smtp-Source: ABdhPJyYhmJDq8KxhWxpvHE23PhM16EPLFJFfR2fw687B0rEzM3UcaukhiwDfQeLPfPhIwpI+IKkkA==
X-Received: by 2002:a17:90a:4e0d:: with SMTP id
 n13mr8611529pjh.95.1603700387135; 
 Mon, 26 Oct 2020 01:19:47 -0700 (PDT)
Received: from ?IPv6:240e:82:3:8c99:cde8:9978:8c8f:325c?
 ([240e:82:3:8c99:cde8:9978:8c8f:325c])
 by smtp.gmail.com with ESMTPSA id l3sm11369064pju.28.2020.10.26.01.19.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 01:19:46 -0700 (PDT)
From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: Lock issue with 2a7cec53816 ("RDMA/cma: Fix locking for the
 RDMA_CM_CONNECT state")
To: jgg@ziepe.ca, leon@kernel.org
Message-ID: <3b1f7767-98e2-93e0-b718-16d1c5346140@cloud.ionos.com>
Date: Mon, 26 Oct 2020 09:19:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201026_041950_899796_1EE0D3E4 
X-CRM114-Status: GOOD (  10.93  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-rdma@vger.kernel.org, Jinpu Wang <jinpu.wang@cloud.ionos.com>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGkgSmFzb24gJiBMZW9uLAoKCltTb3JyeSB0byBzZW5kIGFnYWluIHNpbmNlIHRoZSBwcmV2aW91
cyBtYWlsIGRpZG4ndCBoaXQgdGhlIGxpc3RdCgpXaXRoIHRoZSBtZW50aW9uZWQgY29tbWl0LCBJ
IGdvdCB0aGUgYmVsb3cgY2FsbHRyYWNlcy4KClsgMTIwOS41NDQzNTldIElORk86IHRhc2sga3dv
cmtlci91ODozOjYxNSBibG9ja2VkIGZvciBtb3JlIHRoYW4gMTIwIApzZWNvbmRzLgpbIDEyMDku
NTQ1MTcwXcKgwqDCoMKgwqDCoCBUYWludGVkOiBHwqDCoMKgwqDCoMKgwqDCoMKgwqAgT8KgwqDC
oMKgwqAgNS45LjAtcmM4KyAjMzAKWyAxMjA5LjU0NTM0MV0gImVjaG8gMCA+IC9wcm9jL3N5cy9r
ZXJuZWwvaHVuZ190YXNrX3RpbWVvdXRfc2VjcyIgCmRpc2FibGVzIHRoaXMgbWVzc2FnZS4KWyAx
MjA5LjU0NTgxNF0gdGFzazprd29ya2VyL3U4OjPCoMKgwqAgc3RhdGU6RCBzdGFjazrCoMKgwqAg
MCBwaWQ6wqAgNjE1IApwcGlkOsKgwqDCoMKgIDIgZmxhZ3M6MHgwMDAwNDAwMApbIDEyMDkuNTQ3
NjAxXSBXb3JrcXVldWU6IHJkbWFfY20gY21hX3dvcmtfaGFuZGxlciBbcmRtYV9jbV0KWyAxMjA5
LjU0ODY0NV0gQ2FsbCBUcmFjZToKWyAxMjA5LjU1MjEyMF3CoCBfX3NjaGVkdWxlKzB4MzYzLzB4
N2IwClsgMTIwOS41NTI5MDNdwqAgc2NoZWR1bGUrMHg0NC8weGIwClsgMTIwOS41NTMwOTNdwqAg
c2NoZWR1bGVfcHJlZW1wdF9kaXNhYmxlZCsweGUvMHgxMApbIDEyMDkuNTUzMjUzXcKgIF9fbXV0
ZXhfbG9jay5pc3JhLjEwKzB4MjZkLzB4NGUwClsgMTIwOS41NTM0MjFdwqAgX19tdXRleF9sb2Nr
X3Nsb3dwYXRoKzB4MTMvMHgyMApbIDEyMDkuNTUzNTk2XcKgID8gX19tdXRleF9sb2NrX3Nsb3dw
YXRoKzB4MTMvMHgyMApbIDEyMDkuNTUzNzUxXcKgIG11dGV4X2xvY2srMHgyZi8weDQwClsgMTIw
OS41NTQwNDVdwqAgcmRtYV9jb25uZWN0KzB4NTIvMHg3NzAgW3JkbWFfY21dClsgMTIwOS41NTQy
MTVdwqAgPyB2cHJpbnRrX2RlZmF1bHQrMHgxZi8weDMwClsgMTIwOS41NTQzNTldwqAgPyB2cHJp
bnRrX2Z1bmMrMHg2Mi8weDEwMApbIDEyMDkuNTU0NTMyXcKgID8gY21hX2NtX2V2ZW50X2hhbmRs
ZXIrMHgyYi8weGUwIFtyZG1hX2NtXQpbIDEyMDkuNTU0Njg4XcKgID8gcHJpbnRrKzB4NTIvMHg2
ZQpbIDEyMDkuNTU0ODUyXcKgIHJ0cnNfY2x0X3JkbWFfY21faGFuZGxlcisweDM5My8weDhiMCBb
cnRyc19jbGllbnRdClsgMTIwOS41NTUwNTZdwqAgY21hX2NtX2V2ZW50X2hhbmRsZXIrMHgyYi8w
eGUwIFtyZG1hX2NtXQpbIDEyMDkuNTYxODIzXcKgID8gY21hX2NvbXBfZXhjaCsweDRlLzB4NjAg
W3JkbWFfY21dClsgMTIwOS41NjE4ODNdwqAgPyBjbWFfY21fZXZlbnRfaGFuZGxlcisweDJiLzB4
ZTAgW3JkbWFfY21dClsgMTIwOS41NjE5NDBdwqAgY21hX3dvcmtfaGFuZGxlcisweDg5LzB4YzAg
W3JkbWFfY21dClsgMTIwOS41NjE5ODhdwqAgcHJvY2Vzc19vbmVfd29yaysweDIwYy8weDQwMApb
Li4uXQpbIDEyMDkuNTYyMzIzXSBJTkZPOiB0YXNrIGJhc2g6NjMwIGJsb2NrZWQgZm9yIG1vcmUg
dGhhbiAxMjAgc2Vjb25kcy4KWyAxMjA5LjU2MjM2OF3CoMKgwqDCoMKgwqAgVGFpbnRlZDogR8Kg
wqDCoMKgwqDCoMKgwqDCoMKgIE/CoMKgwqDCoMKgIDUuOS4wLXJjOCsgIzMwClsgMTIwOS41NjI0
MDRdICJlY2hvIDAgPiAvcHJvYy9zeXMva2VybmVsL2h1bmdfdGFza190aW1lb3V0X3NlY3MiIApk
aXNhYmxlcyB0aGlzIG1lc3NhZ2UuClsgMTIwOS41NjI0NTZdIHRhc2s6YmFzaMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgc3RhdGU6RCBzdGFjazrCoMKgwqAgMCBwaWQ6wqAgNjMwIApwcGlkOsKgwqAg
NjE4IGZsYWdzOjB4MDAwMDQwMDAKWyAxMjA5LjU2MjUxNV0gQ2FsbCBUcmFjZToKWyAxMjA5LjU2
MjU1OV3CoCBfX3NjaGVkdWxlKzB4MzYzLzB4N2IwClsgMTIwOS41NjI2MDNdwqAgc2NoZWR1bGUr
MHg0NC8weGIwClsgMTIwOS41NjI2NDJdwqAgc2NoZWR1bGVfcHJlZW1wdF9kaXNhYmxlZCsweGUv
MHgxMApbIDEyMDkuNTYyNjg1XcKgIF9fbXV0ZXhfbG9jay5pc3JhLjEwKzB4MjZkLzB4NGUwClsg
MTIwOS41NjI3MjddwqAgPyB2cHJpbnRrX2Z1bmMrMHg2Mi8weDEwMApbIDEyMDkuNTYyNzY1XcKg
ID8gdnByaW50a19kZWZhdWx0KzB4MWYvMHgzMApbIDEyMDkuNTYyODA2XcKgIF9fbXV0ZXhfbG9j
a19zbG93cGF0aCsweDEzLzB4MjAKWyAxMjA5LjU2Mjg0N13CoCA/IF9fbXV0ZXhfbG9ja19zbG93
cGF0aCsweDEzLzB4MjAKWyAxMjA5LjU2Mjg4N13CoCBtdXRleF9sb2NrKzB4MmYvMHg0MApbIDEy
MDkuNTYyOTM2XcKgIHJkbWFfZGVzdHJveV9pZCsweDMxLzB4NjAgW3JkbWFfY21dClsgMTIwOS41
NjI5ODNdwqAgZGVzdHJveV9jbS5pc3JhLjI0KzB4MmQvMHg1MCBbcnRyc19jbGllbnRdClsgMTIw
OS41NjM1ODZdwqAgaW5pdF9zZXNzKzB4MjNiLzB4YWMwIFtydHJzX2NsaWVudF0KWyAxMjA5LjU2
MzY5MV3CoCA/IHdhaXRfd29rZW4rMHg4MC8weDgwClsgMTIwOS41NjM3NDJdwqAgcnRyc19jbHRf
b3BlbisweDI3Zi8weDU0MCBbcnRyc19jbGllbnRdClsgMTIwOS41NjM3OTFdwqAgPyByZW1hcF9k
ZXZzKzB4MTUwLzB4MTUwIFtybmJkX2NsaWVudF0KWyAxMjA5LjU2Mzg2N13CoCBmaW5kX2FuZF9n
ZXRfb3JfY3JlYXRlX3Nlc3MrMHg0YTEvMHg1ZTAgW3JuYmRfY2xpZW50XQpbIDEyMDkuNTYzOTIx
XcKgID8gcmVtYXBfZGV2cysweDE1MC8weDE1MCBbcm5iZF9jbGllbnRdClsgMTIwOS41NjM5NjZd
wqAgPyBhdG9taWNfbm90aWZpZXJfY2FsbF9jaGFpbisweDFhLzB4MjAKWyAxMjA5LjU2NDAxMV3C
oCA/IHZ0X2NvbnNvbGVfcHJpbnQrMHgyMDMvMHgzZDAKWyAxMjA5LjU2NDA1MV3CoCA/IHVwKzB4
MzIvMHg1MApbIDEyMDkuNTY0MDkzXcKgID8gX19pcnFfd29ya19xdWV1ZV9sb2NhbCsweDRmLzB4
NjAKWyAxMjA5LjU2NDEzMl3CoCA/IGlycV93b3JrX3F1ZXVlKzB4MWEvMHgzMApbIDEyMDkuNTY0
MTY5XcKgID8gd2FrZV91cF9rbG9nZC5wYXJ0LjI4KzB4MzQvMHg0MApbIDEyMDkuNTY0MjA4XcKg
ID8gdnByaW50a19lbWl0KzB4MTI2LzB4MmIwClsgMTIwOS41NjQyNDldwqAgPyB2cHJpbnRrX2Rl
ZmF1bHQrMHgxZi8weDMwClsgMTIwOS41NjQyOTJdwqAgcm5iZF9jbHRfbWFwX2RldmljZSsweDc0
LzB4N2IwIFtybmJkX2NsaWVudF0KWyAxMjA5LjU2NDM0MV3CoCBybmJkX2NsdF9tYXBfZGV2aWNl
X3N0b3JlKzB4MzllLzB4NmMwIFtybmJkX2NsaWVudF0KCiBGcm9tIG15IHVuZGVyc3RhbmRpbmcs
IGl0IGlzIGNhdXNlZCBieSB0aGUgcmRtYV9jb25uZWN0IG5lZWQgdG8gaG9sZCAKdGhlIGhhbmRs
ZXJfbXV0ZXgKYWdhaW4gaW4gdGhlIHBhdGguCgpjbWFfaWJfaGFuZGxlciAtPiBtdXRleF9sb2Nr
KCZpZF9wcml2LT5oYW5kbGVyX211dGV4KQotPiBjbWFfY21fZXZlbnRfaGFuZGxlcgogwqDCoMKg
IMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCAtPiBpZF9wcml2LT5pZC5ldmVudF9oYW5kbGVy
ID0gcnRyc19jbHRfcmRtYV9jbV9oYW5kbGVyCi0+IHJkbWFfY29ubmVjdAotPiBtdXRleF9sb2Nr
KCZpZF9wcml2LT5oYW5kbGVyX211dGV4KQoKCkFuZCBzZWVtcyBudm1lIHJkbWEgY291bGQgaGF2
ZSB0aGUgc2FtZSBpc3N1ZSBzaW5jZSByZG1hX2Nvbm5lY3QgaXMgCmNhbGxlZCBieQpudm1lX3Jk
bWFfY21faGFuZGxlciAtPiBudm1lX3JkbWFfcm91dGVfcmVzb2x2ZWQuCgpUaGFua3MsCkd1b3Fp
bmcKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4
LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
