Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349AFD6EC00
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2024 11:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dxewv+ZQ19+cuNwv74XXnOunHnyc/SxCPMWbrvUDyE4=; b=gynOvbnLtVS8USQj4PeYGjNumU
	QRXVkAnF/jlHtCbz3/BPWCuAH8fNdWrh5pWZFQ8pGlIvudPtPflnOIXN3aiHo2getxKCb9Nw5Er4Q
	3/UOM1dnbKZibfuiFkYsTnoJSXTmJwbqWe+nB+ynK6HZ611ZXe7Ns48yGaNRTWYvmA87nuzAGhwql
	rJ+/L+hZgD8EeZKTGiBRZZ0wWTBD00A0hEio7mRiSGiwQvlgrcwjZ6lslkvctxRALD0fdYM2E5J5W
	2eMA0wUCaptD+tp2Dt3VL+tOWHiN5CG2DPXdbS5AHe4eq19ob/bSd6gl1WSvhxkbODuHkQil9rT5+
	gyP5j77A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGz2L-0000000HWjW-2U2R;
	Fri, 29 Nov 2024 11:19:49 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGz2I-0000000HWi7-1hk5
	for linux-nvme@lists.infradead.org;
	Fri, 29 Nov 2024 11:19:47 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0B0841F391;
	Fri, 29 Nov 2024 11:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732879185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dxewv+ZQ19+cuNwv74XXnOunHnyc/SxCPMWbrvUDyE4=;
	b=zCFNZLZZxahuzDcEUvtj+1NaXmCAHVTxIAUC5kJWwpN2nkCFvU3zro17qARlMo9bV++K7D
	ASuAuKqbTyz9W77bCDxIzCSEYEfpm5jrSX2NpfmyvzTTipRb/qorOK70iTKEBhD5zMb7Lq
	2SbvEYp1wgjbbGH95TqPuOKvA5MMfUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732879185;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dxewv+ZQ19+cuNwv74XXnOunHnyc/SxCPMWbrvUDyE4=;
	b=u+rlv321fG4h3Rhl7oFArLCmm5cKd8iZgsWD9jALYSvWdEDlDfsiULc8QfzC/7j/pHW56Y
	W2CBhNtxzp8FnNBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732879185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dxewv+ZQ19+cuNwv74XXnOunHnyc/SxCPMWbrvUDyE4=;
	b=zCFNZLZZxahuzDcEUvtj+1NaXmCAHVTxIAUC5kJWwpN2nkCFvU3zro17qARlMo9bV++K7D
	ASuAuKqbTyz9W77bCDxIzCSEYEfpm5jrSX2NpfmyvzTTipRb/qorOK70iTKEBhD5zMb7Lq
	2SbvEYp1wgjbbGH95TqPuOKvA5MMfUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732879185;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dxewv+ZQ19+cuNwv74XXnOunHnyc/SxCPMWbrvUDyE4=;
	b=u+rlv321fG4h3Rhl7oFArLCmm5cKd8iZgsWD9jALYSvWdEDlDfsiULc8QfzC/7j/pHW56Y
	W2CBhNtxzp8FnNBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7EC3139AA;
	Fri, 29 Nov 2024 11:19:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 60ImOFCjSWcBdQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 29 Nov 2024 11:19:44 +0000
Message-ID: <c2ae3a29-be3c-40f0-aae2-f36123cd04f6@suse.de>
Date: Fri, 29 Nov 2024 12:19:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] nvme-tcp: simplify nvme_tcp_configure_admin_queue()
To: "brookxu.cn" <brookxu.cn@gmail.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1732368538.git.chunguang.xu@shopee.com>
 <c7006c36681afce811e01de7686d6e2df2c4ab0e.1732368538.git.chunguang.xu@shopee.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <c7006c36681afce811e01de7686d6e2df2c4ab0e.1732368538.git.chunguang.xu@shopee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shopee.com:email,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,brookxu.cn:url]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241129_031946_594385_EB6F52E9 
X-CRM114-Status: GOOD (  10.50  )
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

On 11/23/24 14:37, brookxu.cn wrote:
> From: "Chunguang.xu" <chunguang.xu@shopee.com>
> 
> As nvme_tcp_configure_admin_queue() is the only one caller of
> nvme_tcp_destroy_admin_queue(), so we can merge nvme_tcp_configure_admin_queue()
> into nvme_tcp_destroy_admin_queue() to simplify the code.
> 
> Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
> ---
>   drivers/nvme/host/tcp.c | 14 ++++----------
>   1 file changed, 4 insertions(+), 10 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

