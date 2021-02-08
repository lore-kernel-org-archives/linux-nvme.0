Return-Path: <SRS0=c0j7=HK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7222FC433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Feb 2021 18:42:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E5AC64E74
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Feb 2021 18:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E5AC64E74
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z0RSTtHhWvvsDJIDBrpLalq1trMUOsLMdDyvRbuys1w=; b=hQQuQHKUwLwvPGCOYd4IkAxUl
	TdUojT7h5NsIyePplnK3tncJACFyPQT3nXEjxUIf89lHGJgXVXqJN4cE1y/GbCiWhZmrXHJ6J/C63
	pdemqdIDS2UpKKc3RsPUi38w+upTn9Ir9XiFeVHp71D9eSZ30JaVE0hNekuxa2Lup6bv/3CqxpFhT
	VsfWD5mrhNv6/xPGiZ3od6Je2PdhHCvSShvMx5EYRFnJxbdDtv83xGwndMe08iikYi2vs1Db6qxWV
	zovzh+DHgh0L4W5sgMBk8AgsWqtjeiwY6h4bhy0OOZ/iHA7KIbDXTD5fixJsjz1eBYb87d+pV6AXx
	4btMxbXiQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9BUb-000835-RU; Mon, 08 Feb 2021 18:42:37 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9BUY-00081p-Kw
 for linux-nvme@lists.infradead.org; Mon, 08 Feb 2021 18:42:35 +0000
Received: by mail-wr1-f43.google.com with SMTP id g6so5445110wrs.11
 for <linux-nvme@lists.infradead.org>; Mon, 08 Feb 2021 10:42:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WZI679MKug/C6d5XEdGiTwN53NorH7qi3N9ZPYlHr9Q=;
 b=rQI9qszNV9dJitiO52OkZee6hBVFrcfE6tJNiN+DraNF46nnSSV+SCXjaV5Q2o8VtB
 2uxuET6+p4jQszvSWG7SprCW/x4Do25/SBkzgGEcmZ+vV6Ka5V8+KDBvcBzdl9NHNfgN
 Y9CdS+JTJsdB9I4JgtzfpSJ9TC+G8dL5/GmD4YGwp2c8TMbxvs21h8KeHJDmv8cA1Sal
 KA5Bfe+RvJmS08QRlpSM/pva6DCenjCKcY+uLmIQUrzMBlD8b6twFXda5NpHQfuA2LH6
 9NaiVbQplXQoWTDLJgLWj/JXuDgVZsESAOOphj/6DS7n/pbj3LY8bRwwxToSIiKxMccl
 lrlQ==
X-Gm-Message-State: AOAM531NDop9IRhtYWbDRDVErNA4ZOybfSlfjHvQ0NPveFGhgznXpLDT
 RebjHk0EE/vo8H809/bIcpU=
X-Google-Smtp-Source: ABdhPJy+0K0PHaSQALy1w2K+Q9cnATgNYdrv/M8TDx0MmmjSUBBYwLLXKRJCI1Y5EdVTRoQ6Z55O0g==
X-Received: by 2002:a05:6000:11c4:: with SMTP id
 i4mr7053597wrx.272.1612809753620; 
 Mon, 08 Feb 2021 10:42:33 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:2121:4cf7:e6f6:2dc5?
 ([2601:647:4802:9070:2121:4cf7:e6f6:2dc5])
 by smtp.gmail.com with ESMTPSA id t126sm158426wmf.3.2021.02.08.10.42.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Feb 2021 10:42:32 -0800 (PST)
Subject: Re: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
From: Sagi Grimberg <sagi@grimberg.me>
To: Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block <linux-block@vger.kernel.org>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
 <e1d08160-ca49-91e2-dafc-3ee80516842d@grimberg.me>
 <5848858e-239d-acb2-fa24-c371a3360557@redhat.com>
 <af1d7e9d-0170-82f6-30e1-01f045d73fc7@grimberg.me>
Message-ID: <6147d452-a12e-c76c-22f1-5d9e7cb6b01d@grimberg.me>
Date: Mon, 8 Feb 2021 10:42:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <af1d7e9d-0170-82f6-30e1-01f045d73fc7@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210208_134234_725973_E975A3E1 
X-CRM114-Status: GOOD (  19.54  )
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
Cc: axboe@kernel.dk, Rachel Sibley <rasibley@redhat.com>,
 Chaitanya.Kulkarni@wdc.com, CKI Project <cki-project@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+IEhpIFNhZ2kKPj4KPj4gT24gMi84LzIxIDU6NDYgUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6
