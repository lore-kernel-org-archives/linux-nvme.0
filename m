Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A2CE77191
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Dec 2024 21:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J0Q06dfUQwuy3HRSJGDQWZN/R/8wuO+uS4gFZrG9xmo=; b=p7wTLkjKFLnGT3X5UtRvOKayVA
	VKbdeu6JLZ7ZFSxQqHpbYg6m5ojO+Zmf7voql4vFntyaU5ieYMVgQHtPwmTA+ckSiIkQ051Ra75qF
	fgoJg3DCad7nCNZvSd8WEbfCbhzOB9jMkW4zbXCHTIylE60u+q/x7W53id6WVFp8J61qwkywxGngg
	CqkE8oAUJY0yO3brMDDCQ3J7qXoSz32RGwZGZqMk9IjT6a1XEziiWg9jYCxs9GMQjgTapoUB4KBEY
	ibznjMlcgsgQxuj9GdSwx9ySXdR6gguSQBJd+C58aqkCdH/o+jxo+mDblL1j7BYilVuT9ne8EBQhx
	5SOcxZKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tRI0v-00000000zEn-48AP;
	Fri, 27 Dec 2024 21:36:57 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tRI0u-00000000zE1-04As
	for linux-nvme@lists.infradead.org;
	Fri, 27 Dec 2024 21:36:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 1A318A417C6;
	Fri, 27 Dec 2024 21:35:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07821C4CED0;
	Fri, 27 Dec 2024 21:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735335414;
	bh=Kle5ZH8p2WRwTwIbkgfeBnD8JHh114b3yt9Z06UAEvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sKSYyOUVdnjixegj0LnJjex0oYicXdAyTmg10NVa5cZ9DRn8I3d19WWuO+EhCbJgX
	 9CKkqADOGZytbpqfMSfX8B8NGvF9LM1nfzPh/KZynr4XtTkXH9WKhK1J49pZ1RW+Eu
	 c1W8e/RgJRkTVZw67TLtqqer83UvqnZx+4hyX5yjxkaqG5W4EwjEzlLXQvg4EfCIc3
	 GwbMtWbDwAxaRisODDbmYNTktuMVEGDqiP56rTkMqkOw/SZlOtNbTTCWyxklkjO8yL
	 BXCC2kA2sF/jgKJxhfugiasfsQIDeH1xOxD0lYQpeg20x0exRaU/+b5mHThseJV1iH
	 riV1TGW/q92xw==
Date: Fri, 27 Dec 2024 14:36:52 -0700
From: Keith Busch <kbusch@kernel.org>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	hare@suse.de
Subject: Re: [PATCH] nvme-tcp: remove nvme_tcp_destroy_io_queues()
Message-ID: <Z28d9GSF092kcAXr@kbusch-mbp.dhcp.thefacebook.com>
References: <20241203033955.394595-1-brookxu.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203033955.394595-1-brookxu.cn@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241227_133656_131128_330A5409 
X-CRM114-Status: UNSURE (   8.80  )
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

On Tue, Dec 03, 2024 at 11:39:55AM +0800, brookxu.cn wrote:
> From: "Chunguang.xu" <chunguang.xu@shopee.com>
> 
> Now when destroying the IO queue we call nvme_tcp_stop_io_queues()
> twice, nvme_tcp_destroy_io_queues() has an unnecessary call. Here we
> try to remove nvme_tcp_destroy_io_queues() and merge it into
> nvme_tcp_teardown_io_queues(), simplify the code and align with
> nvme-rdma, make it easy to maintaince.

Thanks, applied to nvme-6.13.

