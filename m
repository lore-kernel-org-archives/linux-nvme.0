Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD58CA0FED
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Sep 2025 17:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W+D//ZZHrqyKkHDFCTDC3SfAhKfb/zsx2JUxlw5ucLU=; b=fAuF3anDgg32dXTGHHQGWfF7uU
	vKNuR7MeQ5QZ+6fyT6xMk3Q5iVI4yiA4QMJ1koS6lpAfF3Sp4h0ntiWYa+y52vWXN0QcoM3kjV/Vd
	f7t/8FtFlihuK4cRnQqdkEfjopm9PtFyqSh7wEHmLkRVLrxBE1q/voE4G9lZrPjnVBiAzAojYA64h
	pM09AOKrd/m1Ggx8/2wjheo40VwtaKV3eWK0f8JXQBstZvB9Gq9p4mQL1SQAuzbfvVW5lantehv8N
	76i7aNmkuqJ/epKOsauyFA/0Yu++kIo1bCzMFfsnuTwuH4HxsfG7qjc/0NgBFb4u69K3D1Sn8Xz1a
	2pJ5dvhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uua8z-00000003RKr-0sFR;
	Fri, 05 Sep 2025 17:22:37 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuWRq-00000001xdo-05Wz
	for linux-nvme@lists.infradead.org;
	Fri, 05 Sep 2025 13:25:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 27B0241806;
	Fri,  5 Sep 2025 13:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05128C4CEF1;
	Fri,  5 Sep 2025 13:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757078749;
	bh=R1AXq4tboKPDj02j8ZcSeexsVBxOm5DIaVF9xRR7bfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E76NbuJNf2kf/BhoQi8TEL7Ic7QymW5CnnfRYMvFmXpr+XLkXtiGilA67T0x+s7sg
	 wtyEutZKLD8/Ic7i3+8R1apz+fRu7epFv5eJXPPhjkyaCi+/aUjYUAs/mosVetyXyc
	 RtO5uq37ljl0z60pPUcXStrqibWbqTJyjEovcGiBdRDawKVDz9lZVmx3Wi5tsW6DaP
	 M495girntXe/+L65UtPi+bCimkM0OFEGJvJHhELPfPtsgDX7ufkdswodcbZDtqzwav
	 1q5wEcTUKnXLVjzn007IM7GSw0dlMO+qKSucwLafbMUfHLqUFYPEYEXDJCZsdgptC5
	 FDbTmIE4R15fg==
Date: Fri, 5 Sep 2025 14:25:43 +0100
From: Simon Horman <horms@kernel.org>
To: alistair23@gmail.com
Cc: chuck.lever@oracle.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2 7/7] nvmet-tcp: Support KeyUpdate
Message-ID: <20250905132543.GG553991@horms.kernel.org>
References: <20250905024659.811386-1-alistair.francis@wdc.com>
 <20250905024659.811386-8-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905024659.811386-8-alistair.francis@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250905_062550_083916_6364731A 
X-CRM114-Status: UNSURE (   8.98  )
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

On Fri, Sep 05, 2025 at 12:46:59PM +1000, alistair23@gmail.com wrote:

...

> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c

...

>  static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
>  		struct msghdr *msg, char *cbuf)
>  {
>  	struct cmsghdr *cmsg = (struct cmsghdr *)cbuf;
> -	u8 ctype, level, description;
> +	u8 ctype, htype, level, description;

nit: htype is unused in this function

Flagged by W=1 builds.

>  	int ret = 0;
>  
>  	ctype = tls_get_record_type(queue->sock->sk, cmsg);

...

