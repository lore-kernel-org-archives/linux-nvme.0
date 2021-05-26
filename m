Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EF8C2B9F7
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 04:52:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7DFD60FF0
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 04:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7DFD60FF0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LFqgdCPLmPlZzajY4f+v1QjN8v4peKv7dpwAXZi5I6Y=; b=i4cF+uXyIxiA62
	+cUUyOVOc0biMuMnar5ITJHz+rfgvSB2gUD5EJI/2rPVmjVBr7xRU+vtXZ7PhPvH/T+8bZXJWG7Ww
	3ssRMJZzOdDS7esSAx6uFQmk2wPW7k7N/Q140yu8PcHq1HZ8BllmxutxIVotlpM0C5qnNX1id79+J
	+lK0+GwLUxyFPL1pb2NlSjT1ZqrBYkp9UwD1CoRMrMuQfs1l3aTt9++xWGaijlRuk1JKFX1zqMxUs
	tCCShOh5Np8SF9J934A5HNb0+xyIWXSuCsy0Yfq4K3rXXKB2UyRrU6syKk5ahxeFGKLOnboRbx6CR
	yJ/s8b25uGr6PlpcckAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lllX7-00AzdH-Hw; Wed, 26 May 2021 04:52:41 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lllUN-00Aylf-Lf
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 04:49:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3ADA76736F; Wed, 26 May 2021 06:49:44 +0200 (CEST)
Date: Wed, 26 May 2021 06:49:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 Jim Paris <jim@jtan.com>, Joshua Morris <josh.h.morris@us.ibm.com>,
 Philip Kelleher <pjk1939@linux.ibm.com>,
 Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
 Matias Bjorling <mb@lightnvm.io>, Coly Li <colyli@suse.de>,
 Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
 Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 linux-block <linux-block@vger.kernel.org>, dm-devel@redhat.com,
 linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org,
 drbd-dev@lists.linbit.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-mmc <linux-mmc@vger.kernel.org>, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: simplify gendisk and request_queue allocation for bio based
 drivers
Message-ID: <20210526044943.GA28551@lst.de>
References: <20210521055116.1053587-1-hch@lst.de>
 <CAPDyKFpqdSYeA+Zg=9Ewi46CmSWNpXQbju6HQo7aviCcRzyAAg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPDyKFpqdSYeA+Zg=9Ewi46CmSWNpXQbju6HQo7aviCcRzyAAg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_214951_883866_9CC44BFD 
X-CRM114-Status: GOOD (  22.23  )
X-Mailman-Approved-At: Tue, 25 May 2021 21:52:30 -0700
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, May 26, 2021 at 12:41:37AM +0200, Ulf Hansson wrote:
> On Fri, 21 May 2021 at 07:51, Christoph Hellwig <hch@lst.de> wrote:
> >
> > Hi all,
> >
> > this series is the first part of cleaning up lifetimes and allocation of
> > the gendisk and request_queue structure.  It adds a new interface to
> > allocate the disk and queue together for bio based drivers, and a helper
> > for cleanup/free them when a driver is unloaded or a device is removed.
> 
> May I ask what else you have in the pipe for the next steps?
> 
> The reason why I ask is that I am looking into some issues related to
> lifecycle problems of gendisk/mmc, typically triggered at SD/MMC card
> removal.

In the short run not much more than superficial cleanups.  Eventually
I want bio based drivers to not require a separate request_queue, leaving
that purely as a data structure for blk-mq based drivers.  But it will
take a while until we get there, so it should not block any fixes.

For hot unplug handling it might be worth to take a look at nvme, as it
is tested a lot for that case.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
