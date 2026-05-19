Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559A9CD4851
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 07:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aIuSa4Q4dMultZ8PBSbLMyy9WSo6AwaKdXcHKLDBDC8=; b=FwlZ3fnrlwiUXS3bPVCnCyzGgK
	jKg5dEd1RRN8nFVsm2fYRNSYPkuW5bi72dD0xCLk4FokKSUneVz05jS1tPUHosKNEYq4X/cxEIV2E
	zQbWyKYfLffhNN5Oj8Rn9KBKO+yRLoFu/ki4KjA0oIwETLSlpoauwJrKMuDts/EDq6oAt34Ob6Kh3
	caGoVnsL7NYv/s/pMA81kJ+0SIPor12XktUI/vISYRLe47KFMDHkspMC+MdvTRZY4a4J2aKU/OxWD
	7EsTY/98OQvVAkT1ZWXV7QuPZZRdzetT3N415a51S2BIxN7Uj1a48mZLMJ0imvfxoiaydq+jSArza
	B3tKsb7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPFIv-00000000ZyQ-2rZA;
	Tue, 19 May 2026 07:55:53 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPFIt-00000000Zwr-0LEY
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 07:55:52 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 41E0767BE0;
	Tue, 19 May 2026 07:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779177349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aIuSa4Q4dMultZ8PBSbLMyy9WSo6AwaKdXcHKLDBDC8=;
	b=veWnd5gU+IacJtakxKB5Bq8XPrPBybU2tIE8hkMMKOAdihO+GSBQZR8k3K9L6bnimySqeI
	rxEvYgGBKVJY6usR26pgMDrBMmbl4/k8UulRf7LtlyzMduJjGyJtEY8D8Ge6kpdgj2iqPl
	0j9QpsIoN/hN6ckvB0OwjTWBXeA2xZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779177349;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aIuSa4Q4dMultZ8PBSbLMyy9WSo6AwaKdXcHKLDBDC8=;
	b=MvxkyHAxTy0I4vLj366t/wr5Xz5/Dv70kNQvK1NcxhrEhCZnNeQIjb0XIgT60eD/9AuL8S
	OmWpaMScjiFfSEAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=veWnd5gU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MvxkyHAx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779177349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aIuSa4Q4dMultZ8PBSbLMyy9WSo6AwaKdXcHKLDBDC8=;
	b=veWnd5gU+IacJtakxKB5Bq8XPrPBybU2tIE8hkMMKOAdihO+GSBQZR8k3K9L6bnimySqeI
	rxEvYgGBKVJY6usR26pgMDrBMmbl4/k8UulRf7LtlyzMduJjGyJtEY8D8Ge6kpdgj2iqPl
	0j9QpsIoN/hN6ckvB0OwjTWBXeA2xZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779177349;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aIuSa4Q4dMultZ8PBSbLMyy9WSo6AwaKdXcHKLDBDC8=;
	b=MvxkyHAxTy0I4vLj366t/wr5Xz5/Dv70kNQvK1NcxhrEhCZnNeQIjb0XIgT60eD/9AuL8S
	OmWpaMScjiFfSEAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19245593A8;
	Tue, 19 May 2026 07:55:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J7w8BYUXDGrLagAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 May 2026 07:55:49 +0000
Message-ID: <76f6bb7c-c0b4-4dfc-b101-13d0bb7d7f0e@suse.de>
Date: Tue, 19 May 2026 09:55:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/7] net/handshake: Take a long-lived file reference
 at submit
To: Chuck Lever <cel@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>,
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
 <20260518-handshake-file-pin-v1-4-4bbcb7e62fda@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260518-handshake-file-pin-v1-4-4bbcb7e62fda@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 41E0767BE0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_005551_266553_3D3214CE 
X-CRM114-Status: GOOD (  15.43  )
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

On 5/18/26 20:24, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> handshake_nl_accept_doit() needs the file pointer backing
> req->hr_sk->sk_socket to survive the window between
> handshake_req_next() and the subsequent FD_PREPARE() and get_file().
> The submit-side sock_hold() does not provide that. sk_refcnt keeps
> struct sock alive, but struct socket is owned by sock->file: when
> the consumer fputs the last file reference, sock_release() tears
> the socket down regardless of any sock_hold.
> 
> Prepare for a fix by adding an hr_file pointer to struct
> handshake_req and acquiring an explicit reference on sock->file
> during handshake_req_submit(). Release the reference on the
> completion-bit-winning path of handshake_complete() and
> handshake_req_cancel(), and on the submit error paths that destroy
> the request before it has been published.
> 
> The accept-side dereferences are not yet retargeted; that change
> comes in the next patch.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/handshake/handshake.h |  2 ++
>   net/handshake/netlink.c   |  6 ------
>   net/handshake/request.c   | 27 ++++++++++++++++++++++++++-
>   3 files changed, 28 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

