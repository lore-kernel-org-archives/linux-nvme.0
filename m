Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE65C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 17:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N4VW1Zg9bvpwhqVDg3j5HU+EbFNLQLlDebsNWLI2yT0=; b=Gc/Ub8qO+FnMDTfdq7QbcHakMi
	3iCeKa0XTQkM66XhRjD+B02EP1DbHxuU/5WazaUu/BcECnUpe2+Ma3iFz+jVthy3d4kZ3/Rk3ycPQ
	PB41bgxQg4w0MSf3JCBl5pu07369SW6DzfrypCMidSc1d7i529F9kwUJXNOlXCbkxFk5TErelPIkD
	TR1PDrqahuSGm2pTeZL/cN/CgQwwl5MKPCbNga1Wt8IUoJqcb4GJm2WGH3ZiqZMdTRGigxfW1NlYF
	3tnEOp1wMP1hrxC0WhBX8fFgV63GfkMdQHXcTiJe9Izgm+VUQBFTRpNRNrPRM4KoF+NrhT0GJ9y93
	nRV9gvNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osp4h-00Ff6G-Te; Wed, 09 Nov 2022 17:41:19 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osp4f-00Ff1z-9t
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 17:41:18 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 10E7622C5D;
	Wed,  9 Nov 2022 17:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1668015676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N4VW1Zg9bvpwhqVDg3j5HU+EbFNLQLlDebsNWLI2yT0=;
	b=bJ7pL7vJC2c7CRK8TuHGaUFvYfiRXHkddeTMJ97Kb/P9wCw3RanOxfr+egMmh+1hu3mqqf
	3h8wH+tYcM2ke1MGIt92Z5HkigKk43qNeUA556pYPpcRl/aHwokuHszrWQVQsdAEswy1qi
	zA3Vp7H4IQziakrjjNRIC8/7bst3Cx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1668015676;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N4VW1Zg9bvpwhqVDg3j5HU+EbFNLQLlDebsNWLI2yT0=;
	b=Rf/YfQmxtwgA04LkgSRf0tRvGLMe41n6ecIV9+U4Xi7Y6MtDkOhE9LBkjxGVdS/73ITyRM
	eAePSEdgG4vUJYBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6758139F1;
	Wed,  9 Nov 2022 17:41:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id lhSPNzvma2PSGQAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 09 Nov 2022 17:41:15 +0000
Message-ID: <b76a600d-b33c-a0ee-64d3-3077b5fb7b62@suse.de>
Date: Wed, 9 Nov 2022 18:41:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 13/16] nvme-auth: remove redundant auth_work flush
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20221109034420.1000086-1-sagi@grimberg.me>
 <20221109034420.1000086-14-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221109034420.1000086-14-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221109_094117_513311_71FB330B 
X-CRM114-Status: GOOD (  17.11  )
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

On 11/9/22 04:44, Sagi Grimberg wrote:
> only ctrl deletion calls nvme_auth_free, which was stopped prior in the
> teardown stage, so there is no possibility that it should ever run when
> nvme_auth_free is called.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/auth.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index b78e0df54f6c..0159179c2455 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -988,10 +988,8 @@ void nvme_auth_free(struct nvme_ctrl *ctrl)
>   	struct nvme_dhchap_queue_context *chap;
>   	int i;
>   
> -	nvme_foreach_dhchap(i, chap, ctrl) {
> -		flush_work(&chap->auth_work);
> +	nvme_foreach_dhchap(i, chap, ctrl)
>   		nvme_auth_free_dhchap(chap);
> -	}
>   	if (ctrl->host_key) {
>   		nvme_auth_free_key(ctrl->host_key);
>   		ctrl->host_key = NULL;

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


