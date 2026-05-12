Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02392CD4851
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2026 14:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3J7CU0OeJ9O9jg81qZWhmHO0hthpveFr+UPeIlsLKTo=; b=cCFF60Kz4K1a0n3u2Ugf7Wrir6
	uI1I/A/1h94cSa/dkD2XI3HslGJVSNwKk6nEuCtyYdyLq+HLXAN5mB1nRhpNSU4ru8avVQGEimOMF
	qcbSJv6CifGI+3XyIOJkkQP/QaeshBDsEunrIkQByIBx97q3PSKx3ynB70bOtjA/z+I+y4V8AMxbf
	cg7BbTrOquiGbOADbu4TQzjq5A3uD/ql2coSFza+lZllDzCwjum88glaUTmCMdm6UNrxRWXoJJl3S
	JhoK9hRiTk1uLskoXCVRmLUi9BNWOwudKjwe4KkJcuGEE9uGmtGmA+d3q1CLPm1JUbIDeSe4AI+JY
	RSyjUU+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMnit-0000000Gwtm-1PXh;
	Tue, 12 May 2026 14:04:35 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMnip-0000000Gwrc-2IjC
	for linux-nvme@lists.infradead.org;
	Tue, 12 May 2026 14:04:34 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 362846C1B6;
	Tue, 12 May 2026 14:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778594664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3J7CU0OeJ9O9jg81qZWhmHO0hthpveFr+UPeIlsLKTo=;
	b=QgrhyGFSZ7RlJtSPhOYxGUYsZ2AY9SxpNcJLlfGsCATyRpcsD3amtYFKJyt7E5v8zD9/ky
	GoPPcgPcIguwZLmlX26uoEIxKA0M856nxncmOJai/IhqHD5Mnr7X59t61mb0/5mRuJLQDc
	AJB1XToRqQmrEl5Ei2110wIreMr2vYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778594664;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3J7CU0OeJ9O9jg81qZWhmHO0hthpveFr+UPeIlsLKTo=;
	b=5e5znqH6q/Vdo98ETX8Ff9lbwN5DYJUnb7nir9q/iAWQoJsRGkPHAs6tvkLJVzk4azSJlV
	2YYhA/2HSav1GlDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778594660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3J7CU0OeJ9O9jg81qZWhmHO0hthpveFr+UPeIlsLKTo=;
	b=N9cCHTDrj1L+ZbKQDUjcN8oEgmAddw0zsZx6ydG1V9J5NihMV3kXerzMAliIqSrktq7iDT
	Df0PlAS51VvZNCHNcVNucBGb9a1pJgAt1ByNb+YyhPag1SnXfAtSdp4ISX38QLOAvDFsaQ
	JBXw1ayglMHBJQ9Ypk1J8dTwG34P8dA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778594660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3J7CU0OeJ9O9jg81qZWhmHO0hthpveFr+UPeIlsLKTo=;
	b=t5rYxb1vMsiqMm72aYas1YRqssLI0s3Bg8V4TM3LokpH6Xxh7ojMdfeDKgsl/HUsFHS3oW
	6Rd8yR/lQheg2bCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3C36593A9;
	Tue, 12 May 2026 14:04:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v/DrMWMzA2oVeQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 12 May 2026 14:04:19 +0000
Message-ID: <04a007f9-0a34-4cf5-9feb-9b43ae591b93@suse.de>
Date: Tue, 12 May 2026 16:04:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme/tcp: release socket on sock_alloc_file() failure
To: Wilfred Mallawa <wilfred.opensource@gmail.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Damien Le'Moal <dlemoal@kernel.org>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20260512102831.3593121-2-wilfred.opensource@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260512102831.3593121-2-wilfred.opensource@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
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
	URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,wdc.com:email,imap1.dmz-prg2.suse.org:helo];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260512_070431_734912_B796B5C9 
X-CRM114-Status: GOOD (  11.46  )
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

On 5/12/26 12:28, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> If sock_alloc_file() fails after a sock_create_kern() in
> nvme_tcp_alloc_queue(), the socket is not released.
> 
> Add sock_release() to release the socket if sock_alloc_file() fails.
> 
> Fixes: e40d4eb84089eae1 ("nvme-tcp: allocate socket file")
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> ---
>   drivers/nvme/host/tcp.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

