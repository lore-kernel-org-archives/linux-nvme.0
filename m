Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803B0CD11C2
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Apr 2024 23:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FXmAKscTbgNJ1p29Two6+cxbrIyx3G8HLoeSBvRIChc=; b=LtxyqnvbgUk1LP3hdFqD7eDANc
	ecO3qynVPnLAPHxZPuYv+e1eIC9PazzZ7XG3prpOKyveN5N//1TEwIIT19Kac2h4hssjJA53PyQKS
	ML1QhwKWEc4TYB7HVZD6q1780PpLbEJ114/XGDWm/4odAqRUVM6MfAQ/wmG6BIqaDx3dp+CWCo3uu
	G6+4JtCWRD3mhq7OCjgGA7ybxYxkC/x2rQsWYi0pfKG5K3a7fjoLnjqy5pUGSAehUUIerLQgOAxgP
	84iSIQOJJ7McqYvLRxXN6OLn36F6IcOTKPhxOTDjNWjMzfpjn0aYojof2xjCnWwf9kzkBH7QpQz5e
	Al5pq/4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruhSR-00000009Tj1-0zog;
	Wed, 10 Apr 2024 23:34:23 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruhSN-00000009Tii-29zF;
	Wed, 10 Apr 2024 23:34:19 +0000
Date: Wed, 10 Apr 2024 16:34:19 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com, willy@infradead.org,
	Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v6 05/10] block: Add core atomic write support
Message-ID: <Zhch-6XSPYxM4ku3@bombadil.infradead.org>
References: <20240326133813.3224593-1-john.g.garry@oracle.com>
 <20240326133813.3224593-6-john.g.garry@oracle.com>
 <0a9fb564-7129-4153-97d6-76e9b3a1b6c1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a9fb564-7129-4153-97d6-76e9b3a1b6c1@infradead.org>
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

On Tue, Mar 26, 2024 at 10:11:50AM -0700, Randy Dunlap wrote:
> Hi,
> 
> On 3/26/24 06:38, John Garry wrote:
> > diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
> > index 1fe9a553c37b..4c775f4bdefe 100644
> > --- a/Documentation/ABI/stable/sysfs-block
> > +++ b/Documentation/ABI/stable/sysfs-block
> > +What:		/sys/block/<disk>/atomic_write_boundary_bytes
> > +Date:		February 2024
> > +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
> > +Description:
> > +		[RO] A device may need to internally split I/Os which
> > +		straddle a given logical block address boundary. In that
> > +		case a single atomic write operation will be processed as
> > +		one of more sub-operations which each complete atomically.
> 
> 		    or

If *or* was meant, wouldn't it be better just to say one or more
operations may be processed as one atomically in this situation?

  Luis

