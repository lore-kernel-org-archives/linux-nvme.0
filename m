Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0761C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 16:49:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D6FE6052B
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 16:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9D6FE6052B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B0DbNMIdnJySJfPWbunRhzKGzYOHZb+Uy6BhtpifdMU=; b=llU/DlrO9a85Uk2bRms/Y1Wb5T
	s0qxTCNmf4KXmItXnHF8sHZOullnYesvJ9Saxr1M+cfOGscmejKYnHiMRqb1q0/JvklUuZal/8a6+
	bTyRxJWaHkq9va1CuDqnB2I9s95awJK7fOAJvZfn2AXzrVzx2M7Nwf7iF4wFqgwxYjA0Wl2JMAub/
	60tQSqqXQc2X1BeEDTHoC4QzXeVlS+FbDMOP8ARBq53r4EYNLWpWZuSP/OpifHv72wnvlYdQxqwzR
	XxgA8u9iXl/2Ag1rCV75sfM+1P58j9cF2j0uIczh9AO44+eg8MjDvhLfpKFJY8vkB2UxyYcKW5GJQ
	4qdZ3ghw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mahRk-0005Tl-Pl; Wed, 13 Oct 2021 16:49:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mahRi-0005TG-Km
 for linux-nvme@lists.infradead.org; Wed, 13 Oct 2021 16:49:39 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id D50CB60EB4;
 Wed, 13 Oct 2021 16:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634143778;
 bh=5zZ3HU6lkjXz+DteEnqjTu8ptCpqpWqSJh+4tUryNsU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ami1k5OahkDZQmGaX53RJ4E5qTpt1shAJRk9Ad7NFHs7O2507Id+UaAWuEc/AHslc
 yzft76GIQSZRYUxYwQxIYY8BWyeuEW7CyyCTzdRybG6kz9Lfu3gvIY4bXvaDHCB+Bb
 Z2pspCcac3/HyHwc3nZ7S147Tlb2TbJBZYQesjN8N3CQ+i21nJY2UfI9sF46KFg6KL
 Z83cpVMkOJQyC4cCFwmyzBc2LKm2MG7ryWD8cdLm/KsRpy/mmGrdbxYFY0Jd1cb8/+
 eyydVjwkaMWgUly2rWu3E4d4/zzDiKE3WwSQyatWY227XVkn5KXeKwmclzg94Azwtt
 1nrfnpBZXUbZQ==
Date: Wed, 13 Oct 2021 09:49:35 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org
Subject: Re: [RFCv2] nvme-pci: adjust tagset parameters to match b/w
Message-ID: <20211013164935.GD1594461@dhcp-10-100-145-180.wdc.com>
References: <20211013152136.1594409-1-kbusch@kernel.org>
 <yq1tuhlnd0c.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1tuhlnd0c.fsf@ca-mkp.ca.oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211013_094938_729232_5B072389 
X-CRM114-Status: GOOD (  20.75  )
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

On Wed, Oct 13, 2021 at 12:04:49PM -0400, Martin K. Petersen wrote:
> 
> Keith,
> 
> > Instead of auto-adjusting the timeout to cope with the worst case
> > scenario, this version adjusts the IO depth and max transfer size so
> > that the worst case scenario fits within the driver's timeout
> > tolerance.
> 
> I am totally in agreement with the concept of preventing mismatched
> queue depth and I/O timeout.
> 
> I am a bit concerned wrt. PCIe bandwidth as a measure since that is not
> necessarily representative of a drive's actual performance. But
> obviously the queue feedback mechanism is still a bit of a can of
> worms. For a sanity check, PCIe bandwidth is definitely acceptable.
> 
> > +	static const u32 min_bytes = 128 * 1024;
> > +	static const u32 min_depth = 128;
> 
> Not sure about 128 as min depth. We have seen workloads where 32 or 64
> performed best in practice although the drive internally had more
> command slots available.

Probably fine. I chose 128 somewhat arbitrarily, and suspect 32 tags per
hctx will be sufficient for most workloads without harming anything.

This algorithm does not change the nvme IO queue depth either; it only
limits what blk-mq is allowed to dispatch, so we will also have more SQ
command entries than we could ever use if this throttle kicks in.
 
> Also, haven't looked closely at your algorithm yet (impending meeting),
> just want to point out that the default 30 seconds is a totally
> unacceptable timeout for many of the things we care about.  Our I/O
> timeout is typically set to a couple of seconds. My hunch is that the
> algorithm needs to take into account. 

30 seconds is just the default if you didn't ask to change it. The
algorithm will react to the user requested IO timeout, so if you request
2 seconds via the module parameter, the driver will try to adjust
dispatch parameters accordingly.

> In the past we have been bitten by scaling algorithms that were
> essentially linear in nature and failed to pick sensible defaults at
> very low input values or timeouts.
> 
> Anyway. Will have a closer look later.
> 
> -- 
> Martin K. Petersen	Oracle Linux Engineering

