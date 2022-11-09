Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165EEC4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 07:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=krah5v5hQa09AzAQMK67GCqmsjLUCOZSSTAXZJl1k5A=; b=DvWm1veNil2vp4yWr5sTkPP6er
	cOpOMo2EHUlRZzrFWQhJws5mF9c2Cm/NBLtggrg2kljjw0XlIl4XjTHOhzeYrFxSQZTUKszbG6v5i
	99HHmumk5UKh2X6+ZaFkhmQ2nk2H66fxhI+mn4NNks0WwZfHY5lrR16c0oLOYKSRJfDrNhGIR8et8
	R0Qfvtfgqlx06Ef58Y+sf1b5KsQstBC8qUSJHOOv8RsJ1FQbp80Eq5SqZ9Mcone378Pd+LC8GYh6Q
	/WeNgWwGV/O4pE3yl2XPXtFjr0Xk+qBt7tnSG9eezr8d059MtbC1hGmIlmx8NdC1SUVgrV+sKTEFY
	Gc0NCZCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osfcS-00BaA1-60; Wed, 09 Nov 2022 07:35:32 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osfcI-00Ba8c-PO
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 07:35:24 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6B7C722458;
	Wed,  9 Nov 2022 07:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1667979321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=krah5v5hQa09AzAQMK67GCqmsjLUCOZSSTAXZJl1k5A=;
	b=NN8TR2y6lvAK/v+x9avgeixxb8UGInItPoU9Z3SIU5010n5XcW1hxZPSr6ha/270VPlgri
	Cpon0fGmDQM8XhOXrchhcEmCgWO9N4luz6qrzcpToYZX1AdbDjEZpn7YRLkdG0kXQHTN8n
	y/1u7BUwyPhVXUgXW/g72XPTMfqLnPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1667979321;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=krah5v5hQa09AzAQMK67GCqmsjLUCOZSSTAXZJl1k5A=;
	b=8S77V5ZLI3fTYhE3J36U8E8EaZI5OGxfJXan6zpwnPoDaYJY82fU/iOy7bJaZaVzhMvtQf
	ecvqaZI6yvMz1jBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B51B139F1;
	Wed,  9 Nov 2022 07:35:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 5SevETlYa2MCNgAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 09 Nov 2022 07:35:21 +0000
Message-ID: <578e71b7-e5e5-dde4-098c-4770c0b13d1a@suse.de>
Date: Wed, 9 Nov 2022 08:35:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 09/16] nvme-auth: clear sensitive info right after
 authentication completes
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20221109034420.1000086-1-sagi@grimberg.me>
 <20221109034420.1000086-10-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221109034420.1000086-10-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_233523_004267_6AE5E3F2 
X-CRM114-Status: GOOD (  15.36  )
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
> We don't want to keep authentication sensitive info in memory for unlimited
> amount of time.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/auth.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index 201f25267685..484315efa0b2 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -908,6 +908,8 @@ int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
>   		mutex_unlock(&ctrl->dhchap_auth_mutex);
>   		flush_work(&chap->auth_work);
>   		ret = chap->error;
> +		/* clear sensitive info */
> +		nvme_auth_reset_dhchap(chap);
>   		return ret;
>   	}
>   	mutex_unlock(&ctrl->dhchap_auth_mutex);

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


