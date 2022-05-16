Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D41C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 16 May 2022 05:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dntl1cxMjLS6R204LbQmYbBJakpiTbtIXHORF8Xc3IQ=; b=Ie/Vk7PwSxEwZOqkCNgMTT+Kur
	UV20mrrBQrdPx3OnByKCL7zSumJfBizuZfwTbPFudECXwiuhDMXxpskKaHaX4UDrM92uS8QjZ6o4j
	u3TqXmdtst/v1D5fzUbt7obNihWArdn4l9aAT7bOo3XfKlZnnGcXqEqLNZIU/OnRtM1UgjDGTxOpQ
	0vBuDJiinCnI/OmIKhAT1QQBYzaPOkNs8/w/RUlMQIs/tT975jNh2JagozhaVBx6Ln9LlV3UZfkrw
	au8PbD8TW6kEisl09qReSRAC+yABHgf9mBKu17B+Jf4ap99qHPVNbB+BWQ6ujaCYyh6CjTEjVPt+F
	56SPuUWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqTXN-00644z-8I; Mon, 16 May 2022 05:44:57 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqTXK-00643A-Po
 for linux-nvme@lists.infradead.org; Mon, 16 May 2022 05:44:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B6A4E68B05; Mon, 16 May 2022 07:44:42 +0200 (CEST)
Date: Mon, 16 May 2022 07:44:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: bhelgaas@google.com, lorenzo.pieralisi@arm.com, kbusch@kernel.org,
 hch@lst.de, linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, svarbanov@mm-sol.com,
 bjorn.andersson@linaro.org, axboe@fb.com, quic_vbadigan@quicinc.com,
 quic_krichai@quicinc.com, quic_nitirawa@quicinc.com,
 vidyas@nvidia.com, sagi@grimberg.me
Subject: Re: [PATCH 0/3] PCI: Notify PCI drivers about powerdown during suspend
Message-ID: <20220516054442.GA12171@lst.de>
References: <20220513110027.31015-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513110027.31015-1-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220515_224455_016477_230C3B7C 
X-CRM114-Status: UNSURE (   9.00  )
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

This looks workable to me, and is fine with me from the NVMe side.
I could see arguments for passing the flag to the actual suspend
method, but as that would require much bigger changes I'm not going
to ask for it just because.

Acked-by: Christoph Hellwig <hch@lst.de>

