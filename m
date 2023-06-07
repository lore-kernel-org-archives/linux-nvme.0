Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F456C7EE29
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 08:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fth7Mcf9w66lWjcDd1L7tMhBqO2W8s0BJhTPJr0Hbxs=; b=zlB/N8nJwRaLkiO6wNQ/PU/bdO
	QHpayAPcLK5NKmATbgOBzgd0Y3RBYyvKSDbrhk7DAHS3e9YP8JBsSlRZc9A9n3UbouT67IBcXqUOY
	RpQ2LmL9ZMKU48DqW+/cdG/4Cg0zK8xYg43KvuCdOQv8+Qz7SP2OhnFSaVCvOocxaZvhnEg7xkUE5
	IelCejZvIpW/W0X4mpkcEVZPmYY656LV806o5KGllxcFYlVbEJvQsL7j+u3+fuTPXKvXH/0Zb1jeh
	I9bcYWv2bGlbkI2NFGCq7nODinG3S6Un3b45IJzNeAw3EMh+ZQAFOjQPVtfdiMNwKePJf618MTUHt
	KQW8lONg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6oTv-004xEV-0W;
	Wed, 07 Jun 2023 08:25:27 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6oTr-004xDX-2n;
	Wed, 07 Jun 2023 08:25:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 517B1615B0;
	Wed,  7 Jun 2023 08:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F50BC433EF;
	Wed,  7 Jun 2023 08:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686126322;
	bh=MlK8ImDSCelGPFiPL92Uyz1xTZjxqRsNNJXefAB4RxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RJVQ7IElXButGpfihgaGTsX+x2U783OB0x7LjcjEuzbvCprkRssPlCqitXbv2qS80
	 7bXHij0rDiyQmVWntSpVgswo1pyplWiVLnxddjl4YEuW7xtVVHP1gtfSYDSzKshjbd
	 cg5VxGDoq3Sq//o6lEqRihRJL3wnpkC2VFrT+3tRPyfE8Rm3QEIGgrc8Zst/2xza1A
	 1dLzlcWhE45pPOZvKsENsCth7zzXVyiw7PbzjT4UN+wZmWKKt2oJ6bg8vrxwu+KR+0
	 hQ+ZzeZhWReHgfkAb9X57t7f3jFG0+rfua8y05NfHnXWIf5wyGJUIy3C7/vBVqlnz+
	 EWD5OnJTGdrhQ==
Date: Wed, 7 Jun 2023 10:25:14 +0200
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
Subject: Re: [PATCH 07/31] block: pass a gendisk on bdev_check_media_change
Message-ID: <20230607-chefsessel-angeordnet-269f0596f9b3@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-8-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_012523_946546_9344FD37 
X-CRM114-Status: GOOD (  12.97  )
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

On Tue, Jun 06, 2023 at 09:39:26AM +0200, Christoph Hellwig wrote:
> bdev_check_media_change should only ever be called for the whole device.
> Pass a gendisk to make that explicit and rename the function to
> disk_check_media_change.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Under the assumption it did only in fact ever only get called on the
whole device so far,
Acked-by: Christian Brauner <brauner@kernel.org>

