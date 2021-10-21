Return-Path: <SRS0=gxeb=PJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2056CC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Oct 2021 08:42:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E51F2610C8
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Oct 2021 08:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E51F2610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=l9RX0S18wqyMTJKUQxPMNJT0M7dLl1Ze2FH11SX8jYM=; b=q+P1LXiA9qx7BGtl+e6BryCJY4
	9RFOl72gGPl9M1YyEliQmvb/j+veUt4iGxH88fQbQyqvycolCaSEkFptOx4Ou4cCjSZwcTG6FgAwR
	stKXzuPDUlZ0Ml/pn4XqpicBzOCHfrGZlhYRYYENfmKtR3aVNGcVSKMaRagVTF2GMdmq+4KouZMh7
	yq0RNypJOzDXUyWp54X8EdDveQRNBPV7mkIfKjJhW7Q84N1Le736kWC4euG76K5oUz84R3QyGhrUR
	BcNoQIZDjYdspsH2h9SIIiSU4uJY1yh/4UCOzDvpZUm0P/mmtlvKnnx17n++4FE39WKwcr32wvIe7
	udFHTJFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mdTeU-006s1b-C8; Thu, 21 Oct 2021 08:42:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mdTeL-006rzg-Qh
 for linux-nvme@lists.infradead.org; Thu, 21 Oct 2021 08:42:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634805727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=l9RX0S18wqyMTJKUQxPMNJT0M7dLl1Ze2FH11SX8jYM=;
 b=Bez7eCzXcj1A3eKfn8fJ9sO0BF/9lNt5oHCO7PZBJJ2dVvFFXxctlXul9Za7sEE48qURnJ
 kEe1jlmNzni44i4LOIf7ifgA59Pxiqzn/cIC4BaBcPHbH0QK3UiA9362BFhDHjtTPZG5m6
 hvYsAIYYD1h5FR79YHY+DxLJ4FeKK6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-uwo-EYE5P8-wa-i755ejyQ-1; Thu, 21 Oct 2021 04:42:01 -0400
X-MC-Unique: uwo-EYE5P8-wa-i755ejyQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2968F1006AA5;
 Thu, 21 Oct 2021 08:41:59 +0000 (UTC)
Received: from raketa.redhat.com (unknown [10.40.193.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 34FE319D9F;
 Thu, 21 Oct 2021 08:41:56 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, hare@suse.de, chaitanya.kulkarni@wdc.com,
 jmeneghi@redhat.com
Subject: [PATCH 0/2] Fix a race condition when performing a controller reset
Date: Thu, 21 Oct 2021 10:41:53 +0200
Message-Id: <20211021084155.16109-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211021_014209_980096_B6EE0D6C 
X-CRM114-Status: GOOD (  10.23  )
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

Memory leaks and kernel panics involving the nvmet driver
have been observed when an initiator executes a reset_controller
operation while doing I/O.

The problem is due to a race condition between io_work
and release_queue, the latter may end up destroying the
commands while io_work is still running, causing use-after-free
and memory leaks.

Maurizio Lombardi (2):
  nvmet: add an helper to free the iovec
  nvmet: fix a race condition between release_queue and io_work

 drivers/nvme/target/tcp.c | 41 ++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

-- 
2.27.0


