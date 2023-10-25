Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BADC0032E
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Oct 2023 06:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2eyOR2CFpv/SAhARfMtejZArreUBoESwDX44f/FHnOw=; b=2QkK9sfWJCYjq0HgmgNFpVGLDS
	oynRcn099HpkF8i6CIvt8TPCPGNTbwl5qAmzljlApM71LLaEax51xPQbdkCYbXo0Q5hY/k4oB3oCN
	Ptd8L/R/zXPXzgwaeZzd01orZ+aZL3EYA76uUqK7xYJ4IG0usi5Ob032sjVOLj5Rwo56FoKZtsRLi
	pgf4iqSDPAD3mibw2MJ5KCOhZ++3X8oqadZilopSH31YIniGJ2Skc9+o/7Laf1BBsPUyFt7u9sJWP
	lVj3u2hIbHSDl7fDNQ5FmtHXn3VmYY5uSe+5F6h++5b6acrOdKWmpBX9C49QEEH62BKF85YPBMrxF
	KyCqePIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvXRP-00BUaG-1O;
	Wed, 25 Oct 2023 06:32:31 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvXRL-00BUZi-1c
	for linux-nvme@lists.infradead.org;
	Wed, 25 Oct 2023 06:32:28 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6E99E21B76;
	Wed, 25 Oct 2023 06:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1698215543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2eyOR2CFpv/SAhARfMtejZArreUBoESwDX44f/FHnOw=;
	b=geDW+yukR0pNPAkq5m4OBL38aZpFkPZ9dTyCurn2QuSV4rPyLYQMp5M67vZQPoRE5KIulK
	rrMFQOfeXaI1o8lhmMwrgghuKimDteFZm8gJ8QG1h3nLpUflAujUKLTu+0kPHE8UZf/nKb
	mP8qEx3AOPcaLmet5gbraFtoHzCK9kY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1698215543;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2eyOR2CFpv/SAhARfMtejZArreUBoESwDX44f/FHnOw=;
	b=yIz5+o3L/6NzeLJe9P4++SG8CF2S0C1vvsAUhuphn6srmT6JN3iq3DKPe2NjZ+jIDkuxkf
	2ycmGrg9+kuHB4Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3561C13524;
	Wed, 25 Oct 2023 06:32:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id w66hC3e2OGV+RQAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 25 Oct 2023 06:32:23 +0000
Message-ID: <cdaae245-89ef-486c-958b-83c9d358e47d@suse.de>
Date: Wed, 25 Oct 2023 08:32:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] nvme-auth: always set valid seq_num in dhchap
 reply
Content-Language: en-US
To: Mark O'Donovan <shiftee@posteo.net>, linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@kernel.dk, kbusch@kernel.org
References: <20231023140003.58019-1-shiftee@posteo.net>
 <20231023140003.58019-4-shiftee@posteo.net>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231023140003.58019-4-shiftee@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-7.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231024_233227_704492_E83D2BF4 
X-CRM114-Status: GOOD (  18.97  )
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

On 10/23/23 16:00, Mark O'Donovan wrote:
> Currently a seqnum of zero is sent during uni-directional
> authentication. The zero value is reserved for the secure channel
> feature which is not yet implemented.
> 
> Relevant extract from the spec:
> The value 0h is used to indicate that bidirectional authentication
> is not performed, but a challenge value C2 is carried in order to
> generate a pre-shared key (PSK) for subsequent establishment of a
> secure channel
> 
> Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
> 
> ---
> v1: used incorrect prefix nvme-tcp
> v2: added spec extract to commit message
> 
>   drivers/nvme/host/auth.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index 8558a02865ac..7f6b2e99a78c 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -316,15 +316,14 @@ static int nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
>   		chap->bi_directional = true;
>   		get_random_bytes(chap->c2, chap->hash_len);
>   		data->cvalid = 1;
> -		chap->s2 = nvme_auth_get_seqnum();
>   		memcpy(data->rval + chap->hash_len, chap->c2,
>   		       chap->hash_len);
>   		dev_dbg(ctrl->device, "%s: qid %d ctrl challenge %*ph\n",
>   			__func__, chap->qid, (int)chap->hash_len, chap->c2);
>   	} else {
>   		memset(chap->c2, 0, chap->hash_len);
> -		chap->s2 = 0;
>   	}
> +	chap->s2 = nvme_auth_get_seqnum();
>   	data->seqnum = cpu_to_le32(chap->s2);
>   	if (chap->host_key_len) {
>   		dev_dbg(ctrl->device, "%s: qid %d host public key %*ph\n",

I guess you'll need to fix up nvmet, too, as this currently ignores 's2' 
when 'cvalid' is false.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


