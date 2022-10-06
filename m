Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D04C433FE
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Oct 2022 09:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=r5MiChcDCdwNkRdWG07g2LkFNneB/7iRxLWzA1+T7fE=; b=PCm2L607RRwXC4qNoBSBqcypT7
	YBq3Eubt+PQcclw4S6Ql3Ypda38dhBO+Ook36EBMIbcqYzM/yz/YCZyY7NR2bGXE5MhRruhHr++pZ
	cwjDio+vKraqGzD4L8fPfziiMpNq8mP49YrOoUIcjrWKKgX7vJGcu2GjmnNpPJgzbxlSL5/QAwHQP
	MmWUG5R/hLE4QXA5q71JzKnHHtZnjQt7n7842Y3zBEQDiJR1o3EdDtclN5pC1zy5JHPDFZph1A1B8
	hELwyMEj0x5rbqdd53Lhr+Gy94ceuiEFwrJI76klJ6wJELKJv6+3MPkMo2T87b1bkxMct6+dg12Pa
	0K40jORg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogNIy-001BtM-Gt; Thu, 06 Oct 2022 09:36:36 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogNIv-001BrE-Cf
	for linux-nvme@lists.infradead.org; Thu, 06 Oct 2022 09:36:35 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E3DC421A1F;
	Thu,  6 Oct 2022 09:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1665048991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=r5MiChcDCdwNkRdWG07g2LkFNneB/7iRxLWzA1+T7fE=;
	b=Ln52Sf444Rh6cZWbX8xZ0BBjtYEXvsF9L+I68pK//TQxV7Bq4AADSXGI8mynBoEMRhBXS3
	16fc3IrGiUDzl6IDmTjsoOjruygmiXxWYP3+XBGahCKUCpB6bas3TesGpGpwX4Y3Zkg74u
	1WJGTfve0df7ISXivNm3wwzfO8OcUxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1665048991;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=r5MiChcDCdwNkRdWG07g2LkFNneB/7iRxLWzA1+T7fE=;
	b=l0vifqBb/A4ozuTm0Yo0Vr6VDwkjuWCUTs8IC+c1RbNVC7XLXB6DjI58tLe0hNDF+YRgA6
	XEelTxy5egUpzaDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3C9F1376E;
	Thu,  6 Oct 2022 09:36:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id zOGcM5+hPmPIVwAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 06 Oct 2022 09:36:31 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	yi.zhang@redhat.com,
	Tomas Bzatek <tbzatek@redhat.com>,
	Alan Adamson <alan.adamson@oracle.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v1] nvme: do not log errors for user commands
Date: Thu,  6 Oct 2022 11:36:28 +0200
Message-Id: <20221006093628.22089-1-dwagner@suse.de>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221006_023633_613730_5A5AA93C 
X-CRM114-Status: GOOD (  10.36  )
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

User space might issue commands which fail. Even though userland
handles them correclty, these command get logged which irritates
users.

E.g. libnvme's nvme_scan_topology function is using Namespace
Identification Descriptor list (CNS Value 0x03) for discovering. It
handles the case where it fails but still the kernel logs this as
error:

 nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) DNR
 nvme1: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) DNR

This disables error logging via nvme_log_error for all passthrough
commands. Instead reverting the complete patch, let's disable this bit
until the interested parties in extended logging have figured out how
to do it without introducing regressions. Removing the now
non-functional part in nvme_log_error can be done later if needed.

Fixes: bd83fe6f2cd2 ("nvme: add verbose error logging")
Link: https://github.com/linux-nvme/libnvme/issues/485
Reported-by: yi.zhang@redhat.com
Reported-by: Tomas Bzatek <tbzatek@redhat.com>
Cc: Alan Adamson <alan.adamson@oracle.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

v1:
 - SET RQF_QUIET flag instead of checking NVME_REQ_USERCMD in
   nvme_log_error.
v0:
 - https://lore.kernel.org/linux-nvme/20220929171338.10792-1-dwagner@suse.de/

 drivers/nvme/host/ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index a48a79ed5c4c..b2c1b73f0a22 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -151,6 +151,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	bio = req->bio;
 	ctrl = nvme_req(req)->ctrl;
 
+	req->rq_flags |= RQF_QUIET;
 	ret = nvme_execute_passthru_rq(req, &effects);
 
 	if (result)
-- 
2.37.3


