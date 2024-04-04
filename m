Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A75CD1292
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Apr 2024 08:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wCIwQG6XMFwg5jqXsEKk4WeiCNj9G5QjfJ1ybiVgzWQ=; b=nVdt07+bYuFLYDreHyXKFttPYA
	CC98fpucLGxfXFnYgKKtfsw3tiaz9KYHoGMK0u1qhw4YKBMiWKDJAHbmstL5ntuiO6OW+OzBbnyU3
	SV7qDcPZegKhsXv4g4gvO2+fYfFZa7D+mhQ0VzyByHdwNO3983aEMP2C1+erZJBPPzZ04z9xdu6aB
	s1JVftffbQPuL3EShe4edzwFRavpuUv9iMT2qPgzkJydXdRjFHTzw+1IB5LZZytRI8gMOqT9YIp2q
	ciG3l734wwOUuM/tLXUgcCRiB08PhjWqMFzPtoDXc3RUp97oUpmks2+gcz/qI6Dw3UcZ5BfQfIzFf
	gfAtaofw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsIEX-00000001meE-2jdC;
	Thu, 04 Apr 2024 08:14:05 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsIES-00000001mbt-11nP
	for linux-nvme@lists.infradead.org;
	Thu, 04 Apr 2024 08:14:04 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EDC573796B;
	Thu,  4 Apr 2024 08:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712218436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wCIwQG6XMFwg5jqXsEKk4WeiCNj9G5QjfJ1ybiVgzWQ=;
	b=t7YE2bmOmn/Cz+kFK7qjRVwVkI5mIPKAHORbyrWKumzoN58Td744rJV3byoqq4WR2vzah9
	bvjVwo4O4ADiI4zgHl8WoV6VSicpLqM3D7bp88552HHQJzdJ10QQvabaIlEPVAlkbRP+a4
	g6FoeXguHpul67y7YYBH+6zmiO2qa3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712218436;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wCIwQG6XMFwg5jqXsEKk4WeiCNj9G5QjfJ1ybiVgzWQ=;
	b=oR4mWVqe0WP/pXIf5FAEFu5FXQCEWbybMDx3HB0Qdx4X95rJ/Le6B+0vaScDbhrw1eTMSo
	61IY5ocrlxaS4rDw==
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DBFD113298;
	Thu,  4 Apr 2024 08:13:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id atZCNERhDmatCgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Thu, 04 Apr 2024 08:13:56 +0000
Date: Thu, 4 Apr 2024 10:13:56 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v1 0/3] add blkdev type environment variable
Message-ID: <t5ad3v5sym5ccj7tptsguclhxywug6rvmn3j2li7gdkmhfw665@ikp3kgcrb5ah>
References: <20240402100322.17673-1-dwagner@suse.de>
 <mqpuf2a7obybtw42ydte2wq7ktema5odvc3dqm32hknjmamgdb@rbo3i6lqqkld>
 <j6awxljufwg6r5rs5kojwsnatfb4aj3vnqsq43hkuuhgvcflvh@u6l5cf2ponaw>
 <5aa4ebdd-5800-4701-9a80-c737b2760ec8@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5aa4ebdd-5800-4701-9a80-c737b2760ec8@nvidia.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[99.99%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_011400_462362_B9EA6965 
X-CRM114-Status: GOOD (  11.69  )
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

On Wed, Apr 03, 2024 at 10:27:48PM +0000, Chaitanya Kulkarni wrote:
> reducing code is always encouraged, but please don't change the test
> coverage and

This series increases the test coverage.

> make user add additional steps to run the tests, IOW ./check nvme should 
> run all
> the tests case by default as it dose today, this will keep your changes 
> backward
> compatible ..

Well, that is not really true right now. E.g. nvme_trtype is loop by
default. And you need to specify the additional transports manually.

This is also why I suggest we think about some sort of generic way to do
this types of 'matrix configuration'(*) out of the box.

(* don't know how to name this better)

