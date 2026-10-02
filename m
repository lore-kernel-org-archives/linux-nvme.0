Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B4ECA5FC4
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2026 06:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Type:Content-Transfer-Encoding:Date:Message-ID:CC:To:From:Subject:
	Mime-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=GG2utD0f6nfLzMKJbhK02FJM4RaQ+X/fVsQucE2NZ8w=; b=P18ZkMrzwVhe2PvpjdG5wgvTMt
	dc45w1TkN7WahYddOj1LeU7nUhl1Lv1n/diNA48PgJWUAGh9EK14GVUDJPXDI1RTd7yO8E82+GUS3
	A97hNB0D2VN/cx9bO7M99ftOcVlmAH6PfWxDob1NCBdhQz3StCZ/3R2zC1qCZZ1sM2qpL9mDYSnS8
	I9/7W19ZAy0BV2NiDeONCFh25nwvWlN7KVds1nOvWaAZ58RO77rlbiRcowMN960T4xj2RPWJNgAi1
	SzrvJJInqeyp4OeQ2VeP1xcRUfMZSCYxSQxOgvJZ2GNgrvCOVvDcGqhy1dcqwzu413QSm9lK7C3l/
	qHUDNUZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCXFB-0000000Al8N-0WVE;
	Fri, 02 Oct 2026 06:59:45 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCXF5-0000000Al7m-2OfQ
	for linux-nvme@lists.infradead.org;
	Fri, 02 Oct 2026 06:59:44 +0000
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20261002065932epoutp02fd9c0b4238f53a258d49715098874039~apDpzer7I0280402804epoutp02M
	for <linux-nvme@lists.infradead.org>; Fri,  2 Oct 2026 06:59:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20261002065932epoutp02fd9c0b4238f53a258d49715098874039~apDpzer7I0280402804epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1790924372;
	bh=GG2utD0f6nfLzMKJbhK02FJM4RaQ+X/fVsQucE2NZ8w=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=TWHto4ce+XAmSsle7ZbNpB3gW+Giu5Y805/FQpHsrFuYuQOIGii+o1fq3HqkeMIvB
	 ZFoGW3jxRq3iff/5wob4GWedyMdytx9OXrEi4cjQvV8wvWguUA8/evckv0VwaMRF4c
	 EmakIfj2GyzEz3SajX9TCIDldr+hh5h0kZkeBtMw=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
	20261002065932epcas2p2295b2922d4ff7bb52a2d960b20c0c8a6~apDpHoXdW0630206302epcas2p2M;
	Fri,  2 Oct 2026 06:59:32 +0000 (GMT)
Received: from epcas2p3.samsung.com (unknown [182.195.38.209]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4hx05H4vHpz2SSKY; Fri,  2 Oct
	2026 06:59:31 +0000 (GMT)
Mime-Version: 1.0
Subject: [PATCH 0/2] nvmet: fix Reservation Acquire preempt sent by the
 holder
From: Daejun Park <daejun7.park@samsung.com>
To: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"kch@nvidia.com" <kch@nvidia.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "kanie@linux.alibaba.com"
	<kanie@linux.alibaba.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Daejun Park <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20261002065931epcms2p1cb2c16f98cf3b05f8c859ad92b0ad465@epcms2p1>
Date: Fri, 02 Oct 2026 15:59:31 +0900
X-CMS-MailID: 20261002065931epcms2p1cb2c16f98cf3b05f8c859ad92b0ad465
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261002065931epcms2p1cb2c16f98cf3b05f8c859ad92b0ad465
References: <CGME20261002065931epcms2p1cb2c16f98cf3b05f8c859ad92b0ad465@epcms2p1>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261001_235940_640185_A29CA815 
X-CRM114-Status: GOOD (  25.63  )
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
Reply-To: daejun7.park@samsung.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvmet_pr_preempt() does not follow NVMe Base Specification 2.1, section
8.1.22.7 when a Reservation Acquire command with the Preempt or Preempt
and Abort action is sent by the reservation holder and the reservation
is not of an All Registrants type.

Patch 1 fixes a use-after-free read in the path that handles a preempt
sent by the holder.  It does not depend on patch 2 and comes first so
that it can be backported alone.

Patch 2: a holder that preempts with the key of another registrant gets
a successful completion, but that registrant stays registered and the
reservation type is changed to RTYPE.  The pNFS SCSI layout server
fences clients with this command (RFC 9561 section 2.2.3), so on an
nvmet namespace nfsd logs a client as fenced while the client can still
write to the device.  The patch lists what changes for a host that
holds the reservation.

Not changed by this series: when the holder preempts itself,
registrants that share its key stay registered.  Case a) of section
8.1.22.7 unregisters them, but the paragraph about a holder preempting
itself lists three effects and does not mention other registrants, so I
left it alone.  The SCSI target removes them in
core_scsi3_emulate_pro_preempt().  I can send a patch if that is the
intended reading.

