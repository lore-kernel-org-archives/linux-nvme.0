Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4198C38A02
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Oct 2022 08:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1KQ5UGjQhFGOymdJy+0MQd/FNVrsRgsT4WJ7+UDIagc=; b=l+/aEi87tSeLc66IBJXJPgzTy2
	X8dAfNpTzLaKMkd9AWs+YqvDtZnJTkMRYi5bRFGwBOTrcboF24ARsrxOTchykUA5kgv4lLhAF0zhx
	hBDF1ae937lgo/YinsEVIQnCx8/yyEoU6OXTA9uGza7Dgqq78uxClHXI5KzLW/mnoufB4IZsA6cVN
	A14s/PeJSsTkjdGyjBYWo2r7GCWSNUYQkN4vilKzKYRHqF4xf6tvb3sJHMIYz/Jq46PNReyN/GX/1
	uaH/Zjd2x9TS0C5ZiupuxIDKg/p5gzfxcptirjC48qoT9FEvMFhf79dNb0am4o+8kEINm381BRA7d
	L2gmb+FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op3L5-00E2EA-CX; Sun, 30 Oct 2022 08:06:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op3L2-00E2Ca-Nu
	for linux-nvme@lists.infradead.org; Sun, 30 Oct 2022 08:06:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F009F68AFE; Sun, 30 Oct 2022 09:06:32 +0100 (CET)
Date: Sun, 30 Oct 2022 09:06:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Mike Christie <michael.christie@oracle.com>, bvanassche@acm.org,
	hch@lst.de, martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	james.bottomley@hansenpartnership.com, linux-block@vger.kernel.org,
	dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
	linux-nvme@lists.infradead.org, chaitanyak@nvidia.com,
	target-devel@vger.kernel.org
Subject: Re: [PATCH v3 08/19] nvme: Move pr code to it's own file
Message-ID: <20221030080632.GI4214@lst.de>
References: <20221026231945.6609-1-michael.christie@oracle.com> <20221026231945.6609-9-michael.christie@oracle.com> <Y1q6so/3Hx9GZmTz@kbusch-mbp.dhcp.thefacebook.com> <370e66bd-81d0-5451-850e-50a4172ed64f@oracle.com> <Y1wFjHzza1QYTzdG@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1wFjHzza1QYTzdG@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221030_010636_977363_A00CBBE1 
X-CRM114-Status: GOOD (  10.97  )
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

On Fri, Oct 28, 2022 at 10:38:36AM -0600, Keith Busch wrote:
> I think I was just the last person to touch the code, but it was mostly
> developed elsewhere. So "no", don't bother propagating the (c).

You actually did write the PR ops code.  I wrote the core and SCSI
side, and you added NVMe.

