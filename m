Return-Path: <SRS0=Ayoq=4V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7960C3F2D1
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2020 15:08:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95DD220848
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2020 15:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jHUipoOy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bzeGNyRt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95DD220848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:In-Reply-To:
	Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=2jEOCmU+4W31qhY2ncr0I/iqTDg/ecVhZIz9kbjDAo0=; b=jHUipoOy6G75FB
	jaU/0UXzTvCPEBgWmdZilbMFD9cIy/CeBd97DBlt8MfH92g+iH7w6nOkxxFN08olVUk0Lc4g4ucXr
	KJZBTlqYQCM4qMyondE5tCzxe3puPZr+Tg7myVuv4R6fWJwB8Si0qFVvXnTsXT+qD0rLDchEpY6MP
	NH7J9i1bklxH0bf0aQwgnW6ZrTMQ6/HenSNvQdIL1RliAbsryn/rGdEyE/YfTJgBCTjzIYwcNoBDs
	5JEhRv8kDiWWt1k8AnpUYV8BDBIgDS2C3Qp6c9pIu81ngDoXpdubaGrAMOmhNYjhYZxrh8hpkxagB
	FMeawZJd5+3Udm4/2ZJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9VdE-0007rO-3V; Wed, 04 Mar 2020 15:08:20 +0000
Received: from us-smtp-2.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9VdB-0007pB-LP
 for linux-nvme@lists.infradead.org; Wed, 04 Mar 2020 15:08:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583334494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to; 
 bh=3xGgI8sfSL2n/t5ODky/G0EXz1SAoxfmmAhM3G4UcKQ=;
 b=bzeGNyRtUASLR+JWCX23DTseF+WVEElXfwzhxKwBj01QBvEKM+RgPuvpoiKTNBr+xO3xiv
 Im2rBPEFP/D9ODm96+02TJkXvDG/RXBbtGQJCmWqhmh8+5DGhyn4KaYUgMuh5NyfO71cMV
 LO9kKK6Yag/kHRnD2MwwR9/VUparys0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-FYxcXAHDPf6N5Ntz78jkhA-1; Wed, 04 Mar 2020 10:08:09 -0500
X-MC-Unique: FYxcXAHDPf6N5Ntz78jkhA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2DBC1005510;
 Wed,  4 Mar 2020 15:08:07 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D96D527186;
 Wed,  4 Mar 2020 15:08:07 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com
 (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id D012618089C8;
 Wed,  4 Mar 2020 15:08:07 +0000 (UTC)
Date: Wed, 4 Mar 2020 10:08:07 -0500 (EST)
From: Yi Zhang <yi.zhang@redhat.com>
To: linux-nvme@lists.infradead.org
Message-ID: <215235485.15264050.1583334487658.JavaMail.zimbra@redhat.com>
In-Reply-To: <716376633.15258107.1583333480546.JavaMail.zimbra@redhat.com>
Subject: [bug report] NVMe RDMA OPA: kmemleak observed with
 connect/reset_controller/disconnect
MIME-Version: 1.0
X-Originating-IP: [10.72.12.57, 10.4.195.5]
Thread-Topic: NVMe RDMA OPA: kmemleak observed with
 connect/reset_controller/disconnect
Thread-Index: 99D4Dl1h6+MRbOLniFqs0Ih/R1DLTA==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Bad-Reply: In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200304_070817_780183_4EE159A8 
X-CRM114-Status: UNSURE (   6.53  )
X-CRM114-Notice: Please train this message.
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
Cc: kbusch@kernel.org, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello

I would like to report a kmemleak issue found on NVMe RDMA OPA environment, here is the log, let me know if you need more info

unreferenced object 0xffffc90006639000 (size 12288):
  comm "kworker/u128:0", pid 8, jiffies 4295777598 (age 589.085s)
  hex dump (first 32 bytes):
    4d 00 00 00 4d 00 00 00 00 c0 08 ac 8b 88 ff ff  M...M...........
    00 00 00 00 80 00 00 00 00 00 00 00 10 00 00 00  ................
  backtrace:
    [<0000000035a3d625>] __vmalloc_node_range+0x361/0x720
    [<000000002942ce4f>] __vmalloc_node.constprop.30+0x63/0xb0
    [<00000000f228f784>] rvt_create_cq+0x98a/0xd80 [rdmavt]
    [<00000000b84aec66>] __ib_alloc_cq_user+0x281/0x1260 [ib_core]
    [<00000000ef3764be>] nvme_rdma_cm_handler+0xdb7/0x1b80 [nvme_rdma]
    [<00000000936b401c>] cma_cm_event_handler+0xb7/0x550 [rdma_cm]
    [<00000000d9c40b7b>] addr_handler+0x195/0x310 [rdma_cm]
    [<00000000c7398a03>] process_one_req+0xdd/0x600 [ib_core]
    [<000000004d29675b>] process_one_work+0x920/0x1740
    [<00000000efedcdb5>] worker_thread+0x87/0xb40
    [<000000005688b340>] kthread+0x327/0x3f0
    [<0000000043a168d6>] ret_from_fork+0x3a/0x50
unreferenced object 0xffffc90008581000 (size 36864):
  comm "kworker/u128:0", pid 8, jiffies 4295778075 (age 588.608s)
  hex dump (first 32 bytes):
    84 00 00 00 84 00 00 00 40 01 36 5d 84 88 ff ff  ........@.6]....
    00 00 00 00 00 00 00 00 00 00 00 00 40 04 00 00  ............@...
  backtrace:
    [<0000000035a3d625>] __vmalloc_node_range+0x361/0x720
    [<000000002942ce4f>] __vmalloc_node.constprop.30+0x63/0xb0
    [<00000000f228f784>] rvt_create_cq+0x98a/0xd80 [rdmavt]
    [<00000000b84aec66>] __ib_alloc_cq_user+0x281/0x1260 [ib_core]
    [<00000000ef3764be>] nvme_rdma_cm_handler+0xdb7/0x1b80 [nvme_rdma]
    [<00000000936b401c>] cma_cm_event_handler+0xb7/0x550 [rdma_cm]
    [<00000000d9c40b7b>] addr_handler+0x195/0x310 [rdma_cm]
    [<00000000c7398a03>] process_one_req+0xdd/0x600 [ib_core]
    [<000000004d29675b>] process_one_work+0x920/0x1740
    [<00000000efedcdb5>] worker_thread+0x87/0xb40
    [<000000005688b340>] kthread+0x327/0x3f0
    [<0000000043a168d6>] ret_from_fork+0x3a/0x50


Best Regards,
  Yi Zhang



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
