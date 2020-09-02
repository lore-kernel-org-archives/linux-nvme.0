Return-Path: <SRS0=9ikG=CL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0EBC433E2
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 22:43:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB86920758
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 22:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W5LfAMYF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dC0amYAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB86920758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6v9qrjmX4c1TzGTJ8P+SdECflPaYuvZkjscudKUKg/I=; b=W5LfAMYF3uRm2qhOmKymmA9Q54
	3iPxFNwVV62RfJhe/1yZ11HRTgHTtHWtlfrwpXEeRZBpYLqfkEhYdFB+AjxxeKvjrSwlKPuTjd3lY
	8Z1sjYyx/aZQuRu4F8wDitB2CenVuD7izgVlE5chXo4yAqWIhirueBZatT/BuWiRrx/XqqeHG9v4W
	53CLT6QMy69+CEwK9K1BlBW/TAMqpVng6jY22x/q1A8pVTYaWrSutosE8qt3Xug/gfjIAozAa38xR
	G0dYFUU/BNz87KdQ3TdZT7h2tIXgjTLgl0odJUVB51FZnIb5oAjZQdRz+BQ2BcPiwD4ON7WeikFOT
	0JOJy+Sg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDbT7-0006kr-HU; Wed, 02 Sep 2020 22:43:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDbT3-0006jP-Ni
 for linux-nvme@lists.infradead.org; Wed, 02 Sep 2020 22:43:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type;
 bh=M/aHiqDJD4HbhMjzXQ2MJBo3VtBEcnpWP52JdoI5icg=;
 b=dC0amYAk5b93eyo5bcDch8YxbMzF+4adCGiNEUb4CB9+ViUrAdymnRp/DzUW1MkLuqVApw
 1GcqsYap++nriavtSEQVXTf8J4rpayf9p2EbXrHK1HvcmYx10QEi+ywmpqC53kwLXyog48
 af4LAIThJJ3YXBqVhzE38lkI6IhTd1w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-_Vtc48ylM7-ykJKsUsgJVg-1; Wed, 02 Sep 2020 18:42:57 -0400
X-MC-Unique: _Vtc48ylM7-ykJKsUsgJVg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E865F8030C7;
 Wed,  2 Sep 2020 22:42:55 +0000 (UTC)
Received: from hpz440.redhat.com (ovpn-113-131.rdu2.redhat.com [10.10.113.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E07C360C0F;
 Wed,  2 Sep 2020 22:42:54 +0000 (UTC)
From: David Milburn <dmilburn@redhat.com>
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 james.smart@broadcom.com
Subject: [PATCH v3 0/3] nvme: cancel async events before freeing event struct
Date: Wed,  2 Sep 2020 17:42:51 -0500
Message-Id: <1599086574-85969-1-git-send-email-dmilburn@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dmilburn@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200902_184301_855549_4404D100 
X-CRM114-Status: UNSURE (   9.94  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cancel async event work in case async event has been queued
up, and transport trys to submit event after it has been freed.

David Milburn (3):
  nvme-rdma: cancel async events before freeing event struct
  nvme-tcp: cancel async events before freeing event struct
  nvme-fc: cancel async events before freeing event struct

 drivers/nvme/host/fc.c   | 1 +
 drivers/nvme/host/rdma.c | 1 +
 drivers/nvme/host/tcp.c  | 1 +
 3 files changed, 3 insertions(+)

-- 
2.18.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
