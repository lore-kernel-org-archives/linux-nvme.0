Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAEE606A31E
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 06:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=m2gjJX7n
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=m2gjJX7na2T0sSA/alByY6j2uq
	0lh5l0rh9ye/hYVU48KmqvviklNnVt8IwoyzV7PIFtyBkj7R1O7TqXeOz23MXCpbK4gJjIRjYe/+e
	wRai3ENZwIaHIYh9MxRLOyn/uuIsYjByY9XcqM5DcNoiS08WYOg2jYq6eEbN06hDS6+yRWtK0Cfg0
	JiMnHFNmCcqidifwzheQ4T4NqCPjOCIMon1+7pR2SuEhHUQO8UTx+zupETt9DG8k0jTyUZ5OPrQSm
	rkLDdVxYOPD+NdRt10kzBpo708LHwz3G6GSmly9AhCsK+FPXb6K+cX7Q0crnRfV52qlx2ykOfTNTQ
	s8G+epOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW6FH-00000008Wr9-0HZi;
	Wed, 25 Nov 2026 06:12:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW6FE-00000008Wql-2uSW
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 06:12:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1607B68AFE; Wed, 25 Nov 2026 07:12:37 +0100 (CET)
Date: Wed, 25 Nov 2026 07:12:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Stephane Thiell <sthiell@hudson-trading.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me, axboe@kernel.dk, sgogte@purestorage.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme-rdma: don't free I/O queues before cancelling
 requests
Message-ID: <20261125061236.GB20910@lst.de>
References: <20261120233508.379363-1-sthiell@hudson-trading.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120233508.379363-1-sthiell@hudson-trading.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_221240_903572_EEF20566 
X-CRM114-Status: UNSURE (   8.79  )
X-CRM114-Notice: Please train this message.
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


