Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB318CDB47E
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Oct 2023 05:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OsNFdKFuVEdrubC43yAS5WZPWsUukUJDd+2CyJhD9b8=; b=K2h0TvMcK8YNRNJiP6zd2lGgAt
	swgZzsuWXfe8TrDDdIONYbxuyuZkLWlIqbuYUMXWBFJSZ9INh8MTU+znaWtFs9j++lFH66Q7jRy/z
	3mG4kdH9uh1kvoQrfvShmMafj3KZ3euG9WKxUrzcvtiGLq48dybnSu7BY0Rk5cbnt2TKHmI7kgI/G
	3HbiEohEuQktKZi4faDQDAwFRsYQdYO1c9pF3Djooi/FgnSRBxqvbfke4J4sQmkFyStSmHbudCQoQ
	LgGcpAQ1NrfH2H/nAN9x5jdbbxcwMMTBghP9quH3XioX1t5bgjHVDiCr6pSOFDHyJeMdTSWc7WJjt
	B4QfR5Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qszNM-00DqrS-1p;
	Wed, 18 Oct 2023 05:45:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qszNK-00Dqr2-1N
	for linux-nvme@lists.infradead.org;
	Wed, 18 Oct 2023 05:45:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C5ACA67373; Wed, 18 Oct 2023 07:45:39 +0200 (CEST)
Date: Wed, 18 Oct 2023 07:45:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: start keep-alive after admin queue setup
Message-ID: <20231018054538.GA17150@lst.de>
References: <20231017134535.137780-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017134535.137780-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231017_224546_624750_DEF7613D 
X-CRM114-Status: GOOD (  11.62  )
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

On Tue, Oct 17, 2023 at 03:45:35PM +0200, Hannes Reinecke wrote:
> Setting up I/O queues might take quite some time on larger and/or
> busy setups, so KATO might expire before all I/O queues could be
> set up.
> Fix this by starting keep-alive right after the admin queue is
> operational.

Having all these manual unpaired nvme_stop_keep_alive calls look
rather unmaintainable.  What keeps us from doing it in
nvme_uninit_ctrl?


