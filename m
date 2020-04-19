Return-Path: <SRS0=4bXW=6D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED36C38A29
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Apr 2020 23:54:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 803A8206F4
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Apr 2020 23:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q3A75CDW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="I+ot1Cy1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 803A8206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7asrV2CIzy2hY81vtnCIRf7M5gZqMh7vgl6ZT9GTI0M=; b=Q3A75CDWWXOTqZ
	TLywsctffcim1SfE2tIIQFC37FqH0TASfSBV5CXDhBRAxSLWRkJsymbvHvKI7AzISvFq58Avs4xs+
	nK4L4MVBwiJ7FGiqjbUHwmQuxGhQTgwymseT0qDbyZwVL0DjB5Rwj0cmXN3qShr8kWtUJhWy6aljp
	xCrIeUpmnWvWwS3m9trzbGrEQgCqwWmCxtGoUiwC/oqepfXxy3hjhz6/ooGCFodUVXurtQaHQIYvx
	DdT+uRiqyxkgcNyCGiopxNJrEzebpnJD49PG4LCs9rpq0rEHmBDcxWvdrcH2v+25D5EBWAF/FckDt
	/yd559GkA89aWe0HjTLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jQJl6-0001Ui-Rx; Sun, 19 Apr 2020 23:53:56 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jQJkm-0001Dr-7M
 for linux-nvme@lists.infradead.org; Sun, 19 Apr 2020 23:53:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587340416; x=1618876416;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+2T2mYHM9oQ2XeDR4rLoAnHbqFrdjN4AcU02Yoo4r9Q=;
 b=I+ot1Cy1YzOJ71TXBoWflS8EGDDSa9H2x1MDTNpkpl92IxiPPQKNhhv4
 Ve8l4PrwTHc1kXG+8MJx5S+GaSP6NgeVCW5u6Vd60x4yikhqougQDuQC7
 K966/eS7eHojR6tpGfXNOb3ry6hTdxTCWMhcrzniyUF/EvuCGOXE2OfYt
 wz7LhiDw0n+Nb3Qyy4BJXiX5kcg4NxnzVnI9quRGyz/sYs0BJIn+8xbZp
 RffFhV6pQjgBu7aQM0s5P30VspGU5UhajGkUruHUhZKtUSWqbEV8Qecrh
 IPZGNXycOLjBSt/8abaZV3OlPDbXdpKHElhsoDtSTTK9yz6gA/IbDv9Lv Q==;
IronPort-SDR: s28UTJsFT3CUWEV+TtdWlMJLYaS6OLVyhX+hkRK4MgBn/zmcdSd8sWgeUMkj1N6py/a/3PsbhB
 ax2nL4su6w/CawRgT1dws28K1Pjw8LjqqWy/iV96aDmThroB9QQcB5wgvC0JJ0UWhQpVox/DLW
 u9VY+G3UkH2lUdB3kvRhS/dZz0qUBIasCiC8qYvEl9g0wM7/iFyOlexWIoDo1vVdQcrg4aPyCJ
 O2oAaCMFknvYXoxfSyJJah9QvLKRt095Fsl4zpaAT2YGMM0Ku5dfpTcLLAu0FITQRHR/75hAUs
 caY=
X-IronPort-AV: E=Sophos;i="5.72,404,1580745600"; d="scan'208";a="135668491"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2020 07:53:34 +0800
IronPort-SDR: lfKdGoxKLE5W2a49D6Rl52dqprxpqGiPRa1+1lHIdTOBzlYsxxcr9dDd/5rGRWP6bEnVrigRYG
 lDxIOsTpaAPvf/8aAMzolWusUF+PjbZSM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2020 16:43:55 -0700
IronPort-SDR: zM+7+xTE/OryIt5V8F6J1UqWyA9ZJ9LX2KtGaroH1StP0BlaPjp3JUZJ/SBJSnE9IP+/VD6DEs
 olx6+CNsTnsg==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Apr 2020 16:53:34 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 6/6] nvmet: align addrfam list to spec
Date: Sun, 19 Apr 2020 16:52:42 -0700
Message-Id: <20200419235242.60355-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200419235242.60355-1-chaitanya.kulkarni@wdc.com>
References: <20200419235242.60355-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200419_165336_362094_CDC4922F 
X-CRM114-Status: GOOD (  14.63  )
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
Cc: sagi@grimberg.me, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

With reference to the NVMeOF Specification (page 44, Figure 38)
discovery log page entry provides address family field. We do set the
transport type field but the adrfam field is not set when using loop
transport and also it doesn't have support in the nvme-cli. So when
reading discovery log page with a loop transport it leads to confusing
output.

