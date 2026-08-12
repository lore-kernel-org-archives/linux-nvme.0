Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62906C5CFEE
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 18:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aPHquUGfzUwFwScaIXHkudmQmMhh2Jzly+/vDfBsyjU=; b=TkLOEjVkxF1v0CvuOOcwvKMSc6
	fZFrNklvNXdKbvciUjYobaNqyWrD2mg9n+skxP8C0mWcFAhAG+C0rnuycUcqE/Z9dejbT8z1z+7aM
	0jiMVhwDqavJqvqEapxzM9B9TPd1bST8ELjtoHnVi6yerjlwrl9GIgB0klNP8H+0cvKHxbFiJWmfR
	3OW4T89vSKrAVOzYNxeZC//zM3JBif3X2CG6a2bZiX/oJMuiroo9mk9q7ASMKkPY20ZPrC4GikyXv
	LcNBQgnHRuHOCHCK6zmN6Q0+r+85YNrHfErlvFMEWMy12ZVZBudiOt6VDRBHtJ5r0k9/7BIWW3i6+
	hnGxatzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuDTD-0000000GlQk-3s8p;
	Wed, 12 Aug 2026 18:14:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuDTB-0000000GlOn-44QD
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 18:14:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786558469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aPHquUGfzUwFwScaIXHkudmQmMhh2Jzly+/vDfBsyjU=;
	b=fQUb4fa4+aiah21fFq863kr980Zv4eYmSAglw9T09HdXGGuI4UvsjY2KixROZxBrIplxBy
	Wbk8qqrxsP35NRgYpYDTJtx1lFsg3Ks/JbJyp9iVVdlI1W0PvSG6KbTOWfsPy61nctqKgu
	F15xD8tp3aYDfnv2HEjzE5uEGtpgDP0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-08LnkDKONdql_U4AP8UScw-1; Wed,
 12 Aug 2026 14:14:24 -0400
X-MC-Unique: 08LnkDKONdql_U4AP8UScw-1
X-Mimecast-MFC-AGG-ID: 08LnkDKONdql_U4AP8UScw_1786558458
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5613619560AD;
	Wed, 12 Aug 2026 18:14:18 +0000 (UTC)
Received: from jtaubepe-thinkpadx1carbongen12.ibmlowe.csb (unknown [10.22.88.181])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 98C0C18005BB;
	Wed, 12 Aug 2026 18:14:13 +0000 (UTC)
From: Jesse Taube <jtaubepe@redhat.com>
To: linux-scsi@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Hannes Reinecke <hare@suse.de>,
	Jesse Taube <jtaubepe@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	Bryan Gurney <bgurney@redhat.com>,
	Chris Leech <cleech@redhat.com>,
	"Ewan D . Milne" <emilne@redhat.com>,
	shinichiro.kawasaki@wdc.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 12/13] nvme: fcloop: Add set_rport_marginal to sysfs
Date: Wed, 12 Aug 2026 14:12:59 -0400
Message-ID: <20260812181300.3712426-13-jtaubepe@redhat.com>
In-Reply-To: <20260812181300.3712426-1-jtaubepe@redhat.com>
References: <20260812181300.3712426-1-jtaubepe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: i7Qrl7T-aP06lfMxeKNqhoEdxMDw6TcwyQgjLE3Ce2Y_1786558458
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_111430_082632_7347ADAF 
X-CRM114-Status: GOOD (  18.55  )
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

To allow testing of multipath failover, add a sysfs attribute to set a
remote port as marginal. This will allow the fcloop LLDD to set the
marginal flag on a remote port, simulating a marginal link.

Example:
Turn on marginal for a remote port matching wwnn and wwpn:
`echo 'wwnn=0x200000109b5f2956,wwpn=0x100000109b5f2956,marginal=1' >
/sys/class/fcloop/ctl/set_rport_marginal`

Turn off marginal for a remote port matching wwnn and wwpn:
`echo 'wwnn=0x200000109b5f2956,wwpn=0x100000109b5f2956,marginal=0' >
/sys/class/fcloop/ctl/set_rport_marginal`

Suggested-by: John Meneghini <jmeneghi@redhat.com>
Signed-off-by: Jesse Taube <jtaubepe@redhat.com>
V10 -> V11
 - New patch
---
 drivers/nvme/target/fcloop.c | 41 ++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index b63af3b643a6..51a50743128d 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/parser.h>
 #include <uapi/scsi/fc/fc_fs.h>
