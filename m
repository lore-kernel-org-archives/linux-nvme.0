Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991FBC4345F
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Apr 2024 06:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sLjKYanurTnvfwqLGBxQ/2npi+bl/AEythjFRUTp+ew=; b=gtwtG4OAYfxrWMc2r3++WYryFK
	pWkEA1JQbSymNZ7qWZyJZiPPMTaRB5XvEuXEYLF7qDhvvI/02k5ibbBTY1lJlrQ1hmHIwZmIUUqMe
	mACUS7f6XwMOXGBAJ5A9lxsxXyX8wkHxRoVfSV1kB4dVxyZNZTvhg3i1j2GScJzbv0GSZvrOgmoM+
	pnPy9QC7NuGGFUN35mTqQGzQoyA1G8L+2FTon3JDjBYY6y0ck6JzY/O3JKqQ44WvkpMAd+RoEnWoh
	cLOoqcPyE2grw+2VchAkp2tSJZ+E1ow0wKvA7udrWhtXlvoFbi7OdA8l9lRR/Ntpz62ztgbsL5/gs
	wD7B4fkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwyRR-0000000EpDk-07Fl;
	Wed, 17 Apr 2024 06:06:45 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwyRL-0000000EpAz-3OVM
	for linux-nvme@lists.infradead.org;
	Wed, 17 Apr 2024 06:06:43 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F10A33384D;
	Wed, 17 Apr 2024 06:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713333997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sLjKYanurTnvfwqLGBxQ/2npi+bl/AEythjFRUTp+ew=;
	b=JxGMZvx0ffYPtg584mgRn6rpGB2dflyRkLBcxOyz5JznlECEa7GGSjqYNImmTgC2W/7YpT
	b0DgxHVmqqv0wdLE5NpmcbxPjZi63BaE6RzncXDg6YiI/QfkUp/z0IhcxBeAFd3OXhCO42
	KspPy9gc4llgtuKakXAbJqBplzYio54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713333997;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sLjKYanurTnvfwqLGBxQ/2npi+bl/AEythjFRUTp+ew=;
	b=KmKdM8tw1e7EBPpI63PB4ySi/OwRd8nQKWViDr7VUDxxzO10ZVsg0ybZcShA/FeR76ATba
	APEUeNk3+h4HMYCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NpmVy94t;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BX435Fk6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713333996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sLjKYanurTnvfwqLGBxQ/2npi+bl/AEythjFRUTp+ew=;
	b=NpmVy94tdnhN34sCsR3mMeldk507d3OvI7+fQWTYBNPiMDubuwkMqCREWZErO5rIe52gUC
	E/kS+Q5VV99vaEKX7ORi8Witm7XlMCokZm2SYQe4bviEZmTbB0nxUEb73K3wa/NVe97gjJ
	75vOkmmAqLIJivfHqLMUWaigmD3FfSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713333996;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sLjKYanurTnvfwqLGBxQ/2npi+bl/AEythjFRUTp+ew=;
	b=BX435Fk6F0Ho4gJzSyFoNCMq2+kkffyysLobZzDLkYEhWvPKn9/RQtppEDpXh5AkZX7WUY
	mvtiwv/4CvCaThAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE8991384C;
	Wed, 17 Apr 2024 06:06:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rXbbNOxmH2bqEAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 17 Apr 2024 06:06:36 +0000
Date: Wed, 17 Apr 2024 08:06:36 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests 05/11] nvme/rc: introduce NVMET_TR_TYPES
Message-ID: <extncf2en5xoiov5mhnaglwd33nmffx2u2mw3zlnrxuty3zurx@nij7avtahebv>
References: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
 <20240411111228.2290407-6-shinichiro.kawasaki@wdc.com>
 <7okerxv2q5k6d2jl4ehdvido37rmycxopqalkt3xcouxeuxxe7@q73je25fv33y>
 <x5xlzl6g3riybq4uuoznt47yp2ieixtltq2sw7w5uodpcosln5@pmx2vne4qgjq>
 <fact36d4ueuna534ktaafuel4uqkexmlkrwasky6ytvpmi33bq@x26qccgbqbnw>
 <b159e306-2b08-4880-96c0-2ff7d5c3023e@nvidia.com>
 <epbj4opovczrfrs3o3mdodjs2dtekl4jsxgbwhtnqhq5bjhjnl@54b5mo6wixsk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <epbj4opovczrfrs3o3mdodjs2dtekl4jsxgbwhtnqhq5bjhjnl@54b5mo6wixsk>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: F10A33384D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-2.99)[99.94%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240416_230640_069933_C55546EC 
X-CRM114-Status: GOOD (  13.14  )
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

On Wed, Apr 17, 2024 at 12:58:53AM +0000, Shinichiro Kawasaki wrote:
> Yes, "mark them they are injected from the environment" was the one reason to
> have the parameters in upper cases. The other reason was the consistency across
> the all parameters described in Documentation/running-tests.md.
> 
> > can we please keep the small letter similar to nvme_trtype ?
> 
> I'm fine to have small letter, lower cases for the new parameter, but I would
> like to clarify the reason to have lower cases. Do you mean to indicate that
> "the parameters are test group local" using the lower cases?

Lower cased environment variables are not very common, in fact
POSIX.1-2017 mandates upper cased environment variables [1]. Also only
the nvme part of the framework is using the lower case ones, thus I
agree with Shinichiro to streamline these nvme variables to upper cased
versions.

[1] https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap08.html

