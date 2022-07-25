Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7E0C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jul 2022 05:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OKoPl6pkKwqfVXv0tkCsZkhTLVRcHEZ8byA5r6vMqzE=; b=qZvnu1WFQvpoIyt3n9qxkCD9El
	qDowgd1Vu20DnnUG1cdux7zcvF5J2ZFmfaZhOjGjb/cEMAaSfjsOv9v0WM0YKMiXEtSYSgTswj70k
	7IME8jmCwd7y32vwIedPzOagYm8+cUkTRDaUDNUcyRRnbYPo7njCK1C7Pbv+UuKFS5KXQ2oW69s4I
	+nzpl5MIRmCzF2eglcJ6q4n6l6P0LOL6g95fd7qtC6pJdVQtwDwlA6Vj/ILW3KYyN/kENmQomffFH
	Li1J5yB3ZrBVLf4DfFMvgY/V9Fat+n/vjmVBjfebpvsYhlJ0JqlncpYD+broKTXJbrOow8t8Y58Kr
	a/pN0h1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFqnh-004a7R-2F; Mon, 25 Jul 2022 05:38:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFqnd-004Zyx-RE
	for linux-nvme@lists.infradead.org; Mon, 25 Jul 2022 05:38:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D29D968AA6; Mon, 25 Jul 2022 07:38:23 +0200 (CEST)
Date: Mon, 25 Jul 2022 07:38:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] nvmet-tcp: fix lockdep complaint on nvmet_tcp_wq flush
 during queue teardown
Message-ID: <20220725053823.GA19426@lst.de>
References: <20220724085843.494463-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220724085843.494463-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220724_223838_069083_5995C2CD 
X-CRM114-Status: UNSURE (   9.41  )
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

Thanks,

applied to nvme-5.20.

