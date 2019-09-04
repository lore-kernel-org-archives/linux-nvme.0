Return-Path: <SRS0=Tecl=W7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B45C3A5A7
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 14:46:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E04922168B
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 14:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CQbDHsro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04922168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=97myjmI0v3Qaaqr6tYsz9nzXpSiFz48zfVa3yPS1lSs=; b=CQbDHsroLZMgWG
	5rkXiaicMx/28W5R3704X+lA9/crr0SbSly6Da0Uag3Q96XtIwPjUHLgHOVZH9tgZsACSPBdl+gQQ
	B4s2+L4qXGwq+e0X/gPjk2g8tBvUwsKMbPH4LL2NObOFrITTOnF9qCDgmT3m2M4tvW4MqGCChmP0O
	QFi9iS+tSZq10u81QAF4ihoK7+CCqHAlk9tjn8BfafNblGlHTDnP6ufIYXVfMfL44Tyk6wSOsMj0a
	hFtXW4sAjCq7HRnUvwxc8Ez3UYap+8E1GuYk4/ZTNKvHCB02IqviQiEqCBpDvW8b96ZK5iXL+S8mc
	6PNZgQJEwqkzNSfW6GHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5WXq-0005Xq-Jn; Wed, 04 Sep 2019 14:46:02 +0000
Received: from mga05.intel.com ([192.55.52.43])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5WXo-0005X7-5R
 for linux-nvme@lists.infradead.org; Wed, 04 Sep 2019 14:46:01 +0000
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Sep 2019 07:45:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; d="scan'208";a="334232146"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
 by orsmga004.jf.intel.com with ESMTP; 04 Sep 2019 07:45:58 -0700
Date: Wed, 4 Sep 2019 08:44:27 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme-core: Fix subsystem instance mismatches
Message-ID: <20190904144426.GB21302@localhost.localdomain>
References: <20190831000139.7662-1-logang@deltatee.com>
 <20190831152910.GA29439@localhost.localdomain>
 <33af4d94-9f6d-9baa-01fa-0f75ccee263e@deltatee.com>
 <20190903164620.GA20847@localhost.localdomain>
 <20190904060558.GA10849@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190904060558.GA10849@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190904_074600_218054_F38658F3 
X-CRM114-Status: GOOD (  15.34  )
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
Cc: Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Logan Gunthorpe <logang@deltatee.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 04, 2019 at 08:05:58AM +0200, Christoph Hellwig wrote:
> On Tue, Sep 03, 2019 at 10:46:20AM -0600, Keith Busch wrote:
> > Could we possibly make /dev/nvmeX be a subsystem handle without causing
> > trouble for anyone? This would essentially be the same thing as today
> > for non-CMIC controllers with a device-per-controller and only affects
> > the CMIC ones.
> 
> A per-subsyste character device doesn't make sense, as a lot of admin
> command require a specific controller.

Yeah, I was hoping to provide something special for CMIC controllers
so you can do path specific admin, but that looks sure to break user
space.

> If this really is an isue for people we'll just need to refcount the
> handle allocation.  That is:
> 
>  - nvme_init_ctrl allocates a new nvme_instance or so object, which
>    does the ida_simple_get.
>  - we allocate a new subsystem that reuses the handle and grabs
>    a reference in nvme_init_subsystem, then if we find an existing
>    subsystem we drop that reference again.
>  - last free of a ctrl or subsystem also drops a reference, with
>    the final free releasing the ida

Let me step through an example:

  Ctrl A gets instance 0.

  Its subsystem gets the same instance, and takes ref count on it:
  all namespaces in this subsystem will use '0'.

  Ctrl B gets instance 1, and it's in the same subsystem as Ctrl A so
  no new subsytem is allocated.

  Ctrl A is disconnected, dropping its ref on instance 0, but the
  subsystem still has its refcount, making it unavailable.

  Ctrl A is reconnected, and allocates instance 2 because 0 is still in
  use.

Now all the namespaces in this subsystem are prefixed with nvme0, but no
controller exists with the same prefix. We still have inevitable naming
mismatch, right?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
