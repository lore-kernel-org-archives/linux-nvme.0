Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606EDE77188
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Jan 2025 12:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=visb8OqqaYOrWp/TWPu1WyHlO1xSZp5r8+E3G5SoWtk=; b=DcKF3sIIoSCD5ALd2fKZuDJ6Bs
	78/wY1i0Wy01/od6KEnFLxPgLJSTqftE21dKDu0ph+q6Z8gPEHVfqL//i4COpfkxazViO5qE406hM
	sW0pDKTkx8rEHEc4dmIwnAwzKuqYYlPKKTSMyf5HyMBaajL33IeiTCJ6SKUVtHU+tLUg55uHpCaNB
	xRUAh4ciiSaQtslB44qXGViltoWHM9hLSwAeQrhktgW5FWNFrhWlrr2eETjtVRWiVnFs/lxKGbGL+
	Lert8k80qADZ3BxNhxt5VQ+mmIFqv5ACOQzid7MwKYAKeFpslQU0PI9w24eU45dp/9HcXn8w1iRcC
	zQNdZ9+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWwvL-00000002eEj-0Q5x;
	Sun, 12 Jan 2025 12:18:35 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWwvJ-00000002eE4-0Xgz
	for linux-nvme@lists.infradead.org;
	Sun, 12 Jan 2025 12:18:34 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50C5is5J032365;
	Sun, 12 Jan 2025 12:18:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=visb8O
	qqaYOrWp/TWPu1WyHlO1xSZp5r8+E3G5SoWtk=; b=Vt2D0z8hQGIm5Ku4+PQPtc
	onJrhMf8S0XByVCf8LQDBSkp+Am5qi0oxPzwX/oanaNgGjI9Z8fOYs/ETAbLqbVc
	iy6nujwi0kCj2gb8RtjyzqmflLX/FBUu0WyFsNiL956BqpIEnCspzzwLR6kCU8kk
	aZDg6ljOqF960Iu/OuvVf5oyIMIQt92xIoRF31lVzYiWgHv1I3DqPS88ajC0MNm9
	5j2yL0uD5W2vMQhk+lecHwdFuH+SHmWX19F2ThU4dimJFUZ0zoUPGhxPXhPZCjYF
	KigmDQ9hy8hhvJfFocBSMPJyrcUV6D9qOEPEUfRSo2Cnj+2HxGYfy86fZue0xeLw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4442fahdvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jan 2025 12:18:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50C7UAjY017014;
	Sun, 12 Jan 2025 12:18:17 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4444fjsna1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jan 2025 12:18:17 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50CCIHx223069408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Jan 2025 12:18:17 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FA7658055;
	Sun, 12 Jan 2025 12:18:17 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 071805804B;
	Sun, 12 Jan 2025 12:18:15 +0000 (GMT)
Received: from [9.171.76.196] (unknown [9.171.76.196])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 12 Jan 2025 12:18:14 +0000 (GMT)
Message-ID: <62aef144-81d1-4fc7-b1c0-3a45fba27cae@linux.ibm.com>
Date: Sun, 12 Jan 2025 17:48:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 RFC 0/3] Add visibility for native NVMe multipath using
 sysfs
To: Keith Busch <kbusch@kernel.org>
Cc: dwagner@suse.de, hare@suse.de, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
        gjoyce@linux.ibm.com, linux-nvme@lists.infradead.org
References: <20241213041908.1381196-1-nilay@linux.ibm.com>
 <Z36sNBMPV7--2XHw@kbusch-mbp> <Z4FBFSGCfHC4PYYi@kbusch-mbp>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Z4FBFSGCfHC4PYYi@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jntFahrmcqLmant9faYYmOMI6_2QpDA7
X-Proofpoint-GUID: jntFahrmcqLmant9faYYmOMI6_2QpDA7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501120107
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250112_041833_305135_325202A3 
X-CRM114-Status: GOOD (  26.16  )
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



