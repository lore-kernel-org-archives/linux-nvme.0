Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F27C6FD19
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Mar 2023 05:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3KUOIEuDKyOHxMbucNAykOCAoCC6boXcHa1Piw6R6Zo=; b=eEfgnoTCb642Odg58vpkzV4jFT
	ToVVY6W6/Orpo8Xs9DvvuZ0o+r1QBE/wxLkiugq9kB0PbPgMzoQw431CViFSSHwCxkUMy1fmE18Gf
	AQ4ZtThu+NKpzxsGS1t9q+rfVOUy14QZcVqaDBppO0xAiR/2Lz7h5VdY+F7l7iyJStMsbXBweKK5k
	vPseZ+GZ3Z5EIksYavl4FmBdLTLC+hVy9Nb1PRp+S+NnJLg61vwmocHQ3rCjPeno22bPK7eitFciu
	lvVUOVDslO4XfhzPZWKRPFlLHsHEPtwoLlmoqkmsd757VrHq8zrIV5MkwzC57mXXzN7zr17n1xzGe
	xoWXtzNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYK3q-008K4Y-TC; Sat, 04 Mar 2023 05:03:58 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYK3p-008K4I-OO
	for linux-nvme@bombadil.infradead.org; Sat, 04 Mar 2023 05:03:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=3KUOIEuDKyOHxMbucNAykOCAoCC6boXcHa1Piw6R6Zo=; b=q0t5NYZ0s0uZSFwaYIKPlHAgBG
	Fh/YpnJ1T7/9vUHeow3hD7Dik99DlmvRByFkcfQZwxvA6KtYG5XM5G0U6uZ/r4FBBtIByb9OqDdZG
	vQssjkyGhGkTluG3K95ZFHJKSynL14+TSOi1HkppE1tkOTxmsdhcmAvO4sGTy0QJthwNdwQFrXy0t
	Vn7bD5YMBPbFmyeWmpANMe5iCD8vq/cl2FY5611Tudn/B2YxWnlPK/CUqW5OsPJH3Ffc5YQwZem1E
	dRMzau6dzmCdGuBED3iNxx1GGRhJd5yy4hQDtKNFt7umUM+SNCpdQCDvbqWeAne9KSxum6aBNAzoN
	sxvPLyWA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYK3l-003er5-Gy; Sat, 04 Mar 2023 05:03:53 +0000
Date: Sat, 4 Mar 2023 05:03:53 +0000
From: Matthew Wilcox <willy@infradead.org>
To: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Subject: [LSF/MM/BPF] Running BOF
Message-ID: <ZALROVnC+GDXsBne@casper.infradead.org>
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

Sunday May 7th is the Vancouver Marathon, and both Josef and I are
registered.  As such, neither of us may be feeling much like joining
or leading a run.  If anyone else is interested in participating,
https://bmovanmarathon.ca/ offers 8km and 21.1km races as well.  If you
just want a spot of morning exercise, I can suggest routes, but will
probably not join you.

For those concerned about how the marathon will affect getting around
Vancouver, you can see the various course maps:

https://bmovanmarathon.ca/marathon#course (8:30am-3pm)
https://bmovanmarathon.ca/halfmarathon#course (7am-11am)
https://bmovanmarathon.ca/8km#course (9:30am - 11am)

Don't expect to walk around Stanley Park until the marathon is over.
The Skytrain from the airport will be largely unaffected (possibly
infested with sweaty runners).  Bus routes may have diversions in place,
but the roads will open once runners are no longer using that particular
stretch, so eg Cambie & 49th will reopen to traffic quite early while
Pacific & Georgia will remain closed for much of the day.

If you want to come out & cheer for Josef and/or myself, let us know
and we can suggest good spots.

