Return-Path: <SRS0=LBLG=7C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B8FC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 11:57:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE593206BE
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 11:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="alc65vLf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DSU8JUss";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bvdwDNpD";
	dkim=neutral (0-bit key) header.d=redhat.com header.i=@redhat.com header.b="R6PVeLKJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE593206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=6RLy9VJjTuq5hoKatbocVOHSuu2LVZZ+ViKdIA9yIXU=; b=alc65vLfIzUVVt
	a3jehuMVXCFvvFZMqJK7T63DIMvzjwmbauoyPFxh5MtgWPg7LZ3mhbt/GFH+MlVtdmJ4Z8knzWv2W
	m06ooAduz/8HQeanplMIeJ68wbI4lXhW264s6VPBi79xbHnw7flNUSwmx4tLgv/U3uHkbpmVPGIWa
	P/UmGva+QvYKke0euBmISwJqMPfeC41Y0GKYzm8rjRYcFTibGa8Ee2tX7OooH8Xle1b2RIG5/44bc
	vPTpckhsiEJTyx5WlgH7+hkO7fSYtNtYQuyj0+Q0CA3uS41LK2bWQlX53P3D4sm6DIMZKKeI4UXLy
	M1cvgMupKPRP6oV1w4wg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbNLr-0007p0-05; Wed, 20 May 2020 11:57:35 +0000
Received: from merlin.infradead.org ([205.233.59.134])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbNLp-0007oh-0H
 for linux-nvme@bombadil.infradead.org; Wed, 20 May 2020 11:57:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=JWKpeI2C0LFWENZuWWHrgdjnNtpXaqQRftbElmCVxzo=; b=DSU8JUssXINEyU7f7fP3u3u5rr
 sUlH1JSMHZKfMLpW2sIq07qSNiOsC8tZrjftDh3/ASOSrmYRomgiJ/wONtyeIp70b5tMxK+qV0yOa
 bqn+0Or1Bdwvg6xbQOctjDTT23hF7EUuXUhB1SaXh0Zul8d5b69vtq65ePAV9Tv/z3FsdaCysrFY7
 4ji4mRVt911qRRXjARIqS9nJ9z++8uqc/nbb4F/JgoQ0p1j74gTbxBiMDch4gL/9EESvfe4sm9eex
 D+ywSEQiSUOa4O4DUm+aHrd33pNtZ/9inHpNEMo+dxFYMHnf5+LKr24VD/7Z7iKpM9HySqizQsUJ3
 S/eb5Brw==;
Received: from us-smtp-2.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbNLm-0007NI-Hh
 for linux-nvme@lists.infradead.org; Wed, 20 May 2020 11:57:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589975829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=JWKpeI2C0LFWENZuWWHrgdjnNtpXaqQRftbElmCVxzo=;
 b=bvdwDNpDKEYdak4sNkl+CIenja4luafVadDTolamkqLOa2kzuOMjS4b3ulw58vtpxlM6RT
 iIAjoSmW9bKsnhmeiJVIBorpyD1mF6EOjwetjU9D5DZZOkPZ4zGA4keeSQF9fFVONN6zGt
 k9/An2g7gftD6usxMd/j39fkMYK56WA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589975847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=JWKpeI2C0LFWENZuWWHrgdjnNtpXaqQRftbElmCVxzo=;
 b=R6PVeLKJBN4s+pOSHl3PrbJC5bSsiqUnh2uWOyqruncuHEdjYNN26h/KSZkTKgzsoCxyGw
 z3QEKFNBCClGcgMy1sjeiCIxepHM9wR9DAAt4acfy62Srp5Xa+X38fT7cmOCBeZXmTx7Ts
 DlyYYK29fhAHTyhknAdLYuF5rowIWFU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-Zzur8L-IMkCPg4VnBMCFmA-1; Wed, 20 May 2020 07:57:07 -0400
X-MC-Unique: Zzur8L-IMkCPg4VnBMCFmA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76BB5107ACCD;
 Wed, 20 May 2020 11:57:06 +0000 (UTC)
Received: from localhost (ovpn-12-81.pek2.redhat.com [10.72.12.81])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8583819C4F;
 Wed, 20 May 2020 11:57:02 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/3] blk-mq/nvme: improve nvme-pci reset handler
Date: Wed, 20 May 2020 19:56:52 +0800
Message-Id: <20200520115655.729705-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Cc: Alan Adamson <alan.adamson@oracle.com>, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

For nvme-pci, after controller is recovered, in-flight IOs are waited
before updating nr hw queues. If new controller error happens during
this period, nvme-pci driver deletes the controller and fails in-flight
IO. This way is too violent, and not friendly from user viewpoint.

Add APIs for checking if queue is frozen, and replace nvme_wait_freeze
in nvme-pci reset handler with checking if all ns queues are frozen &
controller disabled. Then a fresh new reset can be scheduled for
handling new controller error during waiting for in-flight IO completion.

So deleting controller & failing IOs can be avoided in this situation.

Without this patches, when fail io timeout injection is run, the
controller can be removed very quickly. With this patch, no controller
removing can be observed, and controller can recover to normal state
after stopping to inject io timeout failure.

Ming Lei (3):
  blk-mq: add API of blk_mq_queue_frozen
  nvme: add nvme_frozen
  nvme-pci: make nvme reset more reliable

 block/blk-mq.c           |  6 ++++++
 drivers/nvme/host/core.c | 14 ++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  | 37 ++++++++++++++++++++++++++++++-------
 include/linux/blk-mq.h   |  1 +
 5 files changed, 52 insertions(+), 7 deletions(-)

-- 
2.25.2


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
