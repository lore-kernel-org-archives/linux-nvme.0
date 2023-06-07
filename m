Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5A8C7EE29
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 08:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=idJYnJNs8X8blppL3OUvXfKqnI3BgYcWWssYBP5ZnTI=; b=nbZP+2pKbwRzAzcJnd9oE4d/d8
	Ja7DBwLZSWOLh6WwOS8e8aYmDCUj+QW9KWCQoMFa+N4HxaPyN25240zP/mLUE40kD+0eZfSU3eJHo
	W7cDUkiJK2B+FhoTHL1/lT5S1iDv+528rLxs7De+O3yXnpE6VQ5Z3htUoAoTGqaxPnnF8qXoidJ4B
	adj/vJ0GFnIMyrUXSz8y+88oDKn1vOVxIRfc2Yr9BZXdbtBHlQcLglyevHdmv8MH6Qi2rJ/hzvGQC
	QW8pCCMqvJlT9ECGP77AGEo3M+8tTkA2NWxyfIOA0aEMSe5R7hqq3P0kLCMXxw0mjJeqQIvtYEGmq
	X77wbrUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6oJQ-004u8a-08;
	Wed, 07 Jun 2023 08:14:36 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6oJM-004u7T-0k;
	Wed, 07 Jun 2023 08:14:33 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3FBA863894;
	Wed,  7 Jun 2023 08:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DB1C433EF;
	Wed,  7 Jun 2023 08:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686125670;
	bh=OikN0V0gAjgBP+HPzDoTzlQuNrCoReKL8FDM6o8SWL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LoOtwMsbiODoiTDBOlhy9h+NcaXo/0ty0ho40m0mYf7Tqj+wr2dJZ7vUbOn0Kz7GP
	 33AzVbFt/SH4ZtCqtGcyP4wx2pNr5qeOSz7n5llnvQzbkevHbUBwUChjs8tVFu+w+7
	 9qFZdhkREWPfruOfyuYqVKvgknYU35bmYym5jzuvpMGmp93SMTqsZWFeVhyuiwJkrs
	 LAwyIzU/+kVumnYrd9shzRES4ZrZYHJo9QZXt+wC4ujn3BMrp977Z7B0LOqc0LVlBz
	 8OgzOnLLMWqPSlcCNiFoGKY+/fwNpasAfTm2ssRASquxyIwPgu3PSIm5oXJID8PKnw
	 l3rqMIfCwdUgQ==
Date: Wed, 7 Jun 2023 10:14:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
	Josef Bacik <josef@toxicpanda.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Phillip Potter <phil@philpotter.co.uk>, Coly Li <colyli@suse.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
	linux-block@vger.kernel.org, linux-um@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 01/31] block: also call ->open for incremental partition
 opens
Message-ID: <20230607-behelfen-abnormal-8ccf8e1e99c9@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-2-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_011432_332323_DCCB6727 
X-CRM114-Status: GOOD (  13.31  )
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

On Tue, Jun 06, 2023 at 09:39:20AM +0200, Christoph Hellwig wrote:
> For whole devices ->open is called for each open, but for partitions it
> is only called on the first open of a partition.  This is problematic
> as various block drivers look at open flags and might not do all setup
> for ioctl only or NDELAY opens.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

This assumes that all drivers deal with additional ->open() calls for
each partition correctly which I assumed you checked so,
Acked-by: Christian Brauner <brauner@kernel.org>

