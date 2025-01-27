Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA08C0218C
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jan 2025 07:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=orhE1P+irRBUwrfjRlb4TM2hg4ZWxRbJCEBmDSP2F8k=; b=DqqCEpNw+ivCN8mJaeS2lJs3Mg
	Sy3trO3AdKPJBXIcuWBCCWdesUxE61LnYdzQhRdhRzgINxVntoOwqqL25oE3hlUrDiLmtNUd/hrT9
	H1sJckVp6HwuWZQdzlf5lJocPL9hwnl+qfYKOY+jEypSu5jKERCS/7j2Kly5kwbSEN5zw8DvjJUMj
	aNNFSgIg5CAWKJXtX53hLGobCMKT6BvILZ3+IInZueAFEX8OZI9w9FW3rUrGnohMQqAW+jFn+ysRG
	8hi5lIL5tMDjcU53qk8mYZQCv1ZSHbWJlxjC6XqnBCOMOvbfqi+300l8ZTIRVDFmnh3Rt4M+2w7Ru
	us7hLweA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcJHQ-00000001mDr-3Zz4;
	Mon, 27 Jan 2025 07:11:32 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcJHO-00000001mDW-1kHZ
	for linux-nvme@lists.infradead.org;
	Mon, 27 Jan 2025 07:11:31 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8D99E1F38F
	for <linux-nvme@lists.infradead.org>; Mon, 27 Jan 2025 07:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737961888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=orhE1P+irRBUwrfjRlb4TM2hg4ZWxRbJCEBmDSP2F8k=;
	b=MKAfaPB7X0yNbAwbn1NRaQj8hS6Sq02ImI4ANLWI++U7LI3qcqF8p0d4SqvYiYP89TppEX
	RNORk4OUblE7ci1PDDn1NqESlX0KrUKtZGE8CcoW3LxsvwF3hdJAIAZ/Uk9SFV0zJhoi1/
	f0pNyPNHDNcnVLerkFggnBuzXv0xOd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737961888;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=orhE1P+irRBUwrfjRlb4TM2hg4ZWxRbJCEBmDSP2F8k=;
	b=RcAz3zRrG6VjiJKZtR3sP81xQgxoLtiuSnaES1SlM4ZzDFUS0agtr8276Xot23a2jvqaKE
	pFGiWSFp9AjiZCBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wbW2MibQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZK8jRoLX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737961887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=orhE1P+irRBUwrfjRlb4TM2hg4ZWxRbJCEBmDSP2F8k=;
	b=wbW2MibQYK4Bi+GAVrALKrAQvJ4euWKu8+fKXtLoZiqzgKQpQEFEiw0eiwGBMwA5iAw/43
	TWoXX8ivz+bIXShZ642SiPNQdxQ1uTrnt7/ZN3n5l/gGjsuUmwkeSKpRVZyb/HyXFTy6U0
	G34boR+7fc7Yl7aNI15whBmdUMkgZWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737961887;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=orhE1P+irRBUwrfjRlb4TM2hg4ZWxRbJCEBmDSP2F8k=;
	b=ZK8jRoLXl2CrOF45ybPd1GqL/86wtaw2EF6Y1Z8NZoYN0xY1KLI9z3l0DrdxzvEIhtteOV
	oxWMGyL01dtVmLBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 746E1137C0
	for <linux-nvme@lists.infradead.org>; Mon, 27 Jan 2025 07:11:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UFGkGp8xl2f0NwAAD6G6ig
	(envelope-from <hare@suse.de>)
	for <linux-nvme@lists.infradead.org>; Mon, 27 Jan 2025 07:11:27 +0000
Message-ID: <feeb723a-79e3-42b2-960f-26eb3eb0b32b@suse.de>
Date: Mon, 27 Jan 2025 08:11:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: fix a memory leak in controller identify
To: linux-nvme@lists.infradead.org
References: <20250124110033.391731-1-sagi@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250124110033.391731-1-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8D99E1F38F
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[grimberg.me:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-nvme@lists.infradead.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250126_231130_615694_C121A8E4 
X-CRM114-Status: GOOD (  14.37  )
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

On 1/24/25 12:00, Sagi Grimberg wrote:
> Simply free an allocated buffer once we copied its content
> to the request sgl.
> 
> kmemleak complaint:
> unreferenced object 0xffff8cd40c388000 (size 4096):
>    comm "kworker/2:2H", pid 14739, jiffies 4401313113
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace (crc 0):
>      [<ffffffff9e01087a>] kmemleak_alloc+0x4a/0x90
>      [<ffffffff9d30324a>] __kmalloc_cache_noprof+0x35a/0x420
>      [<ffffffffc180b0e2>] nvmet_execute_identify+0x912/0x9f0 [nvmet]
>      [<ffffffffc181a72c>] nvmet_tcp_try_recv_pdu+0x84c/0xc90 [nvmet_tcp]
>      [<ffffffffc181ac02>] nvmet_tcp_io_work+0x82/0x8b0 [nvmet_tcp]
>      [<ffffffff9cfa7158>] process_one_work+0x178/0x3e0
>      [<ffffffff9cfa8e9c>] worker_thread+0x2ec/0x420
>      [<ffffffff9cfb2140>] kthread+0xf0/0x120
>      [<ffffffff9cee36a4>] ret_from_fork+0x44/0x70
>      [<ffffffff9ce7fdda>] ret_from_fork_asm+0x1a/0x30
> 
> Fixes: 84909f7decbd ("nvmet: use kzalloc instead of ZERO_PAGE in
> nvme_execute_identify_ns_nvm()")
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/target/admin-cmd.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index e670dc185a96..acc138bbf8f2 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -1068,6 +1068,7 @@ static void nvme_execute_identify_ns_nvm(struct nvmet_req *req)
>   		goto out;
>   	}
>   	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
> +	kfree(id);
>   out:
>   	nvmet_req_complete(req, status);
>   }
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

