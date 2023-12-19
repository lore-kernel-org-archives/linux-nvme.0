Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD99C41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 14:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oAjLQT6gn05Z9roydajMT4zSvFciQsK05XyxNtJgkcA=; b=Hb94QhN40ZLkvjhZHYCyKf8oND
	IBhWXI5cDTMJPPrO6bGZqERhVbNrqlTHU6ahKuF2BbdCtR67KaQq7st8nuW6S+J+0K4RZRUJTS9qH
	Nr6aXPY50+fdKycWtEOy/Ce0u5m3vbKBAeNB1rRBzo9dqRZrRASBzuRcBG8O5yn0XFao+Md5Oca70
	8qCVXex8Wqw+H0bQ4bR5Zag+AxhjsVUuzFgc5fDyPpCWg6cRPMzo5hVS+7KugaS6mLhNv5kxys6Ym
	MHRHFMQ8h12AtCSnRMBxirAA9c32LgkWke46pf1JgPiQj4CwiztvtN9BJ0s4a9U1/gd5kKarqAge2
	lWvqFGnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFak8-00EIDy-0E;
	Tue, 19 Dec 2023 14:06:44 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFak4-00EICc-2G
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 14:06:42 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2B29F1F7C9;
	Tue, 19 Dec 2023 14:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702994795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oAjLQT6gn05Z9roydajMT4zSvFciQsK05XyxNtJgkcA=;
	b=2X57Y3fw1TdNtGI1/031xX2325PpBjBvpeaPpx/CgimyWnR+wopnuEEv699UmDWdLcImst
	SdfyVEKeFvDo3DISK5TKqur/miLSmd0gt1oPhPCZDsYN7cohaMNXIxPh9eDvrjvG3YM9m1
	NcTCOVbVnU9Sbo4KcCoe5lZfAf20z9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702994795;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oAjLQT6gn05Z9roydajMT4zSvFciQsK05XyxNtJgkcA=;
	b=8Pk5sz7zMLWcvaQcHcYGfpYTjdpYSeEtMiEOxEXdreQzv2GDMDs6jLvtVKmwxB0f6Sm+RC
	B0SwEZ3saZjGNrBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702994795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oAjLQT6gn05Z9roydajMT4zSvFciQsK05XyxNtJgkcA=;
	b=2X57Y3fw1TdNtGI1/031xX2325PpBjBvpeaPpx/CgimyWnR+wopnuEEv699UmDWdLcImst
	SdfyVEKeFvDo3DISK5TKqur/miLSmd0gt1oPhPCZDsYN7cohaMNXIxPh9eDvrjvG3YM9m1
	NcTCOVbVnU9Sbo4KcCoe5lZfAf20z9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702994795;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oAjLQT6gn05Z9roydajMT4zSvFciQsK05XyxNtJgkcA=;
	b=8Pk5sz7zMLWcvaQcHcYGfpYTjdpYSeEtMiEOxEXdreQzv2GDMDs6jLvtVKmwxB0f6Sm+RC
	B0SwEZ3saZjGNrBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FAF813BF1;
	Tue, 19 Dec 2023 14:06:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id iixpAWujgWXAcQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 19 Dec 2023 14:06:35 +0000
Date: Tue, 19 Dec 2023 15:06:30 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH v3 17/17] nvmet-fc: add extensive debug logging
Message-ID: <f6hnsoxuzpul3lkplkgcl4ceem6pf5dwdjgjav6auc4yjfvj3z@hefpryyoue4i>
References: <20231218153105.12717-1-dwagner@suse.de>
 <20231218153105.12717-18-dwagner@suse.de>
 <c40a4b0e-fb0e-40fa-985c-92c6895eb831@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c40a4b0e-fb0e-40fa-985c-92c6895eb831@suse.de>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.28 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.47)[97.61%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=2X57Y3fw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8Pk5sz7z
X-Rspamd-Queue-Id: 2B29F1F7C9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_060640_912310_C41ED156 
X-CRM114-Status: GOOD (  10.67  )
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

On Tue, Dec 19, 2023 at 12:54:12PM +0100, Hannes Reinecke wrote:
> On 12/18/23 16:31, Daniel Wagner wrote:
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> 
> Well ... all previous patches had 'XX/16', only this has '17/17'.
> Late addendum?
> But in either case, please ensure correct counting (and spelling!)
> on the next submission.

Sorry, this patch was not meant to go out. It's just debuggin code for
me.

