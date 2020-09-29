Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8133C4743D
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 20:48:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31A672072E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 20:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YBiZUJQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A672072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nESvYExWj8dwmtOhbnZoQ9onx+XkEcTRVVCzhnSdY5Y=; b=YBiZUJQlC620RhvJ4e4nX9Sr0
	1Ir1PqME+onIRaP0sT45IaDCFg95BfTrzwY6ga4/ni6rFAt2g9ctiQBGOOyFYLloolcik/IAsyvUU
	0rYFzl88uUVuqiyXFU/+NBM6GNYAwzTNCQ9+lOfY+SnHtyLyb7AUKzrxn7Hc2pTCO//oPWFdw+k2u
	fbGmCWXem+kd9UI2wf3CpT/WDdpwGqZlpaFcfu+EPkShkUzeNyBMcp4gOBTxwErdGJXhuREU+xao8
	vy9hfAL71++dcc4ZZ2ERdx0P4XubHJJ1QVVjb4WuXgnYHi+pAMKEHCQZXyLwzbPHoEX2WH3+zHo6W
	C59Bi0q9w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNMXT-0004sB-Ae; Tue, 29 Sep 2020 20:47:55 +0000
Received: from mail-pg1-f196.google.com ([209.85.215.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNMXQ-0004ql-OV
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 20:47:53 +0000
Received: by mail-pg1-f196.google.com with SMTP id o25so4899061pgm.0
 for <linux-nvme@lists.infradead.org>; Tue, 29 Sep 2020 13:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CuuIeFXA1aecH2lJ6pTFHy/2hIqvEcx2qaNqBZuQ4xI=;
 b=B2XJhtnUdlkAoIoJgf++uaBV6xVD2+HGwenk062KCf51VHlEcwLVJv+HTcFB8zsMbP
 pZNp4QKx+sYU64edNiHbPufoNZKqzv5mJeLthkY1fgw1M7tZB0JBDhrX2qhI2TC3eICD
 FB2tMO/j8naQb+O4h1Rprk/bGF+DTQgBUqXoux2dDUCyssWr3VdQUWZjIFM8wX8yfo6o
 ax03D9wuFmkN4ZAE5VhQhN4hM/oPRIEhNwHB3Hk3sT+htUggtpdI1PRj10yUnNoCQF7B
 cxAFCHs3h0b6iiZe/D+bbNlGl3czljR922bj5YkoV/mIs4QnE3IvpG1S1cvsJ+hfzmIp
 Rv8A==
X-Gm-Message-State: AOAM5331SBZHA+fR0FeP9yCu3qyY8clHmsudQHp1L3MV4bcnj2vfRPKF
 CV6PItQAKj8Pvd/aHuMqUHuLvxNNWWA=
X-Google-Smtp-Source: ABdhPJzJalpgZfGYnxOOyXe0t8WSxRs0vw6agrFFsuh21S5AW4xQYkZGJyD4955O2mvZZui53hNpJw==
X-Received: by 2002:a17:902:bf06:b029:d2:8abd:c8f3 with SMTP id
 bi6-20020a170902bf06b02900d28abdc8f3mr6512286plb.13.1601412471437; 
 Tue, 29 Sep 2020 13:47:51 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8ff9:9348:1454:22ce?
 ([2601:647:4802:9070:8ff9:9348:1454:22ce])
 by smtp.gmail.com with ESMTPSA id x3sm6607998pfq.49.2020.09.29.13.47.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 13:47:50 -0700 (PDT)
Subject: Re: kernel panic in nvmet_tcp when receiving malformed admin command
To: "Anner, Ran" <Ran.Anner@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <BL0PR1901MB2067C827A2D826C0FBFE985591320@BL0PR1901MB2067.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <cee26269-c9c3-7ce7-8486-4ed16a632e44@grimberg.me>
Date: Tue, 29 Sep 2020 13:47:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BL0PR1901MB2067C827A2D826C0FBFE985591320@BL0PR1901MB2067.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_164752_825476_B6E656B5 
X-CRM114-Status: GOOD (  26.10  )
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
Cc: "Zinger, Eldad" <Eldad.Zinger@dell.com>, "Grupi,
 Elad" <Elad.Grupi@dell.com>, "Engel, Amit" <Amit.Engel@Dell.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4gSGVsbG8gYWxsLgoKSGV5IFJhbiwgdGhhbmtzIGZvciByZXBvcnRpbmcKCj4gCj4gV2UgYXJl
IGludmVzdGlnYXRpbmcga2VybmVsIHBhbmljIHdoZW4gYSBtYWxmb3JtZWQgYWRtaW4gY29tbWFu
ZCB3aXRoIGlubGluZSB3cml0ZSBkYXRhIGlzIHNlbnQgZnJvbSBob3N0IHRvIHRhcmdldCB1c2lu
ZyBudm1lb2YgdGNwLgo+IEZvbGxvd2luZyBhIGNvZGUgcmV2aWV3IG9mIG52bWV0X3RjcCBmcm9t
IGxhdGVzdCBrZXJuZWwgYW5kIGFkZGluZyBkZWJ1ZyBsb2dzIGFsb25nIHRoZSB3YXkgSSBjYW1l
IHVwIHdpdGggdGhlIGZvbGxvd2luZyBmbG93Ogo+IAo+IG52bWV0X3RjcF90cnlfcmVjdl9wZHUg
c2VuZHMgYW4gSU8gd2l0aCBpbmxpbmUgZGF0YSB0byBudm1ldF9yZXFfaW5pdC4KPiBudm1ldF9y
ZXFfaW5pdCBzZW5kIHRvIHBhcnNlIHdoaWNoIGZhaWxzIChleC4gaG9zdCBzZW5kcyBtYWxmb3Jt
ZWQgY29tbWFuZCkuCj4gbnZtZXRfcmVxX2luaXQgY2FsbHMgX19udm1ldF9yZXFfY29tcGxldGUs
IGFuZCBpbiB0dXJuIGNhbGxzIHF1ZXVlX3Jlc3BvbnNlLgo+IG52bWV0X3RjcF9xdWV1ZV9yZXNw
b25zZSBhZGQgdGhlIGNvbW1hbmQgdG8gcXVldWUgcmVzcG9uc2UgbGlzdC4KPiBudm1ldF9yZXFf
aW5pdCByZXR1cm4gZXJyb3Igc3RhdHVzIGFuZCBudm1ldF90Y3BfaGFuZGxlX3JlcV9mYWlsdXJl
IGlzIGNhbGxlZC4KPiBudm1ldF90Y3BfaGFuZGxlX3JlcV9mYWlsdXJlIGNoZWNrcyBpZiB0aGUg
Y29tbWFuZCBoYXMgaW5saW5lIGRhdGEgYW5kIHdpbGwgYWxsb2NhdGUgcGFnZXMgYW5kIGlvdnMu
Cj4gbnZtZXRfdGNwX2hhbmRsZV9yZXFfZmFpbHVyZSByZXR1cm4gYW5kIG52bWV0X3RjcF9kb25l
X3JlY3ZfcGR1IHJldHVybnMgLUVBR0FJTi4KPiBudm1ldF90Y3BfdHJ5X3JlY3ZfcGR1IHJldHVy
bnMgLUVBR0FJTiBhbmQgaW4gdGhhdCBjYXNlIG52bWV0X3RjcF90cnlfcmVjdl9vbmUgcmV0dXJu
cyAwLgo+IEluIGNhc2UgbnZtZXRfdGNwX3RyeV9yZWN2X29uZSByZXR1cm5zIDAsIG52bWV0X3Rj
cF90cnlfcmVjdiBicmVha3MgZnJvbSBsb29wIGFuZCByZXR1cm4gemVybyBhcyB3ZWxsLgo+IElu
IG52bWV0X3RjcF9pb193b3JrIHdlIGNvbnRpbnVlIHRvIG52bWV0X3RjcF90cnlfc2VuZCBpbiBj
YXNlIHRoZSByZXR1cm4gdmFsdWUgaXMgemVyby4KPiBudm1ldF90Y3BfdHJ5X3NlbmRfb25lIHdp
bGwgY2FsbCBudm1ldF90Y3BfZmV0Y2hfY21kIHdoaWNoIGNhbiBhc3NpZ24gc25kX2NtZCBhcyB0
aGUgZmFpbGVkIGNvbW1hbmQuCj4gbnZtZXRfdGNwX25lZWRfZGF0YV9vdXQgYW5kIG52bWV0X3Rj
cF9uZWVkX2RhdGFfaW4gcmV0dXJuIGZhbHNlIHNvIHdlIGNhbGwgbnZtZXRfc2V0dXBfcmVzcG9u
c2VfcGR1Lgo+IG52bWV0X3NldHVwX3Jlc3BvbnNlX3BkdSBzZXQgdGhlIGNtZCBzdGF0ZSB0byBO
Vk1FVF9UQ1BfU0VORF9SRVNQT05TRSBhbmQgcmV0dXJuLgo+IEJhY2sgdG8gbnZtZXRfdGNwX3Ry
eV9zZW5kX29uZSwgY21kLT5zdGF0ZSA9PSBOVk1FVF9UQ1BfU0VORF9SRVNQT05TRSBzbyBudm1l
dF90cnlfc2VuZF9yZXNwb25zZSBpcyBjYWxsZWQuCj4gQWZ0ZXIga2VybmVsX3NlbmRwYWdlIHdl
IGZyZWUgdGhlIGNtZCBpb3YgYW5kIHNnbC4KPiBFdmVudHVhbGx5IG52bWV0X3RjcF90cnlfcmVj
dl9kYXRhIHdpbGwgYmUgY2FsbGVkIGJ1dCB0aGUgaW92IHdhcyBhbHJlYWR5IHJlbW92ZWQgYW5k
IGdlbmVyYWwgcHJvdGVjdGlvbiBmYXVsdCBpcyB0cmlnZ2VyZWQuCj4gCj4gSSB3YXMgd29uZGVy
aW5nIGlmIHRoaXMgaXMgYSBrbm93cyBpc3N1ZSBvciBpZiBzb21lb25lIGVsc2UgZW5jb3VudGVy
ZWQgdGhpcyBiZWZvcmUuCj4gSXQgc2VlbXMgdG8gbWUgYSBmaXggZm9yIHRoaXMgd291bGQgYmUg
dG8gbm90IHF1ZXVlIHRoZSByZXNwb25zZSBiZWZvcmUgcmVjZWl2aW5nIGFsbCBkYXRhIGluIHRo
aXMgc3BlY2lmaWMgZmxvdy4KPiBBZGRlZCBiZWxvdyBzbmlwcGV0IG9mIHRoZSBrZXJuZWwgdHJh
Y2UuCj4gQWx0ZXJuYXRpdmVseSBpZiB3ZSBkbyBub3Qgd2FudCB0byBkZWxheSB0aGUgcmVzcG9u
c2UsIGZyZWUgdGhlIGlvdiBhZnRlciBib3RoIGZsb3dzIGFyZSBkb25lLCBtYXliZSB1c2luZyBy
ZWZlcmVuY2UgY291bnRpbmcgdG8gZG8gc28uCj4gSSB3aWxsIGJlIGdsYWQgdG8gaGVhciB5b3Vy
IHRob3VnaHRzIGFuZCBjb21tZW50cy4KClRoaXMgaXMgaW5kZWVkIGEgYnVnLiBXZSBkZWZpbml0
ZWx5IG5lZWQgYSByZWZjb3VudCBoZXJlLiBJIHJlY2FsbCB0aGF0CnRoaXMgdXNlZCB0byB3b3Jr
IHRob3VnaC4uCgpXaGF0IHdlIHByb2JhYmx5IG5lZWQgdG8gZG8gaXMgdG8gZGVmZXIgdGhlIHJl
c3BvbnNlIHNlbmQgdW50aWwgd2UKY29tcGxldGUgZmV0Y2hpbmcgdGhlIGVudGlyZSBpbmNvbWlu
ZyBkYXRhIGFuZCB0aGVuIHNhZmVseSBmcmVlIHRoZQpjb21tYW5kLgoKSSdsbCB0cnkgdG8gc3Bp
biBhIHBhdGNoIHNvb24uCgo+IAo+IFRoYW5rIHlvdSwKPiBSYW4uCj4gCj4gWzEzNTM4LjA0NjM2
NF0gZ2VuZXJhbCBwcm90ZWN0aW9uIGZhdWx0OiAwMDAwIFsjMV0gU01QIE5PUFRJCj4gWzEzNTM4
LjA1MTc2Ml0gQ1BVOiAxMCBQSUQ6IDYwMyBDb21tOiBrd29ya2VyLzEwOjFIIEtkdW1wOiBsb2Fk
ZWQgVGFpbnRlZDogR8KgwqDCoMKgwqDCoCDCoFfCoCBPRcKgwqDCoMKgIDQuMTkuMTM0LWNvcmVv
cy1yOTk5OS4xNjAwNzc0MDk1LTE2MTAgIzEKPiBbMTM1MzguMDYzNTc0XSBIYXJkd2FyZSBuYW1l
OiBFTUMgOTAwLTUzMi0wMDIvMTEwLTU1MS05MTBDLTAxLCBCSU9TIDE2LjM1IDA0LzA4LzIwMjAK
PiBbMTM1MzguMDcxMDQ5XSBXb3JrcXVldWU6IG52bWV0X3RjcF93cSBudm1ldF90Y3BfaW9fd29y
ayBbbnZtZXRfdGNwXQo+IFsxMzUzOC4wNzcxNDJdIFJJUDogMDAxMDptZW1jcHlfZXJtcysweDYv
MHgxMAo+IFsxMzUzOC4wODEyMzddIENvZGU6IDkwIDkwIDkwIDkwIGViIDFlIDBmIDFmIDAwIDQ4
IDg5IGY4IDQ4IDg5IGQxIDQ4IGMxIGU5IDAzIDgzIGUyIDA3IGYzIDQ4IGE1IDg5IGQxIGYzIGE0
IGMzIDY2IDBmIDFmIDQ0IDAwIDAwIDQ4IDg5IGY4IDQ4IDg5IGQxIDxmMz4gYTQgYzMgMGYgMWYg
ODAgMDAgMDAgMDAgMDAgNDggODkgZjggNDggODMgZmEgMjAgNzIgN2U+Cj4gWzEzNTM4LjA5OTk4
MV0gUlNQOiAwMDE4OmZmZmZjOTAwMDc4MWJjNzAgRUZMQUdTOiAwMDAxMDIwMgo+IFsxMzUzOC4x
MDUxOTldIFJBWDogMzFkMjQ3Y2ExOTU4ZjYzZiBSQlg6IDAwMDAwMDAwMDAwMDA1MTAgUkNYOiAw
MDAwMDAwMDAwMDAwNTEwCj4gWzEzNTM4LjExMjMyMl0gUkRYOiAwMDAwMDAwMDAwMDAwNTEwIFJT
STogZmZmZjg4ODY0NDVmNjBjYSBSREk6IDMxZDI0N2NhMTk1OGY2M2YKPiBbMTM1MzguMTE5NDQ2
XSBSQlA6IGZmZmY4ODgzMDhjNDE5MjAgUjA4OiAwMDAwMDAwMDAwMDAwNTEwIFIwOTogZmZmZjg4
ODUwYjk2ZTJiYwo+IFsxMzUzOC4xMjY1NzBdIFIxMDogZmZmZjg4ODUwYjk2ZGU0OCBSMTE6IGZm
ZmY4ODg2NDQ1ZjYwY2EgUjEyOiAwMDAwMDAwMDAwMDAwNTEwCj4gWzEzNTM4LjEzMzY5M10gUjEz
OiAwMDAwMDAwMDAwMDAwNTEwIFIxNDogZmZmZjg4ODY0NDVmNjVkYSBSMTU6IGZmZmY4ODg2OTAy
ZGRkOTAKPiBbMTM1MzguMTQwODE5XSBGUzrCoCAwMDAwMDAwMDAwMDAwMDAwKDAwMDApIEdTOmZm
ZmY4ODk3ZGZlODAwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMAo+IFsxMzUzOC4xNDg5
MDZdIENTOsKgIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzCj4g
WzEzNTM4LjE1NDY1MF0gQ1IyOiAwMDAwN2Y1NDcxNjliZWIwIENSMzogMDAwMDAwMDAwMjIwYTAw
MSBDUjQ6IDAwMDAwMDAwMDA3NjA2ZTAKPiBbMTM1MzguMTYxNzcyXSBEUjA6IDAwMDAwMDAwMDAw
MDAwMDAgRFIxOiAwMDAwMDAwMDAwMDAwMDAwIERSMjogMDAwMDAwMDAwMDAwMDAwMAo+IFsxMzUz
OC4xNjg4OTZdIERSMzogMDAwMDAwMDAwMDAwMDAwMCBEUjY6IDAwMDAwMDAwZmZmZTBmZjAgRFI3
OiAwMDAwMDAwMDAwMDAwNDAwCj4gWzEzNTM4LjE3NjAyMl0gUEtSVTogNTU1NTU1NTQKPiBbMTM1
MzguMTc4NzI2XSBDYWxsIFRyYWNlOgo+IFsxMzUzOC4xODExNzFdwqAgX2NvcHlfdG9faXRlcisw
eDMwZS8weDNiMAo+IFsxMzUzOC4xODQ5MjVdwqAgPyB3YWtlX3VwX2tsb2dkLnBhcnQuMjQrMHgz
MC8weDQwCj4gWzEzNTM4LjE4OTM3Ml3CoCBza2JfY29weV9kYXRhZ3JhbV9pdGVyKzB4N2IvMHgy
NjAKPiBbMTM1MzguMTkzODE1XcKgIHRjcF9yZWN2bXNnKzB4MjM4LzB4YzgwCj4gWzEzNTM4LjE5
NzM5NV3CoCA/IG52bWV0X3RjcF9pb193b3JrKzB4NDAwLzB4YTgwIFtudm1ldF90Y3BdCj4gWzEz
NTM4LjIwMjcwN13CoCA/IHJlbGVhc2Vfc29jaysweDQzLzB4OTAKPiBbMTM1MzguMjA2MzczXcKg
ID8gdGNwX3NlbmRwYWdlKzB4NDEvMHg1MAo+IFsxMzUzOC4yMTAwMzhdwqAgaW5ldF9yZWN2bXNn
KzB4NWIvMHhkMAo+IFsxMzUzOC4yMTM1MjJdwqAgbnZtZXRfdGNwX2lvX3dvcmsrMHhlYS8weGE4
MCBbbnZtZXRfdGNwXQo+IFsxMzUzOC4yMTg1NzBdwqAgcHJvY2Vzc19vbmVfd29yaysweDIwNi8w
eDQwMAo+IFsxMzUzOC4yMjI1ODBdwqAgd29ya2VyX3RocmVhZCsweDJkLzB4M2UwCj4gWzEzNTM4
LjIyNjI0M13CoCA/IHByb2Nlc3Nfb25lX3dvcmsrMHg0MDAvMHg0MDAKPiBbMTM1MzguMjMwNDIx
XcKgIGt0aHJlYWQrMHgxMTIvMHgxMzAKPiBbMTM1MzguMjMzNjQ3XcKgID8ga3RocmVhZF9iaW5k
KzB4MjAvMHgyMAo+IFsxMzUzOC4yMzczMTJdwqAgcmV0X2Zyb21fZm9yaysweDFmLzB4NDAKPiAK
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IExpbnV4
LW52bWUgbWFpbGluZyBsaXN0Cj4gTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCj4gaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCj4gCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1l
IG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
