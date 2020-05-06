Return-Path: <SRS0=TIQn=6U=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82683C38A2A
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2020 14:35:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D1C52076D
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2020 14:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tVt1cOVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D1C52076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6c10lkhEmADO63+ix2HuT2xdAPGTDMhqsdbgnPHu8yQ=; b=tVt1cOVehOCoDj
	l2x6SL6UtkOMYPoCxTzhKWNofIMtlLL4gzzgCJ70JxbagPPxaQlocqCrgFELLwNCQqxoBUaq3nIzc
	HOUluOPGMMTTSdFD7keLrgk77wuEsMgajBmdktm+Q549w+WVSK9h5zmzkTW4jEpau3hBce4Xus4P/
	jjWQdTjWE1JbWR6A1hWPR86qAaQrBfx/KvDSn89/Rru6dtB89ju1RNMfd5gPoFMqDBDuwfVxKdHNA
	NdTzH5rLPeRzSitmN+mJWu24WzPJXCUnJ1loqqu6ZvRJUV9Z9q5vKGHzggJRoOyuk4kipnoYX5ovJ
	iKQQOYWNv946ld9W08fw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jWL8w-0006PH-L3; Wed, 06 May 2020 14:35:26 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWL8t-0006OS-FS
 for linux-nvme@lists.infradead.org; Wed, 06 May 2020 14:35:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6B27968C7B; Wed,  6 May 2020 16:35:19 +0200 (CEST)
Date: Wed, 6 May 2020 16:35:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] nvme-pci: slimmer CQ head update
Message-ID: <20200506143519.GA570@lst.de>
References: <20200228184519.GA2281@avx2>
 <20200229055351.GA542920@dhcp-10-100-145-180.wdl.wdc.com>
 <defb25c5-5ae5-5ff9-66db-efb129bd7743@huawei.com>
 <20200506124701.GA54933@C02WT3WMHTD6> <20200506132429.GA21451@avx2>
 <2ecb88b5-b585-52ed-bb84-5b486868743a@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2ecb88b5-b585-52ed-bb84-5b486868743a@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200506_073523_662048_19D0966C 
X-CRM114-Status: UNSURE (   6.14  )
X-CRM114-Notice: Please train this message.
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org, hch@lst.de, axboe@fb.com,
 Keith Busch <kbusch@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gV2VkLCBNYXkgMDYsIDIwMjAgYXQgMDI6NDQ6NTBQTSArMDEwMCwgSm9obiBHYXJyeSB3cm90
ZToKPiBJJ2QgcmF0aGVyIGhlYXIgdGhlIG1haW50YWluZXLigJlzIG9waW5pb24gYmVmb3JlIGJv
dGhlcmluZyB0ZXN0aW5nIHRoaXMuLi4KCkFzIHRoZSBvdGhlciBtYWludGFpbmVyIC0gcGxlYXNl
IGdpdmUgaXQgYSBzcGluLiAgVGhlIGV4cGxhbmF0aW9uIGZyb20KQWxleGV5IGluIHRoZSByZXBs
eSB0byB5b3VyIG1haWwgbWFrZXMgY29tcGxldGUgc2Vuc2UgdG8gbWUuCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlz
dApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
