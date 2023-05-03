Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D06DC77B7F
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 16:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kjYfa7nPE5izLp7hgJ7YJ7ScK5f2ocld8Pe+x1/yV2k=; b=n1FTSYgyFq+nGc2mtBle6xt6P5
	MqEvHQJlc/n/15tsOJeJFUweyVtCHx8gulvXsKFzpPC8BUMWbOZWMBqFjXW46O60t2ZexUW1mJy/N
	+mBpFzqPlIZWNmQiYk/W54zXJNQzKAnxLU/j1i5yEXJCIQkAuR+pgkiZWDAEUBzUTxIrg4l6ByAG0
	z/ImCbVBqMRnshHfAEbByJt0y6znC4t5RClNSJAK0unhSMS7+ne5BdRxZcBHDkTvDbVZZrYC6GwKf
	HN2TEnetzY0QPPYvmE9lUa58cGlv3/lByA/2vIVApnCGnlZLF3sI6jM0cYHRUFQpJAeAU8HqKaKRx
	W4cu3MvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puFLf-0055nZ-1y;
	Wed, 03 May 2023 16:28:59 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puFLc-0055mA-2I
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 16:28:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 523786100B;
	Wed,  3 May 2023 16:28:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31775C433EF;
	Wed,  3 May 2023 16:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683131335;
	bh=kjYfa7nPE5izLp7hgJ7YJ7ScK5f2ocld8Pe+x1/yV2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KD/xvm2IaJfUw+q733dqRKA6l0lUNP2e548p36UPmy9cbsd0Kq/M0O6eXysWnFp4z
	 WEVCli67veYPvPscSEb9t4qubPPo1BBzwv7DQ4IvkDV9VNsu+Mqw32vZbIKRyZXQW9
	 dqvPb5oixYCRFmXnjmMNC5E2wpNjUBU5t6he3ZXH64yGz6NSKIYs3DiojGINjkYm+V
	 h9ZqLxPAGcQAwIlO5yYIGRmx0m6F7upnhFKsBEBlXWPaT/lPxhR7i3JPTNwHBfoigI
	 HgVjVDFHCNpQbnsE1NvaqiNWpFQsJxBVl9r3pZSBn5runtEUS3JuMB5oUS0GrmkvDu
	 APmpR1sNVOxEg==
Date: Wed, 3 May 2023 10:28:53 -0600
From: Keith Busch <kbusch@kernel.org>
To: jiweisun126@126.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	axboe@fb.com, hch@lst.de, sagi@grimberg.me, ahuang12@lenovo.com,
	sunjw10@lenovo.com
Subject: Re: [PATCH] nvme: add cond_resched() to nvme_complete_batch()
Message-ID: <ZFKLxfet7qUIwScd@kbusch-mbp.dhcp.thefacebook.com>
References: <20230502125412.65633-1-jiweisun126@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502125412.65633-1-jiweisun126@126.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_092856_789787_31C80B71 
X-CRM114-Status: GOOD (  10.51  )
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
> According to the above two logs, we can know the nvme_irq() cost too much
> time, in the above case, about 4.8 second. And we can also know that the
> main bottlenecks is in the competition for the spin lock pool->lock.

I have a fix that makes pool->lock critical section much shorter and constant
time. It was staged in mm tree for months, but mysteriously it's missing...

