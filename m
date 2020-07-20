Return-Path: <SRS0=fGVD=A7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED769C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 03:32:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE66A207EA
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 03:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sQZaVXEw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="J//Que1X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE66A207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vUN5EB/LK7bCxA+Abb0WPGT1SyniX8inkWPZD4vFFXw=; b=sQZaVXEw/VWp+9JQUwntl0CCZ8
	pAXIk9+TAjAK54E4kWGFU22yjajVrymyi05uiSP4NyjK27pkY0wUMJ2Ab/Pxc8RtJpn/ZsSr2c5rs
	OfrvBZClNqTkl0KgNCZN5Nip/uDBln+ucM/y+xhM0rauLWg0/8/ATlgRKB2xdga0bB21DTUu+oCn+
	Ix3npaXUQma488P1MefudbbCilJgcKElIFwZTWck0lVl85AWBAqUdMm+0UIH/iy5Idh4fo9z5jMCc
	ToJTrtYps0+o6AsmdTuDyCG4fQusB0tl6Gcbef55bIQ4vsFlk7M2fZbJnV5Rb+HC9rshcWAETQzF4
	H9D4XknA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jxMXZ-0002bx-I8; Mon, 20 Jul 2020 03:32:33 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxMXL-0002bH-QE
 for linux-nvme@lists.infradead.org; Mon, 20 Jul 2020 03:32:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1595215962; x=1626751962;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=3PTfu/pjwThogem+3YfMzU1AnWO9u3zgwnszgIS3450=;
 b=J//Que1XeP0rBYlLe1Fg8HvRcVKpcLmQrb0RdoDpGPo8vEUn9nzTLl1W
 z8546EcniE7co3xKUeLCbRUo1BW2a6nGkSGOVDLTV95UYr0LMWnsVlaKU
 D66dwny+W2AwT7Qtl1yHRtuiWo8bLDkFsM133RJxvFmIRy9Uei8iqgkiR
 WKbYGHRIBNN/U7AaspHPwyVTe8DQkhzXKJKUDEJVy/9ScOtG07pBxOvDs
 rzuL/NkkmVktjOPPG89KzLkiduMN/e11Wx+hu/WDl//raB1g1B8BAvL+S
 XvWV+pP3tJZb2Rc06BtZYdbhwiKCaTQZa+xQashSWIiTNj0PkNZLalVtu w==;
IronPort-SDR: PE2Cd5mkzgrrJnjjmTzw1cCv/9NYbTyfkuMvP6yyB679gXyLq5YltX2gJ8eocPrOdECt4QffKe
 W2lhwMkqHA/0xGtgYwEpKVn8B+cP5Q96BQo5KfYlc/IhkGMH7VzVCf9y9IDWKv/Zqthh9NOD0g
 e+qF56E7f4Nys8rM6WV2MUMifOHlHw6omh1Ez4WX+omrz/+gThCmZS7zewOGqvznngeQOXhgks
 7KvwEjfvLUZ6K2riTyhcro96DrKeyYNMtfYRXtGRD7xxCcZszJuO0Mrgk12Utwo4I5Ci2PlfmT
 ifw=
X-IronPort-AV: E=Sophos;i="5.75,373,1589212800"; d="scan'208";a="245915582"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2020 11:32:37 +0800
IronPort-SDR: 6dukQiY+DPUyzVQ9wVYHEIwJNcMSbqaao0AgLUgr4vmp7LcROOHgKeLandQgva4+mzKXObkhoo
 csEhdYoUM7k9sdutjoIllwnxddiWMHmys=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2020 20:20:35 -0700
IronPort-SDR: oYXANyCShUFXE6FwV/90U0z6KWRHowZ+ffJNrvw5E5MZgs9EYyR+pw0Mg08F1aMHMPby/eAcoE
 o+gCZOJ6uJJA==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Jul 2020 20:32:16 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH V4 0/2] nvme: use xarray for ns tracking
