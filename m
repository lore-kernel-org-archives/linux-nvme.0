Return-Path: <SRS0=W+Vz=CJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2E4C433E2
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 21:28:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E795C20719
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 21:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F/q9qkVp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E795C20719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5W0aknCgeHsZ23d5KO66rMqzfkxDm/5NZXiWnNWU/xg=; b=F/q9qkVpC6O+mb3H7zwAf5DBQ
	XlSS6+VCKqgx2BpcweQi1hYdfrivXNHOrnoj5rcuUIGhzthWchlQ7QfcF3J4TPU8oio9inXP3QRaN
	YMCI5IcFDeT285oImSSgMLA+pOCjxLc80f4zYKBACSiD98udzP1EI7m3rOGdK0/sVxl7/EecY8VTs
	23p6lSi3ITd1jyBcoPWttfF/fKIkM3lqq5sHhEZ/vcTCdP6lQMVpqBJcaETcBHgPPhGsobN3fxLuS
	Rxi3NgNK8RrxXzy4rr0M3cXveK0orF685UvhwNHzXvb79MM+xxWR2+9F3p+b+++3nnfUcXHgsixRq
	TqnyGgdTA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kCrM0-0000uI-TC; Mon, 31 Aug 2020 21:28:41 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCrLx-0000th-3d
 for linux-nvme@lists.infradead.org; Mon, 31 Aug 2020 21:28:37 +0000
Received: by mail-wm1-f47.google.com with SMTP id q9so833242wmj.2
 for <linux-nvme@lists.infradead.org>; Mon, 31 Aug 2020 14:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NSYKbtSonyXsz3JQRRCyhnT0M9JHJvv7JCjC9d4hcrQ=;
 b=eVNr7ghoFSdwzG8DUzIMQPwn6jusjmOe7WkKYRZd0wmJ4By91znt8xTJkUBU0VLUPB
 bwRpNuHzwOHEe8iJUcYUmb4lT/sv168ID+avQrzQpWAoJajGgvyyFoy5uGyvKi1wMfTt
 EiSB7/cCXG9Q48T8cNWP0fl5rP7cJI0PSe6t+pRP79/ZsUJaGW5MyzM3UQmvCK+RCgND
 4HRJOM5BWBov+d1a0yAFZceLyrEsQQBiUwNFhHrsBZUVBArcHYvNqT1Z+qWfCKLSOs7+
 /9ozbcWuUta12mPYyeAtBHSmMG0qW3HLihCqTRU74qB7PmDEWiDARVpid7XanMjlTpAx
 x4Og==
X-Gm-Message-State: AOAM5328nYi339ihehYzY4t6fQjXBcBhdA/NZ7Uho23qg4kOAiEJJStN
 B1CklUjzSJCOYLR9yLdDu0xuAdtqJVAkyw==
X-Google-Smtp-Source: ABdhPJziLsOSNdXZaVnbUlGuSZubJtfwaENeLvZI7zGetTBh/E/7S3AhbrBKSBeLvaj2/oPpJefz8g==
X-Received: by 2002:a1c:156:: with SMTP id 83mr1087268wmb.49.1598909313008;
 Mon, 31 Aug 2020 14:28:33 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:70b6:3990:a389:c0d1?
 ([2601:647:4802:9070:70b6:3990:a389:c0d1])
 by smtp.gmail.com with ESMTPSA id b1sm10142689wru.54.2020.08.31.14.28.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2020 14:28:32 -0700 (PDT)
Subject: Re: [bug report] reset_controller operation on NVMe/IB need more than
 10s
To: Yi Zhang <yi.zhang@redhat.com>, maxg@mellanox.com
References: <769167569.38843663.1598589784057.JavaMail.zimbra@redhat.com>
 <3138aa7e-612c-8a17-4bce-dd42078892b6@grimberg.me>
 <14e3d9d2-0a3e-f79d-dae1-c73ef9cb53a5@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9cf68ebd-f60c-3aef-0cbc-3820598c61af@grimberg.me>
