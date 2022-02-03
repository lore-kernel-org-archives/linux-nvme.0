Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1504C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 07:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0bN99d9+EKiFiMLxeo1Rtb8e5DCvVmf/CCwiKPaUVE0=; b=xDSBtykXPlB79FHEUjtkVpvZBu
	rmFJZxMh5zDUr15pLjh8QAtMQn0zzgl7ptykSb6v58m4cOq/2n21aE1WKOFhQCQsA3Oj6cszFU6y8
	EaTkosekHcY8+slbe0JzhiqjEJhqJbTRKmhmRjAsUruGFVTehVcqQmDEtJ7QDlGL0xw2nTHfq4Y/x
	kzxmcRPGWxzpSjRXcPxRqprk9SmW5hhfhHt1h5u58a5yvekdtD8QhKwq1TI2xlW5CI6nNQuqWHIJb
	v+YPszBZe8Tg5MVssm+h94kcK2tpRGYIMkTxq8ojudy9X/1PfH5lh6P0M+TtOuVvLDyvp6Fck0vBV
	sYm0WtbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFWLY-0009g5-8l; Thu, 03 Feb 2022 07:16:00 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFWLV-0009fg-6i
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 07:15:58 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A4C5E1F398;
 Thu,  3 Feb 2022 07:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643872555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0bN99d9+EKiFiMLxeo1Rtb8e5DCvVmf/CCwiKPaUVE0=;
 b=nuNnABfy5MO6GbP2ltMeoXtGnz3MCaSVc3slD1lmoO+dyhUxF/lu3t4Ne8RWv3Nmuozgv4
 hriDIO7IdJDw1M2b3meyaMlx5XlYbGQLWGPIwNE3lZypHrZXagkl9bWqWhgE/rp4ApkE2I
 ge1D8dNRctv/DRXVaFiL3fSn/gq+16Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643872555;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0bN99d9+EKiFiMLxeo1Rtb8e5DCvVmf/CCwiKPaUVE0=;
 b=J9aC+rfbrMyhxbnVoTOwT14DaE3YkQ7ky0TxZXIX1BZ0agmKsoBttunXD8leQUDIzHg1m+
 LIMB516F7g9qhvDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BCDB213310;
 Thu,  3 Feb 2022 07:15:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pECMKimB+2GUcAAAMHmgww
 (envelope-from <hare@suse.de>); Thu, 03 Feb 2022 07:15:53 +0000
Message-ID: <8695b011-96f1-3c1c-72ba-ea4de9780c34@suse.de>
Date: Thu, 3 Feb 2022 08:15:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/2] nvme: send uevent on connection up
Content-Language: en-US
To: Martin Belanger <nitram_67@hotmail.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 stuart_hayes@dell.com, charles_rose@dell.com,
 Martin Belanger <martin.belanger@dell.com>
References: <20220202213451.33599-1-nitram_67@hotmail.com>
 <BL0PR13MB42913A07097FA13CD1B0B1089C279@BL0PR13MB4291.namprd13.prod.outlook.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <BL0PR13MB42913A07097FA13CD1B0B1089C279@BL0PR13MB4291.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220202_231557_420101_2B073A92 
X-CRM114-Status: GOOD (  20.58  )
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

On 2/2/22 22:34, Martin Belanger wrote:
> From: Martin Belanger <martin.belanger@dell.com>
> 
> When connectivity with a controller is lost, the driver will keep trying
> to reconnect once every 10 sec. When connection is restored, user-space
> apps need to be informed so that they can take proper action. For
> example, TP8010 introduces the DIM PDU, which is used to register with
> a discovery controller (DC). The DIM PDU is sent from user-space.  The
> DIM PDU must be sent every time a connection is established with a DC.
> Therefore, the kernel must tell user-space apps when connection is
> restored so that registration can happen.
> 
> The uevent sent is a "change" uevent with environmental data
> set to: "NVME_EVENT=connected".
> 
> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
> ---
>   drivers/nvme/host/core.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 961a5f8a44d2..872c389dc6d3 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4231,6 +4231,13 @@ static int nvme_class_uevent(struct device *dev, struct kobj_uevent_env *env)
>   	return ret;
>   }
>   
> +static void nvme_change_uevent(struct nvme_ctrl *ctrl, char *envdata)
> +{
> +	char *envp[2] = { envdata, NULL };
> +
> +	kobject_uevent_env(&ctrl->device->kobj, KOBJ_CHANGE, envp);
> +}
> +
>   static void nvme_aen_uevent(struct nvme_ctrl *ctrl)
>   {
>   	char *envp[2] = { NULL, NULL };
> @@ -4405,6 +4412,8 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
>   		nvme_queue_scan(ctrl);
>   		nvme_start_queues(ctrl);
>   	}
> +
> +	nvme_change_uevent(ctrl, "NVME_EVENT=connected");
>   }
>   EXPORT_SYMBOL_GPL(nvme_start_ctrl);
>   
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

