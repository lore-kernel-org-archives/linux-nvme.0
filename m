Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D2CCA5FC8
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2026 08:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=; b=UD7zF7mTuYK7zj29HWFwfOlgoP
	0SzFZeJL/WudcDuW/NKE4bmr7oHxX6vMBBGRWcCTEJ5Hyf+s/Tv94LfGAZYG3No8THlXzsczislBj
	QCKAykLUQkf9ePcxri3NXSdir28HWe2h8C/hE92QxJL6ibpHwc7aTUGrwotCWMEcVhQk1h21FG+Tx
	kJDH5ZAq8zaPY4zWbrno5Dq10jzdb7Z6kubmDyDWqPdS9XvzNUvsE0mqc6kB/QFQPsnnQgWiP+9yH
	zkYgTtnbEm949EYCpUMBGVa59uB3J3sO43Pf/eHvuudBX028nbD+yC0shllxnp469BtWXk82YWhh8
	ozgCcfxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBT7i-00000002jZu-13il;
	Tue, 29 Sep 2026 08:23:38 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBSCb-00000002bmQ-36uj
	for linux-nvme@lists.infradead.org;
	Tue, 29 Sep 2026 07:24:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6517340DB0;
	Tue, 29 Sep 2026 07:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4B81F000FF;
	Tue, 29 Sep 2026 07:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790666677;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ORul1xW9USuUDjtn8B3qbLkIBR+R47hz9P3yPidY48GRn803DHgTJ+QMx5QbqfvMS
	 ZYRm+jFx1sKfk9eUgOCp5fb9VuTXS4XqZi8sPkYqJxCpS5SkOeZ5f2qFLQqBx4sN3B
	 oRAFJtLePKANnTIeCHoxZwBSXft1IeiEXSVzkRD7d3BPBor1fzAHVtHLzSkm5vRjnm
	 VMPrNw4tqqrGzyIEOusNLpLKgow3oQT/b93KXU/VIJoktSazn5DT59Z62TGK6yExnY
	 QrqGOSJXWZrQ36A3gBo717mNumXNDXMW+W3CVQ05eprC9gBvu1K79T8PUxGt5iQPY3
	 9+sOg/V7h7q8A==
From: netdev-bot+sinfo@kernel.org
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 edumazet@google.com, netdev@vger.kernel.org,
 Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>,
 gfs2@lists.linux.dev, John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, Matthieu Baerts <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 mptcp@lists.linux.dev, Wen Gu <guwen@linux.alibaba.com>,
 Dust Li <dust.li@linux.alibaba.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
 Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org, Allison Henderson <achender@kernel.org>,
 rds-devel@oss.oracle.com, Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 Christoph =?utf-8?q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linux.dev,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, Ilya Dryomov <idryomov@gmail.com>,
 Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>,
 ceph-devel@vger.kernel.org
Subject: Re: [PATCH v3 net-next 0/9] tcp: avoid struct socket cache line miss
 in tcp_check_space()
Date: Tue, 29 Sep 2026 07:24:34 +0000
Message-ID: <179066667444.31693.3326934466907750947@kernel.org>
In-Reply-To: <20260929071743.23624-1-edumazet@kernel.org>
References: <20260929071743.23624-1-edumazet@kernel.org>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 29 Sep 2026 01:23:30 -0700
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

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.

