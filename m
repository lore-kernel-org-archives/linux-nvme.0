Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F603CCFA16
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2024 12:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:To:From:Subject:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S/tCdt6iI+9u50BgAr7MU/tXKAohVBj6Dp1MDkJQTFo=; b=m5p7MuH+0ops0KbMqoZ2y/0rNT
	53VFjvMlPP+D4Nn+JrD4Nq4rmPGeRmaGSejV8RF9X5hqhXD0Xp716tfGXGQI+bsZHdH5gl4bOqmk1
	hPvWpMo9+K9DOz/VIR/SURUtfvamVwIu5EQMWqmMv+yzZPcxEg3KnAIXWZPqhFUVdCAnJvJg4T2TC
	wXavigpamnlcZY5Z9SIOcFqjsJfQ1uPmzOXQy9QO7wtms8e3gQK4IIxhQELONlhjbMKmQlzx+9oaL
	cv3ML6KrSeEmByKI3XEM2vjjYNnPbJ8D4ukZ923VuoBo2lb7G1x5FVn2aJ3L/M08CC+BFB6XVG/lT
	ZJGv3Qgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1su9vH-0000000B2lp-1ZN1;
	Fri, 27 Sep 2024 12:18:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1su9vF-0000000B2lP-0ASN
	for linux-nvme@lists.infradead.org;
	Fri, 27 Sep 2024 12:18:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727439487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S/tCdt6iI+9u50BgAr7MU/tXKAohVBj6Dp1MDkJQTFo=;
	b=bAdHy3JRLNO126gKfgxXhq7ioCWLUNM8HAWCWCV0MIGO9xoHDz/NcXFhqVQi02hAK8UvOf
	+wFg5zC+4ENIld3VK09LCoY/k++NSJ7rKLCI5XTmLa/I9jy974hIC5XvfFQ3ISBnOuwx0d
	CnZg3wbmzHp0tjIzE+gWs/dP0+amMhg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-FGclpJ2lMzaCGjiCq7vc2A-1; Fri, 27 Sep 2024 08:18:06 -0400
X-MC-Unique: FGclpJ2lMzaCGjiCq7vc2A-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6cb3ffbba76so11571036d6.2
        for <linux-nvme@lists.infradead.org>; Fri, 27 Sep 2024 05:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727439486; x=1728044286;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S/tCdt6iI+9u50BgAr7MU/tXKAohVBj6Dp1MDkJQTFo=;
        b=isLd+MLnm/OFrqzvJybj7aPbFxNcKodcJiCPySQBHfG2zkyh9zGCa6y5W+kiQWaskw
         j50fJW99UiHYZ3XOPzeNNyumlo4juPwRXSV234rnEPPpbniLEhZYHLs23fwsQ/dpt6sE
         6Al1qm+RyEvMAhHD6ikZ/V7BO/6sjCkgAneQlvXf8Mouk8/KkvmwxsjQPK/xdchIwezJ
         2E5CsKWIYDv9rd4cnDLGOHu9o73jhGe6GWl1cbXpbPWKtlnyfz0YFOab7bztkXj3oFbb
         A12NMELCasGi1DPAI0uDPNhEh9D4oG6LRQQwXO6rcKWb/fOz7eMDLvIzdd1/Hx13D5G6
         aGuA==
X-Forwarded-Encrypted: i=1; AJvYcCVhH4B2IUWvkuYNGvhe2hhHpRsA2JchhFy7LcLrm8aGVwFFvQQeY+UZb3JZaPS5jl3vhBYOQqkBGvU8@lists.infradead.org
X-Gm-Message-State: AOJu0YzNLtFuTkrXm8EO5Z3RNcKPbU6UGmeMe0OoVi30ItDUEKUMk9Su
	ERCVjE5P0V4xAa0PGblw3eITtI6tpKstVvVsyy+3F9LFSnvpR8WXSyaii+lxinZcO2PthKnJtxq
	eqBkLAsqPaIN0idMaEwL7UYRAFwgM0hGvoVSeS47jWblmwDtD6BseITrQVgOhbjec
