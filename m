Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784C6C46CD4
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Dec 2023 09:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FV0GB3Rh+CEt5+AX+j52YuZ0fmgryFc//Ml6lt4d3wk=; b=mkp/91Tf0UXVpou+aRGyc0RSOi
	6xKX1ZTMED3/08+X+Qf3nZd3vmhUXDh0Cgbd2jeXuICwS/vIfYTGNpDHfzFTK7xqR66YZuTbyniT+
	EhV55PYUzlTOuiiXlQartMCL1BpyiFj4JQu9hPtPWuXiOJOuSdllSAVi+XqtchhNXFItkm7ij0U3S
	sqP1yaVmu5MGFYSU3+hureRZZJVR59HtTuVWBZxi3PBD9VlJ7fkpmptFAvsGWtp6FJOKlp3q6FCtf
	WUTuAt11XiMdaNL37Cke89j1j8j2p8R47RSyBCVkTCoVPbrGCPc23BuaGXWWriOSiRgHw4WmIbBU6
	763eyFCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rIQ5j-00EHZF-0R;
	Wed, 27 Dec 2023 09:20:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rIQ5g-00EHXF-2R
	for linux-nvme@lists.infradead.org;
	Wed, 27 Dec 2023 09:20:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BF48E68B05; Wed, 27 Dec 2023 10:20:31 +0100 (CET)
Date: Wed, 27 Dec 2023 10:20:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH V2] nvme: introduce nvme_disk_is_ns_head helper
Message-ID: <20231227092031.GA23040@lst.de>
References: <20231227090525.26662-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227090525.26662-1-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231227_012040_937767_319F26BE 
X-CRM114-Status: GOOD (  11.10  )
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

On Wed, Dec 27, 2023 at 05:05:25PM +0800, Guixin Liu wrote:
>  
> +static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
> +{
> +	if (disk->fops == &nvme_ns_head_ops)
> +		return true;
> +	return false;

I would still keep it simple here:

	return disk->fops == &nvme_ns_head_ops;

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

