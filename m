Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D35606A31B
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 07:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=G1YmIjEb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=bk3XFx2IS0BKNitNkjVAjvt/h7+W5thsM39xRsT1eEU=; b=G1YmIjEbDlec4arCe7pq3Ow51r
	vkVeqEe/RK0/jaiBbcqHWWuZ44CYwcJuZpnuqfO387Q0WeRmG43gSgwtu+P/mCSvq0vjympXKbDBm
	mJtkqxU33apY8jzK6BLvY0u9fqqO98a47k4hIbpaYWS7I7clCjRaTVSwUSt3iT76nVGjMvphk55b0
	w8ytmbKnPDrqDuKVCMpVIunXC+Lt/20A50qOsUAaN6AzxZE3kjQ9kqQal4Sd0r8fzaTp0nn+bh66F
	YBzhQmEIRLlvx5ZsFZZjqDfBRWK4ePUdR+CERG390aJS8FOml43kUMyiuMJEg2+oziLm6Dx+J8Q37
	GmCv2HpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOsJc-000000083lL-3zSq;
	Thu, 05 Nov 2026 07:55:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOsJa-000000083kg-42Cr
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 07:55:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 11D1868B05; Thu,  5 Nov 2026 08:55:14 +0100 (CET)
Date: Thu, 5 Nov 2026 08:55:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yaohan Li <shunsheng1218@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	jthumshirn@suse.de, mkp@kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: stop asynchronous event work before ANA teardown
Message-ID: <20261105075513.GA17979@lst.de>
References: <179378587000.73780.18152328009023418065@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179378587000.73780.18152328009023418065@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_235519_177625_F498FA10 
X-CRM114-Status: UNSURE (   9.54  )
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

The fix looks good, but it would be nice to get the Sashiko nit about the
comment fixed.


