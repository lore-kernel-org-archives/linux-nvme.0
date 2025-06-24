Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC946C77B7F
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Jun 2025 16:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QnfzolbwTPUKsv+6Y6lz6GgYl8lqjL8NHfidau9Gf6I=; b=jyn+282IKQ6H8tx207WuofQF35
	gAaP8V1Vff0mekEQaa100oA77pLWdF4PmWc/psLOdVIBpAGFhkUj6BYnkUmKPL6adNYIkAC3hilBZ
	ojhW8uRGO0GIc91n/VQrTIp5fZVA2b1WxBQw1N4WiuoxEJ98sPAh912r/kljjjgQQS7SpF6soxngL
	3bJzQIHNonjfB8BZrSGBMb6IkwDlP1s3VdqGZToYXhyuiRVcuXEBMp0C7mnUNpdNIw8qZL1lcY9Qe
	PDFo1qfe0HCuJvSx9jvzdP3SEL9Yttg5E5XKvYr5h4xEi+z6O7ieg48YAoJexwy0I/BIQUsP4wMDu
	LR8ajiFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU64p-00000006DLT-0LyF;
	Tue, 24 Jun 2025 16:00:51 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU4Zp-00000005tr4-2KsF
	for linux-nvme@lists.infradead.org;
	Tue, 24 Jun 2025 14:24:47 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O7KowS026107;
	Tue, 24 Jun 2025 14:24:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Qnfzol
	bwTPUKsv+6Y6lz6GgYl8lqjL8NHfidau9Gf6I=; b=gn9IdxtmYbAEP4kGA8iJuj
	ommD8V1iBe8OqhDC/ZgPBMsLHlClFGB4TI7g1VuUQBUUw5EniEKp/mn4BEln7q7Z
	M0IhhPxMRMs9QfrJ/0XnRb6XAETA7VQ2jo/fKewUu7dZOM2CBy7PoDVRjSOHaUEQ
	6mSHGwrpk+2qx/uQKlNZjL+oM7unklRREjnv0sBsOVISobR6jCq7LJ/LMKoktd+H
	x1jLfSpwb3kBPsG5igoCerZyYlzQwTZLMwVl4LF3NFh+BYh9ME/sdMvyYTWD+3x/
	wp1eKW/WO7KQvcz7MQy5vdi+cVfsnGu+GiwBScBGYJCC8GRGcgZPSW+4Uh5IP+PQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dme196wq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 14:24:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55OBSawa014769;
	Tue, 24 Jun 2025 14:24:35 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e9s2c3um-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 14:24:35 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55OEOYa119005938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 14:24:34 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E59D58065;
	Tue, 24 Jun 2025 14:24:34 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FA7658052;
	Tue, 24 Jun 2025 14:24:31 +0000 (GMT)
Received: from [9.109.198.209] (unknown [9.109.198.209])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Jun 2025 14:24:31 +0000 (GMT)
Message-ID: <a16bceaa-cb73-4d23-b145-25d5bc74eded@linux.ibm.com>
Date: Tue, 24 Jun 2025 19:54:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvme: correctly account for namespace head reference
 counter
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, sagi@grimberg.me,
        hare@suse.de, dwagner@suse.de, axboe@kernel.dk,
        shinichiro.kawasaki@wdc.com, gjoyce@ibm.com
References: <20250620080257.27993-1-nilay@linux.ibm.com>
 <20250623122019.GA22176@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250623122019.GA22176@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Tc6WtQQh c=1 sm=1 tr=0 ts=685ab524 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=U3ocMKw3nki_0pKVrGEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8n9XcVC1AV6GmSgHaSJHsgOlnPVn5__d
X-Proofpoint-ORIG-GUID: 8n9XcVC1AV6GmSgHaSJHsgOlnPVn5__d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDEyMCBTYWx0ZWRfX3knGAeEnYuOG lrvm879GquZxmvrKATM7h6AiokztJtsw2naGzJPlmUpPdUi4kyclNUghM0uYwFpAU62/nXF8Z/1 zkNpB+xR94NLAVNLp5c+kkAfDbeKOKqdPkGiM0C86PvLfVDYN6ks+Ol3P7TWRMTTum0LuDZFnbU
 TCGaBrqpl+ijLwPU2jNAwEjV47UyXVkXY9VM+jDM0yWqAGJj5nW1JWr9+lH3fyy7HFI2I2wNsTO TwW0hzqAEPmfWFQJMMDAyLQcbEfIQCCXpUbHkXZNflscE1JfarG2wWNaFyQOkkppir4kQHFz/Xd HMwnyfhAvSnPh6EdtadlZqgJu/9dyBmgQZbnqaHYus7PE92WHC+3Uf7ugJk5Z25Y4gzuNLN5ptp
 bUFTuCYhi0dxObonx8ClD+RAIfQCIjcIEwqpEZhpKO4Obpc+UPuhelUvqaasRvssP+a44bpk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_05,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506240120
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250624_072445_612224_915B460C 
X-CRM114-Status: GOOD (  19.28  )
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



On 6/23/25 5:50 PM, Christoph Hellwig wrote:
> On Fri, Jun 20, 2025 at 01:32:43PM +0530, Nilay Shroff wrote:
>> During the failre
> 
> failure?
> 
>> To fix this, we now unconditionally release the nshead reference when
>> the last nvme path referencing to the nshead is removed, regardless of
>> the head’s state. Also during idnetify
> 
> identify
> 
> Otherwise this looks good.

Thanks! I'd update the above typo, however today I was testing some code 
after disabling CONFIG_NVME_MULTIPATH and I realized that although the
namespace head (ns->head) is still created, its associated head->disk is
not initialized in this configuration. As a result, ns->head only has a
single reference — the one from kref_init() during its creation. Therefore,
when we delete the namespace or handle an error case, we must ensure that
we only call nvme_put_ns_head() once to properly release the reference and
avoid a potential double-free. So I updated this patch as shown below (please
note that this is equally applicable when we insmod nvme_core with module
param "multipath" set to false):

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 92697f98c601..033fe0a12727 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4089,6 +4089,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
        struct nvme_ns *ns;
        struct gendisk *disk;
        int node = ctrl->numa_node;
+       bool last_path = false;
 
        ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
        if (!ns)
@@ -4181,9 +4182,14 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
  out_unlink_ns:
        mutex_lock(&ctrl->subsys->lock);
        list_del_rcu(&ns->siblings);
-       if (list_empty(&ns->head->list))
+       if (list_empty(&ns->head->list)) {
                list_del_init(&ns->head->entry);
+               if (ns->head->disk)
+                       last_path = true;
+       }
        mutex_unlock(&ctrl->subsys->lock);
+       if (last_path)
+               nvme_put_ns_head(ns->head);
        nvme_put_ns_head(ns->head);
  out_cleanup_disk:
        put_disk(disk);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index e040e467f9fa..c7644631bb1a 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -690,8 +690,8 @@ static void nvme_remove_head(struct nvme_ns_head *head)
                nvme_cdev_del(&head->cdev, &head->cdev_device);
                synchronize_srcu(&head->srcu);
                del_gendisk(head->disk);
-               nvme_put_ns_head(head);
        }
+       nvme_put_ns_head(head);
 }
 
 static void nvme_remove_head_work(struct work_struct *work)
@@ -1291,6 +1291,9 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
        bool remove = false;
 
+       if (!head->disk)
+               return;
+
        mutex_lock(&head->subsys->lock);
        /*
         * We are called when all paths have been removed, and at that point

So I'll send out patchv2 with the above changes.

Thanks,
--Nilay


