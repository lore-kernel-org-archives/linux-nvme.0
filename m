Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7390C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Oct 2022 07:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6FJ8/O25BYSu1pxQAV7ISiA6qeRC4Y5Q2s3Ozn+zQZQ=; b=YIoJ52105Lxx8rw/jepC6VwXlh
	2OM9hqz89GfOmW9VmCxml0JWav9JKhuv+mOhzUKRo00mBuk6UY8eLwd6ttpdLo1LhGjCoPiwC7bW/
	Q/YP/Yl9ZgqONJLwpVARzjSZVpVcYJh6vOTHpOIfqtbBm11CUdWuDs0TvGB6APFaLFhA5LYOdV6/S
	ngL9c/wKQRnD7G9pK+SLWkc1dQH1bVK38KOQeFxme4Hg2J6yVGj14BvbAJ2gFT3AUhHFFcgAXSS+p
	PfJsf7arABwgUFSvtobY5d2MfFNxczc9nqjZ4S3rZTnVxAI8N8EjeppVB0+XCqlVGPywurXEc/2oe
	8SuKhTWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okKDr-008LuM-Lw; Mon, 17 Oct 2022 07:07:39 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okKDl-008Ltc-SB; Mon, 17 Oct 2022 07:07:33 +0000
Date: Mon, 17 Oct 2022 00:07:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: Daniel Wagner <dwagner@suse.de>, Pankaj Raghav <pankydev8@gmail.com>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	Keith Busch <kbusch@kernel.org>, Yi Zhang <yi.zhang@redhat.com>,
	Tomas Bzatek <tbzatek@redhat.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Martin Petersen <martin.petersen@oracle.com>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v1] nvme: do not log errors for user commands
Message-ID: <Y0z/NRKwg0SRgYiP@infradead.org>
References: <20221006093628.22089-1-dwagner@suse.de>
 <20221006121635.awoafzxyu6nkrqfj@quentin>
 <20221006133053.mmzw7m7wbfsapqbx@carbon.lan>
 <35A47E59-90E0-4F6C-80EA-A98F59213FA0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35A47E59-90E0-4F6C-80EA-A98F59213FA0@oracle.com>
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

On Fri, Oct 07, 2022 at 09:19:08PM +0000, Alan Adamson wrote:
> > I do get the debugging argument, but this clearly regresses production
> > code. Ideally, this code should be opt-in. The only way I see how to make
> > this work is by introducing a new API which allows enable this
> > feature.
> 
> Looks like a new API may need to be created.  I’ll investigate that.
> With your change, there
> will need to be a blktests change.

Yes, I think we need to effectively revert this for user commands and
then add an opt in - be that from the submitter, or through a sysfs
file for all command.

