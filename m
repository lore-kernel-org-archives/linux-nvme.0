Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00522C3ABC0
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 17:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2PhuccIEiZ3scnRXNt96L7h3yuxtXBi6TGbQ3ttxJEM=; b=B/5fF5DO1UNCQAMn5uEYxfXtv1
	na3ZVCOsYicWSiOqG+ckQVd0uouvmdigF2jVYSpy2t2HbSasV3IMty9pbzhO1MnUuWi19KlLgPeEf
	TO9qrBItrE9expYeMBxpbTZZYiM5/IUSsp/l8I+KiEqOQedkd9yuJ/IJ3zKZXV5WaIKtj8k71staO
	RAOm2wOIxazrE+0WfTPelKDTrmaZmU70MfNj7jbkjTtK1hTYnPmWnGaUEp71XtjhivnuP7eGZYRu7
	wlaALj+KQoHKrnJCoBlVXtWJK82M0dWxK1cqVbd914j3gnzUoSQwff3FwA2k+Vda4l4Qe8ZuMx4dw
	/mW5nOYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCiWs-0000000GIPk-1E77;
	Wed, 07 May 2025 17:25:58 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uChCP-0000000G4eV-2jgT
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 16:00:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5E6AA437AB;
	Wed,  7 May 2025 16:00:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE4FC4CEE2;
	Wed,  7 May 2025 16:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746633645;
	bh=murxxHC0F5RAJmpzPBp2DaXWwoLRB/TK3/yjau/uW6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GxsMPIvt9XtPhNQPKET9an+XAjBYSr4fQyjqvqgA51KIDoAvTcnWiGK0bKO3yWGan
	 uwN2fS3Tkxh4JIU/mH7k2rRMZQtLRpDu4qf3+rZjCLEdFNbNzRkvxzkgBWfpW9mufD
	 VRZclSlRzEqjCrugLqpcZwF3CZYfhn22KGPx16qR4+4YZTsodpxnFq/JH0+YAyavCa
	 0A6azIbv/aEAnw7lC0rOc7E2NhiZ8lUJyl3AMXtj2VvMvUmRQ+K/PK0T4PPyi7fwsD
	 vxU50Q9g9jp6SV4AxBBRkg/R/Edr7W9ZYh86R/rFLUzNMnJXYCqFVwAkq5oTEtDl7Y
	 K5ziO15epg6QQ==
Date: Wed, 7 May 2025 10:00:42 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, kernel test robot <lkp@intel.com>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Make nvme_pci_npages_prp() __always_inline
Message-ID: <aBuDqr-9YCcVfAPi@kbusch-mbp.dhcp.thefacebook.com>
References: <20250507033536.work.088-kees@kernel.org>
 <20250507044754.GC28402@lst.de>
 <202505062255.130383D3B7@keescook>
 <20250507065913.GA31959@lst.de>
 <202505070849.1F48789B6@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202505070849.1F48789B6@keescook>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_090045_707100_98C28083 
X-CRM114-Status: GOOD (  10.59  )
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

On Wed, May 07, 2025 at 08:53:06AM -0700, Kees Cook wrote:
> 
> So, the solution for the "accidentally depending on a function to be
> inlined by the compiler" is to mark it as _required_ to be inlined,
> which given its singular use in BUILD_BUG_ON(), looks like the correct
> solution.

That sounds fine to me. Or maybe this should be a #define instead. It
looks like this nvme function evolved from a very different purpose when
it wasn't an integer constant expression, and the comment above it is
outdated.

