Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02AFBC3ABB0
	for <linux-nvme@archiver.kernel.org>; Mon,  5 May 2025 14:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZV1Z2VR14ylgUix5FI+lRqQxmCZ8sNITwbPQ8g/6YZ4=; b=l4K1cKuV2Ucm/oMbxQKV+rqmT/
	zUHeA/GlsfhIIwZMYvD+dxRA1CLuKehLnFeUWnjjJCX2UObt3QMc3e/8lqEIP9ZBzF7Zm3UMvdo4n
	jEqG3zQv6XIlYrj80jzORKwGGBToVucijv71Wvu+X7S0pUxOfNIKDr2Q6kTqKnXL2RB+8VPrKJFLQ
	4hEZq48vOLNUUVmAAfdyIFYMleQb2hKDznn9Of9Tghw68iKnB6qqOkNbaI5q2sXSnL7ydinR7e9EN
	YY63U2MhaQh+CKd+u5q/cdfJ9Sa8GEYovAZfz46kLQXtWdNx+Kn2q6CrobKQkiaXMH1VtWzihcrf1
	kghQa0qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBwhE-00000007c6w-0qgi;
	Mon, 05 May 2025 14:21:28 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBwh8-00000007c4n-36kz
	for linux-nvme@lists.infradead.org;
	Mon, 05 May 2025 14:21:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3D1C75C553D;
	Mon,  5 May 2025 14:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72633C4CEEE;
	Mon,  5 May 2025 14:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746454881;
	bh=ZV1Z2VR14ylgUix5FI+lRqQxmCZ8sNITwbPQ8g/6YZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sySoIGMPnXUia5gYgjghar7ayTInJeYfRjo2/RniRA41GldkAI2ofuMu+WZG3CAXH
	 JvXuPMjVSMmQnyW+6xyj88pSxOTAN7RDvRMCTVMguHzr+4Vck1CZCanTIpzkKniKHG
	 et31GrPjuani2EXpEvdZY8+Y7L//LHseeLjMc+fUi1idbEC+rV2dta8ZfatCQ5Dwfu
	 7Dzk7m9RXC4GCBsklFVloFDarYOorTi6RLZy3Ld5mkUoa7Ept3bxn/h9nYDadJcsTH
	 Fvkk1SAmCw+axLL2v+I/vUa206XXCA2FtvC2LanRYViRWuIo1PJ/0kIc09OzVGUXss
	 j1TzuqzhjSpZA==
Date: Mon, 5 May 2025 08:21:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/3] nvme/pci: PRP list DMA pool partitioning
Message-ID: <aBjJXo8Svq2f3E9N@kbusch-mbp>
References: <20250426020636.34355-1-csander@purestorage.com>
 <CADUfDZr=OWv-bt+rzNQZ7zii9JyNxmkYCJxXCiCNsoHhT5UcYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADUfDZr=OWv-bt+rzNQZ7zii9JyNxmkYCJxXCiCNsoHhT5UcYw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_072122_820464_A4BC1DA5 
X-CRM114-Status: GOOD (  13.25  )
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

On Fri, May 02, 2025 at 09:48:17AM -0700, Caleb Sander Mateos wrote:
> It seems like there is consensus on this series and all patches have
> multiple reviews. Would it be possible to queue it up for 6.16? The
> NVMe tree seems like it would make sense, though maybe the dmapool
> patch needs to go through the mm tree?

The subsequent nvme patches depend on the dmapool patch, so they all
need to go through the same tree. It's okay with me if nvme picks these
up, but I think we need an Ack from one of the mm reviewers/maintainers.