Date: Mon, 31 Aug 2020 14:28:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <14e3d9d2-0a3e-f79d-dae1-c73ef9cb53a5@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200831_172837_226214_0AC4D942 
X-CRM114-Status: GOOD (  15.60  )
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
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4gQ2hhbmdlIHRoZSBTdWJqZWN0Li4uCj4gCj4gRmluYWxseSBJIGZvdW5kIHRoZSBPT00gd2Fz
IG5vdCB0cmlnZ2VyZWQgYnkgcmVzZXRfY29udHJvbGxlciwgYnV0IGR1ZSAKPiB0byBteSA1MDAg
dGltZXMnIHJlc2V0X2NvbnRyb2xsZXIgbm90IGZpbmlzaGVkIGluIDEgaG91ciwgYW5kIHRyaWdn
ZXJlZCAKPiB0ZXN0IGhhcm5lc3Mgd2F0Y2hkb2cgYW5kIGxlYWQgT09NLgo+IAo+IFNvIHRoZSBp
c3N1ZSBoZXJlIGlzIHRoZSByZXNldF9jb250cm9sbGVyIG9wZXJhdGlvbiBuZWVkIG1vcmUgdGhh
biAxMHMgCj4gbm93WzFdLCBieSBiaXNlY3RpbmcgSSBmb3VuZCBpdCB3YXMgaW50cm9kdWNlZCBm
cm9tIGNvbW1pdFsyXSwgYW5kIGl0IAo+IHdpbGwganVzdCBuZWVkIDIgc2Vjb25kcyBpZiB3L28g
dGhpcyBwYXRjaC4KPiAKPiBbMV0KPiAjIHRpbWUgZWNobyAxID4vc3lzL2Jsb2NrL252bWUwbjEv
ZGV2aWNlL252bWUwL3Jlc2V0X2NvbnRyb2xsZXIKPiAKPiByZWFswqDCoMKgIDBtMTAuMzkycwo+
IHVzZXLCoMKgwqAgMG0wLjAwMHMKPiBzeXPCoMKgwqAgMG0wLjAwMHMKPiAKPiBbMl0KPiBjb21t
aXQgNWVjNWQzYmRkYzZiOTEyYjdkZTllM2ViNmMxZjIzOTdmYWVjYTJiYwo+IEF1dGhvcjogTWF4
IEd1cnRvdm95IDxtYXhnQG1lbGxhbm94LmNvbT4KPiBEYXRlOsKgwqAgVHVlIE1heSAxOSAxNzow
NTo1NiAyMDIwICswMzAwCj4gCj4gIMKgwqDCoCBudm1lLXJkbWE6IGFkZCBtZXRhZGF0YS9UMTAt
UEkgc3VwcG9ydAo+IAo+ICDCoMKgwqAgRm9yIGNhcGFibGUgSENBcyAoZS5nLiBDb25uZWN0WC01
L0Nvbm5lY3RYLTYpIHRoaXMgd2lsbCBhbGxvdyAKPiBlbmQtdG8tZW5kCj4gIMKgwqDCoCBwcm90
ZWN0aW9uIGluZm9ybWF0aW9uIHBhc3N0aHJvdWdoIGFuZCB2YWxpZGF0aW9uIGZvciBOVk1lIG92
ZXIgUkRNQQo+ICDCoMKgwqAgdHJhbnNwb3J0LiBNZXRhZGF0YSBvZmZsb2FkIHN1cHBvcnQgd2Fz
IGltcGxlbWVudGVkIG92ZXIgdGhlIG5ldyBSRE1BCj4gIMKgwqDCoCBzaWduYXR1cmUgdmVyYnMg
QVBJIGFuZCBpdCBpcyBlbmFibGVkIGZvciBjYXBhYmxlIGNvbnRyb2xsZXJzLgo+IAo+ICDCoMKg
wqAgU2lnbmVkLW9mZi1ieTogTWF4IEd1cnRvdm95IDxtYXhnQG1lbGxhbm94LmNvbT4KPiAgwqDC
oMKgIFNpZ25lZC1vZmYtYnk6IElzcmFlbCBSdWtzaGluIDxpc3JhZWxyQG1lbGxhbm94LmNvbT4K
PiAgwqDCoMKgIFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPgo+
IAo+IFszXSB3L28gYWJvdmUgcGF0Y2gKPiAjIHRpbWUgZWNobyAxID4vc3lzL2Jsb2NrL252bWUw
bjEvZGV2aWNlL252bWUwL3Jlc2V0X2NvbnRyb2xsZXIKPiAKPiByZWFswqDCoMKgIDBtMi4xMzJz
Cj4gdXNlcsKgwqDCoCAwbTAuMDAwcwo+IHN5c8KgwqDCoCAwbTAuMDAwcwoKTWF4LCBhcmUgeW91
IGxvb2tpbmcgaW50byB0aGlzPwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtbnZtZQo=
