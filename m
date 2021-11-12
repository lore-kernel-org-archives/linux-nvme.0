Return-Path: <SRS0=M30F=P7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74341C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 14:16:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3599B61027
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 14:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3599B61027
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dFsujYkl/I+PPwZp6Npe6lNc/quyl2I8OOF73g5zgNQ=; b=Q4Io/i2u8TMkaNV3fSOEMttzFw
	VgKFNJH2E9Sq4X2iCFRrHUfYYtp+eBdntGNf1u103TzTkoGAFrV8X2Y22kyAytj5BsIWzkdnFMMC3
	o1KT4MxKcE3BUMx7rOY9U2H+lLuDfE7zy38pPPL3htytioS14+HAJv5jfMUKta3a0AieJpId8V8U6
	hSBi9i72KLneHZZG7xsThwkBSniTNM5CLvH0KUFtK5m01Cc9sS1FVklXjbJZisddXWMZZlNLiSkrU
	H0AKdCRxR2rpxkPOKLIQvFpSdKeX9SBrdR1RoQ0P/SXkQZ7Y+11xBl0yOEJ5pkYgfCGjsozee6HGd
	a7/x+row==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mlXLs-00AjLN-VD; Fri, 12 Nov 2021 14:16:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mlXLq-00AjKv-1d
 for linux-nvme@lists.infradead.org; Fri, 12 Nov 2021 14:16:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636726580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dFsujYkl/I+PPwZp6Npe6lNc/quyl2I8OOF73g5zgNQ=;
 b=CLEXNCRSpq+Lp5GMc3C30UhaWKqNP7IS901gHY4NcGgwdzKBPAtHnN1gv90ouO21sDCGTA
 ZiF3bRDHj/TuptPfFzriX9bXPYzw7dDHQUt5h4jjHozNg4ewUXSwzVLq6A4fNEFDHggiys
 z9EQN6JQTbp7+1MRkpY0PNSoAr0ltAE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-ucHrCpC6MCeANpF-7F4zUQ-1; Fri, 12 Nov 2021 09:16:16 -0500
X-MC-Unique: ucHrCpC6MCeANpF-7F4zUQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E76A81017968;
 Fri, 12 Nov 2021 14:16:14 +0000 (UTC)
Received: from raketa.redhat.com (unknown [10.40.193.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE97960C05;
 Fri, 12 Nov 2021 14:16:13 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org
Subject: [PATCH] nvme-host: prevent nvme-cli from setting invalid
 fast_io_fail_tmo values
Date: Fri, 12 Nov 2021 15:16:12 +0100
Message-Id: <20211112141612.201297-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211112_061622_184707_010D80B4 
X-CRM114-Status: UNSURE (   9.79  )
X-CRM114-Notice: Please train this message.
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

Valid fast_io_fail_tmo values are integers >= 0 or -1 (disabled).
Prevent userspace from setting arbitrary negative values.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/fabrics.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index c5a2b71c5268..282d54117e0a 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -698,6 +698,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			if (token >= 0)
 				pr_warn("I/O fail on reconnect controller after %d sec\n",
 					token);
+			else
+				token = -1;
+
 			opts->fast_io_fail_tmo = token;
 			break;
 		case NVMF_OPT_HOSTNQN:
-- 
2.27.0