Cj4+Pgo+Pj4+IEhlbGxvCj4+Pj4KPj4+PiBXZSBmb3VuZCB0aGlzIGtlcm5lbCBOVUxMIHBvaW50
ZXIgaXNzdWUgd2l0aCBsYXRlc3QgCj4+Pj4gbGludXgtYmxvY2svZm9yLW5leHQgYW5kIGl0J3Mg
MTAwJSByZXByb2R1Y2VkLCBsZXQgbWUga25vdyBpZiB5b3UgCj4+Pj4gbmVlZCBtb3JlIGluZm8v
dGVzdGluZywgdGhhbmtzCj4+Pj4KPj4+PiBLZXJuZWwgcmVwbzogCj4+Pj4gaHR0cHM6Ly9naXQu
a2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvYXhib2UvbGludXgtYmxvY2suZ2l0
Cj4+Pj4gQ29tbWl0OiAxMWY4YjZmZDBkYjkgLSBNZXJnZSBicmFuY2ggJ2Zvci01LjEyL2lvX3Vy
aW5nJyBpbnRvIGZvci1uZXh0Cj4+Pj4KPj4+PiBSZXByb2R1Y2VyOiBibGt0ZXN0cyBudm1lLXRj
cC8wMTIKPj4+Cj4+PiBUaGFua3MgZm9yIHJlcG9ydGluZyBNaW5nLCBJJ3ZlIHRyaWVkIHRvIHJl
cHJvZHVjZSB0aGlzIG9uIG15IFZNCj4+PiBidXQgZGlkIG5vdCBzdWNjZWVkLiBHaXZlbiB0aGF0
IHlvdSBoYXZlIGl0IDEwMCUgcmVwcm9kdWNpYmxlLAo+Pj4gY2FuIHlvdSB0cnkgdG8gcmV2ZXJ0
IGNvbW1pdDoKPj4+Cj4+PiAwZGM5ZWRhZjgwZWEgbnZtZS10Y3A6IHBhc3MgbXVsdGlwYWdlIGJ2
ZWMgdG8gcmVxdWVzdCBpb3ZfaXRlcgo+Pj4KPj4KPj4gUmV2ZXJ0IHRoaXMgY29tbWl0IGZpeGVk
IHRoZSBpc3N1ZSBhbmQgSSd2ZSBhdHRhY2hlZCB0aGUgY29uZmlnLiA6KQo+IAo+IEdvb2QgdG8g
a25vdywKPiAKPiBJIHNlZSBzb21lIGRpZmZlcmVuY2VzIHRoYXQgSSBzaG91bGQgcHJvYmFibHkg
Y2hhbmdlIHRvIGhpdCB0aGlzOgo+IC0tIAo+IEBAIC0yNTQsMTQgKzI1NiwxNSBAQCBDT05GSUdf
UEVSRl9FVkVOVFM9eQo+ICDCoCMgZW5kIG9mIEtlcm5lbCBQZXJmb3JtYW5jZSBFdmVudHMgQW5k
IENvdW50ZXJzCj4gCj4gIMKgQ09ORklHX1ZNX0VWRU5UX0NPVU5URVJTPXkKPiArQ09ORklHX1NM
VUJfREVCVUc9eQo+ICDCoCMgQ09ORklHX0NPTVBBVF9CUksgaXMgbm90IHNldAo+IC1DT05GSUdf
U0xBQj15Cj4gLSMgQ09ORklHX1NMVUIgaXMgbm90IHNldAo+IC0jIENPTkZJR19TTE9CIGlzIG5v
dCBzZXQKPiAtQ09ORklHX1NMQUJfTUVSR0VfREVGQVVMVD15Cj4gLSMgQ09ORklHX1NMQUJfRlJF
RUxJU1RfUkFORE9NIGlzIG5vdCBzZXQKPiArIyBDT05GSUdfU0xBQiBpcyBub3Qgc2V0Cj4gK0NP
TkZJR19TTFVCPXkKPiArIyBDT05GSUdfU0xBQl9NRVJHRV9ERUZBVUxUIGlzIG5vdCBzZXQKPiAr
Q09ORklHX1NMQUJfRlJFRUxJU1RfUkFORE9NPXkKPiAgwqAjIENPTkZJR19TTEFCX0ZSRUVMSVNU
X0hBUkRFTkVEIGlzIG5vdCBzZXQKPiAtIyBDT05GSUdfU0hVRkZMRV9QQUdFX0FMTE9DQVRPUiBp
cyBub3Qgc2V0Cj4gK0NPTkZJR19TSFVGRkxFX1BBR0VfQUxMT0NBVE9SPXkKPiArQ09ORklHX1NM
VUJfQ1BVX1BBUlRJQUw9eQo+ICDCoENPTkZJR19TWVNURU1fREFUQV9WRVJJRklDQVRJT049eQo+
ICDCoENPTkZJR19QUk9GSUxJTkc9eQo+ICDCoENPTkZJR19UUkFDRVBPSU5UUz15Cj4gQEAgLTI5
OSw3ICszMDIsOCBAQCBDT05GSUdfSEFWRV9JTlRFTF9UWFQ9eQo+ICDCoENPTkZJR19YODZfNjRf
U01QPXkKPiAgwqBDT05GSUdfQVJDSF9TVVBQT1JUU19VUFJPQkVTPXkKPiAgwqBDT05GSUdfRklY
X0VBUkxZQ09OX01FTT15Cj4gLUNPTkZJR19QR1RBQkxFX0xFVkVMUz00Cj4gK0NPTkZJR19EWU5B
TUlDX1BIWVNJQ0FMX01BU0s9eQo+ICtDT05GSUdfUEdUQUJMRV9MRVZFTFM9NQo+ICDCoENPTkZJ
R19DQ19IQVNfU0FORV9TVEFDS1BST1RFQ1RPUj15Cj4gLS0gCj4gCj4gUHJvYmFibHkgQ09ORklH
X1NMVUIgYW5kIENPTkZJR19TTFVCX0RFQlVHIHNob3VsZCBiZSB1c2VkLgoKVXNlZCB5b3VyIHBy
b2ZpbGUgYW5kIHRoaXMgc3RpbGwgZG9lcyBub3QgaGFwcGVuIDooCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApM
aW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
