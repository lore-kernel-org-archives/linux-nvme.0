Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B0B4C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Apr 2022 06:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OR2mlbGXvex+Ur8/M2ZUrxU/ipW198Lx+3tEpnwnJxY=; b=S7KVqI9F39jMGgZlDrpcbBuJFc
	atirMI1dk5h0Pnd+WJNbLElmhnKb8EUS+kC08/s1sK8a65JyFH15nOdPaGXdgi8MA4U1CKAHoen/f
	LTFxsXWQHdsQbjoLowzuUY8Sx0Zpqp7ghedtPD2x9qx9hwT/kjEe0S0+gAt7Wx1BIDiU/3gZlzAru
	52/2IMVWJ+dPzDaYoNIkYSAR5mTBm8jGGR0uvyqN0F8z7K8pEebg/hP8no0doPIOxTtPPbKnf0XPE
	A05G7E01rnsDJseZvg+k1tDaMhghTbAUXTV6e+SbFLV7MSpmZOy2nVAmzPefoC0OmC6vsYqOoRbvT
	fU0PVkdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nkJp5-009gja-ST; Fri, 29 Apr 2022 06:09:47 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nkJp2-009ghR-8O
 for linux-nvme@lists.infradead.org; Fri, 29 Apr 2022 06:09:45 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0735D1F891;
 Fri, 29 Apr 2022 06:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1651212583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OR2mlbGXvex+Ur8/M2ZUrxU/ipW198Lx+3tEpnwnJxY=;
 b=qnPUVWkDltpX2sKie9rx3eLj8iYmRudYV1mA9+sL6yEBpOvPzYVRAR/ajVAJ5sWxAMbhTB
 ILN7sSqWcjFsmLEk5lqFFYxz81pWKeg9jp4yXt7nH7iaOHVpeyktuyx2tZbKdUZCIoDsYK
 /BRcGK9BoU2hqpoYPEPpZWOitabQjP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1651212583;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OR2mlbGXvex+Ur8/M2ZUrxU/ipW198Lx+3tEpnwnJxY=;
 b=VcEjeMTSjyzLrErPqA3/PfEuHBov/N3x0wCUEar/jyndg4LhbcGpGLl4oCbgEozG9vXwRW
 kcEVuTEz8F2aT4Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E0AE113446;
 Fri, 29 Apr 2022 06:09:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5IgkNSaBa2I3JwAAMHmgww
 (envelope-from <hare@suse.de>); Fri, 29 Apr 2022 06:09:42 +0000
Message-ID: <3fbe6180-bed9-6b2d-24a1-d62d8413aa76@suse.de>
Date: Fri, 29 Apr 2022 08:09:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] nvme: return BLK_STS_OK on success in nvme_setup_rw
Content-Language: en-US
To: Vincent Fu <vincent.fu@samsung.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Pankaj Raghav <p.raghav@samsung.com>, Sagi Grimberg <sagi@grimberg.me>
References: <CGME20220427191045uscas1p2cff082022143327c9d6bfdf39e4eb861@uscas1p2.samsung.com>
 <20220427190933.627688-1-vincent.fu@samsung.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220427190933.627688-1-vincent.fu@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220428_230944_503891_5D70BC70 
X-CRM114-Status: GOOD (  16.05  )
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

On 4/27/22 21:10, Vincent Fu wrote:
> Return BLK_STS_OK instead of 0 on success. Since BLK_STS_OK is defined
> as 0 this patch results in no functional change but to avoid confusion
> and to be consistent with nvme_setup_write_zeroes as well as
> nvme_setup_discard we should have nvme_setup_rw also return BLK_STS_OK.
> 
> Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
> Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> v1 -> v2:
>    - improved commit message first line
>    - added reviewed-by tags
> 
>   drivers/nvme/host/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index b9b0fbde9..f45665e36 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -895,7 +895,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
>   
>   	cmnd->rw.control = cpu_to_le16(control);
>   	cmnd->rw.dsmgmt = cpu_to_le32(dsmgmt);
> -	return 0;
> +	return BLK_STS_OK;
>   }
>   
>   void nvme_cleanup_cmd(struct request *req)

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

