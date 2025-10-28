Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AC4CCF9E0
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Oct 2025 14:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=el7k3tY0o5BzZ7SGCDRbrDTFGTASJqMk2Yf679qeoKo=; b=H2jmXLCdhxMd1+3R5D/5D2Squ+
	bhWMtUzXJXkyxEQ6j3IoyXLikT6OGWNfmPTWsiY8iCpp3FmesEcA4jmVAX6eMNQfHCPYINcyBpbsu
	LugFOxxsEKoqt1ZIQB1Z6V6DJ+Eg0GDTleixkxVVC5fdt8yt+1vNYSLEoqifSvpTkk76bvKAVEWBc
	Pnro0DgAV3mvr9FidxUZvJo1f4Vecjq84vRCRX47MgYPNZknZylNkGYEjy3km6B/uXYDRiqDlL/RP
	psH5YWBHekhzX23xK1bTH79rqkbdImoWYqECAWa0P136A8yHeZ9Jm1G0mxMB6eATo+OBApDh41NuY
	vOaNipeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDkj2-0000000G5v3-2Utz;
	Tue, 28 Oct 2025 14:31:04 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDkj1-0000000G5uu-4BUR
	for linux-nvme@bombadil.infradead.org;
	Tue, 28 Oct 2025 14:31:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=content-type:Content-Transfer-Encoding
	:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=el7k3tY0o5BzZ7SGCDRbrDTFGTASJqMk2Yf679qeoKo=; b=cI3Al2NFSrCU+atb8Kg+b+VHB8
	NSlZTz5v/k7bDZO3lUWWxkuNwoRXwjjDeChUE/tdjFoAB1hqtF3Bs3XR304M6Sx+joO1WbKy6DD7U
	Zrl5hTR+BS32rcPpVl7tJ368nZkJNLDLl/5hoD9moIg7Donp5qMlN5qcLsdInLTp+cEsoHyUogIR2
	5nJFhy0UYtUtngudXYw1H0GUynmQ4NofipD+YLk/ZIeDvh9rbZhneWPMgcvLAdH6FgQpFH/9AK1uJ
	5rSOJL+ZUo4C4XoCzJ1dCHM+2qBhpsgQApKiLQxy+xVrmCcfdxhonUf7GwwlJ8PZg0NtOYZgfeHD/
	A+GXtLZw==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDjrF-00000004Yhu-0UQE
	for linux-nvme@lists.infradead.org;
	Tue, 28 Oct 2025 13:35:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761661849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=el7k3tY0o5BzZ7SGCDRbrDTFGTASJqMk2Yf679qeoKo=;
	b=c/vdU4Xk0o4UKe569smpbNdwNrn4+LO7wyKy1I4bdQfj7rq6ivIsk8yGJ30FvQAdvOMQ7g
	C3jlQrywmCaKN+8KNCIDVUGddy9kafE9On2i2qNPAIVLq9ygwSEJ9/aVw3rRMOTgx9wE4U
	CqVeRzK/WZIs0bnH/UT2PAq1CbGDoEc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761661858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=el7k3tY0o5BzZ7SGCDRbrDTFGTASJqMk2Yf679qeoKo=;
	b=V870VCYkapkZvNcoNu9oO/K/FQGKDHWDvAyS701MZHW4CqmjMT44vUlkb9otld++A0wl7e
	13hErXidajy1A81kgs2Et9hqZYec25M34cAVdGFIUg91re7HkFkPUoKzddG0c1o6GQNDYJ
	wOG090DdMbCThgwvZbPVU5ZD4tBKEaI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-3JmrefpYN8Gcf0oVWoQdWQ-1; Tue,
 28 Oct 2025 10:29:21 -0400
X-MC-Unique: 3JmrefpYN8Gcf0oVWoQdWQ-1
X-Mimecast-MFC-AGG-ID: 3JmrefpYN8Gcf0oVWoQdWQ_1761661760
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83FE018009C2;
	Tue, 28 Oct 2025 14:29:19 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.44.32.113])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A07E1180035A;
	Tue, 28 Oct 2025 14:29:17 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: mlombard@redhat.com,
	kbusch@kernel.org
Cc: bgurney@redhat.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-pci: expose active quirks in sysfs
Date: Tue, 28 Oct 2025 15:29:16 +0100
Message-ID: <20251028142916.700438-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ckvMR-5rkJfKGkzpsKnB6zFwcfDD_XUPbcgKCLJvHa0_1761661760
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251028_133529_321712_FB9A068C 
X-CRM114-Status: GOOD (  10.04  )
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

Currently, there is no straightforward way for a user to inspect
the quirks value from userspace.
Add a new read-only sysfs attribute "quirks";
reading this file will display the hexadecimal
value of the ctrl->quirks bitmask for the given NVMe device.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/pci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c916176bd9f0..de9febd32e83 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2497,6 +2497,15 @@ static ssize_t cmbsz_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(cmbsz);
 
+static ssize_t quirks_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct nvme_dev *ndev = to_nvme_dev(dev_get_drvdata(dev));
+
+	return sysfs_emit(buf, "0x%08lx\n", ndev->ctrl.quirks);
+}
+static DEVICE_ATTR_RO(quirks);
+
 static ssize_t hmb_show(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
@@ -2557,6 +2566,7 @@ static struct attribute *nvme_pci_attrs[] = {
 	&dev_attr_cmbloc.attr,
 	&dev_attr_cmbsz.attr,
 	&dev_attr_hmb.attr,
+	&dev_attr_quirks.attr,
 	NULL,
 };
 
-- 
2.47.3


