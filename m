Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC4AF588F2
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Apr 2026 16:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HyWKym+NRL8GUhw3HVxEn8s+niUs5YsYkwxj8NqUl9A=; b=dazHgKjfhyxnxYoi7+YI+2+2sF
	pi2eDxxCTJxFM1WU0tK04L4LjmzdYuNxVgfzSQtwX0rRpKn4XCpraQDGwatHirJlu9ihhfaQwBrjd
	6R2EtLwpLfohaATjivw3y8fM3rCbGF2U9dVcVvlUeoJLxAvWuaqvNZPI5ZifJiR0u2m4Z8NJVtIUa
	QKt+HoAl+rYbZVFtWQ2stFKX2CwioEUjILUuDfgvF8AHvdY+sQU3XTXbmVj9mTuos8gmYySG17mEV
	hq0U9EPpoAG82ipdTVYgKEnc3DBfqJRmLuntbsvSnsuBlWnHSHVQbrV6yvWL+Y+m+/TjFzd4ryxnn
	uhdB9y6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wErPe-00000007QAu-09cM;
	Mon, 20 Apr 2026 16:23:54 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wErPX-00000007QAB-0MkL
	for linux-nvme@lists.infradead.org;
	Mon, 20 Apr 2026 16:23:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BC09C409DA;
	Mon, 20 Apr 2026 16:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DB4C19425;
	Mon, 20 Apr 2026 16:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776702226;
	bh=NYpK3CouJHTPSPnW9Gh1DVfkxNtG87b+vm5qv2RXJDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bSC//jY7mGMBjwY7optqRVj88BXjb7Jh2Jll/0zFdpjftbBmgP22DdXUp6lFMPS1L
	 s17hiWgLHrsoHjy64bNu3Sa8Qvs6oLzEExK92AIs47goMR+GxS2281H7MhIGLt5yZZ
	 Z4YljSeMwLe/TUwwKc1G0xhLG7ImQlJ1q/vy8QPx66I2nm+CLQeZ8+3lSga68vbVTD
	 tLUNnyk/rNeak7LtCnMI/B3hSR8UfZuv/TSfgKZV1JOphVoy6tNTccaPy9A8boZQdU
	 jfR8Y+djgDA5MwFJOiwAsuA7w2mCFrRrlPUFebhip/ZKpAY7E+K3K5vBbzKGYPw/Sa
	 Upyn9BMg5E+zQ==
Date: Mon, 20 Apr 2026 10:23:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: alistair23@gmail.com
Cc: hare@suse.de, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	yi.zhang@redhat.com, mlombard@arkamax.eu,
	linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 1/2] Revert "nvmet-tcp: Don't free SQ on authentication
 success"
Message-ID: <aeZTEAYE6uryLbuf@kbusch-mbp>
References: <20260417004809.2894745-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417004809.2894745-1-alistair.francis@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_092347_151675_D539983C 
X-CRM114-Status: UNSURE (   8.73  )
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

On Fri, Apr 17, 2026 at 10:48:08AM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> In an attempt to fix REPLACETLSPSK we stopped freeing the secrets on
> successful connections. This resulted in memory leaks in the kernel, so
> let's revert the commit. A improved fix is being developed to just avoid
> clearing the tls_key variable.
> 
> This reverts commit 2e6eb6b277f593b98f151ea8eff1beb558bbea3b.

Thanks, patches 1 and 2 applied to nvme-7.1.

