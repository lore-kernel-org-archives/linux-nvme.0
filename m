Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15016C0015E
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jul 2023 11:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8blCrV88O6kZTECcW6yFH6jJTp6I81UB/6UiMgYJZfI=; b=2GnTSMRk+geg0KWCNjmW1X4QQP
	6OqR5dDO/VbkKiKSP8J03ZVE8Zkl9GT/O4sCIBCYSWDAhbu8yYkTZOmN1j7PRd75feihachiPUsuy
	NrnYvebDw+97tkPY6rKfcOZzGb/JJ8nNEw5H3+zc/zPdD9nvTjhA2nDp9zKbgBPEsG+Tv8uKeE7jg
	pGTDimBYPVsXgLubahtJj32kOpfOnYt1GNh1EEehfNpRaaPLAx8joQLOMfvGmYcIGOkNP/U8R6A+1
	ttPFAN7CZgwPPDdxZZpX9IPpVhTAh/1gaLATkqvApk4vDxcfhvjhojDnoXIRD9p4f0V9IdImzU4iv
	6KYOX+6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qM5WK-007HJv-33;
	Wed, 19 Jul 2023 11:39:05 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qM5WH-007HHd-2n
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jul 2023 11:39:03 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id F27D561626;
	Wed, 19 Jul 2023 11:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597B5C433C8;
	Wed, 19 Jul 2023 11:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689766740;
	bh=NtDa673qM3W2WdFVYdb8immacaWoESgu/M+KV26c+VQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F3Wwm/px5hxcn38XTY9Nw8TtT4/Kmc6HxHO6688wXM+n0V1yfAocy8ZjGREQipR8+
	 dunB4eooKaqV2ICmDz9KE6cmeFWc53tyhGQOE6Ot3AacMUH5xBMNp41i4YjLAWMhon
	 pyqo7ZPUujT26FNan4vRpe2WP2XFFBnSAgKxBmAyPWtLvXn5OJAi7UDINjTYpNMzNj
	 KvTC4Wc6yjxWQGyAL+IfVSkYYSix+sNN+pdETjtUJK/U3BtiiwdqxXIP+SDxuzSzjc
	 VHIR+GWPix8aURJmDsuokkRy4VISkt0jKt+jt/dWuwQqFhtKkOpFRBAQ42+wjoiigq
	 NhrieVhFHrOhA==
Date: Wed, 19 Jul 2023 13:38:55 +0200
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH v1 1/2] nvme: drop multipath config option
Message-ID: <ZLfLT5Oirckc+o7W@kbusch-mbp.dhcp.thefacebook.com>
References: <20230719084147.16272-1-dwagner@suse.de>
 <20230719084147.16272-2-dwagner@suse.de>
 <ZLe1QmfGg488wH9D@kbusch-mbp.dhcp.thefacebook.com>
 <egbrvnkgv7dpbcqudnvp5xzj75ng6qh3fe7exedwmmffixibex@cdr4jraimzgk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <egbrvnkgv7dpbcqudnvp5xzj75ng6qh3fe7exedwmmffixibex@cdr4jraimzgk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230719_043901_962181_81F27527 
X-CRM114-Status: GOOD (  22.26  )
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

On Wed, Jul 19, 2023 at 01:13:18PM +0200, Daniel Wagner wrote:
> On Wed, Jul 19, 2023 at 12:04:50PM +0200, Keith Busch wrote:
> > From my reading of this message, I thought the intention was that this
> > driver will eventually replace it with a:
> > 
> >   			goto out_put_ns_head;
> 
> This would obviously make the PowerPath module unhappy. Sure, I am aware of our
> upstream policy so I wont argue.
> 
> > instead of letting the namespace become visible for some unsupported
> > mode. The warning was to give people a chance to migrate off whatever
> > unsupported setup they were using, not a deadline for when the warning
> > dissappears.
> 
> I assume this means the dm-multipath setups? If so, I understand the motivation
> but do we really have to burn the bridge here? It's not that we have additional
> code or maintaince overhead, except the module parameter multipath.

Yeah, dm-mpath is such a setup this was intended to prevent, as well as
out-of-tree alternatives. Not that I advocating one way or another at
this point; I'm just trying to set the context for why this message
exists for discussing your patchset.

I'm curious why a proprietary module is even used, though. Is the
driver's native handling doing something undesirable, or is this to
cater to some vendor specific behavior outside the spec? If the former,
I'd like to understand the problem and see if there's something we can
improve.

