Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3F2C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Apr 2022 00:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FLw/IFjDMl8eW0ND0bbrqUtnt+KtMeYLtJp2uhoHnsc=; b=o+T1IVpihHAnVsMWfH6WtO2q8z
	EXs5XlrBSOApqoEjMPXrNyIdInsGtHcFdAqxnXLeqR0ubr35deI7tId8xaEisRsp/0dLKY9vwwarD
	si0GAPiH9A1R6xMWk7QskKu037KHA/qDQ979vNNOYpKPU4DmzOX6B9aVPGD0zZG0ULTZdjNNRzli7
	A2L2jjPI33BxMRlueeU4t6aeWC4mPEu83yisHsYJ4bT1deBmKkMboITqwvHR+ZxMdNp3zh1x90f7M
	RtnZ7+PQIaUxfyOdO/qRBofxM0spF8Z3p/CKBE+0bCTy66m52uPAz6ShPYcf30IPQvtcLO8HH3bqO
	ZV1/DNqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njV9h-00GjO9-HI; Wed, 27 Apr 2022 00:03:41 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njV9e-00GjN3-Ih
 for linux-nvme@lists.infradead.org; Wed, 27 Apr 2022 00:03:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 394F1B82163;
 Wed, 27 Apr 2022 00:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A68C385A4;
 Wed, 27 Apr 2022 00:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651017816;
 bh=t0zawJnlOyXwzS6WK1c2yglNRvFTH/XaDhjC3G/cH0U=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=UJPV/z8jzqRLnklprH9L/Jwnm39U4CizfBZ0c4Z3BZbNdwNnIstnX8wMb91JanmsQ
 Ytcvpg38EFUfZjIb86PFIdAyfXXFKimzD7vLv3698oCFMqB8JoV1YjmlJSbEy1+JrI
 QMBcMpJR5O3vDRJhfRdPykZGx60YPhX1dyOmJt7GZqvrGweohyhqFBLSI0bZbvZr5h
 y++QVEpjNWy8+ioJBvifR0EbZ5IEvHPQvMwITWeEJfvXj8NE19INresRfLChWBAPMp
 A7Jip0KdZL6OCNHPMYhh2DbLlZ4IjVTWWVOP83S91lHcv8eAEOTEDRwKglOYRh6kT3
 DUamUXmWnJdGA==
Date: Tue, 26 Apr 2022 17:03:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chuck Lever <chuck.lever@oracle.com>,
 netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, ak@tempesta-tech.com, borisp@nvidia.com,
 simo@redhat.com
Subject: Re: [PATCH RFC 4/5] net/tls: Add support for PF_TLSH (a TLS
 handshake listener)
Message-ID: <20220426170334.3781cd0e@kernel.org>
In-Reply-To: <40bc060f-f359-081d-9ba7-fae531cf2cd6@suse.de>
References: <165030051838.5073.8699008789153780301.stgit@oracle-102.nfsv4.dev>
 <165030059051.5073.16723746870370826608.stgit@oracle-102.nfsv4.dev>
 <20220425101459.15484d17@kernel.org>
 <66077b73-c1a4-d2ae-c8e4-3e19e9053171@suse.de>
 <1fca2eda-83e4-fe39-13c8-0e5e7553689b@grimberg.me>
 <20220426080247.19bbb64e@kernel.org>
 <40bc060f-f359-081d-9ba7-fae531cf2cd6@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220426_170338_947075_C762706B 
X-CRM114-Status: GOOD (  23.84  )
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

On Tue, 26 Apr 2022 17:58:39 +0200 Hannes Reinecke wrote:
> > Plus there are more protocols being actively worked on (QUIC, PSP etc.)
> > Having per ULP special sauce to invoke a user space helper is not the
> > paradigm we chose, and the time as inopportune as ever to change that.  
> 
> Which is precisely what we hope to discuss at LSF.
> (Yes, I know, probably not the best venue to discuss network stuff ...)

Indeed.

> Each approach has its drawbacks:
> 
> - Establishing sockets from userspace will cause issues during 
> reconnection, as then someone (aka the kernel) will have to inform 
> userspace that a new connection will need to be established.
> (And that has to happen while the root filesystem is potentially 
> inaccessible, so you can't just call arbitrary commands here)
> (Especially call_usermodehelper() is out of the game)

Indeed, we may need _some_ form of a notification mechanism and that's
okay. Can be a (more generic) socket, can be something based on existing
network storage APIs (IDK what you have there).

My thinking was that establishing the session in user space would be
easiest. We wouldn't need all the special getsockopt()s which AFAIU
work around part of the handshake being done in the kernel, and which,
I hope we can agree, are not beautiful.

> - Having ULP helpers (as with this design) mitigates that problem 
> somewhat in the sense that you can mlock() that daemon and having it 
> polling on an intermediate socket; that solves the notification problem.
> But you have to have ULP special sauce here to make it work.

TBH I don't see how this is much different to option 1 in terms of
constraints & requirements on the user space agent. We can implement
option 1 over a socket-like interface, too, and that'll carry
notifications all the same.

> - Moving everything in kernel is ... possible. But then you have yet 
> another security-relevant piece of code in the kernel which needs to be 
> audited, CVEd etc. Not to mention the usual policy discussion whether it 
> really belongs into the kernel.

Yeah, if that gets posted it'd be great if it includes removing me from
the TLS maintainers 'cause I want to sleep at night ;)

> So I don't really see any obvious way to go; best we can do is to pick 
> the least ugly :-(

True, I'm sure we can find some middle ground between 1 and 2.
Preferably implemented in a way where the mechanism is separated 
from the fact it's carrying TLS handshake requests, so that it can
carry something else tomorrow.

