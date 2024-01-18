Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA7AC4707B
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jan 2024 12:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IWwdFAPKIwxj6OgPNZTL9gurhZwzf8blYOysqD66USg=; b=eTY3ndxRHXcoKEi7aiGVDaZdsf
	qvhYL3mi8bRNhbfhx07+RPA6cJ5UoPJtBfL7fQBL63Z2kzT0toZTKumc97C66zzeCqxo89VtIrZfx
	AT38HJsLemtEpqHp235qvIzFBaKk9UCWDSzcfWjRXcpKTb5GVJLROj3ukkKkcjzQ8ZNROrLADMwpa
	8E5POGTwbD6udVDs+kg7nfCZ17Xs/iq9m/O331Z70lq9nkgX6Y5Q+rpcKwyf4CAxGufnUiLHaIAut
	Jkc7Q4lUnlM0EgZkn9Aouriwi6J6lj9q3Fbk5Vcy7KBnKX75pJYbkDZilwutMlMrE1gvouTUoMRQH
	MupJgOqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQRYV-002jpt-2i;
	Thu, 18 Jan 2024 12:31:35 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQRYS-002joi-1x
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jan 2024 12:31:34 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 333141F791;
	Thu, 18 Jan 2024 12:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705581081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IWwdFAPKIwxj6OgPNZTL9gurhZwzf8blYOysqD66USg=;
	b=rZKO+2WQir4i6Kh72vCatGBqcDPmwtEqw6m6WEogDb/GA4EDVUy34+TFkQTr6WRMKll0CV
	mkpaEWmCXerRtZYIk4f7uMFAUJY3DuX4KRxfdtPJVNnUY5qGs7QJiQtt9iN9++ohJ/R1dv
	RMQ8Y5iEYO2Mk0B82mjOyczzq8vCt/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705581081;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IWwdFAPKIwxj6OgPNZTL9gurhZwzf8blYOysqD66USg=;
	b=ritS0bmcDB2hDFkX77omDn2bxPGfgaAUahqfweCqZojnA1V8zBzuz/6VEJk6XspjhFmRm6
	QY7feOIOJtXrH/BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705581081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IWwdFAPKIwxj6OgPNZTL9gurhZwzf8blYOysqD66USg=;
	b=rZKO+2WQir4i6Kh72vCatGBqcDPmwtEqw6m6WEogDb/GA4EDVUy34+TFkQTr6WRMKll0CV
	mkpaEWmCXerRtZYIk4f7uMFAUJY3DuX4KRxfdtPJVNnUY5qGs7QJiQtt9iN9++ohJ/R1dv
	RMQ8Y5iEYO2Mk0B82mjOyczzq8vCt/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705581081;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IWwdFAPKIwxj6OgPNZTL9gurhZwzf8blYOysqD66USg=;
	b=ritS0bmcDB2hDFkX77omDn2bxPGfgaAUahqfweCqZojnA1V8zBzuz/6VEJk6XspjhFmRm6
	QY7feOIOJtXrH/BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15B49136F5;
	Thu, 18 Jan 2024 12:31:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OLDEAxkaqWV1cwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 18 Jan 2024 12:31:21 +0000
Date: Thu, 18 Jan 2024 13:31:20 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, hch@lst.de, Niklas.Cassel@wdc.com, 
	chaitanyak@nvidia.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-host: fix the updating of the firmware version
Message-ID: <3urnhr2hdyn67zbw5a43cscnumbd3h3a2cd63n3ofaslwec2yv@yg3dpb22s2pb>
References: <20240118114854.672748-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118114854.672748-1-mlombard@redhat.com>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rZKO+2WQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ritS0bmc
X-Spamd-Result: default: False [-2.39 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.58)[81.50%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 333141F791
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240118_043132_819498_6C65AE30 
X-CRM114-Status: GOOD (  15.55  )
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

On Thu, Jan 18, 2024 at 12:48:54PM +0100, Maurizio Lombardi wrote:
> The original code didn't update the firmware version if the
> "next slot" of the AFI register isn't zero or if the
> "current slot" field is zero; in those cases it assumed
> that a reset was needed.
> 
> However, the NVMe specification doesn't exclude the possibility that
> the "next slot" value is equal to the "current slot" value,
> meaning that the same firmware slot will be activated after performing
> a controller level reset; in this case a reset is clearly not
> necessary and we can safely update the firmware version.

Is this not an undefined behavior if it is not in the spec? Just
saying this is not so clear to me.

