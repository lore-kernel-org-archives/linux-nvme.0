Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BB2CA0ED3
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Sep 2024 11:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y6Db/bu9rCzS9M4VDYlphe1O+3od8g6Yi36B/DGcrqE=; b=rwTn0byBvt13lw72jj4MLNUaCU
	O6t9hklhrn652oot12Vt3zR/AGCQ2fqv8PpfId20Y07/PRtXsYO4TE9t7z9K3ciWuyZKhbMi5oCvA
	PWGpI2saGwc8QTwMSwnErOKndWBL7uUbLjOXYRrH36zAOpQPnCXhjPiiDs5zPAkzYRmPYQa7xtZ2h
	MgCDXSfz0gIKzrMLJZuGZ3USNkp7gv0dn4zjdi5TiF+sohX3HdvSLyUWvxPqh2YWWB8+MMMiyhT1e
	eW/LXxJQ3AWsTN9vfodjvvDZ384vv08x/v4cjCHw1zuBYGie4rvXtVJ1znNbMDgUALIcX8xzOTDce
	bgfn3fWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl5GN-0000000E7mA-43aF;
	Mon, 02 Sep 2024 11:30:27 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl449-0000000DrKO-30s4
	for linux-nvme@lists.infradead.org;
	Mon, 02 Sep 2024 10:13:49 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E45C01F78A;
	Mon,  2 Sep 2024 10:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725272024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y6Db/bu9rCzS9M4VDYlphe1O+3od8g6Yi36B/DGcrqE=;
	b=LSGG3Ow/hQQx856AVBUPOiDP8d7mLxCm5skpKkhRLrjOl/mzte4c8P5FAUmodtNxzH+Ixy
	v9XmfiVIVTTjVMVssDS5js6oLCJ6+z/+TLA6pOdGC+kAdhoveVyTMWYhKBGorlH/W2zW+C
	nO1nAl9U58iPDU3owhdEXT7hWVywAOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725272024;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y6Db/bu9rCzS9M4VDYlphe1O+3od8g6Yi36B/DGcrqE=;
	b=6M+wEdXwtpn2DLmt9fFPU4XTwvy4gf73dL8OK8JwrB+5Ey+ahsrBELsF4a0OrPTW8htoDL
	+tViXPu9xZJY08Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725272023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y6Db/bu9rCzS9M4VDYlphe1O+3od8g6Yi36B/DGcrqE=;
	b=EYfKmYeUREfctBuIZqWHx99dquOjcfeqWyXRKisiXOpsIZrKjWqpP8VvHcMp+hFXKC8TCP
	ulg6oA52V4oDgJGGYOeXFWY3BjcwV1XTjFei477MqqapP31iFhVUIS+QxPEHf/M+17sBZn
	oz4BCzZ5Wva/t7e7Cx3N0F3T1v5r9/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725272023;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y6Db/bu9rCzS9M4VDYlphe1O+3od8g6Yi36B/DGcrqE=;
	b=G5Dt1urrnqiZmZ73tatcea24eX++UTsM0cdayoVxnsDgXIps72O6LOXOVywgljfAEwRkql
	52yMdoWZpCub/JAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D219813AE5;
	Mon,  2 Sep 2024 10:13:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZLjaMteP1WY/YgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 02 Sep 2024 10:13:43 +0000
Message-ID: <0b1e7924-78e8-4fc6-bcec-a55b246b13e1@suse.de>
Date: Mon, 2 Sep 2024 12:13:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvme: move hidden device and multipath handling out
 of nvme_update_ns_info
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Martin Wilck <mwilck@suse.com>, linux-nvme@lists.infradead.org
References: <20240829063142.2048109-1-hch@lst.de>
 <20240829063142.2048109-3-hch@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240829063142.2048109-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,lst.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240902_031345_935172_F5011123 
X-CRM114-Status: GOOD (  11.18  )
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

On 8/29/24 08:31, Christoph Hellwig wrote:
> Turn nvme_update_ns_info into a pure multiplexer and move the real work
> into nvme_update_ns_info_generic and nvme_update_ns_block, which allows
> to set the flags more coherently while the queue is still frozen.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c | 55 ++++++++++++++++++----------------------
>   1 file changed, 25 insertions(+), 30 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