X-Received: by 2002:a05:6214:3f8d:b0:6c5:b9a7:f3c5 with SMTP id 6a1803df08f44-6cb3b5f73demr57248306d6.14.1727439485743;
        Fri, 27 Sep 2024 05:18:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQYw2HcXiT8Tb4a0ynWW64oN1ST/0Ukykz1UdOMoNsO5z53xGnAXm+rKhANltlhnJtfZyJPQ==
X-Received: by 2002:a05:6214:3f8d:b0:6c5:b9a7:f3c5 with SMTP id 6a1803df08f44-6cb3b5f73demr57247736d6.14.1727439485283;
        Fri, 27 Sep 2024 05:18:05 -0700 (PDT)
Received: from syn-2600-6c64-4e7f-603b-9b92-b2ac-3267-27e9.biz6.spectrum.com ([2600:6c64:4e7f:603b:9b92:b2ac:3267:27e9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b681b18sm8252006d6.126.2024.09.27.05.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 05:18:02 -0700 (PDT)
Message-ID: <1b2d52b455859ac2a0b5e760cee1b706c855d4ee.camel@redhat.com>
Subject: Re: nvme: machine check when running nvme subsystem-reset
 /dev/nvme0 against direct attach via PCIE slot
From: Laurence Oberman <loberman@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org, 
	Keith Busch <kbusch@kernel.org>
Date: Fri, 27 Sep 2024 08:18:00 -0400
In-Reply-To: <7ef2300b-adb2-40d8-95b0-995aaf8d7436@linux.ibm.com>
References: <b73005ac327784e740bb6b362870c15d0c7788fa.camel@redhat.com>
	 <7ef2300b-adb2-40d8-95b0-995aaf8d7436@linux.ibm.com>
User-Agent: Evolution 3.40.4 (3.40.4-10.el9)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240927_051809_176853_F106A8BD 
X-CRM114-Status: GOOD (  29.12  )
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

On Fri, 2024-09-27 at 11:40 +0530, Nilay Shroff wrote:
> 
> 
> On 9/27/24 02:41, Laurence Oberman wrote:
> > Hi Keith
> > Hope all is well
> > 
> > Quick question (expected or not)
> > 
> > It was reported to Red Hat, seeing issues with using a
> > "nvme subsystem-reset /dev/nvme0" command to test resets.
> > 
> > On multiple servers I tested on two types of nvme attached devices
> > These are not the rootfs devices
> > 
> > 1. The front slot (hotplug) devices in a 2.5in format 
> > reset and after some time recover (what is expected)
> > 
> > Example of one working
> > 
> > Does not trap and land up as a machine-check
> > 
> > [ 2215.440468] pcieport 0000:10:01.1: AER: Multiple Uncorrected
> > (Non-
> > Fatal) error received: 0000:12:13.0
> > [ 2215.440532] pcieport 0000:12:13.0: PCIe Bus Error:
> > severity=Uncorrected (Non-Fatal), type=Transaction Layer,
> > (Requester
> > ID)
> > [ 2215.440536] pcieport 0000:12:13.0:   device [10b5:8748] error
> > status/mask=00100000/00000000
> > (First)
> > [ 2215.440544] pcieport 0000:12:13.0: AER:   TLP Header: 40009001
> > 1000000f e9211000 12000000
> > [ 2215.441813] systemd-journald[2173]: Sent WATCHDOG=1
> > notification.
> > [ 2216.937498] {1}[Hardware Error]: Hardware error from APEI
> > Generic
> > Hardware Error Source: 4
> > [ 2216.937505] {1}[Hardware Error]: event severity: info
> > [ 2216.937508] {1}[Hardware Error]:  Error 0, type: fatal
> > [ 2216.937511] {1}[Hardware Error]:  fru_text: PcieError
> > [ 2216.937514] {1}[Hardware Error]:   section_type: PCIe error
> > [ 2216.937515] {1}[Hardware Error]:   port_type: 4, root port
> > [ 2216.937517] {1}[Hardware Error]:   version: 0.2
> > [ 2216.937519] {1}[Hardware Error]:   command: 0x0407, status:
> > 0x0010
> > [ 2216.937522] {1}[Hardware Error]:   device_id: 0000:10:01.1
> > [ 2216.937524] {1}[Hardware Error]:   slot: 3
> > [ 2216.937525] {1}[Hardware Error]:   secondary_bus: 0x11
> > [ 2216.937526] {1}[Hardware Error]:   vendor_id: 0x1022, device_id:
> > 0x1453
> > [ 2216.937528] {1}[Hardware Error]:   class_code: 060400
> > [ 2216.937529] {1}[Hardware Error]:   bridge: secondary_status:
> > 0x2000,
> > control: 0x0012
> > [ 2216.937530] {1}[Hardware Error]:   aer_uncor_status: 0x00000000,
> > aer_uncor_mask: 0x04500000
> > [ 2216.937532] {1}[Hardware Error]:   aer_uncor_severity:
> > 0x004e2030
> > [ 2216.937532] {1}[Hardware Error]:   TLP Header: 00000000 00000000
> > 00000000 00000000
> > [ 2216.937629] pcieport 0000:10:01.1: AER: aer_status: 0x00000000,
> > aer_mask: 0x04500000
> > [ 2216.937634] pcieport 0000:10:01.1: AER: aer_layer=Transaction
> > Layer,
> > aer_agent=Receiver ID
> > [ 2216.937638] pcieport 0000:10:01.1: AER: aer_uncor_severity:
> > 0x004e2030
> > [ 2216.937645] nvme nvme4: frozen state error detected, reset
> > controller
> > [ 2217.071095] nvme nvme10: frozen state error detected, reset
> > controller
> > [ 2217.096928] nvme nvme0: frozen state error detected, reset
> > controller
> > [ 2217.118947] nvme nvme18: frozen state error detected, reset
> > controller
> > [ 2217.138945] nvme nvme6: frozen state error detected, reset
> > controller
> > [ 2217.164918] nvme nvme14: frozen state error detected, reset
> > controller
> > [ 2217.186902] nvme nvme20: frozen state error detected, reset
> > controller
> > [ 2279.420266] nvme 0000:1a:00.0: Unable to change power state from
> > D3cold to D0, device inaccessible
> > [ 2279.420329] nvme nvme22: Disabling device after reset failure: -
> > 19
> > [ 2279.464727] pcieport 0000:12:13.0: AER: device recovery failed
> > [ 2279.464823] pcieport 0000:12:13.0: pciehp: pcie_do_write_cmd: no
> > response from device
> > 
> > Port resets and recovers
> > 
> > [ 2279.593196] pcieport 0000:10:01.1: AER: Root Port link has been
> > reset (0)
> > [ 2279.593699] nvme nvme4: restart after slot reset
> > [ 2279.593949] nvme nvme10: restart after slot reset
> > [ 2279.594222] nvme nvme0: restart after slot reset
> > [ 2279.594453] nvme nvme18: restart after slot reset
> > [ 2279.594728] nvme nvme6: restart after slot reset
> > [ 2279.594984] nvme nvme14: restart after slot reset
> > [ 2279.595226] nvme nvme20: restart after slot reset
> > [ 2279.595435] pcieport 0000:12:13.0: pciehp: Slot(19): Card
> > present
> > [ 2279.595441] pcieport 0000:12:13.0: pciehp: Slot(19): Link Up
> > [ 2279.609081] nvme nvme4: Shutdown timeout set to 8 seconds
> > [ 2279.617532] nvme nvme0: Shutdown timeout set to 8 seconds
> > [ 2279.617533] nvme nvme14: Shutdown timeout set to 8 seconds
> > [ 2279.618028] nvme nvme6: Shutdown timeout set to 8 seconds
> > [ 2279.618207] nvme nvme18: Shutdown timeout set to 8 seconds
> > [ 2279.618290] nvme nvme10: Shutdown timeout set to 8 seconds
> > [ 2279.618308] nvme nvme20: Shutdown timeout set to 8 seconds
> > [ 2279.631961] nvme nvme4: 32/0/0 default/read/poll queues
> > [ 2279.643293] nvme nvme14: 32/0/0 default/read/poll queues
> > [ 2279.643372] nvme nvme0: 32/0/0 default/read/poll queues
> > [ 2279.644881] nvme nvme6: 32/0/0 default/read/poll queues
> > [ 2279.644966] nvme nvme10: 32/0/0 default/read/poll queues
> > [ 2279.645030] nvme nvme18: 32/0/0 default/read/poll queues
> > [ 2279.645132] nvme nvme20: 32/0/0 default/read/poll queues
> > [ 2279.645202] pcieport 0000:10:01.1: AER: device recovery
> > successful
> > 
> > 2. Any kernel upstream latest 6.11, RHEL8 or RHEL9 causes 
> > a machine check and panics the box when its against a nvme in a 
> > PCIE slot
> > 
> >   263.862919] mce: [Hardware Error]: CPU 12: Machine Check
> > Exception: 5
> > Bank 6: ba00000000000e0b
> > [  263.862924] mce: [Hardware Error]: RIP !INEXACT!
> > 10:<ffffffff8571dce4> {intel_idle+0x54/0x90}
> > [  263.862931] mce: [Hardware Error]: TSC 7a47d8d62ba6dd MISC
> > 83100000 
> > [  263.862933] mce: [Hardware Error]: PROCESSOR 0:606a6 TIME
> > 1727384194
> > SOCKET 1 APIC 40 microcode d0003a5
> > [  263.862936] mce: [Hardware Error]: Run the above through 'mcelog
> > --
> > ascii'
> > [  263.885254] mce: [Hardware Error]: Machine check: Processor
> > context
> > corrupt
> > [  263.885259] Kernel panic - not syncing: Fatal machine check
> > 
> > Hardware event. This is not a software error.
> > CPU 0 BANK 0 TSC 7a47d8d62ba6dd 
> > RIP !INEXACT! 10:ffffffff8571dce4
> > TIME 1727384194 Thu Sep 26 16:56:34 2024
> > MCG status:
> > MCi status:
> > Machine check not valid
> > Corrected error
> > MCA: No Error
> > STATUS 0 MCGSTATUS 0
> > CPUID Vendor Intel Family 6 Model 106 Step 6
> > RIP: intel_idle+0x54/0x90}
> > SOCKET 1 APIC 40 microcode d0003a5
> > Run the above through 'mcelog --ascii'
> > Machine check: Processor context corrupt
> > 
> > Regards
> > Laurence
> > 
> > 
> > 
> I think the Keith's email address is not correct. Adding the correct
> email address of Keith here.
> 
> BTW, Keith recently help fixed an issue in kernel v6.11 with nvme
> subsystem-reset command to ensure 
> that we recover the nvme disk on PPC. On PPC architecture, we use EEH
> to recover the disk post 
> subsystem-reset but yours is Intel and that uses AER for recovery. So
> I'm not sure if that same 
> commit 210b1f6576e8("nvme-pci: do not directly handle subsys reset
> fallout") which was merged in 
> kernel v6.11 causing a side effect on the Intel machine. 
> 
> Would you please revert the above commit and see if that help fix the
> observed symptom on your
> Intel machine? 
> 
> Thanks,
> --Nilay
> 
> 
> 
> 
> 
Hello Nilay
Thanks will try that.
Was your IBM PPC issue also only with direct attached PCIE slot based
nvme.
Will report back after testing with the revert