Date: Sun, 19 Jul 2020 20:32:01 -0700
Message-Id: <20200720033203.11474-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200719_233220_052992_F90CB3A7 
X-CRM114-Status: GOOD (  10.52  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

This patch-series uses ctrl->namespaces with an xarray for host-core and
target-core. We can see following performance improvement when running
fio with 32 parallel jobs where first 16 namespaces and last 16
namespaces are used for I/O using NVMeOF (nvme-loop) backed by nulli blk
devices mapped 1:1 on target namespaces.

For host even though nvme_find_get_ns() doesn't fall into the fast path
yet it does for NVMeOF passthru. This prepares us to improve performance
for future NVMeOF passthru backend which is under review which uses the
similar data structure as target.

Following are the performance numbers with NVMeOF (nvme-loop) backed by
null_blk devices mapped 1:1 on NVMeOF target backend :-

IOPS/Bandwidth ~16.4198% increase with XArray (higher the better) :-
-----------------------------------------------------------------------

default-1.fio.log:  read:  IOPS=820k,  BW=3204MiB/s  (3360MB/s)(188GiB/60002msec)
default-2.fio.log:  read:  IOPS=835k,  BW=3260MiB/s  (3418MB/s)(191GiB/60002msec)
default-3.fio.log:  read:  IOPS=834k,  BW=3257MiB/s  (3415MB/s)(191GiB/60001msec)
xarray-1.fio.log:   read:  IOPS=966k,  BW=3772MiB/s  (3955MB/s)(221GiB/60003msec)
xarray-2.fio.log:   read:  IOPS=966k,  BW=3775MiB/s  (3958MB/s)(221GiB/60002msec)
xarray-3.fio.log:   read:  IOPS=965k,  BW=3769MiB/s  (3952MB/s)(221GiB/60002msec)

Latency (submission) ~25% decrease with XArray (lower the better) :-
-----------------------------------------------------------------------

default-1.fio.log:  slat  (usec):  min=8,  max=26066,  avg=25.18,  stdev=47.72
default-2.fio.log:  slat  (usec):  min=8,  max=907,    avg=20.24,  stdev=7.36
default-3.fio.log:  slat  (usec):  min=8,  max=723,    avg=20.21,  stdev=7.16
xarray-1.fio.log:   slat  (usec):  min=8,  max=639,    avg=14.84,  stdev=1.50
xarray-2.fio.log:   slat  (usec):  min=8,  max=840,    avg=14.84,  stdev=1.51
xarray-3.fio.log:   slat  (usec):  min=8,  max=2161,   avg=15.08,  stdev=9.56

CPU usage (system) ~12.2807% decrease with XArray (lower the better) :-
-----------------------------------------------------------------------

default-1.fio.log:  cpu  :  usr=3.92%,  sys=57.25%,  ctx=2159595,  majf=0,  minf=2807
default-2.fio.log:  cpu  :  usr=3.98%,  sys=57.99%,  ctx=1565139,  majf=0,  minf=2425
default-3.fio.log:  cpu  :  usr=3.99%,  sys=57.85%,  ctx=1563792,  majf=0,  minf=2977
xarray-1.fio.log:   cpu  :  usr=4.47%,  sys=50.88%,  ctx=1810927,  majf=0,  minf=2478
xarray-2.fio.log:   cpu  :  usr=4.47%,  sys=50.88%,  ctx=1812184,  majf=0,  minf=2176
xarray-3.fio.log:   cpu  :  usr=4.49%,  sys=50.86%,  ctx=1816963,  majf=0,  minf=2736

For XArray helpers maybe we can do a separate series ?

Regards,
Chaitanya

* Changes from V3:-
-------------------

1. Get rid of the centralize helper for ctrl queue mgmt. 
2. Re-order patches and make nvmet patch first.
3. In the error patch for xa_insert() for nvmet patch restore subsystem
   max nsid and call percpu_ref_exit(). 
5. Ger rid of the rcu read_lock() and rcu_read_unlock() in
   nvmet_find_namespaces().
4. Remove an extra local varable and use ctrl->namespaces directly in
   host ns remove path.
5. Call nvme_nvm_unregister() when xa_insert() fails in nvme_alloc_ns().
6. Move xa_erase() call in nvme_ns_remove() before existing call to
   synchronize_rcu().

* Changes from V2:-
-------------------

1.  Add Xarray __xa_load() API as a preparation patch.
2.  Remove the id_ctrl call in nvme_dev_user_cmd().
3.  Remove the switch error check for xa_insert().
4.  Don't change the ns->kref code. when calling xa_erase().
5.  Keep XArray for deletion in the nvme_remove_invalid_namespaces()
    see [1].
6.  Keep XArray for deletion in the nvme_remove_namespaces() see [1].
7.  Remove randomly changed the lines to alingn the coding style in
    nvmet patch.
8.  Remove remaining #include nvme.h from the nvmet patch.
9.  Remove the xa_empty() from nvmet_max_nsid().
10. Centralize the blk-mq queue wrapper. The blk-mq queue related
    wrapper functions nvme_kill_queues(), nvme_unfreeze(),
    nvme_wait_freeze(), nvme_start_freeze(), nvme_stop_queues(),
    nvme_start_queues(), nvme_start_queues(), and nvme_sync_queues()
    differ in only one line i.e. blk_mq_queue_xxx() call. For the one
    line we have 7 functions and 7 exported symbols. Using a 
    centralize ctrl-queue action function and well defined enums
    represnting names of the helpers we can minimize the code and
    exported symbol and still maintain the redability.

* Change from V1:-
------------------

1. Use xarray instead of rcu locks.

Chaitanya Kulkarni (2):
  nvmet: use xarray for ctrl ns storing
  nvme-core: use xarray for ctrl ns tracking

 drivers/nvme/host/core.c        | 184 +++++++++++++++-----------------
 drivers/nvme/host/multipath.c   |  15 ++-
 drivers/nvme/host/nvme.h        |   5 +-
 drivers/nvme/target/admin-cmd.c |  17 ++-
 drivers/nvme/target/core.c      |  64 ++++-------
 drivers/nvme/target/nvmet.h     |   3 +-
 6 files changed, 123 insertions(+), 165 deletions(-)

-- 
2.26.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
