Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC38FE77188
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 07:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JrYxbYSuhWPmWtfO+OtFAYtumYZrpI/Z+uaU0zNmXPA=; b=J3GdSm3iBeMAlR7LObefUgsD2p
	dEFcAWLWl/nWcYMrEV06aXnT1G3vLEYKA4DE1+9Y4E4+qO2UZ024cEQSb9Tg+fACrSx7gs9rKq25c
	2naOl4MHEikae8UsoEyNsc/G0xfobgtTkM5un+TENrD0p0jvT9gDR5gxdc9PKxsqadzEjq16LzZHJ
	KFgFR46hWAzt7Ea9RUMjFbSyFlQzwaHQgg473HeQ+x2css74k+8qkLMQDTCEAlikKfPkYbPC1NlSC
	MeMcjN24J72T2lMZ+07mGyLjsvAeCIk0lYlYRS9/KDmi01xbwJODKju8InXoG1d6vPBAP08lkGWar
	NKZBytuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUhgR-00000000QFO-0diD;
	Mon, 06 Jan 2025 07:37:55 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tUhg0-00000000QBN-47yr;
	Mon, 06 Jan 2025 07:37:29 +0000
Date: Sun, 5 Jan 2025 23:37:28 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Vishnu ks <ksvishnu56@gmail.com>
Cc: Song Liu <song@kernel.org>, hch@infradead.org, yanjun.zhu@linux.dev,
	lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
	bpf@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [LSF/MM/BPF TOPIC] Improving Block Layer Tracepoints for
 Next-Generation Backup Systems
Message-ID: <Z3uIOPxr4s09qS1X@infradead.org>
References: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
 <CAPhsuW7+ORExwn5fkRykEmEp-wm0YE788Tkd39rK5cZ-Q3dfUw@mail.gmail.com>
 <CAJHDoJYESDzDf9KJgfSfGGit6JPyxtf3miNbnM7BzNfjOi7CQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJHDoJYESDzDf9KJgfSfGGit6JPyxtf3miNbnM7BzNfjOi7CQw@mail.gmail.com>
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

On Sat, Jan 04, 2025 at 11:22:40PM +0530, Vishnu ks wrote:
> 1. Uses eBPF to monitor block_rq_complete tracepoint to track modified sectors

You can't.  Drivers can and often do change the sector during submission
processing.

> 2. Captures sector numbers (not data) of changed blocks in real-time
> 3. Periodically syncs the actual data from these sectors based on
> configurable RPO
> 4. Layers these incremental changes on top of base snapshots

And all of that is broken.  If you are interested in this kind of
mechanism help upstreaming the blk-filter work, which has been
explicitly designed to support that.

Before that you should really undestand how block devices and
file systems work, as the rest of the mail suggested a very dangerous
misunderstanding of the basic principles.

