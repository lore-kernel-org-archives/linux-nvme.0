Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A02AC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 15:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tG4T1xWKob7yml10DfZ3BDvmY7iemrYhXge2pLvvfuw=; b=oZ3dwUWPD1Lj8sUEGNYhH6q6RD
	o6ftbmNwu3+g1QdeaXYFF49WE67lb1QQLhVuR24nDHytoc0D+bkTKbbbn907YsljS4UUxEeM9AFY5
	C0oZzsHxC0W3mRxEtGZaXYScusPpyi4JNJBtaz74tc9uBUA9PzWmY0qe6U9jliq6AcIZSul8NHsb9
	/lgLNGkAURpXDszfNjqfVkx36nosi4KF6uOqGoidT//QTx2XuA3PuXAkVJrxqEx85Eh+i+GIqYB0t
	nKN9L+Eyl9ztiW9PIrlgHNmmPcXp5WhqN4w+dqRTT1jCd/2DKdOnx6aZDwCvd+esLI6z+dRwu7a+N
	/ulBOT9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p02n0-009ovy-1d; Tue, 29 Nov 2022 15:44:54 +0000
Received: from marcansoft.com ([212.63.210.85] helo=mail.marcansoft.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p02mw-009otA-TA
	for linux-nvme@lists.infradead.org; Tue, 29 Nov 2022 15:44:52 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 354AD3FB17;
	Tue, 29 Nov 2022 15:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1669736685; bh=IfCJDDsMxLt3kfJAUMqL3Z5NTpKU0kkU/7mULCjG3/c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=b0VCUKLCOQx9ZwxMoDrbbRz3phbpMxUcdB/NcyXHeRfHp0UiBRQDJAEglxY9p/VBe
	 zysSMswCoTy3xEIaDh6anjk9BCGKhkDoJCX5b5VTUxBeScxEmq+iz3zQvaAS6WGEyt
	 MwYuPb1i9ZN1PWgFGRRExzNUS1uS/0hSChvsWkHRCOAjcxlq48wiKNkHIbiU21Xh03
	 32i9jOWLJG9MO+PiVVRdmI+Q1OZTsbxsnBZGABnOgqCctS3KBrKbHFjFdLhP6GFIwW
	 z+hTxRqus18bgYUdTyXyTW3YShyEuzjkMNP+Z6+FHf4DK6Wsgsn6jeHIPX0WGkjyY+
	 dft2sxN5ABHWQ==
Message-ID: <19d69d30-6bf9-aa4a-8f75-4e8f1163bfaf@marcan.st>
Date: Wed, 30 Nov 2022 00:44:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/9] nvme: merge nvme_shutdown_ctrl into nvme_disable_ctrl
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Sven Peter <sven@svenpeter.dev>,
 asahi@lists.linux.dev, linux-nvme@lists.infradead.org
References: <20221129132208.4337-1-hch@lst.de>
 <20221129132208.4337-4-hch@lst.de>
From: Hector Martin <marcan@marcan.st>
In-Reply-To: <20221129132208.4337-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221129_074451_139522_BF793EAB 
X-CRM114-Status: GOOD (  14.80  )
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

On 29/11/2022 22.22, Christoph Hellwig wrote:
> Many of the callers decide which one to use based on a bool argument and
> there is at least some code to be shared, so merge these two.  Also
> move a comment specific to a single callsite to that callsite.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/apple.c  |  5 +----
>  drivers/nvme/host/core.c   | 33 ++++++++++-----------------------
>  drivers/nvme/host/fc.c     |  2 +-
>  drivers/nvme/host/nvme.h   |  3 +--
>  drivers/nvme/host/pci.c    | 15 +++++++++------
>  drivers/nvme/host/rdma.c   |  5 +----
>  drivers/nvme/host/tcp.c    |  5 +----
>  drivers/nvme/target/loop.c |  2 +-
>  8 files changed, 25 insertions(+), 45 deletions(-)
> 

For the Apple and core bits:

Reviewed-by: Hector Martin <marcan@marcan.st>

- Hector