As per the spec for adrfam value 254 is reserved for Intra Host
Transport i.e. loopback), we add a required macro in the protocol
header file, set default port disc addr entry's adrfam to
NVMF_ADDR_FAMILY_MAX, and update nvmet_addr_family configfs array for
show/store attribute.

Without this patch, setting adrfam to (ipv4/ipv6/ib/fc/loop/" ") we get
following output for nvme discover command from nvme-cli which is
confusing.
#grep -e adrfam -e trtype without_adrfam_loop_patch.log
trtype:  loop
adrfam:  ipv4
trtype:  loop
adrfam:  ipv6
trtype:  loop
adrfam:  infiniband
trtype:  loop
adrfam:  fibre-channel
trtype:  loop		# ${CFGFS_HOME}/nvmet/ports/1/addr_adrfam = loop
adrfam:  pci            # <----- pci for loop
trtype:  loop		# ${CFGFS_HOME}/nvmet/ports/1/addr_adrfam = " "
adrfam:  pci            # <----- pci for unrecognized

This patch fixes above output :-
# grep -e adrfam -e trtype with_adrfam_loop_patch.log
trtype:  loop
adrfam:  ipv4
trtype:  loop
adrfam:  ipv6
trtype:  loop
adrfam:  infiniband
trtype:  loop
adrfam:  fibre-channel
trtype:  loop           # ${CFGFS_HOME}/nvmet/ports/1/addr_adrfam = loop
adrfam:  loop           # <----- loop for loop
trtype:  loop		# ${CFGFS_HOME}/config/nvmet/ports/adrfam = " "
adrfam:  unrecognized   # <----- unrecognized when invalid value

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/configfs.c | 14 ++++++++------
 include/linux/nvme.h           |  2 ++
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 80a7b669b581..42486f86787a 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -33,11 +33,12 @@ static struct nvmet_type_name_map nvmet_transport[] = {
 };
 
 static const struct nvmet_type_name_map nvmet_addr_family[] = {
-	{ NVMF_ADDR_FAMILY_PCI,	"pcie" },
-	{ NVMF_ADDR_FAMILY_IP4,	"ipv4" },
-	{ NVMF_ADDR_FAMILY_IP6,	"ipv6" },
-	{ NVMF_ADDR_FAMILY_IB,	"ib" },
-	{ NVMF_ADDR_FAMILY_FC,	"fc" },
+	{ NVMF_ADDR_FAMILY_PCI,		"pcie" },
+	{ NVMF_ADDR_FAMILY_IP4,		"ipv4" },
+	{ NVMF_ADDR_FAMILY_IP6,		"ipv6" },
+	{ NVMF_ADDR_FAMILY_IB,		"ib" },
+	{ NVMF_ADDR_FAMILY_FC,		"fc" },
+	{ NVMF_ADDR_FAMILY_LOOP,	"loop" },
 };
 
 static bool nvmet_is_port_enabled(struct nvmet_port *p, const char *caller)
@@ -91,7 +92,7 @@ static ssize_t nvmet_addr_adrfam_store(struct config_item *item,
 
 	for (i = 1; i < ARRAY_SIZE(nvmet_addr_family); i++) {
 		if (sysfs_streq(page, nvmet_addr_family[i].name)) {
-			port->disc_addr.adrfam = i;
+			port->disc_addr.adrfam = nvmet_addr_family[i].type;
 			return count;
 		}
 	}
@@ -1347,6 +1348,7 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 	port->inline_data_size = -1;	/* < 0 == let the transport choose */
 
 	port->disc_addr.portid = cpu_to_le16(portid);
+	port->disc_addr.adrfam = NVMF_ADDR_FAMILY_MAX;
 	port->disc_addr.treq = NVMF_TREQ_DISABLE_SQFLOW;
 	config_group_init_type_name(&port->group, name, &nvmet_port_type);
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 3d5189f46cb1..2d978d0cbde6 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -38,6 +38,8 @@ enum {
 	NVMF_ADDR_FAMILY_IP6	= 2,	/* IP6 */
 	NVMF_ADDR_FAMILY_IB	= 3,	/* InfiniBand */
 	NVMF_ADDR_FAMILY_FC	= 4,	/* Fibre Channel */
+	NVMF_ADDR_FAMILY_LOOP	= 254,	/* Reserved for host usage */
+	NVMF_ADDR_FAMILY_MAX,
 };
 
 /* Transport Type codes for Discovery Log Page entry TRTYPE field */
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
