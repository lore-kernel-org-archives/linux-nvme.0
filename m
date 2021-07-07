Return-Path: <SRS0=InZj=L7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D48C07E9C
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jul 2021 16:58:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D2EC61CCB
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jul 2021 16:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2EC61CCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Zh/KiSFOWo+xhuuqdcfKQrRRJbDXFaxmYq+EubdoybU=; b=106JfSe2CIRAjA
	YKQm4g5fXMZpiikpRafY6U7lb4+jtKUINf1MuljRrxfoka7e4ZPDERjEnzUGkU1AM1EoNlTo2X2vp
	92tucYOUmnSAUErK58LEh0gXSyM4slmJM2zQZO9jYgQp8cKwHjsd2HsxON+sjQiIERc/DBLRxriOV
	4hExnawA30zoHMIvT/pgb9XKeQybq48mTSz6DhEWInE5PCepVX4+l07Vp0WmFE5gxBgBt+eRiz2+9
	FxqE5N5++BCYy+Ss6x5WZ8E/nfXNJO7BZ58tS2e+9iyZzpbEKabnHJNzaoMmopRgz+xr8PdnOwIIu
	49hJ0Wh439Q2ku4kTQfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m1AsP-00FKhn-Pl; Wed, 07 Jul 2021 16:58:21 +0000
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1AsM-00FKgz-LS
 for linux-nvme@lists.infradead.org; Wed, 07 Jul 2021 16:58:20 +0000
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net
 [72.74.133.215]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 167Gw96L029559
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 7 Jul 2021 12:58:10 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
 id CA98E15C3CC6; Wed,  7 Jul 2021 12:58:09 -0400 (EDT)
Date: Wed, 7 Jul 2021 12:58:09 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christoph Hellwig <hch@lst.de>
Cc: leah.rumancik@gmail.com, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH] ext4: fix EXT4_IOC_CHECKPOINT
Message-ID: <YOXdIZARJ0Rwtfbd@mit.edu>
References: <20210707085644.3041867-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210707085644.3041867-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210707_095818_919316_521CC06A 
X-CRM114-Status: GOOD (  19.18  )
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

On Wed, Jul 07, 2021 at 10:56:44AM +0200, Christoph Hellwig wrote:
> Issuing a discard for any kind of "contention deletion SLO" is highly
> dangerous as discard as defined by Linux (as well the underlying NVMe,
> SCSI, ATA, eMMC and virtio primitivies) are defined to not guarantee
> erasing of data but just allow optional and nondeterministic reclamation
> of space.  Instead issuing write zeroes is the only think to perform
> such an operation.  Remove the highly dangerous and misleading discard
> mode for EXT4_IOC_CHECKPOINT and only support the write zeroes based
> on, and clean up the resulting mess including the dry run mode.

A discard is not "dangerous"; how it behaves is simply not necessarily
guaranteed by the standards specification.  The userspace which uses
the ioctl simply needs to know how a particular block device might
react when it is given a discard.

I'll note that there is a similar issue with "WRITE SAME" or "ZEROOUT.
A WRITE SAME might take a fraction of a second --- or it might take
days --- depending on how the storage device is implemented.  It is
similarly unspecified by the various standards specification.  Hence,
userspace needs to know something about the block device before
deciding whether or not it would be good idea to issue a "WRITE SAME"
operation for large number of blocks.

This is why the API is implemented in terms of what command will be
issued to the block device, and not what the semantic meaning is for
that particular command.  That's up to the userspace application to
know out of band, and we should be able to give the privileged
application the freedom to decide which command makes the most amount
of sense.

	 	      	  	    		   - Ted

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
