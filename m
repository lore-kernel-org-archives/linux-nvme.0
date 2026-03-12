Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43C9FED2D1
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2026 07:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TviuH9EI+WIGFqvp+UyLEGozh3ipB+pJsqlZ0Fxs8LA=; b=RTpx3BLdSJpl9/iqeQkuuFflCN
	t2/isUMczIabmagG1Zd/UnXE3khvc3dw+DWTW8ABxdoXltjP/CBLuiYVnlzBLgZh/F4V7VwNHrus2
	bC6D7q22edzR21S+gf7n53nJWaWnVoH2GF3sULbgdOYPpSSxumUoEFq31GmWwUbNmPFesf4j1cz2e
	ksf1FCWImwaQYk0RWzjDz2J6F3H75IFrt+keTXmKkQ87PYTFT1tGhLTdC3B3vkT9SNyfK7GQ35j6H
	Gv0H9jbErvrNWaM5XsCumkLtSlpzQ4IQDummxcloGOcv1BNuN3rp2Ixl/EXcy0C9zU+NZPx4n1uPp
	sZzy/oow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0a3M-0000000DVjv-4Bxc;
	Thu, 12 Mar 2026 07:01:53 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0a3J-0000000DVjX-2ZSb
	for linux-nvme@lists.infradead.org;
	Thu, 12 Mar 2026 07:01:51 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED9DA5BD08;
	Thu, 12 Mar 2026 07:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773298907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TviuH9EI+WIGFqvp+UyLEGozh3ipB+pJsqlZ0Fxs8LA=;
	b=uLODKJz99dO1g5+O1kiL7PtIBbYSFplZRBbWdTVaEJlcSfRQwluEfoZBU4CDu6i+A5rldr
	c1wH0fZFOUpBfG/Iu0FO1sXr/E6kJIEsxrwh9NqURPcmMjnmVNJpxjREKSjVOgblA0JSgQ
	7NpYVliNkTAAGO7HYFTW00ybxG41WJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773298907;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TviuH9EI+WIGFqvp+UyLEGozh3ipB+pJsqlZ0Fxs8LA=;
	b=WIKPA0o1lE4hfzKM+34DsHkLPytf27DpRNt3oTDeDfWLIPz9XGDv6xUJ9ur4mbYL7vQ9Fq
	Ab3/21o03LVeXmBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ipbQmpVH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="em6F4/pk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773298906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TviuH9EI+WIGFqvp+UyLEGozh3ipB+pJsqlZ0Fxs8LA=;
	b=ipbQmpVH1Dhpg/g41VKn5eLHob6M6x/aboKI13RSvbJfcrTii5GwX/jMaqE/w4oVmvO+Ze
	ChEMQyQ1OY/5FgZpKPnLeizaceNc5xxf7iLuPg0Woo85ccZn1A9UeguWpjDYQaadFsUqc3
	goZJCymZQB+Uh6GqdRitFTCtq0YBCRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773298906;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TviuH9EI+WIGFqvp+UyLEGozh3ipB+pJsqlZ0Fxs8LA=;
	b=em6F4/pkQY52n9xEGmeSEP1Nun3JlpsNZ3rkJVb+0J9tlCvlZ1ktZ29tSnPE/Hduj8aiwX
	LYyDlEalHuVkWtBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83AF93FE42;
	Thu, 12 Mar 2026 07:01:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vhInHdpksmnwDQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 12 Mar 2026 07:01:46 +0000
Message-ID: <ec03d5ca-a26d-4427-823a-17c5709391f7@suse.de>
Date: Thu, 12 Mar 2026 08:01:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: auth: validate dhchap id list lengths(KASAN:
 slab-out-of-bounds)
To: yunje shin <yjshin0438@gmail.com>, Chris Leech <cleech@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>,
 Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 ioerts@kookmin.ac.kr
References: <20260211065925.2878336-1-ioerts@kookmin.ac.kr>
 <CAMX6_QEQ0MZTPv3+ma6cESW6sXrzHSNttoRTY5wNf9p98caa8A@mail.gmail.com>
 <CAMX6_QGn=0riCV+DZewc98b+AAdemj8ani9bQg-T+epFC5kAhw@mail.gmail.com>
 <CAMX6_QH7xiTxLbF4pZHVs9Umw=j70c-dmb3t97c6XBEEEg-kpA@mail.gmail.com>
 <20260309-scalding-propeller-e00bf0af6519@redhat.com>
 <CAMX6_QHe04XZR9s_eD8vg0njhkvLn4B+Xx2cW4R1gcKZFsw4TQ@mail.gmail.com>
 <CAMX6_QG_Xx=1shB+76GKdMyB3-JW9nRiC+1vik=382FyFCT9cg@mail.gmail.com>
 <20260310-ladle-underuse-50f571ba519c@redhat.com>
 <CAMX6_QE64ttVQ03CQP4ULECePiTwooy6OfqUk4_biz+_s=vpbA@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAMX6_QE64ttVQ03CQP4ULECePiTwooy6OfqUk4_biz+_s=vpbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: ED9DA5BD08
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_000150_024148_4D91AA40 
X-CRM114-Status: GOOD (  16.01  )
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

On 3/10/26 20:06, yunje shin wrote:
> Thank you for the clarification regarding the 64-byte structural
> constraints. If this approach looks good to you, I will format it
> properly with an updated commit message and send out a formal v2
> patch.
> 
> diff --git a/drivers/nvme/target/fabrics-cmd-auth.c
> b/drivers/nvme/target/fabrics-cmd-auth.c
> index 5946681cb0e3..acba4878a873 100644
> --- a/drivers/nvme/target/fabrics-cmd-auth.c
> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> @@ -72,6 +72,14 @@ static u8 nvmet_auth_negotiate(struct nvmet_req
> *req, void *d)
>        NVME_AUTH_DHCHAP_AUTH_ID)
>    return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
> 
> + /*
> + * idlist[0..29]: hash IDs
> + * idlist[30..59]: DH group IDs
> + */
> + if (data->auth_protocol[0].dhchap.halen > NVME_AUTH_DHCHAP_MAX_HASH_IDS ||
> +     data->auth_protocol[0].dhchap.dhlen > NVME_AUTH_DHCHAP_MAX_DH_IDS)
> + return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
> +
>    for (i = 0; i < data->auth_protocol[0].dhchap.halen; i++) {
>    u8 host_hmac_id = data->auth_protocol[0].dhchap.idlist[i];
> 
> @@ -97,7 +105,7 @@ static u8 nvmet_auth_negotiate(struct nvmet_req
> *req, void *d)
>    dhgid = -1;
>    fallback_dhgid = -1;
>    for (i = 0; i < data->auth_protocol[0].dhchap.dhlen; i++) {
> - int tmp_dhgid = data->auth_protocol[0].dhchap.idlist[i + 30];
> + int tmp_dhgid = data->auth_protocol[0].dhchap.idlist[i +
> NVME_AUTH_DHCHAP_MAX_HASH_IDS];
> 
>    if (tmp_dhgid != ctrl->dh_gid) {
>    dhgid = tmp_dhgid;
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index b09dcaf5bcbc..ea0393ab16fc 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -1824,6 +1824,8 @@ struct nvmf_auth_dhchap_protocol_descriptor {
>    __u8 dhlen;
>    __u8 idlist[60];
>   };
> +#define NVME_AUTH_DHCHAP_MAX_HASH_IDS 30
> +#define NVME_AUTH_DHCHAP_MAX_DH_IDS 30
> 
>   enum {
>    NVME_AUTH_DHCHAP_AUTH_ID = 0x01,

Yes, this is far better.

You can add:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

