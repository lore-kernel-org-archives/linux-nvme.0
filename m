Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE89FC54798
	for <linux-nvme@archiver.kernel.org>; Sat,  2 Mar 2024 23:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1m1I3PwMY609pQ7O8L4wtsAOYHCTyLz2Z3ZflSGxz2k=; b=GStRmCNUeQnKhRMWguFBiS8XDh
	kYQFY3U6h5Q9vprm3U2mT4O36SKczvSmr/gadgsRoFGLj90GxKTOkQMdhcuTHtdP5y0c7zA2D5A0e
	EEVjW5MpnsDCceP5qWpu7iNb+yk5rXiQsVzAEkqYbAHW261Qmcndm6rMrSlXzbwvpdO2nyhFHTA7E
	seQhbXJvSAJoZSoPlVgQUUoRui+vvKh0j9lIeNZcUaT0dpTqcUD8MsNzDNaRQQgMm3sYlAJf5KfPu
	ti6Yt4Y3M6Thh2gNoUQxBdbV/ahz8i4lmqSxi1f6hab1tMNi152G8CwG7tcQwL/0hKqH4eF09Mq4L
	nxoIXMIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rgYfZ-00000004dVE-0HBS;
	Sat, 02 Mar 2024 23:21:29 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rgYfW-00000004dUj-44lt
	for linux-nvme@lists.infradead.org;
	Sat, 02 Mar 2024 23:21:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id CAF2BCE0E4D;
	Sat,  2 Mar 2024 23:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608D8C433C7;
	Sat,  2 Mar 2024 23:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709421683;
	bh=5S6aPJcuADaPieaJpVdRKfONG5QbuyZIOnf8f0bJyhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CBR19Gk9EXhxiiYnXyRdIoNkqkyiDd4T6oB/K/TgWRWFX+hfcx+ceOu4jB+6u/Xxt
	 j0f3nTnlaAOQnrSQNqfSN3ugCMi87dsndNtcd6bIKcsEnZ4JU6ljD9eukMpkRzTVXf
	 HKovenoQRQWpc1EraX+Q6bc0dIN1/5DCiFPEt/AnB1+8l+lya1GIZmJ05zh8yD8YI6
	 w9Njy557TGywMIw9oHqH+08Paow5wpwtI0iHK7SfaS66FHFmu/KI0G/urC82yXRVQN
	 ePK8MsJ6bjnKxXNdwi3ikQu9gRKr+HU24qefXbIj5+XvSDNjWrcz87I09vx1/Rh9h1
	 N+C6ia79CeRpw==
Date: Sat, 2 Mar 2024 16:21:20 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: Re: convert nvme to atomic queue limits updates
Message-ID: <ZeO0cFhlk89qEzXq@kbusch-mbp.mynextlight.net>
References: <20240228181215.873854-1-hch@lst.de>
 <ZeIAT5uY36cLkVpJ@kbusch-mbp.mynextlight.net>
 <20240302135954.GA1072@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240302135954.GA1072@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240302_152127_216880_FDF280C9 
X-CRM114-Status: GOOD (  12.77  )
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

On Sat, Mar 02, 2024 at 02:59:54PM +0100, Christoph Hellwig wrote:
> On Fri, Mar 01, 2024 at 09:20:31AM -0700, Keith Busch wrote:
> > 
> > The whole series looks good. I see Jens has got the first two patches,
> > so I'll rebase nvme-6.9 to that and apply the rest of the nvme patches.
> 
> I had to fix up the little thing Max noticed an also added another
> patch for multuipath.  I'll resend with those updates once you
> rebased.

Done, nvme-6.9 is rebased to the current for-6.9/block.

