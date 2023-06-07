Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E878BC77B7A
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 09:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ki87ibK1tm2wqzFPMXWkJl7nWoKXWybi7GQjVNJ+V5M=; b=aRxbEBRBTNt2VDEV0zT7McrOTw
	Oc9Et/bKg6puZscW67kzC2R8gZQRz6PaCMp0OdWWJ0YVkJPm6cM4dXqIIUpcZPPhmaXI818NwabN8
	fGJJLncjKlTlqEtY3Rbh7Lid4lwl7lR2diWKsCAE6385cbH5NEx1Mwq9+BPT8dXftA7P2UF21MILg
	Y/RP2ERqwilDnhheJR77MP2wP15v9QuhsERqyVV6CjK9BS7Mokw4r/6LdDOpyaMnO+LiAvDIQKqdV
	m5UOfhkvBgeCLk4fmmy9Q/PIBFKhMXI0M+NgPbUOByHLc8jr0TcFl+I0OHOUjA8d09JuATk5h0xSP
	eiZZjZeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6pPg-005EKO-32;
	Wed, 07 Jun 2023 09:25:08 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6pPd-005EIT-0R;
	Wed, 07 Jun 2023 09:25:06 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A27A160EF2;
	Wed,  7 Jun 2023 09:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA78C433EF;
	Wed,  7 Jun 2023 09:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686129904;
	bh=PVPEiqQnbOrHGRENvLEdaR/nzeey8b8ZshNSuWbTzrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ALdNOSLUKbyG4MtN9g4NY65h2phNBq7vkw8myPQgpJG2PzaM8f/SVslVCmF/QOc3T
	 Bwp8JuH17KAppuZAf9ArpxZTmb2lgZ7cED8j2ebPZYTj2IOo1Pq/kE6GkpjP2srCxN
	 XuLDkhy5x7omz7gFdxwTAPV7lc6Gdyrkd5NATTyExP7JIaWtEnHvRju/P8W1jwC/ZQ
	 pgr661S3TGnNa0/R8XJs7I9augkFB3fO/k2xICj9Rw66l5DVIPYSNCIJVnNMEfjw+Z
	 gguliFEjC8Gq4dp0LyuKCQZnO9AA7rkPsqLnWoRqyaIZ4YpfwuJwZivsVp2KmUYvZJ
	 O4+xhtnOR9qOw==
Date: Wed, 7 Jun 2023 11:24:55 +0200
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
Subject: Re: [PATCH 30/31] block: store the holder in file->private_data
Message-ID: <20230607-verjagen-weise-4fb3d76a6313@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-31-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-31-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_022505_211683_CBCD547F 
X-CRM114-Status: GOOD (  13.85  )
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

On Tue, Jun 06, 2023 at 09:39:49AM +0200, Christoph Hellwig wrote:
> Store the file struct used as the holder in file->private_data as an
> indicator that this file descriptor was opened exclusively to  remove
> the last use of FMODE_EXCL.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Feels a bit odd to store the object itself but anyway,
Acked-by: Christian Brauner <brauner@kernel.org>

