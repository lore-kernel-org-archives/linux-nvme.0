Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 531FCC7EE29
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 08:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=utLozJ0+WCs5Ko5pQY5tkN1YQ8Tl20A8mAVO85MpDO8=; b=mzSYn4nN2TwbmWg4QnnE3nrRTM
	rjm6soim22nWEYuDdsPWfYsTXH5KNhrxc5qgo2e+PzVtgIeZULek7lhVHuS5xZ5/FdbOh+3VO7jHH
	J6sN2Dje/jbPETJ3PFCUyHwUEHFjhBes3u/44maUTjsTzJubFlhFxQqMkdNBd3zyw1AORZoBQGEfd
	nZjtQvo0FMCcC7v22Fz2zoWQcm/50+nqD4DLKIU5Fj8RHbArcnPQkVfRfGQy5kpO6rW4ojLXedsUn
	993B/WVfOzF8OYohCIi+2kzV92imICXxTjZulEoPT+c88GFjRzLfNhYwP17TJPxy0t+PTa4qLsRhZ
	qlX4wKBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6odL-004zgp-0m;
	Wed, 07 Jun 2023 08:35:11 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6odH-004zfF-0x;
	Wed, 07 Jun 2023 08:35:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id CDFCC63818;
	Wed,  7 Jun 2023 08:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9368FC433D2;
	Wed,  7 Jun 2023 08:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686126906;
	bh=DEpqJ01874Wcf6flpWQL4l3j+OyeWJJ1wSvscW2ZsvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i3CH5XZi7Ku/UmN1uNhGHrNxFPQhZ8efjNfiTbNsWjKI+qjrG2GJAlxpGl4WKzZoh
	 BUa3cIn0dVM3WafUAzzbH8uuNxyByYfP8H70QxdowRN6RCs5nrCwMqpAWtTtCtkrfA
	 UUoFuECYuwF6g6BZvtkz1yfF3SziUWNAxmfcDv+ZyAT15huu83Xslw1FDR3OSN3f7M
	 cxo76H7oplo9/nKa80/LLfizTzZ0Gzi/jSYy7ksr7BoXSBWk0n4y6gq2zZA1zoG10d
	 b82jMNFwK474uaEbmhI5IxsDz3/ABjdRxN6qmozleapT3Vy9qyc29Lz62fPrh+D/W5
	 4FkCLrnTGlquQ==
Date: Wed, 7 Jun 2023 10:34:57 +0200
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
Subject: Re: [PATCH 10/31] block: remove the unused mode argument to ->release
Message-ID: <20230607-inbetriebnahme-markieren-42711df12a4b@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-11-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_013507_370887_1B1C7DDB 
X-CRM114-Status: GOOD (  12.32  )
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

On Tue, Jun 06, 2023 at 09:39:29AM +0200, Christoph Hellwig wrote:
> The mode argument to the ->release block_device_operation is never used,
> so remove it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Good cleanup. Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>

