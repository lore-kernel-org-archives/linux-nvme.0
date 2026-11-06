Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19262606A32D
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=e3vmKx+S
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=7aThGOOyvVFFZf76jFKdd1hLLs6+KlZdH+wSiEt6/y0=; b=e3vmKx+StnXCwVT9apB10xeIj/
	dM7eUmZH/0JVkbLNBTEbO+Pll4w0fFImOoFCz06K0SqtuVOpL41kZf/Cl+dVAYNhiuYduNu6uyGlh
	W64zcBiadppxSa9V5OHgQPgvUEMyWCU2LjZGysgIo/Sd7ojWSTB89N9nyuuHOqkeqSAMgLMxpjLFq
	no6oBDxLz3ZD+Ecv6mwm1UbvcrQZUMBGCwRv4xSvm04ekbsp3CcJrCzqE3q+8hLrdhzj6AIcp82k6
	zFBXa8CK7VZBPAV4/L2bs7DHidm/CAMgoS67w1gh+4RDG1jUH0y5/ZE5X0EUNNuB7FaSBpO6hAsAF
	qZD0xk1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPHGT-0000000Bwxr-3MhU;
	Fri, 06 Nov 2026 10:33:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPHGQ-0000000BwwN-49RQ
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 10:33:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B2B3968BEB; Fri,  6 Nov 2026 11:33:39 +0100 (CET)
Date: Fri, 6 Nov 2026 11:33:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/6] nvme: reject a reconnect_delay of 0 through sysfs
Message-ID: <20261106103339.GB5453@lst.de>
References: <20261106015842.3534898-1-kanie@linux.alibaba.com> <20261106015842.3534898-2-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106015842.3534898-2-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_023343_179290_56D76FD7 
X-CRM114-Status: GOOD (  14.98  )
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

On Fri, Nov 06, 2026 at 09:58:37AM +0800, Guixin Liu wrote:
> nvme_ctrl_reconnect_delay_store() accepts any value the option parser
> also accepts, except that it misses the lower bound: writing 0 is
> rejected by nvmf_parse_options() but not by the sysfs attribute.
> nvme_ctrl_loss_tmo_store() then divides by opts->reconnect_delay in
> DIV_ROUND_UP(), so writing 0 followed by any ctrl_loss_tmo update
> crashes the kernel with a division by zero.
> 
> Reject 0 like the option parser does.
> 
> Fixes: 42a45274c2258 ("nvme-fabrics: Allow ctrl loss timeout configuration")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

I think the Sashiko nit about the fixes tag is correct.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


