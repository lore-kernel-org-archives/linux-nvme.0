Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B368C982ED
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 13:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J1dL6rLBvXC4CJFioHkXsIRtNedvKcDXmdtDMyAul38=; b=tZnyrUldVrYzMTohqleNZ4iNdd
	0z2oJ6tasKFwQGl1MltNdoyELbDnRDu25agXyQzaia3C5B+Yt07uCQNakLT13BFrKLmcIK0SCQrlK
	2jA91QF4XMritwjpbqAxnBFabr2hu0fFvdx+BaFS6kAHNuSMIiiMhnnSmGBMbj713Dhha4ASQyyuf
	LW80jaCn/5JGe87e79tjb7FfoqioGv3hr1ucNyZo4/q2aDPqxMZOswqg2lTJ0vFw4QCN0+EU6Dhlb
	Vww6WsAZv1Mbz1mo7z9bougJJQe44Jyirt9xBwneTOJD8GgDM3a/lDj0rTQ5tlD7SMtrcuEkMD8tv
	l/aSF7+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8eA7-00000002Fq5-0nyw;
	Mon, 21 Sep 2026 13:34:27 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8eA3-00000002FoG-3LwJ
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 13:34:25 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 086D421AD2;
	Mon, 21 Sep 2026 13:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789997658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J1dL6rLBvXC4CJFioHkXsIRtNedvKcDXmdtDMyAul38=;
	b=i3+8R1FaTSF1s7KDw0oM+mkJBjqyszwnh3OdSeuo+cWM27eJF6lxf8fOu5tvMEsdnFW7ZS
	IOugL+82i58n0knkrDfH1vMndKTngjJhw6C+qSr9KfnW1MCgb7H3KtbSED4NISq1vzlGEP
	FG5f0dMJUODmJ48+lAI1PzY3Kh8sfI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789997658;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J1dL6rLBvXC4CJFioHkXsIRtNedvKcDXmdtDMyAul38=;
	b=AkeSNClQSTtkB6AwWIotm+uzhkOnFkjYg2Wk6t8iJ++lroUOPbH6MszVxg93S0fYEATCpR
	5+Q1KyMBQYFLJfDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789997654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J1dL6rLBvXC4CJFioHkXsIRtNedvKcDXmdtDMyAul38=;
	b=i/cLHPVEs8s9pdOWz7CfjOknBV0yOkKh9Nb0fsS2Z//mlYnV2tzDI2flcZllrfP28HmWhS
	cgZB6t/46OqXScaWXDWEXFUu5IShAc9oK+Me1rfzbFqrO5HyiSc67TL1CCbvGrlq2WhDWH
	sCzliDfIzG8R1ycu4VixixLUzIV2SWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789997654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J1dL6rLBvXC4CJFioHkXsIRtNedvKcDXmdtDMyAul38=;
	b=0Ahz4v1IcEvdDbSVYlGfSTVuJIclLJYg39UHN2IsFc7INnAH6TPgLiRMJUAJHtzLd4/k7Q
	CGkbHFCrWjTiAGCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0583513793;
	Mon, 21 Sep 2026 13:34:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ew7UMVQysWojBwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 21 Sep 2026 13:34:12 +0000
Message-ID: <7054e555-258d-459f-97e0-4ffe99b8d4f9@suse.de>
Date: Mon, 21 Sep 2026 15:34:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] nvmet-tcp: support IPv6 traffic class
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
 <7d09c3211dfa76d536c7a30505cea6da626ee5e6.1786841319.git.tanggeliang@kylinos.cn>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <7d09c3211dfa76d536c7a30505cea6da626ee5e6.1786841319.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLhpsi56b8wki6rd8p6oz1itgg)];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,kylinos.cn:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_063423_996333_BAFF919D 
X-CRM114-Status: GOOD (  11.95  )
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
> Currently, nvmet-tcp only applies the received IPv4 TOS value when setting
> up a queue socket, but does not handle the IPv6 traffic class.
> 
> Extend the queue socket setup to handle AF_INET6 sockets. Obtain the
> traffic class from the IPv6 socket's rcv_flowinfo and apply it through
> IPV6_TCLASS using do_sock_setsockopt().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   drivers/nvme/target/tcp.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

