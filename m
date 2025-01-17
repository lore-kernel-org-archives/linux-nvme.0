Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25A5C02183
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jan 2025 21:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pgV+zu79hN75oKX15LFXTDKwUbzMzhPDf2yqirzHSkk=; b=KmwO0EqrdflcoCMaY3TsYzsJ2O
	BT9SSGElLX9s112lvPTPguggaWYQ4fQEw64nlswJOhAgAwwZj7V+N0aik1kBSs0Bq/7TKn4NjnUcz
	dpjSYSmahfPeGQM1LnWyIuOr0RXtRRBk26r+5Z81DfTDE7kIBijMabhoTOJDv3QtFPm7SPLdGYu9Y
	Ns1wBFHMJlMWyMwViYI0whkhfY550jQvtbCTfhJ4O/gvbun/srN50s2jio5fWX7HcePW1Lu67qD/4
	mDtAfQ+a3QGNDI3NBhR7LxwovmZG5fuIMphTwbfPEQxEQpAOeJPNbm4UuWyqkO2QQoUMo0RLpAZMA
	NL+0Sa2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYtu4-00000001OXS-1mfF;
	Fri, 17 Jan 2025 21:29:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYtu1-00000001OX1-3VYK
	for linux-nvme@lists.infradead.org;
	Fri, 17 Jan 2025 21:29:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737149355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pgV+zu79hN75oKX15LFXTDKwUbzMzhPDf2yqirzHSkk=;
	b=INm5Supo/kUCUpzaDQGhD2jEoU3orxq7MRL7YW0rX/sGKoIcYPP0G5w5s4rjxh7JfipRaX
	m6k98ypLgVfLtIzRNRyRc4SMvmErDAVxQD2zhygsmsns//63pgyp1bGe5H3zh8qvXkKABo
	MKFU11LpKcvWzx1XInC5kGESHGtaH/I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-WwH0T1MENuyUjWdIi_lucQ-1; Fri,
 17 Jan 2025 16:27:36 -0500
X-MC-Unique: WwH0T1MENuyUjWdIi_lucQ-1
X-Mimecast-MFC-AGG-ID: WwH0T1MENuyUjWdIi_lucQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 635381956050;
	Fri, 17 Jan 2025 21:27:33 +0000 (UTC)
Received: from [10.45.224.57] (unknown [10.45.224.57])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A764019560A3;
	Fri, 17 Jan 2025 21:27:26 +0000 (UTC)
Date: Fri, 17 Jan 2025 22:27:22 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Mike Snitzer <snitzer@kernel.org>
cc: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, agk@redhat.com, 
    hch@lst.de, song@kernel.org, yukuai3@huawei.com, kbusch@kernel.org, 
    sagi@grimberg.me, James.Bottomley@hansenpartnership.com, 
    martin.petersen@oracle.com, linux-block@vger.kernel.org, 
    dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
    linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org, 
    linux-scsi@vger.kernel.org
Subject: Re: [PATCH RFC v2 0/8] device mapper atomic write support
In-Reply-To: <Z4q45sjEih8vIC-V@kernel.org>
Message-ID: <4c5d02d6-a798-a390-2743-088c31c8965f@redhat.com>
References: <20250116170301.474130-1-john.g.garry@oracle.com> <Z4q45sjEih8vIC-V@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250117_132918_004487_6FACE96D 
X-CRM114-Status: GOOD (  18.71  )
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



On Fri, 17 Jan 2025, Mike Snitzer wrote:

> On Thu, Jan 16, 2025 at 05:02:53PM +0000, John Garry wrote:
> > This series introduces initial device mapper atomic write support.
> > 
> > Since we already support stacking atomic writes limits, it's quite
> > straightforward to support.
> > 
> > Personalities dm-linear, dm-stripe, and dm-raid1 are supported here, and
> > more personalities could be supported in future.
> > 
> > This is still an RFC as I would like to test further.
> > 
> > Based on 3d9a9e9a77c5 (block/for-6.14/block) block: limit disk max
> > sectors to (LLONG_MAX >> 9)
> > 
> > Changes to v1:
> > - Generic block layer atomic writes enable flag and dm-table rework
> > - Add dm-stripe and dm-raid1 support
> > - Add bio_trim() patch
> 
> This all looks good.
> 
> Mikulas, we need Jens to pick up patches 1 and 2.  I wouldn't be
> opposed to him taking the entire set but I did notice the DM core
> (ioctl) version and the 3 DM targets that have had atomic support
> added need their version numbers bumped.  Given that, likely best for
> you (Mikulas) to pick up patches 3-8 after rebasing on Jens' latest
> for-6.14/block branch (once Jens picks up patches 1 and 2).
> 
> Jens, you cool with picking up patches 1+2 for 6.14?  Or too late and
> we circle back to this for 6.15?
> 
> Either way, for the series:
> 
> Reviewed-by: Mike Snitzer <snitzer@kernel.org>

Hi

I rebased on Jens' block tree, applied the patches 3-8, increased 
DM_VERSION_MINOR, DM_VERSION_EXTRA, increased version numbers in 
dm-linear, dm-stripe, dm-raid1 and uploaded it to git.kernel.org.

You can check it if it's correct.

Mikulas


