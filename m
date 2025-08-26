Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACDECA0FED
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Aug 2025 08:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hUE7o9vZl5j5DnrUBirTTuYgI8o7HaFbW6jKSUkPZTA=; b=j2oe6pFR6gcOnPPJ6F7XpHJ4Sd
	cTE85NCyM4XIrXrYG82yoEggV7t50yo26LQlUFDza7iS2cXnk0xIZqdLTocbsGJLhBrcIaxb0IgSd
	/6tR1eFZepJCpE6wGuT63Nf+gRuGr7PiEtVTyAbOKp+YAMmZLoGXTxuij002KSRfrViEMWz9/gy3Q
	6BHGMTwVA0RxAspIE7IFFA7f8DzLadAWX3fCD7d5Wonu3reb12X6TNg1AI3YVwfm0EPBXDRuZNz+N
	AVBJh2+lpVCuy2FYvL1NjvRdqV5172tU2+NOFZwi3BPVbxG8RI7rJzVtwL3hEMjI/ecvkda9ubpVi
	TL71yNCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqp8N-0000000B25t-2pSz;
	Tue, 26 Aug 2025 08:34:27 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqp5K-0000000B1UH-2tSb
	for linux-nvme@lists.infradead.org;
	Tue, 26 Aug 2025 08:31:20 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q4jMgm032655;
	Tue, 26 Aug 2025 08:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=hUE7o9vZl5j5DnrUBirTTuYgI8o7
	HaFbW6jKSUkPZTA=; b=dMWGcxyxTmQic1+2X7rk7A5T0XdfN/IVR1XSpsZF48N4
	S8aAwJWMNGQzvCePS5S1S+H2jBVHx9UrvWnssH8H5u0Iie+xPpYNghuNO8EKlGIU
	7B8eeMkPbF0NY11+qpyZlF1McRIAdIcVw4D1b3u7VPCvNT2gC3ijNqWJytdDhmow
	SzjnbZYIkKJifUjatcbp4jqyIy8qeUTtQAZbyOK1Yup6a7V+Cdhnjlwe/ljYyx9S
	5ygHED06tEL8ayMSyUJ/gpYysq8hTUJj8l8YGbrnCrxpPPUmnv+tW3APD5X3uv6d
	zcz0qyOjOAt+T7EfTW74LxtyaoFD3eXMDjUPfnym+g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q9754rsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 08:31:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q4N472018006;
	Tue, 26 Aug 2025 08:31:01 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qtp39jgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 08:31:01 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57Q8Uxhg62980404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 08:30:59 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65A225804B;
	Tue, 26 Aug 2025 08:30:59 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E9CD58059;
	Tue, 26 Aug 2025 08:30:58 +0000 (GMT)
Received: from [9.61.240.126] (unknown [9.61.240.126])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Aug 2025 08:30:57 +0000 (GMT)
Message-ID: <3a07b752-06a4-4eee-b302-f4669feb859d@linux.ibm.com>
Date: Tue, 26 Aug 2025 14:00:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
        Nilay Shroff <nilay@linux.ibm.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [blktest/nvme/058] Kernel OOPs while running nvme/058 tests
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 51V9u7WJuziGPFYiMyiwlt7S5qDQARdP
X-Proofpoint-ORIG-GUID: 51V9u7WJuziGPFYiMyiwlt7S5qDQARdP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA3MSBTYWx0ZWRfX/rPYb973m5vn
 xdduOqpvljxKKXWkJGGP2nt/8sy8tjVX48dz4XIKuRdtMCkJW3lc44crZUwNNIFTW4/JL9Dp6s7
 zfpxyon6QZCpqckE9zqKc960b2TA/DFCa9tB4MIt+WBOua9xFndwChjEdI1JtWZAgnLhWNjHbNt
 TpXcQSvKAWZbSU/gXfs33YHFLFQregIgWo48R4fgGOjMlOm8jkk7s5BH8xPvLVQeWIR0JrcusJT
 UWDRf3W6Z9uONEBuqYinuCR2tWztnc4eJrX/oOjrK8cWwrIjo7uWAD0nH+GbYEHTb4/e7y7z+cM
 sKHLtut0xpXbg7Xvi7dqX88Vw0OQeTjiWk3fGyV26YBM/RJPdB0FAf5bwgQfVVBvz+6i8PJpCmY
 YTL25oFa
X-Authority-Analysis: v=2.4 cv=RtDFLDmK c=1 sm=1 tr=0 ts=68ad70c6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Acd4I7jP6iG7ARs4AGsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 clxscore=1011 phishscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230071
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250826_013119_107070_CB200277 
X-CRM114-Status: UNSURE (   7.70  )
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


IBM CI has reported a kernel OOPs, while running blktest suite(nvme/058 
test).


Kernel Repo: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git


Traces:


