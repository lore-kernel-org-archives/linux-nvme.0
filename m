Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6994C4707B
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jan 2024 21:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xnCOhdyXK6+lWL1nPb+oietQ6zE0QFA537kX7sK+VTE=; b=ZeByjFEikSWcpYd4Q3/Ig10LNB
	wDJiY9XtQMgtJ4CbjgvdCo87QxD3hfIbYMxtz5yh/4A5JR/zA4TTyZI9DUjgrQdVYG4d+5sRVYQ9o
	SjRNRP8nnJQnbWdgiYWZR+DG0nQXllm99KQ9jV+8oTFRrNYdjKr+CnNqgCNT/N+6ZnKwCDj5Da9UH
	84ZygKuNdItHnW+WLfEw00zw5NNXtD/pa82kQs8zdIWTIbY8hvBr3TDK8w3be3kBEs9401/c11F+M
	LDiiRFpg7h1xiJZavDm1QkUnrxOGdfEUcZm318wxQPLu4DRn+JVVMaksLUueJoUsmjTa+956rKosK
	VOMs+smg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNgHE-00EJ6N-2F;
	Wed, 10 Jan 2024 21:38:20 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNgHC-00EJ4j-0L
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jan 2024 21:38:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 30219CE1DB7;
	Wed, 10 Jan 2024 21:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE424C433F1;
	Wed, 10 Jan 2024 21:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704922695;
	bh=Zj4PU9X2lr+E4Sz/jaxm1avAQhMyb8QtGJxKW9gk18o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b6m3SX+a4T02uYh/9j9LKAc+JroGrpwwx/6mAkD9gqf8PgypSJz9RZX6HlSOQdQSd
	 +T66EuTFfg8Azgo3bDf3JbqMQMP+RU1K9jnmODay6CTmUIT/2B3aatHfJXyVGN4QBJ
	 fUGrpRC5p/6egwBmUQEd5dJr5sfvZIQuEIWnwOTnenwF1nnQuRo76fvF+xfApiM+Kd
	 ufj5IBOeEnVFsTDcGSFIyNoCGFw2OmtByD6I+2LT4Zm0ZRMukpV7+iQW6R6+CudxRI
	 lhGJKZEkaAFv+wfQ3sLIdJzgmQxBqgaSTeS6Hh90lopq2IcfpHhOKImknCKtM2o/Fl
	 0t1iofbjDik4A==
Date: Wed, 10 Jan 2024 14:38:12 -0700
From: Keith Busch <kbusch@kernel.org>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Hannes Reinecke <hare@suse.de>, "hare@kernel.org" <hare@kernel.org>
Subject: Re: [PATCHv3 0/2] nvmet: avoid circular locking warning
Message-ID: <ZZ8ORFxYnrEBdOlh@kbusch-mbp>
References: <20231208125321.165819-1-hare@kernel.org>
 <lg3wdiuk57fveobxy3vwttujrcbgq6zyggqhipntqdv467dxd5@7dl44oec25cu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lg3wdiuk57fveobxy3vwttujrcbgq6zyggqhipntqdv467dxd5@7dl44oec25cu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240110_133818_325020_89C38FE7 
X-CRM114-Status: GOOD (  16.89  )
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

On Wed, Jan 10, 2024 at 04:12:16AM +0000, Shinichiro Kawasaki wrote:
> On Dec 08, 2023 / 13:53, hare@kernel.org wrote:
> > From: Hannes Reinecke <hare@suse.de>
> > 
> > nvmet-rdma and nvmet-tcp trigger a circular locking warning when
> > tearing down; reason is a call to 'flush_workqueue' when creating
> > a new controller which tries to cover for the fact that old controller
> > instances might be in the process of tearing down.
> > However, this is pure speculation as we don't know (and don't check)
> > if there really _are_ controllers in shutdown.
> > And even if there were, that should be short-lived, and would have been
> > resolved by connecting just a tad later.
> > So this patch returns 'controller busy' if we really find ourselves in this
> > situation, allowing the caller to reconnect later.
> 
> Keith,
> 
> Could you consider to upstream these patches for kernel v6.8-rcX? They fix
> lockdep WARNs observed with blktests nvme test groups and rdma/tcp transport.

Definitely, I knew I was forgetting something. Patches applied now for
6.8 and our 2nd merge window pull request will be issued today.

