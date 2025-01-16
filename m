Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EDAC02183
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jan 2025 10:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XNPtSDa6XVF4zUwXYwxaiFEArinpy1Jhqi0F1r5Nk5Q=; b=2eGAg50QCbFLqiMzPzQ7aWyo5a
	qvQ/oqlACbGiX7ZdmaiJIMgpX7O/XB8YggppwoPY/8b768EDOJmhp3XdwUCJ9tVvg25YJ56wHzmPy
	Y4hbNMNh/WnwsDP76ZzL/W10n6LqbLcQ5cOZx7vgfU1y7vXlt41kz8S+XeLrFm8ejp2av2kEAw+Wz
	Qx/XL1B9NfidorH8+0YoBlaB3QnNcV2XDC7rpjIpUGBv5IemnXOoTZCMI7e61boSQDOkJVMxZifxT
	DpcvFivHgB4iB5kWgxxIatf7Niai5eqwxkaxPCm3FDqdqDenxO7EW/nBcZmNnxgFzeHnxtPtXlg5x
	W/GytSJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYMk2-0000000ERpu-0nQK;
	Thu, 16 Jan 2025 10:04:46 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYMjz-0000000ERoO-0vfa
	for linux-nvme@lists.infradead.org;
	Thu, 16 Jan 2025 10:04:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 02EF85C5CD8;
	Thu, 16 Jan 2025 10:04:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18E2C4CED6;
	Thu, 16 Jan 2025 10:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737021882;
	bh=umRE6v25xluhGP765JX3qQKm9iDvOyK2b54s+f7mP5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V+LUdMcWSz6X0NwN2VNwxC18SbqevUZzZF8qtF5uuMwgUobfeARBDRExAA/Br6LLU
	 4RsBrAC6sLgqV4uEtwS4uppHqkaEzEC95BuWO7NUpiHoE2oUkB551WKoQ9SyGe1XQ0
	 SZKt8/9g0nHClUkYXBbbM0EdANZO63jSgVd4nQHIKPRujdjEeX4gneeDTnKMDqa5VH
	 0WBDUV/bn4GRzPALGj2rB1j2hxX4yjdcjGBesXzU1cssKtpp01fQ0O/GSGIplAgcxg
	 Xy6WqJUVqPMl0FzVExkqFy0HG96UvxihmvbWRrr3k5EbYsVv9eYI3hGgiVhV/5D3AE
	 jFbIznUVIvk2g==
Date: Thu, 16 Jan 2025 11:04:36 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, oe-lkp@lists.linux.dev, lkp@intel.com,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org, Damien Le Moal <dlemoal@kernel.org>,
	linux-btrfs@vger.kernel.org, linux-aio@kvack.org
Subject: Re: [linus:master] [block]  e70c301fae: stress-ng.aiol.ops_per_sec
 49.6% regression
Message-ID: <Z4jZtH2lhsZ3JTZ9@ryzen>
References: <Z2EgW8/WNfzZ28mn@xsang-OptiPlex-9020>
 <20241217065614.GA19113@lst.de>
 <Z3ZhNYHKZPMpv8Cz@ryzen>
 <20250103064925.GB27984@lst.de>
 <Z3epOlVGDBqj72xC@ryzen>
 <Z3zlgBB3ZrGApew7@xsang-OptiPlex-9020>
 <Z35VVvuT0nl0iDfd@ryzen>
 <Z4DD1Lgzvv66tS3w@xsang-OptiPlex-9020>
 <Z4efKYwbf2QYBx40@ryzen>
 <Z4ipFFdAppraxrmA@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4ipFFdAppraxrmA@xsang-OptiPlex-9020>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250116_020443_348907_97C7FF19 
X-CRM114-Status: GOOD (  22.95  )
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

On Thu, Jan 16, 2025 at 02:37:08PM +0800, Oliver Sang wrote:
> On Wed, Jan 15, 2025 at 12:42:33PM +0100, Niklas Cassel wrote:
> > 
> > Looking closer at the raw number for stress-ng + none scheduler, in your
> > other email, it seems clear that the raw values from the stress-ng workload
> > can vary quite a lot. In the long run, I wonder if we perhaps can find a
> > workload that has less variation. E.g. fio test for IOPS and fio test for
> > throughout. But perhaps such workloads are already part of lkp-tests?
> 
> yes, we have fio tests [1].
> as in [2], we get it from https://github.com/axboe/fio
> not sure if it's just the fio you mentioned?

Yes, that's the one :)


> 
> our framework is basically automatic. bot merged repo/branches it monitors
> into so-called hourly kernel, then if found performance difference with base,
> bisect will be triggered to capture which commit causes the change.
> 
> due to resource constraint, we cannot allot all testsuites (we have around 80)
> to all platforms, and there are other various reasons which could cause us to
> miss some performance differences.
> 
> if you have interests, could you help check those fio-basic-*.yaml files under
> [3]? if you can spot out the correct case, we could do more tests to check
> e70c301fae and its parent. thanks!
> 
> [1] https://github.com/intel/lkp-tests/tree/master/programs/fio
> [2] https://github.com/intel/lkp-tests/blob/master/programs/fio/pkg/PKGBUILD
> [3] https://github.com/intel/lkp-tests/tree/master/jobs

I'm probably not the best qualified person to review this, would be nice if e.g.
Jens himself (or others block layer folks) could have a look at these.

What I can see is:
https://github.com/intel/lkp-tests/blob/master/jobs/fio-basic-local-disk.yaml

seems to do:
    - randrw

but only on for SSDs, not HDDs, and only on ext4.



https://github.com/intel/lkp-tests/blob/master/jobs/fio-basic-1hdd-write.yaml

does test ext4, btrfs, and xfs,
but it does not do randrw.


What are the thresholds for these tests counting as a regression?
Are you comparing BW, or IOPS, or both?

Looking at:
https://github.com/intel/lkp-tests/blob/master/programs/fio/parse

It seems to produce points for:
bw_MBps
iops
total_ios
clat_mean_ns
clat_stddev
slat_mean_us
slat_stddev
and more.

So it does seem to compare BW, IOPS, total IOs, which is what I was looking
for.

Possibly even too much, as enabling too much logging will actually affect
the results, since you need to write way more output to the logs.

But again, Jens (and other block layer folks) are the experts.


Kind regards,
Niklas

