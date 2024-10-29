Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389A7D5B16F
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 09:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1uSsE2OQYsc+GkBslFCRFdP9xaFHr2vrFckIotmOuqo=; b=In1/mXTDykINcAwknmpz+81yU3
	4lMBGR6oDhzHRRgRSBZ0Y1YocpaiE15EEybmOlr0UgDoAbU6yj3bR5dPV2XEzjBOXSwhZWruR2qdT
	nvCclhfp4SDIL2yBYTe943sNyXtyGWUAl/ViA2SpqDVb9JAXmD6azQcNUGDXdM3g69251gRiy7xxl
	DfJrxeTc/luMtpj83AoZ7A8yJ87gDrIBuxiKcTRtRohB2GsourwYNZID+syUXu1lDGCV7MHnKA/wH
	Dl6nPabdXLH9DsDtpT4oVSBveeUgRZHcS2fXmrRUxzYxF8ldjlSzf8gAi2yCAAYpB4JuebQjcKmOM
	cnErlVig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5i5H-0000000DnsD-0dyy;
	Tue, 29 Oct 2024 09:00:15 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5hu3-0000000Dl78-326D
	for linux-nvme@bombadil.infradead.org;
	Tue, 29 Oct 2024 08:48:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1uSsE2OQYsc+GkBslFCRFdP9xaFHr2vrFckIotmOuqo=; b=LjSxhUHgczvg98eJ1ObBajPpWY
	tud2gIemPTj3vgv/jOvx6/9KoTcT1pmN2uJqco1x2p71o5ovCGA/SceD8f/mpWvxx2bQ6fMKskeUm
	YLbUads8w41BVhp49xT2TqmLe3dPffxvPicWBqte8wpB8Bkcb9MS8X3K+P7loacktuGSPGwzZ0qHN
	lqFtDHmm+uThVr0KNoWQlpQNiD313cmCVaXqe3+gFeC/UY0g9F3hcoPV4YxVkS4xXWgcTvVS1jPYS
	sprsPMaVIKY/4rJNowzZGu4sBV8JLJng1UgHvgkazZJhskMqVNW0OrEKpmCOw/UgMHFq/2jINCedw
	UQ4Z6Ztw==;
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5hty-00000009r3S-0YW2
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 08:48:38 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F0187218F9;
	Tue, 29 Oct 2024 08:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730191709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1uSsE2OQYsc+GkBslFCRFdP9xaFHr2vrFckIotmOuqo=;
	b=ZzWDkneZCk09UrxOuVwgR41N7G9G+1ISXafZxRwFcG28mSPFERaiHamkamyQj4ovAtsLoT
	ro3PIwhSL+WZNENIRlyH+wqrjgJ9Ld4Op4SxvnEXC3hxrqrTVgkTIFtkyPSUWitriJnLGe
	XFTv/cPd3lGb4U1DHH3ivu7LGXeMCFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730191709;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1uSsE2OQYsc+GkBslFCRFdP9xaFHr2vrFckIotmOuqo=;
	b=8rH0EcQyna6ABqjkiLIIZ8hK2dZ7VWj5ApN28CHpiI2DQwagB4Y+U1XNcS+/Efx6hBZART
	NWbUmq0v5LO5g3CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730191708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1uSsE2OQYsc+GkBslFCRFdP9xaFHr2vrFckIotmOuqo=;
	b=ZXVmmVmmr/SIfecOOGzzZKLIpXfcOIi2Zk0ACCfEKkSgF/JNaS4/7YXvggtC/X7QKDjBMl
	O+vxzEng9dfZTNTr4iZDbP9mVlZQGYWaRc+ArfpYlc/TGRrb7d3R0yohLYSx9r4VuNJqME
	JolcOw+CyyPMXX9nMk5QX9iDT7HXn14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730191708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1uSsE2OQYsc+GkBslFCRFdP9xaFHr2vrFckIotmOuqo=;
	b=TchtKBx1s+EqVEtorKWRRexz6OZTkgIgh3HCSLusnwxiYp55cOkxbdMlYhnryHMd14g4V6
	0fdSJ2ILsUCXR9DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBEF1139A2;
	Tue, 29 Oct 2024 08:48:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3otyL1yhIGfODwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 29 Oct 2024 08:48:28 +0000
Date: Tue, 29 Oct 2024 09:48:28 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com, 
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme/{common/nvme, 051, 052}: introduce def_nsid
Message-ID: <7d073c6c-f498-4b8d-b1c2-d3a36ad06a86@flourine.local>
References: <20241029031931.118305-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029031931.118305-1-kanie@linux.alibaba.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_084836_468069_C6BADA13 
X-CRM114-Status: UNSURE (   7.57  )
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

On Tue, Oct 29, 2024 at 11:19:31AM GMT, Guixin Liu wrote:
> Use def_nsid instead of hard code, the default of def_nsid is 1.
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

