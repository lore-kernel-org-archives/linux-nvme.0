Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0F0C46CA2
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 07:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TjL3rK5mqJOGP1HV7taqDEMc4rfDP37oIi42/AtoI7U=; b=WzfdvO2AdXC/YQes6V1y+yO8Tc
	LW8fmiD9Ma+5pheRxC/8wUTlNBVTwjmW0iAkYUtFeCCvQqetdcDbaEdIazLzOX0M2TNPmknfJEnzT
	ThH0IOJl+QzbE9FRdyBlyRiBwmUxzryNrRLy26lPZPALjtl0F4RFxsSQQvIc/ZZf7piX/Q59m1UL4
	OCDFl+nTVWTKLoPq2pfJ26qBKAspepCwJubQTm4nYzPkuCNckUjYo6Yy4X92B6sSQ7Xej6KL1zBbB
	JdsPV+10sr0jwFG1lVTEb6g0bZ8tPJr2J9BE2mnLG/AqrESci+ZHVnftpF1ODWRac6p2m4ZjAj/YG
	gdWGD7Fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFUUz-00D5MC-0Y;
	Tue, 19 Dec 2023 07:26:41 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFUUw-00D5Jo-10
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 07:26:39 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F3BFD1F7A7;
	Tue, 19 Dec 2023 07:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702970797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TjL3rK5mqJOGP1HV7taqDEMc4rfDP37oIi42/AtoI7U=;
	b=Du0gm8ooRodAnWordwCkHDQjLwiCZhH5VL7G1miM/NDP5tfOoKEZSM0RwXQLgXSGBK+ejk
	SuGq2fd4hlwqcviJ1wqBFLdoIlpWsqkuM+TsOynbVwiWK5NDyYdUuVKYDIY7lotUjc3ekJ
	CUquw5xxw+lDmuSBzKsKt1H5Wa+eNVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702970797;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TjL3rK5mqJOGP1HV7taqDEMc4rfDP37oIi42/AtoI7U=;
	b=N1IMFSchUUXb9hPTVpcEUdhmnOh0g5Q221q3cKK1aKvgM7K/HvTK8fMepIIMaJLoRL6iBY
	8pdQy2GKOqhhmvDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702970797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TjL3rK5mqJOGP1HV7taqDEMc4rfDP37oIi42/AtoI7U=;
	b=Du0gm8ooRodAnWordwCkHDQjLwiCZhH5VL7G1miM/NDP5tfOoKEZSM0RwXQLgXSGBK+ejk
	SuGq2fd4hlwqcviJ1wqBFLdoIlpWsqkuM+TsOynbVwiWK5NDyYdUuVKYDIY7lotUjc3ekJ
	CUquw5xxw+lDmuSBzKsKt1H5Wa+eNVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702970797;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TjL3rK5mqJOGP1HV7taqDEMc4rfDP37oIi42/AtoI7U=;
	b=N1IMFSchUUXb9hPTVpcEUdhmnOh0g5Q221q3cKK1aKvgM7K/HvTK8fMepIIMaJLoRL6iBY
	8pdQy2GKOqhhmvDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2319013AA6;
	Tue, 19 Dec 2023 07:26:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8KlXBKxFgWVmcgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 Dec 2023 07:26:36 +0000
Message-ID: <8fdbfb01-d50e-4198-b673-2a4c51417a81@suse.de>
Date: Tue, 19 Dec 2023 08:26:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/16] nvmet-fcloop: Remove remote port from list when
 unlinking
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
References: <20231218153105.12717-1-dwagner@suse.de>
 <20231218153105.12717-6-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231218153105.12717-6-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-6.89 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-1.63)[92.64%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.17)[-0.874];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_232638_502401_96EB25DD 
X-CRM114-Status: GOOD (  19.25  )
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

On 12/18/23 16:30, Daniel Wagner wrote:
> The remote port is removed too late from fcloop_nports list. Remove it
> when port is unregistered.
> 
> This prevents a busy loop in fcloop_exit, because it is possible the
> remote port is found in the list and thus we will never progress.
> 
> The kernel log will be spammed with
> 
>    nvme_fcloop: fcloop_exit: Failed deleting remote port
>    nvme_fcloop: fcloop_exit: Failed deleting target port
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/target/fcloop.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index c65a73433c05..ead349af30f1 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -995,11 +995,6 @@ fcloop_nport_free(struct kref *ref)
>   {
>   	struct fcloop_nport *nport =
>   		container_of(ref, struct fcloop_nport, ref);
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&fcloop_lock, flags);
> -	list_del(&nport->nport_list);
> -	spin_unlock_irqrestore(&fcloop_lock, flags);
>   
>   	kfree(nport);
>   }
> @@ -1357,6 +1352,8 @@ __unlink_remote_port(struct fcloop_nport *nport)
>   		nport->tport->remoteport = NULL;
>   	nport->rport = NULL;
>   
> +	list_del(&nport->nport_list);
> +
>   	return rport;
>   }
>   
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


