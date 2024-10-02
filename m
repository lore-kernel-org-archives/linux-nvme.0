Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B12BCF6D36
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Oct 2024 15:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TtzQAJ0zq3Cdi+ZfM6hhXT8uC3ARxAEpM66h/JDHHAg=; b=gH53q81VCtjNRo4PwDcc/beelp
	1BSm+szRCpiRge9EeHLYJmX8Kss4qL+4WtZxvoeutPIafzsfuA6x/mM/J5zMeUqUzdHwAG+qXerAj
	551FjnrxZzMGcLK1+gH8RB4b+lIpDl7uUSMwIDxB9fwvMCVWPzbOGzWU/9mbneYw6OqPY9Jsgy+lt
	VWhHwNSqhV2wcQvDhDrBpqXmGcXS2OqyUoRtPYponqSRXpYmbCdLcyM9gsUU5jPcovLRPLfUEFUWc
	xc93gddKCeucY+Q0gAkEnZ1afxmbpgD1udGLz+2D5Y5/AdlbJ/Sra+bDnMtwkFyJWi+fKLbjKlfp/
	uIcLWhWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sw17t-00000006bH3-2Mdt;
	Wed, 02 Oct 2024 15:18:53 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sw16h-00000006b1r-1pST
	for linux-nvme@lists.infradead.org;
	Wed, 02 Oct 2024 15:18:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CA19E5C4C3B;
	Wed,  2 Oct 2024 15:17:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF02C4CECD;
	Wed,  2 Oct 2024 15:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727882258;
	bh=ncfHnDDIrlsZ5cv1DqDqNYuQtlTPW4NktXBA1Q3cPL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PiCvDTWXEQOSQi04Hf+D0gfF9g3t3uYK54HODlBfgBSmb4j6zCUNjfO6Xg7JbRQcN
	 ypabAKkcQw3ZmG0HNs5h4GZcKtSABifQex7u9gRsGMahmHmrw28U7VhdVUEdOWaM3k
	 jVcSRQEXgfLonFcqVMl/DyhNaDvvdzMQ7W0Dx00zOoS/9WWWZ4Otv9clvYduUO0Fq4
	 s4YdnwFod+8Xu7Hm17K4pAuOFvL+NaiAjlTNI/mnUJ52ttBxnb6doCAVKB/8QZvt2L
	 9BCOe8TT6yBck17+aqbKek/D/atOGlodaaroLEcgkKykJUyczO6oB5RC+QpTmCnMx1
	 wcCZw8qd93pxg==
Date: Wed, 2 Oct 2024 09:17:35 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>,
	hare@suse.de, sagi@grimberg.me, martin.petersen@oracle.com,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jaegeuk@kernel.org, bcrl@kvack.org, dhowells@redhat.com,
	bvanassche@acm.org, asml.silence@gmail.com,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	linux-aio@kvack.org, gost.dev@samsung.com, vishak.g@samsung.com,
	javier.gonz@samsung.com
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <Zv1kD8iLeu0xd7eP@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20240930182052epcas5p37edefa7556b87c3fbb543275756ac736@epcas5p3.samsung.com>
 <20240930181305.17286-1-joshi.k@samsung.com>
 <20241001092047.GA23730@lst.de>
 <99c95f26-d6fb-4354-822d-eac94fdba765@kernel.dk>
 <20241002075140.GB20819@lst.de>
 <f14a246b-10bf-40c1-bf8f-19101194a6dc@kernel.dk>
 <20241002151344.GA20364@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002151344.GA20364@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241002_081739_540982_EB03B6F9 
X-CRM114-Status: UNSURE (   9.76  )
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

On Wed, Oct 02, 2024 at 05:13:44PM +0200, Christoph Hellwig wrote:
> 
> Well, he finally started on the right approach and gave it up after the
> first round of feedback.  That's just a bit weird.

Nothing prevents future improvements in that direction. It just seems
out of scope for what Kanchan is trying to enable for his customer use
cases. This patch looks harmless.

