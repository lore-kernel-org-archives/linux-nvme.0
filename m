Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8192DC433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Jun 2022 13:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pbpC8QmjjfyNHNQ53db0C46bE51fvPB6JPDlgM3pNq0=; b=EUnN3YWJO2W+T0kDkiuWS0IV9i
	UhKUjxcK6g4HgG4UGD29501hGeof0yD8fQqTiWEb1nUJhXEQirdSUSlJne7tstSQKD3c24sS+njIO
	9EyNM4N5EQcTCpO7ts94C50EpsbngznRbevatn+2F6QvRZutKb3Z/ckLeH4QRF5ET1g7ABDkRk5D3
	C9ei7AEYpNnrpio6UxNCGgO2LN7Tb6OxlC2F7GTffobRzCvMNBzt9hH3/51GKqI6bEH+wzrsmYGN9
	651x6v4gVEVK1pdn18QceVcFDb5kEfuREnq64j2mHr3/0UHqOdfYGsxqRm9TLpkqbD/cPAfsfgMOU
	cjWOfSMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2urD-00EGex-AO; Sun, 19 Jun 2022 13:20:51 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2ur7-00EGde-3J
	for linux-nvme@lists.infradead.org; Sun, 19 Jun 2022 13:20:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 32A4CB80D32;
	Sun, 19 Jun 2022 13:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA2DC34114;
	Sun, 19 Jun 2022 13:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655644842;
	bh=/2u5fntWSZiEpUCmtTS07g312l9PpA2KzIK3S5qIcno=;
	h=Date:From:To:Cc:Subject:From;
	b=E25XDRZZuiPhSrj3BRycG3Yhmd2uoLb65l/lXVT7SHCzjzj0jeLHFLwzv9IDPVW2c
	 rM6uErDiqbEVLGQoAq4HeF5wgsNui6yAPV/aDHxx9KKK0YwDcx8z/GZuTIHGUVWwaD
	 d+BQqmuyILdomSEJUcavWX1GlkN4vrEYIC70GOnMZmSTWWt5bwjSG+wXZPhnnRWsCI
	 UQqGX6CF1tB7B80maW2dkOuvqj4gbKSBVh1xASbtXSQwiR5RtZq0NwoWwCzZuUn2sJ
	 Dy1LoqCCfcFnJAr8jGscFa2EFlCW4cFhefFAoJ4fN9q6RygY569qLQHdyOzqJLtR+r
	 Mi6AO4KCjyZ6A==
Date: Sun, 19 Jun 2022 08:20:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Leo Savernik <l.savernik@aon.at>, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [bugzilla-daemon@kernel.org: [Bug 216147] New: NVMe quirk needed for
 multiple Micron MTFDKBA2T0TFH SSDs]
Message-ID: <20220619132039.GA1243474@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220619_062045_474323_31C933DA 
X-CRM114-Status: GOOD (  21.06  )
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

Thanks very much for the testing and report, Leo!  I'm forwarding it
to the NVMe folks who would take care of this.  I checked current
upstream (v5.19-rc1), and indeed this quirk does not appear there.

----- Forwarded message from bugzilla-daemon@kernel.org -----

Date: Sun, 19 Jun 2022 08:58:10 +0000
From: bugzilla-daemon@kernel.org
To: bjorn@helgaas.com
Subject: [Bug 216147] New: NVMe quirk needed for multiple Micron MTFDKBA2T0TFH SSDs
Message-ID: <bug-216147-41252@https.bugzilla.kernel.org/>

https://bugzilla.kernel.org/show_bug.cgi?id=216147

            Bug ID: 216147
           Summary: NVMe quirk needed for multiple Micron MTFDKBA2T0TFH
                    SSDs
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.15.48
          Hardware: AMD
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: PCI
          Assignee: drivers_pci@kernel-bugs.osdl.org
          Reporter: l.savernik@aon.at
        Regression: No

