Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DB9C36010
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Apr 2025 08:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=atDRQLywZjNFYMvbIfbegUyqMlf9lF+SvjVnIVzDj7s=; b=mv1Tl3h7TQzFM6Zgx745gArS1i
	v9DmQcYMRstJ8OaelkpASnlemODPWBVBBY3G0ppLwvRs5XJvbTUBQYTrzLKsMh+Mc0LpAAN+V9voN
	UbTLrpE7AslawR4SsmEeqFC8KKFwjinsrKQ/fhMIcAGKbFWjKVtwxnMFRH8xcAOCL693Qt3FaMmIm
	MdVBa9cVYcT4AA3jaI679mm3p7kCmmV0D+ghqZKZZn0SBHF68Zym1zutHk0255cCDpElcZ/9AHHqI
	DEnJMX3muXViqJTyd6jE46dLxBolBLOfIi6PFaL1AY5cNUU5c2+Fu8WwcA+MseMWZP8Jo/a82cVCc
	KJyLs1MA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1iDq-0000000H56d-3huH;
	Mon, 07 Apr 2025 08:52:50 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1hxI-0000000H1yp-3KWx
	for linux-nvme@lists.infradead.org;
	Mon, 07 Apr 2025 08:35:46 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 18AFC1F393;
	Mon,  7 Apr 2025 08:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744014943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=atDRQLywZjNFYMvbIfbegUyqMlf9lF+SvjVnIVzDj7s=;
	b=aoJu5o9c+UGjxb8Dpda8SRc8bi6KLYj7UmPPDTHmtnZF9pbL8WBBP8amWaanKCsK/F91oS
	PcW0+LZTovyk0f5/OQ74Olrufso/or6mLabnrB257DRjs/pySyRhrsaHI9wFZg5s4Ja0ks
	S/LGT6KZ6jiR0HOxM65A6I+aAhejlRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744014943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=atDRQLywZjNFYMvbIfbegUyqMlf9lF+SvjVnIVzDj7s=;
	b=GnBHceUbaIuGxe3cZPRP1A3fPqNjzaT3XKhF/vFBwCoABlesFLMfUWbOqelBxQAj4fvB97
	KHoOH1+4XqiyA/Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aoJu5o9c;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GnBHceUb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744014943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=atDRQLywZjNFYMvbIfbegUyqMlf9lF+SvjVnIVzDj7s=;
	b=aoJu5o9c+UGjxb8Dpda8SRc8bi6KLYj7UmPPDTHmtnZF9pbL8WBBP8amWaanKCsK/F91oS
	PcW0+LZTovyk0f5/OQ74Olrufso/or6mLabnrB257DRjs/pySyRhrsaHI9wFZg5s4Ja0ks
	S/LGT6KZ6jiR0HOxM65A6I+aAhejlRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744014943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=atDRQLywZjNFYMvbIfbegUyqMlf9lF+SvjVnIVzDj7s=;
	b=GnBHceUbaIuGxe3cZPRP1A3fPqNjzaT3XKhF/vFBwCoABlesFLMfUWbOqelBxQAj4fvB97
	KHoOH1+4XqiyA/Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0BEA13691;
	Mon,  7 Apr 2025 08:35:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Md0nOF6O82deMAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 07 Apr 2025 08:35:42 +0000
Date: Mon, 7 Apr 2025 10:35:38 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	bluca@debian.org, Caleb Sander Mateos <csander@purestorage.com>, 
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: nvme-cli connect regression
Message-ID: <97cbf713-c8db-4d3f-b12e-fae4b45abbf9@flourine.local>
References: <b0904029-2ffd-4ea9-a8b7-bf7d4182ea29@flourine.local>
 <Z-wKL4g32sABS_Ta@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-wKL4g32sABS_Ta@kbusch-mbp.dhcp.thefacebook.com>
X-Rspamd-Queue-Id: 18AFC1F393
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_013544_976955_474BDB4B 
X-CRM114-Status: GOOD (  12.38  )
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

On Tue, Apr 01, 2025 at 09:45:51AM -0600, Keith Busch wrote:
> > 578539e09690 ("nvme-tcp: fix connect failure on receiving partial ICResp
> > PDU").
> > 
> > The change itself looks okay but I think introduces a behavior change
> > for the initial connect attempt.
> 
> Does reverting the commit fix the regression? It looks like the only
> kernel change in this area, but still would be nice to confirm.

Luca can't simply replace the kernel. I would need to build one and
package it up for Arch I think, which I don't have running here...

