Return-Path: <SRS0=DRq2=6V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE36C38A24
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2020 13:56:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 157832073A
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2020 13:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="phsVAa7n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157832073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jSFTvjfgRbdf1OCU2aqpRNE12xZhZIBlZBLlmokpUxI=; b=phsVAa7nXor/AH+I0OdCsqz4E
	kJSBfS/YadAYCtufXzxgmV7XqRqEzUeWvOz5GZbXwWsAGMkNny54EYGySX3ZhfMTxeaqxqyW5C9ei
	+jUgFJORILp2TiZ095el+T3eA9N9av+Kf5sLDVt8qvMedDeaR1mSZqeXqkDNd2j/fL4X2Stct87Ip
	wKUSyt2ndMPQM7RBiw5CaylO0FQfWJ136Vdi9gQ/KHYiHXUYecWCcNCwiQWlbjdJJSl4885yasS4Z
	BrEqm/ldTGceTdiFUVB+zZJDXYdt55AISXmED91QC0XnllenTAmY0oC8WYlf1QtR69ow1i3n+x9kg
	M2FOfcgTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jWh0u-0001yS-7W; Thu, 07 May 2020 13:56:36 +0000
Received: from lhrrgout.huawei.com ([185.176.76.210] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWh0r-0001xq-2v
 for linux-nvme@lists.infradead.org; Thu, 07 May 2020 13:56:34 +0000
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id 08D1BE16426FCBE6F999;
 Thu,  7 May 2020 14:56:26 +0100 (IST)
Received: from [127.0.0.1] (10.47.3.227) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Thu, 7 May 2020
 14:56:25 +0100
Subject: Re: [PATCH] nvme-pci: slimmer CQ head update
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
References: <20200228184519.GA2281@avx2>
 <20200229055351.GA542920@dhcp-10-100-145-180.wdl.wdc.com>
 <defb25c5-5ae5-5ff9-66db-efb129bd7743@huawei.com>
 <20200506124701.GA54933@C02WT3WMHTD6> <20200506132429.GA21451@avx2>
 <2ecb88b5-b585-52ed-bb84-5b486868743a@huawei.com>
 <20200506143519.GA570@lst.de>
 <4155a814-798c-0c7e-5433-daf719c0345c@huawei.com>
 <20200506163104.GD12919@willie-the-truck>
 <3453193c-424b-1e4c-16be-279088612c68@arm.com>
 <efc85e9a-93a6-989b-b8d7-db83b5d74b96@huawei.com>
 <6673a108-c572-12ff-7ddd-b88147829615@huawei.com>
 <4dae5990-e81b-8b33-dafc-ee47e4f06b6a@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <e1643b53-d362-0b5e-573f-72f0ea249ebf@huawei.com>
Date: Thu, 7 May 2020 14:55:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <4dae5990-e81b-8b33-dafc-ee47e4f06b6a@arm.com>
Content-Language: en-US
X-Originating-IP: [10.47.3.227]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200507_065633_272788_7803182B 
X-CRM114-Status: GOOD (  10.94  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
 Alexey Dobriyan <adobriyan@gmail.com>, axboe@fb.com,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMDcvMDUvMjAyMCAxMjowNCwgUm9iaW4gTXVycGh5IHdyb3RlOgo+PiBbwqAgMTc3LjEzMjgx
MF0gRE1BLUFQSTogbnZtZSAwMDAwOjg1OjAwLjA6IGRldmljZSBkcml2ZXIgdHJpZXMgdG8gZnJl
ZSAKPj4gRE1BIG1lbW9yCj4+IHkgaXQgaGFzIG5vdCBhbGxvY2F0ZWQgW2RldmljZSBhZGRyZXNz
PTB4MDAwMDAwMDBlZjM3MTAwMF0gW3NpemU9NDA5NiAKPj4gYnl0ZXNdCj4gWy4uLl0KPj4gW8Kg
IDE3Ny4yNzYzMjJdwqAgZGVidWdfZG1hX3VubWFwX3BhZ2UrMHg2Yy8weDc4Cj4+IFvCoCAxNzcu
MjgwNDg3XcKgIG52bWVfdW5tYXBfZGF0YSsweDdjLzB4MjNjCj4+IFvCoCAxNzcuMjg0MzA1XcKg
IG52bWVfcGNpX2NvbXBsZXRlX3JxKzB4MjgvMHg1OAo+IAo+IE9LLCBzbyB0aGVyZSdzIGNsZWFy
bHkgc29tZXRoaW5nIGFtaXNzIHRoZXJlLiBJIHdvdWxkIGhhdmUgc3VnZ2VzdGVkIAo+IG5leHQg
c3RpY2tpbmcgdGhlIFNNTVUgaW4gcGFzc3Rocm91Z2ggdG8gaGVscCBmb2N1cyBvbiB0aGUgRE1B
IEFQSSAKPiBkZWJ1Z2dpbmcsIGJ1dCBzaW5jZSB0aGF0ICJETUEgYWRkcmVzcyIgbG9va3Mgc3Vz
cGljaW91c2x5IGxpa2UgYSAKPiBwaHlzaWNhbCBhZGRyZXNzIHJhdGhlciB0aGFuIGFuIElPVkEs
IEkgc3VzcGVjdCB0aGF0IHRoaW5ncyBtaWdodCAKPiBzdWRkZW5seSBhcHBlYXIgdG8gYmUgd29y
a2luZyBmaW5lIGlmIHlvdSBkby4uLgoKT0ssIHNlZW1zIHNlbnNpYmxlLiBIb3dldmVyIGl0IGxv
b2tzIGxpa2UgdGhpcyBndXkgdHJpZ2dlcnMgdGhlIGlzc3VlOgoKMzI0YjQ5NGMyODYyIG52bWUt
cGNpOiBSZW1vdmUgdHdvLXBhc3MgY29tcGxldGlvbnMKCldpdGggY2FycnlpbmcgdGhlIHJldmVy
dCBvZiAkc3ViamVjdCwgaXQncyBhIHF1aWNrIGJpc2VjdCB0byB0aGF0IHBhdGNoLiAKSSBhbHdh
eXMgZ2V0IHRoZSBSQ1UgY3B1IHN0YWxsIHdhcm5pbmcsIHdoaWNoIG9ic2N1cmVzIHRoaW5nIGEg
Yml0LgoKQ2hlZXJzLApKb2huCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1udm1lCg==
