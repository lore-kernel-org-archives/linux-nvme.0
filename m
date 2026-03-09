Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3FDF417F6
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Mar 2026 15:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ryBNeoN1hUCDbbkd3VctR6dmn5e0FjNSRuqGqSc1GsY=; b=REOn3oSyCmxQU3thLHmPL/8Tri
	ekGrJnamH2l3+T6Lw64zNQqIW2x2JOFG1rQuXDbWTBksCZ2uAF40bgR5SwQnLLbSB9TjPUgMcGg+2
	kh0WUN8G6mgi3D4hpgU1mDLtpecxuDd13dqoZk3U+KQngU8YFAdJKVGxSwt2l/EOXb6zZ/dA3kp3r
	G7PIv+pvEBvQ+Xxbr/pO7I0VdiWNE1RqXPWXuWLwmMf/VhByZvdd+2d76eqQh+hqGf0KKS4mxB3jy
	mJXdl2qLxY+c9uKwcVWXCHmNyq9BS33j7XmWIS5cmjK1zQsUzcRe2sXUO4tywX3zphxJJ56pfd0oz
	DwLnujIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzc7X-00000007Y1T-0YZi;
	Mon, 09 Mar 2026 15:02:11 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzc7W-00000007Y1H-04Xz
	for linux-nvme@lists.infradead.org;
	Mon, 09 Mar 2026 15:02:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 09D53600AE;
	Mon,  9 Mar 2026 15:01:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77CEC2BC86;
	Mon,  9 Mar 2026 15:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773068492;
	bh=t4S+tTuMuRCDJ6WlQ+SAQoEeWLR4+1z2yf1E+YGFdd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oKELC1qyrDmi29hJ+XsbOKmcSRfD4ON6wU+4Hs2wjgg2+0YXdeWAk4CoynXt1PM5u
	 G7Lh8rXF4Y8j2t7ChXpQsIsyphzTk0XveY6GsK5D2+gKv7SesF9+n0I/dJD5FUePEl
	 s945hEHPmpv3mtSxrOclWoJXhWaMy5OxshtlkgZjKRzi4bQi5es+S8qGm+QJDlYnvu
	 Py2PpD5KFfzFHjaX6GllUXRzyeNYLh/7quFvXJtI+6MNTQjVH4yoJuvQdRB2yxhCCq
	 2N4HAQGkJXSfd2kbAFvdE1Yi7J1snecKOsaEPIY7xsxM62JqD7wNMgZFqyHHlj2cpG
	 uwk+yFnxb+raA==
Date: Mon, 9 Mar 2026 09:01:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: alistair23@gmail.com
Cc: hare@suse.de, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>,
	Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
Subject: Re: [PATCH v2] nvme-auth: Don't propose NVME_AUTH_DHGROUP_NULL with
 SC_C
Message-ID: <aa7gyZ6arZq8Ud72@kbusch-mbp>
References: <20260309042733.1137108-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309042733.1137108-1-alistair.francis@wdc.com>
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

On Mon, Mar 09, 2026 at 02:27:33PM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Section 8.3.4.5.2 of the NVMe 2.1 base spec states that
> 
> """
> The 00h identifier shall not be proposed in an AUTH_Negotiate message
> that requests secure channel concatenation (i.e., with the SC_C field
> set to a non-zero value).
> """
> 
> We need to ensure that we don't set the NVME_AUTH_DHGROUP_NULL idlist if
> SC_C is set.

Thanks, applied.

