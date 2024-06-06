Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2881C25B75
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Jun 2024 13:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p7tTRfP93oW43tM94X+26qoMDGFVf+JmM/auxT1ZuaE=; b=ztgak1uSZluus5EAT9IhypNj1E
	dOxezW6dcIQSxNwOyFJssZDRVfA+sPOPzK9d0Az41CVO++CC8Tzf87AhT3IvAv2dTqTiG0N4TNlwu
	xeR5ry7ZzYg31aY5VGDK53rk6I1VUAlhtwwmFe3uAdyCMFdqeCHNIvcZ4RYHnTijXYw0RGn0yzOjH
	82HNt0uOYcJ/OcWPbdBv6WclXyZfMYRshYSlglXsKZFNeC/ujUTZ6yYeJOYNs9Oz6/sFv2jTvwPKb
	DjDSIbBVGShF66wHUnck6L4xtodzEX6hUxQ1DTOdZiwOzNeR5ClMUtox46JQ+iSVIQ5YgZAwVIcTw
	mXloErXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFDNy-00000009wrh-265C;
	Thu, 06 Jun 2024 13:42:34 +0000
Received: from pa49-179-32-121.pa.nsw.optusnet.com.au ([49.179.32.121] helo=rh)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFDNr-00000009wqR-0ssC
	for linux-nvme@lists.infradead.org;
	Thu, 06 Jun 2024 13:42:29 +0000
Received: from localhost ([::1] helo=rh)
	by rh with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <dchinner@redhat.com>)
	id 1sFCWF-00000005tvr-0Pit;
	Thu, 06 Jun 2024 22:47:03 +1000
Date: Thu, 6 Jun 2024 22:47:01 +1000
From: Dave Chinner <dchinner@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
	djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com, willy@infradead.org,
	Prasad Singamsetty <prasad.singamsetty@oracle.com>
Subject: Re: [PATCH v7 2/9] fs: Initial atomic write support
Message-ID: <ZmGvxZA6if7_bl63@rh>
References: <20240602140912.970947-1-john.g.garry@oracle.com>
 <20240602140912.970947-3-john.g.garry@oracle.com>
 <20240605083015.GA20984@lst.de>
 <fbb835ff-f1ae-4b59-8cb3-22a11449d781@oracle.com>
 <20240606054143.GB9123@lst.de>
 <cb5e9d41-c625-43b0-aeda-591b4f7edfaf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb5e9d41-c625-43b0-aeda-591b4f7edfaf@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240606_064227_266995_57BA4D09 
X-CRM114-Status: GOOD (  18.30  )
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

On Thu, Jun 06, 2024 at 07:38:41AM +0100, John Garry wrote:
> On 06/06/2024 06:41, Christoph Hellwig wrote:
> > On Wed, Jun 05, 2024 at 11:48:12AM +0100, John Garry wrote:
> > > I have no strong attachment to that name (atomic).
> > > 
> > > For both SCSI and NVMe, it's an "atomic" feature and I was basing the
> > > naming on that.
> > > 
> > > We could have RWF_NOTEARS or RWF_UNTEARABLE_WRITE or RWF_UNTEARABLE or
> > > RWF_UNTORN or similar. Any preference?
> > 
> > No particular preference between any of the option including atomic.
> > Just mumbling out aloud my thoughts :)
> 
> Regardless of the userspace API, I think that the block layer terminology
> should match that of the underlying HW technology - so I would plan to keep
> "atomic" in the block layer, including request_queue sysfs limits.
> 
> If we used RWF_UNTORN, at some level the "atomic" and "untorn" terminology
> would need to interface with one another. If it's going to be insane to have
> RWF_UNTORN from userspace being translated into REQ_ATOMIC, then I could
> keep RWF_ATOMIC.
> 
> Someone please decide ....

RWF_ATOMIC for the user interface, please. An "atomic" IO operation is
easy for application developers to understand and reason about,
whilst "untorn" or some variant of "torn" will require us having to
repeated explain that it is a technical storage term that simply
means "the IO will be completed atomically".

-Dave.
-- 
Dave Chinner
dchinner@redhat.com

