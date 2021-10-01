Return-Path: <SRS0=bzk4=OV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104BBC433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Oct 2021 23:40:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCEEB619F5
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Oct 2021 23:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BCEEB619F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:Message-Id:Date:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nxaj6VKuzJl2cANC+DBxs78tyI7JivOc8wjD+unB56U=; b=JMOSNlbOZ1IsOZ
	9tMgsY3I0BtTaKrXGe+7J5jttUs4ale+B+51T5wLXcsz6q5lgcpXl2E5SI850uh/u1Xr3gNniUHpv
	20t0MLAhZm8OtXMcHRFt47cEq5kbjt1w7WXTcM6KeGz/u/Ut6OJFgBOZ6WADGeJENDkS6XfQl3o/o
	pUoqHqpT2BhUjOTYPSMWNj1gPeQX0isrm2WIDo4FP+ONdfGLeAbXX/HlrC52SWaqfR1vP2n/mY4Y2
	HTFVXzblKtwAH6blmBjR89G8pQgkYxeew5jCLEorfoSbkzSB8zBYypXHM9IvpdKsq7ScgD8k94YRQ
	5zfoYt/76i58SfkoDdAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mWS8k-001Tzr-Jy; Fri, 01 Oct 2021 23:40:30 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mWS8h-001TzV-He
 for linux-nvme@lists.infradead.org; Fri, 01 Oct 2021 23:40:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-Id:Date:Cc:To:From
 :references:content-disposition:in-reply-to;
 bh=wRe6OmdV+ic/VrXDKnYhC5DhYl9+aS4xXGi038GKF8s=; b=baqaxHo1aZZOFHDOyOstBNxcNQ
 hEaMkMVk6+vRC7ZtLlHlDao745Eqhykc2DExpYustKcV9jDIqFrbKpw63xcHj4vzLE8SvcPzEWVRo
 PYwXrCFZO9fR/CLbuio/T/uOTgviYzwvT76FGIIEW/5p/jZXZxptLcz9ZaotGuzZiqpFsjQsoNCPS
 bH6a1dTAgoTiXQXh/cHSE9QA6O12kslU+MJCFPmY4L6z1J6CG3pcu5FToniz3/q90JHL8BIV7dw3m
 AOJFK/UH3msEzPA79CthwRkqWrzecO97bBdKsEO9B7Yxv7ov2g6py4oM/q3oV33jRcnnN2rj26seG
 n6+4TYWw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1mWS8b-00020w-Rd; Fri, 01 Oct 2021 17:40:23 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim
 4.94.2) (envelope-from <gunthorp@deltatee.com>)
 id 1mWS8a-0001Bg-B1; Fri, 01 Oct 2021 17:40:20 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>,
 David Sloan <David.Sloan@eideticom.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Logan Gunthorpe <logang@deltatee.com>
Date: Fri,  1 Oct 2021 17:40:17 -0600
Message-Id: <20211001234017.4519-1-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: kbusch@kernel.org, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 sbates@raithlin.com, David.Sloan@eideticom.com, martin.oliveira@eideticom.com,
 joshi.k@samsung.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [RFC PATCH] nvme: allow specific passthrough IOs without CAP_SYSADMIN
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211001_164027_614576_1725DF03 
X-CRM114-Status: GOOD (  18.88  )
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

The passthrough IOCTL interface allows for prototyping new non-standard
NVMe features in userspace. However, all passthrough commands require
full CAP_SYSADMIN over and above file access to the device. This means
applications must run as root when running proof of concepts which is
not often desirable.

Instead, relax that requirement for vendor specific commands as well
as identify and get_log_page admin commands (which both have vendor
specific components). Identify and get_log_page only query information
from the controller so users with this privilege shouldn't be able to
cause any negative side effects and vendor specific commands are the
vendors responsibility to avoid dangerous side effects.

Users that want to send any of these passthrough commands will still
require access to the NVMe char device or namespace. Typically, the
char device is only accessible by root anyway and namespaces are
accessible by root and the disk group. Administrators are free to
add udev rules to adjust these permissions for specific devices they
want to allow.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---

Hi,

Wondering what people might think of loosening these restrictions a
touch with this RFC patch. Open to other options if people have them.

This will also become more generally useful with Joshi's io_uring work
which enables asynchronous passthrough IOs.

Thanks,

Logan

drivers/nvme/host/ioctl.c | 26 ++++++++++++++++++++++----
 include/linux/nvme.h      |  1 +
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 22314962842d..3411269194e1 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -187,6 +187,24 @@ static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
 	return true;
 }

+static bool nvme_user_cmd_allowed(struct nvme_ns *ns, int opcode)
+{
+	if (ns) {
+		if (opcode >= nvme_cmd_vendor_start)
+			return true;
+	} else {
+		if (opcode >= nvme_admin_vendor_start)
+			return true;
+		switch (opcode) {
+		case nvme_admin_identify:
+		case nvme_admin_get_log_page:
+			return true;
+		}
+	}
+
+	return capable(CAP_SYS_ADMIN);
+}
+
 static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			struct nvme_passthru_cmd __user *ucmd)
 {
@@ -196,10 +214,10 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	u64 result;
 	int status;

-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
 	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
 		return -EFAULT;
+	if (!nvme_user_cmd_allowed(ns, cmd.opcode))
+		return -EACCES;
 	if (cmd.flags)
 		return -EINVAL;
 	if (!nvme_validate_passthru_nsid(ctrl, ns, cmd.nsid))
@@ -242,10 +260,10 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	unsigned timeout = 0;
 	int status;

-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
 	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
 		return -EFAULT;
+	if (!nvme_user_cmd_allowed(ns, cmd.opcode))
+		return -EACCES;
 	if (cmd.flags)
 		return -EINVAL;
 	if (!nvme_validate_passthru_nsid(ctrl, ns, cmd.nsid))
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b7c4c4130b65..8d36dcf6d2a4 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -692,6 +692,7 @@ enum nvme_opcode {
 	nvme_cmd_zone_mgmt_send	= 0x79,
 	nvme_cmd_zone_mgmt_recv	= 0x7a,
 	nvme_cmd_zone_append	= 0x7d,
+	nvme_cmd_vendor_start   = 0x80,
 };

 #define nvme_opcode_name(opcode)	{ opcode, #opcode }

base-commit: 5816b3e6577eaa676ceb00a848f0fd65fe2adc29
--
2.30.2

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
