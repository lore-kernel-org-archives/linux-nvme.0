Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06AB6D7831C
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2024 17:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yXsWhcqGTJcBfD9Jb4FBUWsVKdWca0NeY18oJCuuE1c=; b=Fsuu5Cvc4UyK4mRNjT0lSHtnXR
	BjJXsGHaQeV4toWxJHU1yBy31YdOr1533gBcb8UUOvArlKDC744aYPuL010+hzFjoZZSrStEst5xz
	2hM8cHNt5tqSorbzi97bxZdclsbd2ZaRUG5s9Hg3ea3Zr7M5UquKNLk029pwc5idaC1ncrEXoMyFz
	1fTEr1mVpn2WHcheUfYknLX5+M5T4z06UGEkqtn7eRTxA2CejcBIDj/xvsGLR2qTDPF5qFPBMUHcH
	eMtuRnRSZhUPdTY4k1KoVQWo+JdDeeYVZMmH+G+iJFCkSvaYvGYAlJ3JSkncF6+nmQ7lGsuKl1W1H
	GVDasA9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIAe9-000000075jW-28Kd;
	Mon, 02 Dec 2024 17:55:45 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIAdS-000000075YI-1ll0
	for linux-nvme@lists.infradead.org;
	Mon, 02 Dec 2024 17:55:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 3848DA41062;
	Mon,  2 Dec 2024 17:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C911EC4CED1;
	Mon,  2 Dec 2024 17:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733162101;
	bh=VHb/6xY+v6/rZnae7NXwGACWJAlRr1Z80bhzCqxV3WU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U0LWvQswQH0VIbSFxrtgpD4svAjKl5H0CC3qIFwjEV5F+/cquH8XdFr9cNY2ExkqR
	 5te5OgVaSk3+v9KaD/Se/gABq1/DN1cy9D0h4+7hRW3kwEIv4MVFAa77oYEoCOIC/j
	 QjnJ+UJzNtSybjNy5I3fkWD/Yuo11vF2v4005B3rm4svWpSDlMCi18MbEsdvOFKWNO
	 N0stE4JLVkWw9HpSTaq1YYKWbC18YN6qfcz95iSXwKvjy6maFLO45I8kvMqFPuC00O
	 j42LS1G+oYRhaxz/RpTNgFUyyyBRPOEMiaR5iwk4OzeGEBr+hl2FSczkp5oXVDhaZG
	 6n2Re2LjLFSVg==
Date: Mon, 2 Dec 2024 10:54:58 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, axboe@kernel.dk, linux-nvme@lists.infradead.org,
	Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Subject: Re: [PATCH] nvme: don't apply NVME_QUIRK_DEALLOCATE_ZEROES when DSM
 is not supported
Message-ID: <Z030cuQOvjtLm-hT@kbusch-mbp>
References: <20241127064218.42688-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127064218.42688-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_095502_521168_F721CF0D 
X-CRM114-Status: GOOD (  12.16  )
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

On Wed, Nov 27, 2024 at 07:42:18AM +0100, Christoph Hellwig wrote:
> Commit 63dfa1004322 ("nvme: move NVME_QUIRK_DEALLOCATE_ZEROES out of
> nvme_config_discard") started applying the NVME_QUIRK_DEALLOCATE_ZEROES
> quirk even then the Dataset Management is not supported.  It turns out
> that there versions of these old Intel SSDs that have DSM support
> disabled in the firmware, which will now lead to errors everytime
> a Write Zeroes command is issued.  Fix this by checking for DSM support
> before applying the quirk.
> 
> Reported-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
> Fixes: 63dfa1004322 ("nvme: move NVME_QUIRK_DEALLOCATE_ZEROES out of nvme_config_discard")
> Tested-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks, applied to nvme-6.13.

