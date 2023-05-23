Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AEBC77B7A
	for <linux-nvme@archiver.kernel.org>; Tue, 23 May 2023 06:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xUcV7wxBV6TrOMDm23MJysFVEa4ypwrdf3nFaXwWW9w=; b=y8RlsNOxrYreExYKc2uVw3d3Q/
	4pv7KRY0lluDtG9SFnI8i0ytZarnT/OazDjplYiBM52KUD4ONOiYh2HYQ6zy+dwEOXSR+25ZUluqJ
	CsoCPkvAinzGStd1rqkRlzW1rSLxE0Uu6J81cY5Xv0LBwOKFWxxan7BGRIKCwDMn2xPtrNz++ZCFY
	0xKHK1KnoqT66D5zw5FUamCGIyJyP90QByPaAFIhpqIooTbDtmvZO/R3KERAMk6RW7H0d/Sec0Y8r
	XJeclcTIg8bVJ8QrcP/p3BjLO8M+Z5fX1Bfp5TBfjbuO2nNzPglYhXhqitNahGW7K/71wHTsoj7DR
	rzHe+Ewg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q1Lyp-0098qO-2Z;
	Tue, 23 May 2023 06:58:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1Lyn-0098pO-0X
	for linux-nvme@lists.infradead.org;
	Tue, 23 May 2023 06:58:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8015867373; Tue, 23 May 2023 08:58:42 +0200 (CEST)
Date: Tue, 23 May 2023 08:58:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: hare@suse.de, linux-nvme@lists.infradead.org, hch@lst.de,
	sagi@grimberg.me
Subject: Re: [PATCH 2/3] nvme-fabrics: error out when connect I/O fails
Message-ID: <20230523065842.GB8533@lst.de>
References: <20230522130408.105328-1-kch@nvidia.com> <20230522130408.105328-3-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522130408.105328-3-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230522_235845_342996_4717D681 
X-CRM114-Status: GOOD (  10.65  )
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

On Mon, May 22, 2023 at 06:04:07AM -0700, Chaitanya Kulkarni wrote:
> In nvmf_connect_io_queue() when connect I/O commands fails we just
> log the connect error and continue processing for authentication.
> 
> Add goto out_free_data after logging the connect error to error out.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

