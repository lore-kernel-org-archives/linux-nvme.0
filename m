Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC7E606A32A
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0Y+18LYY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Hhcs2ZeCBVVfVPQzsmMMikOl5vsDJy1YIgOoQmiUvyw=; b=0Y+18LYYfvYET+bfzkB+R+DqKr
	eUpslzvYvCcZI337PKCdS07/2gzdPmwRo6HxETgwzjw4jwfxEwZ0Rz5S2u1BvAh0PsB0GW+pd9Lmb
	vSMDpcNX8o42yfRzw31rVDZvMmiDWNqEobHyr9SJ6OuMtJf5uvJC0EaDuWUXvhyhWdWAzdkyiLaBJ
	35ghInuAdrcMxZA2eVRzEw5mpnqlga4GY5wbD8cgcOWSdHzPhSjQMRDGHsxxAn62n/EhRs9Tp5KGI
	kXQAc0jPGgRin4PtRMA/7lP/no9V5rEMR4YXk+/DHB42eV1hUVorhmg+gMsJEPfiDAS7K9SnoGjfF
	2cwMMIBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSmT-0000000Fn2g-1ZDL;
	Fri, 20 Nov 2026 17:52:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSmQ-0000000Fn14-2Nrm
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 17:52:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 32CDB6732A; Fri, 20 Nov 2026 18:52:07 +0100 (CET)
Date: Fri, 20 Nov 2026 18:52:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/5] nvme: decode the FDP Get Features result as a dword
Message-ID: <20261120175207.GD1484@lst.de>
References: <202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn> <202611150127572887TC7vHzVUFLZ6nyW1NuhU@zte.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202611150127572887TC7vHzVUFLZ6nyW1NuhU@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_095210_753580_5BD0557D 
X-CRM114-Status: UNSURE (   9.21  )
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

With this struct nvme_fdp_config becomes unused, so we might as well
drop it.

Also can you look into the Sashiko found existing issue and fix it in
a separate patch while you're at it?


