Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F724C25B4F
	for <linux-nvme@archiver.kernel.org>; Fri, 10 May 2024 09:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7KEHh32qBijNMwiNKkmLVLk33MaGaNI6oCDcJXjG8Wc=; b=p4dO3JbnK558Ozhgb9l630XxNt
	51UALcbS6G6/fQFaEaFxG7GmoPT8Lg5z5PAu3PhyOtQKqpMz1c0bwNi7l6WjnWgbAwujiuUMaCTxo
	vgHiRRhOqL8yR2h2x6O76zFki/vdc29hn34bOFiP3Opxy5ZN6bG2cIuglrZ16rqrVxXs7f0fJXKlw
	oMlGiYw9nv2ufFiLmvN5xjkfGg4RIERJLsRJjlCLQD1Ai2ezzEcKg1udLNK3kDJqx4vp2Xfb5m1OZ
	2efD6GhJ8kPHw50JRjPrWzPGQPGa7EjSX5IrAhPjloeR9iRBD4ZW1f5fCpY9Vhk7G+Gy/Y2ZfjhnD
	7LKIJUyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5MeH-00000004iJm-0At1;
	Fri, 10 May 2024 09:34:41 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5MeD-00000004iIq-3T4v
	for linux-nvme@lists.infradead.org;
	Fri, 10 May 2024 09:34:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 4B234CE1CF3;
	Fri, 10 May 2024 09:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3B8C113CC;
	Fri, 10 May 2024 09:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715333674;
	bh=fkKst5tRTPmG3SWpn0MZBr1yx/AoXoDQnBVjNHcEMhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g7UXPYPElwbH6RH2AbctTcL35+I6v0LHbxah7Qb0nxfHFh0PCe5zBFBuckuTCeszb
	 GQsalXVhtQ6PfUF8bCkmcVWGgg8P0d3gMCWGuPNWXGWx/wR5LN1QJKgmSVnaUnRgWS
	 yiuc0jxlH3sA6GPFbHlAaNYi9IJcU3chIloFPL027+FIEPajLPumlAntrtJC4DzkY5
	 thWGerpq92S8oGz5KVnXmyM0TFhzssV70mGZWDmyN30aywKkdc+fM9OMoTtO8aaThq
	 uohhmfzP+YNpMCnVDjpiZl7Zp9L+CfNA92DlxcWa9KLsbbWBvHQQD4XLKtAvg7wLAq
	 ab4exq9fijocA==
Date: Fri, 10 May 2024 11:34:28 +0200
From: Niklas Cassel <cassel@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, kbusch@kernel.org,
	hch@lst.de, sagi@grimberg.me, emilne@redhat.com, hare@kernel.org,
	linux-block@vger.kernel.org, cgroups@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	jrani@purestorage.com, randyj@purestorage.com, aviv.coro@ibm.com
Subject: Re: [PATCH v3 0/3] block,nvme: latency-based I/O scheduler
Message-ID: <Zj3qJP_J-D3DEP6W@ryzen.lan>
References: <20240403141756.88233-1-hare@kernel.org>
 <20240509204324.832846-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509204324.832846-1-jmeneghi@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240510_023438_250678_FBC40035 
X-CRM114-Status: GOOD (  27.20  )
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

On Thu, May 09, 2024 at 04:43:21PM -0400, John Meneghini wrote:
> I'm re-issuing Hannes's latency patches in preparation for LSFMM

Hello John,

Just a small note.

Please don't reply-to the previous version of the series (v2), when sending
out a v3.

It creates "an unmanageable forest of references in email clients".

See:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#explicit-in-reply-to-headers

Instead just add the url to the v2 on lore.kernel.org.

See you at LSFMM!


Kind regards,
Niklas

> 
> Changes since V2:
> 
> I've done quite a bit of work cleaning up these patches. There were a
> number of checkpatch.pl problems as well as some compile time errors
> when config BLK_NODE_LATENCY was turned off. After the clean up I
> rebased these patches onto Ewan's "nvme: queue-depth multipath iopolicy"
> patches. This allowed me to test both iopolicy changes together. 
> 
> All of my test results, together with the scripts I used to generate these
> graphs, are available at:
> 
>   https://github.com/johnmeneghini/iopolicy
> 
> Please use the scripts in this repository to do your own testing.
> 
> Changes since V1:
> 
> Hi all,
> 
> there had been several attempts to implement a latency-based I/O
> scheduler for native nvme multipath, all of which had its issues.
> 
> So time to start afresh, this time using the QoS framework
> already present in the block layer.
> It consists of two parts:
> - a new 'blk-nlatency' QoS module, which is just a simple per-node
>   latency tracker
> - a 'latency' nvme I/O policy
> 
> Using the 'tiobench' fio script with 512 byte blocksize I'm getting
> the following latencies (in usecs) as a baseline:
> - seq write: avg 186 stddev 331
> - rand write: avg 4598 stddev 7903
> - seq read: avg 149 stddev 65
> - rand read: avg 150 stddev 68
> 
> Enabling the 'latency' iopolicy:
> - seq write: avg 178 stddev 113
> - rand write: avg 3427 stddev 6703
> - seq read: avg 140 stddev 59
> - rand read: avg 141 stddev 58
> 
> Setting the 'decay' parameter to 10:
> - seq write: avg 182 stddev 65
> - rand write: avg 2619 stddev 5894
> - seq read: avg 142 stddev 57
> - rand read: avg 140 stddev 57  
> 
> That's on a 32G FC testbed running against a brd target,
> fio running with 48 threads. So promises are met: latency
> goes down, and we're even able to control the standard
> deviation via the 'decay' parameter.
> 
> As usual, comments and reviews are welcome.
> 
> Changes to the original version:
> - split the rqos debugfs entries
> - Modify commit message to indicate latency
> - rename to blk-nlatency
> 
> Hannes Reinecke (2):
>   block: track per-node I/O latency
>   nvme: add 'latency' iopolicy
> 
> John Meneghini (1):
>   nvme: multipath: pr_notice when iopolicy changes
> 
>  MAINTAINERS                   |   1 +
>  block/Kconfig                 |   9 +
>  block/Makefile                |   1 +
>  block/blk-mq-debugfs.c        |   2 +
>  block/blk-nlatency.c          | 389 ++++++++++++++++++++++++++++++++++
>  block/blk-rq-qos.h            |   6 +
>  drivers/nvme/host/multipath.c |  73 ++++++-
>  drivers/nvme/host/nvme.h      |   1 +
>  include/linux/blk-mq.h        |  11 +
>  9 files changed, 484 insertions(+), 9 deletions(-)
>  create mode 100644 block/blk-nlatency.c
> 
> -- 
> 2.39.3
> 
> 

