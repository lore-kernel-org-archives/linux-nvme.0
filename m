Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FAFC43327
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2026 11:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=amvkpVZyNUwpRMF3dQzCrJwMY0oB5rCdNGVgZhhe6NE=; b=Nav/aHBEtjUj47f+SeYLEev92W
	5ALBidDtIVPA5QhFhTRUuLFUl+xmDqSIPbuhrfKJRNmtD0ZONuzgV6eLU+EGhfLp6KxxrdplPnxfN
	dSMIK4KvIRYYXUkod4DJNug1FWPUmhHuV0B8y4iqczseSpgXiO6EaO/kfvPFkfMKE7VOmxC8toKv4
	9Qxz0Odor5GcosD9az6TOEX19ZBQ0f6OIhYvC02I+Tfxs8oDQgn8le3R/+S6uu7xKnA2fghjLPCfm
	wJk1vU8Brx+Hw4bFFTjwGjBNrzXULz+eo03p11PdE2P2wC6iJBhL6R82RMheNzmIqDqVBDnyVaZ4L
	n2T2g+eQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wesk2-00000001Phb-0gug;
	Wed, 01 Jul 2026 11:04:30 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wesjz-00000001PgF-0QZa
	for linux-nvme@lists.infradead.org;
	Wed, 01 Jul 2026 11:04:28 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8E73A75D75;
	Wed,  1 Jul 2026 11:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782903863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=amvkpVZyNUwpRMF3dQzCrJwMY0oB5rCdNGVgZhhe6NE=;
	b=D258qGm6EjBWli2C5nZNJ2Q367jpRfe4ONfFoM6wtEooINsSUrDlaf8S/Ixhtx87wEsZXg
	Y02jE2ycPt3Jw1dKRL05s6JIpQF2H1fT/mP2VssybNwcim/jvW1Wb2OlRmYqRwlmLVc3ws
	7RO7H8G/d2AmRKUiNJXVNT4m3ZIRDAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782903863;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=amvkpVZyNUwpRMF3dQzCrJwMY0oB5rCdNGVgZhhe6NE=;
	b=UI+f5HFwboVqy6/fjI1RskqzSynQSBZxHtQf91XddSRI7l70ZDSz43x++ABGKX49s4ghrU
	gRVlfK07ukcRglCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782903863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=amvkpVZyNUwpRMF3dQzCrJwMY0oB5rCdNGVgZhhe6NE=;
	b=D258qGm6EjBWli2C5nZNJ2Q367jpRfe4ONfFoM6wtEooINsSUrDlaf8S/Ixhtx87wEsZXg
	Y02jE2ycPt3Jw1dKRL05s6JIpQF2H1fT/mP2VssybNwcim/jvW1Wb2OlRmYqRwlmLVc3ws
	7RO7H8G/d2AmRKUiNJXVNT4m3ZIRDAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782903863;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=amvkpVZyNUwpRMF3dQzCrJwMY0oB5rCdNGVgZhhe6NE=;
	b=UI+f5HFwboVqy6/fjI1RskqzSynQSBZxHtQf91XddSRI7l70ZDSz43x++ABGKX49s4ghrU
	gRVlfK07ukcRglCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A578779AA;
	Wed,  1 Jul 2026 11:04:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GxP/GDf0RGpcdAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 01 Jul 2026 11:04:23 +0000
Message-ID: <950bfce8-71a3-4888-8edd-c8c0298d0bbc@suse.de>
Date: Wed, 1 Jul 2026 13:04:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-auth: Avoid C=1 warning in
 nvme_auth_derive_tls_psk()
To: Eric Biggers <ebiggers@kernel.org>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: John Garry <john.g.garry@oracle.com>
References: <20260625175911.35094-1-ebiggers@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260625175911.35094-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260701_040427_286670_CB448293 
X-CRM114-Status: GOOD (  13.23  )
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

On 6/25/26 7:59 PM, Eric Biggers wrote:
> The following works fine with gcc and clang, but sparse warns about
> label_len not being an actual constant expression:
> 
>      const size_t label_len = sizeof(label) - 1;
>      ...
>      static_assert(label_len <= 255);
> 
> Avoid this by giving label an explicit length and using sizeof(label)
> instead of label_len.
> 
> Reported-by: John Garry <john.g.garry@oracle.com>
> Closes: https://lore.kernel.org/linux-nvme/965a37dd-f698-46b6-9623-1099a13f7e60@oracle.com
> Fixes: d126cbaa7d9a ("nvme-auth: common: use crypto library in nvme_auth_derive_tls_psk()")
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>   drivers/nvme/common/auth.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

