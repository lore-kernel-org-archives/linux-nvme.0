Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B510CCF9E3
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 10:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dbVY/VBqk2zvjO5PdxoPmUFEkfs061ELl9sM5HumuOM=; b=vNbZ8KGr84Zv0GPjRDBnw5SW4n
	PW+rnynnKX5LJtUf3yBwc8MbRtUpq3DKYeo+ricl5GAttVSeA2KQMCVVuZt2LcbqcK/m0M1Z/y9m7
	GLaFmGD7nVx2xk7IPm5bLvgH3OmAj+WLH9lAJeAb7sur9uiKaW7SE2zwp7B/dWLhx29km+U5zmvGD
	KWzToPEHQ9YqiEZM4Kt9nkWWOKZwgi9CFnJV9fbRN6Msnchu2feXtFNFPKi0FXLMbad+7QqFFIdnq
	g7+2ZndP3cVMA6OGyswDdLQeQHgq05EsfhgG0XhHXhAHQkYmDKML99YorvnyhRij2Igd+U71mSGyn
	vcU+FMCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGEft-0000000Bfa4-3O9o;
	Tue, 04 Nov 2025 10:54:05 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGEfr-0000000BfZb-1gqW
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 10:54:04 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A59C61F387;
	Tue,  4 Nov 2025 10:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762253641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dbVY/VBqk2zvjO5PdxoPmUFEkfs061ELl9sM5HumuOM=;
	b=tB2Hs0BJrBJDXILIjdtq8kcNXqgGd0Mp6BzN0QaLC3tF2Z4+fidBQ37qN4HJr/t0Mksvil
	uJ199Pn0gpJzR/EeaJnW3coiInA9bKAM6f1aB3wInY1MCuLrjIqEijth3FKmMJkhzWPWJ4
	S0SzIN4tVk9Di7FsKDDysM1/PDVerxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762253641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dbVY/VBqk2zvjO5PdxoPmUFEkfs061ELl9sM5HumuOM=;
	b=lkiWxvgFmDuug3uR3C6RYE0H5Tw4gzabSFHCzuau/LiHt3nMPZN3zmzkkT2qZVt1YdKZCJ
	qUISTFzX6OMvhAAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762253641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dbVY/VBqk2zvjO5PdxoPmUFEkfs061ELl9sM5HumuOM=;
	b=tB2Hs0BJrBJDXILIjdtq8kcNXqgGd0Mp6BzN0QaLC3tF2Z4+fidBQ37qN4HJr/t0Mksvil
	uJ199Pn0gpJzR/EeaJnW3coiInA9bKAM6f1aB3wInY1MCuLrjIqEijth3FKmMJkhzWPWJ4
	S0SzIN4tVk9Di7FsKDDysM1/PDVerxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762253641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dbVY/VBqk2zvjO5PdxoPmUFEkfs061ELl9sM5HumuOM=;
	b=lkiWxvgFmDuug3uR3C6RYE0H5Tw4gzabSFHCzuau/LiHt3nMPZN3zmzkkT2qZVt1YdKZCJ
	qUISTFzX6OMvhAAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A96A139A9;
	Tue,  4 Nov 2025 10:54:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3YUeIUnbCWn4cAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 04 Nov 2025 10:54:01 +0000
Message-ID: <58eb1762-342d-4729-bfe4-8c79ef63f913@suse.de>
Date: Tue, 4 Nov 2025 11:54:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] nvmet-fc: use pr_* print macros instead of dev_*
To: Daniel Wagner <wagi@kernel.org>, Justin Tee <justin.tee@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org>
 <20251028-nvmet-fcloop-fixes-v1-5-765427148613@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251028-nvmet-fcloop-fixes-v1-5-765427148613@kernel.org>
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
X-CRM114-CacheID: sfid-20251104_025403_605929_CD620665 
X-CRM114-Status: GOOD (  13.33  )
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
> Many of the nvmet-fc log messages cannot print the device used, because
> it's not there yet:
> 
>    (NULL device *): {0:0} Association deleted
> 
> Use the pr_* macros consistently throughout the module and match the
> output of the nvme-fc module.
> 
> Using port:association ids are more useful when debugging what's going
> on, because these match now with the log entries from nvme-fc.
> ---
>   drivers/nvme/target/fc.c | 48 +++++++++++++++++++++---------------------------
>   1 file changed, 21 insertions(+), 27 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

