Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAC8C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Oct 2022 11:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZMRXYZtdrM6VKg5b9eE9NynEa0Qa3N9n/cBaVtaYV24=; b=bYKvuL2D9t2XtZZm71MycRRsjf
	BO8NGVsA7kcUg0gOwtoCnFoTQyhwnctCOZzG2pMb39JfzwPAGg+GTkqR6nE/nfjECHmtyiEA2npwV
	Rg1a7GuJ2UQ8H3Pgq4qw+zfE6Db+GfFbz2wRJsQbjYdYEZi5pHWnE+RmHqbcbnuSoGOcEPOSLRZ91
	oKZqym3Jc2CCG8N1jA0KaKo4OnJlyTj2dEzK+a1XH/877ypKihKsKTD7m7uTAa2sKNtihoHJrcx8/
	8xFhrkkb7f4vb6VAKf0l06brHEJEjoyXb0mKKcQumOxVwvle2OyA0mgCb+52vWg50E1KwMPdk5Bmd
	DQgi78Lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol7PG-000ve7-IV; Wed, 19 Oct 2022 11:38:42 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol7PC-000vca-B9
	for linux-nvme@lists.infradead.org; Wed, 19 Oct 2022 11:38:41 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C3CE3336B8;
	Wed, 19 Oct 2022 11:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666179514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMRXYZtdrM6VKg5b9eE9NynEa0Qa3N9n/cBaVtaYV24=;
	b=ifViHQbyiWG8ABtlhxEO/4qbfkEGO5jNQ0Q0RYNucLMQPz775pVhErI2v7nrRCX5B57fs/
	0yDiaAUd77lCa3DnUrsPuqJZkIJbOdPi9TJ+gck+6WadY519t66we/Vxt9nqQt7cOtqDdl
	WWB+aVGKSeW9aLDSUlH82t9NA3pJRmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666179514;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMRXYZtdrM6VKg5b9eE9NynEa0Qa3N9n/cBaVtaYV24=;
	b=u0rqgh9eYBkgxKKoiSNG+0heahTGI80a9Blqp9ddvT5AiA+JAQBGxvF6mvpzEZVo82T0TR
	RbtIYWCw5uhiWOBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B549C13A36;
	Wed, 19 Oct 2022 11:38:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id QtA7LLrhT2N6SwAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 19 Oct 2022 11:38:34 +0000
Date: Wed, 19 Oct 2022 13:38:34 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Pankaj Raghav <pankydev8@gmail.com>, linux-nvme@lists.infradead.org,
	gost.dev@samsung.com
Subject: Re: [PATCH nvme-cli] tests: Update license to GPL-2.0-or-later
Message-ID: <20221019113834.mxoumvwt57vlpjse@carbon.lan>
References: <20220517061456.7623-1-dwagner@suse.de>
 <20221019070321.ra5wns3sc3dv3r74@carbon.lan>
 <20221019085004.54mtkhi5qoix5ef6@quentin>
 <20221019105302.tcvfxn4z7nzkit5d@carbon.lan>
 <CGME20221019105342eucas1p22028535789c015121826a4847974e595@eucas1p2.samsung.com>
 <20221019105336.n37oq5u7gbgynrqy@carbon.lan>
 <0b93cd38-0c41-d91d-b169-b01e647dfde2@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b93cd38-0c41-d91d-b169-b01e647dfde2@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_043838_546125_03F54DF8 
X-CRM114-Status: GOOD (  16.73  )
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

On Wed, Oct 19, 2022 at 01:10:13PM +0200, Pankaj Raghav wrote:
> On 2022-10-19 12:53, Daniel Wagner wrote:
> > On Wed, Oct 19, 2022 at 12:53:02PM +0200, Daniel Wagner wrote:
> >> On Wed, Oct 19, 2022 at 10:50:04AM +0200, Pankaj Raghav wrote:
> >>> Hi Daniel,
> >>>>> When I reviewed the tests I asked wrongly for GPL-2.0-only. The
> >>>>> project is using the GPL-2.0-or-later license. Relax the license
> >>>>> requirement to GPL-2.0-or-later.
> >>>>>
> >>>>> Cc: Arunpandian J <apj.arun@samsung.com>
> >>>>> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> >>>>> ---
> >>>>> Hi Arunpandian,
> >>>>>
> >>>>> Sorry for the mess, but could I get a signed-off-by from you?
> >>>>
> >>>> ping?
> >>>>
> >>> I heard from the team that he left Samsung. Do we have any other
> >>> alternative to get this patch in?
> >>
> >> Right, the mail was bounced. I think it would be enough to get a signed
> >> off by any Samsung employer
> > 
> > employee obviously :)
> No problem.
> 
> Looks good,
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Thanks!

