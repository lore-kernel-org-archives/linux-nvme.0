Return-Path: <SRS0=Kbn9=FH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBEFC63777
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Dec 2020 08:54:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD4FF22280
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Dec 2020 08:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4FF22280
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KwI0Bn+JWueTKM29ikeuCaSsRlW+sEWuUVWJCgDHjfE=; b=OqGC+Bbt3/sgy3kcBk6SKl+OO
	4lwTe5szVfeiLiutLTu+sZjrCZsSSWL+k0B/Nm9ILzJa/vbm0/90oAHG6upWdtY8F7uvW4zzFqLCh
	coCSlEE+dosJjgRYeKra7z5OBDbAZ5U7NWYZgkensbVM7RU5KwfqzyteZVRKoPt2wE76DgluWFx6a
	WGNOx7tJJG/rWdU6nEs3cWlM+OtfmqFGCFIS74V48MOeuFf7f6o/tK4kkEJgR73yHbcZU1Msymq0o
	2nUdCYkDPiNcKtocSY7rw4Q02nTzxgo7/8m1V9eo7CgWm3GhdQH6IjcLX1r+j310Jg7LxJwWzHKH1
	EXaEPemBQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkkNC-0007qk-C2; Thu, 03 Dec 2020 08:53:58 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkkN6-0007ou-0j
 for linux-nvme@lists.infradead.org; Thu, 03 Dec 2020 08:53:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B9FC867373; Thu,  3 Dec 2020 09:53:39 +0100 (CET)
Date: Thu, 3 Dec 2020 09:53:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 1/4] block: add a hard-readonly flag to struct gendisk
Message-ID: <20201203085339.GA17110@lst.de>
References: <20201129181926.897775-1-hch@lst.de>
 <20201129181926.897775-2-hch@lst.de> <yq17dpza6nz.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <yq17dpza6nz.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201203_035355_918502_78075261 
X-CRM114-Status: GOOD (  13.24  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 Mike Snitzer <snitzer@redhat.com>, Oleksii Kurochko <olkuroch@cisco.com>,
 ceph-devel@vger.kernel.org, Dongsheng Yang <dongsheng.yang@easystack.cn>,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org, Ilya Dryomov <idryomov@gmail.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Dec 02, 2020 at 11:04:33PM -0500, Martin K. Petersen wrote:
> 
> Hi Christoph!
> 
> >  - If BLKROSET is used to set a whole-disk device read-only, any
> >    partitions will end up in a read-only state until the user
> >    explicitly clears the flag.
> 
> This no longer appears to be the case with your tweak.

True.

> 
> It's very common for database folks to twiddle the read-only state of
> block devices and partitions. I know that our users will find it very
> counter-intuitive that setting /dev/sda read-only won't prevent writes
> to /dev/sda1.

What I'm worried about it is that this would be a huge change from the
historic behavior.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
