Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D68C87FDE
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 08:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+DwSgaof5Ff9Diex7RS3TTV47dYszHEJKASYIHN3t9U=; b=BgIPyH63GPIOfOsJoNA0Csz4x0
	utlKGjGxyw3Q/8HWivn+2vAZC36IvIWZZOsspN6fZf3NUyQBGLqX/mJ2HS2S7JccpivjVoxFf4V07
	niPjYQ73FwAGzMamGqW9Td5DhsvsBbcC4O+H2EfdtULu7gFJqCM2jIKIklKfIzYDCZozDE3wXdls+
	EGJt/atC2Rd4p/BmynaP/mh5CfP20uGKWNYziyhMLoTbhEVfRAo7FLevz5hliLRTR58UkEN28d7Mi
	OVqCR7826KlBGwfueL4xF6teYtVbH/cGAvsOGsJIwqjoqKiMs3FYe7rXbyHEKsKR36WHYlfJRQNS0
	LxWfPp9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6os0-0053hv-0F;
	Wed, 07 Jun 2023 08:50:20 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6orl-0053WQ-0T;
	Wed, 07 Jun 2023 08:50:06 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5998B6334D;
	Wed,  7 Jun 2023 08:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEBAC433EF;
	Wed,  7 Jun 2023 08:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686127803;
	bh=PZjCdaHviY+RVqpZkaQVixpnvUVrPR62Zf8+mzHD1uk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=psgkq590ELlnR3YewhzuAje3f6nLqAdxD2ks0a0ex7l9AURvWbDqzYkAaTTfQ3LRh
	 lbjVPemFfDSDVxbPW+yVAYbVlRK2mYcGkDU+s9QomicwFqaBsiwabN/y6C+B9XbF7a
	 TUp8gIDqcrYKdDf1/ALLYLXJICKJabskE/hFOC/X2WxRVUqsCWuBbuBtyCKTR3JcP5
	 UshWyePpXwuCBpPQlRL5oU0JjL5XQDDGrzAY9Q4EpVcVDZmW/DwUYrjmVOzW63Jixr
	 ioDpPQD0ktu/OZfW3TlmJmEpP8gCBlQwrZ8iPtiqN0Aky+ak3ORBZqrV1HDSve4xiN
	 ZX/3XM7Ql6s/w==
Date: Wed, 7 Jun 2023 10:49:55 +0200
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
Subject: Re: [PATCH 16/31] block: use the holder as indication for exclusive
 opens
Message-ID: <20230607-umtriebe-absicht-0b2232e4f212@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-17-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-17-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_015005_267101_B3742FF3 
X-CRM114-Status: GOOD (  14.88  )
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

On Tue, Jun 06, 2023 at 09:39:35AM +0200, Christoph Hellwig wrote:
> The current interface for exclusive opens is rather confusing as it
> requires both the FMODE_EXCL flag and a holder.  Remove the need to pass
> FMODE_EXCL and just key off the exclusive open off a non-NULL holder.
> 
> For blkdev_put this requires adding the holder argument, which provides
> better debug checking that only the holder actually releases the hold,
> but at the same time allows removing the now superfluous mode argument.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>

