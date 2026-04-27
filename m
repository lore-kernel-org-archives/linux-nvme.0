Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F80FF8861
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2026 09:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I0emObiUGW5vIrCuKImDBXh6wqhKm10C26wxd4m7qgA=; b=0jGMkqMPdqaB2HwVZ+ftaWw46r
	hqHJDAEAo9c7d6aisOpN18uYouJC4MS2BtJwdVjsREbWoY+XensaKEJt9ORvG4G8W/zuFnTjzVg/c
	aBF4cXcxl/k0end60fTlPkkHU7YJHg8Nw7JV7Ia5WrNTud4oe7/C3KtQA1Oa20hjmxtFcVuxDWPNM
	4o1HgcVKu5/Ic88PHrq4YFb7n0adGrGtL8n/eAcNFxS8qXna1CKDqBEXjjr3a5PwMY72F0Qityc3M
	Yzg+UlIEhqGuXdOhCQNZiA1LOdrBYf6H2aaN27XS024Xg3aeEKP7YAgbVho8F8zuZIPs+iLyZ+AZr
	+mKvVZAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHHui-0000000GXKv-0OjF;
	Mon, 27 Apr 2026 09:06:00 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHHuf-0000000GXKL-2wJe
	for linux-nvme@lists.infradead.org;
	Mon, 27 Apr 2026 09:05:59 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 40C176A900;
	Mon, 27 Apr 2026 09:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777280754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I0emObiUGW5vIrCuKImDBXh6wqhKm10C26wxd4m7qgA=;
	b=qLLLsbp6Da4XlmyG16EBYoJedMAbGuNqNoqF8QamakOgVhynmzVvHUhSVyklxfrmYsBsLL
	Vi7iWeR+JAypqxrs99oPuTh3WpFByzj0SW/q8+gxk7i+dAxX2d96QF5to6ttaw2iRVVH6N
	RszbI1tGFfRqyZBl9MQlzi/12OzTR8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777280754;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I0emObiUGW5vIrCuKImDBXh6wqhKm10C26wxd4m7qgA=;
	b=iWOzYmxbQtkPnJj7qpdwdf2PELqQfHoKKg9R1Qg6KpxIJL8AemviWF0Xnm1IuOGmR+HY6A
	7+tEgogZBRgBY2CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777280754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I0emObiUGW5vIrCuKImDBXh6wqhKm10C26wxd4m7qgA=;
	b=qLLLsbp6Da4XlmyG16EBYoJedMAbGuNqNoqF8QamakOgVhynmzVvHUhSVyklxfrmYsBsLL
	Vi7iWeR+JAypqxrs99oPuTh3WpFByzj0SW/q8+gxk7i+dAxX2d96QF5to6ttaw2iRVVH6N
	RszbI1tGFfRqyZBl9MQlzi/12OzTR8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777280754;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I0emObiUGW5vIrCuKImDBXh6wqhKm10C26wxd4m7qgA=;
	b=iWOzYmxbQtkPnJj7qpdwdf2PELqQfHoKKg9R1Qg6KpxIJL8AemviWF0Xnm1IuOGmR+HY6A
	7+tEgogZBRgBY2CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 306AC593B0;
	Mon, 27 Apr 2026 09:05:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qyGWCvIm72njPwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 27 Apr 2026 09:05:54 +0000
Date: Mon, 27 Apr 2026 11:05:45 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, mheyne@amazon.de, emilne@redhat.com, 
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org, mlombard@arkamax.eu, 
	mkhalfella@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org, hch@lst.de
Subject: Re: [PATCH V3 3/8] nvme: pci: use admin queue timeout over
 NVME_ADMIN_TIMEOUT
Message-ID: <5e8ae9b1-6dbd-4c38-8888-5c39ef2e0b4d@flourine.local>
References: <20260410073924.61078-1-mlombard@redhat.com>
 <20260410073924.61078-4-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410073924.61078-4-mlombard@redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_020557_961877_4E24EA1C 
X-CRM114-Status: GOOD (  15.67  )
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

On Fri, Apr 10, 2026 at 09:39:19AM +0200, Maurizio Lombardi wrote:
> While tearing down its queues, nvme-pci uses NVME_ADMIN_TIMEOUT as its
> timeout target. Instead, use the configured admin queue's timeout value
> to match the device's existing timeout setting.
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>  drivers/nvme/host/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 9aa19255b041..379c75c6d35a 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3091,7 +3091,7 @@ static bool __nvme_delete_io_queues(struct nvme_dev *dev, u8 opcode)
>  	unsigned long timeout;
>  
>   retry:
> -	timeout = NVME_ADMIN_TIMEOUT;
> +	timeout = dev->ctrl.admin_timeout;

Looks good to me. I went through the fabrics code to double check if
there is something similiar but it seems we are fine there as well.

Reviewed-by: Daniel Wagner <dwagner@suse.de>


