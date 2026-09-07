Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E6AC79F8C
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Sep 2026 02:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NigjiC+zcDGWomyb0xomDqqP9XDx5b0LXXd6UozBt/g=; b=OqK0aR6+93jsF8Koj17fdtszD2
	fFNB7eBzIj+iFIl1FuJxLBHLHAPSs3OEuA0FvUXP1G3DnFV73cJ8hx5JR3i3BP2rfiqVbAL6UeumV
	f0HykKOfp1jQ5ZK7pw7WXtLqoa2VfNvfqYuxC61Lk2dHEmMipRH5kJa2DFW28A+RcHLqw65iI+QM4
	nrk7+p005GtSRtf9GhdSxJ+2YkZ+T3Plwz+fKL8DQJaLkawEi0EzsBkTX1Yu7LjouCHN+NPt1J6q5
	Svv1oPOR5vwlMDR5D8JXuj/Wnjg/fg2mvF8rfngeKwEscxUjckNOBO2k30GqEDsYQeIqGaI1mNBaQ
	cDd4kleg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3Ota-00000005hZs-0oL2;
	Mon, 07 Sep 2026 02:15:42 +0000
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3OtT-00000005hYv-0Fsn
	for linux-nvme@lists.infradead.org;
	Mon, 07 Sep 2026 02:15:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788747327; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=NigjiC+zcDGWomyb0xomDqqP9XDx5b0LXXd6UozBt/g=;
	b=d2/dH23I6cvhZnDQVD7fR/uyCNr/BhjPYSylfvAp704lG6YT4fEGx9y+pk20TmwkXzVVbTAQXvcd+3ZlmjZc4jiHHAqmQjk/c7geglGWHP/Sa+67ttvrPn9J1GD4NWMmFAKy+SbXXkwnXiN2y1TXF8PqebSOrtV5aK2TuJZuQBM=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XAOGroo_1788747325;
Received: from 30.178.69.48(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XAOGroo_1788747325 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 07 Sep 2026 10:15:26 +0800
Message-ID: <097fa1af-41eb-461b-873e-b5f27e1ae872@linux.alibaba.com>
Date: Mon, 7 Sep 2026 10:15:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] nvme-multipath: expose path_state via sysfs
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
 John Garry <john.g.garry@oracle.com>
Cc: linux-nvme@lists.infradead.org
References: <20260724090004.1146014-1-kanie@linux.alibaba.com>
In-Reply-To: <20260724090004.1146014-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260906_191535_785008_FD7C8326 
X-CRM114-Status: GOOD (  16.15  )
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

Hi, any comments here?

Best Regards,
Guixin Liu

在 2026/7/24 17:00, Guixin Liu 写道:
> This series adds a read-only "path_state" sysfs attribute to each NVMe
> multipath path namespace device (/sys/block/nvmeXcYnZ/path_state), giving
> userspace visibility into whether a path is currently usable for I/O and,
> if not, the reason it is disabled.
>
> Today users have to piece this together from the controller state and
> various namespace flags. The new attribute reports the path selection
> state directly, and is kept in sync with the path selection logic by
> sharing a single nvme_path_get_state() helper.
>
> Patch 1 adds the attribute and the helper; patch 2 documents it in the
> stable NVMe sysfs ABI file.
>
> Changes since v3:
> - Use single-token sysfs values ("enabled", "ctrl-down", "ana-pending",
>    "ns-not-ready") instead of the composite "disabled (reason)" and
>    "enabled (optimized)/(non-optimized)" strings, following the sysfs
>    convention of exporting one simple value per attribute.
> - Drop the "enabled (optimized)" vs "enabled (non-optimized)"
>    distinction; the ANA access state is already exposed through the
>    existing per-path ana_state attribute.
> - Add a second patch documenting path_state in the stable NVMe sysfs
>    ABI (Documentation/ABI/stable/sysfs-nvme).
>
> Changes since v2:
> - Factor path disable checks into nvme_path_get_state() helper returning
>    enum nvme_path_state, and rebuild nvme_path_is_disabled() on top of it
>    to keep path selection logic and sysfs reporting in sync. (Nilay Shroff)
> - Distinguish "enabled (optimized)" vs "enabled (non-optimized)" based on
>    ANA state. (Keith Busch)
>
> Changes since v1:
> - Show specific disabled reason instead of just "disabled":
>    "disabled (ctrl_down)", "disabled (ana_pending)",
>    "disabled (ns_not_ready)". (Nilay Shroff)
>
> Guixin Liu (2):
>    nvme-multipath: expose path_state via sysfs
>    nvme-multipath: document path_state sysfs attribute
>
>   Documentation/ABI/stable/sysfs-nvme | 21 +++++++++++++
>   drivers/nvme/host/multipath.c       | 47 +++++++++++++++++++++++++----
>   drivers/nvme/host/nvme.h            |  1 +
>   drivers/nvme/host/sysfs.c           |  4 ++-
>   4 files changed, 66 insertions(+), 7 deletions(-)
>
>
> base-commit: 7caaa4120d8dd73bb251410e1d007b4131d024c4


