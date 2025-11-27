Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61289D11183
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Nov 2025 13:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P8UOz1lx4bQABnsPJotRzictXM7dsqgfz1cF/UHESVg=; b=vN4vaElK0R0svwMtsPPCYvYxGk
	MmS7DP5LumzyOWSqilz5YHxLAenKOOosL6SfKaoR5QvEGsQZ+E8F4TeiKTZI5Ht1dmg9a1Sav2ubc
	znSTT5qvQfpjhoeyv20+b1afip0YC1uDvUodWS+q0LxTN9u9twZPWREWiW6Fk7IYHZDY19fumkOJC
	H64mgkZRb3W0FHpGkYmWd8gpRAM7L+NopT11GACn3TYy33SIlWTxT80kR8tK/7+PTVMBJ0yK4MShm
	1YJzcAWnGiSaer0jeFWdykB3ChS/TY5NkskjN3CNfaEU+xFPRcemWyEx/AcZFMCVV6TM8AwGQv0MU
	iYQaIMRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vObnK-0000000GeHZ-0ga0;
	Thu, 27 Nov 2025 13:12:22 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vObnH-0000000GeHC-1yvZ
	for linux-nvme@lists.infradead.org;
	Thu, 27 Nov 2025 13:12:20 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F222336F2;
	Thu, 27 Nov 2025 13:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764249137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8UOz1lx4bQABnsPJotRzictXM7dsqgfz1cF/UHESVg=;
	b=Q7LZT069FGyDoauMgZjTpX8sfA0cmHnyhroJrgnuIMgAqej0qJ0QcmTT0uTZYWQDT5rj/K
	1osMPlbrxbqvRnErpCN3fRop7u871wW9q6XO0t0nfKA6z17NrJZqZEVoQWp+zVoyOcTDAL
	3yiS+DqdppC1LpqoH6kJ2BDgraETCeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764249137;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8UOz1lx4bQABnsPJotRzictXM7dsqgfz1cF/UHESVg=;
	b=KqxWqbxC3GMWFx+kNR0xS0/5PUETZtYhGNkDMkvUq8sJH5JzzIJ2noF8Abm6rKMstgm0YX
	TQCBAQBS19K/D9BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764249136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8UOz1lx4bQABnsPJotRzictXM7dsqgfz1cF/UHESVg=;
	b=iwwxgqLhraQyZbIG2ojZtyTwjTMPJrNHf/cJSiCsF3PeF5J4lFZ1owgZUY1/9kQN5EwLEi
	UHnbwUKh+4XUC9UuKyiGMz1XMZHjmdV5PqHZ/I1SZbsaeHbDLaUA6YOtXmxxvZDriCz3tN
	i82P0paxlmFoRxCNDp2L8OKm1aNS5MM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764249136;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8UOz1lx4bQABnsPJotRzictXM7dsqgfz1cF/UHESVg=;
	b=sEtM4pKdE4gTvSNTpa3lJ+45lyyhG2KI9X/2BVsaIUCBIKdmzX3/5fKEf/I/Pg5azosv2B
	hCF9MEtAQJOHqoBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CD163EA63;
	Thu, 27 Nov 2025 13:12:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PqFPDjBOKGl3PgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 27 Nov 2025 13:12:16 +0000
Message-ID: <bd570dbc-2844-4720-8a19-a9d508a1e365@suse.de>
Date: Thu, 27 Nov 2025 14:12:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] net/handshake: Support KeyUpdate message types
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
 <20251112042720.3695972-5-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251112042720.3695972-5-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com,kernel.org,lists.linux.dev,vger.kernel.org,lists.infradead.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251127_051219_697983_AD9BB4EF 
X-CRM114-Status: GOOD (  10.74  )
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

On 11/12/25 05:27, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> When reporting the msg-type to userspace let's also support reporting
> KeyUpdate events. This supports reporting a client/server event and if
> the other side requested a KeyUpdateRequest.
> 
> Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v5:
>   - Drop clientkeyupdaterequest and serverkeyupdaterequest
> v4:
>   - Don't overload existing functions, instead create new ones
> v3:
>   - Fixup yamllint and kernel-doc failures
> 
>   Documentation/netlink/specs/handshake.yaml | 16 ++++-
>   drivers/nvme/host/tcp.c                    | 15 +++-
>   drivers/nvme/target/tcp.c                  | 10 ++-
>   include/net/handshake.h                    |  6 ++
>   include/uapi/linux/handshake.h             | 11 +++
>   net/handshake/tlshd.c                      | 83 +++++++++++++++++++++-
>   6 files changed, 133 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

