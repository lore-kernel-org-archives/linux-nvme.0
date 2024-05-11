Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F68C04FFE
	for <linux-nvme@archiver.kernel.org>; Sat, 11 May 2024 23:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zfu76T4DPAp48niDxAaHqRJdPWrA+RjCKXbxAlaC2mQ=; b=B56SGjAcAvwGLz46TF7iycGzKc
	pGrUUvwshBFy7AdG4pZiPUef0GLPXtN9Y6HO0fGYlwCv0l4dTm+D8nNXLMCtJDpuadtXfBnrjHJ42
	5DzhYigaHUkGkJ4bLZ07NowKWAyI6k2PYRz2OI4jbems3dfdYUUxxJknEH722BTR1VUNb4IOukK5T
	1JfP/Wri6KImMkq5EfSD+FHHCOQ9Bae/YB2pZCNc/Q/Sf8b3qhDbVYtSOjTsR+Mxe+LHeAmWe6pCm
	YvpfLfw4rVotHpl/lJ1VOkTURj5QKW6yVRf2fAZllcLgs9I3soSBlTuyQnRzW9q3CE4HBciSMbOCa
	R5nyyZhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5vst-00000008tav-0VoD;
	Sat, 11 May 2024 23:12:07 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5vsr-00000008taW-2AMf;
	Sat, 11 May 2024 23:12:05 +0000
Date: Sat, 11 May 2024 16:12:05 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: hare@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/5] enable bs > ps for block devices
Message-ID: <Zj_7RUso13b4FXSZ@bombadil.infradead.org>
References: <20240510102906.51844-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510102906.51844-1-hare@kernel.org>
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

On Fri, May 10, 2024 at 12:29:01PM +0200, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@kernel.org>
> 
> Hi all,
> 
> based on the patch series from Pankaj '[PATCH v5 00/11] enable bs > ps in XFS'
> it's now quite simple to enable support for block devices with block sizes
> larger than page size even without having to disable CONFIG_BUFFER_HEAD.
> The patchset really is just two rather trivial patches to fs/mpage,
> and two patches to remove hardcoded restrictions on the block size.
> 
> As usual, comments and reviews are welcome.

What's the test plan?

  Luis

