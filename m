Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6E4CCF9E0
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Oct 2025 16:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0PIq5ISPDC4bpmeH5MEVkOz1Ty661z9UYQuZx703q50=; b=GdZHxnVSxIC6VHNQAnLx3niGRU
	/20gkHt8R2NDd3sd+aNR+8a6o9WMopluXpcHEy1pHJM+OyGQP/kVHdVtTTjG1776RURAKQWFL5yp9
	D9jgXCe11f99V4RROHtjDtoYUCRvV6WsVr4ctkgZIsvbcFUuQHgkoH9lXne9ESjcZWwoSzlE6ACwB
	JJQN4j4/FEUKHJHfkcBQjakL4dv8lJZgo95cnKikiNLXCFeJV+ZOE0s59slpt8Kq7dMKz+bnt8df+
	WZbc9bpPX7nKqUDRcqfxsh1CfhifDYaqzdnel3EoXmBDRKxib+/WNr6tuuHzinYTgJH3xk3uooIZ7
	P4qQ80lQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDPqH-0000000EIIN-1g1L;
	Mon, 27 Oct 2025 16:13:09 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDPqE-0000000EIHz-3jeA
	for linux-nvme@lists.infradead.org;
	Mon, 27 Oct 2025 16:13:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E5A71440B9;
	Mon, 27 Oct 2025 16:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B669C4CEF1;
	Mon, 27 Oct 2025 16:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761581585;
	bh=0PIq5ISPDC4bpmeH5MEVkOz1Ty661z9UYQuZx703q50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I4+HHYC3HFcb6OGPu+drD1Zdtd2C+BvH6NkqklJZ+OV0lq+FRMxmknxe70lvfN6ZT
	 UfdaR68MIj+47bvvQccgYR67Mg6rv3eK+/v+oxTJCdrh5GTdOe2nP2MRdI9Yffml+5
	 ukposD/w0Nyxf09yjYhsiEIQCopK0ET9ErofvfJlSDTXyqkfKsIrN8N6eINFXk1IPX
	 HzfOOu3AVWSDZ0ys2qJJZexGm7rrA7AEQ/PHLct3gLeNbL6wc2yzZB2qrFyMentJkr
	 ra/YKLlekuCgHV/Y1YTfA/9ji7xJPnrTFRw1UiPzBer7YuDrreW4XBwTAGe6wEVIxZ
	 OF5ejLHmUFtEg==
Date: Mon, 27 Oct 2025 10:13:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	John Garry <john.g.garry@oracle.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] nvme-pci: Log failures to probe
Message-ID: <aP-aD_Mh3ttRkxay@kbusch-mbp>
References: <20251024-nvme_probefail-v3-0-5386f905378b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024-nvme_probefail-v3-0-5386f905378b@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251027_091306_969591_19122D87 
X-CRM114-Status: GOOD (  11.56  )
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

On Fri, Oct 24, 2025 at 01:05:30PM +0200, Gerd Bayer wrote:
> occasionally, an NVMe drive fails to reply to MMIO reads despite the PCI
> link being operational. In these situations (obviously not on the
> boot-device :) it is preferred to have this reported in the kernel log
> instead of deducing that something is wrong by comparing expectated vs.
> observed number of nvme devices.

Thanks, applied to nvme-6.19.

