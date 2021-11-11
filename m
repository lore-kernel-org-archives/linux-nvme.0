Return-Path: <SRS0=CVLn=P6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC875C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Nov 2021 17:36:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FD9961390
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Nov 2021 17:36:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7FD9961390
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5AGy1UoxZzXJgUcZkMd2SLNvT9tVbADfUmHjD0/YyaU=; b=v36IPmY93KUiVfQs0Ib8d5thUx
	sq5EWFbboXJyyXuU7NJHx+xCujo/ueUIyPgQQ5Nf7JnbOxNO2flIOhgj8NzG5WWjuY3Un65pJ35TL
	RVqGJZbhOK/H7RnbOiYTDDl4h6d/xQyEwunAimteBFqIQmQMtwO1BgRigN5/c0OSu/CL2S9cSFMkp
	Bm49zvPVFbR8NyyasvnrIRyhyhuYuVO1p8ZkoH7JFy/pzM2am3PvTxIxo9ieyzkVR6Dsfi64Fq6v/
	BEEoSBnNmzHxDZL0FpS3L/rgPcYdhLnuyxvY7YPRrH7iz9eSoGBCpixWnjX2vB3byOFEZKu7710KN
	54NlcgYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mlE04-008VKc-3O; Thu, 11 Nov 2021 17:36:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mlE00-008VJz-MT
 for linux-nvme@lists.infradead.org; Thu, 11 Nov 2021 17:36:34 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id B356561284;
 Thu, 11 Nov 2021 17:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636652191;
 bh=zMClcsV3dfyQh9jqQJlIo9lh3CgVa1wH4EuEsG86G8U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=O0s5qBZm+xtgsm4vOUpnbGj5co+5V6o9kfSQmNoLCat1DuMS4MaZPE68lR8o7tPAk
 GBzWBNQ0PDOYMdrWJYMb3Bcm44a6Qj7m2rKutfw1QAaeA3fR3TN9qpoHm82/Q8p0Ud
 yZ0Dp0ltLgRc8bTqvy5iUb6fMT7nc1wJlRYlcwRDdZ9FUjRik/6g0jBh7WV1svFgwI
 T3Qr1f9l3GmefonbVQ3XtP3CWAJ06/0cy8xiCZDc+GerR7xLRjyO/X7nihps5EyvSR
 k3UOzp4QYPLVj882VQI3bkfrrN2nZ+7di72GWUSTGdRG5z0cFcDezj7lQKQer2o/WC
 vQVS8Y0Y3vQng==
Date: Thu, 11 Nov 2021 09:36:28 -0800
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, chaitanyak@nvidia.com,
 oren@nvidia.com, benishay@nvidia.com, borisp@nvidia.com,
 aviadye@nvidia.com, idanb@nvidia.com, jsmart2021@gmail.com
Subject: Re: [PATCH v1 0/4] Add command id quirk for fabrics
Message-ID: <20211111173628.GA2880795@dhcp-10-100-145-180.wdc.com>
References: <20211109080903.GA28785@lst.de>
 <6292cd43-c746-0316-1820-aa52ec85d375@nvidia.com>
 <20211109131510.GA19713@lst.de>
 <9c740227-8c98-5877-9a9a-ae17756e851c@nvidia.com>
 <20211109143102.GA25263@lst.de>
 <20211109161547.GC2660170@dhcp-10-100-145-180.wdc.com>
 <a70fd129-d69d-2905-c43b-41eae0b3b8f8@nvidia.com>
 <20211109190432.GA2661484@dhcp-10-100-145-180.wdc.com>
 <e2d589ab-2457-a3c8-ba2a-9e4f813d9a72@grimberg.me>
 <fc27faf4-c876-ced5-c9cb-2d6730e07f2d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc27faf4-c876-ced5-c9cb-2d6730e07f2d@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211111_093632_790154_AB6A5064 
X-CRM114-Status: GOOD (  20.71  )
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

On Thu, Nov 11, 2021 at 11:29:11AM +0200, Max Gurtovoy wrote:
> 1. The device that broke the spec in the first place was that device for
> which caused you to add the gen bits to CID.
> 
> 2. These gen bits are causing the limit of 4K Q_depth.

That is true. At least one person (Bart) didn't like that.

On the other hand, we do observe timeouts in production environments
because the queues are already too large, and there is simply not enough
bandwidth available to satisfy default host latency requirements at
current depths. Going deeper doesn't improve iops or throughput, but it
does increase tail latencies.
 
> 3. It's not mention anywhere in the spec, and if it was intended to be
> implemented like it's now - it would have mentioned in the spec.

The only thing the spec says is that host software must ensure the CID
is unique on the SQ for the lifetime of the command. There's no need for
the spec to cover every possible way a driver can satisfy that
requirement.

> 4. Since gen bits were introduced, other devices got broken (such as Apple),
> hence the quirk for PCI.

Apple doesn't care about spec compatibility though. They support their
hardware only with their own host software, hence all the apple specific
Linux quirks.

> 5. The gen bits adds "if" conditions and logic to the fast path for
> "innosent" transports.

The quirk doesn't change that, though.

> 6. This series just extends this quirk for fabrics.

My only request has been that you identify at least one real fabrics
target that behaves this way. So far it sounds like this series is
speculating they might exist.

And if they do exist, you will have to change all the __u16 command_id
to __le16 and use appropriate cpu_to_le16() wrappers, otherwise
big-endian machines will produce completely different command id's than
little-endian. Since we haven't heard a single bug report from
big-endian hosts, I am pretty sure that such target behavior doesn't
actually exist in the field.

> 7. Even if not broken, some devices may suffer from reduced
> performance having CID space spanning all 16 possible bit - fact that
> we ignore

I don't see how. Why would this matter to any target? It's just a
cookie to pass back.
 
> 8. This series provides a flag to disable default behavior per
> connection.
> 
> 9. This series doesn't add any logic to fast path.
> 
> 10. My patch from last year for resiliency for nvme_pci was rejected
> because
> it added one if condition to the fast path - no consistency.

It's based only on what anyone could measure on available hardware. I
have completely different machines than what I tested at that time. If
someone can measure a loss with the current driver, that may change the
discussion. 

