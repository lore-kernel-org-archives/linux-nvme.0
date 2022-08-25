Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4F3ECAA24
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Aug 2022 16:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=th/or4g7W57Lyf14YGkVOmOrxbKzEluiluQl5ULRaLY=; b=fKA1nI1oQsriOcvOAK+9hYzaon
	m6c+iL0J6DlFz+fzUM4VL/gZFTw2zj1gVx9nR/f0VWJylzIvmB6JDirxlNU1JHfASZDwMM34EbUII
	i6htFZyrIrTf71+VByfYP3V2ix23N7Pp4w9rvJ8PnHHkAwC3hNgG4gp3Eg1rGLEPqQFxyi1ve3Eam
	dGThThXhWcqamGxdh21s+iU1tCu0Vkg7Ld384ZP2ychtAkT1jYSm6Sdkl5vPPlreSv3HL+hv0ZQ7X
	iNkXsFsHK7DIpBxtnN+Lbg+1txdmxK0y6SldoFyFpg2Bpvyi+zhj4wOcXy7MmngsSsKw0DjP47+Uo
	5h28V4gA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRFag-00GAO7-B1; Thu, 25 Aug 2022 16:20:22 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRFad-00GAKM-ES
	for linux-nvme@lists.infradead.org; Thu, 25 Aug 2022 16:20:20 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E99565BE07;
	Thu, 25 Aug 2022 16:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1661444413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=th/or4g7W57Lyf14YGkVOmOrxbKzEluiluQl5ULRaLY=;
	b=ShRWD3Q+sozdoYa2aiZo3XwX8Hb29hKCLa6PD0I+YfJbDIBugKJb8ECGe7gF90ljOkC985
	nEO+CMGmZTkSyEuGJK1ek5Tc0WV6w9sr4zjdZQPUstY0bTTkUtLF6wZNtjtXpwewHgdbZV
	SXq0nvwV9Dh8VLVUDDWXOE0Osu1M+/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1661444413;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=th/or4g7W57Lyf14YGkVOmOrxbKzEluiluQl5ULRaLY=;
	b=40jFQxNfHOBxOlT939WrBXvrSPinCALvMK8qJKulhQp4lGLBIRgwVlOFGlAcUJuA7Oxxe4
	WN9jgv2rv1hEnODA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C720213517;
	Thu, 25 Aug 2022 16:20:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id oc3ALD2hB2OsegAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 25 Aug 2022 16:20:13 +0000
Message-ID: <ea632332-d26b-6d1f-b45d-9971902a2ebb@suse.de>
Date: Thu, 25 Aug 2022 18:20:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/3] nvmet: Expose max queues to sysfs
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>
References: <20220823074451.12170-1-dwagner@suse.de>
 <20220823074451.12170-2-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220823074451.12170-2-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220825_092019_666081_DE7230F2 
X-CRM114-Status: GOOD (  20.05  )
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

On 8/23/22 09:44, Daniel Wagner wrote:
> Allow to set the max queues the target supports. This is useful for
> testing the reconnect attempt of the host with chaning numbers of
> supported queues.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/target/configfs.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 2bcd60758919..ba9f3209f848 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -1281,6 +1281,30 @@ static ssize_t nvmet_subsys_attr_pi_enable_store(struct config_item *item,
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
> +	if (sscanf(page, "%hu\n", &qid_max) != 1)
> +		return -EINVAL;
> +
> +	if (qid_max == 0)
> +		return -EINVAL;
> +
> +	down_write(&nvmet_config_sem);
> +	to_subsys(item)->max_qid = qid_max;
> +	up_write(&nvmet_config_sem);

I would have expected this to trigger a reconnect; as it stands it 
requires the user to explicitly do a reconnect via nvme-cli, and there's 
a fair chance the number of queues will be specified there.
Hmm?

> +	return cnt;
> +}
> +CONFIGFS_ATTR(nvmet_subsys_, attr_qid_max);
> +
>   static struct configfs_attribute *nvmet_subsys_attrs[] = {
>   	&nvmet_subsys_attr_attr_allow_any_host,
>   	&nvmet_subsys_attr_attr_version,
> @@ -1291,6 +1315,7 @@ static struct configfs_attribute *nvmet_subsys_attrs[] = {
>   #ifdef CONFIG_BLK_DEV_INTEGRITY
>   	&nvmet_subsys_attr_attr_pi_enable,
>   #endif
> +	&nvmet_subsys_attr_attr_qid_max,
>   	NULL,
>   };
>   

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

