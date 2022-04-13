Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0EBBC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Apr 2022 17:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N/h+XG62LOmztwJNT9Rq5RAnd6P0NGj1ANra9bNZUK0=; b=w8QxmRvqpqNxxYEz1H3vyqOvCL
	lGxGomIRlBXRGm6S7ablF5hhhSDWU531qy6QI74LqbULaZrzwfdRnLjVaLQa3OhdCGStnbt7+HOTo
	9psQcU+o1qYxe5wqFqwg/TdKqAGwcEsortXEeQouXwf8PgiROzI4n6U58rYMPBINIFk7FIttcRFAg
	VxoIJxIb5TW4nTcRg7XsW8kLzio4TjCFmMN6H4xxRZ6fCTbd3Dt0bkWHyI+R8SpmlRJGqcxp4FeR0
	Ak+YMZ2zd462g7T2D9RtiyU/wdvmP3bUPcGjpMdB9fw3zaA3Yrtdha6sBAMf6UPR3VDM2rHA+V2aT
	JfIBwXsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1negUz-001tpU-KF; Wed, 13 Apr 2022 17:09:45 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1negUv-001tnQ-Ja
 for linux-nvme@lists.infradead.org; Wed, 13 Apr 2022 17:09:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 35BE7B82651;
 Wed, 13 Apr 2022 17:09:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE95C385A3;
 Wed, 13 Apr 2022 17:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649869778;
 bh=a8TfYVOqaqHIrxTugQbWQ4Xn/hiT/gbieZKgDwKQi98=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uk0EmsntB7Sd92Ya8TRf4A9kWG4R40zFlIGTOpVDFRMwJQZP2O/281VntMaQoKZ9Y
 rM4Bpcqqf5d5IYhhB2r2TCVn9aFvCw//A2rlcA77WeaV84MbGCQW9K+S6Y1OWIlYiA
 eSIM7NkBXJW8MskRK+EIuvhYpR0hDy5N1It7y5q18lqZGMWgobD9HMK39qIMT7tHyE
 Y6CD293XE0JPIN+HMSX+qhQ3/XQ8+TX+7FrPQz09Al6RL0WMUh04JryUOxVHbLxtQN
 XKs09bSVVLJ6gaMynDakiw6055XLu3eUNOOfdvtRqw6hHJSDNKt7WOYjXOFV++VJCK
 1e2I0KC/a7jgw==
Date: Wed, 13 Apr 2022 11:09:35 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jonathan Derrick <jonathan.derrick@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: Re: [PATCH 3/3] nvme-core: mark internal passthru req REQ_QUIET
Message-ID: <YlcDz4x+PNLgsSCQ@kbusch-mbp.dhcp.thefacebook.com>
References: <20220411031249.5158-1-kch@nvidia.com>
 <20220411031249.5158-4-kch@nvidia.com>
 <cf4534ec-c8d1-c020-2079-5636177ca1b5@linux.dev>
 <20220413165238.GA31786@lst.de>
 <fed97517-201f-f7a8-04ee-4a12698b4e41@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fed97517-201f-f7a8-04ee-4a12698b4e41@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220413_100941_826304_01F994A1 
X-CRM114-Status: GOOD (  18.52  )
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

On Wed, Apr 13, 2022 at 10:57:19AM -0600, Jonathan Derrick wrote:
> 
> 
> On 4/13/2022 10:52 AM, Christoph Hellwig wrote:
> > On Wed, Apr 13, 2022 at 10:49:33AM -0600, Jonathan Derrick wrote:
> > > >    +	req->rq_flags |= RQF_QUIET;
> > > Any reason to not make it a part of flags in the argument list and let the
> > > block layer build the req with it?
> > > 
> > > eg:
> > > flags |= REQ_QUIET;
> > 
> > Because there is not REQ_QUIET, just RQF_QUIET and BIO_QUIET, and their
> > relation isn't quite as straightforward as it seems.
> 
> Well let's suppose I had written RQF_QUIET instead of the non-existent
> REQ_QUIET

The "flags" value passed to blk_mq_alloc_request() is not the same as the
values for rq_flags, though.

I guess you could add a new allocation flag, maybe called something like
BLK_MQ_REQ_QUIET to tell the block layer to set RQF_QUIET. That is similiar to
how BLK_MQ_REQ_PM is used for RQF_PM, but I'm not sure we want to add another
'if' check in the fast path.

