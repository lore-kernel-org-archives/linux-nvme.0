Return-Path: <SRS0=KW0X=MA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416E2C07E96
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jul 2021 05:13:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD21161CD6
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jul 2021 05:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD21161CD6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YVfY3OhpFlkxBTGKvxTwO5z2irhFNrI5hvPTEdU5IWo=; b=dp/yz3MErAR2dC
	ujAEw/r7CrHMtkMD+zLXNDEvq+KZMJrp97ouhEmHwG79SIexU3LbuJxW4UDfmvpdCuvxeG2xVMKqs
	ap3U3KfEeZDVRMWm6eEC4SX/uBw4Bdd9kZMzHKOV6XykIWOIn7z19mGV66vxFoiTzRlKpoSopSn2N
	EOVLSES8oScpilspqwbGD43Lx0Xl3A/1FJQKGsBhMat4ETW9kgdEoOTwAp0DlSLRuyIaV99nW6zrN
	R+fmOg80f1M8aRiS7vmz7wX8qCv/uvt1A1sdkhmccMjc2OxxDIjH4WSTriMmfuzos/6lJZyb3cXfO
	hjfJQppsMteLXxQFJK+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m1MLR-00G59R-G3; Thu, 08 Jul 2021 05:13:05 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1MLP-00G58m-0d
 for linux-nvme@lists.infradead.org; Thu, 08 Jul 2021 05:13:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 60C4D68C4E; Thu,  8 Jul 2021 07:13:00 +0200 (CEST)
Date: Thu, 8 Jul 2021 07:13:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Christoph Hellwig <hch@lst.de>, leah.rumancik@gmail.com,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] ext4: fix EXT4_IOC_CHECKPOINT
Message-ID: <20210708051300.GA18564@lst.de>
References: <20210707085644.3041867-1-hch@lst.de> <YOXdIZARJ0Rwtfbd@mit.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YOXdIZARJ0Rwtfbd@mit.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210707_221303_255539_187B6FCE 
X-CRM114-Status: GOOD (  23.88  )
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

On Wed, Jul 07, 2021 at 12:58:09PM -0400, Theodore Ts'o wrote:
> A discard is not "dangerous"; how it behaves is simply not necessarily
> guaranteed by the standards specification.  The userspace which uses
> the ioctl simply needs to know how a particular block device might
> react when it is given a discard.

A discard itself is indeed not dangerous at all.  Using it to imply
any kind of data erasure OTOH is extremely dangerous, and that is
what this interface does.

> I'll note that there is a similar issue with "WRITE SAME" or "ZEROOUT.
> A WRITE SAME might take a fraction of a second --- or it might take
> days --- depending on how the storage device is implemented.  It is
> similarly unspecified by the various standards specification.  Hence,
> userspace needs to know something about the block device before
> deciding whether or not it would be good idea to issue a "WRITE SAME"
> operation for large number of blocks.

The same is true of discard.  There are plenty of devices where
discards are horrible slow.  There also are plenty of devices where
discard is a complete no-op.  Especially on NVMe where the discard
command (DSM deallocate) is mandatory to implement.

> This is why the API is implemented in terms of what command will be
> issued to the block device, and not what the semantic meaning is for
> that particular command.  That's up to the userspace application to
> know out of band, and we should be able to give the privileged
> application the freedom to decide which command makes the most amount
> of sense.

Stop claiming you actively misleading users with broken interfaces
freedom.

> 
> 	 	      	  	    		   - Ted
---end quoted text---

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
