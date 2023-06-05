Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC27BC7EE24
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 07:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nUcwUcsO7NsH7k0flbemtdbFT3WO22/1UFPu1jPnqj0=; b=gkWnZ4crovwA9UeQA+S3qSpnHT
	c21UUgpfSEmU7iXo6oFvnPWIm5ByZvpczmWBXMLsxKM0i/JQt061fh80RkaMS8kQOs8ljd1YjYcLy
	u/EzigaoLoqPze9oC049TEZ07gT4BzCJvtqmJd9GIAld8BB/hoyzLI9OTJ2Uz0Ozxf4Jr6hvlypI2
	iXO3mg624xxQLF+XmtzHgzO0YI+LFJkBEiEBuQ+8er7cK0dWFAofLefXbGXdtFv9m6qPKNvzpGfuX
	gr1+yZK+npX1bf0V/OtyR8BV2B+gU7WbvM6L4EMRlUd9F1JxzKC2XrhaGqg7yf4AKjQ6huTBibL+I
	t2WZcd8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q653T-00Ed4x-2U;
	Mon, 05 Jun 2023 07:55:07 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q653Q-00Ed4M-33
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 07:55:06 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 89AB321A8F;
	Mon,  5 Jun 2023 07:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1685951703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nUcwUcsO7NsH7k0flbemtdbFT3WO22/1UFPu1jPnqj0=;
	b=STKIVHsROhBtdeyTr9NM7vORB1JzACfTTJ7JyRLjFO2H9TFOFW9Aod0hx4FCJiZmzeE/4h
	rAXWMnkCkjGcu4MLpcSNYpHzFgZkIdeYtccyoM8RD+0grgjxF3ypKIyvH4t5jqRGh7fph3
	9GJVeSvtxGGATSKdUQ2ZckusIdKaki0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1685951703;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nUcwUcsO7NsH7k0flbemtdbFT3WO22/1UFPu1jPnqj0=;
	b=R1KZ5jEtFfUdmPGsN2EQuRrgnEs92uwzEdtZ6jYlfeKXfUvVSEZynMkhGLygl3jqZ8vKeJ
	lug5GzE9tgb5DiBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 27460139C8;
	Mon,  5 Jun 2023 07:55:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Kz6gCNeUfWTweAAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 05 Jun 2023 07:55:03 +0000
Message-ID: <5dcb4c76-0d97-78d6-d383-7f92e7eb4467@suse.de>
Date: Mon, 5 Jun 2023 09:55:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 2/2] nvme-core: use macro defination to define dev attr
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
References: <20230605065125.47563-1-kch@nvidia.com>
 <20230605065125.47563-3-kch@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230605065125.47563-3-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_005505_132737_F9E408D2 
X-CRM114-Status: GOOD (  21.61  )
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

On 6/5/23 08:51, Chaitanya Kulkarni wrote:
> Insated of duplicating the code for dhchap_secret & dhchap_ctrl_secret,
> define a macro to register device attribute to create device attribute
> that will also define store and show helpers.
> 
> Note that this is not newly invented but followed the same format
> preasent in block layer and nvme source code.
> nvme_show_str_function/nvme_show_int_function/
> nvme_subsys_show_str_function/ nullb_device_##NAME##_show/
> nullb_device_##NAME##_store/LOOP_ATTR_RO
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/sysfs.c | 67 +++++++++++++++------------------------
>   1 file changed, 25 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 98becb7a7453..ff72bcfb0ff8 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -407,17 +407,6 @@ static ssize_t dctype_show(struct device *dev,
>   static DEVICE_ATTR_RO(dctype);
>   
>   #ifdef CONFIG_NVME_AUTH
> -static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
> -		struct device_attribute *attr, char *buf)
> -{
> -	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> -	struct nvmf_ctrl_options *opts = ctrl->opts;
> -
> -	if (!opts->dhchap_secret)
> -		return sysfs_emit(buf, "none\n");
> -	return sysfs_emit(buf, "%s\n", opts->dhchap_secret);
> -}
> -
>   static ssize_t nvme_dhchap_secret_store_common(struct nvme_ctrl *ctrl,
>   		const char *buf, size_t count, bool ctrl_secret)
>   {
> @@ -472,38 +461,32 @@ static ssize_t nvme_dhchap_secret_store_common(struct nvme_ctrl *ctrl,
>   	return count;
>   }
>   
> -static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
> -		struct device_attribute *attr, const char *buf, size_t count)
> -{
> -	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> -
> -	return nvme_dhchap_secret_store_common(ctrl, buf, count, false);
> -}
> -
> -static DEVICE_ATTR(dhchap_secret, S_IRUGO | S_IWUSR,
> -	nvme_ctrl_dhchap_secret_show, nvme_ctrl_dhchap_secret_store);
> -
> -static ssize_t nvme_ctrl_dhchap_ctrl_secret_show(struct device *dev,
> -		struct device_attribute *attr, char *buf)
> -{
> -	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> -	struct nvmf_ctrl_options *opts = ctrl->opts;
> -
> -	if (!opts->dhchap_ctrl_secret)
> -		return sysfs_emit(buf, "none\n");
> -	return sysfs_emit(buf, "%s\n", opts->dhchap_ctrl_secret);
> -}
> -
> -static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
> -		struct device_attribute *attr, const char *buf, size_t count)
> -{
> -	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> -
> -	return nvme_dhchap_secret_store_common(ctrl, buf, count, false);
> -}
> +#define NVME_AUTH_DEVICE_ATTR(NAME, cs)					\
> +static ssize_t nvme_ctrl_##NAME##_show(struct device *dev,		\
> +		struct device_attribute *attr, char *buf)		\
> +{									\
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);			\
> +	struct nvmf_ctrl_options *opts = ctrl->opts;			\
> +									\
> +	if (!opts->NAME)						\
> +		return sysfs_emit(buf, "none\n");			\
> +	return sysfs_emit(buf, "%s\n", opts->NAME);			\
> +}									\
> +									\
> +static ssize_t nvme_ctrl_##NAME##_store(struct device *dev,		\
> +		struct device_attribute *attr, const char *buf,		\
> +		size_t count)						\
> +{									\
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);			\
> +									\
> +	return nvme_dhchap_secret_store_common(ctrl, buf, count, cs);	\
> +}									\
> +									\
> +static DEVICE_ATTR(NAME, S_IRUGO | S_IWUSR,				\
> +	nvme_ctrl_##NAME##_show, nvme_ctrl_##NAME##_store);		\
>   
> -static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
> -	nvme_ctrl_dhchap_ctrl_secret_show, nvme_ctrl_dhchap_ctrl_secret_store);
> +NVME_AUTH_DEVICE_ATTR(dhchap_secret, false);
> +NVME_AUTH_DEVICE_ATTR(dhchap_ctrl_secret, true);
>   #endif
>   
>   static struct attribute *nvme_dev_attrs[] = {

Is it really worthwhile?
These are just two sysfs attributes which are generalized that way, and 
it's adding quite some boilerplate code to make it work.

Plus I'll plan to rewrite authentication key handling to leverage 
in-kernel keyrings once the TLS stuff has been accepted.

So I'd rather not have this one. But might be convinced if someone has a 
more compelling reason.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


