Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55303C4829A
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Feb 2024 06:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cedSgtbdqq5cttJArVzEW8A88f/xREi5ZtTzOS/wyZ4=; b=aQyA6EKSoQ5Jd6pqaTyGt7AS0I
	9UcSGMslvsvzCXXawr2v7TyGMszQ7Fp2MkvLj1Z88yZE3ZRlONZezj84mBWDfVBWKG5X4Pm18oLkF
	PAQ++oacU1QLK/eYWVwbjy15iQx0sMtBWzs2g31RQPzI/cP9LGVU+r+NsqLjPCr2PwfSdNTQ1qi+C
	xvK/DltO7QA8y6IU8blH4Hkqs3T1iVtQT7DszDFhK/DgMA9s/IUCvgk7gsV8infVgxeuTjg4CepAr
	Fm25TIQ8+pMllkxpF9tOIhv95/gNPj/mLB9VTRwSLIdUj8C+Q6BhVNyskTvnyJG2mkWsBkulM5srr
	elrXgKRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZmDY-000000087mS-49sR;
	Tue, 13 Feb 2024 06:24:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZmDW-000000087lp-1JgV
	for linux-nvme@lists.infradead.org;
	Tue, 13 Feb 2024 06:24:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A182F227A87; Tue, 13 Feb 2024 07:24:27 +0100 (CET)
Date: Tue, 13 Feb 2024 07:24:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, ojaswin@linux.ibm.com, bvanassche@acm.org,
	Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v3 05/15] block: Add REQ_ATOMIC flag
Message-ID: <20240213062427.GC23128@lst.de>
References: <20240124113841.31824-1-john.g.garry@oracle.com> <20240124113841.31824-6-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124113841.31824-6-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240212_222430_516847_DF3E4D42 
X-CRM114-Status: GOOD (  13.98  )
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

On Wed, Jan 24, 2024 at 11:38:31AM +0000, John Garry wrote:
> From: Himanshu Madhani <himanshu.madhani@oracle.com>
> 
> Add flag REQ_ATOMIC, meaning an atomic operation. This should only be
> used in conjunction with REQ_OP_WRITE.
> 
> We will not add a special "request atomic write" operation, as to try to
> avoid maintenance effort for an operation which is almost the same as
> REQ_OP_WRITE.

I'd also merge this into the main atomic writes block layer patch..


