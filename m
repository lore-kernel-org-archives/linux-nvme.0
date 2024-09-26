Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D53CDE03A
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Sep 2024 21:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:To:From:Subject:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zfVFni+zbo0xTkO15JOE7i7ADZXDzmqRSLm4MYurP4Q=; b=NQVBfTkVlaPYV8oZiMMXQ5KIAR
	BoY3bZrRvGz3Mzu0ny8RI8FyTakFBqx4P3k8g0yZYuL+EQp4V1hS3ET0EQDRMZDFAn4BJ1xLeFFY8
	F4XHSWouyOdVUio5dd5AqgsBqOpbJqf5UuMOVhcFtpZl4GDgyoBBUoG7oProh9WuT9YfFBRE5HhAY
	3lOhZRVdJQ7Cuom1b09TrG6gkFoqOftkhi4mOlGHldAq4pI4Lxg7zJJ5OVcTAAM0CfjBbK7O/Sim/
	4EZ60RchQ3QkoVydDWtt7lDbTXa1+lEbhs+/BRBCpr5FAi4Q0g5uXboTv2WODKettWIKQYG8xpN2j
	66jPoZ6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1stvlc-00000009MSa-1OwF;
	Thu, 26 Sep 2024 21:11:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1stvlY-00000009MS3-19oE
	for linux-nvme@lists.infradead.org;
	Thu, 26 Sep 2024 21:11:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727385070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zfVFni+zbo0xTkO15JOE7i7ADZXDzmqRSLm4MYurP4Q=;
	b=VnPg38daQwuyGJEY4+xb1oVv3WCKUhrJC/2WeXXAyy1m00syOp2MHVBcV/FczgkkNaEJTf
	+zrKJ69pyGfYc14ozsufaC92Nw9o+FKwOmBaFP8T5HPAZvCuS82gdy9HrAJOvyGRBkWKzR
	BFEJOeNZNZYuBNiDbkjSAD9Ax0XfIf4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-mxHBb61rOWSN3PMNW63rRA-1; Thu, 26 Sep 2024 17:11:08 -0400
X-MC-Unique: mxHBb61rOWSN3PMNW63rRA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7acb19747a8so248388485a.0
        for <linux-nvme@lists.infradead.org>; Thu, 26 Sep 2024 14:11:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727385068; x=1727989868;
        h=content-transfer-encoding:mime-version:user-agent:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfVFni+zbo0xTkO15JOE7i7ADZXDzmqRSLm4MYurP4Q=;
        b=fSWTI9txJdGCXhdeBG86rYoiG1h14dpMgerptWpky/HQGiQu5fTGZUoULYs7h9BCjG
         C/7I75ElYRJTYfDcbGUk1Z/qNvd1tNeRsB8S56wYNbZclvykNTpcoBcLHrxtxiQYdrFh
         GNu5v6ZNsYsIvo3GA5j0INF/Ymw9f3zKuikKqfCamsr29FXPA6VEzQ8ACQX+WHIKmLUN
         llDMTIYFc0VS8O+8Nck5iQXF5MgPAtCz3MUCppm84VejyC/poCADBFjYjnDWm4YgH6Gj
         zyWICSAFa+Ntf82f+kowm0mhTElgJOQxItyy0zb2ccbCGSBrjuOVjy9Okgnt9L/0s4SN
         IltQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnhOt1hWgpzGNh6wlCvXb8A/KkBzZRikb39v/FsdC1JMVYTefHvEnLInXFXbn8Po+3WOqYoXLcAC3l@lists.infradead.org
X-Gm-Message-State: AOJu0Yy47abBEywvsVSsyp0J5V0OJ0IueoRwAyXJFZCpl4SnO8zozIOy
	8xrHyzl7ePLWN646v4vcDlRSrEB+75hpUfPWF1X2HPqdMNq1lWxgOsGQtjkb9EpJ4uz7ttbDbs9
	Q8CTzdMh4m4ZIFheEOPTzR+bCh+tGQCIZ+2kxqbg5c87+GcXg5zX31FsODsma5Ekq
X-Received: by 2002:a05:620a:440d:b0:7ac:b1fb:27d3 with SMTP id af79cd13be357-7ae378bc118mr125190685a.40.1727385068229;
        Thu, 26 Sep 2024 14:11:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmYckYwHAx20R3CtRQKZiTkLfzOfXPiOmHGVaaQmrnLipSrtYcZ829ZG7C/KRA2WZjixENKg==
