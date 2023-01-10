Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08423C61DB3
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Jan 2023 07:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3igg7pM0D5Ior3+giwZ1L5uHzcFo/4wwPj2P2H6+NSQ=; b=Lux06bGV5Wp5p2B2gqZbwv8YmR
	SDffEaxiOnNqZP6Vjhf5eoOoYS3Tz30rwDReoiG4yqIdrBd381CyY7kRXeaisw7rf+Z7PFkzuo1Aj
	8KmAC99T4eojojVHtJOAbDz3pZKuiKFtqswRJDN3Y8uwpTVQEigpWOq0Y7jFrPoVA46XG2gAsBUpb
	N7IAKiZsz5As3Rti4AbMFFEHouiX8tRWyf+tacDzmFfIYLcTEV2Fryw3008WvOrq2/s9Sb0DTBzoZ
	8IBPMiebYnyANJY2mO6Z5TkGBH+deWmJm2Mx/+pIYfqPBcZ35Ur7R5+LmUyghrxYUNjvPJy/jFqA1
	SQBJIAxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pF8vH-005bLN-Vb; Tue, 10 Jan 2023 07:19:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pF8vD-005bKr-7V
	for linux-nvme@lists.infradead.org; Tue, 10 Jan 2023 07:19:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 299E868AFE; Tue, 10 Jan 2023 08:19:43 +0100 (CET)
Date: Tue, 10 Jan 2023 08:19:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: stop nvme matching for nvmem files
Message-ID: <20230110071942.GA10929@lst.de>
References: <E1pCkft-004hzL-0Q@rmk-PC.armlinux.org.uk> <20230108170520.GA19739@lst.de> <Y7xNNUpfQ6GiQ5+a@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7xNNUpfQ6GiQ5+a@shell.armlinux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230109_231947_428251_172B63AA 
X-CRM114-Status: GOOD (  16.33  )
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

On Mon, Jan 09, 2023 at 05:21:57PM +0000, Russell King (Oracle) wrote:
> > I think the proper thing to do would to just match the right files
> > from the start:
> > 
> > F:	include/linux/nvme.h
> > F:	include/linux/nvme-*.h
> > 
> > is it ok if I commit it with your original attributation with that
> > change?
> 
> LGTM, thanks!

Thanks, I've added the updated version to the nvme-6.2 branch.

