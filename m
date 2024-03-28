Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D196FC54E64
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 05:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X61QQw1+F4e8UchUe9jSX4VbRxVeT2EG7tPD7tFlSGw=; b=44R7pYv4qRdXUCnn3ndGxb300q
	75TdtnXKxljosJGuq1N732RCv4CMKCCNpuIHcUxIfbnpJ0+EFG+6xTQDXoKlMZZeILbPoAPsy3LzW
	gThueOxRfyeblFIZhv6hefiurnTgNh/6G3P9ePG+F8S3bp69s/sLRSBVMqGoox33ptUtPvgtJ9umP
	2EbWNZOw11VM2AMaomAslDEYx4I8bMDezZR4aZffa14WbcnYgeL5UAJvd6V48MQIGzKno8GzRqdw2
	GWDOzh5UyXhw5jYU4eGSE8vn9xV81sb7DuVutCduAA+5n7pZ7vM1C2yMa2K84oXj5qM2mRLoBvTwS
	SLgW8YNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpibL-0000000Cbdn-1egi;
	Thu, 28 Mar 2024 05:46:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpibH-0000000CbdO-3sO5
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 05:46:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6119C68B05; Thu, 28 Mar 2024 06:46:52 +0100 (CET)
Date: Thu, 28 Mar 2024 06:46:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v3 09/30] block: Pre-allocate zone write plugs
Message-ID: <20240328054652.GA16237@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org> <20240328004409.594888-10-dlemoal@kernel.org> <20240328043016.GA13701@lst.de> <714d0cbc-be4d-4aa9-b200-73c6caaa1d18@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <714d0cbc-be4d-4aa9-b200-73c6caaa1d18@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_224656_136191_37438689 
X-CRM114-Status: GOOD (  17.90  )
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

On Thu, Mar 28, 2024 at 02:28:40PM +0900, Damien Le Moal wrote:
> That was my thinking initially as well, which is why I did not have the
> grace period. However, getting a reference on a plug is a not done under
> disk->zone_wplugs_lock and is thus racy, albeit with a super tiny time
> window: the hash table lookup may "see" a plug that has already been
> removed and has a refcount dropped to 0 already. The use of
> atomic_inc_not_zero() prevents us from trying to keep using that stale
> plug, but we *are* referencing it. So without the grace period, I think
> there is a risk (again, super tiny window) that we start reusing the
> plug, or kfree it while atomic_inc_not_zero() is executing...
> I am overthinking this ?

Well.  All the lookups fail (or should fail) when BLK_ZONE_WPLUG_UNHASHED
is set, probably even before even trying to grab a reference.  So all
the lookups for a zone that is beeing torn down will fail.  Now once
the actual final reference is dropped, we'll now need to clear
BLK_ZONE_WPLUG_UNHASHED and lookup can happe again.  We'd have a race
window there, but I guess we can plug it by checking for the right
zone number?  If we it while it already got reduce that'll still fail
the lookup.

