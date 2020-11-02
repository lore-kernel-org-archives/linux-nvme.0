Return-Path: <SRS0=Iz8v=EI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB3BC00A89
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2020 11:44:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C305222B9
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2020 11:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NG/t/zsz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C305222B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9aDBhqZSfktHZXMhOPQ+F+Y2TjqNx+IivjHpI2MG2Ec=; b=NG/t/zszejuXXEuJAqrowEh9U
	7p7StMM8+NFa0Eq7EKYLIgAQ/VPFujAI7J7OqXQmsHCSxmct4UwIsGK/FL4IlAq/0hSMzA7tKD+L5
	GeL/CaCxIjWI7jPrk2vbrkWJQ0T9FaX+EHfLUIzq9oSIu3m0SI1GElbwpCEOa0DYb+Po4rxRjetJ7
	kjSEn6Dnma7NQJ4bWgC51ikaLv6b5YqaN0SY1FMTZLSCGXnMkZCfVcMLKRDT0Tf7ip14Jb1D4pOII
	61hdDlNiEdH8M0c1EGbu79ZZ0DVe/8IcsVAoKHqj6lq8NfYjB3xza6rX98xJYBmzjL6H+UR/2vNJ0
	owps46mbA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kZYGR-0006zE-3R; Mon, 02 Nov 2020 11:44:43 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kZYGI-0006xL-MY
 for linux-nvme@lists.infradead.org; Mon, 02 Nov 2020 11:44:37 +0000
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426;
 MF=baolin.wang@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0UDzBHD5_1604317461; 
Received: from 30.0.183.43(mailfrom:baolin.wang@linux.alibaba.com
 fp:SMTPD_---0UDzBHD5_1604317461) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 02 Nov 2020 19:44:22 +0800
Subject: Re: [PATCH] nvme: Simplify the nvme_req_qid()
To: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
References: <3ddb02eee7765d63328da3e1499a26da5cd20f1b.1603785673.git.baolin.wang@linux.alibaba.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <2735ac5c-3d7a-0829-368a-2066e75fe635@linux.alibaba.com>
Date: Mon, 2 Nov 2020 19:44:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <3ddb02eee7765d63328da3e1499a26da5cd20f1b.1603785673.git.baolin.wang@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201102_064435_447275_1C3B89AE 
X-CRM114-Status: GOOD (  14.93  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: baolin.wang7@gmail.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

> Use the request's '->mq_hctx->queue_num' directly to simplify the
> nvme_req_qid() function.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Gentle ping?

> ---
>   drivers/nvme/host/nvme.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index cc11113..0b62b62 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -178,7 +178,8 @@ static inline u16 nvme_req_qid(struct request *req)
>   {
>   	if (!req->q->queuedata)
>   		return 0;
> -	return blk_mq_unique_tag_to_hwq(blk_mq_unique_tag(req)) + 1;
> +
> +	return req->mq_hctx->queue_num + 1;
>   }
>   
>   /* The below value is the specific amount of delay needed before checking
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
