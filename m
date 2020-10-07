Return-Path: <SRS0=DCfI=DO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC635C46466
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Oct 2020 00:20:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BABF20760
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Oct 2020 00:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LIrG9V7G";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="P5uI3k2P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BABF20760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jozadDH6LuUKR87RySB9MwCfMKWpu1xXd+4Vn9UekiE=; b=LIrG9V7G/QI99/S5YzCOUttgI
	RH4bJaMVaRHt66qe6ot86upNhTLiw1+uPBca1KkBZPVaGnFyehtOrs3/OoynIbm/ANo7B8TF9l1DK
	RQ3h9N6bk06oCi+TFGp+d7KghajKC1Mt8AOeFBi21Ep1Pcs+joYgLcmvbxQ3D3u1Vl8t14wU4KnGq
	SrPrCCvd3ufgEo5lMFgQAAlthtcjMpwSiH5em5RQKLZuS63Xvwh7EzEzescY6SSe/0V+6aoO6Axg2
	J9GksL9fDP95YOTLK7sap6wkDl6+Q29eJfhXsD1U9aYLKH+dCfYisfTznSO+T27WrIw7e4M9A1rTV
	mUzi26ukQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPxBe-00032Y-O5; Wed, 07 Oct 2020 00:20:06 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPxBc-000329-AI
 for linux-nvme@lists.infradead.org; Wed, 07 Oct 2020 00:20:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1YTuU0iGhSD0CSl0VJJPb6u4Y0+vCizpDxA2qIMTGKo=; b=P5uI3k2P3wdViyRILFT8KQ2iXQ
 0JDXE+vg6+4gFXDjVv+NVLdbJSHUoRFIy/1Eo6PHMUB+n6NGVMilcYbfRx6yKGIR3en+Gk01Ub+TF
 QJlyTRYI1iMtCsfh593o9uBKkPtqFsFlCD+Ck5Vu2+4IgzYdMhXsLBo6DIHTKj8YcbtTm5j5echXI
 Ol1iXHzhNIVJkAlnvfyIJhZdgAT2Tx+At4s5t7feVyCMKtEDAC490LUVJ3fAnzKAeBi+jQonKfUxh
 3gmzgANv5HWEiCzHI1HaQZg4/CkTEhQV1F18WOVwFMjRa6g+4H1WON9afJ1aYyhRwNJsuBrD2ipy/
 +Pp4u8lQ==;
Received: from [172.16.1.162] by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1kPxBY-0007FQ-MR; Tue, 06 Oct 2020 18:20:01 -0600
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20201006233647.57760-1-chaitanya.kulkarni@wdc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e2c46d78-972b-dd7c-6662-edbf91a095fa@deltatee.com>
Date: Tue, 6 Oct 2020 18:20:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201006233647.57760-1-chaitanya.kulkarni@wdc.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] nvme-core: put ctrl ref when module ref get fail
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201006_202004_792689_F2DFED29 
X-CRM114-Status: GOOD (  17.73  )
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



On 2020-10-06 5:36 p.m., Chaitanya Kulkarni wrote:
> When try_module_get() fails in the nvme_dev_open() it returns without
> releasing the ctrl reference which was taken earlier.
> 
> Put the ctrl reference which is taken before calling the
> try_module_get() in the error return code path.
> 
> Fixes: 52a3974feb1a "nvme-core: get/put ctrl and transport module in nvme_dev_open/release()"
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

I guess I missed this too in my review of that patch. Nice catch.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

> ---
>  drivers/nvme/host/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index c20ce8eabe82..56e2a22e8a02 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3158,8 +3158,10 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
>  	}
>  
>  	nvme_get_ctrl(ctrl);
> -	if (!try_module_get(ctrl->ops->module))
> +	if (!try_module_get(ctrl->ops->module)) {
> +		nvme_put_ctrl(ctrl);
>  		return -EINVAL;
> +	}
>  
>  	file->private_data = ctrl;
>  	return 0;
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
