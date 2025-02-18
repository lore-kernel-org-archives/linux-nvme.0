Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086F9C02198
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2025 15:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ewocKPO37RqMwgbMtoLLZssYCPD6HkSnoLTNXJtKmRk=; b=0AlFpC0RL40/Uem/xUAI+6PONd
	AiwanHkJf7J9GlWJxILqoA3rvLxV8RGnn1p8pC84J2wyonCk+slqL835fSCSvChhtAhjn63lYeajX
	JPSSB+Gn5PG9PzCjQjoCqIPZCT1K39VmwL3Mfhf7WPXMD8npyR3oPaYCZpXWj6CrNYNGN+Qxu4P8B
	XgWY/4IVfnL9EI4nPlaUdJ5KOBxzm9jqXiml3aOf+KDOIMnrFA+2bFSUsAS23jP66pdOBqvnADErD
	0j9zAOMM5plfB6gPXLSBKfLfutAC9RMLa2tkQoEh/SycbRfMIh1gd6Tsx8/mJnko2BH3CZBsShQqj
	JAPkCgdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkPn6-00000008oeh-1y00;
	Tue, 18 Feb 2025 15:45:44 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkPn2-00000008oc7-3tTn
	for linux-nvme@lists.infradead.org;
	Tue, 18 Feb 2025 15:45:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2F6015C5FA5;
	Tue, 18 Feb 2025 15:45:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBFBC4CEE2;
	Tue, 18 Feb 2025 15:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739893540;
	bh=T7hySr5ecqC3x+q85ihTMQrkoCJj4NZdyMJ78ShIj+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zoh1xK9Fat+HL/1UOMTHYWdt3x+dfkDWbK1m7iXtlUeo6CaY/qncJLmN6Yw+MRLyJ
	 n+qQNHlqaHBe8+KbEHgZVQ4DMz79KBxRR0x0Xd+iOZY1vhTb/1h4ayJGLEOrajcJnL
	 y4teGLxkBqF8hJEfILbcwBuc9TEJrxJgFOJMGp8DzvHtClqicSqtUPWb1s4OALhB3Y
	 Yn1HFIc+FmjvHFZVQctqmIejJuc60PXS53jG7RqzDPpO26G33oEUnzuBhnZ3Ibz/qI
	 s+5MWpLfkdXCaKatHNrCrPOvjm+X3jcypDE4YCxc9IZh0B4dBeLY5Hp/WX2qDAKZBu
	 zpAOuZdzUm/0g==
Date: Tue, 18 Feb 2025 08:45:37 -0700
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Maurizio Lombardi <mlombard@redhat.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] nvme-tcp: fix connect failure on receiving partial
 ICResp PDU
Message-ID: <Z7SrIT9m51w8A4DC@kbusch-mbp>
References: <20250124184311.1642797-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124184311.1642797-1-csander@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_074541_024600_21B409C0 
X-CRM114-Status: GOOD (  10.81  )
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

On Fri, Jan 24, 2025 at 11:43:10AM -0700, Caleb Sander Mateos wrote:
> nvme_tcp_init_connection() attempts to receive an ICResp PDU but only
> checks that the return value from recvmsg() is non-negative. If the
> sender closes the TCP connection or sends fewer than 128 bytes, this
> check will pass even though the full PDU wasn't received.
> 
> Ensure the full ICResp PDU is received by checking that recvmsg()
> returns the expected 128 bytes.

Thanks, applied to nvme-6.14.

