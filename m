Return-Path: <SRS0=j6C5=H4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB14C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 01:13:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 388EE64EDC
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 01:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388EE64EDC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=o935sCpp5Zvm7GZdHxvnJmyGj1AmVuxbIAUpnuITrdo=; b=iKfWZQrTpHDWM5TfqVxy9XBCw
	EW6/K/DYKnI5vwOKVXo3c6UolabwbIaP4cH0PhktmE1gdTyK9bXRr4KGOp+c4TUcITin1GhsHAMDd
	hS5OboWadGwCzw40bl9qsxy8Yu4j7iWcCsgtkH6qWT66w+mW3YbsjMdX7QeSlDJQh+aIft0zLhk20
	11DWMimcE+Ag/pW1FNFYOIksaqtnzW5OmPckx/0tfjVuKKmvN/YDzmWG64Y0KwN3zbsP9t+/Vp10P
	YmlzJ0gMkaBY6o9W8g5UPMQYqVmYyBr7aGYX+qVqOdnpp0r5w5/i2p47yt7zEXMTruYBtdnUH8nY8
	V71AJGC6g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFRhS-0001UM-Oq; Fri, 26 Feb 2021 01:13:46 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFRhP-0001Sq-6G
 for linux-nvme@lists.infradead.org; Fri, 26 Feb 2021 01:13:44 +0000
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Dms7q3CjtzYCkV;
 Fri, 26 Feb 2021 09:12:07 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 26 Feb 2021 09:13:35 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Fri, 26
 Feb 2021 09:13:35 +0800
Subject: Re: [PATCH 2/6] nvme: add NVME_REQ_CANCELLED flag in
 nvme_cancel_request()
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20210225105527.75277-1-hare@suse.de>
 <20210225105527.75277-3-hare@suse.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <77e41673-8fb0-a399-fee4-ebbf622f44f7@huawei.com>
Date: Fri, 26 Feb 2021 09:13:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210225105527.75277-3-hare@suse.de>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme713-chm.china.huawei.com (10.1.199.109) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210225_201343_495509_CD556BD0 
X-CRM114-Status: GOOD (  16.46  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Daniel Wagner <dwagner@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Chao Leng <lengchao@huawei.com>

On 2021/2/25 18:55, Hannes Reinecke wrote:
> NVME_REQ_CANCELLED is translated into -EINTR in nvme_submit_sync_cmd(),
> so we should be setting this flags during nvme_cancel_request() to
> ensure that the callers to nvme_submit_sync_cmd() will get the correct
> error code when the controller is reset.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/host/core.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 13ed7d3fbbb3..04dc85e0810c 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -380,6 +380,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
>   		return true;
>   
>   	nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
> +	nvme_req(req)->flags |= NVME_REQ_CANCELLED;
>   	blk_mq_complete_request(req);
>   	return true;
>   }
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
