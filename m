Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDAB606A31C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YmQ0YkD4;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ffGAtueZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=1zIRD0D9W9ljkEFtcR36F37mpxlMguIAnlX3mpE5yME=; b=YmQ0YkD4ql43aU
	LMB4/AlGkWBqd2uqdzVJ77uZoWmSGZL1LKPbt+bFlkUeSsrzwKGKFTTfMQhWMsM1imjZ4+hRdfosm
	gNGX+nm6Epw/7/LGgskwpg3JmbuuZnbOAKYxDSeXFuiRGtvnt5vpG9Zcu0MJVXT4EkWf2xjQ0Myqi
	itP8gPq7V4tFYczozxPgzEGNECcEIA6rtMFORu6D8vLQk+mrBLcgYfsLF3cJtZRWwRZgrhTdh13CQ
	bz3OhpzXJeS6Jv+MRbjJEpXEdWuKgTxX4Dw9ZtvU6UvHNct11y4A4L/qoyxCOR6ILCz7N70gEgt1d
	aXv2lKWYgu7c3fYD7QqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuNU-000000022Ei-2lGo;
	Mon, 16 Nov 2026 10:56:00 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuNO-0000000226m-3qde
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 10:55:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794826552; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=1zIRD0D9W9ljkEFtcR36F37mpxlMguIAnlX3mpE5yME=;
	b=ffGAtueZXno0txzw9HDTkrkVGFf7OrjV0IZTw3faPyyTaPr+0w4gcXBvSO3VAzm8TWY0eLPUmb/uXrLBQZ3EIKxMNCqp50OR17zh39zC5czrF6I9lJq+Eih/pMb7YhXmLt+nBwH2h0RP4u/wbv1Yf1jnGrquiyd43mSJw1AOx5k=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XEr1nPN_1794826550;
Received: from 30.178.85.242(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XEr1nPN_1794826550 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 16 Nov 2026 18:55:51 +0800
Message-ID: <5a38e9e7-971a-447d-a27b-dc8bee3e8fa5@linux.alibaba.com>
Date: Mon, 16 Nov 2026 18:55:50 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/12] nvmet: FDP bridge for NVMe-oF targets
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
 Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261029122833.284572-1-kanie@linux.alibaba.com>