Created attachment 301221
  --> https://bugzilla.kernel.org/attachment.cgi?id=301221&action=edit
Adding NVME_QUIRK_IGNORE_DEV_SUBNQN for Micron MTFDKBA2T0TFH

Even though first noticed on an Ubuntu kernel, I dare to report this against
upstream as this hardware combination malfunction seems not to be known yet (I
did not find distribution-specific patches for this issue). Therefore, IMHO,
the fix should be included upstream to make these devices work on every kernel
deployment.

My brand new Lenovo Notebook contains three NVMe 2T disks. When booting with
Kernel 5.15.0, I receive the following dmesg output:

...
Jun 09 03:33:08 kubuntu kernel: nvme 0000:04:00.0: platform quirk: setting
simple suspend
Jun 09 03:33:08 kubuntu kernel: nvme nvme0: pci function 0000:04:00.0
Jun 09 03:33:08 kubuntu kernel: nvme 0000:06:00.0: platform quirk: setting
simple suspend
Jun 09 03:33:08 kubuntu kernel: nvme nvme1: pci function 0000:06:00.0
Jun 09 03:33:08 kubuntu kernel: nvme 0000:05:00.0: platform quirk: setting
simple suspend
Jun 09 03:33:08 kubuntu kernel: nvme nvme2: pci function 0000:05:00.0
...
Jun 09 03:33:08 kubuntu kernel: nvme nvme1: Duplicate cntlid 0 with nvme0,
rejecting
Jun 09 03:33:08 kubuntu kernel: nvme nvme1: Removing after probe failure
status: -22
Jun 09 03:33:08 kubuntu kernel: nvme nvme2: Duplicate cntlid 0 with nvme0,
rejecting
Jun 09 03:33:08 kubuntu kernel: nvme nvme2: Removing after probe failure
status: -22
Jun 09 03:33:08 kubuntu kernel: pps pps0: new PPS source ptp0
Jun 09 03:33:08 kubuntu kernel: igc 0000:0b:00.0 (unnamed net_device)
(uninitialized): PHC added
Jun 09 03:33:08 kubuntu kernel: nvme nvme0: 16/0/0 default/read/poll queues
Jun 09 03:33:08 kubuntu kernel:  nvme0n1: p1 p2 p3
...

nvme0 is properly detected, however nvme1 and nvme2 are both rejected with
"Duplicate cntlid 0 with nvme0" error message.

lspci properly enumerates all of the 3 devices:
04:00.0 Non-Volatile memory controller: Micron Technology Inc Device 5407
05:00.0 Non-Volatile memory controller: Micron Technology Inc Device 5407
06:00.0 Non-Volatile memory controller: Micron Technology Inc Device 5407

Consequentially, I cannot make use of nvme1 and nvme2. A quirk setting was
proposed for a Samsung device [1] which was finally applied to the kernel [2].

[1] https://lkml.kernel.org/lkml/20210118113356.833556252@linuxfoundation.org/
[2] https://lkml.org/lkml/2021/1/18/1172

I wrote up a modified patch for Micron MTFDKBA2T0TFH devices, tested the patch
and could make all three NVMe devices work flawlessly under Linux 5.15.0.

I also checked this patch against 5.15.48, it applies cleanly.

I suggest this patch be applied to latest longterm 5.15.x as well as latest
Mainline as only one device has been added to the quirk table since, and the
format of the quirktable was not changed in the meantime.

The proposed patch itself (also see attachment):

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b925a5f4afc3..2e5c33f3b868 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3372,5 +3372,7 @@ static const struct pci_device_id nvme_id_table[] = {
NVME_QUIRK_128_BYTES_SQES |
                                NVME_QUIRK_NO_DEEPEST_PS |
                                NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+       { PCI_DEVICE(0x1344, 0x5407), /* Micron Technology Inc NVMe SSD */
+               .driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN },
        { PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
        { 0, }
 };

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

----- End forwarded message -----

