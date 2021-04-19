Return-Path: <SRS0=6U9w=JQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD235C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 10:58:25 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B09061166
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 10:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B09061166
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FgYv9JOsDIY7dQD6hQLe3jaaBs5jE6OaiZhSrPiaSes=; b=NT/vhKyo6bDIsnMjPrb3ZLUM6T
	dhL8CZLKBYB9sIPRg2j+JeTflRZNLQH9eVfzycUSeZBOosQMQmbK0YOaftL5jVIO3er6NkY6UYwA/
	sL1GnwNOY/3/ky+C24EQc/oxNe2sbTZIlnw0xeBF4kVzTz0DcsfXVLyyt9NgxkoTn6qOYkge+H2p8
	UsCSDHGMyy2tikvonCbxGpTPzfjKOBTgOMQt7lqydwQxhBWPJ1AIBJ6wm4qK6p6sfUj0ZHMF6ybdY
	LvUaH1qDEKQDruQgEn5wyTMC8P86cSfEVlBMwPxcuG9EX3OREfsmJ5b6zq3UM7u6XxzeD6PqhvjSx
	7jHwpOxw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYRbK-009im5-Q3; Mon, 19 Apr 2021 10:57:58 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYRbH-009ikg-5K
 for linux-nvme@desiato.infradead.org; Mon, 19 Apr 2021 10:57:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=fN0rUfHTUpI9zuvR8EosmD9Y94FEfybLBpoS2VNTspk=; b=UwIpuqkqCNpUjXaoNiQ5bxbYTu
 sXy0gqLoa/Kr3M8iOW2IvvkdrOXdW+p/UrPdaTOUitNArxuxXbiVtNZ18DQ9Uh9GViFAdpHOnDH89
 5eGdJS9Z/5YT+KNtlUoQHew3DL16g3YxdO6KOmdc6NZ5YElTjdQ49nVl34n2G1SOziQVw7xqcpHan
 Nhtyyl/xmU6Hb+R8NuZCxLSAJ5qZwbunSWz42ZAk1af4W8TK0bFTa0dSmgIRkDicWL2LEG6OJfaF4
 ZeDc4akQY+vsVK0Cvo39Ue9x4WeqCeCQa7lSjaob70gmtH+Q3Yz5hfoDF5S9VMRhduoYaiVM6mlpC
 8ph72bwg==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYRbB-00BI5J-5V
 for linux-nvme@lists.infradead.org; Mon, 19 Apr 2021 10:57:53 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 36AE0ACC5;
 Mon, 19 Apr 2021 10:57:46 +0000 (UTC)
From: Daniel Wagner <dwagner@suse.de>
To: linux-scsi@vger.kernel.org
Cc: GR-QLogic-Storage-Upstream@marvell.com, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
 Nilesh Javali <njavali@marvell.com>, Arun Easi <aeasi@marvell.com>
Subject: [RFC] qla2xxx: Add dev_loss_tmo kernel module options
Date: Mon, 19 Apr 2021 12:00:14 +0200
Message-Id: <20210419100014.47144-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210419_035749_526693_33C09DFE 
X-CRM114-Status: GOOD (  21.59  )
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

Allow to set the default dev_loss_tmo value as kernel module option.

Cc: Nilesh Javali <njavali@marvell.com>
Cc: Arun Easi <aeasi@marvell.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
Hi,

During array upgrade tests with NVMe/FC on systems equiped with QLogic
HBAs we faced the problem with the default setting of dev_loss_tmo.

