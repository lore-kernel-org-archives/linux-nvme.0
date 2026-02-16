Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2D5E7BDB5
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Feb 2026 12:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mYADfaAlwixB4zFa6rp0jPqtTVQr1WupR7KCi1DDDTo=; b=DnGj7UIlBuRJSMd/OslFsXr5o4
	zjnsXCgEp1TXMS6zx2FDdGFfNdVonfyMb1jjCgROOi90QpltlGUs/VzmIU83SPBWPT1J0xt1y/F8P
	hnK/rPp/ZEH/4jiUfOk7bvem7QGm4wxr41FeZgt01e9YtyISoL93pBM5DTd5+U3oddPUgZSpHvTCC
	vmBKA+fbAVWhthZL5gXgLNte1RuwifMm4hS6HHmOhgjk78RFED1XA/79A8dZs5FGY/gxIPucgofwp
	0eneMrILDK0EuD+gLXLew3pnchNeKS+vmkRkkWjpvutDhCnNwtbexkGKeTUIgbYWMOlhbyHyGn/Tu
	Hf/AbNfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrxn6-00000006WE0-3oJv;
	Mon, 16 Feb 2026 12:33:28 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrxn4-00000006WDU-0SAz
	for linux-nvme@lists.infradead.org;
	Mon, 16 Feb 2026 12:33:27 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 062AA5BE73;
	Mon, 16 Feb 2026 12:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771245202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mYADfaAlwixB4zFa6rp0jPqtTVQr1WupR7KCi1DDDTo=;
	b=IIjNgxUz7eNjtL/RNife46AdvaW5hGmIuAcqXT5Pjci/tnkdpQ+F4V/vQr8ccoGPac5aoG
	YnLReSXQMrYuDU1IndecLXFfi5HsQO2FMbFEYDustbLMju+342XXPRAnowmtQL4xsKT5fA
	a2m10s87r00Bey3KlwwuZJ+JSe43xXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771245202;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mYADfaAlwixB4zFa6rp0jPqtTVQr1WupR7KCi1DDDTo=;
	b=eUsh4UdFiDe6qNTNL4Uf7hDqB8vqZm7Lk5tfTjTX6SmIDMjEb1J4R0dJUt9EziZuFKW2ct
	UmkkAoX8x5JeHwBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pPDdmaSR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YnCyshHa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771245201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mYADfaAlwixB4zFa6rp0jPqtTVQr1WupR7KCi1DDDTo=;
	b=pPDdmaSR6N47NAm8MPtK22OtnybgBg0+7BWgdbn0znAGr/SqnM8rfUEd+s41VepwKOHQT5
	KAOWVIFqwogYFDZ5L0ag8y7DnjvZNnQCxJIQHSsYPyEdWEL4OuIxrxRHtYWJYEux1sdPNV
	BZTBCiC7NYxT9JFuQQeBp7OSy80HOJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771245201;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mYADfaAlwixB4zFa6rp0jPqtTVQr1WupR7KCi1DDDTo=;
	b=YnCyshHamkIEPj2NoT8dQJusW0+D3ASUXdw3/qxf/x8lzgMdcId1FSjsB8l476pVcQlqJP
	u1ZLbzQheqnNkJDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D1973EA62;
	Mon, 16 Feb 2026 12:33:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +b2iBI8Ok2kqNAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 16 Feb 2026 12:33:18 +0000
Message-ID: <7575cb2b-7af5-4748-9ae3-c0906c6dc2d6@suse.de>
Date: Mon, 16 Feb 2026 13:33:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/21] nvme: Introduce FENCING and FENCED controller
 states
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <jsmart833426@gmail.com>
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
 <20260214042753.4073668-8-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260214042753.4073668-8-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[purestorage.com,broadcom.com,gmail.com,nvidia.com,lst.de,kernel.dk,kernel.org,grimberg.me];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 062AA5BE73
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260216_043326_352145_958C98FE 
X-CRM114-Status: GOOD (  14.95  )
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

On 2/14/26 05:25, Mohamed Khalfella wrote:
> FENCING is a new controller state that a LIVE controller enter when an
> error is encountered. While in FENCING state,inflight IOs that timeout
> are not canceled because they should be held until either CCR succeeds
> or time-based recovery completes. While the queues remain alive requests
> are not allowed to be sent in this state and the controller cannot be
> reset or deleted. This is intentional because resetting or deleting the
> controller results in canceling inflight IOs.
> 
> FENCED is a short-term state the controller enters before it is reset.
> It exists only to prevent manual resets from happening while controller
> is in FENCING state.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/host/core.c  | 27 +++++++++++++++++++++++++--
>   drivers/nvme/host/nvme.h  |  4 ++++
>   drivers/nvme/host/sysfs.c |  2 ++
>   3 files changed, 31 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

