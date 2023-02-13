Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA7CC636D7
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Feb 2023 06:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZU57fp8nO+hTPdWDlmup+6bGshQBtrxgRnWnUD2+SsU=; b=z1uX9Y9y1/iKUwJVg1WvWUydVA
	w8SMWx/81n+O4GSopwcpC2nnxDTyrJoXYEFKZSYPSAUkjoCsS9GLad3mAzJvFgUIOzAV/DFX1+rLg
	MGakCaoSmrg+Tq/86h4OMjsyupigDs5Q/FYy8bGTFZK/9gQ7cQQUUdiUFiNIiAmiL0au+/OGPHShC
	W37eGXChFv7FI4G6/yeS+kCchbAcVrArgFbu5z6UMnVncCtpf4D6i5dWw/6uKJ8k/1COQSkWXMP3Y
	HLJ0o8kphd58237+e8lpKLRscbuq9W3aUPDC9WLwSSNIgf3HoW3Rbm6pweDXTpf1q1fwtQ2pxh48j
	3EcyMDZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRS4b-00DJei-Lg; Mon, 13 Feb 2023 06:12:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRS4X-00DJdF-Fg
	for linux-nvme@lists.infradead.org; Mon, 13 Feb 2023 06:12:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0B39E68BFE; Mon, 13 Feb 2023 07:12:14 +0100 (CET)
Date: Mon, 13 Feb 2023 07:12:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, schnelle@linux.ibm.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/2] nvme-pci: fix freeing single sgl
Message-ID: <20230213061213.GA14070@lst.de>
References: <20230210180347.3613573-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210180347.3613573-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230212_221218_586313_F61B85D3 
X-CRM114-Status: UNSURE (   8.09  )
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

Thanks,

I've applied both patches to nvme-6.3.

