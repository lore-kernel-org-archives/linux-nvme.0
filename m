Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FD1C4332F
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Oct 2022 18:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vWgkp1Uhseyx7z8GnHpVT62F43ADCuiKPEXkLOgZNbI=; b=2cXjD78dmzOe9sKX1FEYZFhKvk
	v4Uegcc+MCGS61au+rmJ/glCuBxxe94L2ZwHHi0/ZDt7vLXu1Fg6sXGL5b11qnrwjL6zEz+moZ21E
	Jobhv67hV4LhW4rSJNpH0k6AIibzuvoKPYnnDScAQntoBSv0X+le4ihu5XxFBYDvYTDSB5bFYT3zM
	tQ11qxo2Abgn4CsS+BIarzx56j8SF16ztojfbcu39Wv1trvlEINLgTurvVgR/ZV9hoRZ/N+41aqrc
	Bz66WC70KUEmFeyYwd8dJin1cVlvrvy8BJ3eQNx/1cPB7ZiJCu6dZDMnWxcxO7feDLbuZMh8mDu/c
	IqBtYGhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofQ78-007Bws-UA; Mon, 03 Oct 2022 18:24:26 +0000
Received: from out2.migadu.com ([188.165.223.204])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofQ75-007Btp-HN
	for linux-nvme@lists.infradead.org; Mon, 03 Oct 2022 18:24:26 +0000
Message-ID: <cce74aec-61b1-d5eb-1b62-746e45ebfe69@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1664821453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vWgkp1Uhseyx7z8GnHpVT62F43ADCuiKPEXkLOgZNbI=;
	b=YRgrt7JRLHcpvwYwlIH4rVoSJiv1DhfNg2g89dUUxTKGbycBChtZGpUNjYqErnK8NfQNvR
	veoeXGNsCx0ez+BLZkSuaj2fSlxnriYeiuQL+mKbjg4FnI2/7tdvqWSUZR3N2hVhkJ+qhf
	cgnsekMDz2NBGYZ0DvH00GlzEtO9E8c=
Date: Mon, 3 Oct 2022 12:24:08 -0600
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/3] block: sed-opal: Cache-line-align the cmd/resp
 buffers
To: Serge Semin <Sergey.Semin@baikalelectronics.ru>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 Jonathan Derrick <jonathan.derrick@intel.com>,
 Revanth Rajashekar <revanth.rajashekar@intel.com>,
 Rafael Antognolli <Rafael.Antognolli@intel.com>,
 Scott Bauer <scott.bauer@intel.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
 Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
 Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20220929224648.8997-1-Sergey.Semin@baikalelectronics.ru>
 <20220929224648.8997-4-Sergey.Semin@baikalelectronics.ru>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <20220929224648.8997-4-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221003_112424_778345_4E065368 
X-CRM114-Status: GOOD (  18.92  )
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

Hi

On 9/29/2022 4:46 PM, Serge Semin wrote:
> In accordance with [1] the DMA-able memory buffers must be
> cacheline-aligned otherwise the cache writing-back and invalidation
> performed during the mapping may cause the adjacent data being lost. It's
> specifically required for the DMA-noncoherent platforms. Seeing the
> opal_dev.{cmd,resp} buffers are used for DMAs in the NVME and SCSI/SD
> drivers in framework of the nvme_sec_submit() and sd_sec_submit() methods
> respectively we must make sure the passed buffers are cacheline-aligned to
> prevent the denoted problem.
> 
> [1] Documentation/core-api/dma-api.rst
> 
> Fixes: 455a7b238cd6 ("block: Add Sed-opal library")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>   block/sed-opal.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index 9700197000f2..222acbd1f03a 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -73,6 +73,7 @@ struct parsed_resp {
>   	struct opal_resp_tok toks[MAX_TOKS];
>   };
>   
> +/* Presumably DMA-able buffers must be cache-aligned */
>   struct opal_dev {
>   	bool supported;
>   	bool mbr_enabled;
> @@ -88,8 +89,8 @@ struct opal_dev {
>   	u64 lowest_lba;
>   
>   	size_t pos;
> -	u8 cmd[IO_BUFFER_LENGTH];
> -	u8 resp[IO_BUFFER_LENGTH];
> +	u8 cmd[IO_BUFFER_LENGTH] ____cacheline_aligned;
> +	u8 resp[IO_BUFFER_LENGTH] ____cacheline_aligned;
I'm with Christoph on this one.
When I see ____cacheline_aligned, I assume its for performance reasons, 
not to work around a DMA limitation. Can we instead kmalloc (which 
provides alignment) these buffers to make it more clear? May want to add 
that same comment pointing out some architectures require these dma 
targets to be cache aligned.


>   
>   	struct parsed_resp parsed;
>   	size_t prev_d_len;

