Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5DBC001DB
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 12:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xlFqPtBp1vBzQv1h5qus19EOFNx6WvMWPcvOHF2b+WY=; b=JdQI/uV3Acy5hTEMwEA3ur4GOs
	jtMrAYscaJyHeznxyUScC27GDOiDqNYisbRUdjKoncYQtfglBcuE9irMuWLbODMG+P5p5UdFJKPeG
	twDoTk+MXOhh7KzyeMA/JFlIpDkIHkbkzgN+N7nLXkXHQ0JRcmK71uDo9U8Kngew3wQ7Z7WmodIKC
	2TI4gTm+8lI7nwctUbyj6nhRofTLinB+DVvsuQBUGZt5Ny/Yxx1W/9DkyGIDKInaYlSSSEUV/zPdp
	YEG4S9k8fgkhm7qF7Os6fHE5juvTgGqKkb8PRnSJ21NRNwXQcFtsJ4scLR5PRb9PnGt4m2434BPtN
	seH0ruog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU4rJ-007cRB-2p;
	Thu, 10 Aug 2023 12:33:45 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU4rH-007cQU-0o
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 12:33:44 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2C6B21F74B;
	Thu, 10 Aug 2023 12:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691670820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xlFqPtBp1vBzQv1h5qus19EOFNx6WvMWPcvOHF2b+WY=;
	b=ax4cA1aBE7qr9zLRXIuNEeeH0TweZAGa2BqnecbM2LBKW64Hjmx0A1yzGACHUl7g8DGR1d
	prwQyj5OQMMygTT3QLR8vv/MPsgWSjj/+qEhnytqiBJtpxbPq9rA5sGgrvHXFiZLCYNAR5
	8qJUXgCj3IMTShLMDDZyl5CZ4n9C5VA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691670820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xlFqPtBp1vBzQv1h5qus19EOFNx6WvMWPcvOHF2b+WY=;
	b=4ewME7U09iMeg1w6M/N284HzOsMKwg+7FleCDvV5pD1iUE8S0B5NxyhRyBN8pB365AmyQ9
	suE68kWgXdunXKCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D6A1138E0;
	Thu, 10 Aug 2023 12:33:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id wvwVByTZ1GSJUgAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 10 Aug 2023 12:33:40 +0000
Date: Thu, 10 Aug 2023 14:33:42 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>, 
	Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH rfc 0/6] support traddr as dns names for ip based
 transports
Message-ID: <bwyn5dqbfvdl4qx7vc6uh5m4zog5c4qttcrhm3rtim5prp7j32@sxtxgnp2no75>
References: <20230724092023.708335-1-sagi@grimberg.me>
 <1032f160-3307-0405-9b68-b8f6f5b028b5@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1032f160-3307-0405-9b68-b8f6f5b028b5@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_053343_435417_CD7A092F 
X-CRM114-Status: GOOD (  24.28  )
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

On Thu, Aug 10, 2023 at 03:03:46PM +0300, Sagi Grimberg wrote:
> 
> > Currently nvme-cli is able to resolve an ip address from a dns name if
> > traddr argument was given as a dns name, so it does that and passes down
> > to the kernel the resolved ip address.
> > 
> > However, if the dns resolution changes over time, the kernel will not
> > be able to reconnect because it has a stale ip address. While this is
> > not a real use case for nvme subsystems, it could be a valid use-case
> > for discovery controllers, where the resolution is made from a dns
> > name that may load-balance/failover over multiple endpoints.
> > 
> > The last patch (7/6) is for libnvme to pass down the traddr as a dns
> > name if the kernel supports dns queries.
> > 
> > The inspiration was taken from the nfs client that does this for
> > redirects or locations discovery.
> > 
> > It is an rfc, so feedback is welcome.
> 
> So I get that there is zero appetite to support this?

Sorry, just too many things at the same time.

I think it makes totaly sense to move the resolve step down into the
kernel. So I am all good with this.

