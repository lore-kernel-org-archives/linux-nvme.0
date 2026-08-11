Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B047EC5AC67
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 18:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9YlPbDLaBs0CaZ7TYt6fKNM5lWno0usG00cXtPzjO5A=; b=LHtnyexBjzfGupfki29hLwI74P
	KzfMo9Ej91lDts0fQ4R2OzaP6X8BN83e364CwF1p5QpsZOqzqgC8GVNftEjbXL6Rz+PXaRa0KKcBt
	OiqRrWGb0fxUAGFSwjtZJaIoJk+mFmUtllkQ2xsuLfsFp2Z9OhJLR2+8vz2YFk10nSWkkeMcF9PtF
	TA6k2eR4AeBDLckIjD+sNohCAtNvBQeLVQyroq5d4UYnUJTGLW+qbi1i+Njw4R+DXmpRvgATXgPVC
	wzRyv3+cpXWFAFXIXxFiMsXhyRCyulZ8Nb0ALoo8u+Is8vJBRrAQDpHnW9nqpUyJNpnExrQ4DwSxH
	d2K2ZKfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtrc6-0000000EnmK-3PQ5;
	Tue, 11 Aug 2026 18:54:14 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtrc4-0000000Enlz-1vXF
	for linux-nvme@lists.infradead.org;
	Tue, 11 Aug 2026 18:54:13 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGVnMa4030061;
	Tue, 11 Aug 2026 18:54:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9YlPbD
	LaBs0CaZ7TYt6fKNM5lWno0usG00cXtPzjO5A=; b=S/5n0UeHkyIBwbIrpPP/8S
	CviZP87PlYmsM3MJ6jm7DSxf16VDgez3AFvr7JQhsddPd16WglB0kyg0WDF6FXLJ
	KiWPxi/Aw8BG0nf+LZBhaSu5r23rwUSvmuCp+nKJSHvqClP4RbHIx07FsbJGqqzI
	65rbMHv0Dr+GTHSZ7wPSEOrfsjdVpeM3hOyPUiOD8NXwvTF3DVkmc74id3BJ7SZk
	AqHuhmtD4uwxM7J68Clt5Eo2zUP3svb8iBsr0Cs5d/1Qx4IJBakFbDo8FBZbiDWF
	uNpV9CxV1mMymcr7RxdYk/iMysDxNc1MWHe3ZWj6KfZHgt873nHjAQJK+lik9cjQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23q8mc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 18:54:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BIfG5x028978;
	Tue, 11 Aug 2026 18:54:08 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h291t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 18:54:08 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BIs6c666519416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 18:54:07 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEEC458052;
	Tue, 11 Aug 2026 18:54:06 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CC0658056;
	Tue, 11 Aug 2026 18:54:06 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 18:54:06 +0000 (GMT)
MIME-Version: 1.0
Date: Tue, 11 Aug 2026 13:54:06 -0500
From: Wen Xiong <wenxiong@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, gjoyce@linux.ibm.com,
        wenxiong@us.ibm.com
Subject: Re: [PATCH] nvme: Add module reference counting for multipath nvme
 device
In-Reply-To: <92d55da9-2cb6-43aa-8fee-51f2c86101f8@oracle.com>
References: <20260810235034.544797-1-wenxiong@linux.ibm.com>
 <92d55da9-2cb6-43aa-8fee-51f2c86101f8@oracle.com>
Message-ID: <936b1d36a4292c9501eec5a5df3d7b47@linux.ibm.com>
X-Sender: wenxiong@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7b6fd1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=GgqJubDKrjp_aS_qcQIA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX9lRrLiK+L9b8
 5GGD9MzbxfoFytDK67o+tkb6SsBQcj0QheL99hOdE5YHwCCe5eNq5Tkfs6cvUUFCjdVtDdyMIgH
 88gBQE7h6ktfq3hgup6msJ08NOVys4xDXKLVtFw9QdMTm40PCN82Ruc5WFNOsgGtLKYTex1xQpj
 Xlk7xKpUssxejGX5DIZTZQpX4tV6nVR5UsjUuyh7Se0kgTnT0RQtcxHgmtLDQzHZmT0vV+u5L9v
 pHPoWo7ZNGFe12GS/bIq7TdH48KOCwuX7AIRFjwH0eEkCV5orQRcMH8Oz8r5qNP1cSSZQFOA+gH
 w9xCovAnr55Rv5SU7FRXI+QxzuNKHWG1AOSpiBOuDLcKiwEaXwNf3cbUTFYyymesr+2y3EPXbw0
 YHuVu9/LUKj33y2SZSSigU8ErAO63Rtg0FKWaEHvzZ9tFsr7VJ96Y80kw7Vs2+9wzniq5fNd0vX
 pQP5MA+4cp15UyYR1XQ==
X-Proofpoint-ORIG-GUID: WiAX5CQAgTJAv756FWldoKqEMTs35I5I
X-Proofpoint-GUID: WiAX5CQAgTJAv756FWldoKqEMTs35I5I
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX9LldSAeEr+xx
 nfCUAusRCo2KqeLfryN/Od9R8PxNlg6P3PA3b/NYh4bjNDWN0+2qz37CSjE4sLHs98VEqWh1/vC
 LwoQQIwS+W5CLlmkFFcjox3rYB74clY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110155
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_115412_647519_E48E0A21 
X-CRM114-Status: GOOD (  12.29  )
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

On 2026-08-11 08:18, John Garry wrote:

> Can you demonstrate that this is a problem?
> 
For example, the Linux root filesystem is located on a multipath NVMe 
device. During system boot, the reference count of the nvme module is 
zero. As a result, the tester can run rmmod nvme, which causes the 
system to become unstable or crash.

linux was installed on /dev/nvme4n2.
#lsmod|grep nvme
nvme_fabrics          262144  0
nvme                  262144  0 ----> reference count = 0 for nvme 
module.
nvme_core             458752  4 nvme,nvme_fabrics
nvme_keyring          262144  2 nvme_core,nvme_fabrics
nvme_auth             262144  1 nvme_core
#  rmmod nvme
[11312.100786][  T937] BTRFS error (device nvme4n1p2): bdev 
/dev/nvme4n1p2 errs: wr 1, rd 0, flush 0, corrupt 0, gen 0
[11312.100855][  T937] BTRFS error (device nvme4n1p2): bdev 
/dev/nvme4n1p2 errs: wr 2, rd 0, flush 0, corrupt 0, gen 0
[11338.724061][  T624] BTRFS error (device nvme4n1p2 state A): 
Transaction aborted (error -5)
[11338.724075][  T624] BTRFS: error (device nvme4n1p2 state A) in 
__btrfs_update_delayed_inode:1096: errno=-5 IO failure
# ls
ls: reading directory '.': Input/output error

In the current nvme module reference count increase/decrease logic, the 
operation is skipped when the device is a multipath device. As a result, 
the NVMe module reference count remains zero even though the NVMe device 
is actively being used by the multipath stack.

static int nvme_ns_open(struct nvme_ns *ns)
{

         /* should never be called due to GENHD_FL_HIDDEN */
         if (WARN_ON_ONCE(nvme_ns_head_multipath(ns->head)))
                 goto fail;
         if (!nvme_get_ns(ns))
                 goto fail;
         if (!try_module_get(ns->ctrl->ops->module))
                 goto fail_put_ns;

This patch adds module reference count increase/decrease logic in 
nvme_ns_head_open() and nvme_ns_head_release() for the multipath head 
device. This mirrors the behavior of nvme_ns_open() for non-multipath 
devices.

Thanks,
Wendy

