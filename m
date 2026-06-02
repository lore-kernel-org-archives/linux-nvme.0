Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5924BCD6E5D
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2026 10:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gEhuE0+RawTemtpfpMJMOv3Anq58JlbIeV2o57rHiQE=; b=HkwYJWgNXcZj9IydXgd+V4egmh
	Zknt6fWXZk+4JGKo2c10+aoxolhQn0ZIxQ47d6ibHJpjg0IWGjXAk1U39iVyxg5B6LkB3xoK57gy2
	Qka5oTBs2vlrP8/HMq2Axr0C4x4zhPq/k4ROmyqjvpeIRfL4yQy3kvRZpCg1tKaOamF17+mrT2KH1
	G4TB0KCftbv8oM8sHoYlxHoNXq/a8hBrO41uSs1biPWuO3r/+SkT7xp64Z9Z8pQL2QCDMRn1O6YEI
	GiOIyx+iz8S8gelVhDm+1eNZPUr9PfDEOflA66cZr9Z0w2PeyNzP2c4Dh6nEm+e01pwG6VoIULf4k
	EJARl6cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUMe1-0000000CnhT-41Bm;
	Tue, 02 Jun 2026 10:46:49 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUMdy-0000000Cnh3-2jtE
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jun 2026 10:46:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 05AC44397C;
	Tue,  2 Jun 2026 10:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD6B1F00893;
	Tue,  2 Jun 2026 10:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780397205;
	bh=gEhuE0+RawTemtpfpMJMOv3Anq58JlbIeV2o57rHiQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OAiUmdduDnr1CbWkr0ZBWJM4bTYEIka59xzSzkjAsVx9yxk1/L22HT22xAhYptGcF
	 WzX1hD/MQNYsPuw0oYfbO2Pbe+aE1xI1tQtLbuXwSOnrF6B7LNf7atxOK8zDSNzRAY
	 U+Do5G+zNpz/7jiryLZX0QFXO/c8QPcANLmzXUDh/EhksdlUod5AbwB7OGiMp7Ephl
	 ALqWy8sGiaDxkCxiH0J0XyDXYlCEgyhBTGz33LIWSL8CIozvXlMYgqO0XoNEHdEpVd
	 9LhV0Da2J/qQ7j7oZEnRNCkDwrBG+EJFPeWcCHalx43rQ8V/vUAhwStqI2QGQgbIpb
	 eqN0Ba4Zf9Mtw==
Date: Tue, 2 Jun 2026 11:46:39 +0100
From: Keith Busch <kbusch@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Tejun Heo <tj@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	linux-nvme@lists.infradead.org,
	syzbot+d078cba4418e65f61984@syzkaller.appspotmail.com
Subject: Re: [PATCH] nvme-tcp: Use WQ_PERCPU explicitly if wq_unbound is
 false.
Message-ID: <ah60j15-zZcn_du0@kbusch-mbp>
References: <20260530081059.428303-1-kuniyu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530081059.428303-1-kuniyu@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_034646_733948_D4CDCE52 
X-CRM114-Status: UNSURE (   8.39  )
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

On Sat, May 30, 2026 at 08:10:57AM +0000, Kuniyuki Iwashima wrote:
> Since commit 21c05ca88a54 ("workqueue: Add warnings and ensure
> one among WQ_PERCPU or WQ_UNBOUND is present"), we must explicitly
> set WQ_PERCPU or WQ_UNBOUND when creating workqueue.

Thanks, applied to nvme-7.2.

