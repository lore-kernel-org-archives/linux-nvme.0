Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F51CD8C85
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2026 06:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PKE/uJBVyB0X5nsgiFUDFtCb4ApOZevyMfjAVJep4rg=; b=fkYjsUjah4tUFwQMghV0xhkZJ1
	iduNVWzwzTcRn0WCtpwn/ow/K1TGJw9cEqatun3ZcKvuJ8qCGoRqiguQ8AdRhmJBeB2TfG4jAkNj0
	TSdl8q4EnaZAEm8LiEg7oZ+3zWc/CyH3MUmPbfsL0k+HGrAWLRzjAzLgi9CtEY368cnWMPrWG2FIp
	JZy2KKSFXnakhDuB+WBPTT44HE4SSY0lV7MaBLzZ2dPVhyuf4/AuJEaVqiuT3tBtUut9308xlhPbq
	pqUEsgZptV91Z5/rRmWd7NjuyAQMhR9Dfy5irwJ7/2lpkXen2yjFTLGXM4OtaHr2OBsnsqbGntgvL
	jC5TTBdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWq2D-00000004sl4-3mg6;
	Tue, 09 Jun 2026 06:34:01 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWq2C-00000004skv-16kj
	for linux-nvme@bombadil.infradead.org;
	Tue, 09 Jun 2026 06:34:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=PKE/uJBVyB0X5nsgiFUDFtCb4ApOZevyMfjAVJep4rg=; b=rakIp/BlIsr2MT8Lqvm78x7kHz
	jko/FFdbwW38LC8YGxD9jzRa0nbzEAOvwxlD7D+ICNy7Ltxljzj8JtO6FQHApFwtsIt8ZDahjcXW8
	aSbWSxlE8Bm44nLFmRuBk64qjgQio22niTsR0+OUjkGFP6rnC2wECyQ3CsbWYwxMxb8rRG6QQsSiY
	kB/N3KplYQRNy7D+xY+QtO8Iz+ybdvpiBGtCwklwgqY3XgdiTA+1EOPY12fF8g8LQcOswKOa9HK2l
	R1l7TqITD1giIsNSbCMm9c43sWrCWL3X9AmeKaXEl+EBnx8KLb/pnxSR3HB63y2JZ1y2tzcujbQKg
	dLudb9xQ==;
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wWq28-000000022WR-2fvh
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jun 2026 06:33:58 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CCBAB7592E;
	Tue,  9 Jun 2026 06:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780986834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PKE/uJBVyB0X5nsgiFUDFtCb4ApOZevyMfjAVJep4rg=;
	b=lKukEZ87WWZmMipW14oKd7IhQm4fBnD5z5ctJNtn8hFmJmZjtoiZfCUUBot+0jUeYdPKLk
	/CWBlr8/7e7Oh2nmgY6kZgG5HXegnSx0f5/Unc2MZg+WPz4bs9wzBGCWvzArgnSWWIaOPX
	4TudyXUP9Uk/E/4mx7t5xUqqiIxgUS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780986834;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PKE/uJBVyB0X5nsgiFUDFtCb4ApOZevyMfjAVJep4rg=;
	b=QHhtorVoQUFH+xxQ7+SaTamZTisHr8Hb2pX4X2O6JHW6DYb2H064FXyYQqWAugqJchSgb0
	nd+Dij86ZrIpw5Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780986832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PKE/uJBVyB0X5nsgiFUDFtCb4ApOZevyMfjAVJep4rg=;
	b=hFGuxsAa0fiKdlWgGQ64jSSnHiO2GYSYcjGAMZ5FbJLZZRNRXrLXqR0+G3OcbLVBUMAllm
	cy3ziTM8tQ7TcXN8HaAANFk3YoESL6V6CkTrSRMC8YNde7lfr0KZAVXV0uQ0GVCtTHDCDR
	B5HLrKg9IcnmR1GZr1z/RgCwr6WF8tY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780986832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PKE/uJBVyB0X5nsgiFUDFtCb4ApOZevyMfjAVJep4rg=;
	b=VJ07OCIEqFLFTnFasawkxz8V90kT9RgZK+wrs1Z0AAzC/7ndDZ3CtsRQ+HrCUJwJxAiMA5
	O1uVKxBeq1UG8NDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94C62779A7;
	Tue,  9 Jun 2026 06:33:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yxStIs+zJ2qBaAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 09 Jun 2026 06:33:51 +0000
Message-ID: <e578fbb5-2184-4052-a9db-b363ae758e3c@suse.de>
Date: Tue, 9 Jun 2026 08:33:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] handshake: Require admin permission for DONE command
To: Chuck Lever <cel@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>
Cc: kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20260605-tls-session-tags-v1-0-47bd1d94d552@oracle.com>
 <20260605-tls-session-tags-v1-1-47bd1d94d552@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260605-tls-session-tags-v1-1-47bd1d94d552@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[29];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org,linux-foundation.org,queasysnail.net,kernel.dk,lst.de,grimberg.me,nvidia.com,brown.name,oracle.com,talpey.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RLh3g55kcpku8oef9ktzra4k57)];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[oracle.com:email,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,oracle.com:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260609_073356_970955_E51778BF 
X-CRM114-Status: GOOD (  17.18  )
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

On 6/5/26 19:34, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> ACCEPT and DONE are the two downcalls of the handshake genl
> family, both intended for use by the trusted handshake agent
> (tlshd). ACCEPT already requires GENL_ADMIN_PERM; DONE has
> no privilege check at all.
> 
> The fd-lookup in handshake_nl_done_doit() only confirms that
> some pending handshake request exists for the supplied sockfd;
> it does not authenticate the sender. An unprivileged process
> that guesses or observes a valid sockfd can therefore submit
> a DONE with HANDSHAKE_A_DONE_STATUS == 0, leaving the kernel
> consumer to proceed as if the handshake succeeded. A non-zero
> status on a forged DONE tears down a legitimate in-flight
> handshake before tlshd can report its real result.
> 
> A subsequent patch teaches the DONE handler to carry session
> tags consumed for access control. That work makes closing the
> existing gap a prerequisite, but the gap itself predates tags.
> 
> Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   Documentation/netlink/specs/handshake.yaml | 1 +
>   net/handshake/genl.c                       | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

