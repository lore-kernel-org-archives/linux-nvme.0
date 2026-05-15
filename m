Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF989CD4F3C
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2026 04:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VWUnWBaKVAFh8B3iRrDg3pGnhOw3VUUYCnmOcZ8H2GU=; b=PESX1G4ls0sJpSgmTKyBCV9WUa
	mrE5Q09RvionqBEMazinmzdH/4LCwNLjUvpZE4NZ/6ed98PVXzJ10jbcvHtepGiL5pL1cgFHrNHZB
	bUjhVSvZKdYYx6hWyHaUnkcuwdJlJaqXUHN6TNh04MS45PBrpEUG9Fm24TF2JxqpefvyZ0xa94z5f
	T1ngHGlfL2yVPhHbD6N1DEkJ+gOMKWkRyh2sU2LwvP0HZad3eLJ5hf8uNN5kMI+UZkm+kQ7h0PTXf
	vO0/yxb7MfsZnNlOrZPiycyxk6pJhGfchIeWeFUGlzqS478d01isQG5F7i50lMt4KjZSOpAnVvmQm
	02AsdWXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNkQY-00000007Kuw-24oe;
	Fri, 15 May 2026 04:45:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNkQW-00000007KuV-3Mas
	for linux-nvme@lists.infradead.org;
	Fri, 15 May 2026 04:45:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6055068BEB; Fri, 15 May 2026 06:45:29 +0200 (CEST)
Date: Fri, 15 May 2026 06:45:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	linux-nvme@lists.infradead.org, bmarzins@redhat.com
Subject: Re: [PATCH] nvme: use DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE for
 multipath_sysfs
Message-ID: <20260515044529.GA4003@lst.de>
References: <20260513095030.2771178-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513095030.2771178-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_214532_982774_56BF6577 
X-CRM114-Status: GOOD (  12.02  )
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

On Wed, May 13, 2026 at 09:50:30AM +0000, John Garry wrote:
> Use DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE instead of
> DEFINE_SYSFS_GROUP_VISIBLE, which means that we can drop
> multipath_sysfs_attr_visible().
> 
> Incidentally, multipath_sysfs_attr_visible() should have returned a
> umode_t.

Looks ok, although all the magic symbol name concatenation in the
sysfs code drives me a bit crazy.

Signed-off-by: Christoph Hellwig <hch@lst.de>

