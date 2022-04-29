Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADAC9C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Apr 2022 06:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uyMNeKKGemBPg6GKQcotBIhntBmnZC9QI3DnQna6bhU=; b=z7SLpRaGLlcnNVSmQEoHxEu595
	YtNAKq29BfM2yaSEFW7WUigNmA6dnj2D6iOmP+b2WksIIFAo/vWjHsKeFF/wTABBj39Vb2iJQELv4
	LPNY5PV71/NZm3wyd41QquHo7dntODq6T7KI8XBzbPgLTkfA5YVx+3g/8SPEv4hrpkMA9YnWxdHl6
	V9M0ncNDbF0jflwx6EFXle8ZEb3ydWqZYI/RfQLN6Okk82hnmEKvtPnWGt387+Km88bvtUWCqsGhm
	x2gmw62kB/9btZXq3H3ms0DFTDbn7PUt1GYYyeg8O98IhxG7hH2OiR6+wX+gkvbLTr8F6V1CECcWX
	2d7SLA0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nkJnh-009gIr-TL; Fri, 29 Apr 2022 06:08:21 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nkJnf-009gI9-AB
 for linux-nvme@lists.infradead.org; Fri, 29 Apr 2022 06:08:20 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5C91C1F37F;
 Fri, 29 Apr 2022 06:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1651212495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uyMNeKKGemBPg6GKQcotBIhntBmnZC9QI3DnQna6bhU=;
 b=kwTxx5YKjPEzLw99mJyBTBKH2Az/K4qJhvHzd/tA768CnYDvoiMu6wmw0r5NnvL1hYii3C
 FMvtGGL3qZlyhZzvqGmrFA71IJ+eY8Qk7OxT3j32nqPDqmLcd8pZrWNiMvS2avwowP3E6h
 KPRD4N2nURpoVitEhA1bgiTQjtnZh2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1651212495;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uyMNeKKGemBPg6GKQcotBIhntBmnZC9QI3DnQna6bhU=;
 b=UJJ9u1ECh4XH3aO3z7tRKwEwwrhvsXBVoktsxq2DxtA++nJK/6zE+JNVJQGFaqD7y7EtDC
 j3c27vl3AU6wecDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A74113446;
 Fri, 29 Apr 2022 06:08:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9NhsDc+Aa2LGJgAAMHmgww
 (envelope-from <hare@suse.de>); Fri, 29 Apr 2022 06:08:15 +0000
Message-ID: <40fad37d-a330-2269-c4af-dd8c80efd308@suse.de>
Date: Fri, 29 Apr 2022 08:08:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/2] nvme: add missing path related status values
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me, kbusch@kernel.org,
 kch@nvidia.com
References: <20220428091935.35651-1-mgurtovoy@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220428091935.35651-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220428_230819_541134_53D067A3 
X-CRM114-Status: GOOD (  13.39  )
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

On 4/28/22 11:19, Max Gurtovoy wrote:
> The following path related status code from the NVM specification were
> added: Internal Path Error (00h) and Controller Pathing Error (60h).
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   include/linux/nvme.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index f626a445d1a8..bbabdc7600da 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -1679,9 +1679,11 @@ enum {
>   	/*
>   	 * Path-related Errors:
>   	 */
> +	NVME_SC_INTERNAL_PATH_ERROR	= 0x300,
>   	NVME_SC_ANA_PERSISTENT_LOSS	= 0x301,
>   	NVME_SC_ANA_INACCESSIBLE	= 0x302,
>   	NVME_SC_ANA_TRANSITION		= 0x303,
> +	NVME_SC_CTRL_PATH_ERROR		= 0x360,
>   	NVME_SC_HOST_PATH_ERROR		= 0x370,
>   	NVME_SC_HOST_ABORTED_CMD	= 0x371,
>   
I would merge both patches.
However:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

