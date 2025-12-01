Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD756D116F3
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Dec 2025 17:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XVKPZPYzuV9n44zhykihTf/2gpzfWXkFuNoK4rkLOrY=; b=dmDrpvxPRkXHPrfz+4usaIo5so
	dfGN3Ezc6j/ogQJZeuqZ7TltwF/2Cvh6J7/lhjoAq9kWS7WTaHG+YumLcWXCvJMnOLLBGzw8JbYwT
	pVXzzFrKyd8hgtrdvUTbcGgF2SKoWn2xvsXiovPfvfBR/xdWYEL7S0eHm4GfNi8bkSdpDYt1BDUz4
	9rYgkkrv1Weu4j+FZiHgf1/iSKYT11h1bLkQh8bnA7CllQ4QplzjWNIiJpNTdRKe2jg5Ltr8FJErI
	SwyvyHrQRYrZLBa/PX7zBT277KqXmVpKpX2+hz7E+bOgxNJGV7sOnUe549BGiaFIKA4qgMivjefoq
	TzmuncZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ7IS-00000004KMu-1oRk;
	Mon, 01 Dec 2025 17:02:44 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ7IP-00000004KM0-34t6
	for linux-nvme@lists.infradead.org;
	Mon, 01 Dec 2025 17:02:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7E62D40DA6;
	Mon,  1 Dec 2025 17:02:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31237C4CEF1;
	Mon,  1 Dec 2025 17:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764608560;
	bh=VIrmOK6q4npDWemnHhse2cgv6SH4xFpqQcgJvhjak6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TfGI5P3LmpfzKEQLeISGY4K4kUbwO6aT8b/xS06XiyQqrnGvDCBrgDtBwbPODCwOW
	 oE/+3n+RA7dKO0svaFzQyZnNqGCI00EOkdiwz0vHmLnbeNFZEqqVisspGOy+BLAzy7
	 IyJELA3Z+PlsgJU3AjEU2Ut79ndj8b3USywKR97N4CPqevhfuMjLTwHU1SxaVMvcQb
	 RFB80TV7zs+xm2al8O36tktVATTqRf/uxbYV6rRtxUwTFEec3DH54cgpDzD1nDBkfV
	 CsaTDSs10599pYVxvpMx3/acVGL/tzC3xvFl05oZDY4omo8IlpEZEeh8uPQ5YPmcbU
	 +JO4x0ZbTzNTg==
Date: Mon, 1 Dec 2025 10:02:38 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCHv2 0/9] nvme-auth: switch to use the kernel keyring
Message-ID: <aS3KLi6RerlR_o2R@kbusch-mbp>
References: <20250528140517.3284-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528140517.3284-1-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_090241_794077_91F76861 
X-CRM114-Status: GOOD (  19.42  )
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

On Wed, May 28, 2025 at 04:05:08PM +0200, Hannes Reinecke wrote:
> the current NVMe authentication code is using a hand-crafted key
> structure; idea was to have the initial implementation with a minimal
> set of dependencies.
> (And me not having a good grasp on how to use the kernel keyring :-)
> That had the drawback that keys always had to be specified on the
> nvme-cli commandline, which is far from ideal from a security standpoint.
> 
> So this patchset switches the authentication code over to use the
> kernel keyring. User-facing interface (namely argument to 'nvme
> connect') remain the same, but the key data is converted into keys
> which are stored as a new key type 'dhchap' with a random UUID as
> description in the kernel keyring.
> 
> With this I have updated the dhchap arguments to 'nvme connect' and
> the configfs interface to either be the keydata (ie the original
> interface) _or_ a key description referring to a pre-populated dhchap
> key in the kernel keyring. This allows for easier provisioning of keys
> and avoids the security risk from having to specify the key data on
> the kernel commandline.

Since we got late feedback on this series, I've unstaged it from the
nvme-6.19 branch.

