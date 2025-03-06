Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827F7C282D1
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Mar 2025 15:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M8PQXdR7OXSTS138LXvgs7UcTovqpj/TY1pOp+slBvA=; b=TPV3olQuiUnXSxgDQ2e6J7pRBR
	spY7JCZD0ChK8nvPOZSBSVhnMsT5vdy8xdh+5i7kSEQUaczL3VPUexw2/380Nmnidp31PyBocSTCW
	ErHFSs3ppEHux8IuEcD9EpInSPd+ZHiUlhe5Z1i2CPUxFiTL30nOuNmc63mHFLKgsZ+no5MoGzLGE
	/WNgizTrOedBfYFu/wMELcAgCoTgeOhodKqO2iYWQcDUTbx0nvvrcZk1dYi4lbPa+TEhpKIgaTduD
	Mcxr0fVHL7MZLcwRst65xbuxNsuLH2FImjqLM+BX7RytUmAHbMPB4+D6YDmSeqPWo/XhCPtPcoZGE
	RQyKuJzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqD0a-0000000BIe6-2UAe;
	Thu, 06 Mar 2025 15:19:36 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqD0X-0000000BId4-2rwS
	for linux-nvme@lists.infradead.org;
	Thu, 06 Mar 2025 15:19:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 038695C5807;
	Thu,  6 Mar 2025 15:17:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BF6C4CEE0;
	Thu,  6 Mar 2025 15:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741274372;
	bh=6QlmcIc2nD2jRS+7DaISjQLzs92eHSdVRUCSyvfiE+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xtn10E7B3Flk/KudFeKjl5xJub3tkThiQhBBxKdUOSnCB1UmePvTjdYFkemRVZIM8
	 ySuyZtAVgG9Zz0GOkAp4MmDSiV4aFU9UHuTc+JpLC3TYAji3//6onGDYIpurzp8Y4B
	 yqf5Hj3L8ZfB+QhavnpGYjzyFSXFZCQnIIBhlbtek++GJ2G4sdc/0+ceT/va9rzUjT
	 dG90gSCKd9gYC/tJOZQI+uLolQ0BWS33zgG0mrrxmwbr/5uCrLCTM95z3qWcQVUAbn
	 u7B3eMXmpXAUlIS7w+hptHfOa2vXJn2lSq8/S1IfCNsfApCykhjxS2MiUx41NGDBd8
	 Rzlsj9B4ydgQA==
Date: Thu, 6 Mar 2025 08:19:29 -0700
From: Keith Busch <kbusch@kernel.org>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	linux-nvme@lists.infradead.org,
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: 6.13/regression/bisected - new nvme timeout errors
Message-ID: <Z8m9AbD3tjNpBt6p@kbusch-mbp>
References: <CABXGCsMcxu3pCF8jYPeqF_jN34saBwc8Fci+c-Dg2Lh7rqvuFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXGCsMcxu3pCF8jYPeqF_jN34saBwc8Fci+c-Dg2Lh7rqvuFQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_071933_761795_6AA2C43B 
X-CRM114-Status: GOOD (  17.80  )
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

On Wed, Jan 15, 2025 at 02:58:04AM +0500, Mikhail Gavrilov wrote:
> Hi,
> During 6.13 development cycle I spotted strange new nvme errors in the
> log which I never seen before.
> 
> [87774.010474] nvme nvme1: I/O tag 0 (3000) opcode 0x1 (I/O Cmd) QID 1 timeout, aborting req_op:WRITE(1) size:131072

...

> I still haven't found a stable way to reproduce this.
> But I'm pretty sure that if this error don't appearing within two
> days, then we can assume that the kernel isn't affected by the
> problem.
> So I made bisection with above assumption and found this commit:
> 
> beadf0088501d9dcf2454b05d90d5d31ea3ba55f is the first bad commit
> commit beadf0088501d9dcf2454b05d90d5d31ea3ba55f
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Wed Nov 13 16:20:41 2024 +0100
> 
>     nvme-pci: reverse request order in nvme_queue_rqs

The patch here uses the order recieved to dispatch commands in
consequetive submission queue entries, which is supposed to be the
desired behavior for any device. I did some testing on mailine, and it
sure looks like the order the driver does this is optimal, so I'm not
sure what's going on with your observation.

Do you have a scheduler enabled on your device?

How are you generating IO? Is it a pattern I should be able to replicate
with 'fio'?

