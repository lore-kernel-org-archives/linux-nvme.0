Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98D2C25B76
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Jun 2024 05:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lbm1kVGcmOM+XzpzZi8WDrCvDIH13qGyXAURLwgVzmM=; b=JtZiPz0wZX0X5FUYJHsuKPuLIn
	2fm4s+SN3dzZAEp4af1kAMbHFAwi/YWmY8T9nXN8vR64OSJ1Sl5TWxIW3uIk17Oc8SUevxa/fQh4j
	Plws2i+yJMAkMHl2iBoLDbePJkKKmevGEtVKyT2cxZBbXZh2ReA4cT6KbOq4IpvQQ7WCFjvHMt7Cm
	3XFh/VKYwAcT851j+mdmWroNoTrGTbj6GqR3pM+z6xF9XIeJ9HGfMXOi5gglqtSU+9F8CZ+3EJnWO
	SEabcvq7wO4XPyrGOMCyXKG8YFse+hUd6JJiRtt2jEpdNaV50ZpxmxnvYk/LGU3wAbrVPXJBvO/jQ
	CSah2WsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDHkN-0000000C2Gv-1hYt;
	Sat, 01 Jun 2024 05:57:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDHkJ-0000000C2GW-3lV4
	for linux-nvme@lists.infradead.org;
	Sat, 01 Jun 2024 05:57:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B4E3468D17; Sat,  1 Jun 2024 07:57:35 +0200 (CEST)
Date: Sat, 1 Jun 2024 07:57:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Nitesh Shetty <nj.shetty@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, david@fromorbit.com, hare@suse.de,
	damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
	joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
Message-ID: <20240601055735.GA5772@lst.de>
References: <20240520102033.9361-1-nj.shetty@samsung.com> <CGME20240520102842epcas5p4949334c2587a15b8adab2c913daa622f@epcas5p4.samsung.com> <20240520102033.9361-3-nj.shetty@samsung.com> <eda6c198-3a29-4da4-94db-305cfe28d3d6@acm.org> <9f1ec1c1-e1b8-48ac-b7ff-8efb806a1bc8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f1ec1c1-e1b8-48ac-b7ff-8efb806a1bc8@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_225740_190072_83620FB9 
X-CRM114-Status: GOOD (  15.16  )
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

On Wed, May 29, 2024 at 04:48:18PM +0900, Damien Le Moal wrote:
> > Yes, in this case copy won't work, as both src and dst bio reach driver
> > as part of separate requests.
> > We will add this as part of documentation.
> 
> So that means that 2 major SAS HBAs which set this flag (megaraid and mpt3sas)
> will not get support for copy offload ? Not ideal, by far.

We really need to ignore the normerges flag for this.
As should we for the precedence in the discard merging.

And the drivers need to stop setting this flag as they have no business
to, but that's a separate discussion (and the flag can still be set
manually).


