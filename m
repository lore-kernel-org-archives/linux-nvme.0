Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE42D149C0
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2024 16:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R5MyqvYjT6t/6UYw2e4q6Ie0iJ1gCk/dDcKleTIYbK4=; b=fyuv2lbXWGGgTrYawXxRKeoo/+
	oeLSSpBHe+7TPbatmZdRGCg9qk4PozUcZM4n9RI/1sOLp/7eaUZSnb9dKixWTdiIiVnPFKzsKhvlG
	p2isdxmKgf40eMVtyCglS1t5VVmKlmPIdmVLwtYDU3CUfEAUh7FTpKGZCmh5KawN00aF7g6O1VLtY
	VegKzdIZ3NT4ZMLFbxXAVu0SfvRaIYn37FZZs0Afd9qzjNEQqz6RJb8K0NUWLPZG4Zwp+Jfno40Fq
	swxUxa2uQQYsJGOQ/8x+Y4WSgHeidaSi/diWzu4Mhl5QsrKzis5meQjGF7LZNBIJX1RocEjflXz/j
	M5twM/lQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4MxD-00000004NHN-33Qa;
	Fri, 25 Oct 2024 16:14:23 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4MvJ-00000004Mw0-0mB5
	for linux-nvme@lists.infradead.org;
	Fri, 25 Oct 2024 16:12:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5FD655C5CB9;
	Fri, 25 Oct 2024 16:11:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8C5C4CEC3;
	Fri, 25 Oct 2024 16:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729872744;
	bh=MbYu/8B6N5thTChedfbAC/pUmjngI2T0nNWhkoENNLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=asN56JR+FfzlsRyeT6tL4SS8+KS4tVoKiGnLM+K5BvmO77+/aTNcMaiT60miDak4t
	 bx8AOqshbszSdRVXahXQILtBLdj7qArL7iUDOpOnuCXqYaNoaKFtkgQ3SBmvGOd9/E
	 VqBcogseFDol1SbqsdFxgDQSFStRdlaZ2VLFaQw6+F1UhccivAtCeQ9sqaFzGV2Lx7
	 WeQRun543ZOkUbhkFDTgULpHO/pGwOKPsK20uJeHKZ0/MWBhl/tBewSEt+aCmPtqxx
	 QpE7O8t4NXf92dgYM4FkwUYlbxLm4HL9/UiEtyyK+yFI+JpJUCdGBXzgxFEO5d32kY
	 eVRDRh0+8X9Lg==
Date: Fri, 25 Oct 2024 10:12:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH] nvme-pci: Force NVME_QUIRK_SIMPLE_SUSPEND on Qualcomm
 hosts
Message-ID: <ZxvDZVKtM9qGYBP_@kbusch-mbp.dhcp.thefacebook.com>
References: <20241024-topic-nvmequirk-v1-1-51249999d409@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024-topic-nvmequirk-v1-1-51249999d409@oss.qualcomm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_091225_520137_19615A62 
X-CRM114-Status: UNSURE (   9.88  )
X-CRM114-Notice: Please train this message.
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

On Thu, Oct 24, 2024 at 07:33:07PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> The Qualcomm SC8280XP SoC requires that all PCIe hosts are powered down
> before the platform can reach S3-like sleep states. This is very much
> similar in nature to the issue described in [1].

The "SIMPLE" quirk is only supposed to affect kernel managed runtime
suspend states, s2idle or s0ix. Shouldn't s3 already be using the simple
suspend?

