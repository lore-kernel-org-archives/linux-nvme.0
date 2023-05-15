Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA76C7EE24
	for <linux-nvme@archiver.kernel.org>; Mon, 15 May 2023 17:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7IzVs9eNHBWQypJIF5R5BhxI53mh373cFgKokzrC5tY=; b=VGqXccPe8xUZOzxGtGSHMRxqKk
	Lqs+9mrvaNElTO6u1dDyHDW6QkD42oF6IcO5C/PSTT12xTOw/h9niAiFa1r/3SKYsQBgPKtAXJ8Ad
	qOmTgTNzpbgJdJj9t8V+mrjjiJqsHN0D0aSzRwa775sjpcmAG3X4BflvS7dgDyE35T5pcQc91KH7M
	sGknmBvTLYqE7JkdXLtL9FtzUmUFxGVkuZtWxfV4hqTvWB70PZNNJcr4nfD9BtrHSTk3gG60G+CsL
	FEjNg4UnPMWruiYIvSvTDR77Pv0abDzf7DQHq1nt7V1oqfPkWewiLhu5WFm3kjApsJhquz56M5QrX
	v/3ptKlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pybkz-002tAU-0r;
	Mon, 15 May 2023 17:13:09 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pybkw-002t9c-21
	for linux-nvme@lists.infradead.org;
	Mon, 15 May 2023 17:13:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id DDB5A62B92;
	Mon, 15 May 2023 17:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C439FC4339B;
	Mon, 15 May 2023 17:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684170785;
	bh=7IzVs9eNHBWQypJIF5R5BhxI53mh373cFgKokzrC5tY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Az7+9MSZshh8thj5fwryxQ/82RYk1rGAY0RvT/CERNKU0cl4pe4aq+bOXSVRRAObf
	 Qk8M9r6oEh13H5Fq22aBlmCH0w+0xsNYEJWLUSzRaoRg25lGryOZAUzfNlo5bgZsEJ
	 zfBRUeRJ6uQh1pjwRq20Z83iKYkSgiOfd2X9mSnJ1L14ZyxNXS1bmYef/lzne4zTnj
	 GNuJ2DNz7Sp1qi+pAa9tyM4LiGuXqJP93vXJp6I6F/AmRCyG5G6rS+lhBtBxZ5lWcr
	 RydbRm8KAzmhEv4tT+pbBH8QaMUvPmj/7NnlZCJARhzSbNQbbLRADzvgE7f/VVR0f5
	 cG4bxE1g7SJRg==
Date: Mon, 15 May 2023 11:13:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/5] optimize some data structure in nvme
Message-ID: <ZGJoHnLalEQFD6c9@kbusch-mbp>
References: <cover.1682941568.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1682941568.git.christophe.jaillet@wanadoo.fr>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230515_101306_701142_3D61AC66 
X-CRM114-Status: UNSURE (   7.77  )
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

Thanks, applied to nvme-6.5.

