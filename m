Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A09DC7EE29
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 08:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9STpoUfPiaJfNFHkPs28XASF7HUmFP8clXa7STdAnUc=; b=cr/wGHTEXBzNG9lJc8ZYNjUNpm
	jG06Do8dzJUvy3zTC/TLuWeo14K94qASzX8SY0cTGXKtwYXzpxEHC/K6CUtcv9gsM/6PO2JRQOJzu
	dCUuivjqfVFsMllHZJauzk8kOWfueCS/6oy1H3LFWJJztKULtlOStamtfyCix7Y57/EP5gkOB6Njt
	BGIYD0kOM02mFirIGZB1QEiSt+IY/UKv8s7Vi+ZOZKCfm+4CP6Mns8agdgp4s0QmfHKv9oNvqmG6t
	YQuAawQcqBLdHTLgFestIA2IOjEd+lx1d+GQUm87yFSzgrGvXKaHMX9LbbQ/KwBm2uM+HZ669fMTG
	H+1KeJMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6oLx-004usJ-38;
	Wed, 07 Jun 2023 08:17:13 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6oLu-004uqg-2v;
	Wed, 07 Jun 2023 08:17:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4E6F76323F;
	Wed,  7 Jun 2023 08:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3257CC433EF;
	Wed,  7 Jun 2023 08:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686125829;
	bh=9STpoUfPiaJfNFHkPs28XASF7HUmFP8clXa7STdAnUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KgvCdUlx7knAQBUAn0H7V0CHr+U5wKzNYfkSnOh31srONfBoFE3rthoW+sKdJZ9a4
	 YOy5KoOxOhCOxG1Md9F1WJ17Yz6b4wswcJZy/m8QeAdjkAj5Jotv8hKeB3pCZHkLRV
	 HvxU4gBwAzz6gL7m244wkkZ6xIOpvzxUTOtLDuM5hMUaeXkTRULIc9m/meDk3tnVW3
	 wQsKgJoM5NU2AlnhWr/FpFNJzRr9asvfMeuaYnRGzuZaTlKQLm7qRzm72SkzE/pc41
	 In6xnqpqiB/kTsU7Mq8HOCQP9YgBx9DS6w8b8Z+MfP3x2QDTjz2GNC6K2x/+6+l9vq
	 0TsDj4ON224+A==
Date: Wed, 7 Jun 2023 10:17:01 +0200
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
Subject: Re: [PATCH 03/31] cdrom: remove the unused mode argument to
 cdrom_ioctl
Message-ID: <20230607-testfahrt-posen-960b2a98b78b@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-4-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_011710_979041_EA10CD85 
X-CRM114-Status: GOOD (  10.24  )
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

On Tue, Jun 06, 2023 at 09:39:22AM +0200, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>

