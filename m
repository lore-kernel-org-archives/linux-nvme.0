Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B94C54798
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 21:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bk0TXRWmGDqLfrayg18tJuCzrPNiXfiFUYxj25H9vQE=; b=XJmQfDckvRITraFJOy/bS37elM
	bCDFWXwhztUmNlI5feZwCeM3eK9kinRy5e9JCyB7egwWsIO9J5vUXtZiiXvvB6yQQ+3IDcNlcw3la
	QUKZDzbZNcNJF+HycGilkURlsNjkE1qwF8BEFv2bol/ohAqdWHYA1q4EcOg3GcPLCq2jQsJzOz/bA
	Z6tM91/Iscwp7MaGyJ/M5sXgVcJbVBUwykEtakQmwfl+Yg9DbsVR7JWNN00XIFN2dNJC6ckTQqbq8
	V+U2z+l3105hNbF5yoLQ8rxG3m4e/AZ+oLaOatJ/P8M+pV2yCZ0vzmYlDCqme9sSZ1hADOFSJoJ6Q
	AwWL635w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riKvT-00000006O3A-1xDa;
	Thu, 07 Mar 2024 21:05:15 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riKvL-00000006NzL-2VMD
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 21:05:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CE19D61CB7;
	Thu,  7 Mar 2024 21:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0566FC433F1;
	Thu,  7 Mar 2024 21:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709845506;
	bh=XIbVq9MKTymH7R60DIn4dfIatGTqJdL4M2k+U7pGm4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZZEOpFiXyhF+5/1zdSMZXSC6gAIOPCD0JkSU0gn1cKl3W0e8aA87B9ORk3v2bETNq
	 FE96R8sZKlE9bPRFWVSmLkEpaab2rMzr0WHo3E0qdGW4VxximmHcVfW9xTvPHVSfvm
	 RmD+M9e4jnGq3JgQCpY4ph9RsvzLtCOu9AiRrVWHMh7G4UbmZHeurq7/473bv9/mQX
	 soe3s61NMeLQ4SRuWAsNapF+g3Mb+TebrJ0iyg/LVp9f8WxggMUAQ/H9pIb9T5jFBV
	 c+Dkhf4GOMPDoGsAWqCDGoF24hTIm7+1usRAFa1g4pX6aQTlGY2aNGwhSaNsxx22YN
	 IrtZSreoAqWXQ==
Date: Thu, 7 Mar 2024 14:05:03 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Chandan Babu R <chandanbabu@kernel.org>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org
Subject: Re: RFC: untangle and fix __blkdev_issue_discard
Message-ID: <Zeor_z55xu6ulRyP@kbusch-mbp>
References: <20240307151157.466013-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307151157.466013-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_130507_719912_1CA83036 
X-CRM114-Status: GOOD (  10.98  )
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

On Thu, Mar 07, 2024 at 08:11:47AM -0700, Christoph Hellwig wrote:
> this tries to address the block for-next oops Chandan reported on XFS.
> I can't actually reproduce it unfortunately, but this series should
> sort it out by movign the fatal_signal_pending check out of all but
> the ioctl path.

The last patch moves fatal_signal_pending check to blkdev_issue_discard
path, which has a more users than just the ioctl path. 

