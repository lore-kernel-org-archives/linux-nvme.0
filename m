Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7939C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 07:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NJxc7NiFfzoeAk9I2WIKsqMhFFsr/KYXf5dhYvf2ENw=; b=kwYCPOoI5ct8+NOG2gaMBX2kqW
	4wnAwlHwp5n4iugljyVEAkZecypYuV/xKPwQ7hWrmCSMQDuHDEtbN3YsB373/5mPSqNUilbE/eC9y
	Ss0Ab8901j5RwHFiui2jtMGH5FELHLi+qaaJMZN703fxUsO66Gi5FQ5GW24W4YECijzlTsUCSLMFJ
	e5PEqkak6GnhE5ddFW4+ZsV9X6yRn1UW/vtLyxoxd+vLmm8OdWr6RV8seqfdVqd3nbsuFNtAu8EvS
	MgMiOyXzplzuCF/h4WRL7253h9MmWuzT/apcpQJY4A8cD3Zc8A3aTYKKeD5xFbfA9vw+yStEpmX7j
	FyrGW4ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osfaB-00BZZC-Ry; Wed, 09 Nov 2022 07:33:11 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osfa5-00BZY9-DF
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 07:33:06 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B237C2244F;
	Wed,  9 Nov 2022 07:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1667979181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NJxc7NiFfzoeAk9I2WIKsqMhFFsr/KYXf5dhYvf2ENw=;
	b=cSY8bASqrVPqAeKK4tRiGiaz4QvqCC1s3CtNc5AaspKuW9Fc5bikCLhVQgv7You+F25nfI
	TZGvKKPH9a/rpPVQxvN+eWZAmJdoKQJxoSnpF451zyOXVsXh1sgGqUnvZYpqmZdMPIn8pz
	dn9dVOF7DFMcDBN+wQg4YKBfD97AoEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1667979181;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NJxc7NiFfzoeAk9I2WIKsqMhFFsr/KYXf5dhYvf2ENw=;
	b=KSSfEUsEZWD2vJnJEE+LOgZd/wPmtFeHq8Zaac0V4z0KsoKRQTPFsxhNuUseU3G7dkd9uX
	v4d3rYoq0vIQEGBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 934AE139F1;
	Wed,  9 Nov 2022 07:33:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id S8+oIq1Xa2NMNAAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 09 Nov 2022 07:33:01 +0000
Message-ID: <d0aa9900-8289-0312-593a-8b1757a17f0a@suse.de>
Date: Wed, 9 Nov 2022 08:33:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 03/16] nvme-auth: don't re-authenticate if the controller
 is not LIVE
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20221109034420.1000086-1-sagi@grimberg.me>
 <20221109034420.1000086-4-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221109034420.1000086-4-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_233305_613231_0A603C37 
X-CRM114-Status: GOOD (  18.57  )
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
> The connect sequence will re-authenticate.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/auth.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index 734928282d3e..93c0fc71bc7c 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -939,6 +939,13 @@ static void nvme_dhchap_auth_work(struct work_struct *work)
>   		container_of(work, struct nvme_ctrl, dhchap_auth_work);
>   	int ret, q;
>   
> +	/*
> +	 * If the ctrl is no connected, bail as reconnect will handle
> +	 * authentication.
> +	 */
> +	if (ctrl->state != NVME_CTRL_LIVE)
> +		return;
> +
>   	/* Authenticate admin queue first */
>   	ret = nvme_auth_negotiate(ctrl, 0);
>   	if (ret) {

What about a state check in __nvme_auth_work()? That should only be 
called if the queue is not in CONNECTING or LIVE.

Otherwise:
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


