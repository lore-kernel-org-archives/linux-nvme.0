Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C02C77B73
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Apr 2023 21:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/0cMP5VccIfGVFM/dGvyuiP9dxZuPXkP3s+v7mAwVow=; b=Z1qLEOeVEQLuc/LW/0kcIxk1y6
	YqjoRFxTge9Y7RDzoy0YjrfyDtitqVat4/yZ4CQ9PpCXVcyfYjbk9l0p1DPuq21TDmwiidip/8AFF
	tWDV0JrRRvGsaUXQINiLxnjbZyk+kngEl9JbagBtpOa2pz6KxqDVsN4ssQqerMgAkfmXlAwz5YsvG
	QZ9Pus3Y47NWHczyxsjm97zxGuwN64R2drps9iNEGkLcuNejRgs2S2Bwemr5DsPTtlNj5rUvdGgOv
	kditUayNqWiqoJxBhL+0ZaCmjqISPnbazGP8Xvu6ezgbNNYQ+wVflFoQ4r97IZ8MMyFyVnOMiK0E4
	6nUZiHqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ps9MX-007cUm-25;
	Thu, 27 Apr 2023 21:41:13 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ps9MU-007cU8-0l
	for linux-nvme@lists.infradead.org;
	Thu, 27 Apr 2023 21:41:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 96C8163E18;
	Thu, 27 Apr 2023 21:41:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BDCC433D2;
	Thu, 27 Apr 2023 21:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682631667;
	bh=ttxh+0owlmTxQ7HiffezNZYNtnW2YAU7ftOMiXd8Qu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r0ZYQXM+hfWSMQUAHomXURnSPlTVaEXEJjpFpyuXLVAXnDz+Pft1dnGxtvJtm37O1
	 o5LGEc0BC4ZF2C7JqCTEMvRBKe6l31X2dGEvpm6KIZtCiwGQN2w7+h+RKQef3C2PHA
	 R75LbkdhKOUGR8hgOzlDgbjC+zpTtKZz9NFeDFTOyej3QXffgfNUFOx5mVXqKocMNG
	 a9J2hblTOw5J3w4Fu3kTqBxVpwdj4+HvYREhKDQHlwPPjJhU+DxK8rHjkoCfsyChU9
	 dqnjXfvlwdEpnXp5o26h6wPD5WktjgpF//0KjrTQ/PVuT4SI6lFTWbK4620dfed410
	 bkrlKjpfqe6iA==
Date: Thu, 27 Apr 2023 15:41:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: Wang Yicheng <wangyicheng1209@gmail.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Seeking for help with NVMe arbitration questions
Message-ID: <ZErr8OV5JRpUityQ@kbusch-mbp.dhcp.thefacebook.com>
References: <CAPiksxOuMyosYh0Ky==jfRcgWpGs5-4SxwfxpaLND5kHsOpq+w@mail.gmail.com>
 <528f9679-1b07-f3af-c936-06ec1e316720@nvidia.com>
 <CAPiksxOQsF0-p_pwFQQhG7r5WERrRKv9R_w3Bgxp=qCBcPNc+w@mail.gmail.com>
 <ZEre23NoKOB56eDj@kbusch-mbp.dhcp.thefacebook.com>
 <CAPiksxOEFDjHh4OrkcuBCMe59vf8_CE=AHeCN_+yFCe3_ry-2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPiksxOEFDjHh4OrkcuBCMe59vf8_CE=AHeCN_+yFCe3_ry-2w@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230427_144110_336390_0F711513 
X-CRM114-Status: GOOD (  18.60  )
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

On Thu, Apr 27, 2023 at 02:21:21PM -0700, Wang Yicheng wrote:
> Thanks a lot for the prompt and detailed reply!
> 
> Before asking for further clarification of your answers (thanks for
> being patient with me :) ), I'd like to sort out one fundamental
> question first. When we're talking about configuring the queues
> (default/read/poll), is it really the software queue or the hardware
> queue in the blk-mq model (figure 5 in this paper:
> https://kernel.dk/blk-mq.pdf)?

We're talking about hardware queues.
 
> I've always been understanding the configuration procedure as
> distributing that number of queues among the CPUs. But as you pointed
> out, if I only distribute 1 queue as default, then the cpu_list will
> contain all CPUs. It gives me an impression that the queue type is
> really about the hardware queues. We don't need to set up the software
> queues, as they're automatically affinitized to the underlying
> hardware queues, in order to make sure all submitted IOs, whichever
> the queue type is, don't need to transfer across CPUs. In other words,
> if I allocate all 3 types of queues, there will be at least 3 software
> queues in each CPU, corresponding to each queue type.

Each CPU has one software context, and each of those have 3 possible
hardware queues. Any given software context may be sharing one or
more of its hardware queues with another software context.

The set of hardware queues of any given type is fully affinitized
to every CPU you can run on.

