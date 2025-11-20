Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6C5CF8548
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Nov 2025 06:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LojWGAx9mVL2XXlyW5uWQ7RbZXgndIU5zwtr1ptBVro=; b=3QO9JaLe5bCV/vsYtta1V7lXqF
	LG3khe0Y2qaB0CBKPgljf+IMn6YXXpy3q6BISIIpO+FdlRySMur8IiX825BTT+dp3zqPfueYjuDd+
	truQInblI0933GAJXpJrwGEHC7c6ki+/Qi/081rPDoLnaBvw7bjwMNAJ/XIZraBUWeqb5fc6shsmz
	1Avjt2ijxm7mMQeY/0Td5AijMa1uSaJ5vfNtK05NlAMfR1aTgdJ0VP+McNYzU65Tu5iXT2jJx+aUl
	/UyqmJR4qyhqSLShnkAUgc07kimBbW9GorRqUrGpew7hRPRVaA6lWj2nHCpJh+phvCvMjdHpusr/q
	KdJyY+pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLyUZ-00000006EzF-1Y6r;
	Thu, 20 Nov 2025 06:50:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLyUW-00000006EuF-2aRX
	for linux-nvme@lists.infradead.org;
	Thu, 20 Nov 2025 06:50:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6A02468B05; Thu, 20 Nov 2025 07:49:55 +0100 (CET)
Date: Thu, 20 Nov 2025 07:49:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: deduplicate empty request list checks in
 nvme_queue_rqs()
Message-ID: <20251120064955.GA30432@lst.de>
References: <20251119021701.3165123-1-csander@purestorage.com> <20251119054848.GA20072@lst.de> <CADUfDZosKsY3TBwPRoEvOCTErcaC3HcR3ChHj=io+=m_EPqX+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZosKsY3TBwPRoEvOCTErcaC3HcR3ChHj=io+=m_EPqX+Q@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251119_225004_798592_D3FBE29A 
X-CRM114-Status: GOOD (  24.69  )
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

On Wed, Nov 19, 2025 at 08:01:30AM -0800, Caleb Sander Mateos wrote:
> On Tue, Nov 18, 2025 at 9:48 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Tue, Nov 18, 2025 at 07:17:00PM -0700, Caleb Sander Mateos wrote:
> > > nvme_queue_rqs() checks that nvmeq is non-NULL before calling
> > > nvme_submit_cmds() and nvme_submit_cmds() checks that submit_list is
> > > non-empty before doing anything. A NULL nvmeq means no requests were
> > > processed from the rqlist in nvme_queue_rqs() since the last call to
> > > nvme_submit_cmds(), which implies submit_list is empty. So just check
> > > that submit_list is non-empty before calling nvme_submit_cmds() and drop
> > > the check for NULL nvmeq.
> >
> > What is the rationale for this?  I had a hard time understanding the
> > logic in the new version, so I don't think this helps with readability
> > at least.
> 
> Just trying to avoid some branches. But if you prefer the current
> version, that's fine.

I find the current version easier to follow.  If there is a good
reason for the new variant I'm ok with it.