On 1/10/25 9:17 PM, Keith Busch wrote:
> On Wed, Jan 08, 2025 at 09:47:48AM -0700, Keith Busch wrote:
>> On Fri, Dec 13, 2024 at 09:48:33AM +0530, Nilay Shroff wrote:
>>> This RFC propose adding new sysfs attributes for adding visibility of
>>> nvme native multipath I/O.
>>>
>>> The changes are divided into three patches.
>>> The first patch adds visibility for round-robin io-policy.
>>> The second patch adds visibility for numa io-policy.
>>> The third patch adds the visibility for queue-depth io-policy.
>>
>> Thanks, applied to nvme-6.14.
> 
> I think I have to back this out of nvme-6.14 for now. This appears to be
> causing a problem with blktests, test case trtype = loop nvme/058, as
> reported by Chaitanya.
> 
> Here's a snippet of the kernel messages related to this:
> 
> [ 9031.706759] sysfs: cannot create duplicate filename '/devices/virtual/nvme-subsystem/nvme-subsys1/nvme1n2/multipath/nvme1c4n2'
> [ 9031.706767] CPU: 41 UID: 0 PID: 52494 Comm: kworker/u192:61 Tainted:G        W  O     N 6.13.0-rc4nvme+ #109
> [ 9031.706775] Tainted: [W]=WARN, [O]=OOT_MODULE, [N]=TEST
> [ 9031.706777] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [ 9031.706781] Workqueue: async async_run_entry_fn
> [ 9031.706790] Call Trace:
> [ 9031.706795]  <TASK>
> [ 9031.706798]  dump_stack_lvl+0x94/0xb0
> [ 9031.706806]  sysfs_warn_dup+0x5b/0x70
> [ 9031.706812]  sysfs_do_create_link_sd+0xce/0xe0
> [ 9031.706817]  sysfs_add_link_to_group+0x35/0x60
> [ 9031.706823]  nvme_mpath_add_sysfs_link+0xc3/0x160 [nvme_core]
> [ 9031.706848]  nvme_mpath_set_live+0xb9/0x1f0 [nvme_core]
> [ 9031.706865]  nvme_mpath_add_disk+0x10b/0x130 [nvme_core]
> [ 9031.706883]  nvme_alloc_ns+0x8d5/0xc80 [nvme_core]
> [ 9031.706904]  nvme_scan_ns+0x280/0x350 [nvme_core]
> [ 9031.706920]  ? do_raw_spin_unlock+0x4e/0xc0
> [ 9031.706929]  async_run_entry_fn+0x31/0x130
> [ 9031.706934]  process_one_work+0x1f9/0x630
> [ 9031.706943]  worker_thread+0x191/0x330
> [ 9031.706948]  ? __pfx_worker_thread+0x10/0x10
> [ 9031.706952]  kthread+0xe1/0x120
> [ 9031.706956]  ? __pfx_kthread+0x10/0x10
> [ 9031.706959]  ret_from_fork+0x31/0x50
> [ 9031.706965]  ? __pfx_kthread+0x10/0x10
> [ 9031.706968]  ret_from_fork_asm+0x1a/0x30
> [ 9031.706980]  </TASK>
> [ 9031.707062] block nvme1n2: failed to create link to nvme1c4n2
> 
> 
Thank you for the report! Yes indeed it failed with trtype=loop and nvme/058.
I further investigated it and found that nvme/058 creates 3 shared namespaces
and then attaches those namespaces to 6 different controllers. Later it rapidly 
(in quick succession) unmaps and then maps those namespaces in random order. 
So that causes multiple nvme paths being simultaneously added/removed in the 
host. During those simultaneous add/remove operations, sometimes we trap into 
the observed symptom as reported above.

So we have to protect nvme_mpath_add_sysfs_link() from simultaneous add/remove
ns paths. Fortunately it's not so difficult to protect it. There're two things 
we need to ensure:

1. Don't try to recreate the sysfs link if it's already created:
The current code uses flag NVME_NS_SYSFS_ATTR_LINK which is marked against ns->flags
when link from head node to the ns path node is added. The current code uses test_bit() 
to evaluate if that flag is set or not. If it's not set then we create link and then 
mark NVME_NS_SYSFS_ATTR_LINK against ns->flags. However this is not safe and we need to
replace test_bit() with test_and_set_bit() which helps set the flag atomically.

2. Don't create the link from head node to ns path node if disk is not yet added:
As sysfs link is created between kobjects of the head dev node and ns path dev node,
we have to ensure that it's only after device_add_disk() successfully returns for
both head disk and path node disk, we attempt to create the link otherwise sysfs/kernfs 
would complain loudly. So we just need to test against GD_ADDED flag for both head disk 
and path disk and it's only after respective disks are added, we attempt create sysfs link.

I have made above two changes and tested the code against blktest nvme/058. Now I see 
that test pass without any issue. I tested the script for hundreds of times and it 
passed each iteration. So with the above two changes, I will spin a patch and submit 
upstream. Please help review the same.

Thanks,
--Nilay


