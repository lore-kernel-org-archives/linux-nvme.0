Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A390EC25B75
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 09:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VrBT7xJ044xkemWbB5t2tsjwBtffDaaz/XKFWc/rdKc=; b=g8NkIKwQbmirzKsZFuKq8IAopu
	OsXIkY6v/TG5+FbGsSgFqcEU+wQH2offpi2X6y5OhCbZGlU19THXZ6IkCocM/G+kHI/ECFf+M0BUv
	QOT0K/wfzLHRenq5lwOZKroOOmoCxDNyhAPbrMHtES0FoY+SD9LN3tyPYqHvt82C8JQilssiiCLSL
	D4gt4cwV4LuoXa7hI7jkLaZGXmTUv9dWeW3YQnVL4CF5SuCLkzAXMYOXSuUK9sMphZUBJv+iXCPVN
	AWFCmwucXMmLW5ZT2dD4oNp/fshcApMhcdJH2opdTs9YPiSTRQPlkGS3niSoM9gvjQh/tSJ31Zj+S
	Kq6HDUlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA4rq-00000005iFd-2Ive;
	Thu, 23 May 2024 09:36:10 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA4ri-00000005iBV-0PYG
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 09:36:08 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DE2792007E;
	Thu, 23 May 2024 09:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716456955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VrBT7xJ044xkemWbB5t2tsjwBtffDaaz/XKFWc/rdKc=;
	b=Sv7ndMEvamga+tZ5JdYklgKhtVCTXTseswQXklCZPP+/4E51PnduLO2hKLrKPHDzyEo5SQ
	oj5N6i2xKWJsaanAXU500MhcY3Go44+90HviQyq25ioEG6s3JjSNQgGH+aAZaKD59vacfY
	o027yDFguB7dU/4mfX37xz32ElfDs0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716456955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VrBT7xJ044xkemWbB5t2tsjwBtffDaaz/XKFWc/rdKc=;
	b=qIQfO1S58MJrsUGO9PbE5NngeXZDMYime61AJOp/l93R9LB0fv/pD1WKthbt8Ceumqn+J6
	T6HvqNwaPzaDJCCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716456954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VrBT7xJ044xkemWbB5t2tsjwBtffDaaz/XKFWc/rdKc=;
	b=0/1n6AChY71n994Nf6PWOb1HqfIvi2RRni5B10zDE5l6DYfcA7/k4EH76voVHvu9HuL5DY
	6szEtUc9x78QNpZUBLfECeX6JORu8rP4zk/ZAm3o4gf3PHxI5UOEeoiWKxKY8lY1TKRw3H
	Ckcl90Z3wuRnDSewRmYKDEu04W1fG9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716456954;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VrBT7xJ044xkemWbB5t2tsjwBtffDaaz/XKFWc/rdKc=;
	b=fKY6FDJCutVDeRfEMIdqIAKT/nn3By/M1O6ACjHtVVfXcPQ2phgxRhJsMukjIIqWo9OysX
	f1TlKJnMvxjKAnAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8C4E13A6C;
	Thu, 23 May 2024 09:35:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 60dmMPoNT2aSfAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 23 May 2024 09:35:54 +0000
Message-ID: <f80ee1f7-fcdb-48b9-a847-6342dda0ede2@suse.de>
Date: Thu, 23 May 2024 11:35:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] nvme-fabrics: factor out auth code into helper
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
References: <20240208062427.31255-1-kch@nvidia.com>
 <20240208062427.31255-2-kch@nvidia.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240208062427.31255-2-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_023602_361663_910BCA32 
X-CRM114-Status: GOOD (  10.40  )
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

On 2/8/24 07:24, Chaitanya Kulkarni wrote:
> Post connect command authentication handling code is repeated into in
> nvmf_connect_admin_queue() and nvmf_connect_io_queue().
> 
> Add a helper to handle post connect command authentication helper. Use
> the same helper in nvmf_connect_admin_queue(). This also removes
> authentication specific code from a build where authentication feature
> is not configured.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/auth.c    | 32 ++++++++++++++++++++++++++++++++
>   drivers/nvme/host/fabrics.c | 25 +------------------------
>   drivers/nvme/host/nvme.h    |  8 ++++++++
>   3 files changed, 41 insertions(+), 24 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes



