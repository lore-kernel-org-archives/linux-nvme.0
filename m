Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFE1C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Apr 2022 06:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bV0L58T4D8qkxvm4nzhx9gfxm0m4hoJYAmcq7LXNrc4=; b=k9L3jIAoexZ2/PjXsR3CwoRQId
	bief1TGP6Gvxx3HWBaIwFszNO6SPG0fgGLMgH2OGIShjFpQr0FmPj0fUqg0TbJeVjCZRVeFZXT1gl
	7G1m0O62DY1qImPxTtL6gDtI4jGoLfZueQ/OxDGDmkHXiUOukcz1Q8Hbux8JlEro6HwPrYsfHDNke
	5qIROBYKDXfzzUtGRkGwLcOZ5wHRQphqawhXBmeuA/+uS1TN4gumgwXjNlgaOIcNCPc4xtoHjtTwb
	OknZGs4f8HHXlyTPHvwjlHUsSHjeoZ1ZKLWvBnWTVUgrp264qxkGsmxnI6mgNJRLDZbdRVn5AH1nQ
	tROF/wJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nkJoP-009gSJ-2u; Fri, 29 Apr 2022 06:09:05 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nkJoL-009gQk-Vg
 for linux-nvme@lists.infradead.org; Fri, 29 Apr 2022 06:09:03 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A8E5C210EC;
 Fri, 29 Apr 2022 06:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1651212539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bV0L58T4D8qkxvm4nzhx9gfxm0m4hoJYAmcq7LXNrc4=;
 b=fW11lxxmjs4k0G4jsOkp09Ed/uwV7iZIPAOKeZ5g/JAMskc5nBmUUuaE0BWxzWZtjVXC8+
 BhiQh7q3XYTnPWMKzV8+rhYnUeuyXYmsJUXwtdYRfGuvVn24knP1FOaO7NtZCEiY06sxCe
 +a5Q9e3GHNHNvIaCGA9hq9YH3fMcRo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1651212539;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bV0L58T4D8qkxvm4nzhx9gfxm0m4hoJYAmcq7LXNrc4=;
 b=fg4eM1HcL3bJ2kSiKMu1IhFruEUzSdwYqXYDoafqc3pKJRIlgjrMvIlgZcgQxsYmksiMHy
 MXCdQQWMCUnE6kCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8389313446;
 Fri, 29 Apr 2022 06:08:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CclOH/uAa2IBJwAAMHmgww
 (envelope-from <hare@suse.de>); Fri, 29 Apr 2022 06:08:59 +0000
Message-ID: <e8ea0448-bdb5-3232-d209-35106f9db30e@suse.de>
Date: Fri, 29 Apr 2022 08:08:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/2] nvme: add missing status values to verbose logging
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me, kbusch@kernel.org,
 kch@nvidia.com
References: <20220428091935.35651-1-mgurtovoy@nvidia.com>
 <20220428091935.35651-2-mgurtovoy@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220428091935.35651-2-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220428_230902_231043_6E438CEC 
X-CRM114-Status: GOOD (  13.59  )
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
> The following status values were added: NVME_SC_INTERNAL_PATH_ERROR,
> NVME_SC_CTRL_PATH_ERROR and NVME_SC_HOST_ABORTED_CMD.
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/nvme/host/constants.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
> index 6c2aa8eefb55..1dd1d78de295 100644
> --- a/drivers/nvme/host/constants.c
> +++ b/drivers/nvme/host/constants.c
> @@ -154,10 +154,13 @@ static const char * const nvme_statuses[] = {
>   	[NVME_SC_COMPARE_FAILED] = "Compare Failure",
>   	[NVME_SC_ACCESS_DENIED] = "Access Denied",
>   	[NVME_SC_UNWRITTEN_BLOCK] = "Deallocated or Unwritten Logical Block",
> +	[NVME_SC_INTERNAL_PATH_ERROR] = "Internal Pathing Error",
>   	[NVME_SC_ANA_PERSISTENT_LOSS] = "Asymmetric Access Persistent Loss",
>   	[NVME_SC_ANA_INACCESSIBLE] = "Asymmetric Access Inaccessible",
>   	[NVME_SC_ANA_TRANSITION] = "Asymmetric Access Transition",
> +	[NVME_SC_CTRL_PATH_ERROR] = "Controller Pathing Error",
>   	[NVME_SC_HOST_PATH_ERROR] = "Host Pathing Error",
> +	[NVME_SC_HOST_ABORTED_CMD] = "Host Aborted Command",
>   };
>   
>   const unsigned char *nvme_get_error_status_str(u16 status)

As mentioned, maybe merge with the first patch.
But that's merely cosmetical.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

