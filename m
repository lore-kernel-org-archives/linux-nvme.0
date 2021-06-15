Return-Path: <SRS0=Oc5T=LJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E768BC48BE5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 21:56:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2A74611AB
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 21:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A74611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BpXKv2FFrZe3CkVJyD80quiZvtLOoOt/6No2fTGSuqA=; b=QZH59t1lK7W7Uj
	DlGiplee8iu+mz833Dsq2qRoPzEjZ6tG+a0kvcyPoj9eZ0NK+7JRvpT19IrYstGv47ozAagYmGoLu
	y32CG+Du6B1UPEovhsGz+7ZEjliM+wGkcLhR0YF4oizKlSCdAZeG6TqN4G0WPaolkxDy/XIq8B0mV
	fAh6MLlQRXlRptNhbE6R94ilV2Q+JbLP+La1ziyBGXOscyujjlpWI/eK69YGAcrKvgxmMhz8a7svt
	4osxsuTdoFoNjIiU08sB3+nVd6PKXSlJTh7Nm9VRuV2iTuriPI427CPB5GkMjEaT4ZcFsYmzaMZSu
	qvlvoYAn/yxtR8LI5dOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltH27-003MEa-2M; Tue, 15 Jun 2021 21:55:43 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltE17-002Chn-1u
 for linux-nvme@lists.infradead.org; Tue, 15 Jun 2021 18:42:30 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A3C361107;
 Tue, 15 Jun 2021 18:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623782548;
 bh=D/F/vwHy5DjGD680manwbLPJU/iB8wr0DxB1fnBe6LM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Raq/+rSSducYVOcutz5LV2Xd8JSKSpp3/oJu/Y28i2GBbn216pKccyEiM9WpLnAAx
 s771gLOMzURsGBdseR69cxcsYPxWmJ6wpr77AakH45AplEcvIKGWvjpgXOoIk/PlfR
 0qoz9m3MQ+Imm9BmCfquP0nCZkfBRY4x7Oo7Uh7u2/fC8uWnD2OfP6f65Go56XyGFL
 5RQUHjXJcjF8tO5nOs0YI4abdsDQMdfk2PJiqSR4HMgroV89XaBjrhJ6b1+cb7p0W5
 5GNf2OgqDFZlEVYJElWePWvHGKLXRTfYaSSEJMym6q1hiJFPJuQXdHUksbc1L6TnSB
 pCwH4My8CtVCA==
Date: Tue, 15 Jun 2021 11:42:26 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH 0/4] nvme-fabrics: remove struct zeroout memset calls
Message-ID: <20210615184226.GC646237@dhcp-10-100-145-180.wdc.com>
References: <20210615024554.42585-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210615024554.42585-1-chaitanya.kulkarni@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210615_114229_170610_1528A851 
X-CRM114-Status: GOOD (  15.47  )
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

On Mon, Jun 14, 2021 at 07:45:50PM -0700, Chaitanya Kulkarni wrote:
> Hi,
> 
> While reviewing the code I did removed the calls to zero out structures
> using memset() for the lio target, which are reviewed and accepted in
> the linux kernel tree. (see [1])
> 
> This patch series is based on the same cleanup pattern for NVMe host.
> This will allow us to have uniform pattern in the future code review to
> avoid similar calls which seems unnecessary.
> 
> If this is accepted I'll gradually convert the rest of the host code
> mainly core and pci.

This looks good, and aligns with the local style. For future cleanups, I
think it would be fine to do it a single patch instead of individual
patches per function.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
