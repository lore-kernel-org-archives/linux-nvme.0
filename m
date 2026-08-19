Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CE4C5DF81
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 15:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/AbQ3S8aGxqK5iofr0fazeU2d3tOj7rvF9ihEQ/lF/I=; b=QFkIzAoDTymyxF6h+itCE7oE0o
	dXJWz+/g4WXkxda+XTqNC8v2v85tZaADLDhW6M1rylmZvR6RBhFqeimXfZoE3SIZc5WDHuHDwifmL
	KJnLrAt+S6kGtIdyPmTQ0gSzfSvfseDnJaq3vkYdaTjaTGPJooDtMZovX/94CtzmtYSY8KwhQIKsh
	M5dv+bi3te/Y0UC4AWlE1z3KFZMWZlz3mlG4xvRhpFgbmcpmCFebfYeFHC27oxhAgU93G4Rfgql6e
	Xn6/nCCrVoR/MGWuOA6UPujyInxNztSIWMhvXS84heS+SHO9FBPvL3PzKXwnfLAmZY5UKE8TzqunD
	yU6m/jiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwiIp-0000000A6Nk-0CFd;
	Wed, 19 Aug 2026 15:34:07 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwiIn-0000000A6NH-3UvR
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 15:34:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 95BE6417B2;
	Wed, 19 Aug 2026 15:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C721F00A3A;
	Wed, 19 Aug 2026 15:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787153645;
	bh=/AbQ3S8aGxqK5iofr0fazeU2d3tOj7rvF9ihEQ/lF/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mDKl7uBA/FuXOmUr/2tkodSU7lSxppXUzNfAo/aomp4B97OZ0oZTwEwPopwzXlcld
	 ZL0Im0m4kQP4VKUJ7P+KuqOHu+3xWfNwrq8auqEMEXabNWCJFgcn+1OW2lIj0W9Dat
	 j7SlE72PvYTaXYhHKgWRGbc/aRo6r6jCultAD1sJRoeLdKn9DAyF0LvLw3Ptv/+9yj
	 EtiEmrJVIDrwkoxqvYBheUyL524x3jRuub1bPk3k0WqPMjAZ5iCSMCSmaE0FrBzu7X
	 beLMMv1eeh7COMH8nb8kPdMy6lImkv+pfAkWpRpLo+Rqm+b2WE8io4c5H68IiE39Rv
	 2LaJYSMNeyfFQ==
Date: Wed, 19 Aug 2026 09:34:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: raoxu <raoxu@uniontech.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme-fabrics: fix DHCHAP secret leak on parse failure
Message-ID: <aoXM61XULtnUeVg5@kbusch-mbp>
References: <66356C8F993780EC+20260813083107.2078333-1-raoxu@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66356C8F993780EC+20260813083107.2078333-1-raoxu@uniontech.com>
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

On Thu, Aug 13, 2026 at 04:31:07PM +0800, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> nvmf_parse_options() duplicates dhchap_secret and dhchap_ctrl_secret
> with match_strdup() before validating the DHHC-1: representation.
> 
> If validation fails, the parser returns -EINVAL before the temporary
> string in p is assigned to opts->dhchap_secret or
> opts->dhchap_ctrl_secret. nvmf_create_ctrl() subsequently frees opts,
> but nvmf_free_options() cannot release the unassigned temporary string.
> Each rejected option therefore leaks one allocation.

Thanks, applied to nvme-7.3.

