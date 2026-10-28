Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF44606A31D
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ymXzTUvw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=rT4EsW428W7L/HXUKj32bjct/IMAM7+t4B6+nqzxxIE=; b=ymXzTUvwWOxSQKPlBPf4GKhHwC
	iTJehbI5z42Lf4Qd/bT34P0iCsnwE9r9XS01n0u4Iafx2u6dwHjO9qXbid00z6qABQdXCGuaK8kwK
	JQ2eVbwA/SB+JxZnJH/d4HsbSXY8Oz/d40nE/OpK5S6qUGK2JyczWZep5miDO48gxoL8cBSrciI2i
	9P5e0cpQv/O06ZKZxUv+KpuijpO76VHuAf7JnzznYnYwssPr5EupbG4vlEsVGani7YrhtJlR63vC7
	1tx0hCgPIjOJelXqIHPjubSzHHf7bFV+FsdwBqodLXfkuhpvcmcOQhY1pQn1hvQ07JS/5LqvSq6Wg
	3hloknKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM54z-00000007Gup-0Fez;
	Wed, 28 Oct 2026 14:56:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM54w-00000007Gtr-098x
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 14:56:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9F96F68D1E; Wed, 28 Oct 2026 15:56:30 +0100 (CET)
Date: Wed, 28 Oct 2026 15:56:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] nvme-pci: shut down the controller if disabling the
 HMB fails on suspend
Message-ID: <20261028145629.GA15112@lst.de>
References: <20261022045828.1392332-2-oss.patchbox@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022045828.1392332-2-oss.patchbox@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_075638_222628_CF0DAD1F 
X-CRM114-Status: GOOD (  12.57  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 12:58:18AM -0400, Yuho Choi wrote:
> This was found by code inspection as part of ongoing, not yet
> published research. It has not been reproduced on hardware.
> Compile-tested only (x86_64 defconfig with BLK_DEV_NVME=y, W=1).

Yeah, the only way this really should happen is a communication
failure.  But your handling looks correct, so:

Reviewed-by: Christoph Hellwig <hch@lst.de>


