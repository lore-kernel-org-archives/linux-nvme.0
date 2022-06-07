Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64827C43334
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jun 2022 14:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ARbohP6mEZob9w8oDjCJOOp1tHNOloqsjsJenSgVOiA=; b=lBqNnSaX9Kn/2vbBp4thQX27uQ
	NIL5VYbjaarCJRcnoiq+66FjaC2rM2jfTgbgLpfdS7WrA8WuD97or6jSDIr6GjSUebvVFIW7wv9dW
	cVA4m+fwL3xRxE8rNs+vuvM06Zu9t29FAwqZIE6dYeZcGgLgeF3WTXZkAtr5ZqXYhDTZFZG/fvCdZ
	jLgm1bDJ8f6NFTRDMER9DhiI7vrTQG8Crp2yPJ4g/ruUmd09kz1xn1K9XbCBVP+10RcBKEoHJoZWQ
	oPf5hsOGr1KF0QkZ2PvtpxW9e7uuoHHVp+fwtmqYOxyfXwghz5aoaR4IBFlqL7PYmN8PW+cHNwbi4
	CTO6vOJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nya8P-0082r6-L7; Tue, 07 Jun 2022 14:24:41 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nya75-00822Y-7J
	for linux-nvme@lists.infradead.org; Tue, 07 Jun 2022 14:23:20 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 9A4BCB81FD1;
	Tue,  7 Jun 2022 14:23:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C6FC34119;
	Tue,  7 Jun 2022 14:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654611796;
	bh=dbpQXKSqQsvmjmPgcSSOP/qcGAmCMVgkxc90D6Gpcy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yq8V0hQDkUgxdfr30tvC1Ia/EjFrT4XLtPEZsl6/0MZCmEJsLpu7/LfW1pkUOQezr
	 GKMXcM2VUrNT+QoVNCs5j01Uf8WJ79KoHj5nQGsG9cMJk1Dz4fijd5aWMsKlJY23cg
	 HDtTY2ZWrki71iSiYTldemns2o76MKmMRw1w3uhnnnnuDredEyeM9tYhQWRJK4bypj
	 5aYdIukIATDp/sOgHrKSBrIuIl4o3gKJSHNGkf+eu5FgDhJlDn63CgjpEoUf0qh0ip
	 8BOKP7YQSH4pTxHEWcdjF9LWF08QfYonpGKzDEVp7LZi9c5FmbZ9XvAaBDwVnlzGsL
	 Gc4GRdIw0fabQ==
Date: Tue, 7 Jun 2022 08:23:13 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@fb.com>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: Re: [PATCH] nvme: add bug report info for global duplicate id
Message-ID: <Yp9fUSEmf3hAoRfp@kbusch-mbp.dhcp.thefacebook.com>
References: <20220606164047.2549647-1-kbusch@fb.com>
 <20220607101526.GA23753@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607101526.GA23753@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220607_072319_469880_82640FAD 
X-CRM114-Status: GOOD (  20.45  )
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

On Tue, Jun 07, 2022 at 12:15:26PM +0200, Christoph Hellwig wrote:
> On Mon, Jun 06, 2022 at 09:40:47AM -0700, Keith Busch wrote:
> >  	if (ret) {
> > +		struct nvme_subsystem *subsys = ctrl->subsys;
> > +
> >  		dev_err(ctrl->device,
> >  			"globally duplicate IDs for nsid %d\n", nsid);
> > +		dev_err(ctrl->device,
> > +			"bug report info: VID:%04x model:%.*s firmware:%.*s\n",
> > +			subsys->vendor_id,
> > +			nvme_str_len(subsys->model, sizeof(subsys->model)),
> > +			subsys->model,
> > +			nvme_str_len(subsys->firmware_rev,
> > +				     sizeof(subsys->firmware_rev)),
> > +			subsys->firmware_rev);
> 
> So I like the idea here, but this won't give us the PCI device id
> that we usually need for quirks.

Yeah, we don't have the DID from core. Should I add a driver specific op to
print device info? Just a quick rough idea here:

---
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9b72b6ecf33c..8daf13eaddac 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -503,6 +503,7 @@ struct nvme_ctrl_ops {
 	void (*submit_async_event)(struct nvme_ctrl *ctrl);
 	void (*delete_ctrl)(struct nvme_ctrl *ctrl);
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
+	void (*print_device_info)(struct nvme_ctrl *ctrl);
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9d963f6cdbae..709793efe16c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2984,6 +2984,18 @@ static int nvme_pci_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 	return snprintf(buf, size, "%s\n", dev_name(&pdev->dev));
 }
 
+
+static void nvme_pci_print_device_info(struct nvme_ctrl *ctrl)
+{
+	struct pci_dev *pdev = to_pci_dev(to_nvme_dev(ctrl)->dev);
+	struct nvme_subsystem *subsys = ctrl->subsys;
+
+	dev_err(ctrl->device,
+		"VID:DID %04x:%04x model:%.*s firmware:%.*s\n",
+		pdev->vendor, pdev->device, 20, subsys->model, 8,
+		subsys->firmware_rev);
+}
+
 static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.name			= "pcie",
 	.module			= THIS_MODULE,
@@ -2995,6 +3007,7 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.free_ctrl		= nvme_pci_free_ctrl,
 	.submit_async_event	= nvme_pci_submit_async_event,
 	.get_address		= nvme_pci_get_address,
+	.print_device_info	= nvme_pci_print_device_info,
 };
 
 static int nvme_dev_map(struct nvme_dev *dev)
--

