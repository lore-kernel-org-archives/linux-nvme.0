Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E80606A331
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=iZ+e8qKx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=iZ+e8qKxAYgRjedrLVO4zd2TLH
	c2IN222k9uLoiMxUJXM6QJFbj519egvzQIXrtGiJiLqo2nnbEzYdRgy+1cpCDz28LI6cUzW9UwQ/Z
	CrBnz9HSRkNUyOqnjiDoGoSfz6+ATJVm2xVgK5uL29WJkYEMBsZuYNPXrts6yT0MldcsDrsVAuU/5
	adAO/Ypr7RRpVf8QuKDMMk9oDsl/EJ2Buh/8BcDiFP+WZ+pYYxXZOdqKkB6rKgu7gToLlafE8MeTl
	LWgYlZeciu/jTCGUV86ai6wd0M7lZHWV+23VBLn8MgBDPSixhcI+NVlhKru/96W4HAqTr9hgqwaD6
	8Ru91FEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSv7-0000000FqX0-1U0m;
	Fri, 20 Nov 2026 18:01:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSv5-0000000FqWU-00RE
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 18:01:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7252B6732A; Fri, 20 Nov 2026 19:01:02 +0100 (CET)
Date: Fri, 20 Nov 2026 19:01:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yao Sang <sangyao@kylinos.cn>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvmet-auth: lock DH-HMAC-CHAP key clearing
Message-ID: <20261120180102.GB1726@lst.de>
References: <20261113094214.1918982-1-sangyao@kylinos.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113094214.1918982-1-sangyao@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_100107_367754_70BEB49E 
X-CRM114-Status: UNSURE (   8.88  )
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

