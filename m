Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DD2D0BB56
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2024 15:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G9zcSuHmgvZYxKR7PzfROKBW1xNJNLrv01DtrPjZ2jQ=; b=fCnkcMIouS90vAfZ0mgpcgKgXe
	UHyUpembbafeAH0svgkPfXb0t4ZP6Bd+fgSN3VEOh4EsDvc+TvJ9QWgyjShbb5iVsfKbDqIoYPT+8
	ZKmN9OHPwbskeKTZNpW3Julpw+4f4QxbBe/xFHXZ1jUQJ5i15vnAkCFa5RC2Z87k8BU41N16dmyG+
	Dit/5aoF/VQYpayomuVtVbUhGZgZOcwFnuUD21haVRrVWqdW8/WZQb5sgdX75RpX44hNVIB9PpxUX
	KBR2nTQqN2shFCKzRbjHiPSpkj7lYPgV7SalzTGK9DRTNmjLMgLAFz+Ac3FKkUcTpAnUScDwun7TE
	CIQ+IWNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4M3n-00000004CK8-10OP;
	Fri, 25 Oct 2024 15:17:07 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Lhg-00000004688-3l4Z
	for linux-nvme@bombadil.infradead.org;
	Fri, 25 Oct 2024 14:54:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=G9zcSuHmgvZYxKR7PzfROKBW1xNJNLrv01DtrPjZ2jQ=; b=YG0933j12L1Rxocd/IEy5Xnp0l
	MyHtB6j+d7pdC0CJn6FeZS92w3KIM7oFuvSIQ0cmckOEVnYaI60+544EB3eYiXhjYbbvx+cLERQoD
	ahyYekG88LbJJptuN00ov7Rj44ypga+3hR8p9PLevmsrP2+eH3tsvmDIrthV0KlzZJuI9dwikwRav
	Mx0HHTHCKpoaeL3gRoNOZQY7pHH/WJXd3KhDa0TABpkpUGTnalZ0GACg2yeu07VF2X1zCokm73SwU
	2CbpJniycdnFrRKjmTqb2Y+fYcII74Sbc9MYMHvVzam+IbhbSHNk7CxHW/6DYJJgjVnBv5sHEbWjY
	qvyCXg1Q==;
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Lhd-00000008wyA-2rmh
	for linux-nvme@lists.infradead.org;
	Fri, 25 Oct 2024 14:54:15 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A969021DA4;
	Fri, 25 Oct 2024 14:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729868051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G9zcSuHmgvZYxKR7PzfROKBW1xNJNLrv01DtrPjZ2jQ=;
	b=HLV1MQJ+ZcyO622vNe0+3ILz9goT5f71GsQFSO0RJMBWC71iASaRxhPEIZrtIyASiuVr0l
	y3dMa824SSP8za0GsaWcf5CLcVf5xQhtRjdeKFoQt8Hs9/tRQADgUw9+/nBN543Qurp72i
	dQMuNRyy4ThAxAiY64+iZfdxQfyz2qY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729868051;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G9zcSuHmgvZYxKR7PzfROKBW1xNJNLrv01DtrPjZ2jQ=;
	b=CcOjBWZX09o1yfBkBwph186yrD78kS/qPiwJYNgBKUiR0i6hu8DWcYQZfAELovzYkFE+Vl
	jpkSlPsxRTDfGLAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729868051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G9zcSuHmgvZYxKR7PzfROKBW1xNJNLrv01DtrPjZ2jQ=;
	b=HLV1MQJ+ZcyO622vNe0+3ILz9goT5f71GsQFSO0RJMBWC71iASaRxhPEIZrtIyASiuVr0l
	y3dMa824SSP8za0GsaWcf5CLcVf5xQhtRjdeKFoQt8Hs9/tRQADgUw9+/nBN543Qurp72i
	dQMuNRyy4ThAxAiY64+iZfdxQfyz2qY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729868051;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G9zcSuHmgvZYxKR7PzfROKBW1xNJNLrv01DtrPjZ2jQ=;
	b=CcOjBWZX09o1yfBkBwph186yrD78kS/qPiwJYNgBKUiR0i6hu8DWcYQZfAELovzYkFE+Vl
	jpkSlPsxRTDfGLAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A9DE136F5;
	Fri, 25 Oct 2024 14:54:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gR6tIROxG2ccZAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 25 Oct 2024 14:54:11 +0000
Date: Fri, 25 Oct 2024 16:54:10 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 11/15] common/nvme, nvme/003: add --no_port
 option to _nvme_connect_subsys
Message-ID: <80050767-185a-42b0-b4af-3f6e2c921b1d@flourine.local>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
 <20241024010025.2216242-12-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024010025.2216242-12-shinichiro.kawasaki@wdc.com>
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-2.99)[99.95%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,flourine.local:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_155413_843329_FBBF51C2 
X-CRM114-Status: GOOD (  13.32  )
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

On Thu, Oct 24, 2024 at 10:00:21AM GMT, Shin'ichiro Kawasaki wrote:
> Commit "nvme: pass in port parameter to _nvme_connect_subsys()"
> introduced the --port argument to _nvme_connect_subsys(). If the option
> is not specified, _nvme_connect_subsys() automatically finds the port
> for the specified subsysnqn. However, this does not work for the test
> case nvme/003, since the test case connects to the subsys for discovery,
> then, the port of the created subsysnqn is not to be used. This causes
> the failure of the test case.
>
> To avoid the failure, introduce --no_port option. When this is option is
> specified, _nvme_connect_subsys() skips the port finding step.

Can't we just figure out from the subsys name if we need to use the
default ports directly? I am not so sure about the --no_port argument
is a good idea. And if a test wants to use a specific port, we have the
port option, no?

