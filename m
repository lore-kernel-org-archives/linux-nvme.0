Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6FFC46CD2
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 11:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0VQTD6e34URitSXIJwAIlu72BmB/Am3gsvG0hDPNiZI=; b=IxTLEF2ghafHkYLhW/nHqiZ20a
	flxK5iOCDZMwjNjD59xbzur7Fdi0UvZrUWkBnzid9UCTlQ46VOZJufsdaHQSnuqQ+9pTfhRkDyG3u
	CgWcAF5pvAxdRa+LojGgqdZJli+JyaufUt7YlbS+Y3Zk8NfmQEYBshwkjbJiisDXyOboj768kJ9Tl
	qS4TX5zoQaWm4xwVZox5CU4c88qYVghYFYm4BCbhSE5QGDxjeyuoElk1IZWp2e2xFl1mIJxYestZt
	vvyiFDgrZgG0HbSGkoQC3L8sH2Rls6fsGbxiCNxU7MK01kNXrrN4bt/St4ezH+yutcOWUrxUnmFj3
	JlIn2vqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFYRz-00DqwJ-0d;
	Tue, 19 Dec 2023 11:39:51 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFYRu-00Dqsw-1c
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 11:39:47 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EB0ED1FD54;
	Tue, 19 Dec 2023 11:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702985985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0VQTD6e34URitSXIJwAIlu72BmB/Am3gsvG0hDPNiZI=;
	b=Km4QD2vlOFG/QojQvLW9QytCV3qH3yxF7JnQBUKv8kmi3Hhj+zcTlM6SXYnaw+yrNcnPS8
	mhxrvOoFMLXfVvWbZhUEMsvyNOKuX/8Xg9M20JJF5zPco2XV6+d4wHsO6RnIGA9ybSrxI8
	IgbX8aZHyEPpyc2fRrtcoByCo6ENFZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702985985;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0VQTD6e34URitSXIJwAIlu72BmB/Am3gsvG0hDPNiZI=;
	b=xHRDvGl8Ghij3nIEVisPgBrdELvujyoU/zNhPBS4RFjmTptDcqWLfE7TWfR2YV/2+mQ0YJ
	ISGOjYT94KVc6YBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702985984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0VQTD6e34URitSXIJwAIlu72BmB/Am3gsvG0hDPNiZI=;
	b=OBfpG3/ixtc3kSlmAVO9AVfmIv3vlZNm1G0kixCY5GhJQD9XhPD9GwVHZF6mn4NXmYFQU6
	J87eLNTdmSblZ2/HiXcI5rng3ADl2ih55nNTPgjBtQeEl9j/og+/FmB+Pi8LrUy29HjYvF
	NlYSfIINpCG84T/RQMTFFbuyZnxK14k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702985984;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0VQTD6e34URitSXIJwAIlu72BmB/Am3gsvG0hDPNiZI=;
	b=9J8wYAmfvRsJVSMmI7eeZ94qXelBfObrpH0IaIbCkfQy+mgAuqxa+l5AIDN3jiqmg724HL
	/0o7ElC+xYngM/DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39BE31375D;
	Tue, 19 Dec 2023 11:39:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qCXANf+AgWWGNQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 Dec 2023 11:39:43 +0000
Message-ID: <044a952f-7e35-4f14-8d49-1aa6e2c6e61a@suse.de>
Date: Tue, 19 Dec 2023 12:39:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/16] nvmet-fc: abort command if when there is binding
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
References: <20231218153105.12717-1-dwagner@suse.de>
 <20231218153105.12717-14-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231218153105.12717-14-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="OBfpG3/i";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9J8wYAmf
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-1.10)[88.18%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: EB0ED1FD54
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_033946_753915_6D46D1B1 
X-CRM114-Status: GOOD (  16.79  )
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

On 12/18/23 16:31, Daniel Wagner wrote:
> WHen the target port has not active port binding, there is no point in
> trying to process the command as it has to fail anyway. Instead adding
> checks to all commands abort the command early.
> 
Please fix up the subject: 'abort command when there is no binding'

> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/target/fc.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 47cecc8c72b2..663c51c9fe53 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -1101,6 +1101,9 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
>   	int idx;
>   	bool needrandom = true;
>   
> +	if (!tgtport->pe)
> +		return NULL;
> +
>   	assoc = kzalloc(sizeof(*assoc), GFP_KERNEL);
>   	if (!assoc)
>   		return NULL;
> @@ -2520,8 +2523,9 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
>   
>   	fod->req.cmd = &fod->cmdiubuf.sqe;
>   	fod->req.cqe = &fod->rspiubuf.cqe;
> -	if (tgtport->pe)
> -		fod->req.port = tgtport->pe->port;
> +	if (!tgtport->pe)
> +		goto transport_error;
> +	fod->req.port = tgtport->pe->port;
>   
>   	/* clear any response payload */
>   	memset(&fod->rspiubuf, 0, sizeof(fod->rspiubuf));

Otherwise:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


