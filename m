Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E752606A332
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2026 20:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=coWUSIMX;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=UkzlIkRz;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CEuL3fh+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=U2xG8uBDS3ZX6a/oBks6CKUJxumAGYWP5iIhTx2myFE=; b=coWUSIMX6AOTMH
	f0TpB+h6LXlcj6Ypg+26nCe3vH8L9pA9ynnqyUYnGnUCMwxYI8+1SlzQM2V2Ym4ttkMpfuJg02kN8
	e1/tnEdi1I0Slhtxl9N/MxThaYDJ/bvTOY08jMFYfG9RAQN/zyCFidf0u1Uk1o1z1zdkVhBpr/uhm
	zkE/K3zKEdpju8A5vGP1xB3oEtMPp62HfjEpuhefhLj66LN0T7KnF7mgp4wjUgV8jl52Yr1IDyl2G
	qEck5634uZiV4wUitNvta1ddPr7/QWyaxFkc2+t1eXFoNc+gEdTISvFz8zgLnQlVqbWgwZ/sPm/c/
	JR8YJ8U6enCPyeaNDOxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oZ-0000000GcoW-2Yom;
	Sun, 08 Nov 2026 20:48:35 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oX-0000000Gche-2Q7d
	for linux-nvme@bombadil.infradead.org;
	Sun, 08 Nov 2026 20:48:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=U2xG8uBDS3ZX6a/oBks6CKUJxumAGYWP5iIhTx2myFE=; b=UkzlIkRzuHSeV9KArKRWDfTrgm
	Sfz8MVSHedydmBrGdelmeiAi3ZHT4pUp57kPGIoCiBkOyVZeW+47DT1kNzNNB3oPkEu75Vi+TI/Y7
	N6652k7uyECpYdBSUhnEA//IhEBI4M0i29YlD2LU7QJSB0Xed3HxA+uAAGpZ59P1eyveASWeak/J5
	x4NHwlIKQoHOGNPHanrKgtZ+hBbs+0W/XCmUyiNYtGAuiX9iwZ4kw0nzsZOF331IYryUAiiZVHIqh
	JkNl4aOGD2CwY4qVRhGqbWOHr/1tJcTZxJAH3j6qDshCl0ICdvEqJoRGnCkO0shxSuuKIbCFzCzLk
	H3x3mi+w==;
Received: from out-214.mta0.migadu.com ([2001:41d0:1004:224b::d6] helo=mta0.migadu.com)
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oU-000000060Ik-1mLR
	for linux-nvme@lists.infradead.org;
	Sun, 08 Nov 2026 20:48:32 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=H0+4Td4UmVtpFq6ZyOOwjEU0diM7bm7DIDQy7pV4k4k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794170906; v=1; x=1794775706;
 b=CEuL3fh+M1rzf0jVZo8L+thV8cWOQYyPS8NMGn5224RAVM3HllGVW9L/fQ6gaxJSr8boJTir
 8aEhIIeOeTl2rVlyu4tOvHozJQG2xSMAmEx3ErkU1Yq5sYQ0ZrJQhsKmwqhihSrq2uC5u19Wy2F
 qS+NsyXVnojVt28hhh2Nzyxg=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta10.migadu.com with ESMTPS id a74b715b38ffa497;
	Sun, 08 Nov 2026 20:48:26 +0000
X-Mizu-Trace-ID: a74b715b38ffa497
X-Migadu-Flow: FLOW_OUT
From: John Garry <john.garry@linux.dev>
To: james.bottomley@hansenpartnership.com,
	mkp@kernel.org
Cc: hare@suse.com,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	snitzer@kernel.org,
	jmeneghi@redhat.com,
	bmarzins@redhat.com,
	dm-devel@lists.linux.dev,
	hch@lst.de,
	michael.christie@oracle.com,
	John Garry <john.garry@linux.dev>
Subject: [PATCH v9 29/29] scsi: sd: add mpath_queue_depth dev attribute
Date: Sun,  8 Nov 2026 20:47:33 +0000
Message-ID: <20261108204733.557995-30-john.garry@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108204733.557995-1-john.garry@linux.dev>
References: <20261108204733.557995-1-john.garry@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_204830_673619_E095ECC4 
X-CRM114-Status: UNSURE (   9.68  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -0.2 (/)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a queue_depth file so that the multipath dynamic queue depth can be
looked up from per-path gendisk (scsi_disk) directory.

Signed-off-by: John Garry <john.garry@linux.dev>
---
 drivers/scsi/sd.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 5ea604c4bbb0..29ac1ee806c5 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -4178,9 +4178,28 @@ static ssize_t sd_mpath_numa_nodes_show(struct device *dev,
 }
 static DEVICE_ATTR(mpath_numa_nodes, 0444, sd_mpath_numa_nodes_show, NULL);
 
+static ssize_t sd_mpath_queue_depth_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct gendisk *gd = dev_to_disk(dev);
+	struct scsi_disk *sdkp = gd->private_data;
+	struct scsi_device *sdev = sdkp->device;
+	struct scsi_mpath_device *scsi_mpath_dev = sdev->scsi_mpath_dev;
+	struct scsi_mpath_head *scsi_mpath_head =
+				scsi_mpath_dev->scsi_mpath_head;
+	struct Scsi_Host *shost = sdev->host;
+
+	if (!mpath_qd_iopolicy(&scsi_mpath_head->iopolicy))
+		return 0;
+
+	return sysfs_emit(buf, "%d\n", atomic_read(&shost->mpath_nr_active));
+}
+static DEVICE_ATTR(mpath_queue_depth, 0444, sd_mpath_queue_depth_show, NULL);
+
 static struct attribute *sd_mpath_dev_attrs[] = {
 	&dev_attr_mpath_dev.attr,
 	&dev_attr_mpath_numa_nodes.attr,
+	&dev_attr_mpath_queue_depth.attr,
 	NULL
 };
 
-- 
2.43.0


