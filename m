Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B3EF46446
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Mar 2026 10:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BP+pwxSDM+lypCOfl0xxp7qZHOt0plST1vb/z1gWzyA=; b=b2ZXM1dEsTeds9ds0qq65Ni0J7
	NhxsDEnt3DqDwN5grraKXFyafh3hra7Va3KcW7arFcNbyAJSvtfHLMfGa6snorK+aeitsZDOyo46d
	jBnuQSHiAZX1DrpDZh6yT7gGcRRsQwS9Xj5WWk+dltBGKUF4XDyXicj+5mP2FuR+lXUuvfGLqlFNC
	uH3bO8XDJqbWRbNwcJCBUuCpY2bK6zqV8EvK2v6pP/yzHbRu7dGjeXgd5tbRkCEraQQ6jhxMBHNmh
	k4Gj6KhnwwqZcbteeJIuLwuxrvmrxdTe5IZXNE6Uw2OTk6FhsJ+hZ5HL6HtdGkWdWyAgZSRuKd9dN
	QxQqUaCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2544-00000003kCd-1XTp;
	Mon, 16 Mar 2026 10:20:48 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2541-00000003kCJ-3yjs
	for linux-nvme@lists.infradead.org;
	Mon, 16 Mar 2026 10:20:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B3FBA419AF;
	Mon, 16 Mar 2026 10:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DBDC19421;
	Mon, 16 Mar 2026 10:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773656444;
	bh=uBu8mLZ+rpt9hHO2zebFJ320GkM1XA33y5mwSl91uXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UDAiyRhIXd16/3n5yLWqFADfP+XReuxaog2CvKttjDc2OI/QYNL4mwF+CIqtaO3Xt
	 nVCnBO2veL3YHcW2M/al3N7NNdtQxG3RK5+PzYo5tgFWUbuZFWefrbgmebUobo/FqX
	 E/7Jvw9UXMob3HhGf9JzB083MJy5xifdVTNGSQRDwUsTi6kWbzYkuEDGBF2AZBIsUu
	 EsisgrMjf/pATcn8oakB9tMAm9J+p2kpQDMFFBWhJesBObIOEijxO7+S/94gcXri5W
	 HwaihjisMgWQuD8/WV5d3I2sSQcn1UBREtld7gk+oOAmDJ3ndKabxfbaj/+Z5VDOrJ
	 jGpDyanxyr9GA==
Date: Mon, 16 Mar 2026 11:20:39 +0100
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: LSF/MM/BPF: 2026: (V)FS: Second Round of Invites Sent
Message-ID: <20260316-gebiss-drehkreuz-1f3f0e7a96df@brauner>
References: <20260110-lsfmm-2026-cfp-ae970765d60e@brauner>
 <20260225-aufeinander-kummervoll-1953a06beae9@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260225-aufeinander-kummervoll-1953a06beae9@brauner>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_032046_042132_F7510FD2 
X-CRM114-Status: UNSURE (   9.73  )
X-CRM114-Notice: Please train this message.
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

On Wed, Feb 25, 2026 at 03:52:23PM +0100, Christian Brauner wrote:
> Hey everyone,
> 
> I sent out the first round of invites for the (V)FS track.
> The first batch is also the largest batch. We will send out a set of
> smaller invites later.

Hey everyone,

I sent out the second and last batch of invites for the (V)FS track.
I've also sent out declined invitation notices. In case you have
received neither it is to be treated as a declined invitation at this
point.

Should any attendees be unable to attend because of... events... we may
be able to notify people on the list but it will likely be very short
notice unfortunately.

Thanks!
Christian

