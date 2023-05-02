Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940ABC77B7E
	for <linux-nvme@archiver.kernel.org>; Tue,  2 May 2023 06:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wfuhAGUHfVo4gsYc8115bqIcUjuAPo0o95qS9PzPfOY=; b=1QwtXXbj8gBRin8zQL7DUGEXs4
	VVRd9E4wf1O+QbzRolYsXS6tXfow2hww1W/Gi7iv+O+ML6qB5sXyhL0lKgi7RPGSAQB6MwU+qs8Tt
	/HtAxCTGZTINHald56fwKW4VjCZqjvvO/knkO4bCLGSzUznzqomfwa2WGsvcCQ7mP1SrM/JVU1ixd
	Qr1uB3bREHqn2mzK/koAfjt/eIkD59JKx2U4qxTwRZlKpm75Ic0v2XqYizNnhTs8+543EasGKsnP6
	B6USPniEbvJQjz+YpgMdWIIlWUxdtd4UPmf3j/PJCIXGM8iOMxttIDB8KiSvdIStkDwAAQfjRXsv2
	aQtvaD8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptjG2-000J3c-2u;
	Tue, 02 May 2023 06:13:02 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptjFz-000J2R-2L
	for linux-nvme@lists.infradead.org;
	Tue, 02 May 2023 06:13:01 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4346421EA4;
	Tue,  2 May 2023 06:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683007978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wfuhAGUHfVo4gsYc8115bqIcUjuAPo0o95qS9PzPfOY=;
	b=CZn7d9XUlpXt8ipfq30KblCccRGpCvPwzwvLmRsBKf7y4xISeocbpssbM6z1y05JVjIk6l
	AsZV1ptWJsOmgG+2wcdJ+FbSc1C9NUqkQVCdzBAgKgqdJAeJ/AijWaWwJ83ZD+TNcl7Ise
	+pRpdhUuq5P3GWR4RR6jMXBa+myn6D4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683007978;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wfuhAGUHfVo4gsYc8115bqIcUjuAPo0o95qS9PzPfOY=;
	b=vz8/YKcWBu8yPvZPTF3c7/PlIsthmLvwfzjja/twuCrkxOyjrbzS6fLZCgtTzeBLE8WORl
	/tQuWY2rLIQEqHBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 23AEF134FB;
	Tue,  2 May 2023 06:12:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id xX3NB+qpUGR3bAAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 02 May 2023 06:12:58 +0000
Message-ID: <2c4334b8-8262-4a31-5cca-e91b119f2357@suse.de>
Date: Tue, 2 May 2023 08:12:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH 2/2] nvme-core: use macro defination to define dev
 attr
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
References: <20230427080207.17249-1-kch@nvidia.com>
 <20230427080207.17249-3-kch@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230427080207.17249-3-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_231259_906853_AE3B20A5 
X-CRM114-Status: GOOD (  18.70  )
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

On 4/27/23 10:02, Chaitanya Kulkarni wrote:
> Insated of duplicating the code for dhchap_secret & dhchap_ctrl_secret,
> define a macro to register device attribute to create device attribute
> that will also define store and show helpers.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/core.c | 71 +++++++++++++++-------------------------
>   1 file changed, 27 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 171ae1f2197a..f619158ea2fc 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3780,17 +3780,6 @@ static DEVICE_ATTR_RO(dctype);
>   
>   #ifdef CONFIG_NVME_AUTH
>   
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
>   		char **dhchap_secret, struct nvme_dhchap_key **orig_key,
>   		const char *buf, size_t count)
> @@ -3833,40 +3822,34 @@ static ssize_t nvme_dhchap_secret_store_common(struct nvme_ctrl *ctrl,
>   	return count;
>   }
>   
> -static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
> -		struct device_attribute *attr, const char *buf, size_t count)
> -{
> -	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> -
> -	return nvme_dhchap_secret_store_common(ctrl, &ctrl->opts->dhchap_secret,
> -			&ctrl->host_key, buf, count);
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
> +#define NVME_AUTH_DEVICE_ATTR(NAME)					\
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
> +		struct device_attribute *attr, const char *buf, 	\
> +		size_t count)						\
> +{									\
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);			\
> +									\
> +	return nvme_dhchap_secret_store_common(ctrl,			\
> +			&ctrl->opts->NAME,				\
> +			&ctrl->host_key, buf, count);			\
> +}									\
> +									\
> +static DEVICE_ATTR(NAME, S_IRUGO | S_IWUSR,				\
> +	nvme_ctrl_##NAME##_show, nvme_ctrl_##NAME##_store);		\
>   
> -	return nvme_dhchap_secret_store_common(ctrl,
> -			&ctrl->opts->dhchap_ctrl_secret, &ctrl->ctrl_key, buf,
> -			count);
> -}
> -static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
> -	nvme_ctrl_dhchap_ctrl_secret_show, nvme_ctrl_dhchap_ctrl_secret_store);
> +NVME_AUTH_DEVICE_ATTR(dhchap_secret);
> +NVME_AUTH_DEVICE_ATTR(dhchap_ctrl_secret);
>   #endif
>   
>   static struct attribute *nvme_dev_attrs[] = {

In principle ok, but obviously depends on the discussion on the first patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


