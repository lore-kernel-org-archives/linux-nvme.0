Return-Path: <SRS0=Glcz=NV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2889C432BE
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Aug 2021 21:01:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C016960234
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Aug 2021 21:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C016960234
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UCDkvN4uF1bI5+xBih9XfYhrQ0ETv37gP0weNlvZhJE=; b=JoEDboZuHkXBOJ
	FXgozM1hsFzyzx+5YZ6fH5Mi9/gApJM/zUeO8mPcc1k4/BlufptX43PPzehBzkzafTqBpb0N6aAvx
	LAmsApEBDJ0l8BLsr+4J+Sx8MWKNUA9Q7R3gBPuwuxM4G8p64fKadFej6M3zgTGZYj/XFqL5AmLlJ
	zaFXxPjlTufh70HzF759W8ZHLWrwyjey8f7D/G7Nn7D5aTCL8weBZZdwxB4NFGoSzV36isClWCFB+
	GoL8Opqj5NvTDFjXAyBQdLSaRluQTiljt/IdVJ2J5/fJb9MbUY/6WJfRxZONrRzQLoER6z1CHxYXD
	buAaboXegczhkFgP0miA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mKoOq-000ZIp-NL; Mon, 30 Aug 2021 21:01:00 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1mKoOo-000ZII-6j; Mon, 30 Aug 2021 21:00:58 +0000
Date: Mon, 30 Aug 2021 14:00:58 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, jejb@linux.ibm.com,
 kbusch@kernel.org, sagi@grimberg.me, adrian.hunter@intel.com,
 beanhuo@micron.com, ulf.hansson@linaro.org, avri.altman@wdc.com,
 swboyd@chromium.org, agk@redhat.com, snitzer@redhat.com,
 josef@toxicpanda.com, hare@suse.de, bvanassche@acm.org,
 ming.lei@redhat.com, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-mmc@vger.kernel.org,
 dm-devel@redhat.com, nbd@other.debian.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] dm: add add_disk() error handling
Message-ID: <YS1HCgP/XdWmMtFN@bombadil.infradead.org>
References: <20210823202930.137278-1-mcgrof@kernel.org>
 <20210823202930.137278-9-mcgrof@kernel.org>
 <YSSP6ujNQttGN2sZ@infradead.org>
 <YSk1EhUIr9OjIoVv@bombadil.infradead.org>
 <YSnnXdKLvxEY8yay@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YSnnXdKLvxEY8yay@infradead.org>
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

On Sat, Aug 28, 2021 at 08:35:57AM +0100, Christoph Hellwig wrote:
> On Fri, Aug 27, 2021 at 11:55:14AM -0700, Luis Chamberlain wrote:
> > > I think the add_disk should just return r.  If you look at the
> > > callers they eventualy end up in dm_table_destroy, which does
> > > this cleanup.
> > 
> > I don't see it. What part of dm_table_destroy() does this?
> 
> Sorry, dm_destroy, not dm_table_destroy.  For dm_early_create it's
> trivial as that calls both dm_table_destroy and dm_destroy in the error
> path.  The normal table_load case is a separate ioctl, but if that
> fails userspace needs to call the DM_DEV_REMOVE_CMD to cleanup
> the state - similar to any other failure.

I see, ok sure I'll document this on the commit log as its not so
obvious.

  Luis

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
