Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80914CA5FF0
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2026 13:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4/wTyoWviBH9FYFMU9hHAS+UXzacvHStdtMdKDyWCWw=; b=NZly/9a25yd2sVa75dkoSGXIZ0
	lLSAh0bUJ2HLFDeIr4BNea2/Cpha6IQmRXieTi5uRcM2UiBntMQ8CYat0PiZz5Jgp2Dui5Wgy7FMq
	b1Mx2E8MYrE3I+U7IFEOWrONjXv/J9zxyoQCvXdrN+Woe5EGpjZR7SHlQa2360NAri+8XhIIWHkCz
	++1LReYRH59H9r+yCvtd/yDd+aeZpp/dGC94SzpVYOBgcg8rQVx36huMvVAJRDgPnoS7HKM5hIkua
	xFX+1SdJPT2W1R94wT2Vt0SnLtu/A0jftgaef6rMtiQdDHG/HZuDw+Hw3FEtBWbCQOvo/u4dZZ5N4
	A2erFISQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDiOI-0000000GRmo-3Rw6;
	Mon, 05 Oct 2026 13:06:02 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDiOH-0000000GRmf-3gOE
	for linux-nvme@lists.infradead.org;
	Mon, 05 Oct 2026 13:06:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0289860A70;
	Mon,  5 Oct 2026 13:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917EF1F000FF;
	Mon,  5 Oct 2026 13:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791205560;
	bh=4/wTyoWviBH9FYFMU9hHAS+UXzacvHStdtMdKDyWCWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=igulrpFHuBWTdu2mMZUy5LgF23YQb30zHL4vJ4m3G7oB8PUQgRsZsl3+l/Hk84Rk2
	 TPff2MmN0pdqF7TWyjDTt8TzAS1z49bM8dmtuKrIary+84W6OsF0eqoZrWoVEdWN05
	 Xb96L3iLLhD8H+vjG3k/SrmNmY9DYhcUIC1WRrh+UjPKAoOWjDZ28V9z/HjKgAEElN
	 kKH16+axuWhSNwfqaHeuZ/U0zPoM4CoSHumMV7/nySN21KPLcTY9XRl9rKBr428HiZ
	 NGuyAmPrJZyx01EZ8TknKB+7ER/Z1zHCTRlkA73fLgdZ6gZBJnGoNnzmaegmK8zAYQ
	 1jH60phmUl9MQ==
Date: Mon, 5 Oct 2026 15:05:55 +0200
From: Keith Busch <kbusch@kernel.org>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Maurizio Lombardi <mlombard@arkamax.eu>,
	Maurizio Lombardi <mlombard@redhat.com>,
	linux-nvme@lists.infradead.org, hch@lst.de, hare@suse.de,
	dwagner@suse.de, asahi@lists.linux.dev,
	Sven Peter <sven@kernel.org>
Subject: Re: [PATCH] nvme: do not reset controllers in NVME_CTRL_NEW state
Message-ID: <asOgs1Qm0Mq_ZqT0@kbusch-mbp>
References: <20260915095827.698928-1-mlombard@redhat.com>
 <94912d46-381d-4988-800a-6ef3b595233f@cyberchaos.dev>
 <DLV7F9W5HSFS.1D5WQW59ZEHEL@arkamax.eu>
 <DLV87HMYWE6U.BG10862VYDK@arkamax.eu>
 <a8975c9a-b0c8-41cf-90e4-a770666e975a@cyberchaos.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8975c9a-b0c8-41cf-90e4-a770666e975a@cyberchaos.dev>
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

On Sat, Oct 03, 2026 at 04:22:09PM +0200, Yureka Lilian wrote:
> On 10/3/26 15:09, Maurizio Lombardi wrote:
> > On Sat Oct 3, 2026 at 2:33 PM CEST, Maurizio Lombardi wrote:
> > > Thanks for reporting this,
> > > it seems that nvme-apple is the only driver that still initializes the
> > > controller by performing a reset directly from a NEW state.
> > > 
> > > This should be easy to fix by moving the state to CONNECTING in
> > > apple_nvme_probe, just before nvme_reset_ctrl() is called.
> > Ops, this won't work, as we can enter the resetting state only when the
> > controller is live.
> > 
> > Keith, I think we have no other option but revert this patch to unbreak
> > apple-nvme until I find a proper fix.
> > 
> > Maurizio
> 
> 
> When you eventually propose a new variant of this, I can certainly test it
> with nvme-apple.

Thanks for the notice. Patch reverted committed to nvme-7.3 and will
send a pull request shortly.

