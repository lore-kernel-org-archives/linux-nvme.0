Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A837C636CD
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Feb 2023 14:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=MGhDneE5gS1B7db4U2DCznzC/szcHVVcEjc3QBxgr9Q=; b=t1sNtxmVSZGAbTfDA5wpbGqqzd
	TUX85GuxRPRrbHReK3ZkQExPIi0vZDuLhw8kknrrsZhnltrHr6GFPjDShmVDw3HwHYBDr4FJ+3lEm
	2rmkt7mWX9jBzPajjwqtLPMeaHz92kPQrKeeTzKqRdHZggTcF5YiEoHI8fxDwuhRGtJSdnCiLpOv4
	28AOXbT+2sG9gOxpwh2GzLYKa5btvDC3gVIXy8OoxCIUSJRjCeQiuWBH84mURcZMN8GDywqZZbl2l
	pjICn6fgh7WVgeo+FfG/QyBdvqUcN1Mp53r5/4HdXePXott0Y9O/8nweaj+OvTERm6O9KqIccdmKh
	96CZc63w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQUUu-0063my-73; Fri, 10 Feb 2023 14:35:32 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQUUr-0063m3-Cz
	for linux-nvme@lists.infradead.org; Fri, 10 Feb 2023 14:35:31 +0000
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AEVx0R008792;
	Fri, 10 Feb 2023 14:35:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=MGhDneE5gS1B7db4U2DCznzC/szcHVVcEjc3QBxgr9Q=;
 b=pxmziH/VwSoveR4lvrUl2QmhcHlPVl2CXjC+6LdfxnuJ7N1AD+KvqkwgchL5fTfzhlxY
 sJN4Kldj0a62xEuiiqhxcTOnOzqbnal4ZkXKV7SgqvVucOG7gjzJ8Md9rdl0NbLejRl2
 bLMEh1omg0sb/2pMlDngZDyHXAJSUhcMCuQ+pJvEGEohA7Z56ozBMueqlvxI6B38SOhP
 igY12ipXTV8S3fAYeJCl3Y73IKpxr95WMiIzsY/y8vfpHp/Aav7kV5wHwDarIEahG+C6
 h6JEu3S+lo4EmE1A+J9BEztSNFTQs7lVdS7xBPOzS6ngZlk2lI0hF817XjgPTLwHy+hM Qg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnqs7020p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Feb 2023 14:34:57 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
	by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31A6OvhJ020939;
	Fri, 10 Feb 2023 14:34:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3nhemfqnkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Feb 2023 14:34:12 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31AEYAqR25494182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Feb 2023 14:34:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F28A020040;
	Fri, 10 Feb 2023 14:34:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95A9C20063;
	Fri, 10 Feb 2023 14:34:09 +0000 (GMT)
Received: from [9.171.67.142] (unknown [9.171.67.142])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Feb 2023 14:34:09 +0000 (GMT)
Message-ID: <fb65a843ba3da23dbb5b7423a2d413c0f263604d.camel@linux.ibm.com>
Subject: Re: [PATCH 0/4] nvme patches for 6.3
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: hch@lst.de
Cc: kbusch@kernel.org, kbusch@meta.com, linux-nvme@lists.infradead.org,
        sagi@grimberg.me
Date: Fri, 10 Feb 2023 15:34:09 +0100
In-Reply-To: <20230108182219.GD25544@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LtN4LTUlca61cDUEZUn4OFnxicbSbTss
X-Proofpoint-GUID: LtN4LTUlca61cDUEZUn4OFnxicbSbTss
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_08,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=499 phishscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100120
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230210_063529_604063_CA0B0C9E 
X-CRM114-Status: GOOD (  17.47  )
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

Hi Christoph, Hi Keith,

It looks like this series causes crashes on s390x.
With current linux-next-20230210 and a Samsung PM173X I get the
below[0] crash. Reverting patches 1-3 makes the NVMe work again. I
tried reverting just patch 3 and 2/3 but this results in crashes as
well and as far as I can see patches 2/3 depend on each other. Not
entirely sure what's going on but patch 3 mentions padding to the cache
line size and our 256 byte cache lines are definitely unusual. I didn't
see any obvious place where this would break things though. I did debug
that in the crashing nvme_unmap_data() iod->nr_allocations is -1 and
iod->use_sgl is true which is weird since it looks to me like iod-
>nr_allocations should only be -1 if sg_list couldn't be allocated from
the pool.

Best regards,
Niklas

