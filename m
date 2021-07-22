Return-Path: <SRS0=qdm1=MO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5896CC6377D
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 13:56:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BDBE6128D
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 13:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BDBE6128D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XGPm9qFvZ6LFE8IXetVn0NJXwdAJO8k2bR4sgQxQQuY=; b=PWwh8r7G1gDGx9IcNPSn+27cKG
	sNFM7tk+780glMqH5WWm9b6AyC88Hs0gPdbB0piPocN4qv/oNYGK0HvNr0BErLZmSsefkMRqV6+ye
	v8DI8buHZwm4DFMJdf1YDdnHCcPz9DNO6JYgt2UAkZmXVxI5ApFlD6X2NCgWYR/2aDFYE0y2uXy6M
	b8ebw2jWDQWj4k/hzgMF3u5ZovTCmSRU+WlM/5ttLDUbxSJeN7xd/ulQp6DUgujsf6cvNFO/fRtDS
	H/sOO3y2IqUP/qZqkvzr1QF3Qc1cvH77uBV9sKF89CQU3RnfU3/JdFie+8F9w2CIYZTG9x0F+E3xT
	+Hi1m80Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6ZBf-001mn4-GE; Thu, 22 Jul 2021 13:56:31 +0000
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6ZAC-001mGr-Hv; Thu, 22 Jul 2021 13:55:05 +0000
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GVtyD4mF5z6DHHy;
 Thu, 22 Jul 2021 21:45:56 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 22 Jul 2021 15:54:51 +0200
Received: from [10.47.26.161] (10.47.26.161) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Thu, 22 Jul
 2021 14:54:51 +0100
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
To: Marc Zyngier <maz@kernel.org>
CC: Ming Lei <ming.lei@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 <iommu@lists.linux-foundation.org>, Will Deacon <will@kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-nvme@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
References: <YOgK8fdv7dOQtkET@T590>
 <23e7956b-f3b5-b585-3c18-724165994051@arm.com> <YOhcOv1oOwm6fco+@T590>
 <ad5bc549-d83f-bee0-9a9f-03a5afd7f3d9@huawei.com> <YPd7IGFZrsTRfUxE@T590>
 <74537f9c-af5f-cd84-60ab-49ca6220310e@huawei.com> <YPfwAN1onpSKoeBj@T590>
 <a2650064-41cf-cb62-7ab4-d14ef1856966@huawei.com> <YPklDMng1hL3bQ+v@T590>
 <9c929985-4fcb-e65d-0265-34c820b770ea@huawei.com> <YPlGOOMSdm6Bcyy/@T590>
 <fc552129-e89d-74ad-9e57-30e3ffe4cf5d@huawei.com>
 <411dfc7cd330df1f681137d77e846b78@misterjones.org>
From: John Garry <john.garry@huawei.com>
Message-ID: <d975276a-5889-7bbd-5329-287ae661f04b@huawei.com>
Date: Thu, 22 Jul 2021 14:54:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <411dfc7cd330df1f681137d77e846b78@misterjones.org>
Content-Language: en-US
X-Originating-IP: [10.47.26.161]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210722_065500_787592_AAAAF19C 
X-CRM114-Status: GOOD (  10.99  )
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

T24gMjIvMDcvMjAyMSAxMzo1MywgTWFyYyBaeW5naWVyIHdyb3RlOgo+IEhpIEpvaG4sCj4gCj4g
Wy4uLl0KPiAKPj4gwqDCoMKgIFlvdXIga2VybmVsIGxvZyBzaG91bGQgc2hvdzoKPj4gwqDCoMKg
IFvCoMKgwqAgMC4wMDAwMDBdIEdJQ3YzOiBQc2V1ZG8tTk1JcyBlbmFibGVkIHVzaW5nIGZvcmNl
ZCBJQ0NfUE1SX0VMMQo+PiBzeW5jaHJvbmlzYXRpb24KPiAKPiBVbnJlbGF0ZWQsIGJ1dCB5b3Ug
c2VlbSB0byBiZSBydW5uaW5nIHdpdGggSUNDX0NUTFJfRUwzLlBNSEUgc2V0LAo+IHdoaWNoIG1h
a2VzIHRoZSBvdmVyaGVhZCBvZiBwc2V1ZG8tTk1JcyBtdWNoIGhpZ2hlciB0aGFuIGl0IHNob3Vs
ZCBiZQo+ICh5b3UgdGFrZSBhIERTQiBTWSBvbiBlYWNoIGludGVycnVwdCB1bm1hc2tpbmcpLgo+
IAo+IElmIHlvdSBhcmUgbm90IHVzaW5nIDE6TiBkaXN0cmlidXRpb24gb2YgU1BJcyBvbiB0aGUg
c2VjdXJlIHNpZGUsCj4gY29uc2lkZXIgdHVybmluZyB0aGF0IG9mZiBpbiB5b3VyIGZpcm13YXJl
LiBUaGlzIHNob3VsZCBtYWtlIE5NSXMKPiBzbGlnaHRseSBtb3JlIHBsZWFzYW50IHRvIHVzZS4K
ClRoYW5rcyBmb3IgdGhlIGhpbnQuIEkgc3BlYWsgdG8gdGhlIEJJT1MgZ3V5cy4KCkpvaG4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUg
bWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
