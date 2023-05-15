Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4C7C7EE24
	for <linux-nvme@archiver.kernel.org>; Mon, 15 May 2023 20:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JDEkOzXkmO4vq/f1uciCLb7+xip3bOlFTtfAfYOBCRE=; b=FexLhXT7LISHlqkCLqz30Loy1V
	hpoquSyyKYVwIkeJUWE7QdvSWo5PQf5awF15gABDtx0LNWWn5eGrnatfAZLIuRQbNnTQG/sDbSTbm
	+9k4lW7duA/TJ7nzmdjgAUQnrOmn1DAdIOnCSfvE5Bk81yeHi7xtbX5ChMXJXZ/ICqyALSAQv7GVc
	4f/whdPqjEDl0QnkudGk7phGPrYl5r1ydoaSMGDyxD1b1XKenjCET5QEbivCIyMYe2HWZOmuZN6vp
	0o0YdckyEcgkYoBUPse9vq+zn4D7NGc3cVPZJsAcT3iAZAOPXOkeX6xpSFfekvcOXKm1yiWSnde8L
	I5WSJvcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyf07-003SFL-2j;
	Mon, 15 May 2023 20:40:59 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyf04-003SEk-2c
	for linux-nvme@lists.infradead.org;
	Mon, 15 May 2023 20:40:58 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id F3BE060BB1;
	Mon, 15 May 2023 20:40:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D815AC433D2;
	Mon, 15 May 2023 20:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684183255;
	bh=Ycz5x4xauJooEI45uTwxsWwrEMcDCoaMGoPeFzflJMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hBJ5GpTz5XrO2mUy/fQYFQ0hyJ+XYysi2gQscEI7GUVjouJ47/DIBlzXpp1lzgG7V
	 kTfQvrpBvA141MPGgm85yIQC5z+sZTqS1cwPanWA7oqDoiZUTlJRfHy140WZ1m9Bp7
	 mKTBgYLNqL/DHMbM2714lhYV9RuP6SNC7efBpyAJl2pChTSX30KLHkOr8k7B4XXqQH
	 bnoIE1c9JPp7V+RPG1yHOe94aSbAam3bFAQYq4WpCtiR7NKijOvnBE6WQHVQM9hWjC
	 +VxDlZAQV6H0oGx4BZnfNZmzEcnt2u4CvJkD7JEmIhL7DOpTJSjyZogvhyFFyAn/kZ
	 HBx5z+AllSHkQ==
Date: Mon, 15 May 2023 14:40:52 -0600
From: Keith Busch <kbusch@kernel.org>
To: jiweisun126@126.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	axboe@fb.com, hch@lst.de, sagi@grimberg.me, ahuang12@lenovo.com,
	sunjw10@lenovo.com
Subject: Re: [PATCH] nvme: add cond_resched() to nvme_complete_batch()
Message-ID: <ZGKY1A1q5Px64v9h@kbusch-mbp>
References: <20230502125412.65633-1-jiweisun126@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502125412.65633-1-jiweisun126@126.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230515_134056_917217_51D2FD1C 
X-CRM114-Status: GOOD (  13.00  )
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

On Tue, May 02, 2023 at 08:54:12PM +0800, jiweisun126@126.com wrote:
> From: Jiwei Sun <sunjw10@lenovo.com>
> 
> A soft lockup issue will be triggered when do fio test on a 448-core
> server, such as the following warning:

...

> According to the above two logs, we can know the nvme_irq() cost too much
> time, in the above case, about 4.8 second. And we can also know that the
> main bottlenecks is in the competition for the spin lock pool->lock.

The most recent 6.4-rc has included a significant changeset to the pool
allocator that may show a considerable difference in pool->lock timing.
It would be interesting to hear if it changes your observation with your
448-core setup. Would you be able to re-run your experiements that
produced the soft lockup with this kernel on that machine?

