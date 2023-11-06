Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF03C4167D
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Nov 2023 17:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1+dY7OqRej0wErk4Al+LGYdiX2XYEYma/dd8z3B7Em8=; b=UW+TyXXeDRaNi5e3RGOip7v9Pl
	UYxBZdAROQvIiYazUBN0HGJenrZmo1GDxc8hHZtLW0OECsc5+LC9Uqk25UvyEKXWA18OX2jKSkHma
	3PUfG+7nucIgtv4U4VwTAEyafYzMnelmJXiPrS5cAz2JBywgPIfpFRJrcekL5BTgEJQ41GlY99mdE
	y8qNU3t2VHwTTu8Ol/vyKvhitHOXu+LArSHFcYYK96J6zlQGaOUfLcmZa6RTC2iYNqyl2jtjiUAOc
	wLSLIXN4DLc8KxLqtVH6gvdmtEzVbTIYSyPtQ731VX42lPu15Wz7GWujWvD0ghQSXoQCViWYFzyQ5
	XpR4QMIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r03Ds-00HCnp-0X;
	Mon, 06 Nov 2023 17:17:12 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r03Do-00HCn2-1a
	for linux-nvme@lists.infradead.org;
	Mon, 06 Nov 2023 17:17:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8FC2DCE0ADB;
	Mon,  6 Nov 2023 17:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8382BC433C8;
	Mon,  6 Nov 2023 17:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699291025;
	bh=uA332wub2hcb34ZrqTut4ULcLysH6KCzSSoJaIV/gGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YpCuzjYfpD0YpO6j1SOABkxHxHb5adopjQdOIxG6AHSKNbMuQ0LHijC1yA+mj8qwq
	 nfN5XR5D8G5r+njvN6M7tQzpcEnXnyO05Nw7ndZwFXd4qPlJOu9VCdJ5Z71CB8xKpc
	 vbrs2Xl45SGbLXnTpmniaPsZZPZRS+K3j/Lv6B5BSQxf3Fe1hS/gxS06y+szlrZUrV
	 cJbPyG5mfNy6u+60alUi0za2laCo6YdlddpdFVuJ+EyujrX22OXoCup0VpeDYxZim4
	 LSn1z03dAxEgkZwtad2onkmwlue4FCFjXD3LOzK9N9c2Iv/jBUMF6mSynkPUHanpjk
	 dNXPTOCtE/zjg==
Date: Mon, 6 Nov 2023 10:17:03 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] nvme: start keep-alive after admin queue setup
Message-ID: <ZUkfjzzUwxBROsjQ@kbusch-mbp.dhcp.thefacebook.com>
References: <20231024061337.35621-1-hare@suse.de>
 <20231024061337.35621-4-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024061337.35621-4-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231106_091708_704131_087C335A 
X-CRM114-Status: GOOD (  12.02  )
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

On Tue, Oct 24, 2023 at 08:13:37AM +0200, Hannes Reinecke wrote:
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2530,6 +2530,12 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
>  	 * clean up the admin queue. Same thing as above.
>  	 */
>  	nvme_quiesce_admin_queue(&ctrl->ctrl);
> +
> +	/*
> +	 * Open-coding nvme_cancel_admin_tagset() as fc
> +	 * is not using nvme_cancel_request().
> +	 */
> +	nvme_stop_keep_alive(ctrl);

That should be '(&ctrl->ctrl)'. No worries, I fixed it up when applying.