When the default timeout hit after 60 seconds the file system went
into read only mode. The fix was to set the dev_loss_tmo to infinity
(note this patch can't handle this).

For lpfc devices we could use the sysfs interface under
fc_remote_ports which exposed the dev_loss_tmo for SCSI and NVMe
rports.

The QLogic only expose the rports via fc_remote_ports if SCSI is used.
There is the debugfs interface to set the dev_loss_tmo but this has
two issues. First, it's not watched by udevd hence no rules work. This
could be somehow worked around by setting it statically, but that is
really only an option for testing. Even if the debugfs interface is
used there is a bug in the code. In qla_nvme_register_remote() the
value 0 is assigned to dev_loss_tmo and the NVMe core will use it's
default value 60 (this code path is exercised if the rport droppes
twice).

Anyway, this patch is just to get the discussion going. Maybe the
driver could implement the fc_remote_port interface? Hannes was
pointing out it might make sense to think about an controller sysfs
API as there is already a host and the NVMe protocol is all about host
and controller.

Thanks,
Daniel

 drivers/scsi/qla2xxx/qla_attr.c | 4 ++--
 drivers/scsi/qla2xxx/qla_gbl.h  | 1 +
 drivers/scsi/qla2xxx/qla_nvme.c | 2 +-
 drivers/scsi/qla2xxx/qla_os.c   | 5 +++++
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index 3aa9869f6fae..0d2386ba65c0 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -3036,7 +3036,7 @@ qla24xx_vport_create(struct fc_vport *fc_vport, bool disable)
 	}
 
 	/* initialize attributes */
-	fc_host_dev_loss_tmo(vha->host) = ha->port_down_retry_count;
+	fc_host_dev_loss_tmo(vha->host) = ql2xdev_loss_tmo;
 	fc_host_node_name(vha->host) = wwn_to_u64(vha->node_name);
 	fc_host_port_name(vha->host) = wwn_to_u64(vha->port_name);
 	fc_host_supported_classes(vha->host) =
@@ -3260,7 +3260,7 @@ qla2x00_init_host_attr(scsi_qla_host_t *vha)
 	struct qla_hw_data *ha = vha->hw;
 	u32 speeds = FC_PORTSPEED_UNKNOWN;
 
-	fc_host_dev_loss_tmo(vha->host) = ha->port_down_retry_count;
+	fc_host_dev_loss_tmo(vha->host) = ql2xdev_loss_tmo;
 	fc_host_node_name(vha->host) = wwn_to_u64(vha->node_name);
 	fc_host_port_name(vha->host) = wwn_to_u64(vha->port_name);
 	fc_host_supported_classes(vha->host) = ha->base_qpair->enable_class_2 ?
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index fae5cae6f0a8..0b9c24475711 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -178,6 +178,7 @@ extern int ql2xdifbundlinginternalbuffers;
 extern int ql2xfulldump_on_mpifail;
 extern int ql2xenforce_iocb_limit;
 extern int ql2xabts_wait_nvme;
+extern int ql2xdev_loss_tmo;
 
 extern int qla2x00_loop_reset(scsi_qla_host_t *);
 extern void qla2x00_abort_all_cmds(scsi_qla_host_t *, int);
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 0cacb667a88b..cdc5b5075407 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -41,7 +41,7 @@ int qla_nvme_register_remote(struct scsi_qla_host *vha, struct fc_port *fcport)
 	req.port_name = wwn_to_u64(fcport->port_name);
 	req.node_name = wwn_to_u64(fcport->node_name);
 	req.port_role = 0;
-	req.dev_loss_tmo = 0;
+	req.dev_loss_tmo = ql2xdev_loss_tmo;
 
 	if (fcport->nvme_prli_service_param & NVME_PRLI_SP_INITIATOR)
 		req.port_role = FC_PORT_ROLE_NVME_INITIATOR;
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index d74c32f84ef5..c686522ff64e 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -338,6 +338,11 @@ static void qla2x00_free_device(scsi_qla_host_t *);
 static int qla2xxx_map_queues(struct Scsi_Host *shost);
 static void qla2x00_destroy_deferred_work(struct qla_hw_data *);
 
+int ql2xdev_loss_tmo = 60;
+module_param(ql2xdev_loss_tmo, int, 0444);
+MODULE_PARM_DESC(ql2xdev_loss_tmo,
+		"Time to wait for device to recover before reporting\n"
+		"an error. Default is 60 seconds\n");
 
 static struct scsi_transport_template *qla2xxx_transport_template = NULL;
 struct scsi_transport_template *qla2xxx_transport_vport_template = NULL;
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
