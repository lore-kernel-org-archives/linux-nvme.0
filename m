Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADB8CCFA03
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 15:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yIGPQs2J2I5GR1V9DDnfQHJEKjl+FvWjBxeEWlzMQHk=; b=qp91eH1L1m3piFwVxrYl+eUoI8
	i1Bip9jfPgZfn6yDM6VtzgjPfEsF/79l/0wwF31B8QCJM7nltlzuK0J30QFYDVSD1BSrPeafa5U4e
	LAt2c/IQAwKJdxy4nWpQRDnfZKwRM9ffEch29iyrvFRJnYoccwkrHORGapaIbJhfQwcD4RLrvoXF1
	/YhLMqiiVicy0JfkzXFQkul+M0Qw3Ja8W2QkFUMq0kj1RmUnpIDeOFMZ+fF+7QzL7zCLu+6t06YDr
	m6fJSsQ6o/w3MgCG5OhT4yikAWePERI3iyYGuKwf9XhZDWjFd1kSyY3td1wfjol+Y6901cywAZIUt
	YDzZiDjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFwaP-0000000AAna-0Gg2;
	Mon, 03 Nov 2025 15:35:13 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFwaN-0000000AAn3-2u0S
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 15:35:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 13979419B6;
	Mon,  3 Nov 2025 15:35:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BEAC4CEE7;
	Mon,  3 Nov 2025 15:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762184110;
	bh=ImJ//mDQbM/LMM7z7pXqCqtgUa74uvesZLwSK6CrM1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jcJFdc8lJzW32uq5AiVTw57BVPbXruH3nUu++kPQK33fFLW9T6zo0dmJFh1Qa3I2C
	 TvgXQFJTsEg1HPLvMs+SsjqZjtZocw8Pm/ZkZbBKlScL3np25P0VinVCqMBO4yNRwF
	 RPpv/2Qm7AkXJEmn+gI0hKitR4FNkXbmJaBjsiN98TJscJueH6nPoCvqfxmAf4SuJ2
	 LDX7vbovv+Ucbi6gfHYlsmbQuHaFo28+SmEOU9OGEw9OPj4mgkHDYNvHA1sgchwbhH
	 La4a3iS2LpcUA3oNN3wy070bGEf3ixgt0wL0VpNWSqsxNvjHFJzU+3JVWHueg6qLyv
	 TVvrpLLuYx20g==
Date: Mon, 3 Nov 2025 08:35:09 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: hare@suse.de, hch@lst.de, linux-nvme@lists.infradead.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] nvme-keyring: mark nvme_dhchap_psk_hash() as static
 inline
Message-ID: <aQjLrZ5zXWrUtMGI@kbusch-mbp>
References: <20251102031701.69920-1-ckulkarnilinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251102031701.69920-1-ckulkarnilinux@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_073511_753384_546AAC88 
X-CRM114-Status: UNSURE (   9.92  )
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

On Sat, Nov 01, 2025 at 08:17:01PM -0700, Chaitanya Kulkarni wrote:
> Fix build warning when CONFIG_NVME_KEYRING is not enabled:
> 
>   include/linux/nvme-keyring.h:57:4: warning: no previous prototype for
>   function 'nvme_dhchap_psk_hash' [-Wmissing-prototypes]
> 
> The nvme_dhchap_psk_hash() stub function in the #else block is missing
> the 'static inline' qualifiers that all other stub functions in the same
> block have. Add them to fix the warning.

Thanks, applied to nvme-6.19.

