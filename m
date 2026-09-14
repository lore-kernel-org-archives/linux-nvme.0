Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD4AC88E64
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2026 11:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R7+L0DS/i+DsiPCK294YRFFlGBSviuyUaFNf79SZZmc=; b=ntYRsjCsWsELCRbfZmYNaotXwJ
	t0S3t2e+gS+lHkhD/fr4r0Ba1AIrbbSVjtv1JewGun54RYlXZSoIg6++kXJB+QGAUzFnCP0a6x/B6
	dFT4FTHa9anJHf0jhpFkLhLJO0kiTB+/NXmmiYaC+rUXcfyIVbnY3PQJnYfuesHH6TGz404OB1t47
	YeLnJEgaVNtJ1cxumxpeQ9R5Lb+5CIc+zRE96mcLZ6wegM4v4QVKuK5y4avVM9KeU3zxeaogyffrZ
	Hni2B0UgHdS2bR/E86golWM5txcFjIXKh/iX5gOLKYunIW7NbJp8u4FjJtBjSF3JuF6CM4VmuaIu7
	YsQUtxbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x65E0-00000003O4c-1Xsb;
	Mon, 14 Sep 2026 11:51:52 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x65Dy-00000003O4L-2tUk;
	Mon, 14 Sep 2026 11:51:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D53E260142;
	Mon, 14 Sep 2026 11:51:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0111F000FF;
	Mon, 14 Sep 2026 11:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789386709;
	bh=R7+L0DS/i+DsiPCK294YRFFlGBSviuyUaFNf79SZZmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BV5v/s6Ovk+D6wQt7lAW7VvxwNapnxy859ARewOJYGvT9LiLkWeHTRW84L70HS3/+
	 Ud1hn+k70Sl4tlLJU6I19fmutJ5k7vTedG/uqVYCjh3apn2B0ecJ5rpNowrtWAd/+o
	 4L5DY/CVobpsOtdB4nLm8SXKhsGePL41l0oT5UxbjpsjNGs3SmyE1SsHMM3DaKOcmi
	 fclMqI/Se2BSNQyLFNG73xUiYjk/jDXHuM/E3Ucx5CmfjK+rowZgWFBpyFjOzCltnc
	 4QjDuA2+ypUTgEaVSZ+lXwEpA7c33gM50dQKMr7Z9Vzq4VLePiDlGlr3YMoPN20GqZ
	 mFqqk5iimPBcg==
Date: Mon, 14 Sep 2026 13:51:44 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] PCI: endpoint: Support hardware-owned MSI-X table
 and PBA
Message-ID: <aqff0CqBIDeMMTke@ryzen>
References: <20260830151948.3547577-1-den@valinux.co.jp>
 <apVWd1u9JjTKQczu@ryzen>
 <pj5vpwwd5tr5tuvhdq3bcpefnq27r6ljvwoysguz2o4tglcqx5@l7zmb6wjnhla>
 <apXdm2I33edo8kpZ@ryzen>
 <sor2mm4jzgeprhn3fjw4jmcaowwkhhuus6exi4k5kum6frqvug@gatkk7r4qyxd>
 <apfPWc09CY2o-P5s@ryzen>
 <zxyr55h6s3tjc6pe23wzwb77dxppsljxcagpqhp4u24cqka2ne@fesick6sneto>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zxyr55h6s3tjc6pe23wzwb77dxppsljxcagpqhp4u24cqka2ne@fesick6sneto>
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

Hello Koichiro,

On Thu, Sep 03, 2026 at 04:56:18PM +0900, Koichiro Den wrote:
> > 
> > Please share your branch. I should have time to do a quick test.

I did test your patches using pci-epf-test.

EP side:

