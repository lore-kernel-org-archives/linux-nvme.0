Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FA1C433EF
	for <linux-nvme@archiver.kernel.org>; Sun,  6 Mar 2022 23:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j8n0+QqkdDPjwgcOvj6gUVu6GcOMpNvxy/MgXXJChyA=; b=wkUms+f2ER7Swo0hQ4QoRglMN7
	LxW6gIJzPs+HfMwOyoSnd3mF0IoriwQGtT8CPba7/2BJDih20PWY3eq3R8FhNeyLo0olT5dtPa3qK
	Pg8lpzE6+t1SVO38opI+7QhLrGeZylYXU40NHgvHLI96R3INv7jnf+BBWAgN0I7GUR+KNx644HIqP
	6FXmXz53MzuCghZnmHfUik8bpmaHYhIU4R+FDsqi4KMPLT7E4BXsb0EOPp2lTuADK87AGImPNqLrM
	ywqFEpil+i/630jAKmqMVNGoCpL3pQOgqMzYyEV8ndb5luGBn5Awz5YApZEhqR1m4fMU/Puz+lreq
	9VKN+xmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nR08A-00FPfp-J6; Sun, 06 Mar 2022 23:17:38 +0000
Received: from mail104.syd.optusnet.com.au ([211.29.132.246])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nR086-00FPfH-SI
 for linux-nvme@lists.infradead.org; Sun, 06 Mar 2022 23:17:36 +0000
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au
 [49.186.17.0])
 by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 3710D530183;
 Mon,  7 Mar 2022 10:17:29 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
 (envelope-from <david@fromorbit.com>)
 id 1nR07z-002NgX-MB; Mon, 07 Mar 2022 10:17:27 +1100
Date: Mon, 7 Mar 2022 10:17:27 +1100
From: Dave Chinner <david@fromorbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me, kbusch@kernel.org,
 song@kernel.org, linux-block@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] block: remove the per-bio/request write hint
Message-ID: <20220306231727.GP3927073@dread.disaster.area>
References: <20220304175556.407719-1-hch@lst.de>
 <20220304175556.407719-2-hch@lst.de>
 <20220304221255.GL3927073@dread.disaster.area>
 <20220305051929.GA24696@lst.de>
 <20220305214056.GO3927073@dread.disaster.area>
 <2241127c-c600-529a-ae41-30cbcc6b281d@kernel.dk>
 <20220306180115.GA8777@lst.de>
 <f08db783-a665-2df6-5d8e-597aacd1e687@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f08db783-a665-2df6-5d8e-597aacd1e687@kernel.dk>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=6225410a
 a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
 a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8
 a=iA7CECttYVG2FqG4ICsA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
 a=biEYGPWJfzWAr4FL6Ov7:22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220306_151735_120148_E17B5DEE 
X-CRM114-Status: GOOD (  18.76  )
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

On Sun, Mar 06, 2022 at 11:06:12AM -0700, Jens Axboe wrote:
> On 3/6/22 11:01 AM, Christoph Hellwig wrote:
> > On Sun, Mar 06, 2022 at 10:11:46AM -0700, Jens Axboe wrote:
> >> Yes, I think we should kill it. If we retain the inode hint, the f2fs
> >> doesn't need a any changes. And it should be safe to make the per-file
> >> fcntl hints return EINVAL, which they would on older kernels anyway.
> >> Untested, but something like the below.
> > 
> > I've sent this off to the testing farm this morning, but EINVAL might
> > be even better:
> > 
> > http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/more-hint-removal

Yup, I like that.

> I do think EINVAL is better, as it just tells the app it's not available
> like we would've done before. With just doing zeroes, that might break
> applications that set-and-verify. Of course there's also the risk of
> that since we retain inode hints (so they work), but fail file hints.
> That's a lesser risk though, and we only know of the inode hints being
> used.

Agreed, I think EINVAL would be better here - jsut make it behave
like it would on a kernel that never supported this functionality in
the first place. Seems simpler to me for user applications if we do
that.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

