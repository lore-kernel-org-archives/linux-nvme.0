Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56273C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jan 2022 09:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ggr7BadebEZnu6+WfRuw0CdzZqnQZ8sXedlYb7gYvy0=; b=i9fahmRDt5rILP8HMnhmNcLgIe
	PDc+9AKpdlLocv0NQTHLcYmFb9g3lVxumXATzJ/xgoWbwkQvB25gSu/gK4O6bUk/pKiK96PtJ1yF9
	QUoVzMIwx+TIA7NOQpRF3iGljCrhUlI6SrcAsVPly5uS/nfPY25gbnLZRiipHq3LAZ9c+bzYzaFcU
	XTzBpx8AorLm/6VnZYZIpLAgTQDtPoU5gI7wvS5deuq0KASgQKl327VpN4xuccSypd/3zbNUS9ten
	+WVRyDFq3O5J/iYAJPaLWjoDKXoRXpg6wTB3VQk3zWyE5+2VHbPXsbZhZ+sNAb+UE8/YwWVFz0Upw
	sNE7Z72g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nD1Bt-00EvPJ-KX; Thu, 27 Jan 2022 09:35:41 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nD0vg-00Er40-W9
 for linux-nvme@lists.infradead.org; Thu, 27 Jan 2022 09:18:58 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 885D4210FB;
 Thu, 27 Jan 2022 09:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643275135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ggr7BadebEZnu6+WfRuw0CdzZqnQZ8sXedlYb7gYvy0=;
 b=xTH2hrCQet0UZ5YrHZLKGbU5C0P5Q2nsr2qYXJlaJuOGRmRknhJb04Q4Nife+SkXUpDidf
 cneUGPxbQIKLBhTtTq5ZYWZnOXvD+z4DxNQxp2dt0SdfQYgEmShyMjEtwjSUTqa4g/IWp5
 QiHBYlBdYXmPM2g4zf6uakve5QqLQAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643275135;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ggr7BadebEZnu6+WfRuw0CdzZqnQZ8sXedlYb7gYvy0=;
 b=DyvZrP2cFEBAqKMAJ6ER28bpJh8/q5nATO86k5iRbjtc28XUEGK67+7gOiVBrLxrwnKl9T
 nhhWqN62n+4ryEAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7308D13CFB;
 Thu, 27 Jan 2022 09:18:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jhTKG39j8mFuHAAAMHmgww
 (envelope-from <hare@suse.de>); Thu, 27 Jan 2022 09:18:55 +0000
Message-ID: <1fcf8d75-4c5a-3de4-bb2d-a3e92460ba47@suse.de>
Date: Thu, 27 Jan 2022 10:18:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/4] nvme: add host symbolic name
Content-Language: en-US
To: Martin Belanger <nitram_67@hotmail.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 Martin Belanger <martin.belanger@dell.com>
References: <20220125145956.14746-1-nitram_67@hotmail.com>
 <BL0PR13MB429181ED6E81FAC7DDB801E89C5F9@BL0PR13MB4291.namprd13.prod.outlook.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <BL0PR13MB429181ED6E81FAC7DDB801E89C5F9@BL0PR13MB4291.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_011857_231388_4718E28D 
X-CRM114-Status: GOOD (  24.69  )
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

