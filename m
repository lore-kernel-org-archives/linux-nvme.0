Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B7BC5DF81
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2026 20:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T2UuD3eSgcHvY/KsgJOfximiozWBdtw4e1vlrx/urLs=; b=uGWdGQJIPze428ggFRDd0Fj6Ul
	kAGXvvCZZRzQgFAxGOI/WfStOLNKDUkQYAX5KkL064OkhEzwezDT685UOeH7otWU7kEIdIHMi6Vs0
	qtKu9aS3aTY2TI3etpS76p024WFQiu+bPJjPbCfr/V5x1laf18RAUXgVlHepvqoFKz3z5EQT7qTWU
	6wjUH8/Vr3CXnBEwFrJnv9kyLZSxcNJ7UJFm7L8OZEIXrL9qxN2IFJ3QS6TOCeQ0f7nXQ3eATNyhq
	h6EGqCUPcb3hcIDaMtex/mW1LnLDCYE+K6yQGaPfV7W3pDSFVK9HK67oigQp4mQmIKF+aniuIefQy
	hghWDAiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wybCf-0000000HMQ1-2pIv;
	Mon, 24 Aug 2026 20:23:33 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wybCb-0000000HMPf-3BM7
	for linux-nvme@lists.infradead.org;
	Mon, 24 Aug 2026 20:23:30 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OJVnVS2744644;
	Mon, 24 Aug 2026 20:23:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=T2UuD3
	eSgcHvY/KsgJOfximiozWBdtw4e1vlrx/urLs=; b=La3OtirEyBVp7nR9ErjtRf
	FR7TXvLdIVZNzYMrg8UBoGo64DxGvdWctINu8wOI/BYetqA+5UUIiWFR8YMJIObl
	kjLd2oblOo5fUiWm1C/nmjcgP1uZTHMcWSyCjSXLXnQ2jw+rcsNXN9M/drPa32Z0
	XCb4GfypGksOOJupy1SNQ8seUNs29kamsUewB16kyt/tIr3sIgwaJ6nvTkVMNbi9
	p6T5MgKGNhNcwG0k8jM/BO+42L6Lh6xVAcJVWx+qBeB4PLJpQbra863Ery3letKl
	dbN7dv3id+AnmJYY7NB8hAIY2l/hgZSvQ6wG1iykdcc2HZbmAusrL+rNqTugt9xA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hm6h6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 20:23:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OKBMkt004598;
	Mon, 24 Aug 2026 20:23:14 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3q0hcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 20:23:14 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OKNBQ328246706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 20:23:11 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B4D358056;
	Mon, 24 Aug 2026 20:23:11 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD4D958052;
	Mon, 24 Aug 2026 20:23:10 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 20:23:10 +0000 (GMT)
MIME-Version: 1.0
Date: Mon, 24 Aug 2026 15:23:10 -0500
From: Wen Xiong <wenxiong@linux.ibm.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, gjoyce@linux.ibm.com,
        wenxiong@us.ibm.com
Subject: Re: [PATCH V2] nvme: Add module reference counting for multipath
 devices
In-Reply-To: <d58d0c4f-0789-4c99-94bc-e2e2121e7b7a@grimberg.me>
References: <20260812223206.720363-1-wenxiong@linux.ibm.com>
 <a9d90f41-1493-4efa-abd1-a7071046414a@grimberg.me>
 <d58d0c4f-0789-4c99-94bc-e2e2121e7b7a@grimberg.me>
Message-ID: <af79f498b1287a3304db97477452537f@linux.ibm.com>
X-Sender: wenxiong@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE2OSBTYWx0ZWRfX6pQjrYwpe+Y1
 saDp80+VYPfXyyfci+pAjwY6HRsB2MUrX2rWY9od6l8+yImCSzp5q0S4R8Ys/0KZGSWUOqNjmiO
 ypE2D92ixSgaCACzrratIxOcg82qIqU=
X-Proofpoint-GUID: hRexQk6KRtpF-2iryVWx76wUvya_O1zs
X-Proofpoint-ORIG-GUID: hRexQk6KRtpF-2iryVWx76wUvya_O1zs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE2OSBTYWx0ZWRfX0ITef+LtbVKP
 3eD5KHu1T4CMK2X/n/5ATxeAliOeDUPjtunLljPaLWWHeL1Aljk4ztfHen6am/ZPe3xC0Vj/q8t
 Y913F6sxbq3iTzKmOMLA0ANwG8FUJPM9L0Zlqy3RdtBNfRbn/PrYDCm3b3Xskf4TjoV26tgeXY+
 RGlhH+Z5cvLyLnTI1OmveBIEPC/CiBuSA+hcY6Mts2ekCQ6C3f2GkydRGqh4qMx2/CBubisX8J7
 jcW4ERW8ykEEMcbjhBtDVTTTasgTgCzQp0S/cKFvsnkmCR/DF4dTPoAM/3AYJRXoVqYEje6i+Gc
 ZW62wsXZp3w19b72gF2/tt2+mMEg9l3wSWyW/huyGVe31oW3t0X11g67hrXh/qtA7GuBIril6L5
 3LyMoKNeP7zg1mKNo+8KDBJjxZGbMpAGqy0DDu+TSJeIRuX7F/o2uhbkuu4uegM2z2t5BHxHEln
 /Krwse/Vb6aUjHdoiMQ==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8ca833 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=2MR6PaJL-F8Ac8TQl58A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240169
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_132329_915916_C2D38DA9 
X-CRM114-Status: GOOD (  19.83  )
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

