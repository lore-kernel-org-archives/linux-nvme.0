Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F46C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 13:17:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AA7961100
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 13:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5AA7961100
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:To:Subject:MIME-Version:
	Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J9brHmQtU17zKD0F+Lh8LCz7UYuLvc4taKZ+xh7Y104=; b=cngllYtP1BxSNKay0KfObo4dao
	eCIqOJbMVOvD9eYua8i/CaYBT0PDSlrFt++hMHNoyYhzdHM86WXI2kz8fn0/ZuNr0/V0DwxxGs6NZ
	ACRuCS0mR/fYJnT32FOYXcNcx7TYPQ2gOAMle8zyDDSKxkAuBA2LDXCFmbXrKs1lDqEGEDSRlcLiQ
	0yvWhyahsw1aDiDs9KUd3in26q8iUkr+zMikPGubzPEbevmP1HtNsutEQVrib4WVwiqaScAjNzGXF
	MGiNojohcomzfZfbaYHoX0E8giv4spHojx1A3nhzccMlFyifaLPWRXzq+SkqinrM2cuChMi4UBuVS
	qr6Op/gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mT27o-008ai8-Qk; Wed, 22 Sep 2021 13:17:24 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mT27Y-008abk-8P
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 13:17:09 +0000
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HDzLw1NRKz1DH9l;
 Wed, 22 Sep 2021 21:15:52 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 22 Sep 2021 21:17:02 +0800
Received: from [10.169.63.14] (10.169.63.14) by dggpeml500006.china.huawei.com
 (7.185.36.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.8; Wed, 22 Sep
 2021 21:17:01 +0800
Message-ID: <532661f9-2056-503f-1bbb-87a61345c9a2@huawei.com>
Date: Wed, 22 Sep 2021 21:17:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0
Subject: Re: [PATCH nvme-cli 1/2] add "State" entry
To: <linux-nvme@lists.infradead.org>, Chaitanya Kulkarni
 <chaitanyak@nvidia.com>
References: <20210915132912.3004-1-chengjike.cheng@huawei.com>
 <20210915132912.3004-2-chengjike.cheng@huawei.com>
 <74cf36c7-9e18-2b81-08ba-cc4223f3b133@nvidia.com>
 <20210916192103.GC3908552@dhcp-10-100-145-180.wdc.com>
 <69217011-5a8f-8149-e8dd-0535358fa930@nvidia.com>
From: "Chengjike (ISSP)" <chengjike.cheng@huawei.com>
In-Reply-To: <69217011-5a8f-8149-e8dd-0535358fa930@nvidia.com>
X-Originating-IP: [10.169.63.14]
X-ClientProxiedBy: dggeme715-chm.china.huawei.com (10.1.199.111) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210922_061708_628299_C7F8BDFB 
X-CRM114-Status: UNSURE (   4.83  )
X-CRM114-Notice: Please train this message.
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

CuWcqCAyMDIxLzkvMTcgNzowMSwgQ2hhaXRhbnlhIEt1bGthcm5pIOWGmemBkzoKPj4+Cj4+PiBX
aGVyZSBpcyB0aGUgZGVmaW5pdGlvbiBvZiB0aGUgbnZtZV9uc19nZXRfc3RhdGUoKSA/IEkgZGlk
bid0IGZpbmQgaW4KPj4+IHRoaXMgcGF0Y2gsIGFuZCB5b3VyIGNvbW1pdCBsb2cgaXMgbm90IGhl
bHBmdWwgYXQgYWxsIGZvciB0aGUgcmV2aWV3ZXJzLgo+PiBJdCBsb29rcyBsaWtlIHBhdGNoIDEg
YW5kIDIgYXJlIHJldmVyc2VkLgo+Pgo+IE1heWJlIHJlc2VuZCB3aXRoIHRoZSByaWdodCBvcmRl
ciB3aXRoIHByb3BlciBjb21taXQgZGVzY3JpcHRpb24gPwo+ClllcwoKSXQgaXMgbXkgZmF1bHQu
IFBhdGNoIDEgYW5kIDIgYXJlIHJldmVyc2VkLgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LW52bWUK
