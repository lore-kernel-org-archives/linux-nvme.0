Return-Path: <SRS0=GtbF=H3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F768C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 16:23:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED19A64EFA
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 16:23:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED19A64EFA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ATB2vpLZh0haKUYXUxXXzbrTCFmCZvQC7INNXkIxaVA=; b=BidYawbH5zFZ0nDhnnCHwuyul
	wAkPJhwI/HIytuXMw36uFvTmMAdgefwOyMIfRBRtz1XKHQhrC8ZEMW4t1HihYt1iuOk2xTqP8zAQh
	jRfK3kWpwjoyCrREuzd1Wv7SQWw9AVdDPqo4s6W6Dq6hwXVxA81NpNvOupXCmoVJOpZ5uRnIPMC3o
	KknKPofKngdr7EljZbyCxMmzY9A1bXGxYTLeOtKbrBk4ZYq0if33GVcx+1HSGZXfVmLcBo0Mn1AhR
	KEwttnMB+V0/r0jb3v8lIDQbu7EjSl6iMi9QWw4FH4kQjo3Tp4iZTCPKsFeQeEHZSWYqtCKtc3iEW
	snpBrbpyw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFJPV-0004oc-UP; Thu, 25 Feb 2021 16:22:42 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFJPS-0004ns-Rv
 for linux-nvme@lists.infradead.org; Thu, 25 Feb 2021 16:22:39 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id A844464EFA;
 Thu, 25 Feb 2021 16:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614270157;
 bh=mYNBUiWAoIFMjB3Rg1By3OXG3Tu7N1Pl4VBRjFsZsTY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IwSa5D7TVaTRtTih5ivlUSytFvx3fyyxGK5tadIpAepenv8hpOEDUwgOsELHSTqSZ
 EOHT0pHLoqLVKg1Ktt5gNwj96Ks26Ff2Gu1X2ZjjS81q03dqlOdF2Dm50X6dNjloFf
 s2wFf0LASzDgGIYZOIhHHlgkPd5OEa29LCRQXU1CcK52fhVmxAZKXeX5ndrxIv5mKW
 8QQHQCjDuAivxiSx4WEz+7VzQOPnBFEQoLgxAD9BYBRJNZfDqw27O/C8Y3538lKbun
 BgX4LXOCeLCyOZj0CinSzOls6iEJifqqQACVi6q7uK1CGEcaaInuFl5X8G/Q6rPEy1
 ToRRh97UGqayA==
Date: Fri, 26 Feb 2021 01:22:34 +0900
From: Keith Busch <kbusch@kernel.org>
To: Pascal Terjan <pterjan@google.com>
Subject: Re: [PATCH] nvme: Add quirks for Lexar 256GB SSD
Message-ID: <20210225162234.GA31593@redsun51.ssa.fujisawa.hgst.com>
References: <20210223221046.3367795-1-pterjan@google.com>
 <20210224092147.GA2195892@infradead.org>
 <CAANdO=LFVGNWNs_p9h0GsukVkRMcDQ1A5qsaa2m9HSPhu0wr7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAANdO=LFVGNWNs_p9h0GsukVkRMcDQ1A5qsaa2m9HSPhu0wr7Q@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210225_112238_982658_0C199D98 
X-CRM114-Status: GOOD (  18.34  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Feb 24, 2021 at 10:23:23AM +0000, Pascal Terjan wrote:
> On Wed, 24 Feb 2021 at 09:21, Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Tue, Feb 23, 2021 at 10:10:46PM +0000, Pascal Terjan wrote:
> > > Add NVME_QUIRK_NO_NS_DESC_LIST to Lexar 256GB SSD to allow it to
> > > work again, and add NVME_QUIRK_IGNORE_DEV_SUBNQN to avoid a warning.
> >
> > Why again?  The drive has always been broken since the desc list has
> > been a mandatory feature since NVMe 1.3..
> 
> According to the reporter it works on Debian which is still running a
> 4.19 kernel
> My guess is that it worked before
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=538af88ea7d9de241e6b6f006e9049c4d96723bb
> as the error was ignored
> And I believe it would have worked again until
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5bedd3afee8eb01ccd256f0cd2cc0fa6f841417a
> as a waorkaround was added at some point (it changed at
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fb314eb0cbb2e11540d1ae1a7b28346397f621ef
> but was laready there)

Right, the error used to be ignored, but now we avoid the error in the
first place with the quirk.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
