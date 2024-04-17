Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48962C4345F
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Apr 2024 17:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8vdoC1n4NAGT51zT+XjZG+byDRcMNbmlIj/N6lUsVwg=; b=Ta0Z2ywAWCBeVRqDD7CEk3h+nw
	J8ZjOj3JHE7yXS7leTKETTjhM2sIC0sw6X66MzdlYGpzWRchHurBQv24b6V8aEVipvEzbEuHaGPTG
	zAJlsYaFtnl/ih6vYsOFHgKyR4y8FbqBY5p7yDbjiGMVbWkKPwQK4CN1Jamx+vhbe185ncUltMA9g
	zVH732SyBUrVLzFfAcNkkSBOA54CkfmYCDFtlLimLQQslYLC/QKl80xOT3QedBSdXEpKoVUSmDUWe
	kAv0jpObQ5eHLkwkhMHUvu0PROIoDT0mF0G4BNSLcqw7LHSnE6Dv4AElcU1pDX+qqgAV8jmq0RFDa
	rc8jjFXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx8eh-0000000GvBA-3tMc;
	Wed, 17 Apr 2024 17:01:07 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx8ed-0000000Gv9e-3PSI
	for linux-nvme@bombadil.infradead.org;
	Wed, 17 Apr 2024 17:01:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=8vdoC1n4NAGT51zT+XjZG+byDRcMNbmlIj/N6lUsVwg=; b=XxHSYhkP78vnJXr5/ru9AvKGXA
	lONfc7ZJWmnQXT3d5x5ISPQdxCHO8rKYhbxpKj9pWh3ovmQdYcFg78TedrrV5/5xzTxEhqiVrBiog
	WnxvR/ra+zuLcI4ns7qg45glSwti8l0u1LSAGewJxEm3UgYi+LFYX563hQw1MJexJB6BhCkeDH9Me
	3TYfDZ4zWAA5utfC+3Ki8UzUlzi26APyPUUxj0y0X86HCnWD8+uIxoopV+hAJ9WtPvLjFhgk4Xvoq
	5JUUyAyM8wA6QfYjm1HJN5uS0DKHEc5Ofc51brgBoWOuhNzFflnOTpz5o/b9zE+BDE+vzC8ENuSWt
	2PPTNetQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx8ea-00000003KIC-220d;
	Wed, 17 Apr 2024 17:01:00 +0000
Date: Wed, 17 Apr 2024 18:01:00 +0100
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	bpf@vger.kernel.org
Cc: lsf-pc@lists.linux-foundation.org
Subject: [LSF/MM/BPF TOPIC] Running BOF
Message-ID: <ZiAATJkOF-FulDyS@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

As in previous years, I'll be heading out for a run each morning and I'd
be delighted to have company.  Assuming our normal start time (breakfast
at 8am, sessions at 9am), I'll aim for a 6:30am start so we can go
for an hour, have half an hour to shower etc, then get to breakfast.
We'll meet just outside the Hilton main lobby on Temple Street.

I don't know Salt Lake City at all.  I'll be arriving a few days in
advance, so I'll scout various routes then.  It seems inevitable that
we'll head up Ensign Peak one day (6 mile round trip from the Hilton
with 348m of elevation) and probably do something involving City Creek /
Bonneville Boulevard another day.  If anyone does know the various trails,
I'd be delighted to listen to your advice.

Running pace will be negotiated by whoever shows up; I'll be tapering for
the Ottawa marathon two weeks later, so I'm not going to be pushing for
a fast pace.  This is a social group run, not a training opportunity.
People who want to do more or less are welcome to start with us and
break off as they choose.

You don't need to sign up for this, but if you let me know whether you're
showing up, I might wait a few extra minutes for you if you're late ;-)