+#include <uapi/scsi/fc/fc_els.h>
 
 #include "../host/nvme.h"
 #include "../target/nvmet.h"
@@ -21,6 +22,7 @@ enum {
 	NVMF_OPT_FCADDR		= 1 << 3,
 	NVMF_OPT_LPWWNN		= 1 << 4,
 	NVMF_OPT_LPWWPN		= 1 << 5,
+	NVMF_OPT_MARGINAL	= 1 << 6,
 };
 
 struct fcloop_ctrl_options {
@@ -31,6 +33,7 @@ struct fcloop_ctrl_options {
 	u32			fcaddr;
 	u64			lpwwnn;
 	u64			lpwwpn;
+	u32			marginal;
 };
 
 static const match_table_t opt_tokens = {
@@ -40,6 +43,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_FCADDR,	"fcaddr=%x"	},
 	{ NVMF_OPT_LPWWNN,	"lpwwnn=%s"	},
 	{ NVMF_OPT_LPWWPN,	"lpwwpn=%s"	},
+	{ NVMF_OPT_MARGINAL,	"marginal=%d"	},
 	{ NVMF_OPT_ERR,		NULL		}
 };
 
@@ -120,6 +124,13 @@ fcloop_parse_options(struct fcloop_ctrl_options *opts,
 			}
 			opts->lpwwpn = token64;
 			break;
+		case NVMF_OPT_MARGINAL:
+			if (match_int(args, &token)) {
+				ret = -EINVAL;
+				goto out_free_options;
+			}
+			opts->marginal = token;
+			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s'\n", p);
 			ret = -EINVAL;
@@ -199,6 +210,9 @@ fcloop_parse_nm_options(struct device *dev, u64 *nname, u64 *pname,
 
 #define TGTPORT_OPTS	(NVMF_OPT_WWNN | NVMF_OPT_WWPN)
 
+#define MARGINAL_OPTS	(NVMF_OPT_WWNN | NVMF_OPT_WWPN | \
+			 NVMF_OPT_MARGINAL)
+
 
 static DEFINE_SPINLOCK(fcloop_lock);
 static LIST_HEAD(fcloop_lports);
@@ -1663,6 +1677,31 @@ fcloop_set_cmd_drop(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
+static ssize_t
+fcloop_set_marginal_rport(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct fcloop_nport *nport;
+	struct fcloop_ctrl_options opts;
+	int ret;
+
+	ret = fcloop_parse_options(&opts, buf);
+	if (ret)
+		return ret;
+
+	/* everything there ? */
+	if ((opts.mask & MARGINAL_OPTS) != MARGINAL_OPTS)
+		return -EINVAL;
+
+	nport = fcloop_nport_lookup(opts.wwnn, opts.wwpn);
+	if (!nport || !nport->tport || !nport->tport->remoteport)
+		return -ENOENT;
+
+	nvme_fc_set_remoteport_fpin(nport->tport->remoteport, opts.marginal);
+	fcloop_nport_put(nport);
+
+	return count;
+}
 
 static DEVICE_ATTR(add_local_port, 0200, NULL, fcloop_create_local_port);
 static DEVICE_ATTR(del_local_port, 0200, NULL, fcloop_delete_local_port);
@@ -1671,6 +1710,7 @@ static DEVICE_ATTR(del_remote_port, 0200, NULL, fcloop_delete_remote_port);
 static DEVICE_ATTR(add_target_port, 0200, NULL, fcloop_create_target_port);
 static DEVICE_ATTR(del_target_port, 0200, NULL, fcloop_delete_target_port);
 static DEVICE_ATTR(set_cmd_drop, 0200, NULL, fcloop_set_cmd_drop);
+static DEVICE_ATTR(set_marginal_rport, 0200, NULL, fcloop_set_marginal_rport);
 
 static struct attribute *fcloop_dev_attrs[] = {
 	&dev_attr_add_local_port.attr,
@@ -1680,6 +1720,7 @@ static struct attribute *fcloop_dev_attrs[] = {
 	&dev_attr_add_target_port.attr,
 	&dev_attr_del_target_port.attr,
 	&dev_attr_set_cmd_drop.attr,
+	&dev_attr_set_marginal_rport.attr,
 	NULL
 };
 
-- 
2.54.0


