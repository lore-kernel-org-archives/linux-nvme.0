Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF19DC5AC7A
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2026 11:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:From:
	Content-Transfer-Encoding:Content-Type:Date:MIME-Version:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=laR57YCDrmXyhfrX2WO4JbsRopbOyZzZJumivJeDwmU=; b=OTC9IJLbvMEY749wnBs/DtArjB
	Mx1QzD/n0zhnFcu8UY7QjBpjESqSQtVGk5S6+N015JpUZCus+fI69Hc5igUGDv9DR97UDtXH6Dt2b
	AQbwMQ7d7zALTG/a2MEBc9wH42MOI7BB/KbYKmQLSLixh3YC3yS6RjBiRNk8XGMYV2iNfBFTptuJ3
	Bpiqx8sSxrWPdR8QPlZoJ62kiST3Xxg3WtFxz3/gOx5l1YCnII0j4VP4YR0+gRiM4TvcFK0lBC6v9
	K7Pb+xD8LkvlhdXOm71RpFWeq6WjTH1g3zFl8MkhHAW6VrET9kGXdlwp/6xO7VieIVEFITVEF4oVW
	q8ykRbaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsJ8D-00000007ycV-2NTf;
	Fri, 07 Aug 2026 11:52:57 +0000
Received: from ingenuity.kiwi ([101.100.136.191] helo=mail.ingenuity.kiwi)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsJ89-00000007yc0-2qBS
	for linux-nvme@lists.infradead.org;
	Fri, 07 Aug 2026 11:52:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ingenuity.kiwi;
	s=mail; t=1786103567;
	bh=qhITJJ25t7Ao5GnjQR4ACLFEmc57kzQavsTSJYdZywQ=;
	h=Date:From:Subject:To:From;
	b=G3P1sSrojNdFPQXDmECb9cypB2eNpJQzGCflFezNEFjYYPPe5L1q2xsAaViZ4XtTo
	 BJ8VFQaxAHHLy3RsL3HCZxkcZ2Lmn4EgsigaaRQnV+BkM2YCXnS2KMAUQ47N05SG5f
	 06itOwlGl2kZ0UmQzOaFrAl9MqWk7pt5mujonCjQ=
Received: from localhost (localhost [127.0.0.1])
	by mail.ingenuity.kiwi (Postfix) with ESMTP id 0CEF51402A9
	for <linux-nvme@lists.infradead.org>; Fri,  7 Aug 2026 23:52:47 +1200 (NZST)
Received: from mail.ingenuity.kiwi ([127.0.0.1])
 by localhost (email.ingenuity.kiwi [127.0.0.1]) (amavis, port 10024)
 with ESMTP id dhQz-qZE8zJs for <linux-nvme@lists.infradead.org>;
 Fri,  7 Aug 2026 23:52:46 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ingenuity.kiwi;
	s=mail; t=1786103566;
	bh=qhITJJ25t7Ao5GnjQR4ACLFEmc57kzQavsTSJYdZywQ=;
	h=Date:From:Subject:To:From;
	b=S4zDQwKDtI9+mKcLy/C6GP7AouigwhUw9BX00YCTXDMI8S/MjG/GF7FXsWslsiLjm
	 bOa2uaIkISWcJfvovWbDpBMmo0z0QAu+kB502fIIMJIYxAB4hY3hQG8uY8iEigY8nx
	 xiQtSOVWjZcKTagz7Qsimd6mfL0iUuyNFAz5ObPg=
Received: from _ (unknown [192.168.110.1])
	by mail.ingenuity.kiwi (Postfix) with ESMTPSA id DA6D7140233
	for <linux-nvme@lists.infradead.org>; Fri,  7 Aug 2026 23:52:46 +1200 (NZST)
MIME-Version: 1.0
Date: Fri, 07 Aug 2026 11:52:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Chris Quin" <chrisq@ingenuity.kiwi>
Message-ID: <3ee0acea15f6b98272d6dec166cbe2d5075e203b@ingenuity.kiwi>
TLS-Required: No
Subject: nvme-pci: ADATA LEGEND 860 [1cc1:5772] recurring controller hang,
 abort ineffective, reset required; one reset failure with CSTS=0x1;
 12 months of data, no host mitigation effective
To: linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260807_045254_218286_8E223C92 
X-CRM114-Status: UNSURE (   9.85  )
X-CRM114-Notice: Please train this message.
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

Subject: nvme-pci: ADATA LEGEND 860 [1cc1:5772] recurring controller hang=
, abort ineffective, reset required; one reset failure with CSTS=3D0x1; 1=
2 months of data, no host mitigation effective

Hi,

