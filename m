Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B831C46CCD
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 11:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vC1tfMzAhjCnD74T2n6aB7HNv/A1nc9tsb7j5i5sPC8=; b=YJY4C6PbBxtHcEcNg5BouIsrIW
	ctCPIIX9PKgtDVgSP3NZwshqm/j5HH4deosnBj5p79O+H/1smSK81Opui+c/v1lHAWs2jfeoYVonR
	Tq3OMbLW8P2oKTUFaINz4T+ll14fvvVtwNX5HiFcJ/qnsH4J6ioRVo0sZOT+Miry3feXQAhitDdUF
	BJ0STXyzUKuEvA/3PLf0rzU/7MnqCexa2FUh5tlA/2C8JecmB7Dn8ZGAmDJjp4o4x9GQnAPPeLoVF
	z2Cpr9cDb/MycccBz7phGhWjH1of6SJDMjC4W5Ve82S4tsrnwyP3lYx1p0OF81kW8sT6JvgsDQ15r
	udu9ZbvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFYU0-00DsOS-0P;
	Tue, 19 Dec 2023 11:41:56 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFYTw-00DsLP-2m
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 11:41:54 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 62D522209F;
	Tue, 19 Dec 2023 11:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702986111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vC1tfMzAhjCnD74T2n6aB7HNv/A1nc9tsb7j5i5sPC8=;
	b=EutZX/Pkal2rAtYpb+nTO7t68KpNHhVki0rd4wqH3VtVSHR+UWOIPjb4BS9G94E0uJICSK
	znHWnip2jS20HlHPJ48mb2JxReco524wUJsKpt1Ukc6/wkmQ7GxHDZMzOGrWblF1+XY8BW
	K3OedsWk/VmyHjXXaCTdMw/xGbACVt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702986111;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vC1tfMzAhjCnD74T2n6aB7HNv/A1nc9tsb7j5i5sPC8=;
	b=SQQj8EhP1UJypNjCbbc/HIr+F3ka9ubY7UaSkG7PdMxgtplGPkhQbIcKvezKEBSt4ZBblM
	MIcVrdot802c6pBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702986111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vC1tfMzAhjCnD74T2n6aB7HNv/A1nc9tsb7j5i5sPC8=;
	b=EutZX/Pkal2rAtYpb+nTO7t68KpNHhVki0rd4wqH3VtVSHR+UWOIPjb4BS9G94E0uJICSK
	znHWnip2jS20HlHPJ48mb2JxReco524wUJsKpt1Ukc6/wkmQ7GxHDZMzOGrWblF1+XY8BW
	K3OedsWk/VmyHjXXaCTdMw/xGbACVt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702986111;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vC1tfMzAhjCnD74T2n6aB7HNv/A1nc9tsb7j5i5sPC8=;
	b=SQQj8EhP1UJypNjCbbc/HIr+F3ka9ubY7UaSkG7PdMxgtplGPkhQbIcKvezKEBSt4ZBblM
	MIcVrdot802c6pBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAFF51375D;
	Tue, 19 Dec 2023 11:41:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G+tINn6BgWVuNgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 Dec 2023 11:41:50 +0000
Message-ID: <ac062d49-05bd-4615-ac38-4a463d533917@suse.de>
Date: Tue, 19 Dec 2023 12:41:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/16] nvmet-fc: free hostport after release reference
 to tgtport
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
References: <20231218153105.12717-1-dwagner@suse.de>
 <20231218153105.12717-15-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231218153105.12717-15-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.74 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-1.45)[91.32%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_034153_047982_B5DD15A3 
X-CRM114-Status: GOOD (  16.80  )
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
> Give the ref back before destroying the hostport object to prevent a
> potential UAF.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/target/fc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 663c51c9fe53..23d8779dc221 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -986,8 +986,8 @@ nvmet_fc_hostport_free(struct kref *ref)
>   	spin_unlock_irqrestore(&tgtport->lock, flags);
>   	if (tgtport->ops->host_release && hostport->invalid)
>   		tgtport->ops->host_release(hostport->hosthandle);
> -	kfree(hostport);
>   	nvmet_fc_tgtport_put(tgtport);
> +	kfree(hostport);
>   }
>   
>   static void

That, I guess, needs some more explanation.
It's not immediately obvious why a 'put' on the targetport would
have implications on the hostport. But when it does wouldn't it
be more sensible to free up the reference to the hostport when the
final 'put' on the target port happens?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


