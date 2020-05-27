Return-Path: <SRS0=KSy6=7J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B1EC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2020 19:36:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2C2A2078B
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2020 19:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QqKnW+wV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="smcCcIEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C2A2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2ntjAUAvqzR/QWa+N92DEEbD4KLQ5jAgoEfpykL1MSo=; b=QqKnW+wVwHcKkt
	LZFUdheTvicij9h0t7OK2ZM1bffalPt6lVKsFaqZ6VEJcG4rH75t+oYSqD8vAyXafHAzdgJ9O4EO8
	MPLMPrsKh9krVU64wDwzp3Oksl62jZ5CF6cHGdv4BqTd+SjYpkKJ2FhdxzeVP4P5bN2UyECCGL+fl
	NdINV5defTy63hocjNr/ECTHCVyX0JfhmLkCTnZWNvV/EzkBAh2BqPjeUTXk7Lt2exYY0mM2deG6c
	orRgBPXlc2B3xjb1dLS0y/Jd8Ry6oHxoanpPeZbuis03+O2CDqk2HyFOU0vR+xXuMpvajBUMh7bci
	ED9Lq8SDCDrOKi4PLg/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1je1ql-0001qY-7r; Wed, 27 May 2020 19:36:27 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1je1qi-0001q1-B5
 for linux-nvme@lists.infradead.org; Wed, 27 May 2020 19:36:25 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04RJVkXU172634;
 Wed, 27 May 2020 19:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=jFwNXc0F3t3+PshXkm70RmyltIuqTcBc3CJzDkod8Nk=;
 b=smcCcIEUqc9c6WrVbpJ/cA+AR3698/0XPxCpuEnYRfh4z5fkgGuE7D88iqrdfJ9BJTpG
 gR+HEk8pwMn0KMWu4aBUEP0jUM+Gze8hXlj4QPRJL/1FLqQq4XWc2d+aXJXQCiPvGo/B
 jh9Ie9sRF072Sgktc4Z8KUhw46t8Bji59vDcB0mrbauNR2BBqaUccAG7vIqYk/uuupFh
 JgLV8qBZHa9uJOKXaSQFsNk/6Fnvgm1q+2Mjfo2Zae7Iw1DDQdBCfzSuP1MKxafaaAvT
 fBCF03HEem5V8KZRVO+IJJQenc2VfdntS5EXEKHQ9YlSEwHHPGZGRytD/ndh9OYW/EDy ow== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 318xbk1ex1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 May 2020 19:36:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04RJWsDU139826;
 Wed, 27 May 2020 19:36:11 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 317ds12e6v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 May 2020 19:36:11 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04RJa9cc018995;
 Wed, 27 May 2020 19:36:09 GMT
Received: from [10.159.255.104] (/10.159.255.104)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 27 May 2020 12:36:08 -0700
Subject: Re: [PATCH] nvme: cancel requests for real
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me
References: <20200527190913.3461503-1-kbusch@kernel.org>
From: Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <eaccdf19-25ef-cf15-5183-dee97b964025@oracle.com>
Date: Wed, 27 May 2020 12:36:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200527190913.3461503-1-kbusch@kernel.org>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9633
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005270149
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9633
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 cotscore=-2147483648
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005270149
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200527_123624_511333_3672E250 
X-CRM114-Status: GOOD (  20.65  )
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
Cc: axboe@kernel.dk, alan.adamson@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Keith,

On 5/27/20 12:09 PM, Keith Busch wrote:
> Once the driver decides to cancel requests, the concept of those
> requests timing out should no longer exist. Since we can't stop fake
> timeouts from preventing a forced reclaim, continue completing the same
> request until the block layer isn't told to pretend that didn't happen.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ba860efd250d..72e5973dda3a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -310,7 +310,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
>  		return true;
>  
>  	nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
> -	blk_mq_complete_request(req);
> +	while (!blk_mq_complete_request(req));
If the probability is configured to fail every time with 100% probability, we
would run into endless loop?

Dongli Zhang

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
