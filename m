Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06062C4167B
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Dec 2023 05:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iYzrF0kcZn1C6ks5RVenRKfzxmbKwzw2JsRSQsWyh30=; b=iBuVNOj/fHQukyY0DFmfl3yIS0
	LlNWdOj6H3FhOPUJhsFbn+OCZuaVQJYIeFQ5SmdEjneqaMIy5rqldzwzGKhZQLfVVdV02fBHxEpaM
	3PN2QfkuKM9X2tfuYkZhvJ+TsYyfYHIJgMNabOrGdeWAmJlFk8FcmeUYKFnZhMUROk3qLtqKe3RHu
	0LLC2vNOt5pWshB4l5hOd0blKEkSzsDKcxdzs1Y4/nRR5ZRun4r/1yetUdrhe44zThyvoH4HBAujX
	CRh3E4/InjengOY3xD8gwJy0wLUbPjuSexHoUwWc6n5fpetiTw6LeBzbzXhdToPP0bdBrbN1Dzit2
	4LKpsgsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rANpa-006ILf-0C;
	Tue, 05 Dec 2023 05:18:50 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rANpX-006ILB-1V
	for linux-nvme@lists.infradead.org;
	Tue, 05 Dec 2023 05:18:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id ECFFB6153B;
	Tue,  5 Dec 2023 05:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D047C433C7;
	Tue,  5 Dec 2023 05:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701753525;
	bh=2FU6xI2SxCz20fD3myDqT4SfMmnFzzLWyDDKaxBN2Yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CewyGbOX3f3XXXj3P6GDe9dt1spkWc/AkGpIzQovEE62XQwqudxmhOhqzgwhlrBsQ
	 HiM+ZHhbtmYz472FLGZ+xNKrNZgCmWIMmMB1bPj0/z3ymWc3V5esnR1A9IHYIlBjVx
	 A5oC/GaxLSnsbUTO15w7je5u1sNDdJxCq6wE+dN0HcN78FZ9SVWvYAZatT2em0znPl
	 cfQaZUaCbKkj+lltd4xOkHo9tmI0OAvW3LLETwM5OX5baaNqvOuxTL1NZBATFGuNsR
	 rtU1C92vkZvACHxE8CI12h1lnFwLURaJ+K4law3lIn9evBu6GRyqFHFBEDUfwbtrv0
	 xwE91TGLyoGJw==
Date: Mon, 4 Dec 2023 22:18:42 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jirong Feng <jirong.feng@easystack.cn>, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	peng.xiao@easystack.cn
Subject: Re: Should NVME_SC_INVALID_NS be translated to BLK_STS_IOERR instead
 of BLK_STS_NOTSUPP so that multipath(both native and dm) can failover on the
 failure?
Message-ID: <ZW6yskpdzy8uAp3u@kbusch-mbp>
References: <9b1589fb-6f47-40bb-8aa6-22ae61145de4@easystack.cn>
 <ZW6pJAm9wgqj1HEW@kbusch-mbp>
 <20231205044035.GA28685@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205044035.GA28685@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_211847_575261_A26F9AC8 
X-CRM114-Status: GOOD (  17.16  )
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

On Tue, Dec 05, 2023 at 05:40:35AM +0100, Christoph Hellwig wrote:
> On Mon, Dec 04, 2023 at 09:37:56PM -0700, Keith Busch wrote:
> > So the controller through that path used to be able to access the
> > Namespace, then suddenly lost ability to do so, but some other path can
> > still access it if we retry on a failover/alternate path? I think your
> > target is returning the wrong error code. It should be SCT/SC 303h,
> > Asymmetric Access Persistent Loss (NVME_SC_ANA_TRANSITION), for what
> > you're describing.
> 
> Yes, assuming ANA is actually supported by the controllers..

Even without ANA, "Invalid Namespace" is still the wrong status code
when dynamic namespace attachement is supported. If the namespace still
exists in the subsystem but not attached to the controller processing a
command (i.e. "inactive"), the return needs be Invalid Field in Command:

  Specifying an inactive namespace identifier (refer to section 3.2.1.4)
  in a command that uses the namespace identifier shall cause the
  controller to abort the command with a status code of Invalid Field in
  Command

