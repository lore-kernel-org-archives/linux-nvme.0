Return-Path: <SRS0=mQhi=PX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A80C433FE
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Nov 2021 17:37:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93F46611EF
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Nov 2021 17:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 93F46611EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c7K5KBvB2RfW8J24kjEOvJaSRoUK/3qO9tvjH55Igmk=; b=RQ5B2GE19LhKrXDp6IfVzKzSbB
	KFELNNPRmTkXILmA9l4PaVSw4QtXQPLrVLcPHpziuq9SzgMxeND2KvHnBgrXVY6IBVqluEQdAVA3i
	Pxb7K8HuUTAQWHVWGzlAkLRkz4BKi+o3dHVtlGgwrmb+nP24ThCXUPs240kFaeH/f1Z5+g+nfBMPK
	s/2qxIki7YYHTJbhtxWykidLBJSilEecPbIKpnKAt9iJl7GPsoKRUX4ESV3yYAhvTCrgB9HYutKEX
	kQ5zRMK1v3SY8rkcwEIBnOJ5T+5o+0EYyMaHek47jQTkmRs/o+6tw6h3JBlBo5Wjf6JThl+EPuH6e
	8BFTNEmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1migfc-009ggq-Jg; Thu, 04 Nov 2021 17:37:00 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1migdJ-009gF6-53
 for linux-nvme@lists.infradead.org; Thu, 04 Nov 2021 17:34:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 64F956732D; Thu,  4 Nov 2021 18:34:31 +0100 (CET)
Date: Thu, 4 Nov 2021 18:34:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "agk@redhat.com" <agk@redhat.com>,
 "snitzer@redhat.com" <snitzer@redhat.com>,
 "song@kernel.org" <song@kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "javier@javigon.com" <javier@javigon.com>,
 "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
 "bvanassche@acm.org" <bvanassche@acm.org>,
 "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>,
 "osandov@fb.com" <osandov@fb.com>,
 "willy@infradead.org" <willy@infradead.org>,
 "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
 "jack@suse.com" <jack@suse.com>, "tytso@mit.edu" <tytso@mit.edu>,
 "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
 "jlayton@kernel.org" <jlayton@kernel.org>,
 "idryomov@gmail.com" <idryomov@gmail.com>,
 "danil.kipnis@cloud.ionos.com" <danil.kipnis@cloud.ionos.com>,
 "ebiggers@google.com" <ebiggers@google.com>,
 "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>
Subject: Re: [RFC PATCH 0/8] block: add support for REQ_OP_VERIFY
Message-ID: <20211104173431.GA31740@lst.de>
References: <20211104064634.4481-1-chaitanyak@nvidia.com>
 <20211104071439.GA21927@lst.de>
 <661bcadd-a030-4a72-81ae-ef15080f0241@nvidia.com>
 <20211104173235.GI2237511@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104173235.GI2237511@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211104_103437_365942_F101E8DC 
X-CRM114-Status: GOOD (  14.38  )
X-Mailman-Approved-At: Thu, 04 Nov 2021 10:36:49 -0700
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

On Thu, Nov 04, 2021 at 10:32:35AM -0700, Darrick J. Wong wrote:
> I also wonder if it would be useful (since we're already having a
> discussion elsewhere about data integrity syscalls for pmem) to be able
> to call this sort of thing against files?  In which case we'd want
> another preadv2 flag or something, and then plumb all that through the
> vfs/iomap as needed?

IFF we do this (can't answer if there is a need) we should not
overload read with it.  It is an operation that does not return
data but just a status, so let's not get into that mess.

