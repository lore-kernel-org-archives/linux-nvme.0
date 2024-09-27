Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07242CEBF78
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2024 06:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H6W1LyfESXJb9xi845y6DXyVhfkTRoCo/BVMje4AuyI=; b=J5nNljwI5z6Hh+UBIDdwqGMBHR
	kdNIioptnxzmouqQP6WVCjSU0Vds305fw0pJ3Usrm6ps/aETkAQy9JtdkLZQgxiiRQS2+4L/DMBEf
	kmm8DoCLnIUbxv96Iv+fECZqUHYW0Y5UXEPX/OXUK1DS6OrcSFTPKMOpi7lhNY/PpEG5VqquTYpvR
	0WgfgyWizORTojB+UfP0qNKIkBPsUOlr45wsQrCZJx8+ru3jfx07BlpqESbOs2wvsUa5gPmyK8P2t
	OoN3A1XMGuAhi/ny6UpmB1BYjRsmwzQVWL29TvlKRO02tS0rIzBy8IMpm6q596qe2XtjVDiE0i+1T
	SbLnON0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1su4BM-0000000A9E4-1rk2;
	Fri, 27 Sep 2024 06:10:24 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1su4BF-0000000A9DV-0gRz
	for linux-nvme@lists.infradead.org;
	Fri, 27 Sep 2024 06:10:19 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R2pPfC021634;
	Fri, 27 Sep 2024 06:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=H
	6W1LyfESXJb9xi845y6DXyVhfkTRoCo/BVMje4AuyI=; b=tt77vcdSRvnnjE7aY
	8sJkEJw6CTM73erUvOkO5d8y204dPN5HLxYF7Bd9GZ0Rok0jeCvqXyWlS1eXu8dJ
	Sk0+KWbiR/YYI6D22bp9/8mFcaJDp/PTtRgGRlrPpnesF7z8+oFuQCOdvooUZrge
	yVUCjwHer0csuINvaeArl3fxhA8vrhwk5IvaBOuVT2NIKHjqhPTlnM1fuRhciurA
	B5xdJdYXNzc9io94i7/7cMX/EVQaeyR8U+HvF2hhYRAOQr4FNy2vMVjwjF+/U4lR
	uopfR3UhqJx2p9Uh6HSyFfOtFLm0ntSombTUqVXmShJWs+l+dUeNJcl44svO9ezq
	opMkQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snvbjgup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 06:10:12 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48R6ABgo013514;
	Fri, 27 Sep 2024 06:10:11 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snvbjguj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 06:10:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48R4ZKsS020814;
	Fri, 27 Sep 2024 06:10:10 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41tb63jtgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 06:10:10 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48R6A9rg43778366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 06:10:09 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E1C258062;
	Fri, 27 Sep 2024 06:10:09 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA7DD5805F;
	Fri, 27 Sep 2024 06:10:07 +0000 (GMT)
Received: from [9.171.27.86] (unknown [9.171.27.86])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Sep 2024 06:10:07 +0000 (GMT)
Message-ID: <7ef2300b-adb2-40d8-95b0-995aaf8d7436@linux.ibm.com>
Date: Fri, 27 Sep 2024 11:40:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nvme: machine check when running nvme subsystem-reset /dev/nvme0
 against direct attach via PCIE slot
To: Laurence Oberman <loberman@redhat.com>,
        "busch, keith" <keith.busch@intel.com>, linux-nvme@lists.infradead.org,
        Keith Busch <kbusch@kernel.org>
References: <b73005ac327784e740bb6b362870c15d0c7788fa.camel@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <b73005ac327784e740bb6b362870c15d0c7788fa.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bny2InZLhkJexO2ebewvlS0tV5mrwRlC
X-Proofpoint-GUID: uBjmZ3xxOF0tyNGZBV49biQ8ZgEhaHOB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_02,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 clxscore=1011 spamscore=0 mlxscore=0
 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409270039
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240926_231017_450809_2DB82309 
X-CRM114-Status: GOOD (  25.18  )
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



