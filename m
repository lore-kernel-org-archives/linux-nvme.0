Return-Path: <SRS0=1Q2H=NB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C451FC4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Aug 2021 10:36:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 833E860EB2
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Aug 2021 10:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 833E860EB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sQJipWgtvahurKv+M2Y209HG9T9g+suAXj6le73DWKU=; b=S1HFKOmKPtUdwO
	RAyfpk7zCYSCiC+FJ/7NNurKRsWXmgFWjg7wMmr+8Sg1YD5hYipXNqD7x8qH8/qdP2sW6iCphs8fE
	m8aWm47IQtkfd87IdH0H9AGqkyzeHpg9uI07vRw/8DOeXtIms6LgwPXSgUyCHObDA3r0gMNCGiSnZ
	q8QHt0PRMSQig2HCXW6iI3U7Xk0zYzYDU+ZVgN2WdwFEI9DUIeXMWrDKyKaopnflHC4aIEHXXC20b
	zIFiJ01rEqM8s8dSRv2wLSUouvYsUEWc2Y+oiStJxrN8Fwj0lEGomwcYXUT6ZezF+mu5wf7OoPQOY
	bZOHUKIAWcdyHu862/uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mDP79-003YBU-CB; Tue, 10 Aug 2021 10:36:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDP75-003Y9q-1P
 for linux-nvme@lists.infradead.org; Tue, 10 Aug 2021 10:36:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628591759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8MKdVxhmWHkSF7Qc4zBZXEqJWUbfI37hUIq+4sHXK5w=;
 b=Ip7y30GDA/sMxxe81GjF3hlfN7Jr6zegzw/cle+JzO7+xf52kwnJZwR8Nsyj8TCpWNOvAE
 aRnuesmzy2Lc29flMerUoX7jENnAEXHVgZkr9+Rilgv62S3tq0Ew4ZsvBhoOBrW1xLJ2kR
 V4XZIpRYA8FsqYpuAlMDph1SLVWPMBc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-SLez8Vj3PA270oq6Eepj1A-1; Tue, 10 Aug 2021 06:35:58 -0400
X-MC-Unique: SLez8Vj3PA270oq6Eepj1A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4B591008060;
 Tue, 10 Aug 2021 10:35:56 +0000 (UTC)
Received: from T590 (ovpn-13-190.pek2.redhat.com [10.72.13.190])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC8415C232;
 Tue, 10 Aug 2021 10:35:50 +0000 (UTC)
Date: Tue, 10 Aug 2021 18:35:45 +0800
From: Ming Lei <ming.lei@redhat.com>
To: John Garry <john.garry@huawei.com>
Cc: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
Message-ID: <YRJWgU5VhzBe1JP4@T590>
References: <YPlGOOMSdm6Bcyy/@T590>
 <fc552129-e89d-74ad-9e57-30e3ffe4cf5d@huawei.com>
 <YPmUoBk9u+tU2rbS@T590>
 <0adbe03b-ce26-e4d3-3425-d967bc436ef5@arm.com>
 <YPqYDY9/VAhfHNfU@T590>
 <6ceab844-465f-3bf3-1809-5df1f1dbbc5c@huawei.com>
 <CAFj5m9J+9vO=CK3uPP+va5EoWffZj9ruSRe2fDDLXn+AE971CQ@mail.gmail.com>
 <ead87bf2-ddfa-eb67-db44-9619c6cdb714@huawei.com>
 <YQF1AKS6Y14dLU/A@T590>
 <dfdd16e8-278f-3bc9-da97-a91264aec909@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dfdd16e8-278f-3bc9-da97-a91264aec909@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210810_033603_183479_8BA8B55C 
X-CRM114-Status: GOOD (  31.51  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Aug 10, 2021 at 10:36:47AM +0100, John Garry wrote:
> On 28/07/2021 16:17, Ming Lei wrote:
> > > > > Have you tried turning off the IOMMU to ensure that this is really just
> > > > > an IOMMU problem?
> > > > > 
> > > > > You can try setting CONFIG_ARM_SMMU_V3=n in the defconfig or passing
> > > > > cmdline param iommu.passthrough=1 to bypass the the SMMU (equivalent to
> > > > > disabling for kernel drivers).
> > > > Bypassing SMMU via iommu.passthrough=1 basically doesn't make a difference
> > > > on this issue.
> > > A ~90% throughput drop still seems to me to be too high to be a software
> > > issue. More so since I don't see similar on my system. And that throughput
> > > drop does not lead to a total CPU usage drop, from the fio log.
> > > 
> > > Do you know if anyone has run memory benchmark tests on this board to find
> > > out NUMA effect? I think lmbench or stream could be used for this.
> > https://lore.kernel.org/lkml/YOhbc5C47IzC893B@T590/
> 
> Hi Ming,
> 
> Out of curiosity, did you investigate this topic any further?

IMO, the issue is probably in device/system side, since completion latency is
increased a lot, meantime submission latency isn't changed.

Either the submission isn't committed to hardware in time, or the
completion status isn't updated to HW in time from viewpoint of CPU.

We have tried to update to new FW, but not see difference made.

> 
> And you also asked about my results earlier:
> 
> On 22/07/2021 16:54, Ming Lei wrote:
> >> [   52.035895] nvme 0000:81:00.0: Adding to iommu group 5
> >> [   52.047732] nvme nvme0: pci function 0000:81:00.0
> >> [   52.067216] nvme nvme0: 22/0/2 default/read/poll queues
> >> [   52.087318]  nvme0n1: p1
> >>
> >> So I get these results:
> >> cpu0 335K
> >> cpu32 346K
> >> cpu64 300K
> >> cpu96 300K
> >>
> >> So still not massive changes.
> > In your last email, the results are the following with irq mode io_uring:
> >
> >   cpu0  497K
> >   cpu4  307K
> >   cpu32 566K
> >   cpu64 488K
> >   cpu96 508K
> >
> > So looks you get much worse result with real io_polling?
> >
> 
> Would the expectation be that at least I get the same performance with
> io_polling here?

io_polling is supposed to improve IO latency a lot compared with irq
mode, and the perf data shows that clearly on x86_64.

> Anything else to try which you can suggest to investigate
> this lower performance?

You may try to compare irq mode and polling and narrow down the possible
reasons, no exact suggestion on how to investigate it, :-(


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
