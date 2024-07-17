Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73894C3DA42
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 08:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ofViyxpL6E7msZWbqzROq9FMn11Nk20ZmNXXn1UgtsI=; b=Clmo2YMF10bFMB1uZFigWubGEf
	tAvfAtphg/SWyoD3qrjkGfVKXSk4M17pbjsGMmfcwUFDV8nEy7OaaAqqpx6wG4Dbq/pUwJy7UTK/R
	UEs0w5163L2lTpssZrI/De0ZHyaWmLtr3C1PWYImLWjFchmSy01ec//B78sibTGVSSNLt+221aQyQ
	zoQyo3wSqOSCGBForPpz82nfhI/7z1ZCkoYE+oqErdTmpplAXgQbW2SfC8iP5dC1N99EUFp108TcX
	CmzyK15dl893jV77/eVmQBK8QL/ABDw+5ac0nQpPkh5pGF7fp5XT/RuwQ6yB9YXa/kUinkwE6obGd
	oLh90r7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTzts-0000000D707-0OsP;
	Wed, 17 Jul 2024 08:20:36 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTztj-0000000D6vf-3BNm
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 08:20:33 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C0EFC21B31;
	Wed, 17 Jul 2024 08:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721204424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ofViyxpL6E7msZWbqzROq9FMn11Nk20ZmNXXn1UgtsI=;
	b=ZK8i56rxG9z+Jk+UFW8VuaLPpdEmXg+fiL3Jx90mvWYTxqUul2hVia8i4K/2dksMrEz0oD
	uWpdonOQYuyO2cMK29A6gNF9C25gG0WdgGmItKSfWtfaE/GVm/Vsgg/vXsrzcL8L1b/SsB
	bjan8orunFxebz/PGmQXyxir5gH9gm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721204424;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ofViyxpL6E7msZWbqzROq9FMn11Nk20ZmNXXn1UgtsI=;
	b=1LQk6FToY4yiPdrCgvJVkLbvTDi4bcjv3RnvLfdA+J5ULOhBsS4HZNyPqV5uZy1gZflka8
	/ywU4sQ2HRGPVcBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721204424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ofViyxpL6E7msZWbqzROq9FMn11Nk20ZmNXXn1UgtsI=;
	b=ZK8i56rxG9z+Jk+UFW8VuaLPpdEmXg+fiL3Jx90mvWYTxqUul2hVia8i4K/2dksMrEz0oD
	uWpdonOQYuyO2cMK29A6gNF9C25gG0WdgGmItKSfWtfaE/GVm/Vsgg/vXsrzcL8L1b/SsB
	bjan8orunFxebz/PGmQXyxir5gH9gm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721204424;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ofViyxpL6E7msZWbqzROq9FMn11Nk20ZmNXXn1UgtsI=;
	b=1LQk6FToY4yiPdrCgvJVkLbvTDi4bcjv3RnvLfdA+J5ULOhBsS4HZNyPqV5uZy1gZflka8
	/ywU4sQ2HRGPVcBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 967F01368F;
	Wed, 17 Jul 2024 08:20:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TPPUIsh+l2aKEAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 17 Jul 2024 08:20:24 +0000
Message-ID: <0c4c4365-2c2b-4985-bbb1-5d58bf332671@suse.de>
Date: Wed, 17 Jul 2024 10:20:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvmet-tcp: add unbound_wq support for nvmet-tcp
To: Ping Gan <jacky_gam_2001@163.com>, sagi@grimberg.me, hch@lst.de,
 kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com
References: <20240717075208.87324-1-jacky_gam_2001@163.com>
 <20240717075208.87324-2-jacky_gam_2001@163.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240717075208.87324-2-jacky_gam_2001@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.29 / 50.00];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[163.com,grimberg.me,lst.de,nvidia.com,lists.infradead.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_012027_972782_C3FFDB16 
X-CRM114-Status: GOOD (  15.61  )
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

On 7/17/24 09:52, Ping Gan wrote:
> To define a module parameter use_unbound_wq to enable unbound
> workqueue to handle TCP's IO.
> 
> Signed-off-by: jackygam2001 <jacky_gam_2001@163.com>

Please use your real name 'Ping Gan' as the author name, not the mail alias.

> ---
>   drivers/nvme/target/tcp.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 5bff0d5464d1..f71d56843e1a 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -73,6 +73,10 @@ device_param_cb(idle_poll_period_usecs, &set_param_ops,
>   MODULE_PARM_DESC(idle_poll_period_usecs,
>   		"nvmet tcp io_work poll till idle time period in usecs: Default 0");
>   
> +static bool use_unbound_wq;
> +module_param(use_unbound_wq, bool, 0444);
> +MODULE_PARM_DESC(use_unbound_wq, "use unbound workqueue to handle IO request: Default false");
> +
>   #ifdef CONFIG_NVME_TARGET_TCP_TLS
>   /*
>    * TLS handshake timeout
> @@ -2196,9 +2200,13 @@ static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
>   static int __init nvmet_tcp_init(void)
>   {
>   	int ret;
> +	unsigned int flags;
> +
> +	flags = WQ_MEM_RECLAIM | WQ_HIGHPRI;
> +	if (use_unbound_wq)
> +		flags |= (WQ_UNBOUND | WQ_SYSFS);
>   
> -	nvmet_tcp_wq = alloc_workqueue("nvmet_tcp_wq",
> -				WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
> +	nvmet_tcp_wq = alloc_workqueue("nvmet_tcp_wq", flags, 0);
>   	if (!nvmet_tcp_wq)
>   		return -ENOMEM;
>   
Otherwise looks good.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


