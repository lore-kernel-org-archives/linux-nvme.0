Return-Path: <SRS0=8PNV=AM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA67DC433DF
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 17:42:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A6B4207CD
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 17:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0OjoVRLY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5kOYeqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A6B4207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kgzWI9V3i/Tax2CA1qTx1eanhkBZZN0pcJWGFie3b8k=; b=0OjoVRLYonnUhp2XYyabASBXQt
	3FWnKrZ671jGLGwR0R3oImRzI0uH08gekhFTJIqyNbZCdor67Rppl4AcvtelPvdLkGWHXhAZQrU0n
	rYGMMh2X6RQu3qV5l1kyN9+R7pqAhpdYKO+m4/NwLpRx1iDjYlvoVmRC7GUq4QTZ3KdlZ1DyWYM+o
	p6jNS4lDVy8mDpJ+ifUaFelSVq5u7sD0tdEPivd6aFdlfNeUrhq/RPFb9ZhOGtkeyDKIXwKkQJtyO
	xBOw98NYXLdAwQ/3QEd9d8waD46x4ffvTfBbFOIrlz67R/nOcoNaYEjd09sTG7x72itRpzr7bhrEj
	HNUxYrdg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqgkv-0002ov-P8; Wed, 01 Jul 2020 17:42:45 +0000
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqgku-0002oT-26
 for linux-nvme@lists.infradead.org; Wed, 01 Jul 2020 17:42:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593625363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=tXKGxpnc5BMs3iDgwihQRstOyMb/SsOmJWMhA/a2H4Q=;
 b=O5kOYeqtjRxM2zg/VclOHx86KUoM4NCpckR3W/C+EgMnCAYV208AMD4NQJsq5n/on3zqtk
 vvVYtkKRUmZLV9WxNhKPO8HFlqLsKz8SAVL1B7U+9/rXAZ4RCMvaXU7S4/0e3ohS2K5UXQ
 1oXRo1rLNiJ5ks1GMxGkHrqliehPz90=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-Jk4wup8QPmylhlXZ_xTslg-1; Wed, 01 Jul 2020 13:41:07 -0400
X-MC-Unique: Jk4wup8QPmylhlXZ_xTslg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB355107ACCD;
 Wed,  1 Jul 2020 17:41:05 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 93E7D5C6C0;
 Wed,  1 Jul 2020 17:41:02 +0000 (UTC)
Date: Wed, 1 Jul 2020 12:39:42 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: NVMe regression, NVMe no longer uses blk_path_error()
Message-ID: <20200701163942.GB27063@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200701_134244_294576_E77EDCED 
X-CRM114-Status: UNSURE (   9.08  )
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
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 dm-devel@redhat.com, Hannes Reinecke <hare@suse.de>,
 John Meneghini <johnm@netapp.com>, Ewan Milne <emilne@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

IF NVMe's isn't a primary user of blk_path_error() it largely kills
the entire point of blk_path_error(). (And no the response to this must
not be: "that's fine")

This commit shows NVMe's previous continued use of blk_path_error():

  8decf5d5b9f3f7 ("nvme: remove nvme_req_needs_failover")

but then nvme_failover_req() was relatively recently refactored with:

  764e9332098c0 ("nvme-multipath: do not reset on unknown status")

NVMe should've continued to use blk_path_error().  If there was some gap
in error classification that should've been fixed in NVMe.

Instead, with commit 764e9332098c0 NVMe is no longer using retryable
error classifications commonly maintained within block core.  As such it
introduces serious potential for regression with DM multipath no longer
having a shared understanding for what _really_ constitutes a retryable
blk_status_t from NVMe.

Mike


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
