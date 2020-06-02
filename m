Return-Path: <SRS0=vW9m=7P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858E4C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2020 14:09:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3923F206E2
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2020 14:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iZhoGDAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3923F206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OPBXZCxolceKhRfoFRnOA4PUUKhX9fM4gL3uIdtRoIU=; b=iZhoGDAzn4P41z
	D9SHQN2KpxHFJgB2FQznD+slgOh0ZuGG7T4iuUONCwuduli0TBD6sINGPdAznexCAWTcmJ8kWHDk/
	6n1LO/USDFOMICvyAnmc6EphmXwPnwRO723ZeuN8/Q4Z6a5uIUo9bmLLlN6Yzp+dG5aKs+N9H8fjD
	Lfu82xOmz2V4rFXn5CHKIAZ4fKGG9AwpOs+T4kkhGk00DY7lsRGboYRQBcvJip+4d6QiCzmVRUOO5
	bCbtHpaOoPA9et2xM4dJ9E3qi7VTLWnaSvJV4RdLgHBXy/KqyauUn5sskkTuPYi9kUhxJRe+2ZbSy
	5t1MijuXq4Za+tHI6Qzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jg7bC-0001MH-23; Tue, 02 Jun 2020 14:09:02 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jfzqC-0004ig-CW
 for linux-nvme@lists.infradead.org; Tue, 02 Jun 2020 05:52:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B383A68BEB; Tue,  2 Jun 2020 07:51:52 +0200 (CEST)
Date: Tue, 2 Jun 2020 07:51:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] blkdev: Replace blksize_bits() with ilog2()
Message-ID: <20200602055152.GA11620@lst.de>
References: <20200529141100.37519-1-pilgrimtao@gmail.com>
 <c8412d98-0328-0976-e5f9-5beddc148a35@kernel.dk>
 <CAAWJmAZOQQQeNiTr48OSRRdO2pG+q4c=6gjT55CkWC5FN=HXmA@mail.gmail.com>
 <20200601084426.GB1667318@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200601084426.GB1667318@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200601_225200_572576_A2CB7326 
X-CRM114-Status: UNSURE (   6.59  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Tue, 02 Jun 2020 07:09:01 -0700
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: hoeppner@linux.ibm.com, heiko.carstens@de.ibm.com,
 linux-nvme@lists.infradead.org, dhowells@redhat.com, clm@fb.com,
 deepa.kernel@gmail.com, houtao1@huawei.com, hch@lst.de,
 linux-s390@vger.kernel.org, Tao pilgrim <pilgrimtao@gmail.com>,
 darrick.wong@oracle.com, Mark Fasheh <mark@fasheh.com>, satyat@google.com,
 hch@infradead.org, borntraeger@de.ibm.com, gor@linux.ibm.com,
 ajay.joshi@wdc.com, chaitanya.kulkarni@wdc.com, chao@kernel.org,
 Josef Bacik <josef@toxicpanda.com>, ming.lei@redhat.com, dsterba@suse.com,
 viro@zeniv.linux.org.uk, Muchun Song <songmuchun@bytedance.com>,
 sagi@grimberg.me, jaegeuk@kernel.org, jlbec@evilplan.org, bvanassche@acm.org,
 Jens Axboe <axboe@kernel.dk>, balbi@kernel.org, damien.lemoal@wdc.com,
 martin.petersen@oracle.com, joseph.qi@linux.alibaba.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 asml.silence@gmail.com, linux-btrfs@vger.kernel.org, sth@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jun 01, 2020 at 10:44:26AM +0200, Greg KH wrote:
> But does this code path actually show up anywhere that is actually
> measurable as mattering?
> 
> If so, please show that benchmark results.

I think the requests are starting to be a bit unreasonable.  Tao is
replacing a reimplementation of a standard function with that standard
function / compiler builtin.  We don't put such a high burden on that.

And once the proper existing fields are used where possible as shown
in my reply just replacing the rest seems totally obvious - quite
contrary I think keeping a reimplementation would need a high bar.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
