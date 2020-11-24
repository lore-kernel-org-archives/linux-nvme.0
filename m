Return-Path: <SRS0=KsQz=E6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029D0C63697
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2020 01:05:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B0402073C
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2020 01:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HsJwtH7l";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKdyx6lo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0402073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9KDXtY6EYqPspleogb76whFWt2Fs/0NuJPEIFm1c368=; b=HsJwtH7luKZCxAjCMuOXvaRPg
	G6YlKbSrNNJbKVbf7lDW18coMqV7QsXF9NCbdITosqp+FjefQ8CUFGvWL3oDMNgZxaqTecSrCst7Q
	EiCuURz9UepxcrSbH4g0nm/fNnRX6ZLCZN5GLLVAbymNJOiRXnM/ZHCRhLwg5aE5PI+t6K6lrWlws
	KTulmxGnaUXaSRCTv+8tp9kyVqfmBwVWT2rlLIPV8eee31Iqaky9muKeJDr4DGuvXSWzNKiAELZ8c
	vTVE1l/2BCuq9Ix+WFNBJcAsyY9swFhD7hmBWXPYuQtgs8fJv857QD/HA8SVzhjkr65iH0/MnXiQg
	bf42qSSDg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khMlc-0005gE-9G; Tue, 24 Nov 2020 01:05:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khMlX-0005eW-SC
 for linux-nvme@lists.infradead.org; Tue, 24 Nov 2020 01:05:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606179907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Meb8VBRdNpLl6eh22OMMs7hFvb4+eceBdMv99rKjoOI=;
 b=UKdyx6lor5Uyq/d1pgtfA+VagYvPM6vzvYiP+wO4b2hFEQ+HSzJBPnA/B452PGuRRSJwi4
 fT7P1/QBCEYYlfmoMDBpqv9WEVBcXUVjnGH3s41hv7265VZYRW7s++MTqr4ryooxwJvdhj
 ubjTeNcfaTB246knIQflPVJ24etMNNk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-D75VfgFXM_a0uzWhw-xDLQ-1; Mon, 23 Nov 2020 20:05:04 -0500
X-MC-Unique: D75VfgFXM_a0uzWhw-xDLQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF7B718C43C7;
 Tue, 24 Nov 2020 01:05:03 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D8AF81346D;
 Tue, 24 Nov 2020 01:05:01 +0000 (UTC)
From: Yi Zhang <yi.zhang@redhat.com>
To: osandov@osandov.com,
	bvanassche@acm.org
Subject: [PATCH blktests 5/5] common/multipath-over-rdma: allow to set use_siw
Date: Tue, 24 Nov 2020 09:04:27 +0800
Message-Id: <20201124010427.18595-6-yi.zhang@redhat.com>
In-Reply-To: <20201124010427.18595-1-yi.zhang@redhat.com>
References: <20201124010427.18595-1-yi.zhang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201123_200508_026446_A0F45C2E 
X-CRM114-Status: GOOD (  12.26  )
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
Cc: linux-block@vger.kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

With this change, we can change to use siw for nvme-rdma/nvmeof-mp 
testing from cmdline:

$ use_siw=1 nvme-trtype=rdma ./check nvme/
$ use_siw=1 ./check nvmeof-mp/

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 common/multipath-over-rdma | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index ebc5939..d0fec6f 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -12,7 +12,7 @@ filesystem_type=ext4
 fio_aux_path=/tmp/fio-state-files
 memtotal=$(sed -n 's/^MemTotal:[[:blank:]]*\([0-9]*\)[[:blank:]]*kB$/\1/p' /proc/meminfo)
 max_ramdisk_size=$((1<<25))
-use_siw=
+use_siw=${use_siw:-""}
 ramdisk_size=$((memtotal*(1024/16)))  # in bytes
 if [ $ramdisk_size -gt $max_ramdisk_size ]; then
 	ramdisk_size=$max_ramdisk_size
-- 
2.21.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
