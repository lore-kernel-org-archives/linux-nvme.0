Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6B4C282D1
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Mar 2025 20:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RQ1ZOOcQsVoF5tjGA9ms4TDsyY8pv8IoRtbC5k9hB4c=; b=wUndhrpZs/q21XOAtFQ8+yyuP2
	em7h8jNkzObS9vEV3F1VdPJGY6/fG2aWaxMx1DZJJhGy81/qhxIl3hQKGIlJyHbeyELXVBex0kOxv
	umlDDtWUKzVdaglu4zlMTq1H/HXoTpDQ37n93ADdE8JqNIB0EW+YLgpFAlz/+BrxlQpz/AHU1i+5X
	gNF2Tf6IM58sqbWxtye1bxoYtxx11E5m1QqBd6yukg7c96pg8KXOSVq2MCVUqC3GSp26W7WRLcFdI
	PgYb1gGtQU63/lHaoCzfHwkzPdecrR9J8qNMS/dpusIsWD1b7OQ7VpkxjXkYCJiwJsISTcfWsbW1l
	kqJbEaTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqIHL-0000000CBbo-1e8d;
	Thu, 06 Mar 2025 20:57:15 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqIBX-0000000CAMP-335P
	for linux-nvme@lists.infradead.org;
	Thu, 06 Mar 2025 20:51:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 443745C5A05;
	Thu,  6 Mar 2025 20:48:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C68C4CEE5;
	Thu,  6 Mar 2025 20:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741294274;
	bh=q32HyuRlMQt1Zam2/ulOfhJfOp7xkCj4XPMi1zCZEjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=baishVGIeMbGecP0VLrdbnIC+RPxyKDUZdMDZqwJTv2egrLtBkf9WbO9tiDIyb7qo
	 voZjjaeSkidXA5SlOt3tnzbC+DoHZup1icPVcoAXJ7etMVmRBFzF/l4FuKNP3sIKCs
	 0rxgXmD6sBlpEZwYaUpSxoYGkDU+iMknvwNEzF/HYVwJmmcL9x2MDVaQMO+s7iGoDQ
	 i753FoOFpCe14mwzaBzEfmtdP2UrfZc9Pl0oKY+81Aif3u9yPslZNmvY8iFQJjhFSU
	 QjlTh2BXDdWIUppksX9lAXPqVYZNVUtYJdGcwH3DLOzK/5UGwhGWwIkxW1PQQqLAGD
	 JjGDOSFBf6nPA==
Date: Thu, 6 Mar 2025 13:51:11 -0700
From: Keith Busch <kbusch@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [bug report] nvme: fio workload hangs on 16m random read
Message-ID: <Z8oKvwPd4UBY1awm@kbusch-mbp>
References: <87a59x6g5u.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a59x6g5u.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_125115_823659_3635356F 
X-CRM114-Status: GOOD (  13.12  )
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

On Thu, Mar 06, 2025 at 09:46:37PM +0100, Andreas Hindborg wrote:
> Hi All,
> 
> My CI system has found an issue for the following fio workload:
> 
> root@debian:~# insmod /mnt/v6.14-rc5-build/drivers/nvme/host/nvme-core.ko
> root@debian:~# insmod /mnt/v6.14-rc5-build/drivers/nvme/host/nvme.ko poll_queues=1
> 
> "fio" "--group_reporting" "--name=default" "--filename=/dev/nvme0n1"
> "--readwrite=randread" "--blocksize=16777216" "--direct=1" "--numjobs=1"
> "--ioengine=io_uring" "--iodepth=1" "--hipri=1" "--time_based=1"
> "--runtime=3000"
> 
> fio will hang, some times immediately, some times after a few minutes.
> 
> I observed this on v6.14-rc1 and v6.14-rc5. It is not present in v6.13.
> 
> Can any of you reproduce this? I was able to reproduce this on real
> hardware and in qemu.

Could you try adding this patch to your kernel?

https://lore.kernel.org/io-uring/92b0a330-4782-45e9-8de7-3b90a94208c2@kernel.dk/

