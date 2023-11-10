Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA61C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Nov 2023 06:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mKeGoSjtOIedMQfB3Zp5/mmosB8vjO4uPyQw1AKPgCY=; b=zjzANtkI1zcPe94rf2K6Vjdp7p
	bCnTBENogGKvPZg2p+6BBwdiJaDSpKi9cxuzYXmFmeXW7Qem5TeMdE//1fyBDtNZ4FO4Ja/xvseHp
	KQpruQjTTrJJr1JT41d2ts8Lz9Vg8H2J3pMEuzOR+lU2wEVDsipeUX8/kMxLTnV10lziDwYOYUrC+
	lCUPMj26aQYUbQys1piKwfIjPlEz0XB1saWzDitB/gmB/82WAuHNXqaBa4vWgsvoXTth3KpDKF+aK
	R517I9H2bz8KUvcHyyvTTJ2Z1l0rIwGUpK1vQ3Y01uqKeLFhuS0BFN5ZoPLbHFpt0Awb1xSL4o1ky
	GPgc4b9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1Kvb-007x7s-2t;
	Fri, 10 Nov 2023 06:23:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1KvY-007x6U-1V
	for linux-nvme@lists.infradead.org;
	Fri, 10 Nov 2023 06:23:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F1E8068AA6; Fri, 10 Nov 2023 07:23:25 +0100 (CET)
Date: Fri, 10 Nov 2023 07:23:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
	djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org,
	Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH 01/21] block: Add atomic write operations to
 request_queue limits
Message-ID: <20231110062325.GB26516@lst.de>
References: <20230929102726.2985188-1-john.g.garry@oracle.com> <20230929102726.2985188-2-john.g.garry@oracle.com> <20231109151013.GA32432@lst.de> <b7f1b93a-08ea-07c8-d1da-5c2a31d1be80@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7f1b93a-08ea-07c8-d1da-5c2a31d1be80@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231109_222336_645751_D64E9F27 
X-CRM114-Status: GOOD (  15.17  )
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

On Thu, Nov 09, 2023 at 05:01:10PM +0000, John Garry wrote:
> Generally they come from the same device property. Then since 
> atomic_write_unit_max_bytes must be a power-of-2 (and 
> atomic_write_max_bytes may not be), they may be different.

How much do we care about supporting the additional slack over the
power of two version?  

> In addition, 
> atomic_write_unit_max_bytes is required to be limited by whatever is 
> guaranteed to be able to fit in a bio.

The limit what fits into a bio is UINT_MAX, not sure that matters :)

> atomic_write_max_bytes is really only relevant for merging writes. Maybe we 
> should not even expose via sysfs.

Or we need to have a good separate discussion on even supporting any
merges.  Willy chimed in that supporting merges was intentional,
but I'd really like to see numbers justifying it.


