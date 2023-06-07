Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FC3C7EE23
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 09:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3c7Q4wKRdmA1MQcEV1xnhu6LCilclGTs//lC74QnyLc=; b=C+XlYdmGYIqeELiemQq1/5BpWo
	Nd/s9IFH92xZmOWS5wkfNeQGfMvbcqZZ+wWRfO81Sz/Ly3zn1QKPN//KPDZJqik6jDAsx8n75p4YG
	h1FizLYzfl8rwucFVF2a5etiqJZlGaeiExcoha5K0tHgX5zpotyQKth0LH0d54OLvGGu6PwX4mgGf
	CLLep2rliZZO3gIdOnaaeZMkPgq0Lblnje0hwCyLIIUSFL+WHiqxZscFRsbEaGT8dStCSvhJzIcCU
	OfAJzxjDdJ7C/vyQhEr4Lta3wgjOWt2cK2frymRMKlhXG44GXYXo4xHmvvGCHpSfpwyhQsiZ3whPy
	WNl/wQmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6p4e-00592D-16;
	Wed, 07 Jun 2023 09:03:24 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6p4b-00590Y-08;
	Wed, 07 Jun 2023 09:03:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4DC4E61E0B;
	Wed,  7 Jun 2023 09:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCCDC433D2;
	Wed,  7 Jun 2023 09:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686128597;
	bh=q7AdZhSDALKQcnwiboxtavjTYhFCYH416kEbuBo82ZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LmFv4NUDSWWO12W7cnryBDYV8PpqTiV6m9IiQfaN+Gy1TfavMxnrDvH/1VFaqu0VY
	 pNdbYyRHzF2xHsOOKI87miWMENWlYg9+fsdmVVKTz7wYCo6GM1+2x+3dTWnt7WYDdZ
	 Mcjyuj+xp5weCEAYKk11qk0vTGQUIzOnBLlKJpx07Q5ZRsx7ASXqBbtAW0ZLkT7Ew4
	 zBKVTwzdquqRp3RuennzrpOsYTw2sC0VjBfUPhiyrzzFVaAdPGx6+N+quMH0El0KVh
	 SXVIETbMrhU8sh4IsaqUJwCWqqtEaM+3Y6KO5/S9XwefBpx2SMbZ5aVq7LqHVJcaJB
	 5ShZ62p5oKScw==
Date: Wed, 7 Jun 2023 11:03:09 +0200
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
Subject: Re: [PATCH 26/31] block: move a few internal definitions out of
 blkdev.h
Message-ID: <20230607-kernkompetenz-halbleiter-b8874bc39061@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-27-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-27-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_020321_113715_8CAE0B19 
X-CRM114-Status: GOOD (  11.49  )
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

On Tue, Jun 06, 2023 at 09:39:45AM +0200, Christoph Hellwig wrote:
> All these helpers are only used in core block code, so move them out of
> the public header.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>

