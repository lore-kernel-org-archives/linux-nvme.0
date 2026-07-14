Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF3BC43458
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2026 13:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l+Kb2nZzySndJje+F5hWGfUhvK2f2NqcjG7mK14L338=; b=K2kSquAXdnk1phGJ9Giig8YJjj
	2AkXw9u+0I64Z0O/GnQ871vyBdJkdIlmDqQESVUSymShuf98wXuqbZKUbJEcC3g8PkA3UgAaNWbzf
	mpFu78SSEpg5GuEt+mW1f1pSpcrWScz4v2zqT4ydWTYECS+r40h/ui/PjeVdqxzU1hBPt6xhve05D
	qZ9i4BKPRmy+4KTSIU1OfgaUuDLK0jHvH7PVMbXoTPOJWQq5c7t2ZU88YaJKIBzDX/77oiz/7GNCO
	zlbYkZtKmlZtUqNmRCGWlPPINNV3TxMnEir9A2pKiB7zVh96Z82ZUZGTTAgWIEgx12SV77IWK45at
	KpEladvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjcwI-0000000C7Wu-0J3I;
	Tue, 14 Jul 2026 13:12:46 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjcwD-0000000C7Vd-0OJm
	for linux-nvme@lists.infradead.org;
	Tue, 14 Jul 2026 13:12:44 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D304477E70;
	Tue, 14 Jul 2026 13:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784034757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+Kb2nZzySndJje+F5hWGfUhvK2f2NqcjG7mK14L338=;
	b=t5n0FP0fQVJaB9wzDf5vh40/0zBXdYKy8UMmCKYvRg+8pX3kOSaqFwIy2rtaAX1dhL56s5
	C4Ju/xfgy7dJY59TK4ZAo9EtbbMV6TR0ZXKmqdd69SO6hSxTGfJqf8Fe6Z9uR/r8AXBNpJ
	Ji6zulp0UNo66uMphtB1BsZncP3zB7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784034757;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+Kb2nZzySndJje+F5hWGfUhvK2f2NqcjG7mK14L338=;
	b=t07j7Hw60QKOkcxM0rAnITcbLpcOt32nE/llqJ9oS8pT1K1Rh9OgGiWlV2NAJItaClNupt
	8PqKq2fIrlIVYRBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784034757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+Kb2nZzySndJje+F5hWGfUhvK2f2NqcjG7mK14L338=;
	b=t5n0FP0fQVJaB9wzDf5vh40/0zBXdYKy8UMmCKYvRg+8pX3kOSaqFwIy2rtaAX1dhL56s5
	C4Ju/xfgy7dJY59TK4ZAo9EtbbMV6TR0ZXKmqdd69SO6hSxTGfJqf8Fe6Z9uR/r8AXBNpJ
	Ji6zulp0UNo66uMphtB1BsZncP3zB7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784034757;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+Kb2nZzySndJje+F5hWGfUhvK2f2NqcjG7mK14L338=;
	b=t07j7Hw60QKOkcxM0rAnITcbLpcOt32nE/llqJ9oS8pT1K1Rh9OgGiWlV2NAJItaClNupt
	8PqKq2fIrlIVYRBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4686779AE;
	Tue, 14 Jul 2026 13:12:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2XAnK8U1Vmq+TQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 14 Jul 2026 13:12:37 +0000
Message-ID: <f47bdb78-e19c-440a-bbcb-71cb4cdfb5f1@suse.de>
Date: Tue, 14 Jul 2026 15:12:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: don't reference NS after unlocking in
 nvme_ns_head_ctrl_ioctl()
To: John Garry <john.g.garry@oracle.com>, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com
Cc: linux-nvme@lists.infradead.org
References: <20260706125402.615277-1-john.g.garry@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260706125402.615277-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,oracle.com:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_061241_291496_F8977297 
X-CRM114-Status: GOOD (  10.48  )
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

On 7/6/26 2:54 PM, John Garry wrote:
> In nvme_ns_head_ctrl_ioctl(), once we drop the SRCU read lock we should
> not reference the NS to lookup the controller, so use the available
> controller pointer directly.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> 
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 664216eece4a6..d5a8f375953bc 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -699,7 +699,7 @@ static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
>   
>   	nvme_get_ctrl(ns->ctrl);
>   	srcu_read_unlock(&head->srcu, srcu_idx);
> -	ret = nvme_ctrl_ioctl(ns->ctrl, cmd, argp, open_for_write);
> +	ret = nvme_ctrl_ioctl(ctrl, cmd, argp, open_for_write);
>   
>   	nvme_put_ctrl(ctrl);
>   	return ret;

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

