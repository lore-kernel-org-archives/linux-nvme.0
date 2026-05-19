Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40C7CD4851
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 08:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mRurxTpvwFo4AGpQWf8HNciRhczFFLaJZoXNuiBQzQo=; b=dceFXzlFQeooqhQAKosP2jKzM4
	yACR9t3CNFDbUZruRHvdkB1DpT/XLXQWapXvAkIv8XZgY1Z0b3s/A/4HjV/SykmaAvCegkAPBwBWb
	M8Rjlt4gpi1REd+yipbQzTuTQPbzHPZBBtUgFKNDGQ8yEhF9SLtIWc9PC+ZuiTaY4jHlYhQ11+TGB
	3O6POvqfYUFU8gLuOHceGhY5PxsqGzuin8yhOQlBmmwcFXRN0QCRszVPrUu8G8hJmKRemmAZoVPGp
	6qkfMaC2zO78y3sLX73yPwEyrpH5GXauRfdiJht+G2kQ8nL5Lk4U1xaNFviZc2SzG3rizuYeYYLZO
	8+DzVIZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPG9p-00000000kLN-10wF;
	Tue, 19 May 2026 08:50:33 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPG9n-00000000kKG-0Dym
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 08:50:32 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 52AB467DF4;
	Tue, 19 May 2026 08:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779180629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mRurxTpvwFo4AGpQWf8HNciRhczFFLaJZoXNuiBQzQo=;
	b=oGXv1BUg1zAW0TVC0+AGJTdOMDsU6FP5BxOLLRskS7j+saXRh74FoObKECJNsMbTAS93IQ
	jFnv1sCkVYrtwRHpv0esZgS5DSTmTLFZvW85+K36Unl2RfJXMHb5bYwe5Yt1YdEq6cLNus
	M9DCnGd3ZX78zSjl6tnHRx2gPhLvlDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779180629;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mRurxTpvwFo4AGpQWf8HNciRhczFFLaJZoXNuiBQzQo=;
	b=83d0/HBxrubrwRzL0rZ0vYeXIT2BIVYrGbnrQHHUWQ4jx3DWLEBPdMB8iIQ1Rcrgse/XjC
	WZtsQVVFefiPDWCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779180629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mRurxTpvwFo4AGpQWf8HNciRhczFFLaJZoXNuiBQzQo=;
	b=oGXv1BUg1zAW0TVC0+AGJTdOMDsU6FP5BxOLLRskS7j+saXRh74FoObKECJNsMbTAS93IQ
	jFnv1sCkVYrtwRHpv0esZgS5DSTmTLFZvW85+K36Unl2RfJXMHb5bYwe5Yt1YdEq6cLNus
	M9DCnGd3ZX78zSjl6tnHRx2gPhLvlDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779180629;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mRurxTpvwFo4AGpQWf8HNciRhczFFLaJZoXNuiBQzQo=;
	b=83d0/HBxrubrwRzL0rZ0vYeXIT2BIVYrGbnrQHHUWQ4jx3DWLEBPdMB8iIQ1Rcrgse/XjC
	WZtsQVVFefiPDWCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF1E9593A8;
	Tue, 19 May 2026 08:50:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l9D2NlQkDGqkIwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 May 2026 08:50:28 +0000
Message-ID: <6a062c38-0686-44b1-a90f-9c9039ad141a@suse.de>
Date: Tue, 19 May 2026 10:50:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 4/7] nvme: add sysfs attribute to change IO timeout per
 controller
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: mheyne@amazon.de, emilne@redhat.com, jmeneghi@redhat.com,
 linux-nvme@lists.infradead.org, dwagner@suse.de, mlombard@arkamax.eu,
 mkhalfella@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org,
 hch@lst.de
References: <20260514083255.41109-1-mlombard@redhat.com>
 <20260514083255.41109-5-mlombard@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260514083255.41109-5-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[suse.de:email,suse.de:mid,purestorage.com:email,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,purestorage.com:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_015031_239580_E0334317 
X-CRM114-Status: GOOD (  11.69  )
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

On 5/14/26 10:32, Maurizio Lombardi wrote:
> Currently, there is no method to adjust the timeout values on a
> per controller basis with nvme I/O queues.
> Add an io_timeout attribute to nvme so that different nvme controllers
> which may have different timeout requirements can have custom I/O
> timeouts set.
> 
> The I/O timeout is also applied to the connect queue (connect_q).
> In NVMe over Fabrics, the connect queue is utilized specifically to
> issue Connect commands that establish the I/O queues.
> 
> Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/nvme/host/core.c  |  4 +++-
>   drivers/nvme/host/nvme.h  |  1 +
>   drivers/nvme/host/sysfs.c | 47 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 51 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

