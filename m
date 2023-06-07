Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A01C87FDD
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 08:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JsXN/EIW6Kqwigw4wGGVknucfkdIsZm79w1pPIMczSI=; b=Iyu+F2dL/bkxvFgm9fgVnVetn3
	Oo39nAnsaUuEmUrHY1lXkB30pnEd22nv9GV1K4hYRoz9NiMCc3HxDPyYM91txDbMHlvEs4S3KkZVt
	L9EX52Wx0VMwg2uLXdMhlNcAM+0zs2v3JsCemT9xYBRMdI2NtXeTEDSRUE33TAm/DjRajSQaXhION
	kqzoamrlIWzPgv0v/0wINUqYqNura1/0NfFDmjk+f03sOb2AwOeVr0+1AAAnxPoQucS5iSP40T2UM
	nbewTGAe5eC2u3hxML2lQHL4i3Q9ZPDWqjxnWPvITwy1Di868liDNLW9Sq1VziR4fq/6FSQ9fU28x
	CGdQHMzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6oOy-004vuX-20;
	Wed, 07 Jun 2023 08:20:20 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6oOv-004vtR-3B;
	Wed, 07 Jun 2023 08:20:19 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 73F3E60F7D;
	Wed,  7 Jun 2023 08:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59570C433EF;
	Wed,  7 Jun 2023 08:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686126016;
	bh=JsXN/EIW6Kqwigw4wGGVknucfkdIsZm79w1pPIMczSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hPo1mXkKxFqrFJbgKtNEIt5ZHiTabb37wMXxLRAIeNRno5DR3AAGuKjp93g16mzBl
	 /3CNbG6uWs3WhElMnvwbqhmSsjjMwZfwrvzM8T673tQGiHisyduOo/76UvFPx8vWHx
	 9lzYUK3IeThBOk9/FedNGybyiwR4Gdt72t9wwPv9e2CIKHXV4qq0pTv7B7QX81SLyf
	 Iw3ISSaMn4rNIW1sjHFDtLvoDLYD8pYgZXmzPWirpoHmn5112xh4jwvgTxtmQ6Wuk2
	 8Bh4MVxCgMvJMsNDaUbaU0No+32RJCdez5rEuCBZAIC/6oUb+6u9qKz1t5j/Vvz6mQ
	 GPTyAfGP21eBA==
Date: Wed, 7 Jun 2023 10:20:08 +0200
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
Subject: Re: [PATCH 06/31] cdrom: remove the unused mode argument to
 cdrom_release
Message-ID: <20230607-beulen-infiltrieren-4cacf9083274@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-7-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_012018_093752_9AB226D6 
X-CRM114-Status: GOOD (  10.15  )
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

On Tue, Jun 06, 2023 at 09:39:25AM +0200, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>

