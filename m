Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDDEEB64D7
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jun 2023 17:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qvor2ZTKnEe1NZOyeZ1a4oez2upZaGdQ/KWpD3wcw4U=; b=gagyNKvFw24V9iTD4x6etsZ8cu
	y5jiTFZpQK2rf0e/ewT/Jw9WFEaDKvdKfHRisW4pyIsyrqd3qbL2wydecDDBNvyIqRxe2u/Re9Y9d
	Wg0Gae3EugLZYHZ7qchTx+qGPgRuxit9uWBe3snG2FEFlnMIJSTS0v4RLfsERHn4yDstI+XF7nSur
	6eDXyiNN6cLJOquE75Cx0Cckt2Q0rHXzkxlP2FHO/+10HUhVA820SeDS/00DOupt2eGaVaSpOkiMj
	Sz5omljfPzcQs/auFxLBBYlTKY86J0AW/spM30JHmuuL6x/UW1lwcEhq+JUk6UjyW1WdB0exrVtrq
	RLRvralw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBeqX-00BtLt-0Q;
	Tue, 20 Jun 2023 17:08:49 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBeqU-00BtKr-2L
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jun 2023 17:08:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0E94261345;
	Tue, 20 Jun 2023 17:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB83DC433C0;
	Tue, 20 Jun 2023 17:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687280925;
	bh=9XMSvSviQQ2SqbOXexMPo6NJSkzOB+ptmGdPgshU+E8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LBzycsSeJaIqBmmfsWAHQDSMYfsY11xUSJnNtaDBtZfnwTQR4vZ0YA8FIKd+MMxVa
	 HC7Dbv4gbB9cVy4WiQTGnG/dseLaBeZZBHD6C88ygRZxzJ4UFsSWG/BjJXNFvxuEOm
	 ryQlCISpVCFED3rC+h5+Y32HQgLm4spvps+P4dDW9pphNFdFPo6nt7Bk7RlhR8C2d2
	 lLE18nZGePBjMOyooDN3AoMZG1ZD/qXZPtHc6d/l5DlOl23J/rxr85WrAaS2AZc+4e
	 lf1oP/mamy1RL/n+cgNDe0NjF1udou3b2iNvZcjnoVibjyieoUI7JWg/c7nzXPK9kZ
	 REdRd4EqffUVQ==
Date: Tue, 20 Jun 2023 10:08:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>, Keith
 Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Boris Pismenny <boris.pismenny@gmail.com>
Subject: Re: [PATCH 4/4] net/tls: implement ->read_sock()
Message-ID: <20230620100843.19569d60@kernel.org>
In-Reply-To: <5bbb6ce4-a251-a357-3efc-9e899e470b9c@grimberg.me>
References: <20230620102856.56074-1-hare@suse.de>
	<20230620102856.56074-5-hare@suse.de>
	<5bbb6ce4-a251-a357-3efc-9e899e470b9c@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230620_100846_806622_57149322 
X-CRM114-Status: GOOD (  15.60  )
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

On Tue, 20 Jun 2023 16:21:22 +0300 Sagi Grimberg wrote:
> > +	err = tls_rx_reader_lock(sk, ctx, true);
> > +	if (err < 0)
> > +		return err;  
> 
> Unlike recvmsg or splice_read, the caller of read_sock is assumed to
> have the socket locked, and tls_rx_reader_lock also calls lock_sock,
> how is this not a deadlock?

Yeah :|

> I'm not exactly clear why the lock is needed here or what is the subtle
> distinction between tls_rx_reader_lock and what lock_sock provides.

It's a bit of a workaround for the consistency of the data stream.
There's bunch of state in the TLS ULP and waiting for mem or data
releases and re-takes the socket lock. So to stop the flow annoying
corner case races I slapped a lock around all of the reader.

IMHO depending on the socket lock for anything non-trivial and outside
of the socket itself is a bad idea in general.

The immediate need at the time was that if you did a read() and someone
else did a peek() at the same time from a stream of A B C D you may read
A D B C.

