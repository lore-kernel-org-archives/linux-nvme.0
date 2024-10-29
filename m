Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25908D3A676
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 17:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ClRSMTIYTzXbYWUK2pQOna4la5Eq1EqcjYtERgppUi8=; b=qLT+AhnCZ+GStfLoAnpYJNmnlF
	OObF8KMiiW63/SBLz2PZ/TY4MqzqyR6w+LQhXlR5Yk45X1pN2kyh+RgnSbGJ2poqGMCMmYejVd41B
	aArHZ/VdJuC2JTb5KzokxJb2xo3eMGmaCZc6wwRnFn/GmlgNo3UrwfHD0eY+3rZLdvgA+69Q0/yLp
	/Ovma7dktrrfuOlHGwCYTzVTcf8sVhIbfdisAa2yeEf8D4PuOcq3YeTLkvFo5MyJIAuvtUQMht2RA
	gTLxtgy6vZkJdFFETgCqKkO++zuofSqTnGm443ev9nakWrjvOczPZ84XwW9RVkKE71W2WTV63AiDz
	t5DrOPdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5q7w-0000000FHWc-0Wmd;
	Tue, 29 Oct 2024 17:35:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5oXI-0000000F16T-3P4m
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 15:53:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6BB04227AAD; Tue, 29 Oct 2024 16:53:31 +0100 (CET)
Date: Tue, 29 Oct 2024 16:53:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
	javier.gonz@samsung.com, bvanassche@acm.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv10 9/9] scsi: set permanent stream count in block limits
Message-ID: <20241029155330.GA27856@lst.de>
References: <20241029151922.459139-1-kbusch@meta.com> <20241029151922.459139-10-kbusch@meta.com> <20241029152654.GC26431@lst.de> <ZyEAb-zgvBlzZiaQ@kbusch-mbp> <20241029153702.GA27545@lst.de> <ZyEBhOoDHKJs4EEY@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyEBhOoDHKJs4EEY@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_085337_019557_C18708C2 
X-CRM114-Status: GOOD (  20.98  )
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

On Tue, Oct 29, 2024 at 09:38:44AM -0600, Keith Busch wrote:
> They're not exposed as write streams. Patch 7/9 sets the feature if it
> is a placement id or not, and only nvme sets it, so scsi's attributes
> are not claiming to be a write stream.

So it shows up in sysfs, but:

 - queue_max_write_hints (which really should be queue_max_write_streams)
   still picks it up, and from there the statx interface

 - per-inode fcntl hint that encode a temperature still magically
   get dumpted into the write streams if they are set.

In other words it's a really leaky half-backed abstraction.

Let's brainstorm how it could be done better:

 - the max_write_streams values only set by block devices that actually
   do support write streams, and not the fire and forget temperature
   hints.  They way this is queried is by having a non-zero value
   there, not need for an extra flag.
 - but the struct file (or maybe inode) gets a supported flag, as stream
   separation needs to be supported by the file system 
 - a separate fcntl is used to set per-inode streams (if you care about
   that, seem like the bdev use case focusses on per-I/O).  In that case
   we'd probably also need a separate inode field for them, or a somewhat
   complicated scheme to decide what is stored in the inode field if there
   is only one.
 - for block devices bdev/fops.c maps the temperature hints into write
   streams if write streams are supported, any user that mixes and
   matches write streams and temperature hints gets what they deserve
 - this could also be a helper for file systems that want to do the
   same.

Just a quick writeup while I'm on the run, there's probably a hole or
two that could be poked into it.

