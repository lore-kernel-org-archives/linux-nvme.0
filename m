Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD93CDD1AE
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2024 13:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yQNf7ZW7JaYwic/De9rhLiPva+5H1Vd25jP9t/L8fDg=; b=mTl4PR+anqC2dr7R/5QNSro8KQ
	FVMIw3pgHl/IE5t0ksjjU71vpNKkq6vv6lvwl/MwNaq2JOVr9Rs1uceh3/WXkw1rwBDQ98GvA2CXX
	H4hW6SyzB/VHCV/NpW2x+/NdNgmp0BVcSk0bsKmrDtKzSBIKFQg+yRPGZNH6T2whmY6jD5yDHAm01
	xKvitMWYJ+6/Yz49Bo2eak0ugFNiW2Lo+Y58r2H4+rOB4ZUMir4nzQWVNzUiokL6HA+iQquK5Pwfx
	BVuWLmLaGWZDZfuHQwjiMUctej2ef1U4lJKaezVXzkEWyIqODd19tOC83vGPLyjm5mKOlNXpkOrov
	3JIO3l5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1suAtQ-0000000BGH2-2xya;
	Fri, 27 Sep 2024 13:20:20 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1suAgd-0000000BDcF-1b1a
	for linux-nvme@lists.infradead.org;
	Fri, 27 Sep 2024 13:07:09 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R6OR97018994;
	Fri, 27 Sep 2024 13:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=y
	QNf7ZW7JaYwic/De9rhLiPva+5H1Vd25jP9t/L8fDg=; b=EzIbMXgyQzFSAKBuI
	bqNCNCnx0z32wSBzXPN8owfoMYhVdaDPI5ARwV/dlUkLqq9Lmp9zys309fc+OCFT
	z7aO0pT+3AFRM25ObJIq66b2XbqICvPy55NLnJxfdDOvW/ccNavDZfIOr/OFQK3c
	XgYYoC3vAWt0U5ogCDaDBlpLnHpQ2wvK+DgF1Fbn+apqE3TPPXU5bzrjhFfwBLsm
	4WsO9zL21634oRKwlsGxapHEJPTSBuOMYn/pV1Qn9RHZGwA2f1zvvdQOJ7/NJ7HK
	po3iqi6FGltXAfEu4wLuYgbybh72z2kbsYqBewgVDq3Q/I0nl/DIpnokzVrTmc2r
	JEMpA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41skjs410y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 13:06:55 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48RD6tYC012978;
	Fri, 27 Sep 2024 13:06:55 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41skjs410v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 13:06:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48RA8lk5008722;
	Fri, 27 Sep 2024 13:06:54 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41t8v1n3wp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 13:06:54 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48RD6sAU23986920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 13:06:54 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 222815805D;
	Fri, 27 Sep 2024 13:06:54 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E906458059;
	Fri, 27 Sep 2024 13:06:52 +0000 (GMT)
Received: from [9.171.44.205] (unknown [9.171.44.205])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Sep 2024 13:06:52 +0000 (GMT)
Message-ID: <091fab50-23e5-4b11-a2b2-4f47c785fa46@linux.ibm.com>
Date: Fri, 27 Sep 2024 18:36:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nvme: machine check when running nvme subsystem-reset /dev/nvme0
 against direct attach via PCIE slot
To: Laurence Oberman <loberman@redhat.com>, linux-nvme@lists.infradead.org,
        Keith Busch <kbusch@kernel.org>
References: <b73005ac327784e740bb6b362870c15d0c7788fa.camel@redhat.com>
 <7ef2300b-adb2-40d8-95b0-995aaf8d7436@linux.ibm.com>
 <1b2d52b455859ac2a0b5e760cee1b706c855d4ee.camel@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <1b2d52b455859ac2a0b5e760cee1b706c855d4ee.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4-OHN_dg4qGIkYRSBuVBlCWGzjaW7Xwf
X-Proofpoint-ORIG-GUID: XsuyNr4mzF3_JsGUWHIITLqUrBfSUzbY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_06,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409270094
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240927_060707_677671_49383EB0 
X-CRM114-Status: GOOD (  21.55  )
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



