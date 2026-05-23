Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E279CD5BBF
	for <linux-nvme@archiver.kernel.org>; Sat, 23 May 2026 13:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iwRnsgoTr2iWbUDasH4uZK/ECwCVzWUo6yYxaliU1W4=; b=wjqNAXjS61Xr34XsKzWs46uPTs
	q3+yxy6YWSjn1qbhNPaZFTZ6cZRMrCAvW4gRu7MmpoW6zzqcutelbQeWj6QXUXViZLX255hvaQUCt
	LpLJcj0M1iBvSsj20xgCS3Ck6rahcH8Gsxttqv4E3GxvCFLnwKHdna62w2myX534aY96qt1DUx3Lo
	8D9NMLeELUXk8uh17xPu/g6xJrrQapzSmODgNFyaUMbeo5xUTt9FtwwRoAmR8ZSWU6QpldSXnPUZh
	Ip0KP7tJxrTHYL+8j5RMCZsIRPmhs9ozuawObw8s1Q4mepQfRobu8WOyc5VQsI0Nbyif2ElKwTvga
	KxfjMcNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQmp3-0000000DL90-2yYS;
	Sat, 23 May 2026 13:55:25 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQmp2-0000000DL8T-0GJv
	for linux-nvme@lists.infradead.org;
	Sat, 23 May 2026 13:55:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 26E29439A1;
	Sat, 23 May 2026 13:55:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842041F000E9;
	Sat, 23 May 2026 13:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779544523;
	bh=iwRnsgoTr2iWbUDasH4uZK/ECwCVzWUo6yYxaliU1W4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZH/r74onQDAsv5o8zRPzKMkUAChwKYQAlL/s2gOMWN3QSmyGsfvdbJOHEQrTyo1fR
	 RH4Z05RX4bS5ITRFqkCdrTUuMDdWsEXv+9+d249Y3JNquLyX5PFf1Y1D1LILDo7Sjd
	 UOi1t52MF0BM5XHGjMZQCpQUdOSFFGdQsmqCC4BW/tBIXxWXIS4z0bCNFy0lkxZ1X5
	 zAVsxE6KRiRU80OXZPq2BwV47kZ/r1nCaOcGGghAOmGEzzJTCYakj45V/3osMNSjYK
	 SQhCopRhlVYACWbeeVTrXoQIxkAkpLRPmhwMYLIDwZAm8MxG8RGVtF1QCZGavoSBkK
	 MIDvSPJyyTL/Q==
Date: Sat, 23 May 2026 19:25:13 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 0/4] PCI: Introduce pci_suspend_retains_context() API
Message-ID: <r247uuc7ilkhn65vcbsaoxhgypif37lj3r3mvb7ooqqdg55vnm@vx3ip6klg6ha>
References: <20260519-l1ss-fix-v2-0-b2c3a4bdeb15@oss.qualcomm.com>
 <09473fc7-e91c-4e80-9d64-0d14d585d89d@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09473fc7-e91c-4e80-9d64-0d14d585d89d@163.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260523_065524_125405_9F359AA8 
X-CRM114-Status: GOOD (  15.27  )
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

On Sat, May 23, 2026 at 12:04:02AM +0800, Hans Zhang wrote:
> Hi Mani,
> 
> We previously discussed a patch. I wonder if you have any memory of it. I'm
> not sure if it can solve my problem. As shown below:
> 
> https://lore.kernel.org/linux-pci/z4bq25pr35cklwoodz34pnfaopfrtbjwhc6gvbhbsvnwblhxia@frmtb3t3m4nk/
> 

This series won't address your issue as it workarounds PCIe controller issue in
waking from L1ss.

But below patch which got merged for v7.2 might help you:
https://lore.kernel.org/all/20251231162126.7728-1-manivannan.sadhasivam@oss.qualcomm.com/

I'm not sure if your platform firmware uses PSCI for S2R (Suspend To RAM) or
not. If PSCI is used, above patch will turn off NVMe during S2R. If not using
PSCI and some other firmware mechanism, then the kernel driver interacting with
the firmware should call pm_set_{suspend/resume}_via_firmware() from the S2R
suspend ops as like the above patch to allow NVMe driver to turn off the
controller during S2R.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

