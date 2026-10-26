Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84647606A31A
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2026 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=iJQ2wfKw;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e3pHktym
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=UKhKJA7Upf7g7MgSplueJZ4shpOyuGH+IGoxjZnLmfQ=; b=iJQ2wfKwAiFt8LabJvWeca99S7
	+Vb19DwcSM/HsiU10yZZtg0psNom+ZP5STcaqwgLYr1btWsVOtPTB97gg7ZoYki9zwJESgwsyOt8j
	PdD4In4D4wPyAS8yJPC8dGtjrMLVrp1t0wa6DVm4s32biGhi3AgRweIWJDNk5gCs3ouc67DDLMobV
	b/3wn3ckOu6Um6YWC0bYCbr3RfHiuPNndf8AbTveZBw1rdLeiZNY1sfMAzM7p8kvA44cZS5f2JoL5
	b2e1xlLFQhMIqfijZlTkkioaGzkiXbT4AMcF9wEAI/aIvGK+MhkgRGeT2LZcx710BlgwbcGES3Xe7
	bpvJ02gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLN8U-00000002oGC-0uft;
	Mon, 26 Oct 2026 16:01:22 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLN8S-00000002oG2-2u2h
	for linux-nvme@lists.infradead.org;
	Mon, 26 Oct 2026 16:01:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C002C601EF;
	Mon, 26 Oct 2026 16:01:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD0B1F01825;
	Mon, 26 Oct 2026 16:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793030479;
	bh=UKhKJA7Upf7g7MgSplueJZ4shpOyuGH+IGoxjZnLmfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e3pHktymeODIHvdpdhZEhii9Ywy1dK1KekkX2LY3xV4jtEyDKtkTxN1E/sgFvp7GT
	 exVzfBGgkNVhjiXahiVcHr2RQVJLmEwFKQGWHFNmKhdAhJXGKaQS7eSxh72U8C1kEw
	 RXVLQ1Vb16MSRuHsXQ3uysQCpLktDB+IFwWZlz8nEzm7ytVt/uvvOpKwP4w5qcuFpU
	 I6EYoOyv2YhP5+jxmykjLIrq477hSoRwooGufH3dDXANgyD5TV4bnSWaeNyHIsY177
	 nfNv78ZmbKsrQVY71eZyw13sep/Q8zc4FR8xomJR2lg9t28tD5asuuSDRfMxygr9dr
	 8HXieegGQ76vQ==
Date: Mon, 26 Oct 2026 10:01:17 -0600
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-fc: Tear down the association when the admin queue
 allocation fails
Message-ID: <at95TevyijBfLYSG@kbusch-mbp>
References: <20261026104456.3672246-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026104456.3672246-1-kanie@linux.alibaba.com>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 06:44:56PM +0800, Guixin Liu wrote:
> When the initial admin queue allocation fails after a new association
> was created, nvmet_fc_ls_create_association() only drops the
> association reference, which frees the association.  By then the
> association is already on the target port's assoc_list, though, and
> removal from that list only happens in nvmet_fc_delete_target_assoc(),
> which this error path never calls.  The freed association stays on the
> list, where later lookups and the port teardown can access it, and the
> target port reference taken at allocation time leaks.
> 
> A remote host can trigger this reliably with a Create Association LS
> requesting a queue too large to allocate.
> 
> Schedule the regular association teardown instead of dropping the
> reference directly.  The teardown removes the association from the
> list and releases the target port reference before the final reference
> drop frees it.

Thanks, applied to nvme-7.4.

