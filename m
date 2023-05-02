Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF14AC77B73
	for <linux-nvme@archiver.kernel.org>; Tue,  2 May 2023 06:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KIRo/ALlJ2nGuaiHB6iOXycW64f648vlneLfnJUUcGo=; b=CauGipCqvFEjW6UFZ/vwzl5i9Y
	WyF9u+GZTplvrohusFkTP8tS+KPZKr6dPi+nq+i8Nfe3mgYXHSiY8yL4rXEXQ8gUIvzojwRCmmhCU
	haQSSaDQJQgJI0tBlvJOQNhdEL1EhtHbDI8Pk6LzsfMItWcVr7txS0BZFgOzsuNIcC0vc8bVzNpXY
	mPaPGOb05wh51yE3YxXypq+YLdsPlWHfyUdljlID3PPnuzrzIdP8qHMYbPpkh6OuaCI2vgNPedunw
	PbkHFXe9FcfrCuWUID+o3bbHKUmxyIBW4EleT8Kdk7gvAtrZH7D7u9vTcTR9WW6UuD7/apZ72gnbF
	S993bjQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptjEe-000Ipf-0p;
	Tue, 02 May 2023 06:11:36 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptjEa-000Iow-1c
	for linux-nvme@lists.infradead.org;
	Tue, 02 May 2023 06:11:33 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 97CCB1F74A;
	Tue,  2 May 2023 06:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683007890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KIRo/ALlJ2nGuaiHB6iOXycW64f648vlneLfnJUUcGo=;
	b=XK5NYVxZNzTBHe+GhHvoMZfg/zMfD7tY7g8La52fk1bTXa0wzg92TwTeeKzDj2ER5xvgvy
	bd4KV+27wcW8gIiX01GuWTzhL8ydiUQF7tqqJ/NXNJELXB0Bc1oHhlWX13ANVCeou90IfQ
	9W6Uy0tmt2fNU/P3q6KlzV16iOOaoX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683007890;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KIRo/ALlJ2nGuaiHB6iOXycW64f648vlneLfnJUUcGo=;
	b=eobv8rA7fJIdKO7dKB+B2dXSxkEIAZ81vvP7dSri5Pq2/R7G4aW6uIAPv0ZojIxXeXECgr
	FxMHdpKm2oAggEAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70C96134FB;
	Tue,  2 May 2023 06:11:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Q/SSGpKpUGTrawAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 02 May 2023 06:11:30 +0000
Message-ID: <36388510-a053-14f6-654b-98317843f290@suse.de>
Date: Tue, 2 May 2023 08:11:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH 1/2] nvme-core: factor out common code into helper
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
References: <20230427080207.17249-1-kch@nvidia.com>
 <20230427080207.17249-2-kch@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230427080207.17249-2-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_231132_705939_ACD82765 
X-CRM114-Status: GOOD (  15.87  )
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
> nvme_ctrl_dhchap_secrete_store() & nvme_ctrl_dhchap_ctrl_secret store()
> share common code. Instead of repeating code into two functions factor
> out into helper function.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/core.c | 85 +++++++++++++++-------------------------
>   1 file changed, 31 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 44408c0c1762..171ae1f2197a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3779,6 +3779,7 @@ static ssize_t dctype_show(struct device *dev,
>   static DEVICE_ATTR_RO(dctype);
>   
>   #ifdef CONFIG_NVME_AUTH
> +
>   static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
>   		struct device_attribute *attr, char *buf)
>   {
> @@ -3790,41 +3791,40 @@ static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
>   	return sysfs_emit(buf, "%s\n", opts->dhchap_secret);
>   }
>   
> -static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
> -		struct device_attribute *attr, const char *buf, size_t count)
> +static ssize_t nvme_dhchap_secret_store_common(struct nvme_ctrl *ctrl,
> +		char **dhchap_secret, struct nvme_dhchap_key **orig_key,
> +		const char *buf, size_t count)

Hmm. I'm _not_ a big fan of using double pointer in arguments; is always
feels to me like using the wrong abstraction.
Can't you just pass in the ctrl and use a 'bool' variable to switch 
between host and controller secret?
Interface is _far_ cleaner, and the resulting code will be, too, as we 
don't have to deal with pointer variables all the time ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


