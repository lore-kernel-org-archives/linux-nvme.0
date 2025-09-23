Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9783CCA470
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Sep 2025 06:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K+REPAt7YGROMU060Sut8pDiJmmKCZ4JFkal1RQOmGs=; b=hD+UfI1+jvJoFet7gqN+rb0g4S
	EhpJft+2oPxSOwmaCmI6a89PFRk1LtMF+Z2KAW1i5usiK7OTBVqL6uRz+IFUD8Lj0zildSDauuU/n
	xVWzAugwEtDwqhwm/Zs3ziQgaSeUESBo31u6IKu7PnO29rWGLsFcbcR/PVEK+Nl1l8cUg59K2M45+
	EQ+SUVaBb/hvnZq4xwz7eSNx5bPZmdzN6/dPGsYBr+8wS7oUVpxlsXdkEumgCx7qoRPFJUsqdtqLq
	u2ZP0ZH01wxmuKgy7Yx/GduztAVA+l1Pcjo1axW54tnCl2BCBkvoROI3NXU+npDP1l60NoVy7haXi
	BAPJiUKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2ORC-00000007fBn-3GkW;
	Sat, 27 Sep 2025 06:29:42 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1BbM-0000000F56j-2YSr
	for linux-nvme@lists.infradead.org;
	Tue, 23 Sep 2025 22:35:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 34F4144593;
	Tue, 23 Sep 2025 22:35:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E0DC4CEF5;
	Tue, 23 Sep 2025 22:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758666911;
	bh=K+REPAt7YGROMU060Sut8pDiJmmKCZ4JFkal1RQOmGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NfvKLIECePVJSfIsLMzuzmM3Lfkth90P9jpbucNQ1bDMKtxnUUxV5JFtKuhdhpmWb
	 Cw3GZEX3eQpIT/PWZ/yXnZMG824R5TCQPjlm98ugF9huAG8DeaThH3gkBcbwr/TZuE
	 vm/De9fznWxi8yL9W3hbwpzVsdSjYKdJINx4sFLGsP2083YAha5J9C5fBwD4MqMtXT
	 ir+xFYNttlpYqZZmrRAZCSLQPAaJ5po2rCCjv7hee+rH9n2nEI6G7JOlhDYZQf0/X1
	 1DkImokD6CqYRTWU50ZSiWc781Xdx+oofE6BqZqS50/4CeH67G98lYY+2B9ZA6UvmX
	 2kJmK3McZDdRg==
Date: Tue, 23 Sep 2025 16:35:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	David Hildenbrand <david@redhat.com>, iommu@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>,
	Juergen Gross <jgross@suse.com>, kasan-dev@googlegroups.com,
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-nvme@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-trace-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, rust-for-linux@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	virtualization@lists.linux.dev, Will Deacon <will@kernel.org>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v6 00/16] dma-mapping: migrate to physical address-based
 API
Message-ID: <aNMgm33W7gh75h3t@kbusch-mbp>
References: <CGME20250909132821eucas1p1051ce9e0270ddbf520e105c913fa8db6@eucas1p1.samsung.com>
 <cover.1757423202.git.leonro@nvidia.com>
 <0db9bce5-40df-4cf5-85ab-f032c67d5c71@samsung.com>
 <20250912090327.GU341237@unreal>
 <aM1_9cS_LGl4GFC5@kbusch-mbp>
 <20250920155352.GH10800@unreal>
 <aM9LH6WSeOPGeleY@kbusch-mbp>
 <20250923170936.GA2614310@nvidia.com>
 <aNLnXwAJveHIqfz0@kbusch-mbp>
 <20250923222216.GC2617119@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923222216.GC2617119@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250923_153512_672128_7D673073 
X-CRM114-Status: GOOD (  10.06  )
X-Mailman-Approved-At: Fri, 26 Sep 2025 23:29:38 -0700
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

On Tue, Sep 23, 2025 at 07:22:16PM -0300, Jason Gunthorpe wrote:
> Very rare is a different perspective, I mis-thought it was happening
> reproducible all the time..

Yes, sorry for the false alarm. I think we got unlucky and hit it on one
of the first boots from testing linux-next, so knee-jerk reaction was to
suspect the new code that showed up in the stack.