On 9/27/24 02:41, Laurence Oberman wrote:
> Hi Keith
> Hope all is well
> 
> Quick question (expected or not)
> 
> It was reported to Red Hat, seeing issues with using a
> "nvme subsystem-reset /dev/nvme0" command to test resets.
> 
> On multiple servers I tested on two types of nvme attached devices
> These are not the rootfs devices
> 
> 1. The front slot (hotplug) devices in a 2.5in format 
> reset and after some time recover (what is expected)
> 
> Example of one working
> 
> Does not trap and land up as a machine-check
> 
> [ 2215.440468] pcieport 0000:10:01.1: AER: Multiple Uncorrected (Non-
> Fatal) error received: 0000:12:13.0
> [ 2215.440532] pcieport 0000:12:13.0: PCIe Bus Error:
> severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester
> ID)
> [ 2215.440536] pcieport 0000:12:13.0:   device [10b5:8748] error
> status/mask=00100000/00000000
> [ 2215.440540] pcieport 0000:12:13.0:    [20] UnsupReq              
> (First)
> [ 2215.440544] pcieport 0000:12:13.0: AER:   TLP Header: 40009001
> 1000000f e9211000 12000000
> [ 2215.441813] systemd-journald[2173]: Sent WATCHDOG=1 notification.
> [ 2216.937498] {1}[Hardware Error]: Hardware error from APEI Generic
> Hardware Error Source: 4
> [ 2216.937505] {1}[Hardware Error]: event severity: info
> [ 2216.937508] {1}[Hardware Error]:  Error 0, type: fatal
> [ 2216.937511] {1}[Hardware Error]:  fru_text: PcieError
> [ 2216.937514] {1}[Hardware Error]:   section_type: PCIe error
> [ 2216.937515] {1}[Hardware Error]:   port_type: 4, root port
> [ 2216.937517] {1}[Hardware Error]:   version: 0.2
> [ 2216.937519] {1}[Hardware Error]:   command: 0x0407, status: 0x0010
> [ 2216.937522] {1}[Hardware Error]:   device_id: 0000:10:01.1
> [ 2216.937524] {1}[Hardware Error]:   slot: 3
> [ 2216.937525] {1}[Hardware Error]:   secondary_bus: 0x11
> [ 2216.937526] {1}[Hardware Error]:   vendor_id: 0x1022, device_id:
> 0x1453
> [ 2216.937528] {1}[Hardware Error]:   class_code: 060400
> [ 2216.937529] {1}[Hardware Error]:   bridge: secondary_status: 0x2000,
> control: 0x0012
> [ 2216.937530] {1}[Hardware Error]:   aer_uncor_status: 0x00000000,
> aer_uncor_mask: 0x04500000
> [ 2216.937532] {1}[Hardware Error]:   aer_uncor_severity: 0x004e2030
> [ 2216.937532] {1}[Hardware Error]:   TLP Header: 00000000 00000000
> 00000000 00000000
> [ 2216.937629] pcieport 0000:10:01.1: AER: aer_status: 0x00000000,
> aer_mask: 0x04500000
> [ 2216.937634] pcieport 0000:10:01.1: AER: aer_layer=Transaction Layer,
> aer_agent=Receiver ID
> [ 2216.937638] pcieport 0000:10:01.1: AER: aer_uncor_severity:
> 0x004e2030
> [ 2216.937645] nvme nvme4: frozen state error detected, reset
> controller
> [ 2217.071095] nvme nvme10: frozen state error detected, reset
> controller
> [ 2217.096928] nvme nvme0: frozen state error detected, reset
> controller
> [ 2217.118947] nvme nvme18: frozen state error detected, reset
> controller
> [ 2217.138945] nvme nvme6: frozen state error detected, reset
> controller
> [ 2217.164918] nvme nvme14: frozen state error detected, reset
> controller
> [ 2217.186902] nvme nvme20: frozen state error detected, reset
> controller
> [ 2279.420266] nvme 0000:1a:00.0: Unable to change power state from
> D3cold to D0, device inaccessible
> [ 2279.420329] nvme nvme22: Disabling device after reset failure: -19
> [ 2279.464727] pcieport 0000:12:13.0: AER: device recovery failed
> [ 2279.464823] pcieport 0000:12:13.0: pciehp: pcie_do_write_cmd: no
> response from device
> 
> Port resets and recovers
> 
> [ 2279.593196] pcieport 0000:10:01.1: AER: Root Port link has been
> reset (0)
> [ 2279.593699] nvme nvme4: restart after slot reset
> [ 2279.593949] nvme nvme10: restart after slot reset
> [ 2279.594222] nvme nvme0: restart after slot reset
> [ 2279.594453] nvme nvme18: restart after slot reset
> [ 2279.594728] nvme nvme6: restart after slot reset
> [ 2279.594984] nvme nvme14: restart after slot reset
> [ 2279.595226] nvme nvme20: restart after slot reset
> [ 2279.595435] pcieport 0000:12:13.0: pciehp: Slot(19): Card present
> [ 2279.595441] pcieport 0000:12:13.0: pciehp: Slot(19): Link Up
> [ 2279.609081] nvme nvme4: Shutdown timeout set to 8 seconds
> [ 2279.617532] nvme nvme0: Shutdown timeout set to 8 seconds
> [ 2279.617533] nvme nvme14: Shutdown timeout set to 8 seconds
> [ 2279.618028] nvme nvme6: Shutdown timeout set to 8 seconds
> [ 2279.618207] nvme nvme18: Shutdown timeout set to 8 seconds
> [ 2279.618290] nvme nvme10: Shutdown timeout set to 8 seconds
> [ 2279.618308] nvme nvme20: Shutdown timeout set to 8 seconds
> [ 2279.631961] nvme nvme4: 32/0/0 default/read/poll queues
> [ 2279.643293] nvme nvme14: 32/0/0 default/read/poll queues
> [ 2279.643372] nvme nvme0: 32/0/0 default/read/poll queues
> [ 2279.644881] nvme nvme6: 32/0/0 default/read/poll queues
> [ 2279.644966] nvme nvme10: 32/0/0 default/read/poll queues
> [ 2279.645030] nvme nvme18: 32/0/0 default/read/poll queues
> [ 2279.645132] nvme nvme20: 32/0/0 default/read/poll queues
> [ 2279.645202] pcieport 0000:10:01.1: AER: device recovery successful
> 
> 2. Any kernel upstream latest 6.11, RHEL8 or RHEL9 causes 
> a machine check and panics the box when its against a nvme in a 
> PCIE slot
> 
>   263.862919] mce: [Hardware Error]: CPU 12: Machine Check Exception: 5
> Bank 6: ba00000000000e0b
> [  263.862924] mce: [Hardware Error]: RIP !INEXACT!
> 10:<ffffffff8571dce4> {intel_idle+0x54/0x90}
> [  263.862931] mce: [Hardware Error]: TSC 7a47d8d62ba6dd MISC 83100000 
> [  263.862933] mce: [Hardware Error]: PROCESSOR 0:606a6 TIME 1727384194
> SOCKET 1 APIC 40 microcode d0003a5
> [  263.862936] mce: [Hardware Error]: Run the above through 'mcelog --
> ascii'
> [  263.885254] mce: [Hardware Error]: Machine check: Processor context
> corrupt
> [  263.885259] Kernel panic - not syncing: Fatal machine check
> 
> Hardware event. This is not a software error.
> CPU 0 BANK 0 TSC 7a47d8d62ba6dd 
> RIP !INEXACT! 10:ffffffff8571dce4
> TIME 1727384194 Thu Sep 26 16:56:34 2024
> MCG status:
> MCi status:
> Machine check not valid
> Corrected error
> MCA: No Error
> STATUS 0 MCGSTATUS 0
> CPUID Vendor Intel Family 6 Model 106 Step 6
> RIP: intel_idle+0x54/0x90}
> SOCKET 1 APIC 40 microcode d0003a5
> Run the above through 'mcelog --ascii'
> Machine check: Processor context corrupt
> 
> Regards
> Laurence
> 
> 
> 
I think the Keith's email address is not correct. Adding the correct email address of Keith here.

BTW, Keith recently help fixed an issue in kernel v6.11 with nvme subsystem-reset command to ensure 
that we recover the nvme disk on PPC. On PPC architecture, we use EEH to recover the disk post 
subsystem-reset but yours is Intel and that uses AER for recovery. So I'm not sure if that same 
commit 210b1f6576e8("nvme-pci: do not directly handle subsys reset fallout") which was merged in 
kernel v6.11 causing a side effect on the Intel machine. 

Would you please revert the above commit and see if that help fix the observed symptom on your
Intel machine? 

Thanks,
--Nilay






