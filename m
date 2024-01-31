Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9403C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 14:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hk4lvUjZXgIv+mRfchf0xoHua9sVyhCiO+ZZZ5eg3kw=; b=u1KYEIDp8TUYg7dG2zFaxMOx34
	P2pN6koqQ48J2cdgwmC85QHWDfMkQOsPONXZOEKqlUwW9/+wi0oDmmK5So7KLMM7Reld6gjeNBHQ/
	0BHCvd2kHpdwBZfEY0tHUSaCZEd6vel73OWVBk943aAIw0gisjWZj6+hQ35MhmdKLv/CbiDzwHWXv
	88dsx6tYx/zV7J5jJNoPA+/qysXKOXyq3ujDnFqXKmKLZlWLUxgxyoKB2XczLov7xG90lvIhRt6Bq
	VHbDIDN53dTFf3lkbKoPMjNSrSwt6Rc9GrQLNleolW7RKhtrcPIyChd2QfpxUDhHsHAj/5P4yceSU
	3WYbRUjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVBsl-00000003zNR-2Nxh;
	Wed, 31 Jan 2024 14:48:07 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVBsg-00000003zKp-1mZQ
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 14:48:06 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8E6741FB87;
	Wed, 31 Jan 2024 14:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706712480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hk4lvUjZXgIv+mRfchf0xoHua9sVyhCiO+ZZZ5eg3kw=;
	b=egvH5lumvyz/EZrnAIc2c7g10yN4UxRvV/PGcwKqGuojwTVOgb2xhttra+7xVvq/OqcyRK
	20x3/M8mPMbP9WQGEbx35Kulbq/qXAQJal9jF3QAX6WByWQd8YF8U0SwJYbUvqOMzLnpVK
	WS0dpAVf3QPKP13FnXXzis/Z7raDevo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706712480;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hk4lvUjZXgIv+mRfchf0xoHua9sVyhCiO+ZZZ5eg3kw=;
	b=H9jueoTrzcaPLPuT+a1O2/kKn4UT6jZ1/Pqb5NACW27CiPKeu1S5aajo6fQllHhHwmasO5
	6M63d5uvEBdj8kDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706712480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hk4lvUjZXgIv+mRfchf0xoHua9sVyhCiO+ZZZ5eg3kw=;
	b=egvH5lumvyz/EZrnAIc2c7g10yN4UxRvV/PGcwKqGuojwTVOgb2xhttra+7xVvq/OqcyRK
	20x3/M8mPMbP9WQGEbx35Kulbq/qXAQJal9jF3QAX6WByWQd8YF8U0SwJYbUvqOMzLnpVK
	WS0dpAVf3QPKP13FnXXzis/Z7raDevo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706712480;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hk4lvUjZXgIv+mRfchf0xoHua9sVyhCiO+ZZZ5eg3kw=;
	b=H9jueoTrzcaPLPuT+a1O2/kKn4UT6jZ1/Pqb5NACW27CiPKeu1S5aajo6fQllHhHwmasO5
	6M63d5uvEBdj8kDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7BE5F132FA;
	Wed, 31 Jan 2024 14:48:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id OwfNHKBdumUXcwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 31 Jan 2024 14:48:00 +0000
Date: Wed, 31 Jan 2024 15:47:59 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Guixin Liu <kanie@linux.alibaba.com>, 
	"chaitanyak@nvidia.com" <chaitanyak@nvidia.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Re: [PATCH V2 1/2] nvme/{rc,002,016,017,030,031}: introduce
 --resv_enable argument
Message-ID: <igsovxyv4y4lajn6chnmnszm5iwzl3qta33ornjzhx4ghchbte@xdjafxxjwhgx>
References: <20240117081742.93941-1-kanie@linux.alibaba.com>
 <20240117081742.93941-2-kanie@linux.alibaba.com>
 <mn2kvkfr72tp7j5pcudkqzrp4yory24mwuqxby3zy7rjdhm5oe@2prxhce7mmgd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mn2kvkfr72tp7j5pcudkqzrp4yory24mwuqxby3zy7rjdhm5oe@2prxhce7mmgd>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=egvH5lum;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=H9jueoTr
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.99 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[5];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.48)[97.64%]
X-Rspamd-Queue-Id: 8E6741FB87
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_064802_644425_8A42D6D1 
X-CRM114-Status: GOOD (  13.70  )
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

On Tue, Jan 23, 2024 at 10:54:07AM +0000, Shinichiro Kawasaki wrote:
> On Jan 17, 2024 / 16:17, Guixin Liu wrote:
> > Add an optional argument --resv_enable to _nvmet_target_setup() and
> > propagate it to _create_nvmet_subsystem() and _create_nvmet_ns().
> > 
> > One can call functions with --resv_enable to enable reservation
> > feature on a specific namespace.
> > 
> > Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> 
> Thanks, looks good to me.
> 
> Daniel, could you take a look in this patch? I think it is consistent with your
> work on _nvme_connect_subsys() and _nvmet_target_setup() in the past.

It teaches _create_nvmet_ns and _create_nvmet_subsystem to parse for
arguments as we have for the function you named. This makes these
function a bit more flexible to use. Looks good to me. Thanks!

Reviewed-by: Daniel Wagner <dwagner@suse.de>

