Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A5FC4452D
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jul 2026 23:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HbarWDj744NAcsuxjg2Rf91YA+KE2onmHu1JCGxVkMk=; b=IBiEqZh/rE9WU5
	AR5thQ+ae9k5LALR2/4eynNfbfabXAD1kLAR0yvRQFP0O7/E0DcxD77LyPkODh5RvLibL3QxI3QNR
	P/aJ4w76Mas/FpybkFr/9pV0H6Mkf8MLTwKyw77+wdvNGrJooA3eYRsNDGExfuDrmlKLLtLI9dv7q
	aEsds3ce38txx9VLy+6sNWw91aO5GoyOl3QMbcGEDYvfzv8DKNE4IcHbOkH/lYXzG+nEDoIZibjU8
	ineaehl836jcc3x9AsaFwQ1ipbrLRuC6PBkeOlaS073NuwsE7F72zPEd0k8/5VjLFozWKCeAk623E
	YW3YsklScprjQSyAE/gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmK3c-0000000AbX1-3xOi;
	Tue, 21 Jul 2026 23:39:28 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmK3a-0000000AbW9-1Azz
	for linux-nvme@lists.infradead.org;
	Tue, 21 Jul 2026 23:39:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=HbarWDj744NAcsuxjg2Rf91YA+KE2onmHu1JCGxVkMk=; b=JePFvpH8O3DliRZI9R402wwaly
	fzTJoa1IC/gAX7iXrnp+PZZCWWxrbTrYtLFQQlDJAALmHAAHkvl9BS90oj/6KpknU6eecrU2DIvi9
	bmrZYjqv2t5S1XlQ3svKNmfTRdxjLDyYuYYN5R0CnhkFkXqnziZ4oteFmlKz/LkSjjght2dXUlK4G
	lSy6UgIhh4jH6/6xxQjEneuIobFofIakqQK67iX4Sf7KN3RdxfHjzseGs93v9EKKTnUngrXY2fMU/
	8U6x0Acyjia92PkagrInKbsSkY9SyISp9cl/sfJWAk+AcZDTbYCeUs056xXviAH1IzKUT6kALehs1
	CBt7pp9w==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wmK3R-0000000BuOW-0FPO;
	Tue, 21 Jul 2026 17:39:17 -0600
Message-ID: <9f846c85-f427-433a-b87d-8e9e3a4406e7@deltatee.com>
Date: Tue, 21 Jul 2026 17:38:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mykola Marzhan <mykola@meshstor.io>
Cc: Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
 Yu Kuai <yukuai@fygo.io>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-nvme@lists.infradead.org, Li Nan <magiclinan@didiglobal.com>,
 Xiao Ni <xiao@kernel.org>, Guoqing Jiang <guoqing.jiang@linux.dev>,
 Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Shivaji Kant <shivajikant@google.com>, Pranjal Shrivastava
 <praan@google.com>, Henrique Carvalho <henrique.carvalho@suse.com>,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260719105327.864949-1-mykola@meshstor.io>
 <20260719105327.864949-7-mykola@meshstor.io>
 <ee312bcb-92f4-4884-91cd-3bd56180c8c7@deltatee.com>
 <CAPzsNDsLr_BABgizujN0CgnLNfzS3S37vQ133fjbJzFMvRs7CQ@mail.gmail.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <CAPzsNDsLr_BABgizujN0CgnLNfzS3S37vQ133fjbJzFMvRs7CQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: mykola@meshstor.io, axboe@kernel.dk, song@kernel.org, yukuai@fygo.io, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org, magiclinan@didiglobal.com, xiao@kernel.org, guoqing.jiang@linux.dev, leon@kernel.org, jgg@ziepe.ca, kmodukuri@nvidia.com, kch@nvidia.com, bhelgaas@google.com, shivajikant@google.com, praan@google.com, henrique.carvalho@suse.com, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 6/7] md/raid1,raid10: skip futile retries on P2PDMA
 mapping failures
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_163926_333548_6702C9FE 
X-CRM114-Status: GOOD (  22.31  )
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



On 2026-07-21 11:50, Mykola Marzhan wrote:
> I have split it in v3 into a raid1 patch and a raid10 patch.
> I am not sure about separate "introduce the bit" patches.
> R1BIO_P2PDMA and R10BIO_P2PDMA are entries in the two personalities'
> with own r*bio state enums.
> The commit messages are shorter now.

That helps a bit, thanks.


> An early return doesn't work here: on a mapping failure the
> function must still fall through to set R1BIO_WriteError, so the
> completion path runs the (single, whole-range) retry and records
> the bad range -- only WantReplacement and the FailFast md_error()
> are skipped.  v3 folds the two tests into one branch now,
> which reads better and keeps the fall-through. Please check v3.

The early return works if you create a helper.

> I compared the two sides after splitting: the P2PDMA handling is
> symmetric, and the remaining differences are pre-existing
> personality differences rather than missed fixes.
> A shared helper would be heavier than the two open-coded branches,
> so I kept it per-personality.

Yeah, I still think it's a bit of a mess so I dug into it a bit more
myself.

I realized the real problem in this patch set was reusing
BLK_STS_TARGET. I think I may have used that a long time ago and those
paths have since been removed. Using it here doesn't quite make sense
because we end up with those awkward checks (is P2PDMA enabled *and* the
error is a BLK_STS_TARGET). I don't think that can ever really be
correct here seeing something could, in theory return BLK_STS_TARGET for
another reason even when P2PDMA is enabled. So that should be cleaned up.

Instead, I think it makes more sense to introduce a new BLK_STS_P2PDMA
error and use that. Then we don't need to know if a transaction is
P2PDMA when processing the result which simplifies patch 6 and 7
significantly.

I created a basic sketch which demonstrates what I'm thinking here:

https://github.com/lsgunth/linux blk-sts-p2p-err

Feel free to run with that.

(Note: I omitted the narrow_write_error() from the sketch because I
didn't dig into it enough to understand it. It'll need to be added to
this, preferably cleaning up the tabbing style a bit.)

Logan