On 2026-08-22 19:46, Sagi Grimberg wrote:

> OK, I now read the original report regarding nvme root device. please 
> disregard.
Hi Sagi,

Thanks for taking the time to review this!

If multipath NVMe is the root device and there is no single NVMe device 
in the system, the tester can still rmmod nvme because the NVMe module's 
reference count is 0 (PCIe).

For example,
System has 2 multipath nvme devices(nvme0 has 1 NS and nvme1 has 2 NS).
# nvme list
Node                  Generic               SN                   Model   
                                  Namespace  Usage                      
Format           FW Rev
--------------------- --------------------- -------------------- 
---------------------------------------- ---------- 
-------------------------- ---------------- --------
/dev/nvme0n1          /dev/ng0n1            S6RUNE0R900042       1.6TB 
NVMe Gen4 U.2 SSD III              0x1        400.08  GB / 400.08  GB    
   4 KiB +  0 B   REV.SN66
/dev/nvme1n1          /dev/ng1n1            S6KZNE0RA00056       800GB 
NVMe Gen4 U.2 SSD                  0x1        400.08  GB / 400.08  GB    
   4 KiB +  0 B   REV.SN4B
/dev/nvme1n2          /dev/ng1n2            S6KZNE0RA00056       800GB 
NVMe Gen4 U.2 SSD

Without patch, reference count of nvme module is 0, "rmmod nvme" causes 
system crashing.
#lsmod|grep nvme
  nvme_tcp              262144  0
nvme                  262144  0
nvme_fabrics          262144  1 nvme_tcp
nvme_core             458752  7 nvme_tcp,nvme,nvme_fabrics
nvme_keyring          262144  3 nvme_tcp,nvme_core,nvme_fabrics
nvme_auth             262144  1 nvme_core

static int nvme_ns_open(struct nvme_ns *ns)
{

         /* should never be called due to GENHD_FL_HIDDEN */
         if (WARN_ON_ONCE(nvme_ns_head_multipath(ns->head))) ---------> 
skip multipath devs
                 goto fail;
         if (!nvme_get_ns(ns))
                 goto fail;
         if (!try_module_get(ns->ctrl->ops->module))
                 goto fail_put_ns;

}

#rmmod nvme
[  434.859171] block nvme2n1: no available path - failing I/O
[  434.859204] XFS (nvme2n1p2): log I/O error -5
[  434.859211] XFS (nvme2n1p2): Filesystem has been shut down due to log 
error (0x2).
[  434.859215] XFS (nvme2n1p2): Please unmount the filesystem and 
rectify the problem(s).
[root@ltcrain119-lp4 nvme_upstream]# [  439.349490] XFS (dm-0): metadata 
I/O error in "xfs_imap_to_bp+0x74/0x108 [xfs]" at daddr 0x73d4ca0 len 32 
error 5
[  439.349651] XFS (dm-0): metadata I/O error in 
"xfs_imap_to_bp+0x74/0x108 [xfs]" at daddr 0x73d4ca0 len 32 error 5
[  439.353244] coredump: 26799(fwupd): 
|/usr/lib/systemd/systemd-coredump pipe failed
[  457.438961] XFS (dm-0): log I/O error -5
[  457.438998] XFS (dm-0): Filesystem has been shut down due to log 
error (0x2).
[  457.439005] XFS (dm-0): Please unmount the filesystem and rectify the 
problem(s).

With patch, reference count of nvme is 6 after system boots up.
2 paths for nvme0 and 4 paths for nvme1:
Can't do "rmmod nvme" command now.

#lsmod|grep nvme
# lsmod|grep nvme
nvme_tcp              262144  0
nvme                  262144  6
nvme_fabrics          262144  1 nvme_tcp
nvme_core             458752  7 nvme_tcp,nvme,nvme_fabrics
nvme_keyring          262144  3 nvme_tcp,nvme_core,nvme_fabrics
nvme_auth             262144  1 nvme_core

# rmmod nvme
rmmod: ERROR: Module nvme is in use

If I remove 1 NS nvme device, reference count decreases 6 – 2 = 4 paths 
in total.
# lsmod|grep nvme
nvme_tcp              262144  0
nvme                  262144  4
nvme_fabrics          262144  1 nvme_tcp
nvme_core             458752  7 nvme_tcp,nvme,nvme_fabrics
nvme_keyring          262144  3 nvme_tcp,nvme_core,nvme_fabrics
nvme_auth             262144  1 nvme_core

If you need any additional information or have any other considerations, 
please let me know.
Could you please help review the patch and share any feedback?

Thanks,
Wen

