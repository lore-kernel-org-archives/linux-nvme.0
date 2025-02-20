Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2EEC021B2
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2025 23:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qVNfQPPtsbxtQv0jnue0m+Vcvynj5EqWpeRbBBd3lfc=; b=0+ifnATE7jt0EN4WzmQihH7tcs
	SX16M0+xhShr5nV6WsrpwQMzfaUW8ZHE0b4vXA+xKLhqD1+zEcIrJ/UGMbeI2vFr3WJK3mmrQEckq
	UZCGXjR5C4DRJdiKLkwCiYNCWWS0+518qBENXIK45D9Cnbup/+jVK/o1A00bUmkwCqRkee1FjIeOU
	LG4NEant11Eg6jgEbf/ElNn0TnWZHXKlxAyLlHEuEca98Meig1OwF5chkI3K/GGJmedSGz1kfh8QK
	0T40gWoYFIg2gqgKW9A+sOKD0SswraGDKajaRiCYAPf56Wg9qqrVb5cRwKFItmozDR3BDuM3twBvN
	HSWnta0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlGRA-00000003QRT-23Eo;
	Thu, 20 Feb 2025 23:58:36 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tlGR8-00000003QQl-0kz7
	for linux-nvme@lists.infradead.org;
	Thu, 20 Feb 2025 23:58:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4E2135C61E0;
	Thu, 20 Feb 2025 23:57:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F246C4CED1;
	Thu, 20 Feb 2025 23:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740095913;
	bh=qVNfQPPtsbxtQv0jnue0m+Vcvynj5EqWpeRbBBd3lfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P7Jx4e5KVcNnWKYXYhDurlDGx9QBvuQ9T2idAecJYi2HiJkG0ceAJPztlUl0iHqny
	 FyJaqVuXeRkEBTel4YvLEtGhqaDocJueCKh7wZSS2SMUy2AOtZaWesgI37Vx1SLUsg
	 sztlCHGxdzD/yIglbCIJXvtO6eQBpMKqKgMGMrRex6A1hYZFyU91oZO3he5us5Af66
	 PgPOrvdLiVb8eqYc20AdIqQHNOgGTPU3C9BlQnqvUeECLEU5QI0hNs3ZwTIyPSha/W
	 d70vLZ9pt26i00Zc1O670dGNMWJPN8nyUBe79p8oItTiVtfPMaXM+HRAdi9hSU3ZDy
	 /dME7KY1RiOwQ==
Date: Thu, 20 Feb 2025 16:58:30 -0700
From: Keith Busch <kbusch@kernel.org>
To: Xinyu Zhang <xizhang@purestorage.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH] nvme: map uring_cmd data even if address is 0
Message-ID: <Z7fBpnVEBhFPXUR7@kbusch-mbp>
References: <20250220235101.119852-1-xizhang@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220235101.119852-1-xizhang@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250220_155834_276894_C68CE409 
X-CRM114-Status: UNSURE (   9.13  )
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

On Thu, Feb 20, 2025 at 04:51:01PM -0700, Xinyu Zhang wrote:
> When using kernel registered bvec fixed buffers, the "address" is
> actually the offset into the bvec rather than userspace address.
> Therefore it can be 0.

Nice, thanks for catching this.

I'm prepping a new ublk-zc version based on previous feedback. I'll add
this into the series once its ready, and I'm hoping by tomorrow.

