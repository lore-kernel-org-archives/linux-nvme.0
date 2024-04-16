Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA45DC4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Apr 2024 16:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OA0RBpzXEB35RwvhyOsIJSTaLqxRG3DBAaWZpUfaX2g=; b=4fXkI+9JK5ZFBs1YuUgWTvlZSK
	BaZ5nrootH0MX6wVg54nl1x+xYC3ektuwRgb6j6KMrDMtFxiDgkEx8ma1vzjHSykrlG/VSKU/Sq9D
	deGfVWNBkCDBTDG6tGwCcaW0t86zZjp5DIGvyhsnR0s/7HkwbjHY2uCXAd38Y4tPk+EJlY4RTWPa9
	NRb0HfZlDAEYR2iY73lIiMU9h8jvCrAOJNXBJ1QqXF7eiprqK7gBtiTzMYyucMCkWcp9te47dOpwT
	NyjoBHgKx5R6kwTsxecUjZ984zwoZ+wTFQXmMiDnDyYZXixFsPTk1/vbPnJJrJi1IugPNTVWnJwaR
	/kX3jygA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwlv3-0000000D3qg-16ti;
	Tue, 16 Apr 2024 16:44:29 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwlv0-0000000D3qC-4AJ3
	for linux-nvme@lists.infradead.org;
	Tue, 16 Apr 2024 16:44:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 35FA4CE10D6;
	Tue, 16 Apr 2024 16:44:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A656C113CE;
	Tue, 16 Apr 2024 16:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713285857;
	bh=7Fdrif1Xq0UgYtYzVzncFEAHPCEQRtItlNUkcVcKdWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fu2YGEDq4560myPqSOWLVBtHGEpGKVLGLMqvTHRDLZ+kE1KRDgiu/zz9pHmz/BeD5
	 2c8Exedjo+YJGietWsY8URwP83y4SzedGQdJK/DlgspTaYKw2P4jfmpIVuJre/qW8i
	 BBEPLvWcfL+Wq1fg+nnkD6eQk2xJH6gT93ISoKGgrWXof7+1wuVra4GXTXCcw5Go+B
	 Bzt6JaF7iwdDPy3ecqvIS85RFCwiWkvb06OpfclvUA+8lXagU+GNsOugESgl3Dh9Ye
	 9qX72Yau+2d3LFMYeJjX9uNlukeV1d6IOCLkXE2Nwjl4rC8Vm6oPq/jf+KfP50NZbP
	 PzoJcqpHiIqVA==
Date: Tue, 16 Apr 2024 10:44:14 -0600
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: sagi@grimberg.me, hare@suse.de, dwagner@suse.de,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/2] nvmet-auth: fix some minor bugs
Message-ID: <Zh6q3mtbt4a7H4sW@kbusch-mbp>
References: <20240410094842.370170-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410094842.370170-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240416_094427_239966_41CD297D 
X-CRM114-Status: UNSURE (   8.48  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Apr 10, 2024 at 11:48:40AM +0200, Maurizio Lombardi wrote:
> First patch modifies nvmet_auth_host_hash() so it correctly returns
> the error code to its caller.
> 
> The second patch replaces a pr_debug() with pr_err().

Thanks, applied to nvme-6.9.