X-Received: by 2002:a05:620a:440d:b0:7ac:b1fb:27d3 with SMTP id af79cd13be357-7ae378bc118mr125186785a.40.1727385067730;
        Thu, 26 Sep 2024 14:11:07 -0700 (PDT)
Received: from syn-2600-6c64-4e7f-603b-9b92-b2ac-3267-27e9.biz6.spectrum.com ([2600:6c64:4e7f:603b:9b92:b2ac:3267:27e9])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae37858436sm24985885a.134.2024.09.26.14.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 14:11:06 -0700 (PDT)
Message-ID: <b73005ac327784e740bb6b362870c15d0c7788fa.camel@redhat.com>
Subject: nvme: machine check when running nvme subsystem-reset /dev/nvme0
 against direct attach via PCIE slot
From: Laurence Oberman <loberman@redhat.com>
To: "busch, keith" <keith.busch@intel.com>, linux-nvme@lists.infradead.org
Date: Thu, 26 Sep 2024 17:11:05 -0400
User-Agent: Evolution 3.40.4 (3.40.4-10.el9)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240926_141112_412168_36DCB717 
X-CRM114-Status: UNSURE (   9.12  )
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

Hi Keith
Hope all is well

Quick question (expected or not)

It was reported to Red Hat, seeing issues with using a
"nvme subsystem-reset /dev/nvme0" command to test resets.

On multiple servers I tested on two types of nvme attached devices
These are not the rootfs devices

1. The front slot (hotplug) devices in a 2.5in format 
reset and after some time recover (what is expected)

Example of one working

Does not trap and land up as a machine-check

[ 2215.440468] pcieport 0000:10:01.1: AER: Multiple Uncorrected (Non-
Fatal) error received: 0000:12:13.0
[ 2215.440532] pcieport 0000:12:13.0: PCIe Bus Error:
severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester
ID)
[ 2215.440536] pcieport 0000:12:13.0:   device [10b5:8748] error
status/mask=00100000/00000000
[ 2215.440540] pcieport 0000:12:13.0:    [20] UnsupReq              
(First)
[ 2215.440544] pcieport 0000:12:13.0: AER:   TLP Header: 40009001
1000000f e9211000 12000000
[ 2215.441813] systemd-journald[2173]: Sent WATCHDOG=1 notification.
[ 2216.937498] {1}[Hardware Error]: Hardware error from APEI Generic
Hardware Error Source: 4
[ 2216.937505] {1}[Hardware Error]: event severity: info
[ 2216.937508] {1}[Hardware Error]:  Error 0, type: fatal
[ 2216.937511] {1}[Hardware Error]:  fru_text: PcieError
[ 2216.937514] {1}[Hardware Error]:   section_type: PCIe error
[ 2216.937515] {1}[Hardware Error]:   port_type: 4, root port
[ 2216.937517] {1}[Hardware Error]:   version: 0.2
[ 2216.937519] {1}[Hardware Error]:   command: 0x0407, status: 0x0010
[ 2216.937522] {1}[Hardware Error]:   device_id: 0000:10:01.1
[ 2216.937524] {1}[Hardware Error]:   slot: 3
[ 2216.937525] {1}[Hardware Error]:   secondary_bus: 0x11
[ 2216.937526] {1}[Hardware Error]:   vendor_id: 0x1022, device_id:
0x1453
[ 2216.937528] {1}[Hardware Error]:   class_code: 060400
[ 2216.937529] {1}[Hardware Error]:   bridge: secondary_status: 0x2000,
control: 0x0012
[ 2216.937530] {1}[Hardware Error]:   aer_uncor_status: 0x00000000,
aer_uncor_mask: 0x04500000
[ 2216.937532] {1}[Hardware Error]:   aer_uncor_severity: 0x004e2030
[ 2216.937532] {1}[Hardware Error]:   TLP Header: 00000000 00000000
00000000 00000000
[ 2216.937629] pcieport 0000:10:01.1: AER: aer_status: 0x00000000,
aer_mask: 0x04500000
[ 2216.937634] pcieport 0000:10:01.1: AER: aer_layer=Transaction Layer,
aer_agent=Receiver ID
[ 2216.937638] pcieport 0000:10:01.1: AER: aer_uncor_severity:
0x004e2030
[ 2216.937645] nvme nvme4: frozen state error detected, reset
controller
[ 2217.071095] nvme nvme10: frozen state error detected, reset
controller
[ 2217.096928] nvme nvme0: frozen state error detected, reset
controller
[ 2217.118947] nvme nvme18: frozen state error detected, reset
controller
[ 2217.138945] nvme nvme6: frozen state error detected, reset
controller
[ 2217.164918] nvme nvme14: frozen state error detected, reset
controller
[ 2217.186902] nvme nvme20: frozen state error detected, reset
controller
[ 2279.420266] nvme 0000:1a:00.0: Unable to change power state from
D3cold to D0, device inaccessible
[ 2279.420329] nvme nvme22: Disabling device after reset failure: -19
[ 2279.464727] pcieport 0000:12:13.0: AER: device recovery failed
[ 2279.464823] pcieport 0000:12:13.0: pciehp: pcie_do_write_cmd: no
response from device

