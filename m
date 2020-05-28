Return-Path: <SRS0=0R6w=7K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A1EC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 18:11:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B23DE207D3
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 18:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eggmCiqN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BLHUHyl7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23DE207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uFTiM+sbd14lcxrZ8TZyGJ3CfmUFjbchY0IcS9OyBYo=; b=eggmCiqNpM5Blj
	yUPcpD3WRQikAorq1boMwKFlDk50FJ64AcUI2xN5vf8Rlswv/cLP2FcUNsL3wQBnRcbpaZ/Rq0bnx
	dbq4lCNOyAa0gTcjktjjXsfDCSYwX5Nk1JjS1iNZ7k4xdxqMFBXtqCAp72xU3/cRSfHCdSoq2+ypT
	j3aQLAVA3yeKvYemKZZCPZ8VXwTY8VJgsYiEL/2SxpebHNU0kGehWaZpPY5N6PTOQIlYb5im723fV
	syARV2w7gaws207HUPaCX21foZWsxt2aQ1zSy991kPI3jhRrQiCWPRqc0pr6l3JxNkxKRfG8CqABH
	sNu6kes9P2iC00mRQU+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jeMzz-0006Uo-6S; Thu, 28 May 2020 18:11:23 +0000
Received: from aserp2120.oracle.com ([141.146.126.78])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jeMzw-0006UA-I3
 for linux-nvme@lists.infradead.org; Thu, 28 May 2020 18:11:22 +0000
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04SHWBuk183830;
 Thu, 28 May 2020 18:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=HzRuuEB6uI3yDSFvd/a+fBX6cIBxbYDGlp4XeHnGFT0=;
 b=BLHUHyl7f4itBnh295W3NJ+DKBxvMVIDPWpYFygsTiIyBJ9aAmNX1JCPytvhGqDAdSfK
 Sz4+Ng36XyIMYk6uwFISivQwKyDN610Cx6Rmrg53rnxFrtZyStp5vfWvQ/g9Yi+TmwDJ
 EtxSQTLa8LyN+lvwJulukPbaMBRXHMeK23LePpOpTh9dsY+nGhIXHCGjGWKps6wTX4Xa
 Cduj9MWUev6of3xi1iXbjeWvaPk2Ht6svbzz1YczmnQIP1V9HNMQ7OJWLvfrDggykALr
 hi7b7zMdz8mzS6HSLkbXBodnlGW6rjXRgnpP8P7DMQ3XNk1jD5AeJX9+5cEkPs8qlx8U aA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 318xe1ph52-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 28 May 2020 18:11:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04SHXeG7018831;
 Thu, 28 May 2020 18:11:07 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 31a9ksxvfq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 May 2020 18:11:07 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04SIB53b022346;
 Thu, 28 May 2020 18:11:05 GMT
Received: from [10.159.153.237] (/10.159.153.237)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 28 May 2020 11:11:04 -0700
Subject: Re: [PATCHv3 1/2] blk-mq: export __blk_mq_complete_request
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20200528153441.3501777-1-kbusch@kernel.org>
From: Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <e3cec8e1-1760-0c26-0e23-eb53e5b78f10@oracle.com>
Date: Thu, 28 May 2020 11:11:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200528153441.3501777-1-kbusch@kernel.org>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005280122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 adultscore=0 cotscore=-2147483648 mlxscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005280122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200528_111120_685335_3CBDB62D 
X-CRM114-Status: GOOD (  20.51  )
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
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 5/28/20 8:34 AM, Keith Busch wrote:
> For when drivers have a need to bypass error injection.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v2->v3: Use _GPL export
> 
>  block/blk-mq.c         | 3 ++-
>  include/linux/blk-mq.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index cac11945f602..e62559ac7c45 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -556,7 +556,7 @@ static void __blk_mq_complete_request_remote(void *data)
>  	q->mq_ops->complete(rq);
>  }
>  
> -static void __blk_mq_complete_request(struct request *rq)
> +void __blk_mq_complete_request(struct request *rq)
>  {
>  	struct blk_mq_ctx *ctx = rq->mq_ctx;
>  	struct request_queue *q = rq->q;
> @@ -602,6 +602,7 @@ static void __blk_mq_complete_request(struct request *rq)
>  	}
>  	put_cpu();
>  }
> +EXPORT_SYMBOL_GPL(__blk_mq_complete_request);
>  
>  static void hctx_unlock(struct blk_mq_hw_ctx *hctx, int srcu_idx)
>  	__releases(hctx->srcu)
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index d7307795439a..cfe7eac3764e 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -494,6 +494,7 @@ void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list);
>  void blk_mq_kick_requeue_list(struct request_queue *q);
>  void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
>  bool blk_mq_complete_request(struct request *rq);
> +void __blk_mq_complete_request(struct request *rq);
>  bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
>  			   struct bio *bio, unsigned int nr_segs);
>  bool blk_mq_queue_stopped(struct request_queue *q);


The null block driver requires this as well.

Otherwise, the below would hang forever because timeout handler keeps failing.

# echo 100 > /sys/kernel/debug/fail_io_timeout/probability
# echo 1000 > /sys/kernel/debug/fail_io_timeout/times
# echo 1 > /sys/block/nullb0/io-timeout-fail
# dd if=/dev/zero of=/dev/nullb0 bs=512 count=1 oflag=direct

With below patch, the timeout handler is able to complete the IO.

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index ce9e33603a4d..ba107b264fab 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1397,7 +1397,7 @@ static bool should_requeue_request(struct request *rq)
 static enum blk_eh_timer_return null_timeout_rq(struct request *rq, bool res)
 {
        pr_info("rq %p timed out\n", rq);
-       blk_mq_complete_request(rq);
+       __blk_mq_complete_request(rq);
        return BLK_EH_DONE;
 }

I would wait for the new exported API name until I send out the above.

Perhaps there are more drivers that require such kind of change, but in more
specific corner case.

Dongli Zhang

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
