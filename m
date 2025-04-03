Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8782DC3601A
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 15:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JwtUWZPs7Rgg9uNNC2BwLnm9a3szpFt4CYz/ZpxSEwU=; b=oWXOu5TCeDjq991nB6R/rgIMvd
	p6ctxH/baCAlYmR01q8bDKW4aQnNzGUJjCTLztzMfQc6UO4TL3tmToe6CdevG2qQtMtATVV3E89GJ
	1FJOEiYxh77KbIdc6x41Vnps4pOGB7MVTy8xGawTzZb0uh4uornPk8uEN6tqJh3bb4D9oWybf444R
	NMWe/m19WrT+uiRHXhSbxDbdpUiOBeQUp35iNHI74PNyzxwZNdr6MH0kRZZkfeezFEtadRKAFsdIG
	2Aqug9SaPG9uhPrtlivEc37pCoaHTH/TZy38932KoBENiuNvYjmgjnLfqNXY6P6PxjLjcoKxpfLKu
	1wn7U6zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0MlJ-00000009GqM-0F7t;
	Thu, 03 Apr 2025 15:45:49 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0MkU-00000009Giq-2337
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 15:44:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5609C438FB;
	Thu,  3 Apr 2025 15:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF92C4CEE3;
	Thu,  3 Apr 2025 15:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743695097;
	bh=qVlOBpLIrr5IFcadVQ29Yx/Hff/WI34RmWkZdrABaiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UN1JBIcp8T1sgsVRUdBjD7BQSXQidWfmztTTpX+/oC7a5ODXWTDkOi2gxI9YgCUtk
	 Z/JiyNuBWZP1l7petcBvgXXnq3epYKy11u7IuImOYaN1AXj80wm7O6YuXrS3jKfNAi
	 9Eqsy8ScaSQNz18shlWM8Ywqib4SYFqog5r50hpvLMlG08nn+/7jh0ahAx/3WY1bMU
	 xTqJXWPmZuMpBauu0ACwxghsVSWNIPtqgd2SFdGMO+bEYNAQeyXsg1L3ytLcK/Zkmp
	 /1Bj6afPear8JgzFpyyZrCQUIJR6o1v7dwfEQK0qvRQc2e3IOigKuAlKKiVawNq+o2
	 ZWUCST+bPc13Q==
Date: Thu, 3 Apr 2025 09:44:55 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Lennart Poettering <lennart@poettering.net>
Subject: Re: [PATCH 1/2] nvmet: make 'readonly' setting configurable
Message-ID: <Z-6s9_rE-qAmhn8w@kbusch-mbp>
References: <20250403144747.43043-1-hare@kernel.org>
 <20250403144747.43043-2-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403144747.43043-2-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_084458_543756_384A103A 
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

On Thu, Apr 03, 2025 at 04:47:46PM +0200, Hannes Reinecke wrote:
> +static ssize_t nvmet_ns_readonly_store(struct config_item *item,
> +		const char *page, size_t count)
> +{
> +	struct nvmet_ns *ns = to_nvmet_ns(item);
> +	bool val;
> +
> +	if (kstrtobool(page, &val))
> +		return -EINVAL;
> +
> +	mutex_lock(&ns->subsys->lock);
> +	if (ns->enabled) {
> +		pr_err("the ns:%d is already enabled.\n", ns->nsid);
> +		mutex_unlock(&ns->subsys->lock);
> +		return -EINVAL;
> +	}
> +	ns->readonly = val;
> +	mutex_unlock(&ns->subsys->lock);

Not sure how people feel about the "cleanup" constructs. If we're okay
using them in this driver, this is a simple use case for the guard to
manage the mutex:

	guard(mutex)(&ns->subsys->lock);

And then you don't need to worry about unlocking.

> +	return count;
> +}

