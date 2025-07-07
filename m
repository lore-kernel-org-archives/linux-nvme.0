Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67292C83F0C
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jul 2025 14:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Re0jbfXwpnTylRrhKHkvnFfRlCmj9Md3TwGTJOgEXjQ=; b=zVv05wwCHNY/nUBCE0+k8c6Az3
	I8Cspxxfzxng49Ez7KvI/n9SYC7Aipd+Bi9n/gtEpeMi7LLqf3Gy8H7lXTV79HO8P1MR4JKy0IQhC
	pky1fyKI5TL/D1vChWJqHaKP1p4f2BkdyqPqEiJCbPC3wpX+mhp5VDH5opMrBYqHxU/1I9EvzX8dJ
	of1OzIIn3UBOJ3zK6joIt8LTRCcQ2LItD8+JQgZGnpxDViK1THVJ790KneNC2nC00dGkvspPvs3LM
	yHXp/T2SZAbr0I2iqtcHKoo8ICOtzqlVUinH7Nq/SxP1XDHMJTootUZVqA48dSl6sCOH3hxZR1BJq
	xIUJrQMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYmzw-00000002jWx-3GCy;
	Mon, 07 Jul 2025 14:39:12 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYmgA-00000002fgG-2Pep
	for linux-nvme@lists.infradead.org;
	Mon, 07 Jul 2025 14:18:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A872468C7B; Mon,  7 Jul 2025 16:18:34 +0200 (CEST)
Date: Mon, 7 Jul 2025 16:18:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: What should we do about the nvme atomics mess?
Message-ID: <20250707141834.GA30198@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250707_071846_766596_745CD942 
X-CRM114-Status: GOOD (  17.78  )
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

Hi all,

I'm a bit lost on what to do about the sad state of NVMe atomic writes.

As a short reminder the main issues are:

 1) there is no flag on a command to request atomic (aka non-torn)
    behavior, instead writes adhering to the atomicy requirements will
    never be torn, and writes not adhering them can be torn any time.
    This differs from SCSI where atomic writes have to be be explicitly
    requested and fail when they can't be satisfied
 2) the original way to indicate the main atomicy limit is the AWUPF
    field, which is in Identify Controller, but specified in logical
    blocks which only exist at a namespace layer.  This a) lead to
    various problems because the limit is a mess when namespace have
    different logical block sizes, and it b) also causes additional
    issues because NVMe allows it to be different for different
    controllers in the same subsystem.

Commit 8695f060a029 added some sanity checks to deal with issue 2b,
but we kept running into more issues with it.  Partially because
the check wasn't quite correct, but also because we've gotten
reports of controllers that change the AWUPF value when reformatting
namespaces to deal with issue 2a.

And I'm a bit lost on what to do here.

We could:

 I.	 revert the check and the subsequent fixup.  If you really want
         to use the nvme atomics you already better pray a lot anyway
	 due to issue 1)
 II.	 limit the check to multi-controller subsystems
 III.	 don't allow atomics on controllers that only report AWUPF and
 	 limit support to controllers that support that more sanely
	 defined NAWUPF

I guess for 6.16 we are limited to I. to bring us back to the previous
state, but I have a really bad gut feeling about it given the really
bad spec language and a lot of low quality NVMe implementations we're
seeing these days.
 not the 

