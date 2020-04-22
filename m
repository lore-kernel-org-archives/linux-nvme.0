Return-Path: <SRS0=9Zwh=6G=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B5CC55185
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2020 22:24:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F1042077D
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2020 22:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TRgmYGtS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1td5G9T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F1042077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HMQUKE6PY/DzrWsn07pMtLLOYcb3+GIboT5mczwRs7I=; b=TRgmYGtS8U8CYMIsZ5Ib/llrV
	+Xds9tdHW+OjGYgVcNfmjeEeV/2+mDkEeUUkwPR6IM1wds32oWpka9AWt32kvzHhTXB9GrywtwM4z
	YeWvsRAY2ctH8xZnji5ObaJZvgwx1kdu5ffGKutLq2aQSLPT71p76mGNP5PgiCVSxkxmHahCmdgkR
	P4cxlHILQm4AMwSk+rI8YnkF9NqGScImGAvgitjsQuogUmhmDkK2THvZbZ10Gq3NeLcuJn6/xOnnt
	/MM22DpcA2N4ZLsKsDBI38rDROW7mkziYHcKQR6BW+jjBw8nWlaE3rl8QXGQUL0VTCIaYIO7ZEptw
	UqTfEweJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jRNnF-0003gE-Eb; Wed, 22 Apr 2020 22:24:33 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jRNnC-0003es-Sa
 for linux-nvme@lists.infradead.org; Wed, 22 Apr 2020 22:24:32 +0000
Received: by mail-pf1-x443.google.com with SMTP id x77so1881818pfc.0
 for <linux-nvme@lists.infradead.org>; Wed, 22 Apr 2020 15:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sHrHLvTJ9CWgVWiVQyE99M0mE7zEJFulQmFuGP+4648=;
 b=e1td5G9TiSyZLvBrUiWmUDEDSml0y1z7wstTGBqLG9UneZh/M3sis8rL0+vqcS1oqh
 pz23uT1tVgyz/NGLRUT/iaMxO5bfjxJ1v+HwrzMtFgwIEOgyLNDPTINEBAUYSst3yGAe
 ebkvgCzFfVwVDF9uu2CgYR5gVRnoc/TZijYxJ8FeP7rdYPSRNzfqpiyY+Jv1CQoAJlq4
 Fwm5xFpZQBhvVmG4Z4AawCWlLIUCzDZ7wn/VgtEqZfZnfRxH1SqUuJSkklZZMDg4eY1b
 kqZDlmJL4kDcwO7hjqDBbRStHdu7xL1yIvJBydcmyL8fDxYwCqT/XjE95hez7XNIH+uX
 DcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sHrHLvTJ9CWgVWiVQyE99M0mE7zEJFulQmFuGP+4648=;
 b=SqfKRd0BhKnIv/ejZzXyvx1Zzj284GAEBhGHL/gSLtsJB/L7Oa2DQkjT5D9ER3tBLm
 tiEnA4oSGsmQJcwST3+iwGrLJ6A9Obaag/cr8JNJ4g9HfmycKQky++WT1BLa9SsLbJOH
 vV6BhoZDW88OmSXipgxvQkqbWnCKbFUkrOUWRn6yYMpBxPcpVRJPs/d5AXg5FQx42JQ/
 n0w21PKKyx+s9bBf+XU0GjjK67qSjPiO/1+w/H+OoTq9v3LdBZJ4xBegpfFSJENUiPUt
 QtiquPshpjyOFQnkY2HZQbGaKNNtefrfd0Z+klBeOVbQRV5NwqxMdLOOUd9IjSPcp8ej
 V8pA==
X-Gm-Message-State: AGi0PuYyZC5D85yV4u0hkW1F3gfnPu2nSDIiFl3V+9DyOZ5+s4FgyMDW
 kM9r7ksttTRsW7fZXHK8IoU=
