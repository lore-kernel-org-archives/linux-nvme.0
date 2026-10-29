Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA00606A320
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 12:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3cBjnwTA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gErX+ksSNZ1+s/G/JwlYGhxpCWmDQr9fbJGY54B8va0=; b=3cBjnwTAiI4Gvd1lAIbY8X8TRK
	Uq7zZO/Tpfh1r5o75z+CrsDnrfaBs7H3tde6Zdo+KUbvO+V1uyYmK9fc8UXdoHpGtZj8yGutaOKgU
	BIzuOh9AQIIoQSiP4vFHy1dJIeraY5+2WeFtrWUOPSKhNnN+JrLkFyUipeFJwxyS7rIr/OfRlkN9l
	4tehKVNgYayviFIYoM4C6SUNvJe4iWMqJnLUioG6jP729Xz8N32QK8FXkDPyo0voGqi1oWsgaLk9o
	k/ZeU273eWVb+kOQv0kMAa/Qf+s5eSjferk5BvzPcghBfTAWh915snVM6OSrj+wofTntNqveuM39x
	4VuOj5Bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMP32-000000098CP-1Xhy;
	Thu, 29 Oct 2026 12:16:00 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMP2z-000000098C2-1jIr
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 12:15:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BA0E068D07; Thu, 29 Oct 2026 13:15:53 +0100 (CET)
Date: Thu, 29 Oct 2026 13:15:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvmet: Handle a NULL admin queue in
 nvmet_queue_tls_keyid()
Message-ID: <20261029121552.GC24375@lst.de>
References: <20261029034306.3626274-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029034306.3626274-1-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_051557_602113_D06BB678 
X-CRM114-Status: GOOD (  15.81  )
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
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 11:43:06AM +0800, Guixin Liu wrote:
> The admin queue is not necessarily installed when the tls_key debugfs
> entry is read: it may not have been created yet, or it may have been
> destroyed already.  nvmet_queue_tls_keyid() then dereferences a NULL
> sq.
> 
> Guard the helper and return 0 instead, which also covers the read
> racing with admin queue teardown.

The patch itself looks obviously fine, but do we have any synchronization
that ensure it does not go away while we're looking at the submission
queue?


