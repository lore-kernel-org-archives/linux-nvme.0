Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148A1C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 05:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+HI8ygopNqUvRXTrKOyBgpqzuq5CQ/JAfCRQfZ8LgZU=; b=yINhyGzyzuGdIgu59f0O/C5n8g
	IqKyPLIpC0jFqzw0U4Ol8nqGpQ4V5IVASXRrP6L3O/JJYVitfwrqE0tkWTM8udNmqNblvLcwC4Y4X
	9BojYoPftu0m2IWQtq+Kz8kqhAyUUZbPpNLjdkNPfbHPevxOen5dwan29dj6HDV9CxvR9qBwwoiXf
	cvy3CyLtwxae378w3xbGvY4ByIvR7cX+o7M1qcHIcoWVtRzGxvtRRV7r8FqBKYKqHb/7WvVG26bTO
	ivnQUCSWgYDkpyyB1ssCxZ667bKXzaSW6IKZEFaSEQCeH/svPH/1cTelBP9xp07H0UH/IBFnCjrJv
	IZMZfwgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okf1O-002jSZ-4U; Tue, 18 Oct 2022 05:20:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okf1K-002jRZ-7e
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 05:20:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0F39B68C4E; Tue, 18 Oct 2022 07:19:56 +0200 (CEST)
Date: Tue, 18 Oct 2022 07:19:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	sagi@grimberg.me, kbusch@kernel.org, ming.lei@redhat.com,
	axboe@kernel.dk
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20221018051956.GA18802@lst.de>
References: <20221013094450.5947-1-lengchao@huawei.com> <20221013094450.5947-2-lengchao@huawei.com> <20221017133906.GA24492@lst.de> <20221017152136.GI5600@paulmck-ThinkPad-P17-Gen-1> <20221017153105.GA32509@lst.de> <20221017224115.GJ5600@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017224115.GJ5600@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221017_222006_441928_86E7776B 
X-CRM114-Status: GOOD (  18.71  )
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

On Mon, Oct 17, 2022 at 03:41:15PM -0700, Paul E. McKenney wrote:
> Then the big question is "how long do the SRCU readers run?"
> 
> If all of the readers ran for exactly the same duration, there would be
> little point in having more than one srcu_struct.

The SRCU readers are the I/O dispatch, which will have quite similar
runtimes for the different queues.

> If the kernel knew up front how long the SRCU readers for a given entry
> would run, it could provide an srcu_struct structure for each duration.
> For a (fanciful) example, you could have one srcu_struct structure for
> SSDs, another for rotating rust, a third for LAN-attached storage, and
> a fourth for WAN-attached storage.  Maybe a fifth for lunar-based storage.

All the different request_queues in a tag_set are for the same device.
There might be some corner cases like storare arrays where they have
different latencies.  But we're not even waiting for the I/O completion
here, this just protects the submission.

> Does that help, or am I off in the weeds here?

I think this was very helpful, and at least to be moving the srcu_struct
to the tag_set sounds like a good idea to explore.

Ming, anything I might have missed?

