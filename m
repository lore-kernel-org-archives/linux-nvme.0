Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBFEC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Apr 2022 19:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6MAy3UFgN4IrlavPGZBqUj2zjwwSWFZ9ONjl8Iyipe4=; b=Ie+6NtE1pBiecdf1ooNYWjNq+u
	4Q8qoe9wcN0MTEnR5+2HGLPjN0FXLRi8qKMVcNXwJaK3f4Jk+CooDvpLtw9s5WWhkMkRRoVrC4Gkk
	UiM8aqQm+hZ+lNGz3PjJUJhfHeJvBCvkE2KbxCDpFdHIGhjx+zB+wpW0SVDGDRDK1YdiBIQCXsZDf
	ENH5XF6+GtmGDAkRJF6qKnTWDmeX3GveNOgjil6D051YQ1IPgTBXbppVOn7PN98H+Q4jUSIjLzpH0
	n/A+Iw2fY2grJXmYZ/208Qkb1k+5T6obzRJ77VEKRSKInfxw1HOBlkBKzqGrr9BDSgLyjvQyGeqVM
	dKAgHuQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nhc2z-00EjNC-RS; Thu, 21 Apr 2022 19:00:57 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nhc2x-00EjLh-Fd
 for linux-nvme@lists.infradead.org; Thu, 21 Apr 2022 19:00:56 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 48E4061AC3;
 Thu, 21 Apr 2022 19:00:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2E8C385A1;
 Thu, 21 Apr 2022 19:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650567653;
 bh=GjNur7Zc+sWMo43ktBfW0od1D6onVHf6SJKIYaaHDT8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lV00wwuB93ERK+CG8h6ABn8PDjDtZuyo95hV8sptKBxivGyvnikGuBwfTUo/GCvAm
 /dHYd9uNbbBmh0555W/qfnYD36KnYQiciBlwCOIWKsH+8QjsQ5mjKO1ryCdDwYF72O
 w2KQ2ipaAZd1lv9+1Vmpmesm7ip/9YS68zkIoIJBHHF+PLBrvKEHGsWB7zDhD67jOB
 rmyKAm/DvOPun4pDHgCuMd8eRGlrQip4RdOX4Kwj3wdDf6EKLEnmVKFlSORJLWOfZK
 /bLeCnOAkQxJ7Oqkz8ITll93n1tpbh7hlCnnk7YCQg9Hjz0kCW/9gygeOpB+KTohJ0
 d6lZZ4izDQQZA==
Date: Thu, 21 Apr 2022 13:00:50 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Smith, Kyle Miller (Nimble Kernel)" <kyles@hpe.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: avoid NULL pointer dereference in admin queue
 initialization error path
Message-ID: <YmGp4g/V9zkyMWzz@kbusch-mbp.dhcp.thefacebook.com>
References: <DM4PR84MB1590F030A9AF89C6E0E62A38A0F49@DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM4PR84MB1590F030A9AF89C6E0E62A38A0F49@DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220421_120055_597877_4B0B1E7C 
X-CRM114-Status: GOOD (  17.83  )
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

On Thu, Apr 21, 2022 at 06:05:56PM +0000, Smith, Kyle Miller (Nimble Kernel) wrote:
> In nvme_alloc_admin_tags, the admin_q can be set to an error (typically -ENOMEM) if the blk_mq_init_queue call fails to set up the queue, which is checked for immediately after the call. However, when we return the error up the stack to nvme_reset_work the error takes us to nvme_remove_dead_ctrl -> nvme_dev_disable -> nvme_suspend_queue(&dev->queues[0]). Here, we only check that the admin_q is non-NULL, rather than not an error or NULL, and begin quiescing a queue that never existed, leading to bad / NULL pointer dereference.
> 
> Signed-off-by: Kyle Smith <mailto:kyles@hpe.com>

The code change looks fine, but your email client has mangled your patch: the
tabs are not preserved, the commit message doesn't wrap at 75 columnns (see
Documentation/process/submitting-patches.rst), and your sign-off has an
unnecessary 'mailto' prefix.

> ---
> drivers/nvme/host/pci.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 6a99ed680915..2f7510938b18 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1772,6 +1772,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
>                                dev->ctrl.admin_q = blk_mq_init_queue(&dev->admin_tagset);
>                                if (IS_ERR(dev->ctrl.admin_q)) {
>                                                blk_mq_free_tag_set(&dev->admin_tagset);
> +                                             dev->ctrl.admin_q = NULL;
>                                                return -ENOMEM;
>                                }
>                                if (!blk_get_queue(dev->ctrl.admin_q)) {
> 
> 
> 

