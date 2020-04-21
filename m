Return-Path: <SRS0=BHyj=6F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A74EC54FC9
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2020 12:13:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41DD9206A5
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2020 12:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U4u5fi7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41DD9206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nqW+KoJCBb+cIfwHJ2H5SBLEoth7NFtz/I6HsSWBMqg=; b=U4u5fi7fkHpcp2
	Ubf3Co9r+91Gl7td9CklljxlqgcCuCRtn1sLOPwZZqGCbO6ercbmL4QF2mVA+PNx8p/blQcrDtfw1
	sVOszPKWOPmC1j355II6Z8XNJfMADK8m6AwlzyW+gPQekDYphryaKemFqe0fCYoLBiCH+twvVVSaV
	ouFVm6UtpvniABSavqCQ3KZUf3wQ/cLIxoaGG5xuZ8OQcIE/Rkmlrmyo+XdRNH1r2+elQcaYc8jF6
	W41o8oFzKIzjxWif2G/w6I3V/RUPm4tJy8Eh2KQruEmyf5Ge8/lOIQ9vUKiIt+0WnorgN8Plc+2nr
	yfy/Rk40ioIeUyTeW9GA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jQrlu-0001Wy-CP; Tue, 21 Apr 2020 12:13:02 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jQrlr-0001WO-95
 for linux-nvme@lists.infradead.org; Tue, 21 Apr 2020 12:13:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 666CE68C4E; Tue, 21 Apr 2020 14:12:57 +0200 (CEST)
Date: Tue, 21 Apr 2020 14:12:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 06/17] nvme: introduce NVME_INLINE_MD_SG_CNT
Message-ID: <20200421121257.GG26432@lst.de>
References: <20200327171545.98970-1-maxg@mellanox.com>
 <20200327171545.98970-8-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200327171545.98970-8-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200421_051259_460804_5F66FCB8 
X-CRM114-Status: UNSURE (   9.11  )
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
Cc: axboe@kernel.dk, jsmart2021@gmail.com, sagi@grimberg.me,
 martin.petersen@oracle.com, shlomin@mellanox.com, linux-rdma@vger.kernel.org,
 israelr@mellanox.com, vladimirk@mellanox.com, linux-nvme@lists.infradead.org,
 idanb@mellanox.com, jgg@mellanox.com, oren@mellanox.com, kbusch@kernel.org,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Mar 27, 2020 at 08:15:34PM +0300, Max Gurtovoy wrote:
> From: Israel Rukshin <israelr@mellanox.com>
> 
> SGL size of metadata is usually small. Thus, 1 inline sg should cover
> most cases. The macro will be used for pre-allocate a single SGL entry
> for metadata. The preallocation of small inline SGLs depends on SG_CHAIN
> capability so if the ARCH doesn't support SG_CHAIN, use the runtime
> allocation for the SGL. This patch is a preparation for adding metadata
> (T10-PI) over fabric support.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
