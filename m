Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90718109C038
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2026 07:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7N9TgMHFraFeVXNYuCdXIWNYZyWpOEPnK8jVkVQJ6hE=; b=0SX+/rW8CveiFD9sao7s3iU/Qg
	3I+WztCpcXMaf29u5/9QQAvFQhtBkwpm19uuRkQMKJQqatg55CiQpUJHwmSr1/SCt3AHgd3Wf3/0/
	Vp0W84XFgIYCGD0NbXIJI2YiJ3sr60TRClW6rDH892Au9NyxucGwPHe8NXx1K3b8pMMcC/8uqhsJ9
	+7t/YPc10hYzHRoXxYk0eaCDfcH4Y1Eolem7SDTEbvDTsVeO/dqAwP0h7GBG5V0/tz3sGWDjDCPWm
	OEfIXmGMr3xUdK4LWshLhDovkjNw3VjbLHa7GCFIjpqk9s5z9iC0ywA+xskP6lbLcgui0C/LBph3w
	Ks6ThMBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5fMO-00000004x5I-34OJ;
	Thu, 26 Mar 2026 07:42:32 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5fML-00000004x4w-3lRm
	for linux-nvme@lists.infradead.org;
	Thu, 26 Mar 2026 07:42:31 +0000
Date: Thu, 26 Mar 2026 08:42:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1774510946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7N9TgMHFraFeVXNYuCdXIWNYZyWpOEPnK8jVkVQJ6hE=;
	b=eECZh1XmFpbS/h9sFHnwIGna1GvmUDCfAQos+dQQy7vFseAryD3PG2r+4/8b/emKKRMzwS
	8LGqJ4r4v6+y8ZKKanGxCPKCIBssfvTma4uzQw4ZshiS7FHtoMK6wQPHxIlX9XVIJNnBYP
	bXwQq+8vaWWg+WwvJOG0qRrChj5DSbHX8gr5GLfupappv2IMcd1ZpHdjhhWZoSCHhjpDfv
	zrUzLji2YpahDUDw1RkApR4NE8YjXy5z1qu92ZIvt9Yy04sdkvSqNz0jjcYTKI0Z6ERIGx
	52MNEAYHp5O2fczO/e/Kl+BKhD8eLOJdfm2pZDexQ3S0safZtZFfABr4/3TeqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1774510946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7N9TgMHFraFeVXNYuCdXIWNYZyWpOEPnK8jVkVQJ6hE=;
	b=iO5XW1w6drYoyeU0YbS1Z+G+BkXpW8c24lsR431Gzrtv2oMWBBW5UxNVZLKJXv9QwZwxdz
	ym3bWlXVBEdmDXBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <llong@redhat.com>, Ming Lei <ming.lei@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org, storagedev@microchip.com,
	virtualization@lists.linux.dev,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v8 00/12] blk: honor isolcpus configuration
Message-ID: <20260326074224.eEozcjTE@linutronix.de>
References: <20250905-isolcpus-io-queues-v8-0-885984c5daca@kernel.org>
 <20260325175610.eY-VHHPS@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260325175610.eY-VHHPS@linutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260326_004230_082084_AE4C7B43 
X-CRM114-Status: UNSURE (   8.58  )
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

On 2026-03-25 18:56:13 [+0100], To Daniel Wagner wrote:
> I have been just made aware of this. It is still not merged so let me
> ask the questions before it is too late.
> What is purpose of managed_irq? Doesn't this sort of aligns with this?

No, it does not. I got the answers. Let me write that down. Move on then=E2=
=80=A6

Sebastian

