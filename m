Return-Path: <SRS0=+1uq=AT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C97C433DF
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2020 14:42:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11CBF2078B
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2020 14:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kdUjMPgF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11CBF2078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7Zetmt9rEqZ+0PQXwCV+Z1AL7dkiGUrf+SSae8Xlcm8=; b=kdUjMPgF81K2E7VVyeInbV+x9
	CA7Hp8YLrZ3WKMIvZaIrA7mOzmNMT/HjNHOqzjmLaffOh01kMkwbTnwCU+Ds/Rc4V+8qM7CvYKFHq
	BRn/3XiADUng/OuBZoav3QhwL+ScszUeVIfK0OKdga0C5G/6eAYUxsuK4BMo6aBjZscjSGqLWV4nG
	gJOkoSByEeqJqhf32ieK3eMlyVWsGl8lACHVHtdRU228MEn4Pg5eTzfW+fjTMbHFZLHpGZERqGdfX
	qfV9PvHTUEgH3nL5M+wQGqFlFXZr3vN6sYykVeziclbyfRZ4qGOPQ9Sg9JKAGAH8WId4rudmIT4rZ
	5m2wnrOBw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jtBHN-0008Hf-UE; Wed, 08 Jul 2020 14:42:33 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtBHK-0008H5-Om
 for linux-nvme@lists.infradead.org; Wed, 08 Jul 2020 14:42:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id CA38E68B05; Wed,  8 Jul 2020 16:42:27 +0200 (CEST)
Date: Wed, 8 Jul 2020 16:42:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anthony Iliopoulos <ailiop@suse.com>
Subject: Re: [PATCH v2 for-5.8-rc 1/6] nvme: fix possible deadlock when I/O
 is blocked
Message-ID: <20200708144227.GA23255@lst.de>
References: <20200624001853.5408-1-sagi@grimberg.me>
 <20200624001853.5408-2-sagi@grimberg.me> <20200624062902.GA17594@lst.de>
 <84583b2e-d59b-01bc-1737-5db107999d84@grimberg.me>
 <20200707105735.GA16868@technoir>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200707105735.GA16868@technoir>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200708_104231_256726_D26B39CE 
X-CRM114-Status: GOOD (  18.25  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Anton Eidelman <anton@lightbitslabs.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jul 07, 2020 at 12:57:35PM +0200, Anthony Iliopoulos wrote:
> The revalidation is still required there in order to update the blockdev
> size when multipath is enabled. With this revert, the behavior regressed
> back to before fab7772bfbcf, so the size isn't updated under multipath
> when the device is in use (e.g. mounted), it will only be effectively
> updated next time it is mounted as a side-effect of blkdev_open on first
> opener. This prevents online resizing of filesystems.
> 
> > And if you look at revalidate, it only calls fops->revalidate_disk
> > (which is a noop in the mpath device) and checks the size change.
> 
> The mpath gendisk doesn't have a revalidate_disk fop indeed, but call to
> check_disk_size_change was needed to update its size. Otherwise, the
> size change isn't reflected externally to userspace before next mount.
> cb224c3af4df doesn't fix this as it skips revalidate and thus also skips
> updating the size.
> 
> The issue is that under CONFIG_NVME_MULTIPATH=y the ns->disk becomes a
> hidden gendisk (see nvme_set_disk_name) and thus doesn't have a backing
> bdev, while ns->head->disk becomes the "visible" one to userspace (with
> a backing bdev), and therefore needs its bdev->bd_inode->i_size updated
> when resized.
> 
> The following patch seems to be working, although I'm not sufficiently
> familiar with the code to tell if this won't cause any other deadlocks
> with some confidence:

This looks sensible to me.  Sagi?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
