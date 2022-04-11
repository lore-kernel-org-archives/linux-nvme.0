Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69CF2C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Apr 2022 14:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xy0xCNHTDe7uCJdMRGZkQpkjxOsvGlOXPgRiAyqvSk8=; b=G3EIERzu2ab8Th5OCwuM7j2a12
	OTLjv+6vQz1JkM+cCm2/urMSf4zQMD4/y8W8+m096M+mnuCEc4QfL9rV9HCBnUggAZK4NTEZgafKM
	JQSeOjVV0OPnPiLXCy4K7/S+t6ChyfTPwM60FqrprcUrXve6yHKtnw5P+p/uUUEMEdwqYyTSPtkL9
	RpTgqgJDVHhljMkFHbdDF+fnXQt/8GzWCYfFBc/bs9Izh8sjIAzB9oHv+c+qztkYfurzOs1RjDuyS
	wSQ66JjhHfevvoHl8+Xps3EoYigDf7stTOefAt/whym8ksOfiHFZeuA+F22OrQCz53ZS3o+LTIXVV
	b9rX4pWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nduoP-009KTz-Ln; Mon, 11 Apr 2022 14:14:37 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nduoM-009KSC-Ti
 for linux-nvme@lists.infradead.org; Mon, 11 Apr 2022 14:14:36 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 8FE9AB81193;
 Mon, 11 Apr 2022 14:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8714C385A4;
 Mon, 11 Apr 2022 14:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649686472;
 bh=JOslBT7qbfETTiqyTp3BES0vvEBQPaA/7suTmLtHOds=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=huJH5OzhYVkbFNkocEMHd9fQLK/g7nbg8FBEs4ksM3sVD8JHxYRcJ0cca5FnL8xKz
 FR21qbzD0ZvFasv2zMjcFuKOZsoEGXXEuD8fa2J/+Q3Lf6AXS8fTo1k5wINSfLoF4s
 uuebfNWLouwf4m5kxmSFsLD80q+4lkltHYkj/kKYfDb0+qvaGCn+JJPz20oj1An/RC
 h+XAkIygkDZ4afLPTMLTxZYuo9DDleaM4Ydh2WAl6cNuWlrKvamwb+j1uiOML6Twb3
 9MDMxbP66HkexvlJ/Jds3LcLt4muW2D9TzdZtJ4C9r/v+E586YmeluMzaKoW7OihgW
 ASaJ1lhXUn96A==
Date: Mon, 11 Apr 2022 08:14:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/3] nvme-core: don't check non-mdts for disc ctrl
Message-ID: <YlQ3xWkZNKcMvvOU@kbusch-mbp.dhcp.thefacebook.com>
References: <20220411031249.5158-1-kch@nvidia.com>
 <20220411031249.5158-3-kch@nvidia.com>
 <20220411061301.GB14797@lst.de>
 <34d61434-27cd-f918-a3bc-fdca3196ef99@grimberg.me>
 <b5dd1bb3-e001-ac66-d461-4d699a2dadd6@nvidia.com>
 <d86c4a83-ac9d-f0b1-de41-5d411f5444f3@nvidia.com>
 <20220411121209.GA21711@lst.de>
 <63d1842c-35d7-e482-21c6-57cab24ae83f@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63d1842c-35d7-e482-21c6-57cab24ae83f@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220411_071435_154536_6C499313 
X-CRM114-Status: GOOD (  12.27  )
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

On Mon, Apr 11, 2022 at 12:40:22PM +0000, Chaitanya Kulkarni wrote:
> @@ -3101,9 +3101,12 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
>   	if (ret)
>   		return ret;
> 
> -	ret = nvme_init_non_mdts_limits(ctrl);
> -	if (ret < 0)
> -		return ret;
> +	/* only check non mdts for the I/O controller */
> +	if (ctrl->tagset) {
> +		ret = nvme_init_non_mdts_limits(ctrl);
> +		if (ret < 0)
> +			return ret;
> +	}

The nvme pci driver doesn't initialize the ctrl->tagset until after
nvme_init_ctrl_finish(), so this won't work.

