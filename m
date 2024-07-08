Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF53C3DA41
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jul 2024 17:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PAoDsKPKesEGP0Y/5n6UejERjl6o03pl9N5sH0gTRVc=; b=fq3TaLlzwEfjHEfbXGnegrJhq+
	OROqk7QwqJi6DVHzw9OQAVO+2fXGsoEuDOW5c5amBtwHf7Vp85e0oHM4RyDZgKPTlEQChArvRZuc/
	+BMBibLae9MrnOKrBCIkPZZeM9sjbTvgaW+DHhWf10TXHOq7hbyDg/NLKzHBYu4JIJSIzPycReGf/
	1bIsNkrKMrVcTMSlVfY/t7rtKO4iWXLt/YQa9TQIZWn7Bm0f6VXJbFnrMVi86jUjKtKToIOtsdl33
	/fMoTnd+922dd8HD5GLA7WY2gFeqlX61m7Ah8dj1M4YPDcNgkYUQPtUpt484X+/Jr3LNidtNk3o/n
	IfQ9THvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQsVN-00000004d4M-1oqm;
	Mon, 08 Jul 2024 17:50:25 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQsVK-00000004d3Q-2bbJ
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jul 2024 17:50:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id F34ACCE0EAA;
	Mon,  8 Jul 2024 17:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CDBC4AF0B;
	Mon,  8 Jul 2024 17:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720461020;
	bh=NR9bvrDePTycQHC2juAdcymV6q+4d/hvumQ76U/UVtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TghK0vy8VYmt5IWaouphK5MEpRZFbJZavnudO9ZABqQx9und7bFsKFKt3anIxg4L2
	 W65Z1KgNZppdSznJPQp9pBvXimc/Zy1xqByEYxHNSnB75iWvvkrBp44uboyOQhb0/H
	 rnLQ97x0tAO/M0hslLEXhruCPUp+hOZ3nUGUfIp52dmIp03iYqCDc/NhlW5XV5dt2n
	 J+64n+TqDuYLs9T47rUmSOR1Zo77dA4LJKP4EBGydfGIvC/jJota+v6iVd5rj+DrG+
	 bIoqHE6C1MTcq2ZvmQkvXWw+jfisXvAI9pzTiz8qvzzUMRCIKIrpkxsBUAw/E2MGfT
	 K46q0Zn6VTs1g==
Date: Mon, 8 Jul 2024 11:50:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nvme: implement ->get_unique_id
Message-ID: <Zowm2hDp_B81P2qQ@kbusch-mbp>
References: <20240705164640.2247869-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705164640.2247869-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240708_105022_859680_A8C18FED 
X-CRM114-Status: UNSURE (   9.66  )
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

On Fri, Jul 05, 2024 at 06:46:26PM +0200, Christoph Hellwig wrote:
> Implement the get_unique_id method to allow pNFS SCSI layout access to
> NVMe namespaces.
> 
> This is the server side implementation of RFC 9561 "Using the Parallel
> NFS (pNFS) SCSI Layout to Access Non-Volatile Memory Express (NVMe)
> Storage Devices".

Thanks, applied to nvme-6.11.

