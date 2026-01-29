Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D06D6B087
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Jan 2026 16:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G5GeqY1juZx6peJ0RBfJB14cgHFI8J5YlMRjKhV9azU=; b=Kw3mHe4Lq33110tinq6eP7fqfz
	4Bs9mjXh6vAxNbvTq9jz0ZDZvul/qDEvUZlvaI1iv33WD0ZUn/+1lDZf570m25mQ9amEUbpvf+moG
	TUv78bfaLebUpwMagIefJ+csRKb6mWWE5bhKmzL46/4TAgaol6tqST20Rr5fPxN67LG55UjcyTspE
	SaVtOCwLSRuiGBq+KIw4yDs+r96V8AtZ2sG1gppZVy3HDH9F1gyBCUt6o3amONVbJ1OWxu6ci22FD
	iY8uanipTIVBeCqhi+kNv982yTA7GP15e6X98Td0jIyBEIxcJzLfj2M00pJ425R+UBApDC7JLAoAA
	91hZBHgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlUef-00000000KEj-2id9;
	Thu, 29 Jan 2026 16:14:01 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlUed-00000000KEM-2zbU
	for linux-nvme@lists.infradead.org;
	Thu, 29 Jan 2026 16:14:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 826FC418D1;
	Thu, 29 Jan 2026 16:13:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74017C4CEF7;
	Thu, 29 Jan 2026 16:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769703238;
	bh=La9o6W4y0vVBdcH6KlN6XyFOKCu8acKZkPR8qhv2+vE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lRPlLdn++Td8jmuOq6JleUntXrH91GO4yrJZdWSzMPTDmpPBJ6nv76jPziMi9ovQp
	 bIn02G/pVE0WSFFQmfs4D1nBRF7jyfqdm7ehToSqEm91VEq0IutGkhv3z1n9RPuTNq
	 07q0cp4WRe74VrHEBVTpBegZIA/HFkpII9yOkSQrViRSZbri6Umnol8B8tzJ6/hFgD
	 ooc+izjKn0i5pxc9MlAcI6lh8Xbnz+ypRl6Awzf5VWArZUfWKLIV4l64hYaquEYURB
	 CwO2X2rA1nCqjH75mPKQtKLqEM/8oUvJbHJY7TUdsRFkbGTVS3GiTVhk7thEdz6std
	 VQBPs3W7lUXTA==
Date: Thu, 29 Jan 2026 17:13:52 +0100
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	lwn@lwn.net
Subject: Re: LSF/MM/BPF: 2026: Call for Proposals
Message-ID: <20260129-beidseitig-unwohl-9ae543e9f9f5@brauner>
References: <20260110-lsfmm-2026-cfp-ae970765d60e@brauner>
 <20260119-bagger-desaster-e11c27458c49@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260119-bagger-desaster-e11c27458c49@brauner>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260129_081359_774832_131BDECD 
X-CRM114-Status: GOOD (  12.03  )
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

On Mon, Jan 19, 2026 at 03:26:39PM +0100, Christian Brauner wrote:
> > (1) Fill out the following Google form to request attendance and
> >     suggest any topics for discussion:
> > 
> >           https://forms.gle/hUgiEksr8CA1migCA
> > 
> >     If advance notice is required for visa applications, please point
> >     that out in your proposal or request to attend, and submit the topic
> >     as soon as possible.

This is another reminder to put in your invitation request!

What are you waiting for? The weather in Croatia in May is nice. What
could be better than soaking up some sun through the meeting room window
while someone's asking you to make your locking more complicated, grow
your data structure by just a few bytes, or to add some more spaghetti
to that code?

Please also don't forget to pester^wask^wremind your respective
organizations to sponsor LSF/MM/BPF 2026! Bring it up as much as you
bring up that patch on-list that didn't get accepted but would've made
everything so much better.

Thanks!
Christian

