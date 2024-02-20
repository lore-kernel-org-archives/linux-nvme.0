Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5376FC48BF8
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Feb 2024 01:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iCmBf4dmplbsn+zPr/zttUGkD4SGaLhapeNh3147XPc=; b=0PPnYyXZztX60BP1jrR0C029pL
	DwFI9uCiQ6vjLLnhrC0AOfw5XE3Kt+tfqpkWzMMYSYx5w9rZi5kRCCmNp3NNMTsCA1WGrl7K3GsaU
	sstblLl+6EEk3Ohf4xphs7URrEoBMWne920kMbAqABCXvdGAeTBs4HJR7EhEV8dgBnInEgzGYsz+3
	GRXF/21pmPiAq5t0Qw5SYYuwFsF2eqA7bWBgZbqO2LMuaRP7wtCwQE/Rm1HxaXFyMkcl0LcM8paps
	Zloxu3Q7pdnSSjdLmnioDOgYc+74LF0SKASGuFsuCD6Pow052rQXbetxn+AfaN+AQuA8YSxQAVTl3
	cNpLdbKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcEw8-0000000ClJI-1svB;
	Tue, 20 Feb 2024 01:28:44 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcEw5-0000000ClIg-23tP
	for linux-nvme@lists.infradead.org;
	Tue, 20 Feb 2024 01:28:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6A17960FF5;
	Tue, 20 Feb 2024 01:28:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D881C433C7;
	Tue, 20 Feb 2024 01:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708392519;
	bh=U/OzMP41UIGNGjFQJcOxOiN+HvJ7Vk2QT4oFCERWQS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SmXKvVZTg6JWE9s4m6+eBQVl2PQv1p1z32TS85zBFdDIr17rrMaGcPUD7Say8jznH
	 5gAj+VRoNXeeaBTGNhizHmC7a9LRdIe78dRAxV+vwXd7Z7wNZblnV06isLfXAJ216o
	 iSBYFwtxftX90pOA0abvcYIk+Kqwb7UAxxCbRg6GrfpTntjzOaTs2OdXc69jSIPGv2
	 Ns3NLtVLxMhpuasbijAUCSj8NfLR6Sj6r+wLMjF2WybGrlgjc35jZ+suL7+38j9Fl4
	 Yds3bLW6mgfcAo4zmZ420doehQ0CeiJeAKHKUAJuUKAqz819iM9XNdfIxesve4/yjH
	 Ec30eswj9H4Vg==
Date: Mon, 19 Feb 2024 18:28:37 -0700
From: Keith Busch <kbusch@kernel.org>
To: Wen Xiong <wenxiong@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@infradead.org>,
	Wenxiong <wenxiong@us.ibm.com>
Subject: Re: re attach-ns causing IO errors
Message-ID: <ZdQARSrV-HXWf6rc@kbusch-mbp>
References: <75700e85137a40305238c74cf03bb677@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75700e85137a40305238c74cf03bb677@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240219_172841_588549_FD1FACFA 
X-CRM114-Status: GOOD (  14.64  )
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

On Mon, Feb 19, 2024 at 04:49:06PM -0600, Wen Xiong wrote:
> Hi All,
> 
> We discussed this at the beginning of November last year.
> Test team with extra ns-rescan, get new namespace back last year.
> But they still ask if there is way not doing extra ns-rescan.
> 
> Consider this scenario with nguid changes:
> 
> # nvme list-subsys
> nvme-subsys0 -
> NQN=nqn.1994-11.com.samsung:nvme:PM1743:2.5-inch:S7DDNG0X100093
> \
> +- nvme0 pcie 052a:58:00.0 live
> +- nvme1 pcie 058a:58:00.0 live
> 
> After system boots up:
> Nvme-subsys0  -> ns_head(NSID1/NGUID1)
> /dev/nvme0n1 -> ns_head(NSID1/NGUID1) ->ns(NSID1/NGUID1)
> /dev/nvme1     -> ns_head(NSID1/NGUID1) ->ns(NSID1/NGUID1)
> 
> After delete-ns /dev/nvme0 -n 1 -c 0x82:
> Nvme-subsy0 -> no more ns_head(EMPTY)
> /dev/nvme0  -> no ns(EMPTY)
> /dev/nvme1 -> no ns(EMPTY)
> 
> create-ns /dev/nvme0 -s 0x5000000 -c 0x5000000 -f 0 -d 0  -m 1:
> 
> After attach-ns /dev/nvme0 -n 1 -c 0x82: I saw calling nvme_scan_ns_list()
> twice.
> 
> 1st scan: nvme_queue_scan() -> nvme_scan_ns_list(), we got:
> Nvme-subsy0 -> ns_head(NSID1/NGUID1)   -------> Note: this is old NGUID1
> /dev/nvme0 -> ns_head(NSID1/NGUID1) ->ns(NSID1/NGUID1)  ----> Note: this is
> old NGUID1
> 
> 2nd scan: scan_work()  -> nvme_scan_ns_list, we got:
> Nvme-subsys0 ->ns_head(NSID1/NGUID1) ----> created this ns_head in 1st scan.
> /dev/nvme0n1  -> ns_head(NSID1/NGUID1) -> ns(NSID1/NGUID2)
> Then saw: nvme nvme0: identifiers changed for nsid 1  ---> because of NGUID
> changed to NGUID2
>                    block nvme0n1: no available path - failing I/O
>                    block nvme0n1: no available path - failing I/O
> 
> My question is:
> - Looks only scan once during system boot up.
> - Why scan twice when did delete-ns/create-ns/attach operation? 1st scan:
> Nvme_queue_scan is called from user space or udev?
> - 1st scan, NGUID1 is old one, 2nd scan, NGUID2 is new one?

The driver will automatically rescan based on command effects. It's also
possible the device completes an AEN for the Namespace List change
event, which would trigger a 2nd namespace scan. We use effects in the
driver on admin passthrough commands because a user can always mask an
AEN to be off with a 'set-feature' command, so we can't rely on it.

