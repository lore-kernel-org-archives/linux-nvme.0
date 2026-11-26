Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FDB606A333
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 08:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uj0CGuoX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=uj0CGuoXirRjzwAq2irQTR8oF9
	EFpL6cIJA10m3Xa0kj6llgCy8HXbkE8YPI+EDHTy5eeC//j/9/R1QWsj1Cx693frLrqpAEHp+9BzH
	C5eyUfZav21l3sHqGav4jw+Ue5ISaGgiWU+mIVGt+B1aWM9OIYk0lIhM3zO03mUwtL/+4YID6gHQk
	GqnJTJBtGPoMV84tCsvqXxyUCIrcNemtZCDaSKPbVW+CIdjOKcaE0luALCFbX92NpWT3GMIPFGLPU
	EVrEorYlKd7fPJAfwcjapYbF0DzkZW4uS3Hj6OWjrYYI6OPTvx+5IBTKHDmVdiGjiZRleAANne73d
	PBkAu6Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWVAn-0000000CR8z-2LOs;
	Thu, 26 Nov 2026 08:49:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWVAl-0000000CR7h-45su
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 08:49:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B6F8668B05; Thu, 26 Nov 2026 09:49:40 +0100 (CET)
Date: Thu, 26 Nov 2026 09:49:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>, co+018500376d4b835e@bugs.sh,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: reserve connect header digest and align PDUs
Message-ID: <20261126084940.GB7617@lst.de>
References: <20261125160418.1518007-3-bestswngs@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125160418.1518007-3-bestswngs@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261126_004944_160935_94FB9E24 
X-CRM114-Status: UNSURE (   8.91  )
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


