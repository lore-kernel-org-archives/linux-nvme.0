Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B6FC43458
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2026 12:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M5kNHTeVQeP6GA90VID8S6a+DIOg6r1Qlofc1FKuYhY=; b=4JyYQePjrCn72gfnj1qRGsNTyZ
	LFB6W+Nv2pq8AIBrCOEdSpBTFWgZNmGk/8TdGs/wEOy4Mm0HdIVSR+fTP8DEK1KGu6Y0dCe6P4Lla
	ovQIdLDyKjLDkm3eHtuO6ZQIYqZmc9nZloxI/Pu0GjYUI53B8eEHIqpnaugbFwgtTXY75TUnisixv
	vNIHK7U5+VGfdF1G4xNisEYanutw0j4934u1jv1jjm0G4gtue4cSdMnZLDSN5iqEBmyAO8mQx1B/c
	XnJk0ZSFZJy0z90we2+G62XtJuJJfTHF+cqKj6bneyZ0JNXDqUh3EkzvN2RojLlBZQ6VJVZjwEE2v
	xge1VUtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjcN9-0000000Bxx2-2zjn;
	Tue, 14 Jul 2026 12:36:27 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjcN8-0000000Bxwd-1qsZ
	for linux-nvme@lists.infradead.org;
	Tue, 14 Jul 2026 12:36:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8A99A6136C;
	Tue, 14 Jul 2026 12:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8909D1F00A3D;
	Tue, 14 Jul 2026 12:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784032585;
	bh=M5kNHTeVQeP6GA90VID8S6a+DIOg6r1Qlofc1FKuYhY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=b1Ka+0m5IhiNMZQrGOdYPQHY7nnbXwbJ0JQdG7Pe9UJsXA/9unW1haAOfURKukdYB
	 2PMXMxCo2FV/rdg8wjYEvcuQePofbEqZmJ0UXsdNi93xRqua8mDhsOVkUUorZz46Xh
	 mX31ACfz4CwYHQs60UQltFIZebLZ8mWoQiw03tV34OEX3n45Z78UXqD9zP8/eaG9oW
	 Rtg1g9Wrp35vS+jmARlVwXRwPnOsQR/HSWZA7sd/O+RG4j335Eqsm7qEixAqJESrgt
	 MlQi0LNpWCjOXk3yCvQTbi2/uGNbR9E1yxCS8mUCNi3MIR+B7LpJmEu1lRjdpulPge
	 JmBBgyXfcsYtw==
From: Vinod Koul <vkoul@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Niklas Cassel <cassel@kernel.org>, Frank.Li@oss.nxp.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Koichiro Den <den@valinux.co.jp>, 
 imx@lists.linux.dev, "Verma, Devendra" <devverma@amd.com>, 
 Frank Li <Frank.Li@nxp.com>, Devendra Verma <devendra.verma@amd.com>
In-Reply-To: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
References: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
Subject: Re: [PATCH v7 00/10] dmaengine: dw-edma: flatten desc structions
 and simplify code
Message-Id: <178403257915.822807.4369626855004661951.b4-ty@kernel.org>
Date: Tue, 14 Jul 2026 18:06:19 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0
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


On Mon, 13 Jul 2026 13:03:18 -0400, Frank.Li@oss.nxp.com wrote:
> Basic change
> 
> struct dw_edma_desc *desc
>        └─ chunk list
>             └─ burst list
> 
> To
> 
> [...]

Applied, thanks!

[01/10] dmaengine: dw-edma: Move control field update of DMA link to the last step
        commit: 99c46385edb155cfd2919b4a44d97f9ea811639e
[02/10] dmaengine: dw-edma: Add xfer_sz field to struct dw_edma_chunk
        commit: 07680003068a8008b4585423d533ab9e86a8a4d3
[03/10] dmaengine: dw-edma: Move ll_region from struct dw_edma_chunk to struct dw_edma_chan
        commit: 956028c5dde9fd1a8a462db53609c1c547cafb5c
[04/10] dmaengine: dw-edma: Pass down dw_edma_chan to reduce one level of indirection
        commit: be35502a14726e916ac41545840c5d682c5d54e6
[05/10] dmaengine: dw-edma: Add helper dw_(edma|hdma)_v0_core_ch_enable()
        commit: df9c5515501c8860a228ade47b93aff5b66544ee
[06/10] dmaengine: dw-edma: Add callbacks to fill link list entries
        commit: 2cc7ba6b168f2d0bd79f47ccc14168352a3c6cd2
[07/10] dmaengine: dw-edma: Add non_ll_start() callback
        commit: de60121a08799c4db503d44a9028856976f1cfff
[08/10] dmaengine: dw-edma: Use common dw_edma_core_start() for both eDMA and HDMA
        commit: 0d7a2719d85f9940b05eeed18e5f398b0b3219b1
[09/10] dmaengine: dw-edma: Use burst array instead of linked list
        commit: 3f3fa81cd2ace2c95a0368f2c6e6d1a1d983281a
[10/10] dmaengine: dw-edma: Remove struct dw_edma_chunk
        commit: bed94a469f2ce783f17ac0699f26277bc3c74118

Best regards,
-- 
~Vinod



