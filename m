Return-Path: <SRS0=SWCy=JM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FA0C43460
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 23:13:06 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C2C461029
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 23:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C2C461029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=s/ZAbc0JnJpR+6T1x6xHYnhJB5S/KYRleQZ1tPgie7I=; b=nVGpND6vPEFOt8NqwJeiuJ87cV
	J5G3K7rpBna8So7MiUNSCyVOSp0Ore9dBWqiE4NJ1RuZcoJDN1Wld2nwVjsBRzZHrLPRh3hnbpJdt
	1sxBiYPL49inEpDlDjtTSzHjZqDXnbXn5QeUqg399dhWyisktXsLut2kSzNliTpHcodj2g01pjWkR
	MmC7KfA5PtltB4qvNcleXKoyUDpnG8bca8AS2nKq9UMNhJ+j/SZRf20y4W2guQrguRO+YfxizeSnO
	BnYjn60GKoeg0Bp8KwNj5euPebc5TNjFTyJXMrdHkyC94LVQp9iWIWc2b41MYpLDI53leMuJrN6vI
	dsXgoU2w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXBA5-0001lb-KD; Thu, 15 Apr 2021 23:12:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXB9O-0001bl-Qd
 for linux-nvme@lists.infradead.org; Thu, 15 Apr 2021 23:11:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618528301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=YTeO2NMu0rbgVuVknP5/yqeO0riYia7vLpmniKoNERA=;
 b=S0GLYqFxcAjKL6bTSqWogqskxdC4ge64R3lO9cxeOtvY3B8RR9TyNjuh6CCnPc0jZ5SpMN
 fb6VszWyBbMB5lHf0jA7fOtnBJAZFZ2TEoo+E3SX3FIQjLWbzCFidPeg7jboTrM0l24150
 DS8J/SOcfRl+Is3MXTsn2AKtdTW9RJc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618528310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=YTeO2NMu0rbgVuVknP5/yqeO0riYia7vLpmniKoNERA=;
 b=O1sOb/TsiSSOvSxNmU9tZU2eOe/XhNexD36rU5rt9gahI2gFiwKsMinQ25NVq0mJFlK8A2
 RyGLJT1RPBZb/I2v8uFXuiqiot+qXHEmjId0jGCZrGuy7Hn0urE7DLrKVRMy9ehxAVMbDa
 itsxQrHrfFDFAtBH3dAkKUF2gNuLZlw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-SjkolUZkPfGit6j8e6AnLg-1; Thu, 15 Apr 2021 19:11:36 -0400
X-MC-Unique: SjkolUZkPfGit6j8e6AnLg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB56F107ACE3;
 Thu, 15 Apr 2021 23:11:33 +0000 (UTC)
Received: from localhost (thegoat.4a2m.lab.eng.bos.redhat.com [10.16.209.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3112760BE5;
 Thu, 15 Apr 2021 23:11:27 +0000 (UTC)
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: nvme: Return BLK_STS_TARGET if the DNR bit is set
Date: Thu, 15 Apr 2021 19:11:23 -0400
Message-Id: <20210415231126.8746-1-snitzer@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_001155_382016_725F4C7B 
X-CRM114-Status: GOOD (  12.76  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

BZ: 1948690
Upstream Status: RHEL-only

Signed-off-by: Mike Snitzer <snitzer@redhat.com>

rhel-8.git commit ef4ab90c12db5e0e50800ec323736b95be7a6ff5
Author: Mike Snitzer <snitzer@redhat.com>
Date:   Tue Aug 25 21:52:45 2020 -0400

    [nvme] nvme: Return BLK_STS_TARGET if the DNR bit is set
    
    Message-id: <20200825215248.2291-8-snitzer@redhat.com>
    Patchwork-id: 325178
    Patchwork-instance: patchwork
    O-Subject: [RHEL8.3 PATCH 07/10] nvme: Return BLK_STS_TARGET if the DNR bit is set
    Bugzilla: 1843515
    RH-Acked-by: David Milburn <dmilburn@redhat.com>
    RH-Acked-by: Gopal Tiwari <gtiwari@redhat.com>
    RH-Acked-by: Ewan Milne <emilne@redhat.com>
    
    BZ: 1843515
    Upstream Status: RHEL-only
    
    If the DNR bit is set we should not retry the command, even if
    the standard status evaluation indicates so.
    
    SUSE is carrying this patch in their kernel:
    https://lwn.net/Articles/800370/
    
    Based on patch posted for upstream inclusion but rejected:
    v1: https://lore.kernel.org/linux-nvme/20190806111036.113233-1-hare@suse.de/
    v2: https://lore.kernel.org/linux-nvme/20190807071208.101882-1-hare@suse.de/
    v2-keith: https://lore.kernel.org/linux-nvme/20190807144725.GB25621@localhost.localdomain/
    v3: https://lore.kernel.org/linux-nvme/20190812075147.79598-1-hare@suse.de/
    v3-keith: https://lore.kernel.org/linux-nvme/20190813141510.GB32686@localhost.localdomain/
    
    This commit's change is basically "v3-keith".
    
    Signed-off-by: Mike Snitzer <snitzer@redhat.com>
    Signed-off-by: Frantisek Hrbata <fhrbata@redhat.com>

---
 drivers/nvme/host/core.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-rhel9/drivers/nvme/host/core.c
===================================================================
--- linux-rhel9.orig/drivers/nvme/host/core.c
+++ linux-rhel9/drivers/nvme/host/core.c
@@ -237,6 +237,9 @@ static void nvme_delete_ctrl_sync(struct
 
 static blk_status_t nvme_error_status(u16 status)
 {
+	if (unlikely(status & NVME_SC_DNR))
+		return BLK_STS_TARGET;
+
 	switch (status & 0x7ff) {
 	case NVME_SC_SUCCESS:
 		return BLK_STS_OK;


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
