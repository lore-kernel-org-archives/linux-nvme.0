Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B514C197A0
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Nov 2023 07:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+v0Dv/M3rISWIdnCUvOmVyV0Mj8HaXukAEvgaBBqjfY=; b=bmdFKOBOIOuljJFny9IczvSP3S
	gcVWtPW9ZUpGwNxbBF7I7myrCi0Yme2smdninQC4VS8DjLDqKLgJgoMgkqDYmW+Ib1W9eYWrTBzvR
	KDWOnC2zWnnAXXmUjxAeASOwPt9bn66lxKii4Ta+eOxnalYRK1qIQoZav6uuHlZf07/2el2UFlv+N
	PRHcjIsVd5mJfGwg8zLnQ0ilC2HcqpB1/suYhDxZMC9YeRawBaZaKksMwY1QY7pj8SsyNsFESxdiK
	J+b5QIDWTXRWsF+rXoTjhgFwhSNNB0SO7AK57XZgbfd1hokfh3eMFW+f7M6mhI85+mRPUfVi/K1U0
	hjXu6noA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3WnK-002kXs-1W;
	Thu, 16 Nov 2023 07:28:10 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3WnH-002kWs-1T
	for linux-nvme@lists.infradead.org;
	Thu, 16 Nov 2023 07:28:08 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5620A21BFE;
	Thu, 16 Nov 2023 07:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1700119684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+v0Dv/M3rISWIdnCUvOmVyV0Mj8HaXukAEvgaBBqjfY=;
	b=tnKJ6btRVQ0vR0umNU1E+VnlFRz111nWZFUEDc4NCRYNGtO3Oxo2Hryw3hGWPklYv3rpOV
	HF5V5+Nl1t9htC3dzOFBXSO1xpWE2ftAcm6PLLsFks3MsF9h6QjvFDwjCbsHgwX5+eGqDW
	LRAdkyJrvTJct8LxYWTq4z+yuZTQr7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1700119684;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+v0Dv/M3rISWIdnCUvOmVyV0Mj8HaXukAEvgaBBqjfY=;
	b=twjABYUy5aK8vlZ32B7KgD4Cr4hIvj4xbEs3cb0Z5/CxjA94ZMW8iDaN94OyzFX++7lykK
	4hF0pEUUQIYdM5CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 431BE1377E;
	Thu, 16 Nov 2023 07:28:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id N95GEITEVWXuQwAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 16 Nov 2023 07:28:04 +0000
Date: Thu, 16 Nov 2023 08:30:01 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH blktests 2/2] nvme/{041,042,043,044,045}: require kernel
 config NVME_HOST_AUTH
Message-ID: <le7g5bdxyikg6o3it3xnwcwygqku4v5jlgfc4aahhgnwnook2t@eztro5zxsfm2>
References: <20231115055220.2656965-1-shinichiro.kawasaki@wdc.com>
 <20231115055220.2656965-3-shinichiro.kawasaki@wdc.com>
 <447d68cc-91d1-4d17-aec6-0105d3b188c5@suse.de>
 <xikiwdcssvdc2dvozscny73e7pxcdf7b7qx7oys34ote4cv4qo@3msll2uqsz7y>
 <ebf8d5ed-1fe6-4962-a363-5b11cd01bd70@suse.de>
 <bkd22lp42ewpp6u7lws2alcbfzjzt6yp7m3ou2ugdukiyuwqt5@pjnxq5uqnjlc>
 <fd9a0f77-116d-4eb6-ab3b-8af08dda878e@suse.de>
 <6fwo7puujh4dgoppilxwtg6t2d3sf7l7jp7ifyjprgj5litjtt@b6qoyootcnnr>
 <3c5daxlrkpyf6l3asotx7gqczqo32ffzjjvfoobchvwq56c4hv@r4llw3v2msvl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c5daxlrkpyf6l3asotx7gqczqo32ffzjjvfoobchvwq56c4hv@r4llw3v2msvl>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.05 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.992];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.25)[96.47%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231115_232807_640345_2BF593AE 
X-CRM114-Status: GOOD (  20.97  )
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

On Thu, Nov 16, 2023 at 03:03:20AM +0000, Shinichiro Kawasaki wrote:
> > The idea looked good and I checked /dev/nvme-fabrics content on kernel v6.7-
> > rc1. But unfortunately, I found that /dev/nvme-fabrics content is same
> > regardless of the kernel config NVME_HOST_AUTH. I checked opt_tokens in
> > drivers/nvme/host/fabrics.c, and saw that "dhchap_ctrl_secret=%s" is not
> > surrounded with #ifdef CONFIG_NVME_HOST_AUTH. Should we add the
> > #ifdef?

Yes. The whole point of adding the features to /dev/nvme-fabrics is that
we can figure out easily what is supported. If dhchap_ctrl_secret is not
working due missing CONFIG_NVME_HOST_AUTH, then it should not be in the
list.

> > I tried to find out other differences that NVME_HOST_AUTH makes and visible
> > from userland. I found ctrl_dhchap_secret sysfs attribute of nvme devices is
> > in #ifdef CONFIG_HOST_AUTH. But to find the attribute, it looks "nvme connect"
> > needs to happen before-hand. So the attribute does not look usable. Hmm.
> 
> I rethought about the ctrl_dhchap_secret sysfs attribute, and came up with an
> idea to set up nvme target without host key and do "nvme connect". (With host
> key, nvme connect fails). Then check if the sysfs attributes exists or not.
> 
> I quickly created a patch below, and it looks working. The check creates a nvme
> target and affects the test system, then I think it should be done in test()
> rather than requires(). If there is no better idea, we can take this solution.

I'd rather see this fixed as pointed out above. This is a lot of
overhead to figure out if something is supported.

Thanks,
Daniel