X-Google-Smtp-Source: APiQypLhEvLtIfLOWM8+pZBs4U9szwgf8fl8NBMZCmDSbKP6vCWtNSheRM6HYUUBiCAXGIH7jeXrjA==
X-Received: by 2002:a63:213:: with SMTP id 19mr1172051pgc.202.1587594269973;
 Wed, 22 Apr 2020 15:24:29 -0700 (PDT)
Received: from [10.230.185.141] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id h12sm508042pfq.176.2020.04.22.15.24.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2020 15:24:28 -0700 (PDT)
Subject: Re: [PATCH 05/17] nvme-fabrics: Allow user enabling metadata/T10-PI
 support
To: Max Gurtovoy <maxg@mellanox.com>, Christoph Hellwig <hch@lst.de>
References: <20200327171545.98970-1-maxg@mellanox.com>
 <20200327171545.98970-7-maxg@mellanox.com> <20200421151747.GA10837@lst.de>
 <54c05d2d-2ea5-bf58-455f-91efa085aa9b@mellanox.com>
From: James Smart <jsmart2021@gmail.com>
Message-ID: <70f40e49-d9d7-68fe-6a63-a73fabcd146d@gmail.com>
Date: Wed, 22 Apr 2020 15:24:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <54c05d2d-2ea5-bf58-455f-91efa085aa9b@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200422_152430_920253_1F5ABCC9 
X-CRM114-Status: GOOD (  15.38  )
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
Cc: axboe@kernel.dk, sagi@grimberg.me, martin.petersen@oracle.com,
 shlomin@mellanox.com, linux-rdma@vger.kernel.org, israelr@mellanox.com,
 vladimirk@mellanox.com, linux-nvme@lists.infradead.org, idanb@mellanox.com,
 jgg@mellanox.com, oren@mellanox.com, kbusch@kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNC8yMi8yMDIwIDM6MDcgUE0sIE1heCBHdXJ0b3ZveSB3cm90ZToKPiAKPiBPbiA0LzIxLzIw
MjAgNjoxNyBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4+IE9uIEZyaSwgTWFyIDI3LCAy
MDIwIGF0IDA4OjE1OjMzUE0gKzAzMDAsIE1heCBHdXJ0b3ZveSB3cm90ZToKPj4+IEZyb206IElz
cmFlbCBSdWtzaGluIDxpc3JhZWxyQG1lbGxhbm94LmNvbT4KPj4+Cj4+PiBQcmVwYXJhdGlvbiBm
b3IgYWRkaW5nIG1ldGFkYXRhIChUMTAtUEkpIG92ZXIgZmFicmljIHN1cHBvcnQuIFRoaXMgd2ls
bAo+Pj4gYWxsb3cgZW5kLXRvLWVuZCBwcm90ZWN0aW9uIGluZm9ybWF0aW9uIHBhc3N0aHJvdWdo
IGFuZCB2YWxpZGF0aW9uIGZvcgo+Pj4gTlZNZSBvdmVyIEZhYnJpYy4KPj4gU28gYWN0dWFsbHkg
LSBmb3IgUENJZSB3ZSBlbmFibGUgUEkgYnkgZGVmYXVsdC7CoCBOb3Qgc3VyZSB3aHkgUkRNQSB3
b3VsZAo+PiBiZSBhbnkgZGlmZmVyZW50P8KgIElmIHdlIGhhdmUgYSBzd2l0Y2ggdG8gdHVybiBp
dCBvZmYgd2UgcHJvYmFibHkgd2FudAo+PiBpdCB3b3JrIHNpbWlsYXIgKGNhbid0IGJlIHRoZSBz
YW1lIGR1ZSB0byB0aGUgbGFjayBvZiBjb25uZWN0KSBmb3IgUENJZQo+PiBhcyB3ZWxsLgo+IAo+
IEZvciBQQ0kgd2UgdXNlIGEgZm9ybWF0IGNvbW1hbmQgdG8gY29uZmlndXJlIG1ldGFkYXRhLiBJ
biBmYWJyaWNzIHdlIGNhbiAKPiBjaG9vc2UgZG9pbmcgaXQgaW4gdGhlIGNvbm5lY3QgY29tbWFu
ZCBhbmQgd2UgY2FuIGFsc28gY2hvb3NlIHRvIGhhdmUgCj4gInByb3RlY3RlZCIgY29udHJvbGxl
cnMgYW5kICJub24tcHJvdGVjdGVkIiBjb250cm9sbGVycy4KPiAKPiBJIGRvbid0IHRoaW5rIGl0
J3MgYWxsIG9yIG5vdGhpbmcgY2FzZSwgYW5kIGNvbmZpZ3VyYXRpb24gdXNpbmcgbnZtZS1jbGkg
Cj4gKG9yIG90aGVyIHRvb2wpIHNlZW1zIHJlYXNvbmFibGUgYW5kIGZsZXhpYmxlLgoKSSB0aGlu
ayB5b3UgbmVlZCB0byBjaGFuZ2UgdGhpcyB0byAic29tZSBmYWJyaWNzIi4KCldpdGggRkMsIHdl
IGRvbid0IGRvIGFueXRoaW5nIGluIGNvbm5lY3QuIFRoZSB0cmFuc3BvcnQgcGFzc2VzIAphdHRy
aWJ1dGVzIG9uIHdoYXQgaXQgY2FuIGRvIGZvciBQSSBzdXBwb3J0LCBpbmNsdWRpbmc6IHBhc3Np
bmcgdGhyb3VnaCAKbWV0YWRhdGEgKG5vIGNoZWNrcyk7IGNoZWNraW5nIG9mIG1ldGFkYXRhIChu
b3JtYWwpOyBnZW5lcmF0aW9uL3N0cmlwIG9mIAptZXRhZGF0YSBvbiB0aGUgd2lyZSAobWVhbmlu
ZyBPUyBkb2VzIG5vdCBoYXZlIHRvIGhhdmUgYSBtZXRhZGF0YSAKYnVmZmVyKSwgYW5kIHNvIG9u
LiAgRW5hYmxlbWVudCBpcyBqdXN0IGxpa2UgcGNpIC0gZm9ybWF0IHRoZSBucywgdGhlbiAKbWF0
Y2ggdXAgdGhlIGF0dHJpYnV0ZSB3aXRoIHRoZSBiZWhhdmlvci4gVGhlcmUgaXMgbm8gc3VjaCB0
aGluZyBhcyAKcHJvdGVjdGVkIGFuZCBub24tcHJvdGVjdGVkIGNvbnRyb2xsZXJzLiAgVGhlcmUn
cyBlaXRoZXIgYSBucyB0aGF0IGhhcyAKbWV0YWRhdGEgb3Igbm90LiBJZiBtZXRhZGF0YSBhbmQg
dGhlIGF0dHJpYnV0ZXMgb2YgdGhlIHRyYW5zcG9ydCBjYW4ndCAKc3VwcG9ydCBpdCwgdGhlIG5z
IGlzIGluYWNjZXNzaWJsZS4KCkkgdW5kZXJzdGFuZCB3aHkgeW91IGFyZSBkZXNjcmliaW5nIGl0
IGFzIHlvdSBhcmUsIGJ1dCBJJ20gYSBiaXQgCmNvbmNlcm5lZCBhYm91dCB0aGUgY3JlYXRpb24g
b2YgdGhpbmdzIHRoYXQgYXJlbid0IGNvbXByZWhlbmRlZCBpbiB0aGUgCnN0YW5kYXJkcyBhdCBh
bGwgcmlnaHQgbm93IChwcm90ZWN0ZWQgdnMgbm9uLXByb3RlY3RlZCBjb250cm9sbGVycykuIApU
aGlzIGFmZmVjdHMgaG93IG11bHRpcGF0aCBjb25maWd1cmVzIGFzIHdlbGwuCgotLSBqYW1lcwoK
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1u
dm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
