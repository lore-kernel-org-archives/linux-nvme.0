Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DFDC3F6B0
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Aug 2022 15:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=db+1G5s5YET1/p3WZ+miCXoDDQtDBuTM6gOqjL2mgtM=; b=L0AyIhQ5RV5NMV3VgQ2o40WBkd
	5r2TRILhCCFSQDr1ZUT+PGsx7Ohok40GUuI3WXfnS3PlOGADC0DHoG0U+icxTwLJLisf2106HEzAR
	D3cR4rprGn+SR2tXju2oxaqVGRr2vZr/rQpX8lUbOZPbKciPHUAQb5WcngZKxFp7695FAQRfWNCVz
	X6up6fz9FSEWpm7897IOW7pGrs6GJUyIN+dR9qGa4BrJdypVNABfnnDdOiQGNFD93VDJngDXhaRbm
	T4BGhIMvh1p5Qc2tNL2fBPBGUxJ9PK5Omn2wDu5X0gcymP/13YVIkUTthlxiQitVX9UnnswNp45KL
	WhU5IZaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNc24-000sDC-R3; Mon, 15 Aug 2022 15:29:36 +0000
Received: from mga14.intel.com ([192.55.52.115])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMzBY-000TIE-MQ; Sat, 13 Aug 2022 22:00:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660428048; x=1691964048;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J2stkkYmPik2bQMds1PPTKQFWYY4K6w3/+pjsawBn4I=;
  b=bgxIXp/xs6uqFfuM6aAWeTAoUIo1/VNWQ6sXhCQ1i4dMlgfFeE9h0qQB
   5zs/rFahDROxg4W15UVWXO0hHmUrz8kHLF9CDRMc6hcafEqXJq1FyK+8m
   p+dXT1NlM83o/3eDKqDGK9MZ+6RLlClAGL2FNEJanAXecp4YmHZ0lC83Q
   QMs+bC97GQslZQouN58C80Ugw1tJEpcbNL42y/xHFOiE00cDvffvMJ2HZ
   VYTRsIPbu+aKBA1HtjsBeIKsJ/jgtdwj4JScBynUXhl2ycUHdS1VMUaZO
   Wg8VYDh3IwNX281LAoscoFBcV5GJCtyKch5RXH5u/h+mQIAv1UZj8e6tl
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="291778709"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="291778709"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 15:00:42 -0700
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="635047705"
Received: from tsaiyinl-mobl1.amr.corp.intel.com (HELO localhost) ([10.209.125.19])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 15:00:40 -0700
From: ira.weiny@intel.com
To: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>
Cc: Ira Weiny <ira.weiny@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	linux-xtensa@linux-xtensa.org,
	keyrings@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net,
	dri-devel@lists.freedesktop.org,
	dm-devel@redhat.com,
	linux-raid@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	netdev@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net,
	iommu@lists.linux.dev,
	bpf@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH] checkpatch: Add kmap and kmap_atomic to the deprecated list
Date: Sat, 13 Aug 2022 15:00:34 -0700
Message-Id: <20220813220034.806698-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220813_150048_831036_70734D68 
X-CRM114-Status: GOOD (  12.91  )
X-Mailman-Approved-At: Mon, 15 Aug 2022 08:29:34 -0700
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

From: Ira Weiny <ira.weiny@intel.com>

kmap() and kmap_atomic() are being deprecated in favor of
kmap_local_page().

There are two main problems with kmap(): (1) It comes with an overhead
as mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when
the kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

kmap_local_page() is safe from any context and is therefore redundant
with kmap_atomic() with the exception of any pagefault or preemption
disable requirements.  However, using kmap_atomic() for these side
effects makes the code less clear.  So any requirement for pagefault or
preemption disable should be made explicitly.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again,
the kernel virtual addresses are restored.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Suggested by credits.
	Thomas: Idea to keep from growing more kmap/kmap_atomic calls.
	Fabio: Stole some of his boiler plate commit message.

Notes on tree-wide conversions:

I've cc'ed mailing lists for subsystems which currently contains either kmap()
or kmap_atomic() calls.  As some of you already know Fabio and I have been
working through converting kmap() calls to kmap_local_page().  But there is a
lot more work to be done.  Help from the community is always welcome,
especially with kmap_atomic() conversions.  To keep from stepping on each
others toes I've created a spreadsheet of the current calls[1].  Please let me
or Fabio know if you plan on tacking one of the conversions so we can mark it
off the list.

[1] https://docs.google.com/spreadsheets/d/1i_ckZ10p90bH_CkxD2bYNi05S2Qz84E2OFPv8zq__0w/edit#gid=1679714357

---
 scripts/checkpatch.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 79e759aac543..9ff219e0a9d5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -807,6 +807,8 @@ our %deprecated_apis = (
 	"rcu_barrier_sched"			=> "rcu_barrier",
 	"get_state_synchronize_sched"		=> "get_state_synchronize_rcu",
 	"cond_synchronize_sched"		=> "cond_synchronize_rcu",
+	"kmap"					=> "kmap_local_page",
+	"kmap_atomic"				=> "kmap_local_page",
 );
 
 #Create a search pattern for all these strings to speed up a loop below

base-commit: 4a9350597aff50bbd0f4b80ccf49d2e02d1111f5
-- 
2.35.3


