Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39680C61D85
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Nov 2023 18:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gp6T1/K4P2YcZV58xGc81WtCX4oMtCfL9UgT1h7hBNA=; b=WtmWvj88nduaZbk5BCtuOodpjF
	nWn25g7qk9+esLXUU2IU2XuIzoQUeqfh5hpR02nbw0wggIJoe6Q9azhTZuHwRydSCOBAulNkd0n6O
	DxL5prRsRjhjQ7bSW5bmm61pUgfCWAvudBCXmfhVLs9rAlplWOv8OWu5w6znqvvCX+KmkRD79lWpg
	iS749VBrWNOjKraB91Mi6Sj79FjnTqnkTLQDHE/ZWITzceX2uoZBW+8JNzBAXn2GKXikXPwGaoCg/
	SHM7TZxc5AAJBC/dj2uYLohPgkIlqYBFwG+Dqo65t7Zrd3oDUab4+KDBfbELFPKIQQ+TciMYp9jZY
	5pnPMIcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5VG4-00HSkT-04;
	Tue, 21 Nov 2023 18:14:00 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5VG1-00HSjz-1f
	for linux-nvme@lists.infradead.org;
	Tue, 21 Nov 2023 18:13:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 58964B821E7;
	Tue, 21 Nov 2023 18:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9B6C433C8;
	Tue, 21 Nov 2023 18:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700590429;
	bh=m+huApgYyngIgWn8TxM+6VO8JYElxMWaEAlQ144wvj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qRI4lGoANvAN34i6GpOonnSejPoN73uTehu6IDrjZMlR+3HwLKFMA4XC/mNpb0nbz
	 IN9fH3a2qj7FV7f9HkmC6Nym3PmUJScjyFHsduK75FBtQehlXqXLE0q5tyH/ktpvx8
	 uk3iHM+f3NjzobyyClsEPXknf7uvTViMNTH+L3BgGUEaYQ9aIOIeB3aSbT3AG3bVj/
	 38MjiwbMpmbmY6kgQC6yYoRxp6QgETsAsVqcV0ZmwkhRj+SuQp9SA0ViV8khih7T+A
	 lbCzO0KfkUjQd/zvV4/T6G8Qs0uX2zgOXc7mk6ZED+Rsjryt0Iu95qcrKE1QUTzGJr
	 50W3YdqXOhezQ==
Date: Tue, 21 Nov 2023 11:13:47 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ewan Milne <emilne@redhat.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: check for valid data from from nvme_identify_ns()
 before using it
Message-ID: <ZVzzW0P6CtataBLK@kbusch-mbp>
References: <20231110163721.15292-1-emilne@redhat.com>
 <CAGtn9rmMLQfsocZvWJnnekRxfL2_s3oDYcUNTy3M0c2d8UYYfg@mail.gmail.com>
 <CAGtn9rkynCF1De25--d39D0o2Eh2QV4aDLOxaRYrw2m1ouu_4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGtn9rkynCF1De25--d39D0o2Eh2QV4aDLOxaRYrw2m1ouu_4g@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231121_101357_686426_E6848672 
X-CRM114-Status: GOOD (  13.72  )
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

On Tue, Nov 21, 2023 at 06:49:35AM -0500, Ewan Milne wrote:
> Oh, never mind, I see it.  Just didn't see anything on the list.  Sorry.

Is it? I don't see it in any of the staging or upstream trees, but thank
you for pinging me on the patch.

> > > @@ -2027,6 +2027,12 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
> > >         if (ret)
> > >                 return ret;
> > >
> > > +       if (id->ncap == 0) {
> > > +               /* namespace not allocated or attached */
> > > +               info->is_removed = true;
> > > +               return -ENODEV;

The concept sounds good, though you are leaking 'id' in the new error case.

