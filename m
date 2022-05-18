Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EA6C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 13:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u7fUpB+JuVpAGJyPH6gm4B/Gk36d8rWrqDcCaxC+4w0=; b=qcNPDetho6OjWf/+PzEzQh7lpK
	3KrkjShkaQqHCrqqlAx2VqX6k3K3gxIIvjDWtu/2t1tqX1ydmkLyPlCYj3u6fQTVfb76TQQDpU7uZ
	bqvQpnzAbT3w+fuEtdw+/e/vHhuMKw7/TDGi7Z8rK/LcTc7QHZ4AVfVXZHkf8kM2WR0uUf2UEkiBe
	zMxG9USARpWCzeslnW93SXyfv46RDU6LY3gfVDAuhZI34JilSECPtXPmVPTdgctJqmDcIdCHYa4X5
	De9159ABjNFDCrxvGOB28U295Fi9cmWDl0YUmrWDnjAtJ8IqAxc3aqvupIISV+8rWpPAX2fLonB+O
	zKPq8qvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrJeq-002Hnr-7b; Wed, 18 May 2022 13:24:08 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrJen-002Hlh-B8
 for linux-nvme@lists.infradead.org; Wed, 18 May 2022 13:24:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D137268AFE; Wed, 18 May 2022 15:23:58 +0200 (CEST)
Date: Wed, 18 May 2022 15:23:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: bhelgaas@google.com, lorenzo.pieralisi@arm.com, kbusch@kernel.org,
 hch@lst.de, linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, svarbanov@mm-sol.com,
 bjorn.andersson@linaro.org, axboe@fb.com, quic_vbadigan@quicinc.com,
 quic_krichai@quicinc.com, quic_nitirawa@quicinc.com,
 vidyas@nvidia.com, sagi@grimberg.me, linux-pm@vger.kernel.org,
 rafael@kernel.org, Prasad Malisetty <quic_pmaliset@quicinc.com>
Subject: Re: [PATCH v2 3/3] PCI: qcom: Add system PM support
Message-ID: <20220518132358.GA26902@lst.de>
References: <20220518131913.26974-1-manivannan.sadhasivam@linaro.org>
 <20220518131913.26974-4-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518131913.26974-4-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_062405_573332_77FFCE38 
X-CRM114-Status: GOOD (  14.22  )
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

On Wed, May 18, 2022 at 06:49:13PM +0530, Manivannan Sadhasivam wrote:
> From: Prasad Malisetty <quic_pmaliset@quicinc.com>
> 
> Add suspend and resume callbacks to handle system suspend and resume in
> the Qcom PCIe controller driver. When the system suspends, PME turnoff
> message will be sent to the device and the RC driver will wait for the
> device to enter L23 Ready state. After that, the PHY will be powered down
> and clocks/regulators will be disabled.

So what about just not doing this stupid power disabling to start
with?  Unlike x86 where we do not have choice due to the BIOS, we
apparently do here.  And disabling power is the wrong thing to do at
least for SSDs as it massively increases the wear on the NAND.

