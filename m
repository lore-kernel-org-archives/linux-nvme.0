Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FE110F6FD9
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2026 15:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cx8sAQQ/r32fM6RYRZui+B8m3abyemPhfp6ah4ZmPCo=; b=CP6104OJZG3qR6RXyZ9DKd1DD6
	vooeSiu5hi1w6MxSAC9xOW9iC9WeVpJfq7+IjYGuYOL0QhJytnZcS3wArNdezro2J3JAFoCeXVEH7
	FdNMilbXo+6tyhhw9pGnhQpWnRalgES+xkRWFOBG2OUefDnF7ji8QQPyZ0+smYt65yPX69fS2GTcz
	NbSK2pOCVxPcoSFqQCuq/TwFRi+ZDM5/JREqqjfHZf+ik2dGHm8X/OpMZ7qchPH+i21oLV/7WVjNl
	uTCtpE77aUNBSOgV7KAVt/UAnQcoHuqXGufAJ0h2gkvxBy/roNbxt8b996OkXAgsXlIDregaTQ/Oj
	o91irnZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7xig-0000000Ff0J-1QeM;
	Wed, 01 Apr 2026 15:43:02 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7xid-0000000FezR-24Ug
	for linux-nvme@lists.infradead.org;
	Wed, 01 Apr 2026 15:43:00 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1FE084D1D0;
	Wed,  1 Apr 2026 15:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775058176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cx8sAQQ/r32fM6RYRZui+B8m3abyemPhfp6ah4ZmPCo=;
	b=Y3elJa/bXM4Qr/usruPJTo1/ioXr/lbPJZlyWweRzwgqJUBgJsCpKZmqKVmKUC5sYRrTdW
	zZJVc95nOC1uWBSDuuSoBVh7EJKwgdpfqWWjNe4TskaexkwqvAcWnQOmRVoxNERmsdszXU
	dpCztTKSEHNTFA2d3rBZhWaaQZVf9JE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775058176;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cx8sAQQ/r32fM6RYRZui+B8m3abyemPhfp6ah4ZmPCo=;
	b=wHbUO2RM4Ug+Dpx0+VYa1XQr0E1/+ECjCd5+HnbxCMDcZ2E9q5KKDAZfUZWsresgJld+Rg
	mi91Z7ftyR4LJ9BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Y3elJa/b";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wHbUO2RM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775058176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cx8sAQQ/r32fM6RYRZui+B8m3abyemPhfp6ah4ZmPCo=;
	b=Y3elJa/bXM4Qr/usruPJTo1/ioXr/lbPJZlyWweRzwgqJUBgJsCpKZmqKVmKUC5sYRrTdW
	zZJVc95nOC1uWBSDuuSoBVh7EJKwgdpfqWWjNe4TskaexkwqvAcWnQOmRVoxNERmsdszXU
	dpCztTKSEHNTFA2d3rBZhWaaQZVf9JE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775058176;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cx8sAQQ/r32fM6RYRZui+B8m3abyemPhfp6ah4ZmPCo=;
	b=wHbUO2RM4Ug+Dpx0+VYa1XQr0E1/+ECjCd5+HnbxCMDcZ2E9q5KKDAZfUZWsresgJld+Rg
	mi91Z7ftyR4LJ9BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F17C4A0B0;
	Wed,  1 Apr 2026 15:42:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hwh3AgA9zWkBUQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 01 Apr 2026 15:42:56 +0000
Date: Wed, 1 Apr 2026 17:42:55 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hare@suse.com, kbusch@kernel.org, 
	hch@lst.de, gjoyce@ibm.com, wenxiong@linux.ibm.com
Subject: Re: [PATCH 4/9] libnvme: add support for retrieving per-path gendisk
 I/O statistics
Message-ID: <1e4eb9df-d260-4a72-91e0-b96a2447f6b9@flourine.local>
References: <20260321152823.3197870-1-nilay@linux.ibm.com>
 <20260321152823.3197870-5-nilay@linux.ibm.com>
 <1adcb39b-5e88-4ad0-86fb-8d794adc8744@flourine.local>
 <cc566b4c-fe9f-47c6-827f-d1d436fa477e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc566b4c-fe9f-47c6-827f-d1d436fa477e@linux.ibm.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 1FE084D1D0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260401_084259_702482_FDBFEF5C 
X-CRM114-Status: UNSURE (   8.61  )
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

Hi Nilay,

Sorry for the late response.

On Tue, Mar 24, 2026 at 06:32:59PM +0530, Nilay Shroff wrote:
> After updating the stat, the caller/nvme-cli invokes nvme_path_get_xxx()
> APIs to retrieve specific metrics. These APIs also take the current index
> and compute results by comparing the current and previous statistics.

Let's try to avoid leaking internal implementation details to the public
API. This makes it unnecessary hard to maintain.

The stats update function could take an argument what it should do:
  - update internal stats, calculate diff -> getters return the diff
  - update internal stats, getters return the absolute value

Thanks,
Daniel