[0] =C2=A0
[   10.631468] nvme nvme0: Shutdown timeout set to 10 seconds
[   10.639143] nvme nvme0: 63/0/0 default/read/poll queues
[   10.646890]  nvme0n1: p1
[   10.652923] Unable to handle kernel pointer dereference in virtual kerne=
l address space
[   10.652927] Failing address: 0000000000000000 TEID: 0000000000000483
[   10.652929] Fault in home space mode while using kernel ASCE.
[   10.652932] AS:00000001ae5c8007 R3:000000027fffc007 S:000000027fffb800 P=
:000000000000003d
[   10.652950] Oops: 0004 ilc:3 [#1] SMP
[   10.652954] Modules linked in: aes_s390(E+) des_s390(E) libdes(E) sha3_5=
12_s390(E) sha3_256_s390(E) sha512_s390(E) sha256_s390(E) nvme(E) sha1_s390=
(E) sha_common(E) nvme_core(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(=
E) pkey(E) zcrypt(E) rng_core(E) dm_multipath(E) autofs4(E)
[   10.652968] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G            E      6=
.2.0-20230209.rc7.git113.20f513df926f.300.fc37.s390x+next #1
[   10.652971] Hardware name: IBM 8561 T01 703 (LPAR)
[   10.652973] Krnl PSW : 0404c00180000000 00000001aca225c6 (dma_pool_free+=
0x4e/0xe8)
[   10.652984]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:=
0 RI:0 EA:3
[   10.652987] Krnl GPRS: 00000000fffffff4 0000000100000000 000000008397c49=
0 0000000000000004
[   10.652990]            0000000000000000 ffffffe000000000 000000000000000=
0 0000000095e80400
[   10.652992]            04000001ace74d6e 0000000000000000 000000000000000=
0 000000008397c480
[   10.652994]            00000000803aa100 0000000000000001 000003800081bb1=
0 000003800081bac0
[   10.653003] Krnl Code: 00000001aca225b6: ba13b010\x09\x09cs\x09%r1,%r3,1=
6(%r11)
                          00000001aca225ba: ec160048007e\x09cij\x09%r1,0,6,=
00000001aca2264a
                         #00000001aca225c0: c00400000024\x09brcl\x090,00000=
001aca22608
                         >00000001aca225c6: e390a0080024\x09stg\x09%r9,8(%r=
10)
                          00000001aca225cc: e310b0180004\x09lg\x09%r1,24(%r=
11)
                          00000001aca225d2: e310a0000024\x09stg\x09%r1,0(%r=
10)
                          00000001aca225d8: e3a0b0180024\x09stg\x09%r10,24(=
%r11)
                          00000001aca225de: ebffb028007a\x09agsi\x0940(%r11=
),-1
[   10.653039] Call Trace:
[   10.653042]  [<00000001aca225c6>] dma_pool_free+0x4e/0xe8
[   10.653049]  [<000003ff7fcd02e8>] nvme_unmap_data+0x98/0x168 [nvme]
[   10.653054]  [<000003ff7fcd043c>] nvme_pci_complete_batch+0x84/0x100 [nv=
me]
[   10.653058]  [<000003ff7fcd0b34>] nvme_irq+0x64/0x80 [nvme]
[   10.653061]  [<00000001ac80b1c6>] __handle_irq_event_percpu+0x5e/0x1b8
[   10.653065]  [<00000001ac80b346>] handle_irq_event_percpu+0x26/0x70
[   10.653068]  [<00000001ac8112f0>] handle_percpu_irq+0x68/0x90
[   10.653072]  [<00000001ac809c8e>] generic_handle_irq+0x3e/0x60
[   10.653074]  [<00000001ac77f794>] zpci_floating_irq_handler+0xdc/0x190
[   10.653079]  [<00000001ad2f212e>] do_airq_interrupt+0x8e/0xf0
[   10.653085]  [<00000001ac80b1c6>] __handle_irq_event_percpu+0x5e/0x1b8
[   10.653087]  [<00000001ac80b346>] handle_irq_event_percpu+0x26/0x70
[   10.653090]  [<00000001ac8112f0>] handle_percpu_irq+0x68/0x90
[   10.653092]  [<00000001ac809c8e>] generic_handle_irq+0x3e/0x60
[   10.653094]  [<00000001ac7451d8>] do_irq_async+0x50/0xb0
[   10.653100]  [<00000001ad3b5dca>] do_io_irq+0xba/0x168
[   10.653103]  [<00000001ad3c5736>] io_int_handler+0xd6/0x110
[   10.653107]  [<00000001ad3c57b6>] psw_idle_exit+0x0/0xa
[   10.653109] ([<00000001ad3b6aac>] default_idle_call+0x3c/0x108)
[   10.653112]  [<00000001ac7ea43c>] do_idle+0xd4/0x168
[   10.653115]  [<00000001ac7ea696>] cpu_startup_entry+0x36/0x40
[   10.653118]  [<00000001ac750ac4>] smp_start_secondary+0x12c/0x138
[   10.653121]  [<00000001ad3c5a5e>] restart_int_handler+0x6e/0x90
[   10.653123] Last Breaking-Event-Address:
[   10.653124]  [<000003ff7fccd2a4>] 0x3ff7fccd2a4
[   10.653130] Kernel panic - not syncing: Fatal exception in interrupt


