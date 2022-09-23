Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BD7C6FA8B
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Sep 2022 15:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U2GBoTlUUzXWekHFJz6mXCmgTVG6B81NWa8OCvWXOw0=; b=4nAa0DvPVloPMrEjvVJJG3kbU1
	DmVgl4F5zP8/yjvcBPoh/YDwlpa1XJEIXkQfM+ksUaDFWyJNyMDnFyzVaFCV6x5bsflJhE8qG8d3U
	Wwc8WgVNZXCielRmeB5fissFs4QE85Mk0D7IrrQcpW5AerMO7PB8EIrkms475vKz7lcBWMS/2bzr6
	tp9vzQma5nKXfyStuH0YX20GU55t4t5fPRlI6pzK7gZSR1UemlhJcYxoKw5hUZw22NaQeq2+QX0+V
	jtKMdMuG27Yn4Wn2NQobOWQaw5khxVpPuBQy0nGVNCFuxjjGcmPnUGPPKi1AcS6dOiLD5WRkv0UN2
	9g6pz5ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obkV1-004nMA-TD; Fri, 23 Sep 2022 15:21:55 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obkV0-004nLV-CI; Fri, 23 Sep 2022 15:21:54 +0000
Date: Fri, 23 Sep 2022 08:21:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCHSET 0/5] Enable alloc caching and batched freeing for
 passthrough
Message-ID: <Yy3PEjD2pkSq84RW@infradead.org>
References: <20220922182805.96173-1-axboe@kernel.dk>
 <Yy3NyACongSfayY+@infradead.org>
 <6f7600be-d4b9-aeac-7dd1-71992a4dd5e8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f7600be-d4b9-aeac-7dd1-71992a4dd5e8@kernel.dk>
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

On Fri, Sep 23, 2022 at 09:19:15AM -0600, Jens Axboe wrote:
> On 9/23/22 9:16 AM, Christoph Hellwig wrote:
> > On Thu, Sep 22, 2022 at 12:28:00PM -0600, Jens Axboe wrote:
> >> This is good for a 10% improvement for passthrough performance. For
> >> a non-drive limited test case, passthrough IO is now more efficient
> >> than the regular bdev O_DIRECT path.
> > 
> > How so?  If it ends up faster we are doing something wrong in the
> > normal path as there should be no fundamental difference in the work
> > that is being done.
> 
> There's no fundamental difference, but the bdev path is more involved
> than the simple passthrough path.

Well, I guess that means there is some more fat we need to trim
then..

