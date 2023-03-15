Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BF7C61DA4
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 13:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m6hVJL0xA7F5QWE51pwgISXtk/JBPSlGVLFZ8RUzoLs=; b=EFBsgwjfxxiYk/p2XEGfPFY2Tn
	xfIYedlnGkmHbEDULe0V/yuUSvP3Q8d69/J+NxG8qDqCOEvGi55rEgGBo/DCIoLXy/9H5beBkaWTx
	VZdqLwydXx/DNhpM2h255fYEI57VbxVxP605Ip8AODZbJrsjXW5bhZO3JY+spswmmvwbJXRulkWKd
	NqKf7wPmmS2a/dh578c0gxEbG3E4tD5oJUH2AQJrKA8Yfq0qYB7EuzYwiPO41KZ1pWF+eribR9eyl
	ej1iFiOFPVanZRSjtwdmBx5kYgfib0qk8t5QeFAozZY44MNR7NDf97ixUThhowncjbBwjTjRONNdr
	ucxCZosQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcRKk-00DTF8-2o;
	Wed, 15 Mar 2023 13:38:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcRKj-00DTEI-0X
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 13:38:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7795F67373; Wed, 15 Mar 2023 14:38:21 +0100 (CET)
Date: Wed, 15 Mar 2023 14:38:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 4/5] nvmet: Fix I/O Command Set specific Identify
 Controller
Message-ID: <20230315133821.GC24915@lst.de>
References: <20230315105939.305825-1-damien.lemoal@opensource.wdc.com> <20230315105939.305825-5-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315105939.305825-5-damien.lemoal@opensource.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_063825_349118_5185409E 
X-CRM114-Status: GOOD (  10.67  )
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

> 1) Renaming nvmet_execute_identify_cns_cs_ctrl() to
>    nvmet_execute_identify_cns_cs_ctrl_zns() to continue handling the
>    ZNS command set as is.

I think nvmet_execute_identify_ctrl_cs_zns might be a better name.

> 2) Introduce nvmet_execute_identify_cns_cs_ctrl() helper to handle the
>    NVM command set, returning a zero filled nvme_id_ctrl_nvm data
>    structure.

and this might better be named nvmet_execute_identify_ctrl_cs.

As the _cns in all these and the Identify Namespace variants is
rather redundant.

Otherwise this looks good to me (and I can fix up the naming when
applying the series)

