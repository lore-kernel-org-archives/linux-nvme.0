Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C892C7EE2E
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 08:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nP45w1GQBSWuIBs+JEVqXrMN6ftlLSPjv3U/O/W21AQ=; b=WNOdtqnDmE9Y8ZLwoVIyg1NuDj
	rA+O1KKE2Ou0IXH55FGNQQk3WebHG/AO4HRJYW6JqRLv9mvgF3AVfHHsyJaOAgTHe0YmSwWPAQaqf
	H+UECBr0uU24Wc2/TTR7rJQlsdTPZLVrNCfZIRSvbdvVLxC6tLXg/CSvje39i8EGQ+TgKnYZEo1Uz
	7HrdKriN0V8IPnB4qNuXwzMlvVoXFpy/hOoAn8Q+0Ip68OlMhhKA9UCPoILaXbBQ2aNKOLK9wGb43
	OVucwVln8Jk5AJXeN3hp4z9TXTYNugi0DjjKpJSSOSdiGbns1c4kPeDiVsv4t2pQtD1B7o+o/ZGfM
	AAh9czEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6oza-0056pZ-1i;
	Wed, 07 Jun 2023 08:58:10 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6ozX-0056nY-0j;
	Wed, 07 Jun 2023 08:58:08 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B784863C9E;
	Wed,  7 Jun 2023 08:58:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D982C433EF;
	Wed,  7 Jun 2023 08:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686128285;
	bh=SIZ+eCgOkog+Q4s3tUge5LH3sx300bb23Eun6BFPrew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LYAEqX6oV7TKK7FpSkgUsEVya9xhUy/JPhJiRGLYoOYHWT1I2ULOK7XHs64TXfoFn
	 mK0rDwRkYd2/GYZAlZLwNyS+CJKOhsomUkO8JCiKie8dl/BRiOTeonBmS4PvPu6ieF
	 sVIi5srBClDyYqHINc4pZYt7suQ3BTKRABwS7pHU3VKKSKaLzQS0g/VYlh9aDEEczz
	 eubVSLgoReF59GWwxGcQxODeBBcSFZ44sZs5+J+yLbcDPSbVuucJrs8YJ3B1hEkc9m
	 wEFyAXRiqWDpxiHtJcXt54WBqY8AcSWZsAoORertZk2ph2t6aW4EyYiUKsHKNUhrA8
	 yd5W3CUGhJ54A==
Date: Wed, 7 Jun 2023 10:57:57 +0200
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
Subject: Re: [PATCH 19/31] scsi: replace the fmode_t argument to
 scsi_cmd_allowed with a simple bool
Message-ID: <20230607-lider-beilegen-479e8cf3bf53@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-20-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-20-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_015807_310560_91B88167 
X-CRM114-Status: GOOD (  11.51  )
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

On Tue, Jun 06, 2023 at 09:39:38AM +0200, Christoph Hellwig wrote:
> Instead of passing a fmode_t and only checking it for FMODE_WRITE, pass
> a bool open_for_write to prepare for callers that won't have the fmode_t.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>

