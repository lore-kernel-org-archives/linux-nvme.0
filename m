Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15056C4167B
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 16:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ujJ5bOX4/yG/GztGrk3gkCn/PAMB9JMbGaB7uJw6evI=; b=hd6B0GSSwzpq/xfOQEc7dEVGDv
	uUtDlJalwKBmqjXeeZHrer0AHoLqdBHtdMKyVfDUVmQmL6i0KMnkBdteQ9dFWKQ117hyExFrbLwj1
	rFZV7jhvDi6cHCpHeDplzc9u5PJoyywVOyKIUFh91I6lbe49h3UsgJePxHAGIi2rUx6uzx36pD1qT
	2B+Z6hj3ibvpKS3xEn7/Q+UXbccQnKNIVq2hrVtYGjOEOpg49kwFfe0z2PuxjK8mfr1vc6huxpQus
	T577pZg3gNDhVh0HBsFnD9LBrYUQIvG1e1Es6+wBkyzoOzUdlSnTj7fxMkb4uP3w4Q+cSXiuRV2Md
	sCpVwr1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDRiQ-00FNzG-0k;
	Wed, 13 Dec 2023 16:04:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDRiN-00FNxF-0F
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 16:04:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BDB9E68B05; Wed, 13 Dec 2023 17:03:57 +0100 (CET)
Date: Wed, 13 Dec 2023 17:03:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, dchinner@redhat.com, jack@suse.cz,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ming.lei@redhat.com,
	jaswin@linux.ibm.com, bvanassche@acm.org
Subject: Re: [PATCH v2 04/16] fs: Increase fmode_t size
Message-ID: <20231213160357.GA9804@lst.de>
References: <20231212110844.19698-1-john.g.garry@oracle.com> <20231212110844.19698-5-john.g.garry@oracle.com> <20231213-gurte-beeren-e71ff21c3c03@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213-gurte-beeren-e71ff21c3c03@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_080403_257031_3FB5BA61 
X-CRM114-Status: GOOD (  10.48  )
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

On Wed, Dec 13, 2023 at 02:02:31PM +0100, Christian Brauner wrote:
> >  typedef unsigned int __bitwise gfp_t;
> >  typedef unsigned int __bitwise slab_flags_t;
> > -typedef unsigned int __bitwise fmode_t;
> > +typedef unsigned long __bitwise fmode_t;
> 
> As Jan said, that's likely a bad idea. There's a bunch of places that
> assume fmode_t is 32bit. So not really a change we want to make if we
> can avoid it.

Oh well, let me dust of my series to move the fairly static flags out
of it.  But even without that do we even need to increase it?  There's
still quite a lot of space after FMODE_EXEC for example.

