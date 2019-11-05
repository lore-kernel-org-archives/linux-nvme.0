Return-Path: <SRS0=AJHE=Y5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB6ACA9ED9
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 08:07:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4226D20869
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 08:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ez2dy8T6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="cAsa6kfr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4226D20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kalray.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:Message-ID:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=8JY5nhwyb+2XJBVLBbD2zQte6Xo2ByPZayj3lVcdwNQ=; b=Ez2dy8T66IIYzi
	niKXsBK73DpOuPMBkOjYUoe3KAVxkqlWF+RsyG8M+betgX+gezV4/7xX28F1mF6LAX+Q7oxu9XPB+
	RHW9+ARVilg/Wquzk+g5HYv5eLRrrx1mOUc94OkH33RgaZglXZXrpDmKleIogVIBnZ5sC+Pw9wULI
	iKdmqUzd75TH4BnuJdhJoL8izD5xTms7v+Gb0GNEZEmz5i7JlKfXxl5H34TmNK9RMbhHoRw3Eum6O
	Oh9kMKsSA01pv8LjYZbby1MYCb57otvNAPzD5sR84vrE0ZZW0BF2Ajro5gQILkrmCBmq30YDN9IqU
	NUuytlG8ZvaaGngGQ3Ug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iRtsD-0005Ge-3l; Tue, 05 Nov 2019 08:07:33 +0000
Received: from zimbra2.kalray.eu ([92.103.151.219])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iRtsA-0005GE-Te
 for linux-nvme@lists.infradead.org; Tue, 05 Nov 2019 08:07:32 +0000
Received: from localhost (localhost [127.0.0.1])
 by zimbra2.kalray.eu (Postfix) with ESMTP id 594B527E0F36;
 Tue,  5 Nov 2019 09:07:29 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1])
 by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id y_G0-tzmub36; Tue,  5 Nov 2019 09:07:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zimbra2.kalray.eu (Postfix) with ESMTP id 1780727E0FF8;
 Tue,  5 Nov 2019 09:07:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 1780727E0FF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1572941249;
 bh=OvGJ9IUMXo3vU6a5XyMpW5RLl6nyUwERxP+jlplbWyM=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=cAsa6kfrpFMlKlnfOs0ppDtqkUaRHC5InYFQbmFyCSgGhcioTIMS1YZOs3dDofetn
 PFAB6j0YR7AlI1yGiH8qOyw08OwL70jIdq9TohBFYp3OSBz+7svPj/C2NbAmRcBhcH
 rko/1k0Gq34zckKW9k89sLE4bzzbVbXATJPxDgGA=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
 by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id FTxCP7404xCA; Tue,  5 Nov 2019 09:07:29 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
 by zimbra2.kalray.eu (Postfix) with ESMTP id 0373827E0F36;
 Tue,  5 Nov 2019 09:07:29 +0100 (CET)
Date: Tue, 5 Nov 2019 09:07:28 +0100 (CET)
From: Marta Rybczynska <mrybczyn@kalray.eu>
To: Keith Busch <keith.busch@intel.com>, 
 linux-nvme <linux-nvme@lists.infradead.org>
Message-ID: <53644331.90381202.1572941248980.JavaMail.zimbra@kalray.eu>
Subject: [PATCH 1/4] nvme-cli: plugins: intel-nvme: add include
MIME-Version: 1.0
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF57 (Linux)/8.8.12_GA_3794)
Thread-Index: FoS2eyvm5gSs+PVhX3eZWetHRXQbJQ==
Thread-Topic: nvme-cli: plugins: intel-nvme: add include
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191105_000731_139130_11A761B3 
X-CRM114-Status: UNSURE (   4.75  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add sys/ioctl.h that will be needed after the update of
the kernel ioctl header.

Signed-off-by: Marta Rybczynska <marta.rybczynska@kalray.eu>
---
 plugins/intel/intel-nvme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/intel/intel-nvme.c b/plugins/intel/intel-nvme.c
index 44e4d5d..0977581 100644
--- a/plugins/intel/intel-nvme.c
+++ b/plugins/intel/intel-nvme.c
@@ -1,5 +1,6 @@
 #include <fcntl.h>
 #include <errno.h>
+#include <sys/ioctl.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
-- 
1.8.3.1

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
