Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2CCCD6E57
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2026 15:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LxZaES6QzKJciwH+6bxlgoIAWhn5EPiEaviksyyXPJY=; b=AAFVAx5dM2SdntXHA72ikfhMIi
	4EzU2x6Yd8pRsLBDDWjo8Zu666u91rDoPcgDqXzefa22pDTt3o6o/3Ikdjo46OtDlTH1No77IPRpk
	LH2IbgewYKp/OneJHKue7icvbIF+QS68dnRr3CCyLnzz3LsHlV+1YkrLLmjhAiA7RqntExZYC94/3
	l/zmeyx/e87ow7auDipQSwSsbyDrss9NuhEHdsdDGMfHTRkHmZHhRnQxJY8OW8ffljaK18TRjyCI2
	9ZDg7ly+3gCPOasVwxedukL8Yt/gIOMSCPkGMh1Pr+2HLRCI0FTDP+VPB3UJAav010yYpQ6i3HmM7
	0MudS9tA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUQqO-0000000DHva-0NSJ;
	Tue, 02 Jun 2026 15:15:52 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUQqL-0000000DHv5-3EOu
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jun 2026 15:15:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B0FAD60123;
	Tue,  2 Jun 2026 15:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E341F00893;
	Tue,  2 Jun 2026 15:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780413348;
	bh=LxZaES6QzKJciwH+6bxlgoIAWhn5EPiEaviksyyXPJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Uoztegv+qozYXlC6oNk1quA4Ackno4FHkPnjiQUnU5XVgDzQlNiOtWyom1xxC6Kx4
	 gnugmhdnBZr/t4MpGvmbp+Mf24NclAbQDPu0e0Ww1Wfzj/RU0lL7cYyYptM1SGIRT7
	 InzSaOMjn2F5dP2bZ+WViuiDLx6/QCAjv36nTGVHYh+krsC1ndYS7pogbn4OLhC7xE
	 wB34gnu2W0gn+1nAhodLp4hoDTWma7LuGVVFccBQXF/jgYApbo9qf2P/OU0Xpg8LgX
	 AXFO10v4qm6l3JMUWVQ4jOCE/HMR4ZnlLsTS1PJA24r6lEZC7GOuXWvY8Ov9jsBow+
	 I31k5oU7A2SJQ==
Date: Tue, 2 Jun 2026 16:15:41 +0100
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Chao Shi <coshi036@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>,
	Maurizio Lombardi <mlombard@arkamax.eu>,
	Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH v3] nvme: core: reject invalid LBA data size from
 Identify Namespace
Message-ID: <ah7znSpPM-H-ACaV@kbusch-mbp>
References: <20260515185853.2761456-1-coshi036@gmail.com>
 <0938b6f8-8001-4fcf-95a4-327fa9077163@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0938b6f8-8001-4fcf-95a4-327fa9077163@oracle.com>
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

On Tue, Jun 02, 2026 at 02:10:07PM +0100, John Garry wrote:
> On 15/05/2026 19:58, Chao Shi wrote:
> > +	if (id->lbaf[lbaf].ds < SECTOR_SHIFT ||
> > +	    check_shl_overflow(le64_to_cpu(id->nsze),> +			 id->lbaf[lbaf].ds -
> SECTOR_SHIFT,
> > +			       &capacity)) {
> > +		dev_warn_once(ns->ctrl->device,
> > +			"invalid LBA data size %u, skipping namespace\n",
> > +			id->lbaf[lbaf].ds);
> > +		ret = -ENODEV;
> > +		goto out;
> > +	}
> 
> JFYI, this is giving a C=1 warning:
> 
> drivers/nvme/host/core.c:2411:13: warning: unsigned value that used to  be signed checked against zero?
> drivers/nvme/host/core.c:2411:13: signed value source
> 
> I can't seem to quieten it myself, though.
> 
> BTW, I would have thought that check_shl_overflow would catch
> id->lbaf[lbaf].ds < SECTOR_SHIFT (so that we don't need the extra check).

I see it too. check_shl_overflow has checks that suggest it was
expecting a signed type, as all the < 0 checks don't make sense for
unsigned. The warning seems harmless, but I'd too like to see it
suppressed.

I think it's odd that I'm not seeing a similar error for the similar
usage in generic_check_addressable() from fs/libfs.c. They look the same
to me with respect to the types passed in.

