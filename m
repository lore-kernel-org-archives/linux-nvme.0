Return-Path: <SRS0=THed=NL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDCAC4338F
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Aug 2021 04:05:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CA0D6101A
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Aug 2021 04:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0CA0D6101A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RPGSxmy/vnEa9Q3rpxALoYZzhY59n09c0LdRK9OJ2V8=; b=1Kw73Oi0PF1PjT
	obfzmyocrcJve+NfFoS9QJPmZ/ibkTcEBquOTLxo2RSqQFK968kSWjdwvqk7POVYrHJVbaqZREg18
	9mbafN+ZMfTaltj4H/QP+5y21xYKAUCfAP+cv7mAQ2TQmnFdQkXFjVvm1ykFAS/YuD0IMZ/Zz0z8M
	pd4PdaLUaYSs32SyGAHOmf5eZPrDXCuizOJE8qayh/AyPHzGLrG1RmxJGH94tjJ8Io6vrvs/lrKeM
	fdtXriTK6BCQ87lQhwAX/SdFQgaNNfIWEG5nXHMPHR9eU1aBw1zl/pGUHmfP8+hX75syrL3XbYZ0Z
	xx0ZP+S57hOHZQ8vhNpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mGvmP-00A30H-1d; Fri, 20 Aug 2021 04:05:17 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mGvmF-00A2yW-JL
 for linux-nvme@lists.infradead.org; Fri, 20 Aug 2021 04:05:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E7DC86736F; Fri, 20 Aug 2021 06:05:00 +0200 (CEST)
Date: Fri, 20 Aug 2021 06:05:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Stefan Haberland <sth@linux.ibm.com>,
 Jan Hoeppner <hoeppner@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Doug Gilbert <dgilbert@interlog.com>,
 Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 3/9] sg: do not allocate a gendisk
Message-ID: <20210820040500.GA26305@lst.de>
References: <20210816131910.615153-1-hch@lst.de>
 <20210816131910.615153-4-hch@lst.de>
 <YR7OJ+lmps2H2fN/@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YR7OJ+lmps2H2fN/@bombadil.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210819_210507_821995_7052B88B 
X-CRM114-Status: GOOD (  10.89  )
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

On Thu, Aug 19, 2021 at 02:33:27PM -0700, Luis Chamberlain wrote:
> -	retval = scsi_ioctl(STp->device, STp->disk, file->f_mode, cmd_in, p);
> +	retval = scsi_ioctl(STp->device, NULL, file->f_mode, cmd_in, p);

Only in linux-next.  The change to pass the gendisk to scsi_ioctl is
only in the scsi tree, not the block tree.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
