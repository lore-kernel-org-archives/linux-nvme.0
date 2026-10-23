Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2137606A31B
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yQjZFYsF;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=FLpJVBJ6;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jWMRxV2n
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=kkvar2o+3Ha6mOonX176i6kW5zfw4JypQo5ROcscIGA=; b=yQjZFYsFIiM0eP
	GQ6GxHHqKELMdhEbtiFVqryhrgIOXjjGRsHP8IhCDZq5ku8FVcmVWVKCk6TrbnJsTKpAnwIdCMxK9
	2azTnG69yFWYISYIWf+NSUPRai9U5WdwH12fHtf/mHC23o86TzXDw7tjHOEDP0kkDmv55AzxFXYxT
	OvmtZAH/OzSvrxK89lvJaTPbMGPtoeDEUD2JHN6PvYnRQ5q+JYYg5tn3Yr7gxHGZoAnUf2vqk5H6u
	/bHPrQUmcn+FBPFEtMZz9UZdMLILzmBfrWaVNuCE6vpveXBxhGneYP6cfO45NhSFvc09RFiRJTdhJ
	NBWsdhILatqhUutFulpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKJRF-0000000Gkog-3qIE;
	Fri, 23 Oct 2026 17:52:21 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKJRE-0000000GkoX-2hv8
	for linux-nvme@bombadil.infradead.org;
	Fri, 23 Oct 2026 17:52:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=kkvar2o+3Ha6mOonX176i6kW5zfw4JypQo5ROcscIGA=; b=FLpJVBJ6YjwCZoYk6Y9R5AK6qI
	vO5S/DBx93arocp1kI0XLFlqjgduPL8uXAjiIsftHHelyhBJiCrVbrHLQ4MBisV7j8kkRNmC54UlP
	sprhscIsNzpImvDZllHSfvfcKpN6ZtlGS+ojHs63tiRWkPOC5Em5Wd+gKEpfOv39YgvEWgQP9HIhL
	qsm10ojNEp0ClSXBZHPrPNEdGyqlDk1KCpl196Wo+tJIIgOo3ucZNvhxiO2J3rnsbXANW/MNFF4+U
	jwVsQB40j4BW2ZA1pHalCC+rCo+qA3PtZ2vtUSsm5RUUIPi79YtvOb/0asjCkWXD8kcz/WOWmfpl3
	p3J3gSFA==;
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKJRB-0000000ADyL-46oS
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 17:52:19 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4a214af2076so6834555e9.0
        for <linux-nvme@lists.infradead.org>; Fri, 23 Oct 2026 10:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792777935; x=1793382735; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kkvar2o+3Ha6mOonX176i6kW5zfw4JypQo5ROcscIGA=;
        b=jWMRxV2nHl+KVKYkUi7Sa21VGNAht69Ivjg6GRYhYj3c2zBtTf9Z95INXT/5w1Sn3D
         O/tN1nDbiTHRDaPURb6lA5xunXR2upS+Iv5f3RBpulgPwxReNQKvQ8k1rFI160Q8I0Z0
         Vo6cPl+wlQbCaeY1OiC8Wy2H5tUIv3s7KtbZBzsiYxMP7G9sqyku4n4ZlTnwwp44ZpQs
         WS0iSIxj3BK8V7uadIjQrzxER88mqG3fICqO4MvdsFfws1PYLBjmmOzXDPmhZBLoMOHK
         KTcLn0TFxm4TJHz1x484NCEv8K1FyWWJFVycAug4J9FCKeli5+ozpoZNbfg+TjV19ZO6
         +e6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792777935; x=1793382735;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kkvar2o+3Ha6mOonX176i6kW5zfw4JypQo5ROcscIGA=;
        b=KFS3iWE+gmUSirmQLF32HPpgtQIFMj4H0vSnQN0FUsRfGh5VvTW6RRZ1HUle4IBjus
         BfzjhykR7m8+M6fhCpccEE8JMn0ZkYLgq4Iqw8ooLNGAoD7PVc4m/0+RKs1aGzOhdOQ2
         tufv6nbvPnsLkkSLvCezF8144cq5Y6rDwoLPVWl711pIXT+fE5PWOHk3SNYnGJpPB/s6
         E1mDIFG/gKJFEXqDQZGwEHgJjJ6RKXNLzoBP2mV3OW/rnuqzA8odDkMBJdNr9N8DTBKN
         j3x13rd+TsFWSjuqVluNO0+AuKmvfDY5XJnblZAkunnRCpjHWm6b/H6BbfOvlM0/fjfu
         nMrQ==
