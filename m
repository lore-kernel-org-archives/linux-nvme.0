Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C291C02183
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jan 2025 11:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=87iWy9v4rW7TLZRaG/mQnW0rW43/f/JEGGMfKb6x2cw=; b=mQMB1aNOoxAaqEiJjrx1eMx/Pa
	qrJ8wweTEtkRbZT7NHTTGDsZBFN/j/Q6D4A8d5QalV4D8radVJlwxr5QiWc6U5tPByROtIsuRiGK3
	bmmQry5hqVF7sfJ474AvsntvbpiepGYHhh6cETpzWJ8sYzhpl3jl82F+W3Z1qus7i6jp/0+1Q/dmW
	2NLNmGSKR7b3TLYd8/Oc+Y7Ry1XQx9N2uf0hy61g575r1dmI/0Cc09heJfejm+NS4nSknODEV1se/
	RVH8xnIgRK5qGyh4f2jtv1G2AhC68nHJUsgiQ573m37yAYE3I5AneiaoqD3eB9n6H/BJwG/2KJCWG
	oKi9m31g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tY1nG-0000000BjAB-1NwB;
	Wed, 15 Jan 2025 11:42:42 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tY1nD-0000000Bj6f-3aJG
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jan 2025 11:42:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5C9505C176F;
	Wed, 15 Jan 2025 11:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562EAC4CEE6;
	Wed, 15 Jan 2025 11:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736941358;
	bh=pq/v0VSJ9VsZQn33S7S7wvNcGH+oudGNlgIaUU4DpJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SK1UM+rfoqKh/h3BU5ce3vIkS003NTSuW+v6diKDwjMb+JbyjOu6hOcQ4NbQfqUJN
	 94c5rc6AwA+9T1Vy+2lvYgfbl+d62DXYW9tNBrP9p8znN6P96ewJ7Wyys4JPP3EJrd
	 Tx92bEk2LuC3tN50gYqtCXmFbwoq8BA0L2jMNdx3E5n6Q9B3D6V7f6xpO7LGAanP4t
	 rKrNSLjQcpmSGj3fQD9UCpBUoi7+cHw5KwxrVZ+S0noeNhLliYvjdIkBIKEdA89flU
	 YJ9F9cJat63XgK20QD2vguEaHDAf6dEsfajhwp08RlohMxVkDV//k28maTUzgDi4o/
	 HfCCCKF5ZhMpQ==
Date: Wed, 15 Jan 2025 12:42:33 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, oe-lkp@lists.linux.dev, lkp@intel.com,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org, Damien Le Moal <dlemoal@kernel.org>,
	linux-btrfs@vger.kernel.org, linux-aio@kvack.org
Subject: Re: [linus:master] [block]  e70c301fae: stress-ng.aiol.ops_per_sec
 49.6% regression
Message-ID: <Z4efKYwbf2QYBx40@ryzen>
References: <20241213143224.GA16111@lst.de>
 <20241217045527.GA16091@lst.de>
 <Z2EgW8/WNfzZ28mn@xsang-OptiPlex-9020>
 <20241217065614.GA19113@lst.de>
 <Z3ZhNYHKZPMpv8Cz@ryzen>
 <20250103064925.GB27984@lst.de>
 <Z3epOlVGDBqj72xC@ryzen>
 <Z3zlgBB3ZrGApew7@xsang-OptiPlex-9020>
 <Z35VVvuT0nl0iDfd@ryzen>
 <Z4DD1Lgzvv66tS3w@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4DD1Lgzvv66tS3w@xsang-OptiPlex-9020>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_034239_998250_BC0B39FE 
X-CRM114-Status: GOOD (  19.55  )
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

Hello Oliver,

On Fri, Jan 10, 2025 at 02:53:08PM +0800, Oliver Sang wrote:
> On Wed, Jan 08, 2025 at 11:39:28AM +0100, Niklas Cassel wrote:
> > > > Oliver, which I/O scheduler are you using?
> > > > $ cat /sys/block/sdb/queue/scheduler 
> > > > none mq-deadline kyber [bfq]
> > > 
> > > while our test running:
> > > 
> > > # cat /sys/block/sdb/queue/scheduler
> > > none [mq-deadline] kyber bfq
> > 
> > The stddev numbers you showed is all over the place, so are we certain
> > if this is a regression caused by commit e70c301faece ("block:
> > don't reorder requests in blk_add_rq_to_plug") ?
> > 
> > Do you know if the stddev has such big variation for this test even before
> > the commit?
> 
> in order to address your concern, we rebuild kernels for e70c301fae and its
> parent a3396b9999, also for v6.12-rc4. the config is still same as shared
> in our original report:
> https://download.01.org/0day-ci/archive/20241212/202412122112.ca47bcec-lkp@intel.com/config-6.12.0-rc4-00120-ge70c301faece

Thank you for putting in the work to do some extra tests.

(Doing performance regression testing is really important IMO,
as without it you are essentially in the blind.
Thank you guys for taking on the role of this important work!)


Looking at the extended number of iterations that you've in this email,
it is quite clear that e70c301faece, at least with the workload provided
by stress-ng + mq-deadline, introduced a regression:

       v6.12-rc4 a3396b99990d8b4e5797e7b16fd e70c301faece15b618e54b613b1
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
    187.64 ±  5%      -0.6%     186.48 ±  7%     -47.6%      98.29 ± 17%  stress-ng.aiol.ops_per_sec




Looking at your results from stress-ng + none scheduler:

         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
    114.62 ± 19%      -1.9%     112.49 ± 17%     -32.4%      77.47 ± 21%  stress-ng.aiol.ops_per_sec


Which shows a change, but -32% rather than -47%, also seems to suggest a
regression for the stress-ng workload.




Looking closer at the raw number for stress-ng + none scheduler, in your
other email, it seems clear that the raw values from the stress-ng workload
can vary quite a lot. In the long run, I wonder if we perhaps can find a
workload that has less variation. E.g. fio test for IOPS and fio test for
throughout. But perhaps such workloads are already part of lkp-tests?


Kind regards,
Niklas

