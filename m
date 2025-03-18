Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B19C282EC
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 10:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UtC//Wk5So92EDZ1/8rtKLulhOPoMLt/y1uBzCl4a/k=; b=cn7ufZ5ox3vIopUpErkbshfNvg
	I/gd2HNQ+EXXTjuuw/oorjEq7oMQPytgwEk0zZo/0IG2+fDJTQLOsfw12xfXlq1939IH+h9VaHWNi
	4oBlrpRVZW2K25vUWN4vN14ADGo1P/h+VgwaiZTdiIl7nbW/gAZwjmz0LcJy9G1+NVHhAFlm180T4
	eK6Juxxz4GP74puAFRCrEj2NqE198LjO2EPI73z6WB+db2S3ngT3pE7yVXdjp513AHC6ParoguUP+
	cFUHzvq0Vh+YI7LLSDetqE+qppS7CkUFUFUOX1yQjn8ZQvoe3VXfDRZTtHe68e9JcNTZ9iHNh26/F
	PA+BRBSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUcz-00000005cFR-1p42;
	Tue, 18 Mar 2025 10:56:57 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUcw-00000005cE8-2sIi
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 10:56:55 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 77D3221B85;
	Tue, 18 Mar 2025 10:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742295411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UtC//Wk5So92EDZ1/8rtKLulhOPoMLt/y1uBzCl4a/k=;
	b=bj9MdbBFPmIz2uEqQMdWLLuBZ3ZEJnrjqv6Z2hFhMh0VoJtTwSFyMuMDVBhrmXsCJGqjre
	vg0Pq/A7C0QT4e1Tno0Aozn37Exx1UqrHWr3WN2mcD/mhAKj39/8ZlWhtFBz9aIuxTdqTq
	Gjn9MwRNpE+crTNBGSyytrF38vGng2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742295411;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UtC//Wk5So92EDZ1/8rtKLulhOPoMLt/y1uBzCl4a/k=;
	b=99blsUTtfcQmAeLwHLz6TNtdOfrg8XaLDZ7yIOFlmI9qKl9C895BBi1eEuv4PSLRhsGWSt
	7zUyOXwTcl3/W6Cw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bj9MdbBF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=99blsUTt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742295411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UtC//Wk5So92EDZ1/8rtKLulhOPoMLt/y1uBzCl4a/k=;
	b=bj9MdbBFPmIz2uEqQMdWLLuBZ3ZEJnrjqv6Z2hFhMh0VoJtTwSFyMuMDVBhrmXsCJGqjre
	vg0Pq/A7C0QT4e1Tno0Aozn37Exx1UqrHWr3WN2mcD/mhAKj39/8ZlWhtFBz9aIuxTdqTq
	Gjn9MwRNpE+crTNBGSyytrF38vGng2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742295411;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UtC//Wk5So92EDZ1/8rtKLulhOPoMLt/y1uBzCl4a/k=;
	b=99blsUTtfcQmAeLwHLz6TNtdOfrg8XaLDZ7yIOFlmI9qKl9C895BBi1eEuv4PSLRhsGWSt
	7zUyOXwTcl3/W6Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48CBA13A43;
	Tue, 18 Mar 2025 10:56:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9gNYEXNR2WfAQAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 18 Mar 2025 10:56:51 +0000
Message-ID: <e94a7fab-3811-449b-9999-7641b9274b07@suse.de>
Date: Tue, 18 Mar 2025 11:56:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/18] nvmet-fcloop: replace kref with refcount
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
 <20250318-nvmet-fcloop-v3-2-05fec0fc02f6@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250318-nvmet-fcloop-v3-2-05fec0fc02f6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 77D3221B85
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_035654_878698_0E682100 
X-CRM114-Status: GOOD (  10.93  )
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

On 3/18/25 11:39, Daniel Wagner wrote:
> The kref wrapper is not really adding any value ontop of refcount. Thus
> replace the kref API with the refcount API.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fcloop.c | 37 +++++++++++++------------------------
>   1 file changed, 13 insertions(+), 24 deletions(-)
> 
Can you split this in two, one for the nport and one for fcpreq?
That way it's easier to follow what has been modified.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

