Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD775CD8CA7
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Nov 2025 16:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=acnorco3r1OWVqxwisFCZtNNuSVKZYX9Y3wyP7m23lo=; b=LSjH9/U6wtqmaEPFcpEUYYitaW
	XDFB7mnWFU4APjpsmn8JttNopjAiXtREJmd7Vzwn6JX7PsQ8SxgZyQb5HWTYwySxZGCZR8MhEw18U
	ZFZMSeZ+ymttHAyZeylGNNgo9ZKBqTg0ntaUbQtH+oIlg+kQOTqE0h66Ep3jTyIW+mtWJ+N/Z/3xH
	e1yQmvRulKLoGG0feURNMBnzLr7zuVRwoxhsk7NQ8ZLGUaHJWwpRGkeuMxlKLxqJrrzVYQ8lEAmQb
	SfLQzq15y65shWwMvSTuABY8id9xLBvgDzmdbVWQQPDWNo6LNvqw51Iegu9rRuiBOrIJcwCKZJ9w3
	vWVSljdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJaMM-0000000AoNL-2SQM;
	Thu, 13 Nov 2025 16:39:46 +0000
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJaMI-0000000AoMr-3ae5
	for linux-nvme@lists.infradead.org;
	Thu, 13 Nov 2025 16:39:44 +0000
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-45030c45371so440274b6e.0
        for <linux-nvme@lists.infradead.org>; Thu, 13 Nov 2025 08:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763051981; x=1763656781; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acnorco3r1OWVqxwisFCZtNNuSVKZYX9Y3wyP7m23lo=;
        b=OeyIhBInVP15BgQL7FNmDn2ebPhhV0iWFHwSHp1fqNJf6vv9kX2H3Sq3ChVcLSa5la
         zQN6J6NB/RUH2a3CgDCsd1Hg7BDm7tRkxfEF4Eahm76f84EV1XilmJaPas2Ns85/1o8K
         +tc5v7Ct/m4GNCOzUCHyFQh4PFtHgR0OS8k1UsPCNysyhoD37R9cNygsCRqWsR9A8b4H
         lgcIn5NAt2oslPi5h063TXXf53Msfd6kL0pMMhh2scBuJ6Y58VN1PZ3HGmE8AgNkYLSA
         Y5zpmaNq3psqnJNjcddZ7/7v2GijXhEeMj6tzipjA8b+2G+pF7tymkxJ8ydmqjnJ+jY5
         QN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763051981; x=1763656781;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=acnorco3r1OWVqxwisFCZtNNuSVKZYX9Y3wyP7m23lo=;
        b=xB3XlUfyx9gLPyYZhPoJ4qDgaOrBltypUsMav3GpRqdVkUd6GZ+ZNO4YN34INOGH1K
         CCBjUXUh4+0sgksKoCYFBB5TC8jYcaqaGLK0ErAj249efS+QWrTEmFQ2jK1vK9H40t5z
         5oEpAWTgR7gPS1MsvMK1Q314IEZO1W3nINrff44hABGtooSOPUDvzsaAtCZbNmkHSzu6
         kuWpjHIfWQi7B2wEdiRtTN0wrrYmXn1+ZnB3ml6pulRZvfqDPlZSwdx/XylGdJWsk9xS
         +AXWUsYNapwi71UHVI9JP92TwNgZpdYBsl/ZSvDSBOdIvHYa9vPu2udLB4rEa6+hHW0p
         uu5A==
X-Forwarded-Encrypted: i=1; AJvYcCXNzTqBAYG+7Jj4V9y1vy18Nmoritq6S8x7nHIOxDE12VqOX1Lk0y1TBgnawadC2O4D/PErH3sXuPnN@lists.infradead.org
X-Gm-Message-State: AOJu0YyvZs67+sLsvoR15mjcl2At0I+PbJzAnbUmCouy9gqBawE3BgYQ
	R2EEEUD3gLpXtIH4Y9H8sZw552SNQWBnjhLx6OAsgo/baStfMgHygisSsiVN60Tnx80=
X-Gm-Gg: ASbGncuYAM9BwgiKO4kw5aiJAvYcS+kjyFRWT0uLxz2RhNwfdMBCyY6octmY+s1Anx9
	w+Wlq2vwlCfQ/N0JtKlOhyvJ1Nuh6rlI4RJ/xVZWPfjUrlGY9PVTWX+755XC3GXtKXVC+b+92qy
	6xE2aU2PSF0d+6kfoocNYDZ/Do0dwbfOLSaoQ9hBRvhuaNK6Df8Fg0p45KNv757vbWmC5gq3EAZ
	+gxs9HdrfeMBEPlUopdX7/OVnEU7NwmILlFQH8tBLF/JT2E2h1b31Q6cHRTDGHAFsSdtyfxW6bf
	/ChW1Tg8bqZiYjpViug5l4v4XdHkkJQ7WTXGaFkR1qDQglWUY4GQqAL7XjctpTJmUX4iE0snaKm
	Ixk7HQFLgRm+2h24oIVAGN3tYp5BXkbLai9RbVi6TYG1K+l3SfTKwzbkosC4rA6dGSPg=
X-Google-Smtp-Source: AGHT+IEN9Kca9UVNMkaDQH4sixh1UDXbVuoaQZrNLuxjjpOlBG92d5Tw7nSUHhmYRwVQ4lVJgFmtdw==
X-Received: by 2002:a05:6808:d52:b0:44f:e931:38ab with SMTP id 5614622812f47-4507454af73mr2995413b6e.43.1763051981315;
        Thu, 13 Nov 2025 08:39:41 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7bd35c5f4sm852672173.61.2025.11.13.08.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:39:40 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Leon Romanovsky <leon@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nvme@lists.infradead.org
In-Reply-To: <20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com>
References: <20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com>
Subject: Re: [PATCH v4 0/2] block: Enable proper MMIO memory handling for
 P2P DMA
Message-Id: <176305197986.133468.1935881415989157155.b4-ty@kernel.dk>
Date: Thu, 13 Nov 2025 09:39:39 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251113_083943_014160_F9066299 
X-CRM114-Status: UNSURE (   7.85  )
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


On Wed, 12 Nov 2025 21:48:03 +0200, Leon Romanovsky wrote:
> Changelog:
> v4:
>  * Changed double "if" to be "else if".
>  * Added missed PCI_P2PDMA_MAP_NONE case.
> v3: https://patch.msgid.link/20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com
>  * Encoded p2p map type in IOD flags instead of DMA attributes.
>  * Removed REQ_P2PDMA flag from block layer.
>  * Simplified map_phys conversion patch.
> v2: https://lore.kernel.org/all/20251020-block-with-mmio-v2-0-147e9f93d8d4@nvidia.com/
>  * Added Chirstoph's Reviewed-by tag for first patch.
>  * Squashed patches
>  * Stored DMA MMIO attribute in NVMe IOD flags variable instead of block layer.
> v1: https://patch.msgid.link/20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com
>  * Reordered patches.
>  * Dropped patch which tried to unify unmap flow.
>  * Set MMIO flag separately for data and integrity payloads.
> v0: https://lore.kernel.org/all/cover.1760369219.git.leon@kernel.org/
> 
> [...]

Applied, thanks!

[1/2] nvme-pci: migrate to dma_map_phys instead of map_page
      commit: f10000db2f7cf29d8c2ade69266bed7b51c772cb
[2/2] block-dma: properly take MMIO path
      commit: 8df2745e8b23fdbe34c5b0a24607f5aaf10ed7eb

Best regards,
-- 
Jens Axboe