The series is based on the block-7.3 branch of the block tree at
684b413b5483, which has the current nvme fixes, and was tested there
with KASAN, PROVE_LOCKING and PROVE_RCU enabled, in QEMU guests, with
nvme-cli 2.8.  drivers/nvme/target/pr.c is the
same file there, in nvme-7.3, in nvme-7.4 and in mainline.  "before" is
that commit, "after" is that commit with both patches.  Each case was
run once unless noted.  The runs with the patches applied produced no
KASAN or lockdep report.  Mainline ce1e0223d8ad, which does not have
"nvmet: copy the hostid into the ctrl before creating PR pc_refs" yet,
gave the same results before and after.

1. nvme-loop, hosts A, B and C registered on one namespace with
   different keys, A holds the reservation.  "regs" is the number of
   registrants after the command.  EA-RO is Exclusive Access -
   Registrants Only, WE Write Exclusive, WE-RO Write Exclusive -
   Registrants Only, EA-AR Exclusive Access - All Registrants.

   reservation and command                     before          after
   EA-RO, A preempts key of B, same RTYPE      regs 3          regs 2
   EA-RO, A preempts key of B, other RTYPE     regs 3, type    regs 2, type
                                               changed         unchanged
   EA-RO, A preempts and aborts key of B       regs 3          regs 2
   WE,    A preempts key of B                  regs 3          regs 2
   WE-RO, A preempts and aborts key of B       regs 3          regs 2
   EA-RO, A preempts with PRKEY 0h,            success, type   Invalid Field
          other RTYPE                          changed         in Command
   EA-RO, A preempts with an unregistered      success         Reservation
          key, same RTYPE                                      Conflict
   EA-RO, A preempts itself with another RTYPE regs 3, type    same
                                               changed
   EA-RO, C preempts key of B                  regs 2          same
   EA-AR, A preempts key of B                  regs 2          same
   EA-AR, A preempts with PRKEY 0h             regs 1          same

   With EA-RO and WE-RO, writes from B succeed while B is registered and
   fail with Reservation Conflict once it is unregistered.

2. blktests nvme/054 passes before and after, with nvme-loop and
   nvme-tcp.  A test for the multi host cases is posted separately as
   "[PATCH blktests] nvme/071: test reservation preempt with multiple
   hosts".  It fails before and passes after (nvme-loop three times,
   nvme-tcp once, and both transports in one run).

3. pNFS SCSI layout.  An nfsd server exports XFS on an nvmet-tcp
   namespace to two clients, all nodes run the same kernel.  The server
   and both clients are registered, the server holds an EA-RO
   reservation.  Client 1 holds a layout and writes 1 MiB with O_DIRECT
   every 0.2 seconds.  Its network link to the server is then blocked
   while its link to the NVMe target stays up, and a local write to the
   file on the server recalls the layout.  The server write waits for
   the lease break time (45 seconds by default), then nfsd fences
   client 1 and logs "FENCED client[...]" in both cases.  The link is
   restored about 15 seconds after the fence, and the RPC counter is
   read when client 1 stops writing.

                                               before          after
   seconds the server write waited             49              49
   registrants after the fence                 3               2
   bytes client 1 wrote to the device in the
   10 seconds after the fence                  45088768        0
   WRITE RPCs sent by client 1 by the end      0               172

   After the fence client 1 logs "reservation conflict error, dev
   nvme0c0n1" and, once the link is back, sends its writes to the
   server.

   A run with the patches in which client 1 was cut off from both the
   server and the NVMe target gave 45 seconds, 2 registrants and 0
   bytes; the fence did not block on the unreachable client.

Daejun Park (2):
  nvmet: fix use-after-free of the old registrant in nvmet_pr_preempt()
  nvmet: fix preempt of another registrant by the reservation holder

 drivers/nvme/target/pr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


base-commit: 684b413b5483f57c890c171b9400076a0143b918
-- 
2.43.0

