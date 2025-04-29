Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C202CC369CB
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 06:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aX/n8DEU7k2zd6R4185XfjPpp4bYxgPWwiGj1//HaV4=; b=5EZsZ9KS4zhPLFZYEzqmSI5nbN
	WQ4/EErfvRY602Oj9XHYHj2MnEzsB0BwLh4qH/dOxnMsh2WgjDl9jz+fzgJDklDNrFtU9u777Ya4h
	Dpww2mP+9f/Z4Im0EDi5mseTBveFksdCMfj5U5U7F6mhkFrts3c6AU7i0xCDNZPW/nxTG0MA0Tw8+
	UyZSj8RBD2y3HEsleF2DAFj0mFn7p5uaPkTrtVhrfIWVc+bgPLzhTQTK5vSqaBYRICG12zWRj4oEZ
	eR1Qgy5m1YLuvqk/DSzKC59WtcdCdoQmLs6ymAZZFpiNY5fXpX1X8NUByJeeSVFMTrzk8DVzxByzV
	cWdq4Hng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9eEx-00000008W6d-0zNz;
	Tue, 29 Apr 2025 06:14:47 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9eEu-00000008W3r-153E
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 06:14:45 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2911621196;
	Tue, 29 Apr 2025 06:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745907282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aX/n8DEU7k2zd6R4185XfjPpp4bYxgPWwiGj1//HaV4=;
	b=q+T5p8RSXS38RP5QaSMLOf3k7GLxYJfAOXk9dF6IoTNRCPvYanlHm4kVA0Yg0CKttxu5iJ
	Idf4/Zt6KjUN2M+o9NW4T9f1H+rP4YSKfLKkUIMPvC4KjX8uvQshfMPloGj21rD9VYf8Vu
	tuY5zugLZX5R966TuVa/4LQ7DSbboKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745907282;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aX/n8DEU7k2zd6R4185XfjPpp4bYxgPWwiGj1//HaV4=;
	b=SFASsEcS/I9wtslmguz18S3t5glfTX6eEQBbxMZs2zf2bYlIuaQ80S1PGdkGiJMhcaGIW9
	qhOW5Utc59LDNsDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745907282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aX/n8DEU7k2zd6R4185XfjPpp4bYxgPWwiGj1//HaV4=;
	b=q+T5p8RSXS38RP5QaSMLOf3k7GLxYJfAOXk9dF6IoTNRCPvYanlHm4kVA0Yg0CKttxu5iJ
	Idf4/Zt6KjUN2M+o9NW4T9f1H+rP4YSKfLKkUIMPvC4KjX8uvQshfMPloGj21rD9VYf8Vu
	tuY5zugLZX5R966TuVa/4LQ7DSbboKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745907282;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aX/n8DEU7k2zd6R4185XfjPpp4bYxgPWwiGj1//HaV4=;
	b=SFASsEcS/I9wtslmguz18S3t5glfTX6eEQBbxMZs2zf2bYlIuaQ80S1PGdkGiJMhcaGIW9
	qhOW5Utc59LDNsDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6FDC13931;
	Tue, 29 Apr 2025 06:14:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OYJtLlFuEGhGXAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 29 Apr 2025 06:14:41 +0000
Message-ID: <301c144b-b3e1-4dfb-8f11-9aafd56ef993@suse.de>
Date: Tue, 29 Apr 2025 08:14:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] lpfc: enable FPIN notification for NVMe
To: Justin Tee <justintee8345@gmail.com>, hare@kernel.org
Cc: Justin Tee <justin.tee@broadcom.com>, James Smart <jsmart2021@gmail.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20250428063635.125879-1-hare@kernel.org>
 <20250428063635.125879-4-hare@kernel.org>
 <CABPRKS9yTExMW+PdJHnXiftck8dQQcF-RxVUt75M=P2bTnfmHA@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CABPRKS9yTExMW+PdJHnXiftck8dQQcF-RxVUt75M=P2bTnfmHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,gmail.com,lst.de,kernel.org,grimberg.me,lists.infradead.org];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250428_231444_674476_814123F5 
X-CRM114-Status: GOOD (  11.93  )
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

On 4/29/25 02:30, Justin Tee wrote:
> Hi Hannes,
> 
> May we qualify the call to nvme_fc_fpin_rcv with something like this?
> 
> diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
> index cf1fbfb15c5d..ea76b4550e30 100644
> --- a/drivers/scsi/lpfc/lpfc_els.c
> +++ b/drivers/scsi/lpfc/lpfc_els.c
> @@ -10251,8 +10251,11 @@ lpfc_els_rcv_fpin(struct lpfc_vport *vport,
> void *p, u32 fpin_length)
>                  if (deliver) {
>                          fc_host_fpin_rcv(lpfc_shost_from_vport(vport),
>                                           fpin_length, (char *)fpin, 0);
> -                       nvme_fc_fpin_rcv(vport->localport,
> -                                        fpin_length, (char *)fpin);
> +#if (IS_ENABLED(CONFIG_NVME_FC))
> +                       if (vport->cfg_enable_fc4_type == LPFC_ENABLE_BOTH)
> +                               nvme_fc_fpin_rcv(vport->localport,
> +                                                fpin_length, (char *)fpin);
> +#endif
>                  }
>                  desc_cnt++;
>          }
> 
That should rather be a 'cfg_enable_fc4_type & LPFC_ENABLE_NVME', right?

But okay, I'll fold it in.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