Port resets and recovers

[ 2279.593196] pcieport 0000:10:01.1: AER: Root Port link has been
reset (0)
[ 2279.593699] nvme nvme4: restart after slot reset
[ 2279.593949] nvme nvme10: restart after slot reset
[ 2279.594222] nvme nvme0: restart after slot reset
[ 2279.594453] nvme nvme18: restart after slot reset
[ 2279.594728] nvme nvme6: restart after slot reset
[ 2279.594984] nvme nvme14: restart after slot reset
[ 2279.595226] nvme nvme20: restart after slot reset
[ 2279.595435] pcieport 0000:12:13.0: pciehp: Slot(19): Card present
[ 2279.595441] pcieport 0000:12:13.0: pciehp: Slot(19): Link Up
[ 2279.609081] nvme nvme4: Shutdown timeout set to 8 seconds
[ 2279.617532] nvme nvme0: Shutdown timeout set to 8 seconds
[ 2279.617533] nvme nvme14: Shutdown timeout set to 8 seconds
[ 2279.618028] nvme nvme6: Shutdown timeout set to 8 seconds
[ 2279.618207] nvme nvme18: Shutdown timeout set to 8 seconds
[ 2279.618290] nvme nvme10: Shutdown timeout set to 8 seconds
[ 2279.618308] nvme nvme20: Shutdown timeout set to 8 seconds
[ 2279.631961] nvme nvme4: 32/0/0 default/read/poll queues
[ 2279.643293] nvme nvme14: 32/0/0 default/read/poll queues
[ 2279.643372] nvme nvme0: 32/0/0 default/read/poll queues
[ 2279.644881] nvme nvme6: 32/0/0 default/read/poll queues
[ 2279.644966] nvme nvme10: 32/0/0 default/read/poll queues
[ 2279.645030] nvme nvme18: 32/0/0 default/read/poll queues
[ 2279.645132] nvme nvme20: 32/0/0 default/read/poll queues
[ 2279.645202] pcieport 0000:10:01.1: AER: device recovery successful

2. Any kernel upstream latest 6.11, RHEL8 or RHEL9 causes 
a machine check and panics the box when its against a nvme in a 
PCIE slot

  263.862919] mce: [Hardware Error]: CPU 12: Machine Check Exception: 5
Bank 6: ba00000000000e0b
[  263.862924] mce: [Hardware Error]: RIP !INEXACT!
10:<ffffffff8571dce4> {intel_idle+0x54/0x90}
[  263.862931] mce: [Hardware Error]: TSC 7a47d8d62ba6dd MISC 83100000 
[  263.862933] mce: [Hardware Error]: PROCESSOR 0:606a6 TIME 1727384194
SOCKET 1 APIC 40 microcode d0003a5
[  263.862936] mce: [Hardware Error]: Run the above through 'mcelog --
ascii'
[  263.885254] mce: [Hardware Error]: Machine check: Processor context
corrupt
[  263.885259] Kernel panic - not syncing: Fatal machine check

Hardware event. This is not a software error.
CPU 0 BANK 0 TSC 7a47d8d62ba6dd 
RIP !INEXACT! 10:ffffffff8571dce4
TIME 1727384194 Thu Sep 26 16:56:34 2024
MCG status:
MCi status:
Machine check not valid
Corrected error
MCA: No Error
STATUS 0 MCGSTATUS 0
CPUID Vendor Intel Family 6 Model 106 Step 6
RIP: intel_idle+0x54/0x90}
SOCKET 1 APIC 40 microcode d0003a5
Run the above through 'mcelog --ascii'
Machine check: Processor context corrupt

Regards
Laurence



