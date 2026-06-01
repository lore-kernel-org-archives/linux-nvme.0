Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26955CD5BD1
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jun 2026 06:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=czQK89r9ESjI1XjNxWBS5FRGe8tFlsKhNiOhOEVpCO0=; b=K3uMbE8zJX5KchwynnlENZljQ9
	S/ejoPvESPGtF4c5Jq9DJNoU1JKIhsYnZ6tASzAsDoi4YN31Mjri4E5BsUKpI0PHGVV/OivEumers
	ubSP+kc+AEgy2m+nM9zhMyr0aflfxOZ4qwsde+cNqeZZA7qQpuywFP45JsTtmG90NbPgqCYcLNFe1
	MOobFRxVYgb+ifL66rqAOYIz3w+9Eb39+KW6Q7Ij95ul/XoKAOFY+2C1bgElY5XIxInt09u5/4ovn
	QOh7/SflTi6M60zzl9FT9dJnuGH18pJiiTeowQLC/N+128TpBfRQP5UUHNF8BQ6v2VEbRexNWTd5t
	UL34Wd+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTvr5-0000000ABQq-2Esk;
	Mon, 01 Jun 2026 06:10:31 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTvr3-0000000ABQU-1Tfx
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jun 2026 06:10:30 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6512KgMi2292720;
	Mon, 1 Jun 2026 06:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=czQK89r9ESjI1XjNxWBS5FRGe8tF
	lsKhNiOhOEVpCO0=; b=FWfc+HpfSsoHulOZRWIVJ4hn+E+mWwiEi2CgAb35X5qn
	X82CxXoJ7vqZH8XX7/yPyLmBxBXHhkZ7VESwPIZZFxVqEWVciPa2yaujyOAc5d0n
	UhsqRRv306M1DunG8Svo3OQBUp19mj0HHkL9Mj9mzopzVnzHx9vglQyLHi11KVAb
	xhUiCUO3v6b8RUaH9NV+eSsPYZ9iOO3omMj+Lpdrf+I+CPLWspIP1aKxPS6C+tX+
	We8HyuFeCRf0tIBdreZa211ylk8K1Wo7bLJ61cKVHQW4qRKAQnucGk1pRZI3WJgC
	XYsURXcHpFFMaQSp2mzxEHM9bjIvEGBfs2Juv2saPA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjpy5p1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 06:10:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651695Ad029737;
	Mon, 1 Jun 2026 06:10:16 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwy4cbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 06:10:16 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6516AFVP24642122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 06:10:15 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0833058064;
	Mon,  1 Jun 2026 06:10:15 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C45558061;
	Mon,  1 Jun 2026 06:10:12 +0000 (GMT)
Received: from [9.61.253.231] (unknown [9.61.253.231])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jun 2026 06:10:11 +0000 (GMT)
Message-ID: <dab729b3-fa8e-4d17-894d-07f0c6845e01@linux.ibm.com>
Date: Mon, 1 Jun 2026 11:40:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [linux-next20260529] WARNING: kernel/workqueue.c:5855 at
 __alloc_workqueue+0x62c/0x690
To: Tejun Heo <tj@kernel.org>, jiangshanlai@gmail.com, hch@lst.de,
        sagi@grimberg.me, kbusch@kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
        marco.crivellari@suse.com, Nilay Shroff <nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: maXBk7fbeGQpAYKVo8GjUQt83VAWa0q9
X-Proofpoint-GUID: iy5I3e4f-_D3HR-GZCRWtq1wGo4gX6Yt
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a1d2249 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=paeGcJy66i2UgEBO6U0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA1OSBTYWx0ZWRfXwbcroq9z+O4h
 jizA8kIRqjYmlf3fGArO7LzS+YvZv4A9xR1gfzDgU+x7hhuVXazZNOykEWHqGMhZjAzxPh5Xy02
 ksLyRitwz4ai023WS2VLcRxATZIWgZokTgc2qXFE2JGOVFPV4y09FD6p/ICVjKy8VJavwe0PWD3
 5ZuPH+khFhn27nqVXUJZrxzxhAcsgApnTQgh90DxlJ/DiqVESflcm7/YV3jpUDpwXUMR2fBcpcZ
 MrzFH15ZahI+Tz8MgqHEs8cBFdopUZy4O/kH0yXw63SB/bkedIIhwHg359FqYx6JEvvE7nrbYT6
 MIg+vIJqVVew2Fs8C1VBaWvOLMw1nWVSjZiijyth52nzHtC/vzhEdtk04GmdNo/+IMfepaUSeAO
 lX4pe5JCeqHBkUhipECkB2BtbV1IG84DduqzhF+X4ORuu9pKKSjUVhmM5rOkTeBpBqzRqhxzI03
 FrTozuLd3GZvNmEFrSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010059
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260531_231029_437325_99E033FA 
X-CRM114-Status: UNSURE (   9.39  )
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

Greetings!!!

I am observing following boot warning, appears to be triggered by recent 
WQ changes.

Test environment:
   Kernel: linux-next-20260529 (7.1.0-rc5-next)
   Arch: powerpc (Power11 / pSeries)


Warnings:



