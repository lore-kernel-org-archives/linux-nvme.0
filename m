Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42B7C5CFCF
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 10:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l3Kt4KbGsXSbdjf21qYSSa4UkM2/oPWR1wlV6B9wTYI=; b=xf6NdTmearocLl4cr/QckZVobH
	cfbnHKULKVcZ4JLFxCYesC9/CashXHST07CyYk570UjdWNBVGpU4mWtYN+yL3s2GikZgT1jy9aZcB
	ahR6tFQbeMB/ty0XKMEqPy8FIbXtQvLFG8EdCXAIJQSzjlKW5/YdT8PK2C/VOgoSejzPD99eUI73i
	UiYz24pO88qtmbOF6DDrz0osM8uCVxfYrhpSoGI8pBocLFaxaVMdfD3MCxeJpDWxQSDieNFlokwR0
	tPfPUbi1T8cJhEWb8V5aVq7d1QbTx7eC8cx1UANwT+OTWxpuQGCstYA6EBJ5RMQZhUBL6MFedOZTw
	WMwynxJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtjgj-0000000Dqio-0h1Q;
	Tue, 11 Aug 2026 10:26:29 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtjgg-0000000DqiE-1Lsz
	for linux-nvme@lists.infradead.org;
	Tue, 11 Aug 2026 10:26:27 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C1C4C3F23;
	Tue, 11 Aug 2026 10:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786443978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l3Kt4KbGsXSbdjf21qYSSa4UkM2/oPWR1wlV6B9wTYI=;
	b=Qi6UOHYTPR7MDZhGvD5Wm99+1HmVlb5V2c/Omi2vui0bKzU1K5khMOALbXP5dqqvmNcocP
	ddrSxz23diAAf0/yDDPRvLdnaxc+b9Nzdp7AAKV/hiRcfmLbxgbsxXeG8+6xWG/S3Ko7nU
	IBr8EFO98o+KQ3pi/OswofRUIFi9E/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786443978;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l3Kt4KbGsXSbdjf21qYSSa4UkM2/oPWR1wlV6B9wTYI=;
	b=ZM3s688tvLSR8UO6F/guHL7dKcAO7Gv1QCgwHRrxBfgxaLIG5ZfxUEFHg3sR5JIUnUt8Ut
	AgKZonW7/ZOa5yAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786443974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l3Kt4KbGsXSbdjf21qYSSa4UkM2/oPWR1wlV6B9wTYI=;
	b=rxPf3uk/QEkEO9Kj3NAx1intd6U7XY4JpKSA7Doj/e6/obgXfGFdAX2x5lm7VX+vOpKX/g
	fRmfDwLXYMnIUfzSi/UIWgReUSsejaTNZTfx1K19sRXuBJ4X6ZtHnueIeT985bEq993jcr
	mxPVWxY17o1Y0MUmaeRl2KuMkL2VFSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786443974;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l3Kt4KbGsXSbdjf21qYSSa4UkM2/oPWR1wlV6B9wTYI=;
	b=XuR/PkOMWl41WDBK/81zEIGbkHVanXrpxd+6UFSZTMM+8wmv68q+TK8r2IlTxM2xtBNPgy
	zdCfrg7dtnUKpsDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD485779B2;
	Tue, 11 Aug 2026 10:26:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yTTiKcb4emp2NAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 11 Aug 2026 10:26:14 +0000
Message-ID: <a0ff0901-8f9e-4309-a5c3-18317b7af442@suse.de>
Date: Tue, 11 Aug 2026 12:26:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-auth: reject overlong negotiate identifier lists
To: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260810155615.3269409-1-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260810155615.3269409-1-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,cyber.gouv.fr:email,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_032626_539288_D2657DC1 
X-CRM114-Status: GOOD (  17.66  )
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

On 8/10/26 5:56 PM, Jérémy Jean wrote:
> The DH-HMAC-CHAP NEGOTIATE descriptor carries separate lengths for the
> hash and DH identifier lists, but each list occupies a fixed 30-byte half
> of idlist[]. nvmet_auth_negotiate() uses halen and dhlen from the wire as
> loop bounds without validating them, so a remote initiator can make the
> target read past the 72-byte request buffer. KASAN reports a
> slab-out-of-bounds read in nvmet_execute_auth_send().
> 
> Reject list lengths above the protocol maxima before either loop
> indexes idlist[].
> 
> Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5
> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> ---
>   drivers/nvme/target/fabrics-cmd-auth.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
> index 45820a12750d..8679d5db4f86 100644
> --- a/drivers/nvme/target/fabrics-cmd-auth.c
> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> @@ -71,6 +71,12 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
>   	    NVME_AUTH_DHCHAP_AUTH_ID)
>   		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
>   
> +	if (data->auth_protocol[0].dhchap.halen >
> +	    NVME_AUTH_DHCHAP_MAX_HASH_IDS ||
> +	    data->auth_protocol[0].dhchap.dhlen >
> +	    NVME_AUTH_DHCHAP_MAX_DH_IDS)
> +		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
> +
>   	for (i = 0; i < data->auth_protocol[0].dhchap.halen; i++) {
>   		u8 host_hmac_id = data->auth_protocol[0].dhchap.idlist[i];
>   

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

