Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F5FCCFA04
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 10:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q6i469k8uzc9cH/k5nPYtXpVpJlQzHublJWG8HfoBk8=; b=LzR2tlX22DUf1Gs5pTno/RpRLZ
	hGRpR4KXnQs9vhXMLNfrmxgpzFChX+ZZKTl6vYG/0WoawCAPvZ4AX+nnUgIcTYwsi0BSkV1GE4g+5
	mkL3oOPA7geZxVtQVWdBxBj1XqGx8yyCIVxG4IgVVwiLzFLQ1LzsNtJrt/kjRJKcyG3ZwBW7UWN9b
	YtOaxmnVfSyhfplLABieT6a51AX7mE9IWAnMJ1BJLq/uyr3hjl+EC2/9EIVachCo/bp9L5nSENbpP
	wjeQcav/Hw6F1T9n63VWypO0XI09KsGhWYu2oZyzewUHKQzAxLUhxfeVtx3hZrewd5j4NKnSUjZih
	iO0gqAeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGEeW-0000000BfJL-1flo;
	Tue, 04 Nov 2025 10:52:40 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGEeT-0000000BfIK-2pyC
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 10:52:38 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 168942116E;
	Tue,  4 Nov 2025 10:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762253556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q6i469k8uzc9cH/k5nPYtXpVpJlQzHublJWG8HfoBk8=;
	b=pMCgOU+gxiefbqG2fqoc3BDjqlCGh7Wb12JBK3kEWcwGhwZ4czKuFqI5h5ZBc4UWBjgUGg
	tKuSNmlAgTjeCQqziYiZ7sEcui14rpvPIhSixOjNlPkkpmpMr3xV27+hx9Uzgi8hjKkmXC
	ETSxQxS9ybxvhN0eqDfPObLfhQpZ85U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762253556;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q6i469k8uzc9cH/k5nPYtXpVpJlQzHublJWG8HfoBk8=;
	b=nH5xlcVdWl6y3yLCvJqZE0/ArMBM8iyUuWptiylYWmZWH84HpgJTGb6kQtn6C5BvJbisAd
	3O/01ViM0gCEMBBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762253556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q6i469k8uzc9cH/k5nPYtXpVpJlQzHublJWG8HfoBk8=;
	b=pMCgOU+gxiefbqG2fqoc3BDjqlCGh7Wb12JBK3kEWcwGhwZ4czKuFqI5h5ZBc4UWBjgUGg
	tKuSNmlAgTjeCQqziYiZ7sEcui14rpvPIhSixOjNlPkkpmpMr3xV27+hx9Uzgi8hjKkmXC
	ETSxQxS9ybxvhN0eqDfPObLfhQpZ85U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762253556;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q6i469k8uzc9cH/k5nPYtXpVpJlQzHublJWG8HfoBk8=;
	b=nH5xlcVdWl6y3yLCvJqZE0/ArMBM8iyUuWptiylYWmZWH84HpgJTGb6kQtn6C5BvJbisAd
	3O/01ViM0gCEMBBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F111D139A9;
	Tue,  4 Nov 2025 10:52:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id L4F3OvPaCWmEbwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 04 Nov 2025 10:52:35 +0000
Message-ID: <fbccc6d2-4c6b-43a1-a06d-02d8af9ece96@suse.de>
Date: Tue, 4 Nov 2025 11:52:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] nvmet-fcloop: remove unused lsdir member.
To: Daniel Wagner <wagi@kernel.org>, Justin Tee <justin.tee@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org>
 <20251028-nvmet-fcloop-fixes-v1-4-765427148613@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251028-nvmet-fcloop-fixes-v1-4-765427148613@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_025237_859751_B889B515 
X-CRM114-Status: GOOD (  16.56  )
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

On 10/28/25 16:26, Daniel Wagner wrote:
> Nothing is using lsdir member in struct fcloop_lsreq.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fcloop.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index 4e429a1ea2bd..c30e9a3e014f 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -254,7 +254,6 @@ struct fcloop_nport {
>   struct fcloop_lsreq {
>   	struct nvmefc_ls_req		*lsreq;
>   	struct nvmefc_ls_rsp		ls_rsp;
> -	int				lsdir;	/* H2T or T2H */
>   	int				status;
>   	struct list_head		ls_list; /* fcloop_rport->ls_list */
>   };
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

