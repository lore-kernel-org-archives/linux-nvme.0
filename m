Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540C7C02183
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jan 2025 21:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HlnWc82qbOiirT90TDTw4a7b5CQsVGTkoX6CUoayrXo=; b=q0WeMz67CEgTAzwRrP82AJdwqG
	DUeRFfd6FPca6orWC0hj8KnJIRv3qoDmKv8fBGV5tGlN9VGJUPcmu2E5WF0Km90VqqotHVGPbrjzU
	nzUNY9MPRkkpkt8SYi+xJvmbGSaCpNXpFEq9tbKDAhTe/cIU/0G1nUe6QXgP80Hp6nSTNsaVxiyFC
	1AsWveP9VbBbIfe13dwg4GtFHFX1vIcYM1szg4/tFDV6/eiMxMwDRacuD5HhNFOxlitD0s3UH5jFW
	i33sJE1r3qcNCVPh9ktLGGRzCJQQezFdZNGvIYDs+Y4lQffqjvsV/q7x03uh77ehDzuAB+CNaQvNk
	wTV3RCQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYuFP-00000001Qhc-2XJQ;
	Fri, 17 Jan 2025 21:51:23 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYuFN-00000001QhI-1gVu
	for linux-nvme@lists.infradead.org;
	Fri, 17 Jan 2025 21:51:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id AA7B1A43427;
	Fri, 17 Jan 2025 21:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9A3C4CEDD;
	Fri, 17 Jan 2025 21:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737150680;
	bh=FRpjS2wIB0Lhe5eU5biRWpurnDwG7XTpJwMfPQLrmxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rCxuYe4bGhBnXfwsLJT0dKNJv6Ceh6kemVixJOPc4/yz2CgwAZ9u4tv+jHHmxVCpe
	 yjAvBO6aMxQro5xnU/+XgenZAo7WNLhAQmB0WlGt1Iw8/gjZB8tj9U7bVZaY/Dq+vO
	 ycL/3pfrbcWgseZCwS+6iXy7RUuhu+MW5gNBCOovCt+AtkenQNR8LCUiUtF8IwtEY4
	 WFxORbiIwZSm6TdmDNKDVZPz07bwR88Gk1b5nBjV6WESatqkJTHjXzHGK43DkHHRym
	 ffj9w1Dqrnvxg+nXwrtrVdoP1XbArL+LtrFNSO6EyxhrHGGGbOLZH1OY9qjFPTw9jl
	 RynjJ0T4WJYuw==
Date: Fri, 17 Jan 2025 16:51:18 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Mikulas Patocka <mpatocka@redhat.com>, axboe@kernel.dk
Cc: John Garry <john.g.garry@oracle.com>, agk@redhat.com, hch@lst.de,
	song@kernel.org, yukuai3@huawei.com, kbusch@kernel.org,
	sagi@grimberg.me, James.Bottomley@hansenpartnership.com,
	martin.petersen@oracle.com, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH RFC v2 0/8] device mapper atomic write support
Message-ID: <Z4rQ1ihb0GsOan6f@kernel.org>
References: <20250116170301.474130-1-john.g.garry@oracle.com>
 <Z4q45sjEih8vIC-V@kernel.org>
 <4c5d02d6-a798-a390-2743-088c31c8965f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c5d02d6-a798-a390-2743-088c31c8965f@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250117_135121_506885_2AA1303D 
X-CRM114-Status: GOOD (  21.88  )
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

On Fri, Jan 17, 2025 at 10:27:22PM +0100, Mikulas Patocka wrote:
> 
> 
> On Fri, 17 Jan 2025, Mike Snitzer wrote:
> 
> > On Thu, Jan 16, 2025 at 05:02:53PM +0000, John Garry wrote:
> > > This series introduces initial device mapper atomic write support.
> > > 
> > > Since we already support stacking atomic writes limits, it's quite
> > > straightforward to support.
> > > 
> > > Personalities dm-linear, dm-stripe, and dm-raid1 are supported here, and
> > > more personalities could be supported in future.
> > > 
> > > This is still an RFC as I would like to test further.
> > > 
> > > Based on 3d9a9e9a77c5 (block/for-6.14/block) block: limit disk max
> > > sectors to (LLONG_MAX >> 9)
> > > 
> > > Changes to v1:
> > > - Generic block layer atomic writes enable flag and dm-table rework
> > > - Add dm-stripe and dm-raid1 support
> > > - Add bio_trim() patch
> > 
> > This all looks good.
> > 
> > Mikulas, we need Jens to pick up patches 1 and 2.  I wouldn't be
> > opposed to him taking the entire set but I did notice the DM core
> > (ioctl) version and the 3 DM targets that have had atomic support
> > added need their version numbers bumped.  Given that, likely best for
> > you (Mikulas) to pick up patches 3-8 after rebasing on Jens' latest
> > for-6.14/block branch (once Jens picks up patches 1 and 2).
> > 
> > Jens, you cool with picking up patches 1+2 for 6.14?  Or too late and
> > we circle back to this for 6.15?
> > 
> > Either way, for the series:
> > 
> > Reviewed-by: Mike Snitzer <snitzer@kernel.org>
> 
> Hi
> 
> I rebased on Jens' block tree, applied the patches 3-8, increased 
> DM_VERSION_MINOR, DM_VERSION_EXTRA, increased version numbers in 
> dm-linear, dm-stripe, dm-raid1 and uploaded it to git.kernel.org.
> 
> You can check it if it's correct.

Looks good, thanks!

Mike

