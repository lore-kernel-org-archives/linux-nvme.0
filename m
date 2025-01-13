Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0AAFC02180
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jan 2025 17:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yb9zoOpkwsRTxkQIog/O/ZohTmJ+V60Au8zyWz3nCgk=; b=nQnUSRSFKA8OieXwcWQfw6Zeuk
	IWEoe2FFb+50zJsTBqBXw9Kmn/E+5akKwfIGlYGstK8mVz9nPoPMcYTDAp3ulKEVv2UO/mzIQkI4M
	LK13eHPYFhuoKRP46GRdyi81T/61Gk1gRi7Fm8tYBjffGRKS+xAHeTS/UyVEB4mWJ43CeCD7xDb+R
	JJN7p5nMlyYTpr72omfdHuwn4SiHswIXJRP6tvjJt8W8ksC4sm1wOdob8/dz1SkvB/pPpPDmnGEAo
	aKpKyEZ31FkUOdfS36lEGKLZe6PIz7kdx6P0OdInW/2D/1Mk4DMC9yvHLE2CgP9wqinA/0A1k/myc
	6TWvp8Sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXOQU-000000064tP-26DT;
	Mon, 13 Jan 2025 17:40:34 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXOPK-000000064Mq-3SZV
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jan 2025 17:39:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id D5D3DA41207;
	Mon, 13 Jan 2025 17:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72778C4CED6;
	Mon, 13 Jan 2025 17:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736789961;
	bh=81+zHx/SUcIlQAPhoA5KC89gWKZQRH8WRCSTjYam8k4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iymlr0fHMAKsElX/+YWDdLWIxmKL6O9plSCBo1I5ePpmlP4NkmiTTJcmuaRnfF0OI
	 bpDiN9bpjXno30owaTF6QKbPIiQtMI7N2HWBs+8OQzdBiTPJU0Ao2956Ii7Ow7gRdB
	 YMOyZ1tGG9jvYHUWQQd5m8kjlJCCKGVwIGmtw+qlUR0TRYTfZEtLJTFME9yos+G259
	 +LHj1SYFuVj3r+n4A/ZdOHPwc0faY12/1twSt89V5DuhatvsnYIxGd774zuz/3z5UD
	 uuF3fqq1ry0Kixnfe7KwZKM5JBJ9nCGBbi1l/GHPOa8ChsFuA/NC2JAD01FcV6nTJE
	 TTq9A+MWOlT1A==
Date: Mon, 13 Jan 2025 10:39:19 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	keisuke.nishimura@inria.fr
Subject: Re: [PATCH] nvme: fix bogus kzalloc() return check in
 nvme_init_effects_log()
Message-ID: <Z4VPxy8G--jyYFm4@kbusch-mbp>
References: <9516d209-712a-4a48-9dda-b270e80e3abb@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9516d209-712a-4a48-9dda-b270e80e3abb@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250113_093922_929167_A90DB6C5 
X-CRM114-Status: GOOD (  12.99  )
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

On Mon, Jan 13, 2025 at 10:30:06AM -0700, Jens Axboe wrote:
> nvme_init_effects_log() returns failure when kzalloc() is successful,
> which is obviously wrong and causes failures to boot. Correct the
> check.
> 
> Fixes: d4a95adeabc6 ("nvme: Add error path for xa_store in nvme_init_effects")
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Oops. Thanks for the fix

Reviewed-by: Keith Busch <kbusch@kernel.org>

Also applied to nvme-6.14, but feel free to take it directly to
block/for-6.14.

> Caused a boot failure on the first test system I tried. Not sure how
> this got this far without being seen...

I think we've a gap in our blktests for checking driver backward
compatibility. The devices we test against support the Effects log, so
we didn't see this fallback path for older spec revision devices tested
out.

