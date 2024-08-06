Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B03EEC52D70
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 20:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0vNPovwd0/h8Tm9YLE+4Dvj7zLGx74WH0Y5Uyb+yR6E=; b=BB1K0cwp7FXwW3yL9emHWgiWRb
	Rg4/+/uwurIJ1Qe4pJyaYy6lPvliyCTsY6B5SaU1hym4p1EgCWaNHWgMieW3i1jZv6kZx+MdXrY9b
	m8pUvf480SXRK1Y3CtCC+FrfbeHb0VONdCIxToHlE2F7TyM90qEtRUSuJTVRYnVcllnAkQP7Sfsuo
	VbP8m5qXnlQhDpzrRM8Cfp+Xk83hOAn5vv9K+Iyjby+aE9rcG9tiF2uWdFv1x10LzK+bIZTaMCCpZ
	T0QvjCdGiizE0OA2X/bKmwdbJppc/5jWM8BEDe0MS1lgmEcRFS9UiBziUYOdphPP0CtJALwxqcPZ8
	+ez6CHvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbQRY-00000002lqQ-1Xzi;
	Tue, 06 Aug 2024 20:06:04 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbQRT-00000002lpY-0gMZ
	for linux-nvme@lists.infradead.org;
	Tue, 06 Aug 2024 20:06:02 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 313DF21C48;
	Tue,  6 Aug 2024 20:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722974757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0vNPovwd0/h8Tm9YLE+4Dvj7zLGx74WH0Y5Uyb+yR6E=;
	b=EcERNwllALTVjgEFmJ8eLBvqXvhHAFHHdfW0jCqTu9lNkKtyhIG0BlRDApC59HK4kxoXAa
	Ij98AzGX06bLwNWVR1wsqUD3d8SLluWCwRA7uHqfIz7KsBo0TI0l+NJ8/NcPYtcLqPm+BG
	6o2tudPcNUR1+c/YEmIyHP44bpAmRvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722974757;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0vNPovwd0/h8Tm9YLE+4Dvj7zLGx74WH0Y5Uyb+yR6E=;
	b=Cfzt7e/oVei+nOjykAsNh+MGtmGQAvTMoUTPGJfq7oLBa7Ds+Ktt1OdR4BpcAPjm5ye+2v
	lgjPr2GAL7bGhkAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EcERNwll;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Cfzt7e/o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722974757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0vNPovwd0/h8Tm9YLE+4Dvj7zLGx74WH0Y5Uyb+yR6E=;
	b=EcERNwllALTVjgEFmJ8eLBvqXvhHAFHHdfW0jCqTu9lNkKtyhIG0BlRDApC59HK4kxoXAa
	Ij98AzGX06bLwNWVR1wsqUD3d8SLluWCwRA7uHqfIz7KsBo0TI0l+NJ8/NcPYtcLqPm+BG
	6o2tudPcNUR1+c/YEmIyHP44bpAmRvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722974757;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0vNPovwd0/h8Tm9YLE+4Dvj7zLGx74WH0Y5Uyb+yR6E=;
	b=Cfzt7e/oVei+nOjykAsNh+MGtmGQAvTMoUTPGJfq7oLBa7Ds+Ktt1OdR4BpcAPjm5ye+2v
	lgjPr2GAL7bGhkAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E9FC13929;
	Tue,  6 Aug 2024 20:05:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VbsFBiWCsmbLOQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 06 Aug 2024 20:05:57 +0000
Date: Tue, 6 Aug 2024 22:05:56 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Eric Robinson <eric.robinson@psmnv.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Disk Says It is Full But There's Nothing on It
Message-ID: <vqbcmbet5jfbhmjfuhr66om2ta5lw2octpynjdzyvk66ok47kd@oj7vhatyai3g>
References: <SJ0PR03MB65014AE3AD77A352D0C88855FABE2@SJ0PR03MB6501.namprd03.prod.outlook.com>
 <zsyfgzmoyvjgvywkbkgtxchpfei3pyfcaf2mzu4gltraf34ymx@vocftyxjmedn>
 <SJ0PR03MB65010C717291244293A88CAEFABF2@SJ0PR03MB6501.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR03MB65010C717291244293A88CAEFABF2@SJ0PR03MB6501.namprd03.prod.outlook.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.01 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 313DF21C48
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240806_130559_377686_2EA1D258 
X-CRM114-Status: UNSURE (   9.63  )
X-CRM114-Notice: Please train this message.
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

On Tue, Aug 06, 2024 at 01:11:23PM GMT, Eric Robinson wrote:

> I was on 2.6.5. I upgraded to 2.9.1 but got the same result.

I assume you also update libnvme alongside, because the bug was in
libnvme. Anyway, what do you get with:

nvme id-ns /dev/nvme0n1

This should help to figure out if nvme-cli gets it wrong or the device
reports someting bogus (nsze, ncap, nuse).

