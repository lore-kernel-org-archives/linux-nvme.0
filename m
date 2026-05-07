Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5B6CD343B
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2026 05:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yH/CKZ0v1xVz5kgObDTvv9qZ2vRj7OW1HqpRVRINHX4=; b=cOsICzHwYXP/cBGO12EqcUJSwS
	V2qeCRSzUYkZogE5ygNcp3QFhJtImyV8D82gg2vLL59oFe4/ssfgRLrLqL0QkzA/zWgX0Ik+l3Kn3
	XAGaRmhT4okHgbsUH6pN296b4uYYXU3jDHq0RnpKnYzElvOLs/1CnKunY0eXTr0KqHaw58yB06F8x
	cyLct+3fbEgEZknL+bUdcYwrpfLnBFzhYXJHsCHe0NfdIap04LzMayyv0ai1SVa1mB6hJ9EP/n35b
	R7VHZFdeihGqMp1USl3g5F5KFqVcXzqGKeB/wPmOs7wYgWr1qdW/cSs0H5GyKuF2pTARgiKV813PQ
	uUALSbEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKrau-00000002q0s-1etc;
	Thu, 07 May 2026 05:48:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKrat-00000002q02-0L2U
	for linux-nvme@lists.infradead.org;
	Thu, 07 May 2026 05:48:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CF3EC68BEB; Thu,  7 May 2026 07:48:09 +0200 (CEST)
Date: Thu, 7 May 2026 07:48:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Shi <coshi036@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
	kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
	Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH RFC 1/2] nvme: downgrade WARN in nvme_setup_rw to
 pr_debug
Message-ID: <20260507054809.GA19796@lst.de>
References: <20260427003457.1264511-1-coshi036@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260427003457.1264511-1-coshi036@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260506_224819_268580_3654A1F1 
X-CRM114-Status: GOOD (  12.46  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Apr 26, 2026 at 08:34:56PM -0400, Chao Shi wrote:
> When an NVMe namespace is configured with embedded metadata (flbas bit 4
> set, NVME_NS_FLBAS_META_EXT) but no Protection Information (dps=0) and
> no NVME_NS_METADATA_SUPPORTED, nvme_setup_rw() fires WARN_ON_ONCE on
> any request that reaches it with REQ_INTEGRITY unset.  The WARN was
> observed repeatedly during NVMe fuzz testing with a FEMU-based fuzzer
> that performs semantic mutation of Identify Namespace responses.

What is "semantic mutation of Identify Namespace responses" supposed to
mean?

> In both cases the bio was submitted without REQ_INTEGRITY (because
> blk_get_integrity() returned NULL at dispatch time, so
> bio_integrity_action() returned 0 and bio_integrity_prep() was not
> called), and it reaches nvme_setup_rw() for a namespace where
> head->ms != 0.  The existing BLK_STS_NOTSUPP return correctly handles
> this dispatch; the WARN_ON_ONCE is a false positive.

That means we fail to properaly freeze and quiesce the queue over
updateѕm which has much worse results than just a WARN_ON.  So if we
care about this rather theoretical case we'll need to fix that.


