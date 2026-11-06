Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD544606A32D
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=z2cOgrS/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5vpnBLuOZjS78HnWofolOcgvPkKmQfgic/XSefos49k=; b=z2cOgrS/R0mZN/UPTVMXrH9tHo
	Erhi3Eeg+fnQoVAQUWY41nbCIX65M9+1eRdP+nthz4Ihg4zZ7Nt2K4nHQqqrJza6fQJ9KA/HkdQ8D
	tnlTgULzMIrBkpwn99VKeu7fxPN5yuWtOL9UrLD+UHX3R72A9x2Urv50j6dVT/UfKAPNG6Ph8krb6
	6DC9SMI3bX6K2nsaZlDO8yO50DWUimAC/9AS2lIdQ+9tdzPI4a0JKKEGS7Vdz0b1OpRdSYIbP24XA
	EkyRQlrGCr+WrF9eNeInS0vY9SH7N2b4TdU49SkDwcWSS7hU9xv3wQZrh2onN/0ld+lU5V1W4C3yq
	rseksdDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPHMo-0000000Byeb-3pRn;
	Fri, 06 Nov 2026 10:40:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPHMm-0000000Byd2-19MR
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 10:40:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C4E8868BEB; Fri,  6 Nov 2026 11:40:12 +0100 (CET)
Date: Fri, 6 Nov 2026 11:40:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] nvmet: zns: return the namespace lookup error for
 Identify
Message-ID: <20261106104012.GB5633@lst.de>
References: <20261105215753914RuQA4AVkFtXzpBkieEscY@zte.com.cn> <20261105215800734URR7v0vyg8xZ8t5d0qzIb@zte.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105215800734URR7v0vyg8xZ8t5d0qzIb@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_024016_720958_483FB88C 
X-CRM114-Status: UNSURE (   9.05  )
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
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The fix looks good, but please write to the point commit logs instead
of detective novels.

