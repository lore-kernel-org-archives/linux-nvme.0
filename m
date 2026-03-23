Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E47F483DE
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2026 17:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=alM9fCPgMmqIyhLMRV0kx45bQP20BzWtRXsBmtgT8dM=; b=WZ6uksGuu4g4oz47hMu4Sl8ZX9
	7w87LEJcchNvIPHh79Toxprv3VfxtD7X6XkjxPAfirdAdORAce8Knnl9MSGCM6LQUbph12qLBhhuU
	+zug7UjxxknLGZv2uc+FtKyUec2ThrlqWR7m3tm9n9wYdFvdI0DhOqHfxM4JU+AQZB5C6Jha+Ii9I
	yStVqXNUYmDHTuevV8rtJwSfPkvm6VrZRFPuUzwdRGVIIuWXJmr77rDEQMXdMzOlnz/kGhuUIB6P3
	UDvRbpINX6/sWwfMsIW6ToPd1ga+RB6nm+MdoJfG4MAmcTKvt7pDMHiawoB16EIAu3UnhH/FtDvnr
	2hTfEOLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4jSz-0000000HGw3-0rN6;
	Mon, 23 Mar 2026 17:53:29 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4jSx-0000000HGvZ-1agV
	for linux-nvme@lists.infradead.org;
	Mon, 23 Mar 2026 17:53:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2C8B744349;
	Mon, 23 Mar 2026 17:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0090C2BC9E;
	Mon, 23 Mar 2026 17:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774288406;
	bh=alM9fCPgMmqIyhLMRV0kx45bQP20BzWtRXsBmtgT8dM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mKhy1G81lHvy3rKGlLWKPOdutap8hJ6rXiMelt0zSB25quqjTIyFLrgpLeM4Unwbq
	 f4HRMh8nfp0DZFBJkhtvkonINGWRizgPy0MHDwpQSYMeA+ojL5KylSxtZWvMZo/ZdB
	 CNcKE/cwjXopc3jk0o+YOVrbVGfu6SiWuqVJftqyH43onGWc+q+Nv9eO0rgpZFqHN8
	 mslGDLolOdrYsv6joaFZJ69yF1E/MfCwWCfAf2i+Ry4xtm72DM4WRy3UgAQncsHyNF
	 Rs4iy/A6bALJ54yR9yz002QtTCQiL55L51yC+MnuLfBIPppridMQXhnWGMjBPfew2z
	 YV8TDZiI5lwGg==
Date: Mon, 23 Mar 2026 11:53:23 -0600
From: Keith Busch <kbusch@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Sungwoo Kim <iam@sung-woo.kim>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH] nvme: remove bogus check in nvme_pr_read_keys()
Message-ID: <acF-E8csusg-YbaO@kbusch-mbp>
References: <ab5yUf3BqtlN3K-P@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab5yUf3BqtlN3K-P@stanley.mountain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260323_105327_443075_2B3DC98E 
X-CRM114-Status: GOOD (  13.79  )
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

On Sat, Mar 21, 2026 at 01:26:25PM +0300, Dan Carpenter wrote:
> This check for if (rse_len > U32_MAX) is confusing because if
> rse_len is > INT_MAX, that will trigger a WARN() in kvzalloc().
> Fortunately, the caller blkdev_pr_read_keys(), puts a limit on num_keys.
> The number of keys can't be more than PR_KEYS_MAX (65536) and the
> condition is impossible.

There's actually two callers: blkdev_pr_read_keys() ensures the number of
keys is smaller than 65536 and iblock_pr_read_keys() is a fixed size at
16. But begs the question, what guarantee does nvme_pr_read_keys() have
that all the callers validated the number of keys such that it can
bravely skip checking it? I think nvme should validate that it's a
reasonable value before calling kvalloc so we return an apporpriate
EINVAL instead of ENOMEM. The existing UINT_MAX check is certainly far
too high, but I think something like a 4MB payload would be a totally
reasonable upper limit for nvme on this function.

