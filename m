Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664BCC27C52
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Jun 2024 05:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y/7NU+GHWK4+dLJ8ltEoDJuTmeRXw13miLkF9Iv15vs=; b=DWK6jWqbg3EYXRAmEpIBiVPLP0
	X4oD5vNzxtbK2QHedpyRZbXsg2nrC71Ci2BO29vAlRUmaFiqlkVB/1UK9Bcfw3R/iSAJtVLoFeC2n
	c8TlX2rckHpNdpxUbI3T2Yqa342EiKKswV490IeyyhTC640vox1PjbKALyuJsVLMPEzswbrQsJq+e
	0bv8pdcPCDwzXNpuFAWhFz6RnC2I8dZzwb6VUw/li+x38lnepk8zD8Ad5zQkYsTt9JExXkd0Eu2LY
	SXVVi8T8ARE/xih+tNRbiKPbRpj5T2WZhd7JcKUujOc0VAgUK/YM/NakIdvxdl43wiCN0kgzjdHRv
	AWlTLXfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sF5sl-00000008QLW-0TJr;
	Thu, 06 Jun 2024 05:41:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sF5si-00000008QKG-1F6N
	for linux-nvme@lists.infradead.org;
	Thu, 06 Jun 2024 05:41:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5391A68CFE; Thu,  6 Jun 2024 07:41:44 +0200 (CEST)
Date: Thu, 6 Jun 2024 07:41:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
	djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	dchinner@redhat.com, jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com, willy@infradead.org,
	Prasad Singamsetty <prasad.singamsetty@oracle.com>
Subject: Re: [PATCH v7 2/9] fs: Initial atomic write support
Message-ID: <20240606054143.GB9123@lst.de>
References: <20240602140912.970947-1-john.g.garry@oracle.com> <20240602140912.970947-3-john.g.garry@oracle.com> <20240605083015.GA20984@lst.de> <fbb835ff-f1ae-4b59-8cb3-22a11449d781@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbb835ff-f1ae-4b59-8cb3-22a11449d781@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_224148_510309_27E19906 
X-CRM114-Status: GOOD (  21.20  )
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

On Wed, Jun 05, 2024 at 11:48:12AM +0100, John Garry wrote:
> I have no strong attachment to that name (atomic).
>
> For both SCSI and NVMe, it's an "atomic" feature and I was basing the 
> naming on that.
>
> We could have RWF_NOTEARS or RWF_UNTEARABLE_WRITE or RWF_UNTEARABLE or 
> RWF_UNTORN or similar. Any preference?

No particular preference between any of the option including atomic.
Just mumbling out aloud my thoughts :)

> For io_uring/rw.c, we have io_write() -> io_rw_init_file(..., WRITE), and 
> then later we set IOCB_WRITE, so would be neat to use there. But then 
> do_iter_readv_writev() does not set IOCB_WRITE - I can't imagine that 
> setting IOCB_WRITE would do any harm there. I see a similar change in 
> https://lore.kernel.org/linux-fsdevel/167391048988.2311931.1567396746365286847.stgit@warthog.procyon.org.uk/
>
> AFAICS, setting IOCB_WRITE is quite inconsistent. From browsing through 
> fsdevel on lore, there was some history in trying to use IOCB_WRITE always 
> instead of iov_iter direction. Any idea what happened to that?
>
> I'm just getting the feeling that setting IOCB_WRITE in 
> kiocb_set_rw_flags() is a small part - and maybe counter productive - of a 
> larger job of fixing IOCB_WRITE usage.

Someone (IIRC Dave H.) want to move it into the iov_iter a while ago.
I think that is a bad idea - the iov_iter is a data container except
for the shoehorned in read/write information doesn't describe the
operation at all.  So using the flag in the iocb seems like the better
architecture.  But I can understand that you might want to stay out
of all of this, so let's not touch IOCB_WRITE here.


