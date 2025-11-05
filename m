Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C70ACCF9F8
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Nov 2025 20:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JxQ4rINzRt0aFKhrbRAd4SQkORoqhfjhbj+2OG8vI8k=; b=dHqDsqTx1nwIwofgsa89k5LCR6
	Jz7PJ1FG1pvqwZUU00IXLox4rCSGIALN0bIRhOBLlY7eZ40mVqBGwTbNKCJPjcg9wJjRoO3khp+dU
	6KVP541iVYkPRDJPeSrocp2txPPOsHfTW/RyGc40aigFEHiq8m5rchmwvcUJtbOcrvwU/jx8gjeA1
	wZFbhLFXLbEFSuCByIyz57m1MPoqiSydf22dBX4c55kCmbFjzEazGRSnr1oCUZ4fULQFOoypJgRbE
	/r5JMWjrkpJJwcRcGB1FDtZCcYgaYpwUAWjAlFLy46uyB2O6EmM7aEcNivKbiGTkMzr+VqB5v9Lhs
	MDP2sJcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGkA0-0000000ENVm-0xq3;
	Wed, 05 Nov 2025 20:31:16 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGk9y-0000000ENVc-0mLk
	for linux-nvme@lists.infradead.org;
	Wed, 05 Nov 2025 20:31:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EE26F60220;
	Wed,  5 Nov 2025 20:31:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F45C4CEF5;
	Wed,  5 Nov 2025 20:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762374672;
	bh=11BV4gM/nXkX98nI80IieIzXuOaxZgsxWfF8KScFx4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ACoPZshnw/x9Zy433cjSA0V0gocd2WziW91r7xUQsjIJI7YOCc7ZzUEmf1pifNIHg
	 E73WA4/CEeixnTvZmtL2n6MJU76S3ijEj8ccqrPdUBP/YZp1Yu7hke0tT2FnnSEKnD
	 zJdm9LE8/a6jlYWaDg68QX6sFHOZNi65P70jv/0v9WfU7xwR4E3LQbL9sKpgMuxcDo
	 Dm0F0CzY4kqm2C9Wo5u49ApKjjKdpovu1y3U759PSiq3nSknn5QL0J/FIr+M6lWrOy
	 OaLi267loY4yozjKkMALrFOZ6aem9Wnn07wmNeqH313ao2643TQ6BIDprgXshA4LBm
	 eAGP+xZYx0JPQ==
Date: Wed, 5 Nov 2025 13:31:10 -0700
From: Keith Busch <kbusch@kernel.org>
To: Casey Chen <cachen@purestorage.com>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, ming.lei@redhat.com, chaitanyak@nvidia.com
Subject: Re: [PATCH] nvme: fix admin request_queue lifetime
Message-ID: <aQu0Dqc6L17WplVt@kbusch-mbp>
References: <20251104225939.3641605-1-kbusch@meta.com>
 <CALCePG1FFQUWg2u-RhY4DQ9uVxd3uMuwSdvyU-r-ssm_dQjY=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCePG1FFQUWg2u-RhY4DQ9uVxd3uMuwSdvyU-r-ssm_dQjY=Q@mail.gmail.com>
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

On Wed, Nov 05, 2025 at 12:21:14PM -0800, Casey Chen wrote:
> On Tue, Nov 4, 2025 at 3:00 PM Keith Busch <kbusch@meta.com> wrote:
> > @@ -5045,6 +5044,7 @@ static void nvme_free_ctrl(struct device *dev)
> >                 container_of(dev, struct nvme_ctrl, ctrl_device);
> >         struct nvme_subsystem *subsys = ctrl->subsys;
> >
> > +       blk_put_queue(ctrl->admin_q);
> 
> Wait. Do we need to check ctrl->admin_q non-NULL before putting it ?
> If nvme_alloc_admin_tag_set() fails, blk_put_queue() would put NULL
> and panic kernel.

Oh, like if we call nvme_uninit_ctrl() prior to allocating the tagset?
Yes, I think you're right, unlikely as that is to occur. Thanks, I'll
fold in your suggestion.

