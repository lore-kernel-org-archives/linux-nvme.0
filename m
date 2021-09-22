Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E61C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 06:02:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 410DC61090
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 06:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 410DC61090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7S9uMd+SdDTf6i2YNGM7Po3cAyRfprXsdV8qLcTldAw=; b=x5pNaR4IR/NiItSRfCwY9CUfZx
	7Y7WYoYH956/T6Ec+7Ip6jiG5XjX8Xli+/bq5deaEmezdcHx1hFyLmZqPJJq2e9W15cuNEtorYyqo
	Tvm3seGOSJICAzPHX02WuMC6KNeE508mbqSaM1DAmGfjyOQRXXGP7S/OCoqyKXFpXqLV9UXNG95NU
	jic1Kgo1299If7JL+RqFaXw3sQHZ4dlM2kZUi9B1xO0r0W6N57DkNRg77Ze8RsD1zBVaJsAKrW+xG
	i+V4Htkd34flTuCZkC6VsS5bFCGsZXEB5ILKwWZ9G8vpkq7e9kMl4z4JWDZ30hdzeG/mPZuAupWaL
	UbSCDH+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSvKK-006zy7-F1; Wed, 22 Sep 2021 06:01:52 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSvKI-006zxm-54
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 06:01:51 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9726920081;
 Wed, 22 Sep 2021 06:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632290508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=omINzg/Kq8FlPW2Dqd0sT/9v8UMXF1/4Uu9dRL8Sf2E=;
 b=ZifsAuyOjcj6gxTQz29c3xO7epBwjtBbkHrw4UalHNruCN+D5yTYQoTr46i4yOn7UQ8awL
 UCAjUaGG/3hXVfGX/0oUy8RvFub9XHKdJvZEwWwMyQ7CmfMgsm/sdWDAigkKRXWxl7eYun
 qTpl+J9Vhic4wH8jp5Dhfd8rIKmYYBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632290508;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=omINzg/Kq8FlPW2Dqd0sT/9v8UMXF1/4Uu9dRL8Sf2E=;
 b=/GxZnwUlx09QvUS9FPwIkLKvIcoC9l2/PGyyo56kzdERvNM4AFuqwKLjW/8tGL2BnymvcH
 4GGdC1UEaPAS01CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A62C13D2F;
 Wed, 22 Sep 2021 06:01:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OnucGMzGSmF8RwAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 22 Sep 2021 06:01:48 +0000
Subject: Re: [PATCH 3/6] nvmet: set 'CNTRLTYPE' in the identify controller data
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20210921151529.29419-1-hare@suse.de>
 <20210921151529.29419-4-hare@suse.de>
 <0afe1307-44d8-50d5-13b1-1939745dc2a5@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <6a230381-2f34-fce6-2853-296b00477553@suse.de>
Date: Wed, 22 Sep 2021 08:01:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <0afe1307-44d8-50d5-13b1-1939745dc2a5@nvidia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_230150_396354_32D5D491 
X-CRM114-Status: GOOD (  19.69  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gOS8yMi8yMSAzOjIzIEFNLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6Cj4gT24gOS8yMS8y
MSA4OjE1IEFNLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+IFNldCB0aGUgY29ycmVjdCAnQ05U
UkxUWVBFJyBmaWVsZCBpbiB0aGUgaWRlbnRpZnkgY29udHJvbGxlciBkYXRhLgo+Pgo+PiBTaWdu
ZWQtb2ZmLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KPj4gLS0tCj4+ICAgIGRy
aXZlcnMvbnZtZS90YXJnZXQvYWRtaW4tY21kLmMgICB8IDMgKysrCj4+ICAgIGRyaXZlcnMvbnZt
ZS90YXJnZXQvZGlzY292ZXJ5LmMgICB8IDIgKysKPj4gICAgZHJpdmVycy9udm1lL3RhcmdldC9m
YWJyaWNzLWNtZC5jIHwgMyArKy0KPj4gICAgMyBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJnZXQv
YWRtaW4tY21kLmMgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2FkbWluLWNtZC5jCj4+IGluZGV4IGFh
NmQ4NGQ4ODQ4ZS4uODU0NmJhZTUyNDRkIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL252bWUvdGFy
Z2V0L2FkbWluLWNtZC5jCj4+ICsrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvYWRtaW4tY21kLmMK
Pj4gQEAgLTM3NCw2ICszNzQsOSBAQCBzdGF0aWMgdm9pZCBudm1ldF9leGVjdXRlX2lkZW50aWZ5
X2N0cmwoc3RydWN0IG52bWV0X3JlcSAqcmVxKQo+PiAgICAKPj4gICAgCWlkLT5yYWIgPSA2Owo+
PiAgICAKPj4gKwlpZC0+Y250cmx0eXBlID0gY3RybC0+c3Vic3lzLT50eXBlID09IE5WTUVfTlFO
X0RJU0MgPwo+PiArCQlOVk1FX0NUUkxfRElTQyA6IE5WTUVfQ1RSTF9JTzsKPj4gKwo+IAo+IHNp
bmNlIHRoaXMgY2hlY2sgaXMgdXNlZCBvbiBtb3JlIHRoYW4gb25lIHBsYWNlIGluIHRoaXMgcGF0
Y2gsCj4gd2h5IG5vdCBoYXZlIGEgaGVscGVyIGluc3RlYWQgb2Ygb3BlbmNvZGluZyB0aGF0IG1h
a2VzIGNvZGUgZWFzeSBzbwo+IHNlYXJjaCBlLmcuCj4gCj4gYm9vbCBudm1ldF9pc19zdWJzeXNf
ZGlzYyhzdHJ1Y3QgbnZtZXRfc3Vic3lzICpzKQo+IHsKPiAJcmV0dXJuIHN1YnN5cy0+dHlwZSA9
PSBOVk1FX05RTl9ESVNDID8gdHJ1ZSA6IGZhbHNlOwo+IH0KPiAKR29vZCBwb2ludC4gV2lsbCBi
ZSB1cGRhdGluZyB0aGUgcGF0Y2hzZXQuCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMg
UmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3Vz
ZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0Ug
U29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpI
UkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2
cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
