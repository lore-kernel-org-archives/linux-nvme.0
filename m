Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E052AFB3D03
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Mar 2026 10:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D+PvFINlm0q8uC458q0kngZxQAI9x8UUOiDVxzmXaJE=; b=AoTfn/CmrHKAwb0DFdDU43d4uC
	uHh3ymDv7wOnJye+KJyyu6qyyuy3bQUkEwSjslMts0lFqTjVqWw3Tr2SPhL6jcmou7k18i7MYy6dR
	7+sq80T57VS7wjgARQx6z/fqROpmhBjWVH8yKgpYDpD1rBWuzNXP+m/J7Acboo8OhxsQNNVvzJ2Aw
	Wq5+o39nexE19pf9nHCEgJcQ/U3TkF4LdWMaJLSSvHlWRbkqL735AQUUCe10x+jZpUb+QwiGmemmj
	3mTUY45Otn/uExthPasI4+VAL/yvwrzDhV/8s/EYeYGBrmtm69r+E90vzhJV6F+FfSKJ64DauA9eL
	48XkfCGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w79zz-0000000B4pO-1WDT;
	Mon, 30 Mar 2026 10:37:35 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w79zs-0000000B4o8-3bhS
	for linux-nvme@lists.infradead.org;
	Mon, 30 Mar 2026 10:37:30 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 674FB4D1F1;
	Mon, 30 Mar 2026 10:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774867045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+PvFINlm0q8uC458q0kngZxQAI9x8UUOiDVxzmXaJE=;
	b=a5EQvbiZJ7eX9Fr5qrzYVNZ0zxLLH+71q2znxv/CQgaE1O387VaAeVtT0XyaMN1muwbJfD
	qEQ05tVpy1GhGO4WG07vF7Y2mPRjamVa/dWApepljfqiQKz4Z4dmrgKlZ3PAw3ZqHdt8JA
	mPKsod8tE1a8YtHGaVMB4dR/FMplGsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774867045;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+PvFINlm0q8uC458q0kngZxQAI9x8UUOiDVxzmXaJE=;
	b=CBKTkUGD5Zw0BMjGMoRreK+6UnQjlwEEmRM9odmC2Aj31pjgg0NeWlEdUgds+BkTVESObM
	me6ukMm5pXec6CAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=a5EQvbiZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CBKTkUGD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774867045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+PvFINlm0q8uC458q0kngZxQAI9x8UUOiDVxzmXaJE=;
	b=a5EQvbiZJ7eX9Fr5qrzYVNZ0zxLLH+71q2znxv/CQgaE1O387VaAeVtT0XyaMN1muwbJfD
	qEQ05tVpy1GhGO4WG07vF7Y2mPRjamVa/dWApepljfqiQKz4Z4dmrgKlZ3PAw3ZqHdt8JA
	mPKsod8tE1a8YtHGaVMB4dR/FMplGsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774867045;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+PvFINlm0q8uC458q0kngZxQAI9x8UUOiDVxzmXaJE=;
	b=CBKTkUGD5Zw0BMjGMoRreK+6UnQjlwEEmRM9odmC2Aj31pjgg0NeWlEdUgds+BkTVESObM
	me6ukMm5pXec6CAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 208304A0A2;
	Mon, 30 Mar 2026 10:37:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OL2EB2VSymleaQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 30 Mar 2026 10:37:25 +0000
Message-ID: <e8b54cbf-b854-477f-9ab9-164268fce443@suse.de>
Date: Mon, 30 Mar 2026 12:37:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/15] nvmet: Rapid Path Failure Recovery set
 controller identify fields
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <jsmart833426@gmail.com>
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260328004518.1729186-1-mkhalfella@purestorage.com>
 <20260328004518.1729186-2-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260328004518.1729186-2-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[purestorage.com,broadcom.com,gmail.com,nvidia.com,kernel.dk,kernel.org,grimberg.me];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 674FB4D1F1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260330_033729_047368_2168835F 
X-CRM114-Status: GOOD (  12.45  )
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

On 3/28/26 01:43, Mohamed Khalfella wrote:
> TP8028 Rapid Path Failure Recovery defined new fields in controller
> identify response. The newly defined fields are:
> 
> - CIU (Controller Instance UNIQUIFIER): is an 8bit non-zero value that
> is assigned a random value when controller is first created. The value
> is expected to be incremented when RDY bit in CSTS register is asserted
> - CIRN (Controller Instance Random Number): is 64bit random value that
> gets generated when controller is created. CIRN is regenerated everytime
> RDY bit is CSTS register is asserted.
> - CCRL (Cross-Controller Reset Limit) is an 8bit value that defines the
> maximum number of in-progress controller reset operations. CCRL is
> hardcoded to 4 as recommended by TP8028.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/target/admin-cmd.c |  5 +++++
>   drivers/nvme/target/core.c      |  9 +++++++++
>   drivers/nvme/target/nvmet.h     |  2 ++
>   include/linux/nvme.h            | 10 ++++++++--
>   4 files changed, 24 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

