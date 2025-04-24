Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CE0C369D7
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 13:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=INeTkgOjLN0k/r+yDqIW8EZ9muScBYK5kQVQV9iDXQw=; b=vzJypYvdznEEcJWCeMyCfqkVsx
	3+9TkZmH5CA9PDw+cxuQSRiKxLcyfRaz5J93qfNOeqUsd69eBBlesD41aOiGHhh3cZFbgDslBskde
	0KDpTMuX9wGrVPoeG5UUDZMHxQ9yKFcA7r0W4IUuZmrH4SsSDR6Y3WjZAPb2MTKaqmBIivCuzk82P
	wxO9YPhsCVEh1OnW/Nj6eThNSzC2E5+qb2sj6ahLOupYKt4DZeTk7P6kKIr09SOnDsmyENjLgGNmr
	OX7I88ACzVPQwKnoBzoGAH17ihqxum8ChZLhQRgej8k9h3sO8sxf43X1RbSio5YFlWExVpDTSInuK
	ethaXaxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7wBb-0000000E7c6-3OeT;
	Thu, 24 Apr 2025 13:00:15 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7uZn-0000000DpMt-405w
	for linux-nvme@bombadil.infradead.org;
	Thu, 24 Apr 2025 11:17:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=INeTkgOjLN0k/r+yDqIW8EZ9muScBYK5kQVQV9iDXQw=; b=b5mqUYZHn2tVV6k1eV5cO8TsKr
	EJh9SCYAmmgCMlA5bKoCawWJbNcIcRzuARogj3r0VhKEdLlxNM9kbDwG5T9jBwu+F+Sik0R8sC0AI
	XSa16TiCYEDDWvQH88filNE6PJBneCc7cg8GbjskRFXD5lDzIgH4p7fZ1aJzVRty/XcRdrE8+Gz19
	vbeaI3ACY3QsVpLUxAnWd+LWZGeHDSpsbyEiPlRL5yINSAEdiwZyqD0RiPk3Rp3023nHjJEj37Q57
	WnJjEf9sgzhO/NRaETlJKd34SgFvp0xCnbBZP/hk15jQA1WVU9xnZXEO9OVEUikjtg0ay8VJ5siHJ
	XH94sIow==;
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u7uZl-0000000BlUh-0sp6
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 11:17:06 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D01F421125;
	Thu, 24 Apr 2025 11:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745493421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=INeTkgOjLN0k/r+yDqIW8EZ9muScBYK5kQVQV9iDXQw=;
	b=Qquh4YNpgV0bV9f0IxlCpUZbdvmAiRsyWsLtCoBNqVqW1wDNLQhffiqGN0rywCi59O6qZ4
	yQg8IreGtW6Q7W+N12mToj/LGPGyRiYvtMJgQnDajTm2Ot26hUgPwJjP92y6sj9aElYXYR
	yMzBHFm1kkFFdbEEm7CS5NFIsSuYS8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745493421;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=INeTkgOjLN0k/r+yDqIW8EZ9muScBYK5kQVQV9iDXQw=;
	b=FCc8tN1m8rrCgPI1vFd0qb/JFaI2e0b04ExJS1M0Xwmc111dY2c//IjncmEFTCblqKbBgf
	xLSsRmlbfDcICBDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1OiekEMZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QhMbUUAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745493420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=INeTkgOjLN0k/r+yDqIW8EZ9muScBYK5kQVQV9iDXQw=;
	b=1OiekEMZK8RjqmQwWMPuhdIEsyPX+1+STSYlWFat+eIOp308AXKEAnxOC2N/AjWoda1Lyv
	zbz2PBNgszKzSrisIvKnm2uo3pHHEPmA12zMAHnnAeny0/lZdo1WuLIkYCB14gPPCUGeww
	hANpX5CO0NUimxBsouj1/i9TqJwUpVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745493420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=INeTkgOjLN0k/r+yDqIW8EZ9muScBYK5kQVQV9iDXQw=;
	b=QhMbUUACzZWpLIOalWiAMF5XC1rMUrCX4yo+n/TAnMtlpy1Sxv5plS68X47/wzzaBT+BUR
	ykk71evEPga5czAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B68D41393C;
	Thu, 24 Apr 2025 11:17:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ngsuKqwdCmgaOQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 24 Apr 2025 11:17:00 +0000
Date: Thu, 24 Apr 2025 13:16:52 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 04/14] nvmet-fcloop: refactor fcloop_delete_local_port
Message-ID: <80fd88ea-50e8-4692-ad15-c18cd45191dd@flourine.local>
References: <20250423-nvmet-fcloop-v5-0-3d7f968728a5@kernel.org>
 <20250423-nvmet-fcloop-v5-4-3d7f968728a5@kernel.org>
 <0c04b345-152b-4bbe-b9b7-7796211b8547@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c04b345-152b-4bbe-b9b7-7796211b8547@suse.de>
X-Rspamd-Queue-Id: D01F421125
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,flourine.local:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_121705_368678_69EDAE13 
X-CRM114-Status: GOOD (  14.73  )
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

On Thu, Apr 24, 2025 at 12:10:46PM +0200, Hannes Reinecke wrote:
> On 4/23/25 15:21, Daniel Wagner wrote:
> > Use the newly introduced fcloop_lport_lookup instead
> > of the open coded version.
> > 
> > Signed-off-by: Daniel Wagner <wagi@kernel.org>
> > ---
> >   drivers/nvme/target/fcloop.c | 30 +++++++++++++++---------------
> >   1 file changed, 15 insertions(+), 15 deletions(-)
> > 
> You could merge it with the previous patch, but I guess that's
> personal preference.

I've decided to split this out, so the previous patch is simpler to
read but I merge it if this is better.

