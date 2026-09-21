Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD05CC982EE
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 13:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IsHgzpy/Sl3GscephIYavlJsW/MGoMLXO4ABREtdToo=; b=3kF7TT78scGKKZj6IcucqLeidS
	Lfnz2vjz0gdkP0ZIoaoYYZwDMgdIdWLdFojKt+TrZ2NcUeeFOmS6NyneMArPTZmTgJNX/6kpUFChZ
	Z4ZxucaD7omL+7HjwQluaeP6yP2wxot+bqbdA+jVxmqiqdPUOg+xE1j2znVobb6iW0nYPa1novvXW
	St4hn6urkc3X+mkt2+0tdkkbXhUagU3y5jFXRLK/9NQqzHrH5mZdfrb0xAOefAbFpcy695KNBuE9r
	A5UBkWxntLoqF5JLkcMuqRdVDTe2BAULjLoS+w+OYWDFvJHjS8//uhraSt0DA12XtxrJfxpAdQU53
	rykU83Sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8e98-00000002Fcw-3KvG;
	Mon, 21 Sep 2026 13:33:26 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8e93-00000002Fbe-2yrN
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 13:33:24 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 533311F816;
	Mon, 21 Sep 2026 13:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789997595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IsHgzpy/Sl3GscephIYavlJsW/MGoMLXO4ABREtdToo=;
	b=aRbxGTxV0zKGRo7+m1eVVPa+WVLjA7zvQPC6oPy9zBMzFkRB1beqggNfP9KpoPYJh9dPwG
	fLcFBSE2JIaXS/qBHIwEX7BD0C/Ohyfit+pZCbZDjcTw2CSCfy3vTyDf7qbeD1Tj1zJ6IC
	BiBoGwlL+OCYsmtj3oQFBO24blhNL80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789997595;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IsHgzpy/Sl3GscephIYavlJsW/MGoMLXO4ABREtdToo=;
	b=zLc37psQuAOFVgFx+6gFQd+L38CJ2w4D6NSmkB0WrKzOzh9lIoUKYktUHbe7TxSdKfGGpB
	3K86gLRo+gVSAFDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789997591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IsHgzpy/Sl3GscephIYavlJsW/MGoMLXO4ABREtdToo=;
	b=CZNbe6dQLFbj1hlZanWBXqoUyA8BfWaZXRZS6XeiC9u5e1pEbIOA5blErM3v5E112jFqVw
	6h7hnM8Iy7YAvj2ATcbRSxGOlpGNju2lrm9u0C1wV+zOsSYd7ZN/HPTRhxrevYhyPP6D2u
	h1Ov6QtSsQHt+BO8SOIchY1yKyt+sEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789997591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IsHgzpy/Sl3GscephIYavlJsW/MGoMLXO4ABREtdToo=;
	b=jBYuAX/k8anLjiURCgNeiLw+bGMSM0c5YRLTVngf01nm+7ewJkRDCHWySgxrxlKSGa1LJo
	+YrNojdZ/E/68fDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6EE271368D;
	Mon, 21 Sep 2026 13:33:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JACjERYysWqrBQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 21 Sep 2026 13:33:10 +0000
Message-ID: <deaf6eaf-3ee5-4d8c-bfed-ac3ab6298c9d@suse.de>
Date: Mon, 21 Sep 2026 15:33:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] nvmet-tcp: unify sockopt with do_sock_setsockopt
To: Geliang Tang <geliang@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev
References: <cover.1786841319.git.tanggeliang@kylinos.cn>
 <d06dd395575d7f639cd8bc3f984692704fd40e56.1786841319.git.tanggeliang@kylinos.cn>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <d06dd395575d7f639cd8bc3f984692704fd40e56.1786841319.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,kylinos.cn:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_063321_937878_843C5C9E 
X-CRM114-Status: GOOD (  13.41  )
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

On 8/16/26 2:59 AM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch consolidates socket option settings in nvmet-tcp by utilizing
> the generic do_sock_setsockopt() helper for options including SO_LINGER,
> SO_PRIORITY, SO_REUSEADDR, TCP_NODELAY, and IP_TOS. This change eliminates
> the need to export and use specialized helpers for each individual socket
> option.
> 
> A key benefit of this refactoring is that it decouples the socket option
> configuration from the underlying transport protocol. This makes it
> easier to extend nvmet-tcp to support other protocols, such as MPTCP, in
> the future, as do_sock_setsockopt() abstracts away protocol-specific
> differences without requiring per-option protocol-specific wrappers.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   drivers/nvme/target/tcp.c | 53 +++++++++++++++++++++++++++++++++------
>   1 file changed, 45 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

