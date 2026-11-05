Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BFF606D812
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 18:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CiAeLHyA;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e0Zf1xR7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=DbVXtjmXEidjKGQfwT1FS56vvbuAVEYXJ6jbibWlecU=; b=CiAeLHyAyr/BKiCVKyboHiQNG0
	9kTsKsgJ8ZBtjQW9xZ8iZVxcjx3oRs5yXH0kbfY59ijyeiG5YLDWd2LYdWB1LtmIxaHFqNr1r+eXX
	pbZXu0pdvDj5GW9D4n1nbFvOXZfYcCvMelRXZTQnysIjRCWRg312FKoKYiAa/LWnkHdNp76NlKu3G
	vlc3WA7WECJVOWGvkenwiRDL8+0EAZeN09cLesh/9yRJ/diqFjx98n71B9O9kkn5Nv7/SbAwVMA6N
	8onC8ta1fZFxbmesxvwrd+SGifh2Pm/GWAZdjyWc9xU+mz4Cb5ryJab6kwvFww0drzx2aDt+BsWlo
	iwk/Amhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP2QH-0000000AB8p-2X4w;
	Thu, 05 Nov 2026 18:42:54 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP2Pf-0000000AAxw-2id7
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 18:42:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 69117433EB;
	Thu,  5 Nov 2026 18:42:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3BA1F00A15;
	Thu,  5 Nov 2026 18:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793904135;
	bh=DbVXtjmXEidjKGQfwT1FS56vvbuAVEYXJ6jbibWlecU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=e0Zf1xR7dRMzFDFTHUtoIE+NpuR4mSHskw2E5CphOe7jmB9j6B7W34yLw2x0/zdjd
	 eQ2TVjkcC2AeuPP8BcEoqeukxvx9caP021CXYe0a1NgKFgUoCQMV+ZnrgkzgPmfXnL
	 vcQT8meDFEuxAunwISS1dS7PLfIVbVKxSN7XGPupO8QlSdwU+3vwK/jujaia60Eazf
	 gTFeNsE7kL4ycLnKocIO90gGZyeXSFCduzXrD0DqLlN9l2d5tFmj5fOcnPRPmGpRCM
	 0ifGm0zpx8P3kxmNLaReE8oCGvVWvuWKEmM0dW0wG0Wt1VVgKLkSN1haX0nQPyK2gi
	 iO5Hv2ygzI8ag==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 02E7DCE0897; Thu,  5 Nov 2026 10:42:15 -0800 (PST)
Date: Thu, 5 Nov 2026 10:42:14 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Qiliang Yuan <odys.yuan@gmail.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] srcu: Add list_splice_init_srcu()
Message-ID: <493a0897-c117-4517-a3a4-6d84da9d30ae@paulmck-laptop>
References: <20261104-bug-nvme-remove-ns-srcu-v2-0-feb64ecb96ca@gmail.com>
 <20261104-bug-nvme-remove-ns-srcu-v2-1-feb64ecb96ca@gmail.com>
 <9f8c94ff-29e3-4ea5-b9ec-b04b2bc21b1c@paulmck-laptop>
 <5b0e7c55-72b1-410a-982c-a62138b9e44c@paulmck-laptop>
 <20261105074554.GA17781@lst.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105074554.GA17781@lst.de>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: paulmck@kernel.org
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 08:45:54AM +0100, Christoph Hellwig wrote:
> On Wed, Nov 04, 2026 at 05:46:45PM -0800, Paul E. McKenney wrote:
> > Given Qiliang's response:
> > 
> > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Thanks.  I assume you're fine if we carry this in the nvme tree?

Please do!

							Thanx, Paul