[    1.933519] ------------[ cut here ]------------
[    1.933523] workqueue: nvme_tcp_wq is using neither WQ_PERCPU or 
WQ_UNBOUND. Setting WQ_PERCPU.
[    1.933531] WARNING: kernel/workqueue.c:5855 at 
__alloc_workqueue+0x62c/0x690, CPU#19: modprobe/573
[    1.933539] Modules linked in: nvme_tcp(E+) sd_mod(E) nvme_fabrics(E) 
nvme_core(E) ibmvscsi(E) ibmveth(E) scsi_transport_srp(E) dm_mirror(E) 
dm_region_hash(E) dm_log(E) dm_multipath(E) dm_mod(E)
[    1.933553] CPU: 19 UID: 0 PID: 573 Comm: modprobe Tainted: G         
   E       7.1.0-rc5-next-20260529 #1 PREEMPT
[    1.933559] Tainted: [E]=UNSIGNED_MODULE
[    1.933561] Hardware name: IBM,9080-HEX Power11 (architected) 
0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
[    1.933565] NIP:  c00000000026f59c LR: c00000000026f598 CTR: 
00000000005d54a0
[    1.933568] REGS: c0000000097ff600 TRAP: 0700   Tainted: G       E    
     (7.1.0-rc5-next-20260529)
[    1.933572] MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 
28222282  XER: 00000004
[    1.933581] CFAR: c000000000234154 IRQMASK: 0
[    1.933581] GPR00: c00000000026f598 c0000000097ff8c0 c00000000205b200 
0000000000000053
[    1.933581] GPR04: 3fffffffffff7fff c0000000097ff6b0 c0000000097ff6a8 
00000013f6440000
[    1.933581] GPR08: 0000000000000027 0000000000000000 c0000000c90b2a00 
c0000000037ae1d0
[    1.933581] GPR12: c000000003b2e160 c0000013fffa2300 0000000000000000 
0000000000000000
[    1.933581] GPR16: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[    1.933581] GPR20: 0000000000000000 0000000000000000 0000000000000000 
c000000003fb5d18
[    1.933581] GPR24: c000000003fb55b0 c000000008acc2b8 c008000005390180 
c0000000097ff9c8
[    1.933581] GPR28: 0000000000000000 c000000008acc200 0000000000000000 
0000000000000058
[    1.933619] NIP [c00000000026f59c] __alloc_workqueue+0x62c/0x690
[    1.933623] LR [c00000000026f598] __alloc_workqueue+0x628/0x690
[    1.933627] Call Trace:
[    1.933629] [c0000000097ff8c0] [c00000000026f598] 
__alloc_workqueue+0x628/0x690 (unreliable)
[    1.933635] [c0000000097ff970] [c00000000026f634] 
alloc_workqueue_noprof+0x34/0x50
[    1.933640] [c0000000097ff990] [c008000005316428] 
nvme_tcp_init_module+0x54/0xf4 [nvme_tcp]
[    1.933645] [c0000000097ffa10] [c000000000010f7c] 
do_one_initcall+0x5c/0x45c
[    1.933650] [c0000000097ffb00] [c000000000358b10] 
do_init_module+0x70/0x380
[    1.933655] [c0000000097ffb80] [c00000000035ac10] 
init_module_from_file+0x110/0x130
[    1.933659] [c0000000097ffc60] [c00000000035ad84] 
idempotent_init_module+0x154/0x3c0
[    1.933663] [c0000000097ffd20] [c00000000035b080] 
sys_finit_module+0x90/0x150
[    1.933667] [c0000000097ffda0] [c000000000034318] 
system_call_exception+0x148/0x4b0
[    1.933672] [c0000000097ffe30] [c00000000000d05c] 
system_call_vectored_common+0x15c/0x2ec
[    1.933678] ---- interrupt: 3000 at 0x7fff98bab0bc
[    1.933682] NIP:  00007fff98bab0bc LR: 00007fff98bab0bc CTR: 
0000000000000000
[    1.933685] REGS: c0000000097ffe60 TRAP: 3000   Tainted: G       E    
     (7.1.0-rc5-next-20260529)
[    1.933688] MSR:  800000000000f033 <SF,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 
40222404  XER: 00000000
[    1.933697] IRQMASK: 0
[    1.933697] GPR00: 0000000000000161 00007fffda9c33d0 00007fff98c97c00 
0000000000000005
[    1.933697] GPR04: 00000001034dbf48 0000000000000000 0000000000000000 
0000000000000000
[    1.933697] GPR08: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[    1.933697] GPR12: 0000000000000000 00007fff994bcac0 000000013fcd0720 
000000013fcd1c28
[    1.933697] GPR16: 000000013fce06a0 0000000000000208 0000000000000020 
0000000000000000
[    1.933697] GPR20: 0000000000000000 0000000000000000 000000013fcd1bc0 
0000000000000000
[    1.933697] GPR24: 000000013fcd3200 000000013fcd21d0 00000001034dcf18 
000000013fcd1d50
[    1.933697] GPR28: 00000001034dbf48 0000000000060000 000000013fcd1bc0 
000000013fcd2290
[    1.933733] NIP [00007fff98bab0bc] 0x7fff98bab0bc
[    1.933736] LR [00007fff98bab0bc] 0x7fff98bab0bc
[    1.933739] ---- interrupt: 3000
[    1.933741] Code: 4bffff34 3d22ff9c 3b496760 4bfffbfc 3c62ff89 
39200001 3d4201d0 7f24cb78 38638d60 992ab08a 4bfc4ab5 60000000 
<0fe00000> 4bffff60 3c62ff89 39200001
[    1.933753] ---[ end trace 0000000000000000 ]---



If you happen to fix, this please add below tag.


Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.



