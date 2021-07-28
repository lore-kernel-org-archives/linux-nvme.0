Return-Path: <SRS0=tys/=MU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8A9C4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jul 2021 15:18:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5885060F91
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jul 2021 15:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5885060F91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uj39KO3S2j4Q05csNhw1PiyHZI2PqAi6YtBZf3PlX+c=; b=ago43TGrzwju/0
	0WKr3F1JGHkkFMJCMTOy0oKJHkWGESnGzOuFX1mXslNErRspm8nqgB5J38YvN405Rua76gKreU/QC
	T1d1/acsu4WzPosTOZ+iWC3dQrq1daFAJMOQiCxlBaranZ6SWSLJgvgoyqrl7XH4FyHiX9sA3va36
	+Etg9nTU7SRccTt+KJWNY9tb8nCRKzJhuj6u0Ow3dMI7gyk0dXNhEXFXAzBL1fFECR3rIj7ZjzxXh
	mZXK4Ru1CltfKQUO4gd1tWzXz2Gwf3QxZflyX7W4VIukLJcGNVNP6zFGUTaY+oXLT6225QlmMlNUP
	bA1csM8RenvRm0t/0hiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m8lKL-001FRV-Oj; Wed, 28 Jul 2021 15:18:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m8lJO-001FIr-H5
 for linux-nvme@lists.infradead.org; Wed, 28 Jul 2021 15:17:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627485453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G74hAD1INJz4al2p5kUqrIQ36rIkhCEJh1SOa5TxS9s=;
 b=PLkuyu1PNnPK5vwatnMIK+ysKtTfN1UCJ6wxI+VVCWADFP/CRIs9QfpmJPOWwdEZPooYGr
 /+XCIPOgWyyKw5KF1PKSmgE9gYcIiaa2smUQI74RLgtAfmpxPzPMbHVNI8tsnflnsQZDbd
 VdEOCuKIDOtG+eMyQ4JWSSthIG8O80M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-UDtteHy1NGmvPeuayJGZwg-1; Wed, 28 Jul 2021 11:17:29 -0400
X-MC-Unique: UDtteHy1NGmvPeuayJGZwg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B449801AC0;
 Wed, 28 Jul 2021 15:17:28 +0000 (UTC)
Received: from T590 (ovpn-12-35.pek2.redhat.com [10.72.12.35])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 27C7A1971B;
 Wed, 28 Jul 2021 15:17:19 +0000 (UTC)
Date: Wed, 28 Jul 2021 23:17:20 +0800
From: Ming Lei <ming.lei@redhat.com>
To: John Garry <john.garry@huawei.com>
Cc: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
Message-ID: <YQF1AKS6Y14dLU/A@T590>
References: <YPklDMng1hL3bQ+v@T590>
 <9c929985-4fcb-e65d-0265-34c820b770ea@huawei.com>
 <YPlGOOMSdm6Bcyy/@T590>
 <fc552129-e89d-74ad-9e57-30e3ffe4cf5d@huawei.com>
 <YPmUoBk9u+tU2rbS@T590>
 <0adbe03b-ce26-e4d3-3425-d967bc436ef5@arm.com>
 <YPqYDY9/VAhfHNfU@T590>
 <6ceab844-465f-3bf3-1809-5df1f1dbbc5c@huawei.com>
 <CAFj5m9J+9vO=CK3uPP+va5EoWffZj9ruSRe2fDDLXn+AE971CQ@mail.gmail.com>
 <ead87bf2-ddfa-eb67-db44-9619c6cdb714@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ead87bf2-ddfa-eb67-db44-9619c6cdb714@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210728_081734_866700_DCE8141F 
X-CRM114-Status: GOOD (  25.56  )
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

On Wed, Jul 28, 2021 at 11:38:18AM +0100, John Garry wrote:
> On 28/07/2021 02:32, Ming Lei wrote:
> > On Mon, Jul 26, 2021 at 3:51 PM John Garry<john.garry@huawei.com>  wrote:
> > > On 23/07/2021 11:21, Ming Lei wrote:
> > > > > Thanks, I was also going to suggest the latter, since it's what
> > > > > arm_smmu_cmdq_issue_cmdlist() does with IRQs masked that should be most
> > > > > indicative of where the slowness most likely stems from.
> > > > The improvement from 'iommu.strict=0' is very small:
> > > > 
> > > Have you tried turning off the IOMMU to ensure that this is really just
> > > an IOMMU problem?
> > > 
> > > You can try setting CONFIG_ARM_SMMU_V3=n in the defconfig or passing
> > > cmdline param iommu.passthrough=1 to bypass the the SMMU (equivalent to
> > > disabling for kernel drivers).
> > Bypassing SMMU via iommu.passthrough=1 basically doesn't make a difference
> > on this issue.
> 
> A ~90% throughput drop still seems to me to be too high to be a software
> issue. More so since I don't see similar on my system. And that throughput
> drop does not lead to a total CPU usage drop, from the fio log.
> 
> Do you know if anyone has run memory benchmark tests on this board to find
> out NUMA effect? I think lmbench or stream could be used for this.

https://lore.kernel.org/lkml/YOhbc5C47IzC893B@T590/

-- 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