X-Forwarded-Encrypted: i=1; AKwUvBxbgUnleMOBDV8uXyCyRUrpJgtlLJOfpe5xTOy8CDDnZm97YwF+WcIROegsnusRFLsguqJO/vIQhPmb@lists.infradead.org
X-Gm-Message-State: AFq9FYKcD4Il3hbfKICSMFnBTJ03KRL71P0qxbbugY0yzt/zbbuwFdsW
	sFKIL6MAi9l5aL2d6kqPCiP6MDU94lSsoEcJyPFgpP3S6/0UzchpO9Qv
X-Gm-Gg: AYBFou3qG5rP7kVafLAQQ4+/aj+i1jHj6D00RxtxGyYH1jTplg2hiYFJ50BC3G9VhhL
	8IyuSNPAWXsSuFyvGdx5TS0CdpWhUyj1ZVGi8fSN0wct7DMfJ4hESviZGkYX3QAkbPGtQBajAms
	Sxl2QaksD/RPBtCmS7zffTrWKucag22aIJKJj+X8MHTVzrK8DuSsK8L5TQ8ORqMoW4MUsaNqL9+
	5TV/lTTShyfEcjbr1nglvf8anZLuCdBicJi47MCEDy5LF+koI7PciA0fFH8+8caEyUref3LLhML
	XWQq1HKX4C4683Tb4qBRM0bL0AYDOxn/K7Ex2YvxBq9gwffajrSUXVNBZVYm8Uf0gaZcJWbCf8w
	xVgrVGRTHSqOqzMaGZINqEgX+S2dlZGbqJv6UZAG3VSdHnEloXT9mT3xo+dmFj9v/aXVEvwseZL
	HQJcdQlo6Rr7qVA4j6N3CGec+td1G4atd8znxICO75RG0WFYPW+3PzVLPTKMn32tS1jVggfHNLn
	rejM5Iyqm6bxMsOelapZsXuZuR4WMkyYKbUwhsetGPSV1mnV40EQ7ihfRFqFdfBiyoDESG92MlH
	GBFNQuMXVahxBe7YXsLE+GDkTnwJ9oqqYnObivJvxsZJR0mt6TWX5dt7SeySiM2pcCkNKac2I4u
	vYDMU7LdvOdioJJFuZqHUt7UtveWdbg==
X-Received: by 2002:a05:600c:3e88:b0:4a1:dfaf:f465 with SMTP id 5b1f17b1804b1-4a211c72edcmr46211455e9.4.1792777935335;
        Fri, 23 Oct 2026 10:52:15 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d40459dsm1191081f8f.28.2026.10.23.10.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 10:52:14 -0700 (PDT)
Message-ID: <7c1599a8-31df-4797-a794-bf5ba3d75286@gmail.com>
Date: Fri, 23 Oct 2026 18:52:13 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: reject dma-bufs larger than 4GiB
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@kernel.dk
Cc: hch@lst.de, Keith Busch <kbusch@kernel.org>
References: <20261021184658.644645-1-kbusch@meta.com>
 <20261021184658.644645-2-kbusch@meta.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261021184658.644645-2-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_185218_093767_785288D5 
X-CRM114-Status: GOOD (  16.48  )
X-Spam-Score: -0.2 (/)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/26 19:46, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The dma-buf offset is set in the 32-bit bvec_iter bi_offset. Reject
> buffers that can carry an offset that would wrap.
> 
> Fixes: 839231d19393 ("block: add dma-buf support for raw bdev")
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   block/fops.c | 3 ++++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/block/fops.c b/block/fops.c
> index 46cb86dd36d23..a974b423869eb 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -19,6 +19,7 @@
>   #include <linux/iomap.h>
>   #include <linux/module.h>
>   #include <linux/io_uring/cmd.h>
> +#include <linux/dma-buf-io.h>
>   #include "blk.h"
>   
>   static inline struct inode *bdev_file_inode(struct file *file)
> @@ -1009,6 +1010,9 @@ static int blkdev_init_dma_buf_io_ctx(struct file *file,
>   
>   	if (!(file->f_flags & O_DIRECT))
>   		return -EINVAL;
> +	if (ctx->dmabuf->size > UINT_MAX)
> +		return -EINVAL;

Sounds good, should be reasonable for now. It'd also be good to
move it to dma-buf-io* as it's not a block problem.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>


>   	if (!disk->fops->init_dma_buf_io_ctx)
>   		return -EOPNOTSUPP;
>   	if (bdev_has_integrity_csum(bdev))

-- 
Pavel Begunkov


