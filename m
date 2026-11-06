Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42C4606A326
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Je4trQsX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=osKRha/Hg+LQMY+UEgplE9iUYGKROlfGP9WAi8DNHDI=; b=Je4trQsX2bSb10fRZn7MsjpVpz
	HuatAxH9V94e8JmtfU9wKOWiOu/tUPFs5PpqDp2r1cASff3zfc+9eRLneNCuZN8wL/E0jWKjCIBPP
	K3TNP6xaG7qb7i7uf5WjmnQA3CiDHSsjuFncReRAvMi8WFgeOS1zGVr2f7ICukHYXifzETW3B612A
	a0EmE+gFPdkFDS5G/a9bIGWO2wRw8n7GCqfhQ1m2+1ZKeOhYoijGpETdYUsi/Fm57RKTG//GK41xl
	xfOyRvOp1d1q+2ydlmJyI0tW9mBdLj7rijmfghhzGFE519YX4hU6rwXP6fikWaN6Y0PzIqe35Pm2r
	BWp3X1qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPHJG-0000000BxeP-1QFM;
	Fri, 06 Nov 2026 10:36:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPHJD-0000000BxcE-1MZU
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 10:36:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0A22068BFE; Fri,  6 Nov 2026 11:36:32 +0100 (CET)
Date: Fri, 6 Nov 2026 11:36:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 3/9] nvme-auth: remove dead entry field in
 nvme_dhchap_queue_context
Message-ID: <20261106103631.GG5453@lst.de>
References: <20261106022736.3582824-1-kanie@linux.alibaba.com> <20261106022736.3582824-4-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106022736.3582824-4-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_023635_509717_6322EC98 
X-CRM114-Status: GOOD (  12.00  )
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

On Fri, Nov 06, 2026 at 10:27:30AM +0800, Guixin Liu wrote:
> The entry list_head of struct nvme_dhchap_queue_context has never been
> used since it was introduced in commit f50fff73d620c ("nvme: implement
> In-Band authentication"). Drop it.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

