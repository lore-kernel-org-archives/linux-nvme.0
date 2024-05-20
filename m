Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45467C25B79
	for <linux-nvme@archiver.kernel.org>; Mon, 20 May 2024 15:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ahJhPS46ZZMHjFu06tvpsLUT3cnOc4KGb+AYS8CfPbM=; b=mHMeIFre7D07gvPxK09u/wHrKR
	BVmHZvgNUoJuoajk1S8Gv53B32m/4IgtnOzbytn/3/gWXyy3wEtDcWD9nxRJO2oIEIAbKa4rJSedq
	uOnB3oOUw6AJBsGD9Mv9rek7NLnP00jJC3mutQBy0T2GcDYJz6u7Yjd8yeZnzmLHz3g83iQmXBjLA
	9rcJnkZg0kwtDuGLexeV2ebbl19Cz4Cb01r69SxZaT4R5MO0HK2I2j30UqUFFIUTil2ycyqUx7fUF
	w7OU8+NnVGYuFlcqE90mGV2iJSvD/Rac4aEyd6te9v9iFbr0ufS8yf/9oaD1UzUbaNHKX+NvnEfpf
	tKM25wow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s955C-0000000Eroj-3ZMs;
	Mon, 20 May 2024 15:37:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9559-0000000Ero4-2Vbz
	for linux-nvme@lists.infradead.org;
	Mon, 20 May 2024 15:37:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 595D368BFE; Mon, 20 May 2024 17:37:43 +0200 (CEST)
Date: Mon, 20 May 2024 17:37:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme-pci: allow unmanaged interrupts
Message-ID: <20240520153742.GB921@lst.de>
References: <20240510141459.3207725-1-kbusch@meta.com> <20240510141459.3207725-2-kbusch@meta.com> <20240510151047.GA10486@lst.de> <Zj5JMqWRY187PqnD@kbusch-mbp.dhcp.thefacebook.com> <Zj6yvTxIpUnOXl7R@fedora> <Zj6-1sXvUNZWO1pB@kbusch-mbp.dhcp.thefacebook.com> <87r0e7mt9w.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0e7mt9w.ffs@tglx>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240520_083747_799205_61A1A77F 
X-CRM114-Status: GOOD (  13.53  )
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

On Sun, May 12, 2024 at 08:35:55AM +0200, Thomas Gleixner wrote:
> That's expected as you pin the I/O operation on the isolated CPUs which
> in turn makes them use the per CPU queue.
> 
> The isolated CPUs are only excluded for device management interrupts,
> but not for the affinity spread of the queues.

We'll probably need a version of isolcpus that also excludes the
interrupt spread given that users are asking for it.  And I'd much
prefer that over adding radom module options to every driver to disable
managed interrupts.


