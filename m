Return-Path: <SRS0=JVDK=LI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682C8C48BDF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 02:01:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17D28613AB
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 02:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D28613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2+wJGxUsGY8SecTsBj1oV3sRL0wt6k4kpcyi3GjdONA=; b=mHTzzAjjzOxEOs
	itfRbx8oBwnKQAI7+a4OaUhFwYvdQjeuuXKA2hk22ZDPS6m6TRkjopQxus8iz8Hg66YIGs8ME+2w0
	/jYJJcZyhxkbB/jefgwNzrN3K9Wr8x2g/nXsAMJTBkiMfqXTdpJf4/pSWOy/753BGhJbpocNk+ugI
	dv1diksjVDXxoiI3kuljuUAR8B/OoLjAd18NtVw92xmPn7GbdWm+7Go9xtNQGQ8Gv53geDgmQXecE
	Val8JAnae4WNN70s2RrliaGft3zpDr11SREZ4N1IkBSSDQhIID8PL9n7lEeBvQ86WJZmj7p8DhQKr
	vObsUHel/ZFjZwn83jNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lsbuY-00BzTF-IZ; Mon, 14 Jun 2021 02:01:10 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lsbt9-00Byxp-LG
 for linux-nvme@lists.infradead.org; Mon, 14 Jun 2021 01:59:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623635993; x=1655171993;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Fx+rzFtI/Q89TusXUq97A4Tyqcy6H7m2EqNt5uDDyhg=;
 b=axxBUhlk/9FrCXsXzGvEx/Spjo7SfxtBQrv/vLuVFTpa4G3HOPzgVL5n
 1PZo6iA36c6U8N9cXPrOqQVEA7Y0NXDpvW2q6Xl5yZ/bQhxNMy8dw0kS5
 83SjLNld1MH4W1WWMS2PBFcbmWomMyk67VD7R2p7naWstARYWvV6Sty4M
 O/P5a1cbwe64dghY2I83sISpkoVWMTZg1cg94zpKKSrxoFTIs7BGnbGpi
 nFvhqRdYAae5ivU9xlgqOyL56FUth9LfWIQro2qQxiFe6IeQoWSYu2pUy
 8q2/AzCmTJZxcHPICsUVEHdPlq2el4u2j7E/E9ylSMRe35yKH/S6AbTS+ g==;
IronPort-SDR: o9SVL4sy2zKz9t+cg6cNjWDxkVfnfL4OKJwsIFSYjXvn16BheX7/7bA03npJu5R4Y4CcKexX8+
 7HGPED39/nVH4rEzZKWjWi6pcWN95VlLQLgXRWDPe/7REpXBER4+oZ6pn24zOpESbG81WZoRSe
 pc5c7Bx+1f8FoeHy+ckJxcfs3qsd0wrkPvr3VRji51hbzai9OWzR6N8Mpz7tYnD6R2cvlOFVep
 x8uSdlgTqJVv8YuYWjpybQTZ5H8uFM+fsBB0tSTlVjWDxHbiBXEvgIoZWWhrQ207tGfKK684IH
 wgw=
X-IronPort-AV: E=Sophos;i="5.83,272,1616428800"; d="scan'208";a="275560920"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2021 09:59:52 +0800
IronPort-SDR: ywJBUNsXnEFRRvgoARgYpsHxfIKLLJEdZ90/2prjRcCDucAMEE0EYf4/V4Cni06sVsYWWJbyik
 79hMIlEmxMJls7pBkePLELd7xdR5qInyRDCKe5eI66MeRBnWqdosowDTNY/mIYVEjQK7pajiXP
 Z3UU0CLXw0H0IeXsTB4oPEJpPGCwOMpY5mKEkzXl9gCZUt4f/Akz3VEbychGbwbmBcx8HQOUIM
 EnrBXHT7LYIyYWSSF2DfvPhS/K4MfOtSvqvV5EFReQpulcZQS97FE/LZkNflkjcaKsG5iw1M4R
 1yQpL6S+4Fn54/iLzgZefFa/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2021 18:37:14 -0700
IronPort-SDR: xMBTUUXgENc1xbXr0nntFEBlOxeaL4r34c7jZ1tM5lD2u0fxHmXuaqUbict9EVY/nfE7sAxNHb
 rxH1Op4oIxvJUjDqU5WQalifhuP7RvajHnOnihhhK+7WPQsQAnRr4lkWWn2T6AVPbUg9tc6RxN
 VGM4QgRQL3lPZwFnLDPjwsd+wovTN9BRn0GjBgDFYke0ZkqaWIODZKK6JduLQXmCILSIj8HXX+
 EsEZe3eIIhXLplpl/ppCtwSK37W5NpYM4OrooWgIFdHehq4fx49JeWNb/4txK/w2XaSDOYa4hI
 vMw=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Jun 2021 18:59:43 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 6/6] nvmet: remove local variable
Date: Sun, 13 Jun 2021 18:58:51 -0700
Message-Id: <20210614015851.53925-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210614015851.53925-1-chaitanya.kulkarni@wdc.com>
References: <20210614015851.53925-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210613_185943_794388_3D737930 
X-CRM114-Status: GOOD (  10.90  )
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

In function errno_to_nvme_status() we store the value of the NVMe
status into the local variable and don't do anything useful with that
but just return.

Remove the local variable and return the value directly from switch.
This also removed extra break statements.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/core.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 45a5b273b525..c8708dcaeaa5 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -43,43 +43,34 @@ DECLARE_RWSEM(nvmet_ana_sem);
 
 inline u16 errno_to_nvme_status(struct nvmet_req *req, int errno)
 {
-	u16 status;
-
 	switch (errno) {
 	case 0:
-		status = NVME_SC_SUCCESS;
-		break;
+		return NVME_SC_SUCCESS;
 	case -ENOSPC:
 		req->error_loc = offsetof(struct nvme_rw_command, length);
-		status = NVME_SC_CAP_EXCEEDED | NVME_SC_DNR;
-		break;
+		return NVME_SC_CAP_EXCEEDED | NVME_SC_DNR;
 	case -EREMOTEIO:
 		req->error_loc = offsetof(struct nvme_rw_command, slba);
-		status = NVME_SC_LBA_RANGE | NVME_SC_DNR;
-		break;
+		return  NVME_SC_LBA_RANGE | NVME_SC_DNR;
 	case -EOPNOTSUPP:
 		req->error_loc = offsetof(struct nvme_common_command, opcode);
 		switch (req->cmd->common.opcode) {
 		case nvme_cmd_dsm:
 		case nvme_cmd_write_zeroes:
-			status = NVME_SC_ONCS_NOT_SUPPORTED | NVME_SC_DNR;
-			break;
+			return NVME_SC_ONCS_NOT_SUPPORTED | NVME_SC_DNR;
 		default:
-			status = NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+			return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 		}
 		break;
 	case -ENODATA:
 		req->error_loc = offsetof(struct nvme_rw_command, nsid);
-		status = NVME_SC_ACCESS_DENIED;
-		break;
+		return NVME_SC_ACCESS_DENIED;
 	case -EIO:
 		fallthrough;
 	default:
 		req->error_loc = offsetof(struct nvme_common_command, opcode);
-		status = NVME_SC_INTERNAL | NVME_SC_DNR;
+		return NVME_SC_INTERNAL | NVME_SC_DNR;
 	}
-
-	return status;
 }
 
 u16 nvmet_report_invalid_opcode(struct nvmet_req *req)
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