[37496.800225] BUG: Kernel NULL pointer dereference at 0x00000000
[37496.800230] Faulting instruction address: 0xc0000000008a34b0
[37496.800235] Oops: Kernel access of bad area, sig: 11 [#1]
[37496.800239] LE PAGE_SIZE=64K MMU=Hash  SMP NR_CPUS=8192 NUMA pSeries
[37496.800245] Modules linked in: nvme_loop(E) nft_compat(E) bonding(E) 
nft_fib_inet(E) nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) 
nft_reject_inet(E) nf_reject_ipv4(E) nf_reject_ipv6(E) nft_reject(E) 
nft_ct(E) nft_chain_nat(E) rfkill(E) ip_set(E) mlx5_ib(E) ib_uverbs(E) 
ib_core(E) pseries_rng(E) vmx_crypto(E) drm(E) 
drm_panel_orientation_quirks(E) xfs(E) sr_mod(E) cdrom(E) sd_mod(E) 
sg(E) lpfc(E) nvmet_fc(E) ibmvscsi(E) mlx5_core(E) ibmveth(E) 
scsi_transport_srp(E) nvmet(E) nvme_fc(E) nvme_fabrics(E) mlxfw(E) 
nvme_core(E) tls(E) scsi_transport_fc(E) psample(E) fuse(E) [last 
unloaded: nvme_loop(E)]
[37496.800309] CPU: 40 UID: 0 PID: 417 Comm: kworker/40:1H Kdump: loaded 
Tainted: G            E       6.17.0-rc3-gb6add54ba618 #1 VOLUNTARY
[37496.800317] Tainted: [E]=UNSIGNED_MODULE
[37496.800320] Hardware name: IBM,8375-42A POWER9 (architected) 0x4e0202 
0xf000005 of:IBM,FW950.80 (VL950_131) hv:phyp pSeries
[37496.800326] Workqueue: kblockd nvme_requeue_work [nvme_core]
[37496.800339] NIP:  c0000000008a34b0 LR: c000000000869654 CTR: 
c00000000086954c
[37496.800344] REGS: c000000015e97970 TRAP: 0380   Tainted: G       E    
     (6.17.0-rc3-gb6add54ba618)
[37496.800349] MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  
CR: 4800020f  XER: 0000000f
[37496.800365] CFAR: c000000000869650 IRQMASK: 0
[37496.800365] GPR00: c000000000869654 c000000015e97c10 c000000001c88100 
0000000000000000
[37496.800365] GPR04: c0000000b005c400 c000000015e979d0 c000000015e979c8 
0000001037ba0000
[37496.800365] GPR08: 0000000000000100 c00000013923db18 0000000000000140 
c008000005bba2d0
[37496.800365] GPR12: c00000000086954c c000000017f7e700 c0000000001aab20 
c000000015b533c0
[37496.800365] GPR16: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[37496.800365] GPR20: c000001039e1c418 c000000002e075d0 c0000000027a3818 
fffffffffffffef7
[37496.800365] GPR24: 0000000000000402 c000000015b72000 c0000001c0374850 
c000000134492010
[37496.800365] GPR28: 0000000000000001 0000000000000001 c0000000b005c400 
0000000000000000
[37496.800424] NIP [c0000000008a34b0] __rq_qos_done_bio+0x3c/0x88
[37496.800433] LR [c000000000869654] bio_endio+0x108/0x2b8
[37496.800440] Call Trace:
[37496.800442] [c000000015e97c40] [c000000000869654] bio_endio+0x108/0x2b8
[37496.800450] [c000000015e97c80] [c008000005bb6794] 
nvme_ns_head_submit_bio+0x25c/0x358 [nvme_core]
[37496.800462] [c000000015e97d10] [c00000000087320c] 
__submit_bio+0x150/0x304
[37496.800469] [c000000015e97da0] [c000000000873444] 
__submit_bio_noacct+0x84/0x250
[37496.800476] [c000000015e97e10] [c008000005bb5540] 
nvme_requeue_work+0x94/0xd8 [nvme_core]
[37496.800488] [c000000015e97e40] [c00000000019c72c] 
process_one_work+0x1fc/0x4ac
[37496.800497] [c000000015e97ef0] [c00000000019d6dc] 
worker_thread+0x340/0x510
[37496.800504] [c000000015e97f90] [c0000000001aac4c] kthread+0x134/0x164
[37496.800512] [c000000015e97fe0] [c00000000000df78] 
start_kernel_thread+0x14/0x18
[37496.800518] Code: 60000000 7c0802a6 fbc1fff0 fbe1fff8 7c9e2378 
7c7f1b78 f8010010 f821ffd1 f8410018 60000000 60000000 60000000 
<e93f0000> 7fe3fb78 7fc4f378 e9290030
[37496.800540] ---[ end trace 0000000000000000 ]---
[37496.827403] pstore: backend (nvram) writing error (-1)
[37496.827409]


If you happen to fix this, please add below tag.


Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.


