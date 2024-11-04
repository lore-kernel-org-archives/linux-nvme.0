Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F8ED1BDFF
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2024 21:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=djWGYE/kd9Fe4Sbyd5M6DaSP/l6/jDSS051wRB40yeg=; b=lFtM7lX9uLAYn2BfuX32H9eB8o
	Okytft1thzJvTcBIChko9Lwuojzm4dAouWsqw8wJ1ugrAmEvX8RGdGbbKjwv5zlB/6c8hf2Vvgvnt
	BY4G+RTeenGs8BTkiFwdjkvR10U/mesbjgIiEdOIzOitkGkiKQ2jUFlgbaWc9avhB1ukpCnwx8DM2
	FLugx5VuAJR5v0fciN1ycAMSRaeIp5wOm/Ea30GwWjqMPxAhf4j28fpU06N3nQluEKZRGMufQoHtF
	YYYNaddYEf816Uhg9omQqu7q/tQCjsOvl+qDTurhOyEEq4cFvSGibdnBwUvpkouIMxgHjhXt2ln5q
	DJmuz/YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t84qK-0000000FCWL-2Ued;
	Mon, 04 Nov 2024 21:42:36 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t84av-0000000F9s2-2tdW
	for linux-nvme@lists.infradead.org;
	Mon, 04 Nov 2024 21:26:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 3561CA40CD5;
	Mon,  4 Nov 2024 21:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B92C4CECE;
	Mon,  4 Nov 2024 21:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730755600;
	bh=czF5iClM5SFSIks/goyQRZImaFZN55WN+NlJffmJj8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SR6ZZckcJbFTiiKfZU6pXnIlfC509ywE2TYQWPvT9mVReWxVagqamOGysjvsivG5A
	 qQ12c2uLVhanKhGjtGCelNLbVrHqPuR/G/2JL65umd1yXZWj+jkJTQmx4YSkf5f2OJ
	 mtLfHreDMbecRVpfW4slq/lgaDltipH/qptqSJ4mwE4nQKxYULge/NI8dJXLm+ypGo
	 WpE1uRaTtCO5pAqR84coQnHg/hEYb4lBtaZ7eUEMLwZp9FL9Z89sio0XQ965kjU7qx
	 O3OYNumH4l6rCmyToO1tV+aX/vet3c2b8YGBp/sedR5WpUgWqwfqnqLjMPLdrfkBq4
	 +TJC8onVOa3TQ==
Date: Mon, 4 Nov 2024 14:26:37 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] nvme/host: Fix RCU list traversal to use SRCU primitive
Message-ID: <Zyk8DTLbDP2LFdDJ@kbusch-mbp.dhcp.thefacebook.com>
References: <20241104-nvme_rcu-v1-1-ecb19f5c95fa@debian.org>
 <20241104131652.GB14373@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104131652.GB14373@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_132641_880033_11A7636E 
X-CRM114-Status: GOOD (  14.01  )
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

On Mon, Nov 04, 2024 at 02:16:52PM +0100, Christoph Hellwig wrote:
> On Mon, Nov 04, 2024 at 04:24:40AM -0800, Breno Leitao wrote:
> > The code currently uses list_for_each_entry_rcu() while holding an SRCU
> > lock, triggering false positive warnings with CONFIG_PROVE_RCU=y
> > enabled:
> > 
> >   drivers/nvme/host/core.c:3770 RCU-list traversed in non-reader section!!
> > 
> > While the list is properly protected by SRCU lock, the code uses the wrong
> > list traversal primitive. Replace list_for_each_entry_rcu() with
> > list_for_each_entry_srcu() to correctly indicate SRCU-based protection
> > and eliminate the false warning.
> 
> I didn't even know there was such as thing as list_for_each_entry_srcu,
> but apparently it's been there for a while.  Looks good:

Neither did I! Thanks Breno, applied to nvme-6.12

