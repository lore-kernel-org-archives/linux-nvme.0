Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12958ECAAD5
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Aug 2022 09:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e2piUmCvjezYkVv37eL1/W71897LTJov3uvI5Lv/KIQ=; b=cM2MJbHMEVBX1+kenHSr73AjrM
	PKjd9dlR8q6qBF/HeHQa339QqoTyRfGuH4vjxtsJnnDuvPqId8e7S++ugjMA/RAQ0dWnn1bqQU1z7
	O9WwgAtXaCautpjs6cewTlDiZX2FdW3CWb3WlsWd8zCRiTzaKJMJCeLcep0rT7JPLz4xXmUOg5J9B
	3RA9w6Ud7sbLCsMW6dEJ4eRcUOGFtBGlWn+cx8FjYa8ryRoVtLw6eN7rq+XJZo25uXGh51Vgl79hS
	mX63KR1jkFBIOYZBOgC2EfKsuTr1Ik50R2cXKNpFoLj0mWiWZ2EpYHrCU3ehA6izteZ4J8SyQIl5N
	rPgwEa4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSaik-006WJU-UG; Mon, 29 Aug 2022 09:06:14 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSaig-006WFI-3e
	for linux-nvme@lists.infradead.org; Mon, 29 Aug 2022 09:06:11 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 87F4D336E7;
	Mon, 29 Aug 2022 09:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1661763966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e2piUmCvjezYkVv37eL1/W71897LTJov3uvI5Lv/KIQ=;
	b=rVs4RA2dtwFxKgQ2ThK7xqmquQD5egV3oEqrXZbsyEst9vNrXd3keXL2i7qNZVMnfJxWO3
	q21LIGj9gy+NUehIla/rImet2c9asZdEexQkW916hxUR4vTEpBouv1grjyw0Kr4wbF8JYM
	hRjJKbAbcGThtQRb24QC+LweNF7eBzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1661763966;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e2piUmCvjezYkVv37eL1/W71897LTJov3uvI5Lv/KIQ=;
	b=kMst4v+WNrlEVIM3/hrPeTCVG6uZKJDFneZH8lOptqC6XLYHIdMp+nkEsRTl4XkEnxZzU6
	9lrpbz3s5ezG2OCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7089E1352A;
	Mon, 29 Aug 2022 09:06:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 0TjFGn6BDGMRIAAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 29 Aug 2022 09:06:06 +0000
Message-ID: <d93ede38-f2b0-9731-3889-a27de65d3530@suse.de>
Date: Mon, 29 Aug 2022 11:06:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/3] nvmet: Expose max queues to sysfs
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>
References: <20220829083856.1850-1-dwagner@suse.de>
 <20220829083856.1850-2-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220829083856.1850-2-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_020610_339496_7018AD87 
X-CRM114-Status: GOOD (  19.08  )
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

On 8/29/22 10:38, Daniel Wagner wrote:
> Allow to set the max queues the target supports. This is useful for
> testing the reconnect attempt of the host with changing numbers of
> supported queues.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/target/configfs.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 2bcd60758919..a415c2987393 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -1281,6 +1281,33 @@ static ssize_t nvmet_subsys_attr_pi_enable_store(struct config_item *item,
>   CONFIGFS_ATTR(nvmet_subsys_, attr_pi_enable);
>   #endif
>   
> +static ssize_t nvmet_subsys_attr_qid_max_show(struct config_item *item,
> +					      char *page)
> +{
> +	return snprintf(page, PAGE_SIZE, "%u\n", to_subsys(item)->max_qid);
> +}
> +
> +static ssize_t nvmet_subsys_attr_qid_max_store(struct config_item *item,
> +					       const char *page, size_t cnt)
> +{
> +	u16 qid_max;
> +
> +	if (nvmet_is_port_enabled(port, __func__))
> +		return -EACCES;
> +
> +	if (sscanf(page, "%hu\n", &qid_max) != 1)
> +		return -EINVAL;
> +
> +	if (qid_max < 1 || qid_max > NVMET_NR_QUEUES)
> +		return -EINVAL;
> +
> +	down_write(&nvmet_config_sem);
> +	to_subsys(item)->max_qid = qid_max;
> +	up_write(&nvmet_config_sem);
> +	return cnt;
> +}
> +CONFIGFS_ATTR(nvmet_subsys_, attr_qid_max);
> +
>   static struct configfs_attribute *nvmet_subsys_attrs[] = {
>   	&nvmet_subsys_attr_attr_allow_any_host,
>   	&nvmet_subsys_attr_attr_version,
> @@ -1291,6 +1318,7 @@ static struct configfs_attribute *nvmet_subsys_attrs[] = {
>   #ifdef CONFIG_BLK_DEV_INTEGRITY
>   	&nvmet_subsys_attr_attr_pi_enable,
>   #endif
> +	&nvmet_subsys_attr_attr_qid_max,
>   	NULL,
>   };
>   
Minor nit: I would add the new field prior to the 'ifdef' stuff; as it 
stands the layout of the resulting structure changes depending on the 
configuration, which tends to cause all sorts of issues for distributions.
But otherwise:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

