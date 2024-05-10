Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3614C25B74
	for <linux-nvme@archiver.kernel.org>; Fri, 10 May 2024 22:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=re3VoZzU2TIsrtRvUJ4q0JjRlgL7V/zeHjoJu92vi5c=; b=Li695Sx1CdrQA5BpVEqzCvN1zF
	rcO/juVoGTlYfOOxzR2ZB6SU3v+jgh/kXx1BC/4D2vzEqOZKQU3wiAygkHZY4XSwkKrV2Ne8msFau
	qeQa9655mf5uMQYVQltRVW/8rYhApJhgT2YXRnkcMFTgHGUCSIOtFe5A4MhcIB3xGW114ZAxMCMJ1
	PCn5XaB9Yi17lwAIJ2LLbbpfoQ6GtCVH7QEj8zb+VSovdlrgxVAIeK6VyaCxmLTtRHa+BnE/QhAs6
	wUi/jQaqLttQwuvCnT7j2qNdOvlcrifrj+Ugc7uIqphAC2ATGZxF/S16OoSdrJfxDUIr9GpaWXvEv
	Kveu11ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5Yrm-00000006gQq-11LU;
	Fri, 10 May 2024 22:37:26 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5Yrl-00000006gQU-03hH
	for linux-nvme@bombadil.infradead.org;
	Fri, 10 May 2024 22:37:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=re3VoZzU2TIsrtRvUJ4q0JjRlgL7V/zeHjoJu92vi5c=; b=F6lUujE/CS42DjAijXt0Zr+hpk
	7MfNwJU218yFYQowlW/s/whrVtcUK52nFpST/m+6Z/eMLIuQ9hyMTewcfKj3bL2J697DLrSXtnx9/
	2qF5V1ZpL0d7l7FTFq4sOLxSbHTiE/grDRb2aOVqyP537WOMP4f7ALoI7sIhvEzmDGv9wwWwxTSuT
	m5IEtUj/jaMiI/fAaq7mKTBw3MzOgUNNvXNG9zZmMhmyetUkkTR3BjQ+uHx2TKJo8fsSABi8mQ1Ej
	RRR+h0zzNamMwFMad2wxACTW/WW1vg7InVI07qAdhmjPIppD6uvMSxMw5R/1+20lifcyeZmPz/q69
	/cOCey8g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5Yri-000000045OH-4ANm;
	Fri, 10 May 2024 22:37:23 +0000
Date: Fri, 10 May 2024 23:37:22 +0100
From: Matthew Wilcox <willy@infradead.org>
To: hare@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 5/5] nvme: enable logical block size > PAGE_SIZE
Message-ID: <Zj6hotHEsOSL9h1K@casper.infradead.org>
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-6-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510102906.51844-6-hare@kernel.org>
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

On Fri, May 10, 2024 at 12:29:06PM +0200, hare@kernel.org wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Don't set the capacity to zero for when logical block size > PAGE_SIZE
> as the block device with iomap aops support allocating block cache with
> a minimum folio order.

It feels like this should be something the block layer does rather than
something an individual block driver does.  Is there similar code to
rip out of sd.c?  Or other block drivers?

