Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7022EB64DC
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Jul 2023 14:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+FKQQkDQTRqv35Sqvx+xi2JqY8r+E2YX0UKObnsiIWo=; b=eR5Y5tRPDKc7mqw2qxzCUQtfnv
	lyPGszDFZr89TPJGGgECh4q32dqH06YYgAiwb666XkgHS5klIzuSa1iaMoNl4tnSmJYpe5i2GfmVO
	LnIogN6RobBpLD9k/3wGZ5K1CtFFhvxHgAo08x2hpWF1anVYGpEsQoLIwvFqCG0JDUde9Y+uow/oN
	q2vvmnuMyuFATTXRoG1FfgKVzWInD4Kdx8UHjvphkJnaSAMaW5uAJQMOn1xJSlPe2E/X+aJma/Bq2
	DPX3gdrqgYw32Bikw5EjzRCy88qxxBVmqtm5orVRvctt3VhLicyE+Y+7ekxHVAO0s45+OXEp0SVTn
	mMp//wmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qMrSU-00EL3D-0n;
	Fri, 21 Jul 2023 14:50:18 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qMrSR-00EL17-1L
	for linux-nvme@lists.infradead.org;
	Fri, 21 Jul 2023 14:50:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id ECBCA61CE8;
	Fri, 21 Jul 2023 14:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE46C433CB;
	Fri, 21 Jul 2023 14:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689951014;
	bh=HxvP9qwzVXvPydklMJxjI8bn17kFxn3qJ9hluGqcBFw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hoxGc3Cw1i8K8D5k4XplMTkRAq9/LrA/DzDu8xxyn8dXLN/VuP8ajnu9WI902q5I6
	 /a4TctMIp9dYzqn19hU7QvsaiwM8OmEX1PB/t+NcYbicGPhUPkXgnzD9ngi7o9RCi/
	 GH/t50nZdkfGhk0W4T/j/tVIJYeaiuOg9X17XPDOAwwKypkirFI8RJVSWQ2Gz+EJaB
	 xHqF2coagCMcfPPaCuLRJGfH8anFeNsrLCBkRtvUcvEv7K0yJZ1EbWxsEuWE2jvE7M
	 n9ldFTvCNfnYU5xkzlYmoMxfoGiDFUenblDX61kkxcax//warLmwmItv7JEWGj0TWn
	 Yylu0hsLPQBdg==
Date: Fri, 21 Jul 2023 07:50:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Boris Pismenny <boris.pismenny@gmail.com>
Subject: Re: [PATCH 6/6] net/tls: implement ->read_sock()
Message-ID: <20230721075013.0d71e21b@kernel.org>
In-Reply-To: <a3184117-751a-c582-6295-f45a26398deb@suse.de>
References: <20230719113836.68859-1-hare@suse.de>
	<20230719113836.68859-7-hare@suse.de>
	<20230720200216.4bf1bf4b@kernel.org>
	<a3184117-751a-c582-6295-f45a26398deb@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230721_075015_492787_AED51B6C 
X-CRM114-Status: GOOD (  14.10  )
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

On Fri, 21 Jul 2023 15:53:05 +0200 Hannes Reinecke wrote:
> >> +			err = tls_rx_one_record(sk, NULL, &darg);
> >> +			if (err < 0) {
> >> +				tls_err_abort(sk, -EBADMSG);
> >> +				goto read_sock_end;
> >> +			}
> >> +
> >> +			sk_flush_backlog(sk);  
> > 
> > Hm, could be a bit often but okay.
> >   
> When would you suggest to do it?
> (Do I need to do it at all?)

I picked every 128kB for the normal Rx path. I looked thru my old notes
and it seems I didn't measure smaller batches :( Only 128kB - 4MB.
Flush every 128kB was showing a 4% throughput hit, but much better TCP
behavior. Not sure how the perf hit would scale below 128kB, maybe 
the lower the threshold the lower the overhead because statistically
only one of every 4 calls will have something to do? (GRO coalesces
to 64kB == 4 TLS records). Dunno. You'd have to measure.

But its not a blocker for me, FWIW, you can keep the flushing on every
record.

