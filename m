Return-Path: <SRS0=DxE/=PW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69532C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 03:43:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 362A560E05
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 03:43:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 362A560E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=px09Mq8hurZCKugKSYoOdFg4hORTnaCBQzOYpg7lg30=; b=DmXORa9miie0wjSY3u5ifSb6bE
	l/bnlG3Yc/jpbd/EyJ+gZI6FiHDVbRAqy5gKXdvmtw8ehWahhs9YMfI5GZCxuboXpRJUpgnv+88dg
	61RqI9rn4bOZ60m/BTxxOocbNQgoXuaoa8pqcMhynDOtDqNRH8s4loaujp0RLzoCUJGBmIJqbt6Cq
	CSwuoKDlG1swU9096OMnO1kTuVBFFyBcy3g/VKuuAjXnFAPo7PaBflQIlxeIR6tpY6fO2kPoE3jtu
	q/0MEHo0Dd1IQ8DpAhJsBffuvXzxeRCDg/RD3l+Iz950Qm4AuGtorCmAPIAdulzcbcu3rZ4u6fzQv
	kls9AQmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mi7Bk-003ym2-Tr; Wed, 03 Nov 2021 03:43:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mi7Bi-003yl8-6X
 for linux-nvme@lists.infradead.org; Wed, 03 Nov 2021 03:43:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635911024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=px09Mq8hurZCKugKSYoOdFg4hORTnaCBQzOYpg7lg30=;
 b=JHDmzTNLat0kpLj+/uurY4wmiEhMSqvDQPKEm8YVIVfsmjRauYmd10Rz8g8nuMGEZlclOO
 QFEFE0/rP1zEp7W4H515NfLHAbRIAmSNT/FK5zBy5QG3X1TTn1nml5AXZnNXYl2/l5NMBl
 D1GxT8DnMU1JL2pZLhtGMK18zhJomo4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-GZOikcS0PCKtNshaKXE8AQ-1; Tue, 02 Nov 2021 23:43:41 -0400
X-MC-Unique: GZOikcS0PCKtNshaKXE8AQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 406E380EFBD;
 Wed,  3 Nov 2021 03:43:40 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA95D5D9D3;
 Wed,  3 Nov 2021 03:43:31 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/4] block: fix concurrent quiesce
Date: Wed,  3 Nov 2021 11:43:01 +0800
Message-Id: <20211103034305.3691555-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211102_204346_346261_0988ED00 
X-CRM114-Status: GOOD (  10.10  )
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

Hi Jens,

Convert SCSI into balanced quiesce and unquiesce by using atomic
variable as suggested by James, meantime fix previous nvme conversion by
adding one new API because we have to wait until the started quiesce is
done.


Ming Lei (4):
  blk-mq: add one API for waiting until quiesce is done
  scsi: avoid to quiesce sdev->request_queue two times
  scsi: make sure that request queue queiesce and unquiesce balanced
  nvme: wait until quiesce is done

 block/blk-mq.c             | 28 +++++++++++++------
 drivers/nvme/host/core.c   |  4 +++
 drivers/scsi/scsi_lib.c    | 55 +++++++++++++++++++++++---------------
 include/linux/blk-mq.h     |  1 +
 include/scsi/scsi_device.h |  1 +
 5 files changed, 59 insertions(+), 30 deletions(-)

-- 
2.31.1


