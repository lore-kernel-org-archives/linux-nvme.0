Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7A0C44500
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jul 2026 04:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V/IDuOkOULpxERfKYNtIRcT8Y6B+PBtsCGeyRszDJiY=; b=Nfe6uiKKjoi0pQ2wqHm4aAphtp
	lMoT3xWZuWCncvtf31DZPfxaTTfBNl2IVi7gbKjIAf7BJq75XBfZ4rr6lt41Xuj+0t75tyL2zyPgS
	wepbLLnm5Kqx71T91eC9QLq2dSEKCGhqYyVoEnztwdbydH44t2U5TzljQM9y9VmTPGqzACs5fMdo3
	/dyWPrOc6qwVjCM/rJWnR8lFSYdkWbIC5XkGh5/YPxatEpeizr/wF6BK5CA25hyMM3dIcKNw5+0n8
	OxUKMjHnh5xE/6FC7yfWWAd4Ljlzx6sq56vWnSbpChzfXkKJunYOdR9wZyAZOj3Glaffgqbw7x/Bj
	1Sd1ZxnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfVBI-00000005xxl-3uT0;
	Fri, 03 Jul 2026 04:07:12 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfVBI-00000005xxb-041f
	for linux-nvme@lists.infradead.org;
	Fri, 03 Jul 2026 04:07:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4ECA3600AF;
	Fri,  3 Jul 2026 04:07:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953CF1F00A3F;
	Fri,  3 Jul 2026 04:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783051630;
	bh=V/IDuOkOULpxERfKYNtIRcT8Y6B+PBtsCGeyRszDJiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NN8S6rnHQfskr2AlUKu//359uBhPBK/70zx27rEM2JidQPnd5G4Nq1SOgiF1bOUcZ
	 F9RJobWoJzgFj/wHAhPOYgWINrkWmSSq2RBMPL28LXx9fb0M3bRP+snQHcUlnAO//s
	 E3vkSs3UYyDfGm70XyBtMRa7n2FvmP6DvzIoaK9nW8QOexe7KcLBS2SrNwMqdtTVzT
	 /M+hUxr9ElP+OxbLLg9jIQ9FwI18/FS5a1yV7ZKGZWO12ZYgQiQTjJYjKAbyEv5iDi
	 hU5nYJSWLeoh4Q2RnMt8wZtoBmoOINJ0Qg1uP1Y/kI/GcOf/h1G5XuRqYl5TX6gihT
	 MqKb//Ui78YTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	gregkh@linuxfoundation.org,
	skumar47@syr.edu,
	kumar.shivam43666@gmail.com,
	kbusch@kernel.org,
	dust.li@linux.alibaba.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Philo Lu <lulie@linux.alibaba.com>
Subject: Re: [PATCH 5.15.y] nvmet-tcp: fix race between ICReq handling and queue teardown
Date: Fri,  3 Jul 2026 00:06:58 -0400
Message-ID: <stable-reply-nvmet-tcp-515y-20260702192533@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702123757.99897-1-lulie@linux.alibaba.com>
References: <20260702123757.99897-1-lulie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Thu, Jul 02, 2026 at 08:37:57PM +0800, Philo Lu wrote:
> From: Chaitanya Kulkarni <kch@nvidia.com>
>
> commit 5293a8882c549fab4a878bc76b0b6c951f980a61 upstream.
>
> nvmet_tcp_handle_icreq() updates queue->state after sending an
> Initialization Connection Response (ICResp), but it does so without
> serializing against target-side queue teardown.

Queued up for 5.15.y, thanks!

-- 
Thanks,
Sasha