On 1/25/22 15:59, Martin Belanger wrote:
> From: Martin Belanger <martin.belanger@dell.com>
> 
> TP8010 introduces the 'host symbolic name' as an optional
> parameter for explicit registration with a central discovery
> controller.
> 
> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
> ---
>   drivers/nvme/host/core.c    | 14 ++++++++++++++
>   drivers/nvme/host/fabrics.c | 17 +++++++++++++++--
>   drivers/nvme/host/fabrics.h |  2 ++
>   include/linux/nvme.h        |  2 ++
>   4 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index cd34b92e8e9d..cf5d9984f8f6 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3404,6 +3404,16 @@ static ssize_t nvme_sysfs_show_hostnqn(struct device *dev,
>   }
>   static DEVICE_ATTR(hostnqn, S_IRUGO, nvme_sysfs_show_hostnqn, NULL);
>   
> +static ssize_t nvme_sysfs_show_hostsymname(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%s\n", ctrl->opts->host->symname);
> +}
> +static DEVICE_ATTR(hostsymname, S_IRUGO, nvme_sysfs_show_hostsymname, NULL);
> +
>   static ssize_t nvme_sysfs_show_hostid(struct device *dev,
>   					struct device_attribute *attr,
>   					char *buf)
> @@ -3531,6 +3541,7 @@ static struct attribute *nvme_dev_attrs[] = {
>   	&dev_attr_sqsize.attr,
>   	&dev_attr_hostnqn.attr,
>   	&dev_attr_hostid.attr,
> +	&dev_attr_hostsymname.attr,
>   	&dev_attr_ctrl_loss_tmo.attr,
>   	&dev_attr_reconnect_delay.attr,
>   	&dev_attr_fast_io_fail_tmo.attr,
> @@ -3553,6 +3564,9 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
>   		return 0;
>   	if (a == &dev_attr_hostid.attr && !ctrl->opts)
>   		return 0;
> +	if (a == &dev_attr_hostsymname.attr &&
> +	    (!ctrl->opts || (ctrl->opts->host->symname[0] == '\0')))
> +		return 0;
>   	if (a == &dev_attr_ctrl_loss_tmo.attr && !ctrl->opts)
>   		return 0;
>   	if (a == &dev_attr_reconnect_delay.attr && !ctrl->opts)
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 7ae041e2b3fb..040a6cce6afa 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -540,6 +540,7 @@ static const match_table_t opt_tokens = {
>   	{ NVMF_OPT_HOST_TRADDR,		"host_traddr=%s"	},
>   	{ NVMF_OPT_HOST_IFACE,		"host_iface=%s"		},
>   	{ NVMF_OPT_HOST_ID,		"hostid=%s"		},
> +	{ NVMF_OPT_SYMNAME,		"hostsymname=%s"	},
>   	{ NVMF_OPT_DUP_CONNECT,		"duplicate_connect"	},
>   	{ NVMF_OPT_DISABLE_SQFLOW,	"disable_sqflow"	},
>   	{ NVMF_OPT_HDR_DIGEST,		"hdr_digest"		},
> @@ -556,7 +557,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   		const char *buf)
>   {
>   	substring_t args[MAX_OPT_ARGS];
> -	char *options, *o, *p;
> +	char *options, *o, *p, *hostsymname = NULL;
>   	int token, ret = 0;
>   	size_t nqnlen  = 0;
>   	int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO;
> @@ -830,6 +831,13 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   		case NVMF_OPT_DISCOVERY:
>   			opts->discovery_nqn = true;
>   			break;
> +		case NVMF_OPT_SYMNAME:
> +			hostsymname = match_strdup(args);
> +			if (!hostsymname) {
> +				ret = -ENOMEM;
> +				goto out;
> +			}
> +			break;
>   		default:
>   			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
>   				p);
> @@ -864,8 +872,13 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   
>   	uuid_copy(&opts->host->id, &hostid);
>   
> +	if (hostsymname)
> +		strncpy(opts->host->symname, hostsymname,
> +			sizeof(opts->host->symname) - 1);
> +
>   out:
>   	kfree(options);
> +	kfree(hostsymname);
>   	return ret;
>   }
>   
> @@ -957,7 +970,7 @@ EXPORT_SYMBOL_GPL(nvmf_free_options);
>   				 NVMF_OPT_KATO | NVMF_OPT_HOSTNQN | \
>   				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT |\
>   				 NVMF_OPT_DISABLE_SQFLOW | NVMF_OPT_DISCOVERY |\
> -				 NVMF_OPT_FAIL_FAST_TMO)
> +				 NVMF_OPT_FAIL_FAST_TMO | NVMF_OPT_SYMNAME)
>   
>   static struct nvme_ctrl *
>   nvmf_create_ctrl(struct device *dev, const char *buf)
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index c3203ff1c654..494e6dbe233a 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -38,6 +38,7 @@ struct nvmf_host {
>   	struct list_head	list;
>   	char			nqn[NVMF_NQN_SIZE];
>   	uuid_t			id;
> +	char			symname[NVMF_HOSTSYMNAME_SIZE+1];
>   };
>   
>   /**
> @@ -68,6 +69,7 @@ enum {
>   	NVMF_OPT_FAIL_FAST_TMO	= 1 << 20,
>   	NVMF_OPT_HOST_IFACE	= 1 << 21,
>   	NVMF_OPT_DISCOVERY	= 1 << 22,
> +	NVMF_OPT_SYMNAME	= 1 << 23,
>   };
>   
>   /**
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 82567d493c51..3b47951342f4 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -16,6 +16,8 @@
>   /* However the max length of a qualified name is another size */
>   #define NVMF_NQN_SIZE		223
>   
> +#define NVMF_HOSTSYMNAME_SIZE	256
> +
>   #define NVMF_TRSVCID_SIZE	32
>   #define NVMF_TRADDR_SIZE	256
>   #define NVMF_TSAS_SIZE		256

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

