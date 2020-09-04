Return-Path: <SRS0=O63G=CN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F5BC433E2
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 15:57:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B413020791
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 15:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H0aIOqhG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="iOFWNnBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B413020791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mLx5te8A+oyrDemBcR9137Qvgre/2TUpLRAk96rVOys=; b=H0aIOqhGB2WWCsnoX4tULilH0
	oCWRFXptz/B/grg8Is4KagZ2Tmzn7RXbmaj7mhPlIaTORzmDhH+52U7Sa5jqj+ImpIKzKY9tDHyk5
	mu3toUAFA7wsctdlehGECw3KKRRDIqzwrhlfKV4YRTpac7b604YpMAIafWNx22oxJAbph/eWYpx21
	YedqJNtEGa8RtDAoKCCZMGW60UPQBYJSvxlV86CiUbJ+zJQgFJkcpep+JpCa+ZzPTTKW1PzgYAivT
	aCWJaDPDeHl53FzNi336/rvBTN8bCd5j3Z6VW544SZe9EhUPuk4b9GrhiHJzUx/+i4RVetjXOawVO
	PX1k7QsfA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kEE5W-00023S-6U; Fri, 04 Sep 2020 15:57:18 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kEE5M-0001xm-Lx
 for linux-nvme@lists.infradead.org; Fri, 04 Sep 2020 15:57:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fqBMPPm5s/JahS6zw/vh5YIGxbt5s482W6ZSCHC3MM4=; b=iOFWNnBr8Rfcu1VzpBOtqMiLMl
 E/cwKRPcJIW8von5BDKHCIpDPgfQ8mavQaGKxlSzYhjRmqeDK/98rZ0DxHMbgfp9osI5cGzeHgkJi
 1XOS7VP76Oma0qrevtODJLcHXYleELdysQs9K1QgOjMxPE5yO/X2dWKPHgMC7qE50C1HmGG8Rkp8x
 S+jA6TRhX7gWUsmOwwS1GVNskGyAGRIZnNUvn8v/6vkrrwW05zGZedyRn6rFdf65hk/vOYucBfSsW
 ZkTAi7Zo2qgd8uNcQfjOa3kxU75phyjSTEiHq0O+Ff8XipfSD0Jqniph5rds5LvDzZCFvmbtLpr3g
 U9v+g+hQ==;
Received: from [172.16.1.162] by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1kEE5J-0007t0-Mz; Fri, 04 Sep 2020 09:57:06 -0600
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20200904023929.5320-1-chaitanya.kulkarni@wdc.com>
 <20200904023929.5320-4-chaitanya.kulkarni@wdc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8c075e3a-d461-7d58-7c02-5ce81cfff6b9@deltatee.com>
Date: Fri, 4 Sep 2020 09:57:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904023929.5320-4-chaitanya.kulkarni@wdc.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sagi@grimberg.me, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org, chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 3/3] nvme-core: fix nvme module ref count Oops
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200904_115708_898576_E4DDAD08 
X-CRM114-Status: GOOD (  15.10  )
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



On 2020-09-03 8:39 p.m., Chaitanya Kulkarni wrote:
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a1707afcb710..8445293c74e3 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3263,6 +3263,12 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
>  
>  	file->private_data = ctrl;
>  	nvme_get_ctrl(ctrl);
> +	if (!try_module_get(ctrl->ops->module)) {
> +		pr_err("try_module_get failed for cntlid 0x%x\n", ctrl->cntlid);
> +		nvme_put_ctrl(ctrl);
> +		return -EINVAL;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -3271,6 +3277,7 @@ static int nvme_dev_release(struct inode *inode, struct file *file)
>  	struct nvme_ctrl *ctrl =
>  		container_of(inode->i_cdev, struct nvme_ctrl, cdev);
>  
> +	module_put(ctrl->ops->module);
>  	nvme_put_ctrl(ctrl);
>  	return 0;
>  }

I'd probably just fold these changes into the previous patch. When we
get a reference to the controller we must also get a reference to the
transport module. So no sense getting the different references in
different patches.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
