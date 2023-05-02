Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0100C77B7E
	for <linux-nvme@archiver.kernel.org>; Tue,  2 May 2023 15:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zzvrkLFUqS2KJrgKqehrc7ERzU4TMOgKTj4HGDnNT6c=; b=Ze+1VrMR5WPdSEHwAQcP1RQudR
	mn8ERM+dGk0niG0HX52n76yAakH3/B4hrWWk2SP3wjrfFjfR9ZntZWDaaHKp9LPQ4ROdaknUfxS0g
	qmDxt6SsnpiP31GSkQeHErukidc4QdBte3rTPm//0kjWBVPysUQqrin5FzygtE8hGc0NZ08/dxQOU
	nL3ZuWWGKbDOn4BaxY8MdJIbDJ2o/cL/0rqHbXuGXT6fy15okl/SXvZj7tHWZyHz4kmpcSBUKXCIN
	IHUjQoeczG0lsLZ557RawJbBEnvv1DOS5hDPSHVRQC7PBEDiN0/RDQFy1ZdTgQaA0Ev9vIJ4fx/a0
	/S3vVg6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptsCN-001zum-0n;
	Tue, 02 May 2023 15:45:51 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptsCK-001ztZ-19
	for linux-nvme@lists.infradead.org;
	Tue, 02 May 2023 15:45:49 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 83EF821E93;
	Tue,  2 May 2023 15:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683042346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zzvrkLFUqS2KJrgKqehrc7ERzU4TMOgKTj4HGDnNT6c=;
	b=UmPhlf/6SiPXX+aNo/xbG/8SpZllfgqTXCJtpILFaLqVwUCURgsuikh7kqBkl9PMKK6rAp
	RhEF6m+UgU9o1HpN9h1qhB30OqUKzPLJHsGxwB83EYdlmA1STRQBxAZTup5ph1j2GOrCCt
	KsOLOKNYB9R2qTkN5MJp+4s7KedkoG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683042346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zzvrkLFUqS2KJrgKqehrc7ERzU4TMOgKTj4HGDnNT6c=;
	b=/CJf0S3GhgGqiIpNTqHVMxH7v3jQnPM5+WZ4Sa4tmUm2aYy1NTte5D0593rMCkn8YYXfvF
	ce5/Ae/fpR5+v+CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 77097134FB;
	Tue,  2 May 2023 15:45:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Y1jmHCowUWSvKgAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 02 May 2023 15:45:46 +0000
Date: Tue, 2 May 2023 17:45:45 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 7/9] nvme-rc: Calculate IO size for
 fio jobs
Message-ID: <k54c3p47ot3aj7srqyx5ayrjawmdqj47hvtwcxyps67gfq533b@ftj2ugr4lalm>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-8-dwagner@suse.de>
 <sbkboyc3tcad4g5zjdtko6ardhythnaotwp3njchbotnabhlun@mhhvxut6q2av>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sbkboyc3tcad4g5zjdtko6ardhythnaotwp3njchbotnabhlun@mhhvxut6q2av>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230502_084548_532019_4E408296 
X-CRM114-Status: GOOD (  13.36  )
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

On Fri, Apr 28, 2023 at 04:00:54AM +0000, Shinichiro Kawasaki wrote:
> On Apr 21, 2023 / 08:05, Daniel Wagner wrote:
> > Introduce two new function to calculate the IO size for fio jobs.
> > 
> > _nvme_calc_io_size() returns the jobs size for _run_fio_verify_io()
> > function. Reduce the max size of the job by one megabyte to make the
> > test more robust not to run out of space by accident. Note these fio
> > calls run with just one jobs.
> 
> It is not clear for me what kind of issue happens without the 1MB decrement.
> Could you share failure symptoms you observed?

As I said, this is just to make the test more robust as this the size limits
are not the main objective of these tests. I don't care about this too
much, I'll just drop it then.

