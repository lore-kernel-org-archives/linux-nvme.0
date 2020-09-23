Return-Path: <SRS0=afDi=DA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D93C2D0A8
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2020 16:03:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02227214F1
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2020 16:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kRdrSXex";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYl2FawG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02227214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YwfPAYcncBXJqeZcCHYDJpzz8IBtB7Ha7UbTchwmC/M=; b=kRdrSXexE2/aFrXgxE+dDfxSYa
	+mjHmj5Ejp4fdtWBvBVzJk6R1o7dufAZvK+vC2O1dWrPZmcg4GS4VRqsVgtAPJKK0IyvVqGevP2zF
	HKaK46frkfzTH0davqEV8sGI2XSPYmDaRLWXjd5xo48T//msIykJVbE5wOl0wcQwMBIp9ss+jTgIx
	A9EEyikItAdL6rrZped+9zZQ1GTJ+W1ntmnb8wISQbmnDXWMYD3X/qcCQAtcoPBx7vK531TEf55iu
	CpJ7LQv1gcQmidB3Lblznzk/NSTthrMP80H9QqdTNth148KjJpiyYK3gfZYYgYjvEzrxfToI01ajC
	Rl2u8isw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kL7F2-0001DY-2y; Wed, 23 Sep 2020 16:03:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kL7Ew-0001Cm-A2
 for linux-nvme@lists.infradead.org; Wed, 23 Sep 2020 16:03:31 +0000
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1033A214F1;
 Wed, 23 Sep 2020 16:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600877009;
 bh=9l/nrbnWUjMS39tgMqGNaBSTyJVZza8YTM6Xjn+ycYY=;
 h=Date:From:To:Cc:Subject:From;
 b=WYl2FawGX2+QKlnFsTqAaXa8CepNhpyp/R+w3kW9XcSchavbM7bYh2y7qq1E6GaGN
 P10B6R+XuJTi/uDJHzZCy1ano93li/Xbw9aJQi5q4StyW4kxWcO9iX7Snm2zQ1q4nM
 1dCH74jjZhMh9MQki5h8oNAQS1JiIxguuJO1lyEI=
Date: Wed, 23 Sep 2020 11:03:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Subject: [bugzilla-daemon@bugzilla.kernel.org: [Bug 209149] New: "iommu/vt-d:
 Enable PCI ACS for platform opt in hint" makes NVMe config space not
 accessible after S3]
Message-ID: <20200923160327.GA2267374@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200923_120330_484183_55BA4295 
X-CRM114-Status: GOOD (  16.85  )
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
Cc: Joerg Roedel <jroedel@suse.de>, Ashok Raj <ashok.raj@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>,
 Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
 iommu@lists.linux-foundation.org, Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Keith Busch <kbusch@kernel.org>, Rajat Jain <rajatja@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>, Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

[+cc IOMMU and NVMe folks]

Sorry, I forgot to forward this to linux-pci when it was first
reported.

Apparently this happens with v5.9-rc3, and may be related to
50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in hint"),
which appeared in v5.8-rc3.

There are several dmesg logs and proposed patches in the bugzilla, but
no analysis yet of what the problem is.  From the first dmesg
attachment (https://bugzilla.kernel.org/attachment.cgi?id=292327):

  [   50.434945] PM: suspend entry (deep)
  [   50.802086] nvme 0000:01:00.0: saving config space at offset 0x0 (reading 0x11e0f)
  [   50.842775] ACPI: Preparing to enter system sleep state S3
  [   50.858922] ACPI: Waking up from system sleep state S3
  [   50.883622] nvme 0000:01:00.0: can't change power state from D3hot to D0 (config space inaccessible)
  [   50.947352] nvme 0000:01:00.0: restoring config space at offset 0x0 (was 0xffffffff, writing 0x11e0f)
  [   50.947816] pcieport 0000:00:1b.0: DPC: containment event, status:0x1f01 source:0x0000
  [   50.947817] pcieport 0000:00:1b.0: DPC: unmasked uncorrectable error detected
  [   50.947829] pcieport 0000:00:1b.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Receiver ID)
  [   50.947830] pcieport 0000:00:1b.0:   device [8086:06ac] error status/mask=00200000/00010000
  [   50.947831] pcieport 0000:00:1b.0:    [21] ACSViol                (First)
  [   50.947841] pcieport 0000:00:1b.0: AER: broadcast error_detected message
  [   50.947843] nvme nvme0: frozen state error detected, reset controller

I suspect the nvme "can't change power state" and restore config space
errors are a consequence of the DPC event.  If DPC disables the link,
the device is inaccessible.

I don't know what caused the ACS Violation.  The AER TLP Header Log
might have a clue, but unfortunately we didn't print it.

Tangent:

  The fact that we didn't print the AER TLP Header log looks like
  a bug in itself.  PCIe r5.0, sec 6.2.7, table 6-5, says many
  errors, including ACS Violation, should log the TLP header.  But
  aer_get_device_error_info() only reads the log for error bits in
  AER_LOG_TLP_MASKS, which doesn't include PCI_ERR_UNC_ACSV.

  I don't think there's a "TLP Header Log Valid" bit, and it's ugly to
  have to update AER_LOG_TLP_MASKS if new errors are added.  I think
  maybe we should always print the header log.

----- Forwarded message from bugzilla-daemon@bugzilla.kernel.org -----

Date: Fri, 04 Sep 2020 14:31:20 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: bjorn@helgaas.com
Subject: [Bug 209149] New: "iommu/vt-d: Enable PCI ACS for platform opt in
	hint" makes NVMe config space not accessible after S3
Message-ID: <bug-209149-41252@https.bugzilla.kernel.org/>

https://bugzilla.kernel.org/show_bug.cgi?id=209149

            Bug ID: 209149
           Summary: "iommu/vt-d: Enable PCI ACS for platform opt in hint"
                    makes NVMe config space not accessible after S3
           Product: Drivers
           Version: 2.5
    Kernel Version: mainline
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: PCI
          Assignee: drivers_pci@kernel-bugs.osdl.org
          Reporter: kai.heng.feng@canonical.com
        Regression: No

Here's the error:
[   50.947816] pcieport 0000:00:1b.0: DPC: containment event, status:0x1f01
source:0x0000
[   50.947817] pcieport 0000:00:1b.0: DPC: unmasked uncorrectable error
detected
[   50.947829] pcieport 0000:00:1b.0: PCIe Bus Error: severity=Uncorrected
(Non-Fatal), type=Transaction Layer, (Receiver ID)
[   50.947830] pcieport 0000:00:1b.0:   device [8086:06ac] error
status/mask=00200000/00010000
[   50.947831] pcieport 0000:00:1b.0:    [21] ACSViol                (First)
[   50.947841] pcieport 0000:00:1b.0: AER: broadcast error_detected message
[   50.947843] nvme nvme0: frozen state error detected, reset controller

-- 
You are receiving this mail because:
You are watching the assignee of the bug.

----- End forwarded message -----

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
