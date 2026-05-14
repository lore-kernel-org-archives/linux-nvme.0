Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807FBCD4F39
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2026 13:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/IhLUaaSABnUks9j7jWCyyt6qVD0w61uLPIrEXIi/Ng=; b=eEUnGMSvCZE8LjrLhpIL/RiaJT
	aem/lXtd4cPTD5R1+H3Y3+PLodEOpmWkNelJQ0ZyQgEu/P01HmvmM1iVJIuj5zw2V/kHNoLfM7dUg
	gor8rfuJ3nk4XMder2F5RH+G/bovZkSKuHgh2hrSutyqaJGnLelglf4sN+9Syx398HwYj+5u7riPW
	6r+pj7TuvV9pFqkS8zsypFc02vvAnjJJDNgCy+0YdrFO4id2wCsj259RwaXv4K/bOQC0wuatXSJK7
	nmNczmAPrdn7P+wqbpU0Ket8Wovw8vqE2FzlRL0rVY3cQjuxeBE4kP2/fhMKYZQjDwbyQXkipgJRW
	ocyU+vQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNVzX-00000005aQP-0Gaf;
	Thu, 14 May 2026 13:20:43 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNVzR-00000005aO0-122L;
	Thu, 14 May 2026 13:20:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A213343A57;
	Thu, 14 May 2026 13:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86AAC4AF09;
	Thu, 14 May 2026 13:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778764836;
	bh=Ew8sNdAbDD8HHEiNp0fXLa+xg171HJQFiqRZFuz8RFU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=erX1Qk109xYnrUQD5Mk4e4ChE8Rq1Yv/VqiVCMa/5WNPWBEqbPWUh+JXeKzRKF+p6
	 ZbDYgVG9K/XBnqmST25y63M/R0AevoCy0CkXAV+05fTJptggAIi82SMu0cPcKj8XFX
	 9jRj99BAHCUADFyibthoOQW+qv+q2cA13ObhU0O72TAbTalC8Pjjp5+5YAdsrcvyrL
	 b1yHZvyOY/33xhsJOKe0vKHwi7G92t9eh5lMr4K+EjJo6Ym8jv96eihN03yZNdwNW5
	 MdfB5GsWkR2efsD758PSPpqQ+gE93ysJggEtoNPXgB576AyPWzcWLKcqLqqc72PZTL
	 wVspT8u7MFK8g==
Message-ID: <8e29246e-cb29-4eb2-86ca-8e0b8e3f601c@kernel.org>
Date: Thu, 14 May 2026 15:20:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-apple: Reset q->sq_tail during queue init
To: Nick Chan <towinchenmi@gmail.com>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Yuriy Havrylyuk <yhavry@gmail.com>
References: <20260514-nvme-apple-sq-reset-v2-1-84cbb5c70bf5@gmail.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20260514-nvme-apple-sq-reset-v2-1-84cbb5c70bf5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_062037_308009_53D99005 
X-CRM114-Status: UNSURE (   7.69  )
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

On 14.05.26 15:16, Nick Chan wrote:
> Fixes a "duplicate tag error for tag 0" firmware crash during controller
> reset while setting up the admin queue on Apple A11 / T8015.

... caused by stale entries in the submission queue due to an invalid 
sq_tail offset after reset.

And I guess this also happens on the i/o queue and is fixed by this as 
well, isn't it?


> 
> Fixes: 04d8ecf37b5e ("nvme: apple: Add Apple A11 support")
> Cc: stable@vger.kernel.org
> Suggested-by: Yuriy Havrylyuk <yhavry@gmail.com>
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---


Reviewed-by: Sven Peter <sven@kernel.org>



Best,


Sven



