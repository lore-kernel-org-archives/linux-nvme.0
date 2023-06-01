Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DA3C7EE23
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jun 2023 08:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vAUgWsWihuICZ0W/UHSMFcstti8PKzf4LJWc1QG6u2I=; b=lC8ru77YkrFD/Vee9kTYVX/WJt
	ghQBRJqTpl47bgiWTP7qb2ehqopchqAksIrLjYVAomFSKqL14W4eAsjOhFmMje8cD6S1xN+J0MofH
	hADLCMr8pnVv7tSlDoV159wyZNLrce6bzNUQYNwXMZY/z91yp64AC/V56slT5eHc2ZiS7X+tKJxLd
	HXvYN0UD1BA17p/0xy+iGM61xjb2Jr5jc94pvvyLF10xpfre+G32NgP4T0Px5XAUPdpIFOvp2RDGg
	+0M4bL/7dCVJUchbbgJIH1vLpp6QbwATaVUhuLZuAJ/q9N7BSNpaDrA/tj0yCQ8Ibdz1lfzyyEmHN
	Kwv3LrFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4dwy-002cAW-2O;
	Thu, 01 Jun 2023 08:46:28 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4dwv-002c9g-1w
	for linux-nvme@lists.infradead.org;
	Thu, 01 Jun 2023 08:46:26 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 64F8021963;
	Thu,  1 Jun 2023 08:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1685609182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vAUgWsWihuICZ0W/UHSMFcstti8PKzf4LJWc1QG6u2I=;
	b=Fa6Qp9M8zkX8d7ViVbC6opC2XtnbX39SZk/kNLTkrVEKBIvWzZuQHeeRTPijl8pZEp3fUl
	82xm7rAso6+apMtekNKKezo4WDOUXZhKSHIVZ16ZVQD82pkHk8iCP0gmorP2g59DwkzKej
	MPIYyh6uoP6qsDpQiFwl0QC3x59EIfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1685609182;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vAUgWsWihuICZ0W/UHSMFcstti8PKzf4LJWc1QG6u2I=;
	b=uUDkFIs9oiv6jts0Ve9FGf6E+UQ0WotOeoShTGbXJZSLgTyrbnGJipM5JDj/pkVLnhRziQ
	r7cbmH8pvsaG7kCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5620613441;
	Thu,  1 Jun 2023 08:46:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 84nDFN5aeGThDgAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 01 Jun 2023 08:46:22 +0000
Date: Thu, 1 Jun 2023 10:46:21 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Shin'ichiro Kawasaki <shinichiro@fastmail.com>, 
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v4 09/11] nvme{045,047}: Calculate IO size for
 random fio jobs
Message-ID: <wcbwh4ju5c5chtxyuekffwn3uvjnlqy2fanltr6d7x34lgbrfc@nluc3kfnwych>
References: <20230511140953.17609-1-dwagner@suse.de>
 <20230511140953.17609-10-dwagner@suse.de>
 <c5c2af7c-2b63-f30d-f568-c136dd6f6c5c@nvidia.com>
 <5duh22ydzwth2z2sd4oo22cuaqlazxq3u5m7vo5qfkp4fgec7w@elzdr6vbksgv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5duh22ydzwth2z2sd4oo22cuaqlazxq3u5m7vo5qfkp4fgec7w@elzdr6vbksgv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230601_014625_808770_52DFAFBF 
X-CRM114-Status: GOOD (  15.67  )
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

Sorry for the late response, had to deal with a lot of high prio stuff...

On Fri, May 19, 2023 at 01:36:17AM +0000, Shinichiro Kawasaki wrote:
> On May 17, 2023 / 04:44, Chaitanya Kulkarni wrote:
> > On 5/11/23 07:09, Daniel Wagner wrote:
> > > _nvme_calc_run_io_size() returns the jobs size for _run_fio_rand_io()
> > > function. The jobs size is the size per job, thus we have to divide
> > > through the number of CPUs.
> > 
> > sorry I didn't understand why we have to divide through number of
> > CPUs ? isn't tht will change the current job size of the test ?
> > 
> > unless we are increasing somewhere which I missed it .
> 
> This change reduces the I/O size per job, but it keeps the total I/O size
> regardless of the number of CPUs. This will keep test case runtime reasonable
> on systems with hundreds of CPUs.

Yes, indeed.

> As for the test case nvme/045, it tests re-authentication. I don't think it
> requires total I/O size proportional to number of CPUs. As for the test case
> nvme/047, it exercises different queue types (write queue and poll queue). Does
> it require total I/O size proportional to number of CPUs? Daniel is the test
> case author, and I guessed he is ok with the change.

Yes :)

Thanks for applying these patches!

