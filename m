Return-Path: <SRS0=THed=NL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21327C4338F
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Aug 2021 04:06:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9C6D6101A
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Aug 2021 04:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D9C6D6101A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Qpy2ARa9LDFPEJjAMRim2SUUcyw5J4yc/LCje+y9l10=; b=swf5Jx4aJMRB0Q
	RMGnwnRzr3GqAxsqr20d5Tz60hJX2TezNK2ntPoVG4Ltv5zEBbLLATgIHQQ8/f7S2OsMFZwJPsDQM
	gqZ57H7j6NdM1F6e+ofsAPBvINz9NLbP44ro/N4P40YJ/3eVmAd6a9bYwzEqpU5UoUI5DO9QWR9sy
	b4xL9OS/DCXBzOtoMLj3cheu8xSVLnosaMplKu+yPf9PuwhWSVMKWn+CXIC59Q97U760YT3wDhIe4
	lRT1tmFKJge91aIzIPK+5LNFpmbwl//e6QQujeLOEIs0TUaP7xFdK+JSGQWJH4TJzITYHntbA6zXD
	mK7fMcdVpQLi+jUaCpGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mGvnJ-00A382-KL; Fri, 20 Aug 2021 04:06:13 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mGvnC-00A36W-Up
 for linux-nvme@lists.infradead.org; Fri, 20 Aug 2021 04:06:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0EC686736F; Fri, 20 Aug 2021 06:06:05 +0200 (CEST)
Date: Fri, 20 Aug 2021 06:06:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Stefan Haberland <sth@linux.ibm.com>,
 Jan Hoeppner <hoeppner@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Doug Gilbert <dgilbert@interlog.com>,
 Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/9] nvme: use blk_mq_alloc_disk
Message-ID: <20210820040604.GB26305@lst.de>
References: <20210816131910.615153-1-hch@lst.de>
 <20210816131910.615153-2-hch@lst.de>
 <YR7h0w6rJc9GYpaf@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YR7h0w6rJc9GYpaf@bombadil.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210819_210607_187376_D0C6E3C7 
X-CRM114-Status: GOOD (  13.07  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gVGh1LCBBdWcgMTksIDIwMjEgYXQgMDM6NTc6MjNQTSAtMDcwMCwgTHVpcyBDaGFtYmVybGFp
biB3cm90ZToKPiA+ICAJCWlmIChudm1lX252bV9yZWdpc3RlcihucywgZGlzay0+ZGlza19uYW1l
LCBub2RlKSkgewo+ID4gIAkJCWRldl93YXJuKGN0cmwtPmRldmljZSwgIkxpZ2h0TlZNIGluaXQg
ZmFpbHVyZVxuIik7Cj4gPiAtCQkJZ290byBvdXRfcHV0X2Rpc2s7Cj4gPiArCQkJZ290byBvdXRf
dW5saW5rX25zOwo+ID4gIAkJfQo+ID4gIAl9Cj4gCj4gVGhpcyBodW5rIHdpbGwgZmFpbCBiZWNh
dXNlIG9mIHRoZSBub3cgcmVtb3ZlZCBOVk1FX1FVSVJLX0xJR0hUTlZNLiBUaGUKPiBsYXN0IHBh
cnQgb2YgdGhlIHBhdGNoICB0aGVuIGNhbiBiZSByZW1vdmVkIHRvIGFwcGx5IHRvIGxpbnV4LW5l
eHQuCgpTbyB0aGlzIGlzIG5vdCBpbiB0aGUgZm9yLTUuMTUvYmxvY2sgdHJlZSwganVzdCB0aGUg
ZHJpdmVycyBvbmUuCgpKZW5zLCBkbyB5b3Ugd2FudCB0byBzdGFydCBhIC1sYXRlIGJyYW5jaCBv
bnRvcCBvZiB0aGUgYmxvY2sgYW5kIGRyaXZlcnMKYnJhbmNoZXMgc28gdGhhdCB3ZSBjYW4gcHJl
LXJlc29sdmUgdGhlc2UgbWVyZ2XRlT8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LW52bWUK
