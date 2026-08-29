Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F0CEC61DB9
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Aug 2026 03:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AZJWn7GVJ/iviRGAPjhH0SXCL/93mSrWHjGu2VHL5KU=; b=MFSoHlXf+f2k6sDIQ7YTl4cfSA
	z/ORZybPRzYsescBvJGGipzDNqULpbNGh9MejL08NoDf0GRMZ91w3JTH+RdPF+77iESVO9vJcKBc+
	Sp0gaT4zZS6gHUL/g5CoLdfc6J7f8AbhO+omwfgJDqArWDZ2O04sOsMxowmlBjmADDh2sc+fL/8Zt
	WY2G0vmKTkuPHDSFUvo1deoCLIS51vgDm4cgmj/9myOWCqrcyhzvn++pXkacVZ0ToUQuyxvQU3DcA
	Xk2evOGr81PcMN226BZzdhloaMbhon3kzEXKZqYy2qGZxLWNhTc+fzo9LEflMCy2g6vDojz9W5kWW
	wVUPNcpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x09qG-00000006fx6-1Ai4;
	Sat, 29 Aug 2026 03:34:52 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x09q9-00000006fx0-2wKu
	for linux-nvme@lists.infradead.org;
	Sat, 29 Aug 2026 03:34:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 21E1E407ED;
	Sat, 29 Aug 2026 03:34:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743301F000E9;
	Sat, 29 Aug 2026 03:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787974485;
	bh=AZJWn7GVJ/iviRGAPjhH0SXCL/93mSrWHjGu2VHL5KU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=op+xYtyoYawh/PKfMh+pP02YYvhHqteZ3U5tY2Deu0ilXG7Uozohs0skjz0klOyGO
	 MzVGS5iUw0U7C0QOkPRO/zFv3PSs7oUxxGYLhluaUf3GmIF6briCWDxsTtueRCDOWO
	 5PqAr1hzKduTXxKXh0UeCg9fDazpqchHKvBPBZUr2uAzy9OPzYVKfXSUh+lR9DEVWT
	 dmqabriJO4ZnE1+d/zzseBlhSJXRQOU9p81H8E/VOahXjTpFRta9r0zS8mC7BgnSrB
	 oiiC6ZACHqKR3+yqD0ciBPaKCaiDa6Rs1eK3W5Q3SErWj7Qv/vO7RhrVgQP7Oy5rRJ
	 APNo9c8OgQkhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	d.bogdanov@yadro.com,
	wagi@kernel.org,
	linux-nvme@lists.infradead.org,
	bilbao@vt.edu,
	ryan.arnold@lambdal.com,
	krishna.mohan@lambdal.com,
	christian.jones@lambdal.com,
	eduardo.habkost@lambdal.com,
	brian.kopp@lambdal.com,
	Carlos Bilbao <carlos.bilbao@kernel.org>
Subject: Re: [PATCH 6.12.y] nvme-tcp: fix usage of page_frag_cache
Date: Fri, 28 Aug 2026 23:34:32 -0400
Message-ID: <20260828-stable-daily-0001-nvme-tcp-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827222015.45415-1-carlos.bilbao@kernel.org>
References: <20260827222015.45415-1-carlos.bilbao@kernel.org>
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

> commit 36ac05f7cfd59d90c597071304b14e98090d5dd1 upstream.
>
> nvme uses page_frag_cache to preallocate PDU for each preallocated request
> of block device. Block devices are created in parallel threads,
> consequently page_frag_cache is used in not thread-safe manner.
> That leads to incorrect refcounting of backstore pages and premature free.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha

