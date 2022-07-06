Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4028CCA47F
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jul 2022 17:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5Xz4cgyr907laE8FVhXtKTrrGymLfm+M6u2vDoD+N0M=; b=aAMQt/2IlSMQ86x4uk2u7QeFXP
	2OZfRVWTA4nLSkaRmqQC1zq3LPK75veTGhvGXgdwen3jUl0oshAQNf1SwzJdm3IOf/6F/P2+y8HFs
	D98G5TGAIl7CWBq+QaO9un+1Is9tGKfcFILM7fls/rZJM/GXfDYVfJEn89oNMr08I2Jm4ES84+FtK
	0l9t0SY0IdG4aHggHght4IBNyMO2NPeGS8qqTzCdG4Nm8LDQZxEXyIXel/o5jxPAgUWLQSEHHW8Ip
	nZMFoxXWpV3gkULpVa7J0cYmUgYE9cWF5+n5WFH3qxBXqR9vPoA5BVGGhBQ7waEAqONz3bgBh67UH
	p2WBGilA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o998S-00BoMJ-Bb; Wed, 06 Jul 2022 17:48:24 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o992i-00BlfF-GI
	for linux-nvme@bombadil.infradead.org; Wed, 06 Jul 2022 17:42:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5Xz4cgyr907laE8FVhXtKTrrGymLfm+M6u2vDoD+N0M=; b=GvPwHahMBbuNaNdNezm22avvV9
	vEac+n/N1Md008SH2L9+RDomZy7o87JiMqMajIYvZXSQyUWO2GenBJAXWxZQyy4d8LU0kQ+wuiB4k
	NxtxcPAT8s2zJx1qInWe7P31NX/HMJOck6wbES12nfC+bEDbeTCgdXS8Ew77H04ohvWLCy5kLxDkR
	V8eZ2n6shRdVtN++uP0oM6PTMFz8/tiCXLPt2D6q735qAFICn1hUOb2hLczXweoLsSsDN55y5VwDI
	fETBNiD7Fh1XFY5nzF9NnBzGZK+Dt8XwewYnqS7DzAJC3mrAbIABzZvzPdzeT5X83wyn7tXopbVkk
	pqvxP0ng==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o992T-001q54-UO; Wed, 06 Jul 2022 17:42:13 +0000
Date: Wed, 6 Jul 2022 18:42:13 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	axboe@kernel.dk, agk@redhat.com, song@kernel.org, djwong@kernel.org,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, viro@zeniv.linux.org.uk,
	javier@javigon.com, johannes.thumshirn@wdc.com, bvanassche@acm.org,
	dongli.zhang@oracle.com, ming.lei@redhat.com,
	jefflexu@linux.alibaba.com, josef@toxicpanda.com, clm@fb.com,
	dsterba@suse.com, jack@suse.com, tytso@mit.edu,
	adilger.kernel@dilger.ca, jlayton@kernel.org, idryomov@gmail.com,
	danil.kipnis@cloud.ionos.com, ebiggers@google.com,
	jinpu.wang@cloud.ionos.com
Subject: Re: [PATCH 0/6] block: add support for REQ_OP_VERIFY
Message-ID: <YsXJdXnXsMtaC8DJ@casper.infradead.org>
References: <20220630091406.19624-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630091406.19624-1-kch@nvidia.com>
X-Mailman-Approved-At: Wed, 06 Jul 2022 10:48:15 -0700
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

On Thu, Jun 30, 2022 at 02:14:00AM -0700, Chaitanya Kulkarni wrote:
> This adds support for the REQ_OP_VERIFY. In this version we add

IMO, VERIFY is a useless command.  The history of storage is full of
devices which simply lie.  Since there's no way for the host to check if
the device did any work, cheap devices may simply implement it as a NOOP.
Even expensive devices where there's an ironclad legal contract between
the vendor and customer may have bugs that result in only some of the
bytes being VERIFYed.  We shouldn't support it.

Now, everything you say about its value (not consuming bus bandwidth)
is true, but the device should provide the host with proof-of-work.
I'd suggest calculating some kind of checksum, even something like a
SHA-1 of the contents would be worth having.  It doesn't need to be
crypto-secure; just something the host can verify the device didn't spoof.

