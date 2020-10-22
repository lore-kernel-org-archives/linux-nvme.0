Return-Path: <SRS0=3deH=D5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D43C2D0A3
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 01:02:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 088AF223FB
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 01:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="wfKxnaQJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="k14Uijum"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 088AF223FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xfljnMHnpccPjIlw0pJKvF2LHKjXogkD7wRvci1U/4A=; b=wfKxnaQJDk7CNItDM/IgtIl4i/
	UZmc9P+pdinGehbDa9mkmoO8RHR1VdJBgau8ySC5J20mBSPagvgeNRpt/PWl0t+MLV3+UlCt8W+Tu
	D9RnES4e3j7Q7Jqhxirg7hgMawOazKQOlAw6SfbHx4x36DbwswaFe8xzOM3KPYfx/l1Kq3/X3WKpI
	hGQMc7U0QMH7+8dWf8TqSCBuX6iZqOaTlnsfojgDrheATgQQ7cX5Bg/9jec4DSifCjCW3J6nXennS
	HesOrma2aN2/xY5oHaska6sBKgi5uVr/d79P3Y2K01ZaZxevDWjz63jStJFvx0TCEvxEI4enxFcjT
	ULaaK+EA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVP06-00043d-JH; Thu, 22 Oct 2020 01:02:42 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVP04-00043D-9O
 for linux-nvme@lists.infradead.org; Thu, 22 Oct 2020 01:02:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603328561; x=1634864561;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=km+hZ7YgGfWW2fRnp+dFWSxQXntiG3Omd9A/wctZwuk=;
 b=k14UijumNB7iMIKeoA6CvVHobas9bd0kv9Cnd+BWvoBaxKWRI2CXNc6a
 Nq9LsPPWio7oIcPLdc5HqAGH63gT5O5eG+WeqfoDMaJi424ck/MoE8YKi
 E2aUs1DtjUtHGJlPac/YsGSpejeeh1nEDW7OUYk92pLWMszKsJk8Du8Y5
 n6bX5D1yh8HUYngkB1lpo7D8TJKUp3PPaZ5ywMYmp+/r6jKeQlURImXta
 qKr3jqX0IxQnjnbmwwfo+Jk3wadVBPlz5HerlmOxnIrK9G92fX20ZPmwv
 3gtXW2Iw9gFRXpsXiJWPSevpWPUt0vmP0ATXTUfAB7an3DbMBVqCPKdb9 w==;
IronPort-SDR: QETOInZl5ZIEZWj9DhKuaaDI/FO9XB5QWeK5I8/a8oFCanuz1sZHUWpgIaG4fCPM2zhGkls3wV
 pxK/NEKX7mx5XUPmDWFfvQspYSCTRr8OrzNTqdtVH2F97SjbEN4Qep8SJ0gSTeI68pg8Qhh3F+
 g9B66WC//ZJ8FIgkuLjOzd1VAWcYe1OHi2PImx/vqYOI/cEu7vICkIpLTeKYO147cDdLrTKIJ6
 qilnxidPV8r7EjtkRPZsgz6W1Q1ux+bWlBzzv2RdIwN7rf/ZS+JmRkOEKdT0XEPf54qLeRxT2x
 7P0=
X-IronPort-AV: E=Sophos;i="5.77,402,1596470400"; d="scan'208";a="155006279"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2020 09:02:37 +0800
IronPort-SDR: RRJI4ZHK8BWW84MUR29bIMhlqvhBsuCVWPa0p6ddOwooGJU6VJMYy6VSAYjpprxG2CYIm28cmH
 0y/pW0HvdLrxV/+SNKot5fQAh17Z6whA8dCmRNwadelJGhf2lkN2DyfX/qGHzV7G43nTWAAOdV
 5nXjbOy9OBK5sQModJ5nV8Bvg+3ByAJJoiOY8nlXs/PYcnsF7QxJ5kJ67AZGFkvHZDKO+wk1+n
 SG+1x32Yq3avwOUWTTYCj6rFVYu71do6XxLLbVbv6/fJZtCYJ7GrtXX6K3tTWivDXgblVQoODz
 1mcerxE2M4GFWhANlmc7PsDL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2020 17:48:09 -0700
IronPort-SDR: /8X3iiyhNko2O9XhVlOWJLTnyXHM4dt+AnycPBTdR01RqFcW+xw/z43tcJjS9gZzjXds8a7mFX
 BLwtZf8aXSRCmImTsreXl4a7dI2uFGOywEcyvd5V3LMaGQEM24UvkyFRuk0Q7f/rEc7Ej2ewhm
 SOTds3MEEOBNcbyGY6I2nYjTMCNgKgdZIxfQXzt1iX1urmjaVoUEzSrXikvZQ6JFFHSh1AZKuT
 Z3PTWPPvptkF9N9OjgwWGSNzmpXrc/W3yuBbFuQFO6lYT3pviQK7ic1uRn+r7yxYqktNXuktxI
 JkY=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 21 Oct 2020 18:02:37 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V3 0/6] nvmet: passthru fixes and improvements
Date: Wed, 21 Oct 2020 18:02:28 -0700
Message-Id: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201021_210240_475517_AF54A242 
X-CRM114-Status: GOOD (  12.97  )
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
Cc: kbusch@kernel.org, logang@deltatee.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

This patch series has several small trivial fixes and few code
optimizations.

Regards,
Chaitanya

Changes from V2:-

1. Remove "nvme-core: annotate nvme_alloc_request()" patch and
   split the nvme_alloc_request() into nvme_alloc_request_qid_any()
   and nvme_alloc_request_qid() with addition of the prep patch for
   the same.
2. Remove the cleanup patches and trim down the series.
3. Remove the code for setting up the op_flags for passthru.  
4. Rebase and retest on the nvme-5.10.

Changes from V1:-

1. Remove the sg_cnt check and nvmet_passthru_sg_map() annotation.
2. Add annotations and performance numbers for newly added patch #1.
3. Move ctrl refcount and module refcount into nvme_dev_open() and
   nvme_dev_release(). Add prepration patch for the same.
4. Add reviewed-by tags.

Chaitanya Kulkarni (6):
  nvme-core: add a helper to init req from nvme cmd
  nvme-core: split nvme_alloc_request()
  nvmet: remove op_flags for passthru commands
  block: move blk_rq_bio_prep() to linux/blk-mq.h
  nvmet: use minimized version of blk_rq_append_bio
  nvmet: use inline bio for passthru fast path

 block/blk.h                    | 12 --------
 drivers/nvme/host/core.c       | 56 +++++++++++++++++++++++-----------
 drivers/nvme/host/lightnvm.c   |  5 ++-
 drivers/nvme/host/nvme.h       |  4 +--
 drivers/nvme/host/pci.c        |  6 ++--
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/passthru.c | 38 +++++++++++++----------
 include/linux/blk-mq.h         | 12 ++++++++
 8 files changed, 81 insertions(+), 53 deletions(-)

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
