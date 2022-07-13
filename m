Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC47CC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 15:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mJjBmMAXT2h6I0nmMQuW56J/7RtTYtOpHF5Tj5AvOWE=; b=emqPrVIoVzo9+WCUYFX47SXVjY
	6cVmBSTkBmCS0B2XfGQK4UuxGT3wjnxgVIZjPOPDP0g0tI+2H5XOhiVqZF3+yOrPzU8D064YronHT
	ecX83wfYiEw+AJjl9sNpp/RfBlepkVQo729hKwxoTPGths7FOUjzS8sDktj4JD7powxPt+UfWtMHh
	/Ra9wIZdHTd7EOvZtw2nOC6z5/L6yJzVOlN6hldDDSGpOxUoEfRyrTEwbd1xac4Zjt+7pHigvywHf
	KN9YLBMbBiVx0GcGBVsTnWpZeMmza0ZJKeoMIJZygEh877FzV47Xue32+7tzo3mvyPc1+f/JePcVd
	PVJSbHpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBdrF-004pz1-Rp; Wed, 13 Jul 2022 15:00:57 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBbKi-003SNz-3f
	for linux-nvme@bombadil.infradead.org; Wed, 13 Jul 2022 12:19:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mJjBmMAXT2h6I0nmMQuW56J/7RtTYtOpHF5Tj5AvOWE=; b=WMa19WfnzPViDLABSHs3QnQmSW
	4Yn9G+E+X+eHmXygmZ9SJISv+OjO4Uet8m9+0J8uKFMeGLXluy40BJGPVnAieJzm0fn+vmh5jDS9P
	d3JN2TlJCNWWpUL/PwQSv79shcoOlUdWO8TcM5BkVLX7NU45Y9z78/dU4PHkKFkcIexCFJs2m9R+R
	RG5tg4d9l0HcbjratWoNf9PCm/ofpp7zdYUZbpwPLjnqq6Y/iHgZMgpPulPD8LAUwZW4PtUZ390qa
	lAEs/1h8We8KTGbsylxYgERHE/pMWH+Lui46xp88dsXquY86RVjWfA5/O9QucoBk9BC5KebK2lgkR
	+dJ/tBoA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBbKd-008Alv-T2; Wed, 13 Jul 2022 12:19:07 +0000
Date: Wed, 13 Jul 2022 13:19:07 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, axboe@kernel.dk, agk@redhat.com,
	song@kernel.org, djwong@kernel.org, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
	viro@zeniv.linux.org.uk, javier@javigon.com,
	johannes.thumshirn@wdc.com, bvanassche@acm.org,
	dongli.zhang@oracle.com, ming.lei@redhat.com,
	jefflexu@linux.alibaba.com, josef@toxicpanda.com, clm@fb.com,
	dsterba@suse.com, jack@suse.com, tytso@mit.edu,
	adilger.kernel@dilger.ca, jlayton@kernel.org, idryomov@gmail.com,
	danil.kipnis@cloud.ionos.com, ebiggers@google.com,
	jinpu.wang@cloud.ionos.com
Subject: Re: [PATCH V2 0/6] block: add support for REQ_OP_VERIFY
Message-ID: <Ys64O6malGAbslBL@casper.infradead.org>
References: <20220713072019.5885-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713072019.5885-1-kch@nvidia.com>
X-Mailman-Approved-At: Wed, 13 Jul 2022 08:00:42 -0700
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

On Wed, Jul 13, 2022 at 12:20:13AM -0700, Chaitanya Kulkarni wrote:
> Hi,
> 
> One of the responsibilities of the Operating System, along with managing
> resources, is to provide a unified interface to the user by creating
> hardware abstractions. In the Linux Kernel storage stack that
> abstraction is created by implementing the generic request operations
> such as REQ_OP_READ/REQ_OP_WRITE or REQ_OP_DISCARD/REQ_OP_WRITE_ZEROES,
> etc that are mapped to the specific low-level hardware protocol commands 
> e.g. SCSI or NVMe.

Still NAK, see previous thread for reasons.  Somewhat disappointing that
you sent a new version instead of addressing those comments first.