In-Reply-To: <20261029122833.284572-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_025555_954856_2BD4D347 
X-CRM114-Status: GOOD (  40.09  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-19.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,
  A gentle ping on this series, all comments are welcome. If you have any concerns about this feature, please let me know. Best Regards, Guixin Liu

在 2026/10/29 20:28, Guixin Liu 写道:
> Flexible Data Placement (FDP) is defined in the NVMe base specification
> and therefore applies to fabrics as well.  An Ethernet Bunch Of
> Flash (EBOF) style storage system that exposes its local FDP-capable
> NVMe drives to remote hosts over NVMe-oF currently has no way to pass
> that capability through: nvmet neither advertises FDP nor translates
> or forwards any FDP command, so a host connected through the target
> loses the write amplification benefits that the local drives provide.
>
> This series adds an FDP bridge to the NVMe target.  A namespace backed
> by an NVMe namespace opts in through the fdp_enable configfs attribute;
> the bridge then advertises the FDPS capability, reports the backing FDP
> configuration through the feature and log pages, translates the
> placement identifiers of write commands to the backing write streams,
> and forwards the FDP management commands and log pages to the backing
> controller.  The backing geometry is verified at namespace enable time,
> so the bridge only comes up when the backing placement identifiers are
> identity mapped, which the translation relies on.
>
> The FDP commands are served by the bridge directly instead of relying
> on the existing passthru support, for several reasons:
>
>   - Passthru subsystems do not support reservations; the reservation
>     commands are rejected and the controller is not advertised as
>     reservation capable, because the underlying device cannot
>     differentiate the hosts that connect over fabrics.  A regular
>     namespace goes through the target's own reservation implementation,
>     which is not available to a passthru subsystem.
>
>   - A passthru subsystem is bound to a single backend controller: the
>     whole drive, with all of its namespaces, is passed through as one
>     unit, and no regular namespaces can be added to the subsystem.  An
>     EBOF system needs to compose a storage pool out of individual
>     namespaces from multiple backend drives, which only the regular
>     namespace path provides.
>
>   - The regular namespace path already handles the target side of
>     reservations, ANA reporting and per-namespace configuration; the
>     bridge extends that path rather than replacing it.
>
>   - With passthru, the namespace identity of the backend drive is
>     exposed to the host as is, and the host would talk to the backend
>     controller's FDP state through the passthrough of every command.
>     The bridge instead owns the FDP presentation of the exported
>     namespace, while the state that the backing controller owns is
>     forwarded to it: the reclaim unit handle status hosts read and the
>     reclaim unit handle updates they issue are carried out by the
>     controller that actually manages the media.
>
> The Linux host side needs no changes: the existing FDP discovery path
> (FDPS bit, endurance group identifier, FDP feature, FDP configurations
> log page and reclaim unit handle status) works against the bridge
> unmodified.
>
> The series is structured as follows:
>
>   1-2   wire structures and block layer helper
>   3     nvme_bdev_ops export, used to recognize an NVMe backing device
>   4     per-namespace bridge state and configuration
>   5     fdp_enable ABI documentation
>   6     endurance group identifier in the CS-INDEP identify data
>   7     FDPS advertisement
>   8     FDP feature (FID 1Dh)
>   9     I/O management command forwarding
>   10    FDP log pages (LID 20h-23h)
>   11    placement identifier translation on the write path
>   12    tracepoint for the translation
>
> This was tested with a QEMU FDP backing device through an nvmet-tcp
> loopback setup, with persistent reservations enabled on the exported
> namespace: the host discovers and registers the backing write streams
> over the bridge, writes with placement identifiers land in the reclaim
> units of the backend device they select (verified through the reclaim
> unit handle status of the backend, for single bio and chained bio
> writes alike), and the forwarded log pages match the backend byte for
> byte.  Short and offset reads of the configurations log match the full
> page, and Set Features on a namespace without FDP accepts the unchanged
> disabled configuration.  I/O management receive requests whose NUMD
> arithmetic would wrap, zero-length forwards, and requests above the
> 1 MiB staging bound are rejected with Invalid Field.  A second
> namespace without FDP in the same subsystem comes up normally and
> reports FDPE clear.  With a second controller registered, the FDP
> commands are served while a write exclusive reservation is held,
> writes from the non-holder conflict, and preempt-and-abort completes
> with I/O management commands in flight.
>
> Changes since v2:
>
>   https://lore.kernel.org/all/20261023080251.2606443-1-kanie@linux.alibaba.com/
>
>   - Take the namespace reference of the FDP commands under
>     NVMET_NS_IO_LIVE with percpu_ref_tryget_live_rcu(), closing a
>     use-after-free against a concurrently disabled namespace.
>   - Report FDPE clear from Get Features for namespaces without FDP,
>     so that a subsystem mixing bridged and regular namespaces does
>     not fail the host's per-namespace discovery; Set Features accepts
>     that same disabled configuration as a no-op.
>   - Evaluate the I/O management receive transfer length in 64 bits
>     instead of letting the 32-bit NUMD arithmetic wrap, bound all
>     staged FDP transfers to 1 MiB, and reject zero-length forwards.
>   - Re-encode NUMD of the forwarded log pages from the staged transfer
>     length instead of carrying over the host supplied value, and clear
>     the reserved metadata field of the forwarded commands.
>   - Fall through to the persistent reservation access checks for the
>     I/O management commands instead of returning before them.
>   - Require the backing reclaim unit handle count to match the write
>     streams exactly instead of accepting a larger count.
>   - Read the backing FDP configurations log at enable time so the
>     advertised handle types and the 64-bit reclaim unit nominal size
>     are the backing device's own values, selected by the active
>     FDPCIDX rather than by descriptor order, and validate every
>     descriptor before dereferencing it.
>   - Serve short reads and nonzero Log Page Offsets of the
>     configurations log as windows of the complete page.
>   - Run the FDP command handlers from a workqueue so that lpfc cannot
>     sleep in hardirq context.
>   - Track the FDP capability as a per-subsystem count, incremented at
>     namespace enable and decremented at namespace disable.
>   - Advertise the I/O management commands in the command-effects log
>     only when the subsystem actually bridges FDP, and set error_loc
>     for invalid FDP feature requests.
>   - Document fdp_enable in the ABI file.
>
> Changes since v1:
>
>   https://lore.kernel.org/all/20261019033624.402337-1-kanie@linux.alibaba.com/
>
>   - Verify the transfer length encoded in the I/O management commands
>     against the length the host supplied, and do not carry the host
>     data pointer over to the backing command.
>   - Assign the translated write stream to every bio of a write, not
>     just the first one.
>   - Run the namespace lookup of the FDP commands under RCU.
>   - Report the FDP feature in the Features log page under the same
>     per-subsystem condition as the FDPS bit.
>   - Only emit the write translation tracepoint for writes that carry
>     the Data Placement Directive.
>   - Dispatch the I/O management commands after the persistent
>     reservation checks.
>   - Report backing command failures during the namespace enable as
>     errno, and clean up the backend state when the enable fails.
>   - Drop the Assisted-by: LLM tag from all commits.
>
> Guixin Liu (12):
>   nvme: add the FDP wire structures for the I/O management send command
>   block: add bdev_write_stream_granularity()
>   nvme: export nvme_bdev_ops
>   nvmet: add per-namespace FDP bridge state and configuration
>   nvmet: document the fdp_enable configfs attribute
>   nvmet: report the Endurance Group Identifier in the CS-INDEP identify
>     data
>   nvmet: advertise the FDP capability
>   nvmet: implement the FDP feature
>   nvmet: forward the FDP I/O management commands to the backing device
>   nvmet: serve the FDP log pages
>   nvmet: translate placement identifiers of writes to write streams
>   nvmet: add an FDP write translation tracepoint
>
>  Documentation/ABI/stable/configfs-nvmet |  13 +
>  drivers/nvme/host/core.c                |   1 +
>  drivers/nvme/target/Kconfig             |  14 +
>  drivers/nvme/target/Makefile            |   1 +
>  drivers/nvme/target/admin-cmd.c         |  45 +-
>  drivers/nvme/target/configfs.c          |  32 ++
>  drivers/nvme/target/core.c              |  43 +-
>  drivers/nvme/target/fdp.c               | 682 ++++++++++++++++++++++++
>  drivers/nvme/target/io-cmd-bdev.c       |  15 +
>  drivers/nvme/target/nvmet.h             |  91 ++++
>  drivers/nvme/target/trace.h             |  23 +
>  include/linux/blkdev.h                  |   8 +
>  include/linux/nvme.h                    |  24 +
>  13 files changed, 987 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/nvme/target/fdp.c
>


