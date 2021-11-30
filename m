Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2C8C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Nov 2021 16:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IE2gRtUKwN9NbI3YSKGX70eCnOeuuRl6s2oJGbJ2gH8=; b=N7ldokgm3Ss+0T639zYFCL6UwW
	aH+nha0xQQBdl5N5mQnW+GAOd/fxVcsG+n0R0JWZhbKu2UnBKyUK22YtBh8ie1/DsNJirfK+WEQJJ
	WXpLTGrgdb5fiYdjtNBTI8dWAC0cbDwCoMQklI2hhyBjy0nJnqa9bBfWQivBsiX904PZDd1VUezCK
	+nYTPEk+IrjUUtAlb2dOQxKuovpn5Jp3o8TySqn9VEOS7z9DY5fZTRMtjaLBdeI4L9Il9aM9X9n1m
	AcWyqrwHEVHfhkYzXb5GkyFf0VYRxMVu333EV8YUevV4awSzAReqNtqL6Inda0IjkCOl/jwrRw9gD
	jCMWU0uA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ms5sO-0068xU-C9; Tue, 30 Nov 2021 16:21:04 +0000
Received: from smtpout2.vodafonemail.de ([145.253.239.133])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ms5sL-0068w3-9A
 for linux-nvme@lists.infradead.org; Tue, 30 Nov 2021 16:21:03 +0000
Received: from smtp.vodafone.de (unknown [10.2.0.33])
 by smtpout2.vodafonemail.de (Postfix) with ESMTP id BEF0A6112C;
 Tue, 30 Nov 2021 17:20:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nexgo.de;
 s=vfde-smtpout-mb-15sep; t=1638289242;
 bh=IE2gRtUKwN9NbI3YSKGX70eCnOeuuRl6s2oJGbJ2gH8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=pJ490t83pP+ncPzgfB9z6sr2iX/9G91lUpPIy/oxF3lVhEVAaSjMrRHpFr9+4Y4l4
 JXldhynKzm2A8ZfxBQEVKfG0d46iRJ+QbRzXT4JxBcTR6PJ/OXbMC5RdcoBo6T3HVH
 PRXf8hCsNMxNFus8KDnzcRo16DA1qFTn6E9nzB+U=
Received: from lazy.lzy (p579d7c55.dip0.t-ipconnect.de [87.157.124.85])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.vodafone.de (Postfix) with ESMTPSA id 4J3SB51gJ3zHnJM;
 Tue, 30 Nov 2021 16:20:26 +0000 (UTC)
Received: from lazy.lzy (localhost [127.0.0.1])
 by lazy.lzy (8.17.1/8.14.5) with ESMTPS id 1AUGKP8P012899
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Tue, 30 Nov 2021 17:20:25 +0100
Received: (from red@localhost)
 by lazy.lzy (8.17.1/8.16.1/Submit) id 1AUGKPZc012898;
 Tue, 30 Nov 2021 17:20:25 +0100
Date: Tue, 30 Nov 2021 17:20:25 +0100
From: Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-raid@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-accelerators@lists.ozlabs.org, linux-nvme@lists.infradead.org
Subject: Re: Using aGPU for RAID calculations (proprietary GRAID SupremeRAID)
Message-ID: <YaZPScnojOLqDNPc@lazy.lzy>
References: <ccdbb0d7-d043-d41f-508b-4a464ffa5fe9@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ccdbb0d7-d043-d41f-508b-4a464ffa5fe9@molgen.mpg.de>
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for
 further information)
X-purgate: clean
X-purgate-size: 2214
X-purgate-ID: 149169::1638289242-00000479-66182D27/0/0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211130_082101_811473_58AB3FC3 
X-CRM114-Status: GOOD (  22.16  )
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

On Tue, Nov 30, 2021 at 12:58:10PM +0100, Paul Menzel wrote:
> 
> Dear Linux folks,
> 
> 
> I read about GRAID SupremeRAID [1], which seems to be an Nvidia T1000 card
> and software to use the card for RAID calculations.
> 
> > GRAID SupremeRAID works by installing a virtual NVMe controller onto
> > the operating system and integrating a PCIe device into the system
> > equipped with a high-performance AI processor to handle all RAID
> > operations of the virtual NVMe controller
> 
> According to the review *GRAID SupremeRAID SR-1000 Review* [2] it performs
> quite well. I couldn’t find any driver files online.
> 
> Now I am wondering, why a graphics card seems to help so much. What
> operations are there, modern CPUs cannot keep up with?
> 
> If GPUs are that much better, are people already working on a FLOSS solution
> for the Linux kernel, so people can “just” plug in a graphics card to
> increase the speed?
> 
> Does the Linux kernel already have an API to offload calculations to
> accelerator cards, so it’s basically plug and play (with AMD graphics cards
> for example using HSA/KFD)? Entropy sources, like the ChaosKey [3], work
> like that. If not, would the implementation go under `lib/raid6`?

I think this was somehow discussed here
some times ago.
That is the use of "GPU" to accellerate
the parity computation.

There are a couple of things to keep in mind.

One is the data transfer to / from the video
card, which might be a bottleneck.
At any rate, there will be a write and read
streams going across the system bus(es).

An other point is that, unless an high end
video card is used, with ECC memory, the
reliability of the whole process might be
of concern.

Finally, usually video cards, while having
a lot of memory (caching could be good),
they miss the battery backup.
Power is off, data is gone...

bye,

pg

> 
> 
> Kind regards,
> 
> Paul
> 
> 
> [1]: https://www.graidtech.com/post/graid-reveals-the-next-generation-of-enterprise-data-protection-nvme-ssds
> [2]: https://www.storagereview.com/review/graid-supremeraid-sr-1000-review
> [3]: https://altusmetrum.org/ChaosKey/
> 

-- 

piergiorgio