Reporting a recurring controller hang on ADATA LEGEND 860 NVMe SSDs
(DRAM-less/HMB), with 12 months of event data. No host-side mitigation
tested had any effect on the event rate. Reporting for the archive and
in case a quirk entry or further debugging is useful.

Hardware/software:
- 2x ADATA LEGEND 860 2TB, firmware VF115C6C (both drives identical)
- PCI ID 1cc1:5772 -- note the PCI ID string reads "LEGEND 850 LITE
  NVMe SSD (DRAM-less)", so this platform appears shared across
  retail SKUs
- frmw 0x2 (single firmware slot); vendor offers no firmware update
- Kernel 7.0.12+deb13-amd64 (Debian trixie); same behavior on earlier
  kernels over the past year
- The two drives are whole-disk members of a single md raid1 (md127,
  ext4, hosting KVM guest images); the host OS runs from a separate
  SATA md mirror, so each hang stalls guest storage but not the host
  root. Light, bursty I/O workload.

Symptoms:
Roughly 6 times/month across the pair (similar rate on each drive), an
I/O command times out and only a controller reset recovers:

  nvme nvme1: I/O tag 485 (51e5) opcode 0x0 (I/O Cmd) QID 10 timeout, abo=
rting req_op:FLUSH(2) size:0
  nvme nvme1: Abort status: 0x0
  nvme nvme1: I/O tag 485 (51e5) opcode 0x0 (I/O Cmd) QID 10 timeout, res=
et controller
  nvme nvme1: 12/0/4 default/read/poll queues

~70 events over 12 months. Victim opcode is usually FLUSH; READ and
WRITE also occur. Key observations:

- The stuck command never completes regardless of wait time. io_timeout
  values of 30s, 90s, 120s and ~240s were used over the year; no stuck
  command ever completed, and reset was always required. Abort always
  completes with status 0x0 but never rescues the command.
- Events occur only during low-I/O periods. Multiple full md resyncs
  and sustained sequential transfers completed over the year with zero
  events during them.
- The drives log nothing: after ~70 controller resets, both report
  "Error Information Log Entries: 0", Critical Warning 0x00, clean
  SMART, 0% used.
- No host-side change over 12 months affected the event rate:
  * nvme_core.default_ps_max_latency_us=3D0 (APST disabled; verified via
    get-feature: APSTE=3D0, all table entries zero), pcie_aspm=3Doff,
    pcie_port_pm=3Doff
  * nr_requests 256 -> 8 -> 16
  * ext4 commit interval 5s -> 180s
  * io_timeout in the 30s - 240s range
  * a 5s direct-read keepalive to both controllers (one event occurred
    on day 3 with it running)
  * a 60s unconditional "nvme flush" keepalive, tested for a full
    month: event rate unchanged (~6/month-pair, matching the 11-month
    baseline). One victim was the keepalive flush itself, submitted
    <60s after the previous successful flush.
  The only visible change: after APST/ASPM were disabled, victims
  became almost exclusively FLUSH, where earlier events included more
  READ/WRITE victims.

Worst-case event (1 of ~70): reset failure and device removal.
On one occasion the controller failed the reset handshake entirely:

  nvme nvme0: I/O tag 961 (53c1) opcode 0x0 (I/O Cmd) QID 13 timeout, abo=
rting req_op:FLUSH(2) size:0
  nvme nvme0: I/O tag 961 (53c1) opcode 0x0 (I/O Cmd) QID 13 timeout, res=
et controller
  nvme nvme0: Device not ready; aborting reset, CSTS=3D0x1
  nvme0n1: I/O Cmd(0x2) @ LBA 97441816, 48 blocks, I/O Error (sct 0x3 / s=
c 0x71)
  nvme nvme0: Abort status: 0x371
  nvme nvme0: Device not ready; aborting reset, CSTS=3D0x1
  nvme nvme0: Device not ready; aborting reset, CSTS=3D0x1
  nvme nvme0: Disabling device after reset failure: -19
  md/raid1:md127: Disk failure on nvme0n1, disabling device.

CSTS stayed 0x1 through three reset attempts; the device was removed
(-19) and required a host power cycle to recover, after which the md
member re-added cleanly via the write-intent bitmap. Note the abort
returned 0x371 in this event versus 0x0 in all recoverable events.

Interpretation (host-side view only):
Consistent with an internal controller state entered on the firmware's
own schedule during low activity -- below the NVMe power-state layer,
since APST is disabled and the host never enables non-operational
states -- with a wake/recovery path that hangs. I obviously can't
confirm internals from the host.

Happy to provide full logs, id-ctrl output, or to test patches.

Thanks,
Chris Quin