[  105.770736] using HW-defined MSI-X layout!
[  105.770763] MSI-X table BAR: 4 offset: 0x4000 size: 0x1000
[  105.770777] MSI-X PBA BAR: 4 offset: 0x5000 size: 0x1000
[  113.634512] raising MSI-X doorbell for irq: 1 msg_data: 0
[  114.650505] raising MSI-X doorbell for irq: 2 msg_data: 1
[  114.658509] raising MSI-X doorbell for irq: 3 msg_data: 2
[  114.666499] raising MSI-X doorbell for irq: 4 msg_data: 3
[  114.674508] raising MSI-X doorbell for irq: 5 msg_data: 4
[  114.682498] raising MSI-X doorbell for irq: 6 msg_data: 5
[  114.690508] raising MSI-X doorbell for irq: 7 msg_data: 6
[  114.698500] raising MSI-X doorbell for irq: 8 msg_data: 7
[  114.706508] raising MSI-X doorbell for irq: 9 msg_data: 8
[  114.714500] raising MSI-X doorbell for irq: 10 msg_data: 9
[  114.722508] raising MSI-X doorbell for irq: 11 msg_data: 10
[  114.730500] raising MSI-X doorbell for irq: 12 msg_data: 11
[  114.738511] raising MSI-X doorbell for irq: 13 msg_data: 12
[  114.746498] raising MSI-X doorbell for irq: 14 msg_data: 13
[  114.754509] raising MSI-X doorbell for irq: 15 msg_data: 14
[  114.762499] raising MSI-X doorbell for irq: 16 msg_data: 15
[  114.770509] raising MSI-X doorbell for irq: 17 msg_data: 16
[  114.778500] raising MSI-X doorbell for irq: 18 msg_data: 17
[  114.786508] raising MSI-X doorbell for irq: 19 msg_data: 18
[  114.794501] raising MSI-X doorbell for irq: 20 msg_data: 19
[  114.802507] raising MSI-X doorbell for irq: 21 msg_data: 20
[  114.810500] raising MSI-X doorbell for irq: 22 msg_data: 21
[  114.818509] raising MSI-X doorbell for irq: 23 msg_data: 22
[  114.826502] raising MSI-X doorbell for irq: 24 msg_data: 23
[  114.834509] raising MSI-X doorbell for irq: 25 msg_data: 24
[  114.842502] raising MSI-X doorbell for irq: 26 msg_data: 25
[  114.850509] raising MSI-X doorbell for irq: 27 msg_data: 26
[  114.858499] raising MSI-X doorbell for irq: 28 msg_data: 27
[  114.866510] raising MSI-X doorbell for irq: 29 msg_data: 28
[  114.874500] raising MSI-X doorbell for irq: 30 msg_data: 29
[  114.882510] raising MSI-X doorbell for irq: 31 msg_data: 30
[  114.890500] raising MSI-X doorbell for irq: 32 msg_data: 31


Host side:

#  RUN           pci_ep_basic.MSIX_TEST ...
MSI-X1 returned -110
# pci_endpoint_test.c:168:MSIX_TEST:Expected 0 (0) == ret (-110)
# pci_endpoint_test.c:168:MSIX_TEST:Test failed for MSI-X1
MSI-X2 returned 0
MSI-X3 returned 0
MSI-X4 returned 0
MSI-X5 returned 0
MSI-X6 returned 0
MSI-X7 returned 0
MSI-X8 returned 0
MSI-X9 returned 0
MSI-X10 returned 0
MSI-X11 returned 0
MSI-X12 returned 0
MSI-X13 returned 0
MSI-X14 returned 0
MSI-X15 returned 0
MSI-X16 returned 0
MSI-X17 returned 0
MSI-X18 returned 0
MSI-X19 returned 0
MSI-X20 returned 0
MSI-X21 returned 0
MSI-X22 returned 0
MSI-X23 returned 0
MSI-X24 returned 0
MSI-X25 returned 0
MSI-X26 returned 0
MSI-X27 returned 0
MSI-X28 returned 0
MSI-X29 returned 0
MSI-X30 returned 0
MSI-X31 returned 0
MSI-X32 returned 0
MSI-X33 returned -22
#      SKIP      MSI-X33 is disabled
#            OK  pci_ep_basic.MSIX_TEST
ok 16 pci_ep_basic.MSIX_TEST # SKIP MSI-X33 is disabled


There seems to be a bug that "pci_ep_basic.MSIX_TEST"
returns status ok, even though MSI-X1 returned -110 (ETIMEDOUT).

If you don't look closely enough, it is easy to miss the
"MSI-X1 returned -110"
and only see:
ok 16 pci_ep_basic.MSIX_TEST


Perhaps this is what I missed when I was doing the same conversion as you some
time ago.

Anyway, I do see the same problem as you. For some reason IRQ 1 is not working,
but all other IRQs are working.

Unfortunately I don't have any ideas.
MSIX_DOORBELL_VECTOR is 10:0 so msg_data can have value 0-2047.
Thus, it looks correct that dw_pcie_ep_raise_msix_irq_doorbell()
sets msg_data =  (interrupt_num - 1);

FWIW, I think you should send out patch 1/7 as a standalone patch, so that
it can be picked up ASAP.


Kind regards,
Niklas

