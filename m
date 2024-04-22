Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE8B6C4345F
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Apr 2024 13:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=upoGKrJkRGN2TsP5uld+raQacJbnLT7pseXPW8+DoF8=; b=B4V3cGNKM9v9cAVd+4fyX/58G/
	rNEINOL593wyC/ZnCrM5s5vIVEwJ2wG3DZ3P93MBmh1rsc609Y3RvlMcQmOkX+WFsVhbuir4gxD84
	6OpNnvEdgH7mPTtCmxmIwteyHBlndOcvN4i2OwSNMr1X9luEHs0fG2t4DPQTn/wWUuBjbWyvtGmsJ
	mOdLXaWetELe8Uuc3fDpgbgWUgSeyD5PCHR7l+OA+ymtUefpJIbDBEXS/nCn6ZW7f4Le01Lk6kEva
	WKLkPJzugsB7AsGPPjGEEWdW+ONIe8Xbwd51yIQ/ilrGidYTz6heUy3Odcd60takjJ0NYocweHiiY
	QPL7Wkcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryu5w-0000000DpOm-0qEK;
	Mon, 22 Apr 2024 13:52:32 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryu5t-0000000DpNZ-3oRB
	for linux-nvme@lists.infradead.org;
	Mon, 22 Apr 2024 13:52:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 60E5B60DF4;
	Mon, 22 Apr 2024 13:52:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8B2C32783;
	Mon, 22 Apr 2024 13:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713793949;
	bh=0HspCuB1hBKnh/pR1CggY0E1H1Kaq+SeWPeu/THFQ3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SJDIoB8ijhw3GNK9+1Nc6sT501xvlnj/66Jlqj95klVCuIPUGSXf2hNXBncWhTBMS
	 7pT0uCZNOOYFrpBKJzvZCFaF9DTbrtiGnxYg+KAP/XDsCVHnfKcM7OfJsGrf/uHvgG
	 EVFBvN2tRnD67AfvQmA++U31CU6Lco5fxNNwXLD2uKpfCvbEsperlXQsiJAVwYGIZB
	 LGNPujm5EjEOe7dmE8QRTs8ByzhmJGvfi/s7oGWDCgeODoZ+QB0FucOUqN6e3R1Kox
	 jyMa1EALPoBpXgcoPrATbsTaZjqxmnUUCSkW3iHeN8CibjnUgAfAa+4cI0pc8M13U+
	 aLaxnh3qSIJmw==
Date: Mon, 22 Apr 2024 07:52:25 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>,
	Gregory Joyce <gjoyce@ibm.com>,
	Srimannarayana Murthy Maram <msmurthy@imap.linux.ibm.com>
Subject: Re: [Bug Report] PCIe errinject and hot-unplug causes nvme driver
 hang
Message-ID: <ZiZrmSW6s7lY7j98@kbusch-mbp.dhcp.thefacebook.com>
References: <199be893-5dfa-41e5-b6f2-40ac90ebccc4@linux.ibm.com>
 <579c82da-52a7-4425-81d7-480c676b8cbb@grimberg.me>
 <d33a5681-b195-4258-8eee-e0eae46ade5b@linux.ibm.com>
 <627cdf69-ff60-4596-a7f3-0fdd0af0f601@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <627cdf69-ff60-4596-a7f3-0fdd0af0f601@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240422_065230_015678_984AD70E 
X-CRM114-Status: GOOD (  15.48  )
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

On Mon, Apr 22, 2024 at 04:00:54PM +0300, Sagi Grimberg wrote:
> > pci_rescan_remove_lock then it shall be able to recover the pci error and hence
> > pending IOs could be finished. Later when hot-unplug task starts, it could
> > forward progress and cleanup all resources used by the nvme disk.
> > 
> > So does it make sense if we unconditionally cancel the pending IOs from
> > nvme_remove() before it forward progress to remove namespaces?
> 
> The driver attempts to allow inflights I/O to complete successfully, if the
> device
> is still present in the remove stage. I am not sure we want to
> unconditionally fail these
> I/Os.    Keith?

We have a timeout handler to clean this up, but I think it was another
PPC specific patch that has the timeout handler do nothing if pcie error
recovery is in progress. Which seems questionable, we should be able to
concurrently run error handling and timeouts, but I think the error
handling just needs to syncronize the request_queue's in the
"error_detected" path.

