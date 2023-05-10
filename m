Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1927DC7EE22
	for <linux-nvme@archiver.kernel.org>; Wed, 10 May 2023 17:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+2RPcnuD/B5/jpEGRvPjSZU9zdchad+gheYdPhvKsik=; b=XQB0k0LHG28y368JoPmzUmwZ/f
	58KlQXqMzEDByqDQSDn3MC2RFBxRQ5ZmuunPza54Bufis9foxXjqQ19uy7dCs6zjVCbHVhmob1gTo
	Mvm/RLwadq6VIlBIpcPvRr8BxIzotaZUooz1boa/ERjjQbHgEEJlOdQnWppaC1Bensa1FD+MNRkS3
	I8bl3+S/UpkTBM4jQUtdECEPLxvY5cIu+d5+JvoIF64UBT0OcOhl0Qh/0PjjePW4KJ6txMDKWrQWv
	ESFWAoJLgoEEdT+YjtgIbN5ACr/haf0DQe+3UU3SnK6MGnNXj3fuXenNkE54tf4ie9Y+tnOHVE2cQ
	yaNpmkuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwnOY-006e44-1d;
	Wed, 10 May 2023 17:14:30 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwnOW-006e3P-1n
	for linux-nvme@lists.infradead.org;
	Wed, 10 May 2023 17:14:29 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D5A581F747;
	Wed, 10 May 2023 17:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683738864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+2RPcnuD/B5/jpEGRvPjSZU9zdchad+gheYdPhvKsik=;
	b=CDhVusS9912eGykAiQg6jDXMItwGdq4OE7PYs9GVcisKsjLU9Ik0z5HcqXvw98UMJmZNUh
	RhZ+NcOiLFCSKWbpVFHP1Zwad+oTKc0Oh4kGJY1gEjR5EYnBLS7bsllaSZQ0sF5Z4BKS8v
	dLXHCyJthyPPYg7i+ssI+LGL80Z109E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683738864;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+2RPcnuD/B5/jpEGRvPjSZU9zdchad+gheYdPhvKsik=;
	b=+MV2TCiVhwrQVmQhz0kE4dKRD3/8Sq2ueROZPM78U8lF9yXdmTnCmGdTfBimjYWSFH/H82
	ckOAlFD5+0bsLJDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 37BE413519;
	Wed, 10 May 2023 17:14:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id eGEpOe/QW2SZCAAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 10 May 2023 17:14:23 +0000
Date: Wed, 10 May 2023 19:14:21 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Shin'ichiro Kawasaki <shinichiro@fastmail.com>, 
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 10/12] nvme/rc: Calculate IO size for random
 fio jobs
Message-ID: <vlq7hqrweo527daqh7m5iidcvlhujxsc3hwmeqm2oen4dbucsa@3yo2lm3d6aap>
References: <20230503080258.14525-1-dwagner@suse.de>
 <20230503080258.14525-11-dwagner@suse.de>
 <xqdnjtl5m6idy7kecwpc6nho74twnvcslkvxnyto6aflz54y5p@6rqao2i3ro2r>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xqdnjtl5m6idy7kecwpc6nho74twnvcslkvxnyto6aflz54y5p@6rqao2i3ro2r>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230510_101428_740044_2AD3C96D 
X-CRM114-Status: GOOD (  10.30  )
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

On Sun, May 07, 2023 at 11:31:10PM +0000, Shinichiro Kawasaki wrote:
 > -	_xfs_run_fio_verify_io /dev/"${nvmedev}n1" "1m" || echo FAIL
> > +	rand_io_size="$(_nvme_calc_rand_io_size 4M)"
> > +	_run_fio_rand_io --filename="/dev/${nvmedev}n1" --size="${rand_io_size}"
> 
> Here, _xfs_run_fio_verify_io is replaced with _run_fio_rand_io. May I confirm
> that this replacement does not affect this test case? Same question for the hunk
> below.

This is on purpose. The test just wants only verify that IO is still working.
Because _xfs_run_fio_verify_io has the minimum requirement of 350M for
nvme_img_size. When I wrote the test I didn't know this and thus this change.

I'll update the commit message to include this info.

