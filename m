Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A843F606A326
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 09:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uVU5S2lH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=uVU5S2lH47Sb5nkzbq/Y+bMQ+t
	v+eREORk9BLM0f4hdIotglDgNutIx7xd01emGjxshKph6Jr0CR0/WkYyNJk8uhX4RF1FmBZAAgTjx
	/6XHhBbYmp5agJxs6WWL23BUlj1sYWi/wvM/2CEjz+2o9gY+B+9hhXr7/sgS2wybdHbgJlC2/CoR0
	fQzoIbNTcATqY7qv0ClkwZviulUBoRy+z/vrlInbb4YxHWfCaI5vHMQKADkwgEzV/kfe8V9kWrIWD
	ZsmROcSPrb5Ki2DCCdoRyJAu4iEF7b9xKBx84Hfe+OSPKLqnqMkbUTerFdOgKN0QeeUqyzRzRtisV
	T5/N9P0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWVXh-0000000CVOR-3ohp;
	Thu, 26 Nov 2026 09:13:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWVXf-0000000CVNg-2BqA
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 09:13:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 25EDB68B05; Thu, 26 Nov 2026 10:13:19 +0100 (CET)
Date: Thu, 26 Nov 2026 10:13:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Seiji Nishikawa <snishika@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	Chris Leech <cleech@redhat.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: fix use of a released socket in
 nvme_tcp_poll()
Message-ID: <20261126091318.GA8380@lst.de>
References: <20261126085653.3339227-1-snishika@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126085653.3339227-1-snishika@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261126_011323_703136_A4650D0F 
X-CRM114-Status: GOOD (  10.12  )
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

