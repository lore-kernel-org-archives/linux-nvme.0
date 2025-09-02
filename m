Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39D1CA1005
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Sep 2025 06:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XyXPUrsPYBj1Ky4K5J5VMp11z3VWGs5TBLG8tgWyook=; b=kx87LwYeniKzd2n8fo02UnIB9B
	rsmRfzMQY603PjupqYlJp6Jfxag5j9OiyTXEfhmLF833ivdYnDYNln7xFo/wyvBv0RDAavPYEb8dy
	lpy4UIMLdrG5cPKo0e0wesr1JBEp1f05s4YAXLSaVYZJ9bJc4TgKclAwOSpJmU4S3sZkrF+XExAs4
	q4yNBOPtOIa9ce0E9CP1TXBUweEB0QvmTK3PhS5TvC3r1z0b7Z7aWeOWYiaYIm+sUaTPtYiARKJ5D
	i7g5dKt7AI/nK1evKs0H52GVfQ4VXK1ZAfa9rznV4HOBXLU8t6ZKIHbTFrBO2wDAoBYuy73O3GRio
	BKbOL15A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utKnU-0000000Fb0H-0DPm;
	Tue, 02 Sep 2025 06:47:16 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utKnR-0000000FazN-3PSw
	for linux-nvme@lists.infradead.org;
	Tue, 02 Sep 2025 06:47:15 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5CC061F445;
	Tue,  2 Sep 2025 06:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756795632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XyXPUrsPYBj1Ky4K5J5VMp11z3VWGs5TBLG8tgWyook=;
	b=rUp2AzRS9YM7SP3snjDkaE8NAmfyA/iCKxLfdb8js29lMO6phieelcYYXaPrgQ2B3JjpvZ
	VD03sMhVo4kS9fwDxg04SQCAp71NZOSHOAFbwkXan/4Nom15KvX5vByXcZ4EUeBITreGUz
	76d1AgH4fnc+LhTOIyvuIgYNpkkWfAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756795632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XyXPUrsPYBj1Ky4K5J5VMp11z3VWGs5TBLG8tgWyook=;
	b=Op2aSIdEsbCmJIzqtnL3qytHxt088ANWgNGWQsJILxNNK+XxkPKMthmnbbB/SflbeVVvHE
	3ZgnMg9CwtHG0DAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756795632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XyXPUrsPYBj1Ky4K5J5VMp11z3VWGs5TBLG8tgWyook=;
	b=rUp2AzRS9YM7SP3snjDkaE8NAmfyA/iCKxLfdb8js29lMO6phieelcYYXaPrgQ2B3JjpvZ
	VD03sMhVo4kS9fwDxg04SQCAp71NZOSHOAFbwkXan/4Nom15KvX5vByXcZ4EUeBITreGUz
	76d1AgH4fnc+LhTOIyvuIgYNpkkWfAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756795632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XyXPUrsPYBj1Ky4K5J5VMp11z3VWGs5TBLG8tgWyook=;
	b=Op2aSIdEsbCmJIzqtnL3qytHxt088ANWgNGWQsJILxNNK+XxkPKMthmnbbB/SflbeVVvHE
	3ZgnMg9CwtHG0DAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F38013888;
	Tue,  2 Sep 2025 06:47:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 32XLAfCStmjuVQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 02 Sep 2025 06:47:12 +0000
Message-ID: <b9ee2f1f-f250-4403-81c9-48fdc73221c1@suse.de>
Date: Tue, 2 Sep 2025 08:47:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] nvme-fc: refactore nvme_fc_reconnect_or_delete
To: Daniel Wagner <wagi@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <james.smart@broadcom.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250829-nvme-fc-sync-v3-0-d69c87e63aee@kernel.org>
 <20250829-nvme-fc-sync-v3-3-d69c87e63aee@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250829-nvme-fc-sync-v3-3-d69c87e63aee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
X-CRM114-CacheID: sfid-20250901_234713_995827_4E9B6A70 
X-CRM114-Status: GOOD (  12.35  )
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

I guess the subject should be 'refactor nvme_fc_reconnect_or_delete'

On 8/29/25 17:37, Daniel Wagner wrote:
> Instead using if else blocks, apply the 'early return' and 'goto out'
> pattern. This reduces the overall complexity of this function as the
> conditions can be read in a linear order.
> 
> The only function change is that always the next reconnect attempt
> message will be printed.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/host/fc.c | 64 +++++++++++++++++++++++++++-----------------------
>   1 file changed, 34 insertions(+), 30 deletions(-)
> 
Otherwise:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

