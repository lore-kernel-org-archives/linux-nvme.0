Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AE4C7EE31
	for <linux-nvme@archiver.kernel.org>; Thu, 25 May 2023 15:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yCDzj21CfLVCh4y4uoYZaN75mx/cS0V7OtJmKLAFe+k=; b=xo6p42E8DG2gGVun3mWok8O5sy
	byGb1CEv4biTcbvtLpyWmdqsEjTad1aiDxXHirIN81XbTqM+N5sOQGiTfVuToo0ZVyyqDgk0xXZzQ
	MVRb+vEuqgJKpZ7Ydjaak5VLZRKbq9IsG47Hr3Ti/QmiBEwattzl/2/HdjDYDIP+Tdn1IQuOrah8e
	nc22JxWt/VwsSMw0mJ5k25XhldyEickTgzhoF942RazfxZ/cL7P7SiJm5bAEAJSxdrQ0KaWEhSOdp
	h4Zbr0RGAUW5Lt8fMnlcySffq7dthIfl00SU8PFequWL8BSj6xfOeX/3GB/hLtOi81p8WMnP8HZqf
	vjjf8gvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2CwU-00GyYK-10;
	Thu, 25 May 2023 15:31:54 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2CwS-00GyXr-26
	for linux-nvme@lists.infradead.org;
	Thu, 25 May 2023 15:31:53 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 399E6646E9;
	Thu, 25 May 2023 15:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29969C433EF;
	Thu, 25 May 2023 15:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685028711;
	bh=yCDzj21CfLVCh4y4uoYZaN75mx/cS0V7OtJmKLAFe+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dGXtVpXzlOCqqsAzus6F/Ke2NghEfqzHn95D75eJJ2Ye31WVcfuieAA5JoY7IbDkh
	 nk9JvJ8KPWu8chtLYEL+VFmpT9O2CjDfS716XtS4zB84ssHnYiBu8oaW3d+QeY0bCQ
	 RBWQaAs9EPCopB5dBwPvC4Ys1qhtmT2FO1WYzivdRXWcWVKZFB7VHKUuXBdVc6s807
	 XLkhRPKoKGKwaZ0v6DStmGZQpcTC18yWSJ1n8FpINNhTvTP8OKZd2x+2HlghfBqqf4
	 63LstyLRxpgI3c9ylUA4aKQjrNDyqToDA+xQ2tx8fv2nKw6Orvg1aGDo/3lPOgge0E
	 Yd/tvxhTqIt3g==
Date: Thu, 25 May 2023 09:31:48 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Tatsuki Sugiura <sugi@nemui.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] NVMe: Add MAXIO 1602 to bogus nid list.
Message-ID: <ZG9/ZF/dlyv8CsxK@kbusch-mbp.dhcp.thefacebook.com>
References: <87ttw7i6p7.wl-sugi@nemui.org>
 <20230520122350.2232956-1-sugi@nemui.org>
 <20230523061450.GA6334@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523061450.GA6334@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_083152_727960_0AF2E417 
X-CRM114-Status: UNSURE (   8.62  )
X-CRM114-Notice: Please train this message.
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

Thanks, applied for nvme-6.4.

