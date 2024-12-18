Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E35E77184
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Dec 2024 02:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zG/whhhNwLnOVwHT2f1CvLCAZE+XgnbcCpgmM3fSNqE=; b=EjiM5OgKm8/6WfvoB2jO2WXpRc
	ohtms9MMcdfuULO+TykeUjxldg2ingO/6AJy2s2V/L0Yk3v4L/YX6g4ko8WqKysLpj6L03rnSfSvH
	rc5wugDIrQJyDXUXojGZnzN6qItZKjNAl007aMl+iEPrk7L4gW+h++XAh8kP0o3BSSUJlRDgWiekk
	NmunH3Wx0nbResiYtWM+jaq0QxYoyTm5Fw+u3gCl2mxyKioJxmuKj8FhLcG9vpL77NyDrHb2P4G/K
	gXerOF8c/GgqTzLX6hdSbKAwzJqOoDlRp47TkjajFjxRJK7wHeiBps4NHgioGcNQFZKpqpn24nFMo
	1qrvPYZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNjVe-0000000FMaO-17RM;
	Wed, 18 Dec 2024 02:09:58 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNjVc-0000000FMWq-1XkQ
	for linux-nvme@lists.infradead.org;
	Wed, 18 Dec 2024 02:09:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 044DFA4215A;
	Wed, 18 Dec 2024 02:07:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFF0C4CED3;
	Wed, 18 Dec 2024 02:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734487789;
	bh=zG/whhhNwLnOVwHT2f1CvLCAZE+XgnbcCpgmM3fSNqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V6MOC46Gd+klvCb6BOmTrMmJrw+i1YGlzdodWC5IU14uH+u0ta1iPQZZ1UmqAHUwZ
	 rlzioyRjod0vGBluJRIgctxOvhHSQqscj5Vkvhv0GOvBZj2oEKWar0XfHGD1WGSGZK
	 JWn8tjSDAEZcoWAna/ehvixb/zG1YLCGXBP3jMvpnqKMMzr8NiWGzsucsvhG1L99aO
	 9xVSmjE2fVnNAR25jyAUnDTI635p3/Q9CMl0ajT5GL5Q6+9IOdq4YfWt/y4TVKu3A7
	 hJK9Oitw+22qYPSPKRHJpH6hsTa/kweO81dtv4qMFBafqmsoAsFO1HSzt7lAEkRp4D
	 z5j2D7GjGCKlw==
Date: Tue, 17 Dec 2024 19:09:45 -0700
From: Keith Busch <kbusch@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: axboe@kernel.dk, hch@lst.de, hare@suse.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, willy@infradead.org,
	dave@stgolabs.net, david@fromorbit.com, djwong@kernel.org,
	john.g.garry@oracle.com, ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com,
	kernel@pankajraghav.com
Subject: Re: [PATCH 0/2] block size limit cleanups
Message-ID: <Z2Iu6bSbUzl27mxt@kbusch-mbp.dhcp.thefacebook.com>
References: <20241218020212.3657139-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218020212.3657139-1-mcgrof@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_180956_465167_E53065A3 
X-CRM114-Status: UNSURE (   6.31  )
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

On Tue, Dec 17, 2024 at 06:02:10PM -0800, Luis Chamberlain wrote:
> This spins off two change which introduces no functional changes from the
> bs > ps block device patch series [0]. These are just cleanups.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

