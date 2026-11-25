Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAC4606A31E
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 05:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Zx6omu9s
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=jR76uMKfrswWIyroPa1Qo9yd4PvYEyj59LKtfnS4WWw=; b=Zx6omu9s7ZI3vPB/zYE/SXGMNk
	wxUjBjs3GhircHWtJUOGIz9AOjaz8MDKMgVYDwqQTObsFdCEvNHqjbtIS7imZCaWHlnAY3Vgs5lLT
	I/Gl6pzKw3T/rhl3dcdKoUeOVHBirvRfvk3LKEVoXQ11ZKNUze2TI/qm3804UOItEFE8uVp19M4IY
	iDOmtRjIJc43FEulm+UQ4ohXCnU6XfY2NKoNTzSZ7HTqKicSS0pd2HRTDuR2MeihNJDhOjSA+a8ij
	9jfQZLTM3HZvb7l3m7w14eWICqCfGyrkYuL0w6PFsGpZqj1/WI5fkLs0GOatKGBPKVEhb68FBWkW0
	MvGDr3Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW5Mf-00000008Ra9-1y7W;
	Wed, 25 Nov 2026 05:16:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW5Mb-00000008RZi-3zL1
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 05:16:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A43F368AFE; Wed, 25 Nov 2026 06:16:08 +0100 (CET)
Date: Wed, 25 Nov 2026 06:16:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	kamaljit.singh@opensource.wdc.com
Subject: Re: [PATCH] nvme: reject an administrative controller type on
 reinitialization
Message-ID: <20261125051608.GA20096@lst.de>
References: <20261124133122.4167640-1-yhlee@isslab.korea.ac.kr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124133122.4167640-1-yhlee@isslab.korea.ac.kr>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_211614_823836_027B1E22 
X-CRM114-Status: GOOD (  15.20  )
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

On Tue, Nov 24, 2026 at 10:31:22PM +0900, Yehyeong Lee wrote:
> nvme_init_ctrl_finish() takes the controller type from the Identify
> Controller data, and for an administrative controller it overrides
> ctrl->queue_count to 1 so that only an admin queue is created.  The
> Identify data is read again on every reconnect, so a controller that
> reported itself as an I/O controller on the first connect, and whose
> namespaces are in use, can report itself as an administrative controller
> on a reconnect.

Well, we'll have more issues if a reconnect changes the controller
type.  So please check for that just after issuing the identify
controller and reject such a shape changing controller.

And please cut the commit message down to the basics.