On 9/27/24 17:48, Laurence Oberman wrote:
> On Fri, 2024-09-27 at 11:40 +0530, Nilay Shroff wrote:
>>
>>
>> On 9/27/24 02:41, Laurence Oberman wrote:
>>> Hi Keith
>>> Hope all is well
>>>
>>> Quick question (expected or not)
>>>
>>> It was reported to Red Hat, seeing issues with using a
>>> "nvme subsystem-reset /dev/nvme0" command to test resets.
>>>
>>> On multiple servers I tested on two types of nvme attached devices
>>> These are not the rootfs devices
>>>
>>> 1. The front slot (hotplug) devices in a 2.5in format 
>>> reset and after some time recover (what is expected)
>>>
>>> Example of one working
>>>
>>> Does not trap and land up as a machine-check
>>>
>>> [ 2215.440468] pcieport 0000:10:01.1: AER: Multiple Uncorrected
>>> (Non-
>>> Fatal) error received: 0000:12:13.0
>>> [ 2215.440532] pcieport 0000:12:13.0: PCIe Bus Error:
>>> severity=Uncorrected (Non-Fatal), type=Transaction Layer,
>>> (Requester
>>> ID)
>>> [ 2215.440536] pcieport 0000:12:13.0:   device [10b5:8748] error
>>> status/mask=00100000/00000000
>>> (First)
>>> [ 2215.440544] pcieport 0000:12:13.0: AER:   TLP Header: 40009001
>>> 1000000f e9211000 12000000
>>> [ 2215.441813] systemd-journald[2173]: Sent WATCHDOG=1
>>> notification.
>>> [ 2216.937498] {1}[Hardware Error]: Hardware error from APEI
>>> Generic
>>> Hardware Error Source: 4
>>> [ 2216.937505] {1}[Hardware Error]: event severity: info
>>> [ 2216.937508] {1}[Hardware Error]:  Error 0, type: fatal
>>> [ 2216.937511] {1}[Hardware Error]:  fru_text: PcieError
>>> [ 2216.937514] {1}[Hardware Error]:   section_type: PCIe error
>>> [ 2216.937515] {1}[Hardware Error]:   port_type: 4, root port
>>> [ 2216.937517] {1}[Hardware Error]:   version: 0.2
>>> [ 2216.937519] {1}[Hardware Error]:   command: 0x0407, status:
>>> 0x0010
>>> [ 2216.937522] {1}[Hardware Error]:   device_id: 0000:10:01.1
>>> [ 2216.937524] {1}[Hardware Error]:   slot: 3
>>> [ 2216.937525] {1}[Hardware Error]:   secondary_bus: 0x11
>>> [ 2216.937526] {1}[Hardware Error]:   vendor_id: 0x1022, device_id:
>>> 0x1453
>>> [ 2216.937528] {1}[Hardware Error]:   class_code: 060400
>>> [ 2216.937529] {1}[Hardware Error]:   bridge: secondary_status:
>>> 0x2000,
>>> control: 0x0012
>>> [ 2216.937530] {1}[Hardware Error]:   aer_uncor_status: 0x00000000,
>>> aer_uncor_mask: 0x04500000
>>> [ 2216.937532] {1}[Hardware Error]:   aer_uncor_severity:
>>> 0x004e2030
>>> [ 2216.937532] {1}[Hardware Error]:   TLP Header: 00000000 00000000
>>> 00000000 00000000
>>> [ 2216.937629] pcieport 0000:10:01.1: AER: aer_status: 0x00000000,
>>> aer_mask: 0x04500000
>>> [ 2216.937634] pcieport 0000:10:01.1: AER: aer_layer=Transaction
>>> Layer,
>>> aer_agent=Receiver ID
>>> [ 2216.937638] pcieport 0000:10:01.1: AER: aer_uncor_severity:
>>> 0x004e2030
>>> [ 2216.937645] nvme nvme4: frozen state error detected, reset
>>> controller
>>> [ 2217.071095] nvme nvme10: frozen state error detected, reset
>>> controller
>>> [ 2217.096928] nvme nvme0: frozen state error detected, reset
>>> controller
>>> [ 2217.118947] nvme nvme18: frozen state error detected, reset
>>> controller
>>> [ 2217.138945] nvme nvme6: frozen state error detected, reset
>>> controller
>>> [ 2217.164918] nvme nvme14: frozen state error detected, reset
>>> controller
>>> [ 2217.186902] nvme nvme20: frozen state error detected, reset
>>> controller
>>> [ 2279.420266] nvme 0000:1a:00.0: Unable to change power state from
>>> D3cold to D0, device inaccessible
>>> [ 2279.420329] nvme nvme22: Disabling device after reset failure: -
>>> 19
>>> [ 2279.464727] pcieport 0000:12:13.0: AER: device recovery failed
>>> [ 2279.464823] pcieport 0000:12:13.0: pciehp: pcie_do_write_cmd: no
>>> response from device
>>>
>>> Port resets and recovers
>>>
>>> [ 2279.593196] pcieport 0000:10:01.1: AER: Root Port link has been
>>> reset (0)
>>> [ 2279.593699] nvme nvme4: restart after slot reset
>>> [ 2279.593949] nvme nvme10: restart after slot reset
>>> [ 2279.594222] nvme nvme0: restart after slot reset
>>> [ 2279.594453] nvme nvme18: restart after slot reset
>>> [ 2279.594728] nvme nvme6: restart after slot reset
>>> [ 2279.594984] nvme nvme14: restart after slot reset
>>> [ 2279.595226] nvme nvme20: restart after slot reset
>>> [ 2279.595435] pcieport 0000:12:13.0: pciehp: Slot(19): Card
>>> present
>>> [ 2279.595441] pcieport 0000:12:13.0: pciehp: Slot(19): Link Up
>>> [ 2279.609081] nvme nvme4: Shutdown timeout set to 8 seconds
>>> [ 2279.617532] nvme nvme0: Shutdown timeout set to 8 seconds
>>> [ 2279.617533] nvme nvme14: Shutdown timeout set to 8 seconds
>>> [ 2279.618028] nvme nvme6: Shutdown timeout set to 8 seconds
>>> [ 2279.618207] nvme nvme18: Shutdown timeout set to 8 seconds
>>> [ 2279.618290] nvme nvme10: Shutdown timeout set to 8 seconds
>>> [ 2279.618308] nvme nvme20: Shutdown timeout set to 8 seconds
>>> [ 2279.631961] nvme nvme4: 32/0/0 default/read/poll queues
>>> [ 2279.643293] nvme nvme14: 32/0/0 default/read/poll queues
>>> [ 2279.643372] nvme nvme0: 32/0/0 default/read/poll queues
>>> [ 2279.644881] nvme nvme6: 32/0/0 default/read/poll queues
>>> [ 2279.644966] nvme nvme10: 32/0/0 default/read/poll queues
>>> [ 2279.645030] nvme nvme18: 32/0/0 default/read/poll queues
>>> [ 2279.645132] nvme nvme20: 32/0/0 default/read/poll queues
>>> [ 2279.645202] pcieport 0000:10:01.1: AER: device recovery
>>> successful
>>>
>>> 2. Any kernel upstream latest 6.11, RHEL8 or RHEL9 causes 
>>> a machine check and panics the box when its against a nvme in a 
>>> PCIE slot
>>>
>>>   263.862919] mce: [Hardware Error]: CPU 12: Machine Check
>>> Exception: 5
>>> Bank 6: ba00000000000e0b
>>> [  263.862924] mce: [Hardware Error]: RIP !INEXACT!
>>> 10:<ffffffff8571dce4> {intel_idle+0x54/0x90}
>>> [  263.862931] mce: [Hardware Error]: TSC 7a47d8d62ba6dd MISC
>>> 83100000 
>>> [  263.862933] mce: [Hardware Error]: PROCESSOR 0:606a6 TIME
>>> 1727384194
>>> SOCKET 1 APIC 40 microcode d0003a5
>>> [  263.862936] mce: [Hardware Error]: Run the above through 'mcelog
>>> --
>>> ascii'
>>> [  263.885254] mce: [Hardware Error]: Machine check: Processor
>>> context
>>> corrupt
>>> [  263.885259] Kernel panic - not syncing: Fatal machine check
>>>
>>> Hardware event. This is not a software error.
>>> CPU 0 BANK 0 TSC 7a47d8d62ba6dd 
>>> RIP !INEXACT! 10:ffffffff8571dce4
>>> TIME 1727384194 Thu Sep 26 16:56:34 2024
>>> MCG status:
>>> MCi status:
>>> Machine check not valid
>>> Corrected error
>>> MCA: No Error
>>> STATUS 0 MCGSTATUS 0
>>> CPUID Vendor Intel Family 6 Model 106 Step 6
>>> RIP: intel_idle+0x54/0x90}
>>> SOCKET 1 APIC 40 microcode d0003a5
>>> Run the above through 'mcelog --ascii'
>>> Machine check: Processor context corrupt
>>>
>>> Regards
>>> Laurence
>>>
>>>
>>>
>> I think the Keith's email address is not correct. Adding the correct
>> email address of Keith here.
>>
>> BTW, Keith recently help fixed an issue in kernel v6.11 with nvme
>> subsystem-reset command to ensure 
>> that we recover the nvme disk on PPC. On PPC architecture, we use EEH
>> to recover the disk post 
>> subsystem-reset but yours is Intel and that uses AER for recovery. So
>> I'm not sure if that same 
>> commit 210b1f6576e8("nvme-pci: do not directly handle subsys reset
>> fallout") which was merged in 
>> kernel v6.11 causing a side effect on the Intel machine. 
>>
>> Would you please revert the above commit and see if that help fix the
>> observed symptom on your
>> Intel machine? 
>>
>> Thanks,
>> --Nilay
>>
>>
>>
>>
>>
> Hello Nilay
> Thanks will try that.
> Was your IBM PPC issue also only with direct attached PCIE slot based
> nvme.
> Will report back after testing with the revert
> 
On PPC, it doesn't matter whether NVMe disk is directly attached to PHB or 
attached through another PCIe bridge. On PPC we saw that when nvme subsystem-
reset command is executed on an NVMe disk the EEH couldn't recover the disk 
and that' where the above commit (from Keith) helped get the disk recovered 
using EEH after the subsystem-reset command.

Thanks,
--Nilay



