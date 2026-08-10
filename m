Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88653C5AE49
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 14:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NNQptlJ2Y8APAajBlBfwKR8a2d7FfQ8UK2xX4LPzHrY=; b=Av+Q/7/B6RGkyfnk9ERGZRX5SW
	NcA1mLmbbps2iXY3L0ig1BIUlOXraDzTh0QZPZiS6u6zINChY2D1Dxy+05paDcrZ5g3yjodZxRTCL
	9u9IYsb85wgeU/DHxV+3Dy17r1DhdYbZJIOxoFvpbd5iyAdOsxus2eWcYQoOxGRjksanGkGWzE55A
	cHgQ0XXGGoWP/1hXlE9QUKQAbKppQGedoX9j7Pjq1ociuNEnFu7VBEiQFYJHfzuMCcgewt8zNI/TC
	j4Z5JZui0A1SL8JaurWjm1TpJqknTJWtjLc/5ohDXGDmLY71xO0y56wLgDv0v+rMcXCvtWwA9QazR
	0AXNCQXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtR1J-0000000C0yI-2ihE;
	Mon, 10 Aug 2026 14:30:29 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtR1I-0000000C0y5-1Nbf
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 14:30:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8F4AD60A5B;
	Mon, 10 Aug 2026 14:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7301F00A3A;
	Mon, 10 Aug 2026 14:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786372227;
	bh=NNQptlJ2Y8APAajBlBfwKR8a2d7FfQ8UK2xX4LPzHrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fPLFUTHiwbIUAIGWMyrlpROLaFLePKYgn3PHZapFwC9ds+v8Z12pAudrw6hKcAO65
	 Zl8pefNKn1xLOb19D9A6PQaoisiMWbSA3fG/jGWOTmSI1dpqjhNQG6jy594D5Dv8hq
	 OmVlLL2cpqpAtdTrojNc4+0ZiLCEyyykC4c/LXPEzddUoY3VEVuPh+DcngiukOrEPf
	 fTO1a3ezRY3YVbglbqvRxTfFfv46sI4FkdOPuzgdgRlBEpEUrtOu8M76XKW+jx255g
	 +41ZvZiQ555DeObBvj6bipLFfDhRcTDPu1uh6+OZbi/X4h4eQxJazwr1U3fg6rB8la
	 tqY+JLFT2TL8w==
Date: Mon, 10 Aug 2026 08:30:25 -0600
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: hare@suse.de, hch@lst.de, dwagner@suse.de,
	linux-nvme@lists.infradead.org, mlombard@arkamax.eu
Subject: Re: [PATCH] nvmet: fix max_qid race between configfs and controller
 allocation
Message-ID: <annggXmP2yS47QN4@kbusch-mbp>
References: <20260810133301.52537-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810133301.52537-1-mlombard@redhat.com>
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

On Mon, Aug 10, 2026 at 03:33:01PM +0200, Maurizio Lombardi wrote:
> Fix this by protecting the queue allocations and list insertion in
> nvmet_alloc_ctrl() with down_read(&nvmet_config_sem). Because
> nvmet_subsys_attr_qid_max_store() acquires down_write(&nvmet_config_sem)
> to modify the attribute, this safely prevents the configfs writer from
> modifying max_qid during controller creation.

I think there's still a race in nvmet_check_cqid() such that a command
can access an out-of-bounds index if the target side changes
subsys->max_qid to a larger value and the host sends a command with a
larger cqid than the array was initially allocated. Should the max_qid
be copied from the subystem to the controller that allocated the queue
array?

