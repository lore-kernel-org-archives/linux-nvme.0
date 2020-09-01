Return-Path: <SRS0=Ap99=CK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6F6C433E6
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 17:23:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC3982078B
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 17:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZG5n2RiV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="o35jijD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC3982078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2F1MEwRmcfVlQpjOzqskocJZnho1MC5w5PiHb94OdjQ=; b=ZG5n2RiVBsvER1ENHmiDlzHzl
	WpGEZdtoHD7X9jx2giF/bOB8vb857IOUTaCayBwrk1BJP4jVt459HKYB4O6WER/JtVX9Cyj8igwPO
	PsIHcVuGI3ES43M9HUfrIkkrJBOhv8F4AflRA824P2QutaNnwjUhV5Fi8GKq0sR8ySNVIp0lvgypy
	S8TwD+vYlFqLhIjTyhPXdP7ylW87Crm+YoNmmZzvZKNxQCwUZFYbEzDL5zBY735fPoBiZGx53hQQ8
	U6rfK6fKCyblGcagzTx+dPfS1r+Acen+Ng+7oVaqW3MC642DAqc/JfSBd+9RLbyWz6cYAZcMQzd4H
	xq4f0FGtg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDA0Z-0005Aj-Gp; Tue, 01 Sep 2020 17:23:47 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDA0X-00059w-FS
 for linux-nvme@lists.infradead.org; Tue, 01 Sep 2020 17:23:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qXp8hH9EFe6nOxhXw92y3S31WFXcvVns5Y68XqLPzOw=; b=o35jijD+7nxR2wxGvqgHnuM7mp
 nyWS3ZEhwLXVAwXKMLP4ioQzT2YCI35fjjK0yz5aVHbgs7ra3vOa6z2arBuirYZPZ7YF2kIbGNVa6
 +UGusC78YLdQc+V+ZKMWCb9KgMFK9yVCV2hMQvhamLPvVW9+zAdPnWYRIfeR3sj4PavwbzKuBfn62
 xyc1i3Xhjw+C8wd9aBc5u2ZjzrJyQMid8wncppiB1KGwDXHX2+jBnwDbO4+tXB9UyV5JNI5cCiWJI
 5hmJdZkpAMr47ETUj/QAnmoqV8WKyucX7YDoT9ULNH4kjGO5rELMUAZKNQXyaS+ZvWIRM2XO8lcAJ
 /tXBftcw==;
Received: from [172.16.1.162] by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1kDA0U-0007GF-He; Tue, 01 Sep 2020 11:23:43 -0600
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
 <20200831222707.35611-10-chaitanya.kulkarni@wdc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <012a68bb-2b0d-23f8-0dc9-d21ed8950841@deltatee.com>
Date: Tue, 1 Sep 2020 11:23:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200831222707.35611-10-chaitanya.kulkarni@wdc.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: kbusch@kernel.org, sagi@grimberg.me, hch@lst.de,
 linux-nvme@lists.infradead.org, chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH V2 09/12] nvmet: fix nvme module ref count Oops
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200901_132345_528043_FB45D13F 
X-CRM114-Status: GOOD (  18.37  )
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
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-08-31 4:27 p.m., Chaitanya Kulkarni wrote:
> In the passthru controller enable path current code doesn't take the
> reference to the passthru ctrl module. Which produces following Oops :-

Seems like this change should be justifiable without passthru, simply by
 opening the char device and removing the module. The tag in the title
should certainly be nvme, not nvmet...

> We fix that by taking a module ref count in nvme_dev_open() and release
> that ref count in nvme_dev_release().
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/host/core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f82c6a283b15..c940f49a30bf 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3263,6 +3263,12 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
>  
>  	file->private_data = ctrl;
>  	nvme_get_ctrl(ctrl);
> +	if (!try_module_get(ctrl->ops->module)) {
> +		pr_err("try_module_get failed for cntlid 0x%x\n", ctrl->cntlid);

Is the error print necessary? We don't print any errors in the similar
path in nvme_open()...

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
