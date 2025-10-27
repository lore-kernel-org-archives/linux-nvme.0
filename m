Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387F1CCF9E5
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Oct 2025 12:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tZRTj+kOpmAZ4lXd75oo9d1waoXdjPLl508pz7qc+Yk=; b=AwZJg/GP/DbdXe2tsqemO6SaJn
	G1st8ETECmoY7txQTNG2q3ws/IFU/46qq9638BJuN2/zWWCNmzCUlhcYO3q+S5ktyBwn3C5tUoR67
	6liZF2o07JL+sUm0NqkhCj1oqYcwy8azsgx3hul85sE3EE9QP7dKwxbyuKT44N9t8vFEjMKJ4tajL
	yYmcUjklmdsuduKtgi+l2ErjcILX9JsaW495fQptQUfhX875kmYq53Q9RVt8pvnJqtgOHylnPQHtb
	PszZ9yuj+n1aczNlDE1z7n2Frm3+/phuCluAzAyH6dQu9ar6AGaECQYLqosbDkjQ/ElLhOPeeGUaE
	loDXrM4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDLwO-0000000DqFJ-42zq;
	Mon, 27 Oct 2025 12:03:12 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDLwL-0000000DqEg-3nlW
	for linux-nvme@lists.infradead.org;
	Mon, 27 Oct 2025 12:03:11 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59QH71Na007389;
	Mon, 27 Oct 2025 12:03:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tZRTj+
	kOpmAZ4lXd75oo9d1waoXdjPLl508pz7qc+Yk=; b=k9166zjEnf8pU3VumNSPvo
	1a7/euHfiSAvCG05S0xqWgV/+LeHqoCHY+HOKVlJuPIrOZMPTfrDt3Gv5tNnGEL/
	fMO8TUKdwsPS3z5fciqQh2eZDcvmswOzSKH4OnNBa+ZAcWIRXP5u60MMRpbA6zYj
	Sx2FspRd9epo8QYkHGHwnv+/Qr/5FBKUCupVMM6avWHMSWV/Nh4P/KFQ061qExp8
	aorGqR+zUafuTbZn8+0QDlD2c1i0zyLyLKCkHPj0qzfTNFLuj19r7iD7hkI2rWvd
	a5pfsmRnoig+uAS4IaQ93hP0Nqk7d68jiS7EnXUMxsQeRq9pIFVI0ns+nplsx7cQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0kyt6pab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 12:03:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59RBUNiw030103;
	Mon, 27 Oct 2025 12:03:03 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a19vmdd27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 12:03:03 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59RC32u728181002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 12:03:02 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A68E58057;
	Mon, 27 Oct 2025 12:03:02 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 249EE58061;
	Mon, 27 Oct 2025 12:02:58 +0000 (GMT)
Received: from [9.61.186.32] (unknown [9.61.186.32])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Oct 2025 12:02:57 +0000 (GMT)
Message-ID: <155db473-0b40-4c3b-bde3-1cb650f1072a@linux.ibm.com>
Date: Mon, 27 Oct 2025 17:32:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv3 5/6] nvme: add generic debugfs support
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, dwagner@suse.de,
        axboe@kernel.dk, gjoyce@ibm.com
References: <20251027092949.961287-1-nilay@linux.ibm.com>
 <20251027092949.961287-6-nilay@linux.ibm.com>
 <b7022e68-34d0-45b1-92b8-45f145315aff@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <b7022e68-34d0-45b1-92b8-45f145315aff@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: V9rhvr6gKDlvasm3XvaFc7beFpjLZKSu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAwMSBTYWx0ZWRfX3wXuPlUxG3b+
 9SWsDh/NRUVp6cLORtzMcQQ5ZeAwuwUBoFIv0n8ZZtUyXI5Hl9D/CihliDhnYFepyU+LNRwBWSJ
 q/chKkEKupzFjrKRfsC6JH8gSZLNbXuwelE3g9G4TUY3M63egVDnaHjmBH9exN5Dpw9salc0x3T
 8tt06OPHSIv8EBbeNZot2GM2xNfJTh+BdS+FNKgXs+hFnEkVBFizC1f+nUYtPvlkn72Wk11mMOu
 3xsqegblUPyhnSW9gL7Mk9lI1IFC8xdtqaLRALQtbawZzjIsT7firTvxOg0W6kQiyFSyIl417jo
 DhOVH+Bonu+9WBablMizuox/9z2u4nAE94wS3N1hXRpETRqbmxjbtZ7Wm6RyFg6rtnJd54GTf0W
 po4IC8yFveCn5aTF1M2VDzNAlDao+w==
X-Proofpoint-GUID: V9rhvr6gKDlvasm3XvaFc7beFpjLZKSu
X-Authority-Analysis: v=2.4 cv=FaE6BZ+6 c=1 sm=1 tr=0 ts=68ff5f77 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=AreWLH70bw0oQ-XAbN4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250001
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251027_050310_065985_FD8F1497 
X-CRM114-Status: GOOD (  24.42  )
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



On 10/27/25 5:25 PM, Hannes Reinecke wrote:
> On 10/27/25 10:29, Nilay Shroff wrote:
>> Add generic infrastructure for creating and managing debugfs files in
>> the NVMe module. This introduces helper APIs that allow NVMe drivers to
>> register and unregister debugfs entries, along with a reusable attribute
>> structure for defining new debugfs files.
>>
>> The implementation uses seq_file interfaces to safely expose per-NS and
>> per-NS-head statistics, while supporting both simple show callbacks and
>> full seq_operations.
>>
>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>   drivers/nvme/host/Makefile  |   2 +-
>>   drivers/nvme/host/debugfs.c | 122 ++++++++++++++++++++++++++++++++++++
>>   drivers/nvme/host/nvme.h    |  11 ++++
>>   3 files changed, 134 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/nvme/host/debugfs.c
>>
>> diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
>> index 6414ec968f99..7962dfc3b2ad 100644
>> --- a/drivers/nvme/host/Makefile
>> +++ b/drivers/nvme/host/Makefile
>> @@ -10,7 +10,7 @@ obj-$(CONFIG_NVME_FC)            += nvme-fc.o
>>   obj-$(CONFIG_NVME_TCP)            += nvme-tcp.o
>>   obj-$(CONFIG_NVME_APPLE)        += nvme-apple.o
>>   -nvme-core-y                += core.o ioctl.o sysfs.o pr.o
>> +nvme-core-y                += core.o ioctl.o sysfs.o pr.o debugfs.o
>>   nvme-core-$(CONFIG_NVME_VERBOSE_ERRORS)    += constants.o
>>   nvme-core-$(CONFIG_TRACING)        += trace.o
>>   nvme-core-$(CONFIG_NVME_MULTIPATH)    += multipath.o
>> diff --git a/drivers/nvme/host/debugfs.c b/drivers/nvme/host/debugfs.c
>> new file mode 100644
>> index 000000000000..5c441779554f
>> --- /dev/null
>> +++ b/drivers/nvme/host/debugfs.c
>> @@ -0,0 +1,122 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2025 IBM Corporation
>> + *    Nilay Shroff <nilay@linux.ibm.com>
>> + */
>> +
>> +#include <linux/debugfs.h>
>> +#include <linux/seq_file.h>
>> +
>> +#include "nvme.h"
>> +
>> +struct nvme_debugfs_attr {
>> +    const char *name;
>> +    umode_t mode;
>> +    int (*show)(void *data, struct seq_file *m);
>> +    const struct seq_operations *seq_ops;
>> +};
>> +
>> +struct nvme_debugfs_ctx {
>> +    void *data;
>> +    struct nvme_debugfs_attr *attr;
>> +    int srcu_idx;
>> +};
>> +
>> +static int nvme_debugfs_show(struct seq_file *m, void *v)
>> +{
>> +    struct nvme_debugfs_ctx *ctx = m->private;
>> +    void *data = ctx->data;
>> +    struct nvme_debugfs_attr *attr = ctx->attr;
>> +
>> +    return attr->show(data, m);
>> +}
>> +
>> +static int nvme_debugfs_open(struct inode *inode, struct file *file)
>> +{
>> +    void *data = inode->i_private;
>> +    struct nvme_debugfs_attr *attr = debugfs_get_aux(file);
>> +    struct nvme_debugfs_ctx *ctx;
>> +    struct seq_file *m;
>> +    int ret;
>> +
>> +    ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>> +    if (WARN_ON_ONCE(!ctx))
>> +        return -ENOMEM;
>> +
>> +    ctx->data = data;
>> +    ctx->attr = attr;
>> +
>> +    if (attr->seq_ops) {
>> +        ret = seq_open(file, attr->seq_ops);
>> +        if (ret) {
>> +            kfree(ctx);
>> +            return ret;
>> +        }
>> +        m = file->private_data;
>> +        m->private = ctx;
>> +        return ret;
>> +    }
>> +
>> +    if (WARN_ON_ONCE(!attr->show)) {
>> +        kfree(ctx);
>> +        return -EPERM;
>> +    }
>> +
>> +    return single_open(file, nvme_debugfs_show, ctx);
>> +}
>> +
>> +static int nvme_debugfs_release(struct inode *inode, struct file *file)
>> +{
>> +    struct seq_file *m = file->private_data;
>> +    struct nvme_debugfs_ctx *ctx = m->private;
>> +    struct nvme_debugfs_attr *attr = ctx->attr;
>> +    int ret;
>> +
>> +    if (attr->seq_ops)
>> +        ret = seq_release(inode, file);
>> +    else
>> +        ret = single_release(inode, file);
>> +
>> +    kfree(ctx);
>> +    return ret;
>> +}
>> +
>> +static const struct file_operations nvme_debugfs_fops = {
>> +    .owner   = THIS_MODULE,
>> +    .open    = nvme_debugfs_open,
>> +    .read    = seq_read,
>> +    .llseek  = seq_lseek,
>> +    .release = nvme_debugfs_release,
>> +};
>> +
>> +
>> +static const struct nvme_debugfs_attr nvme_mpath_debugfs_attrs[] = {
>> +    {},
>> +};
>> +
>> +static const struct nvme_debugfs_attr nvme_ns_debugfs_attrs[] = {
>> +    {},
>> +};
>> +
>> +static void nvme_debugfs_create_files(struct request_queue *q,
>> +        const struct nvme_debugfs_attr *attr, void *data)
>> +{
>> +    if (WARN_ON_ONCE(!q->debugfs_dir))
>> +        return;
>> +
>> +    for (; attr->name; attr++)
>> +        debugfs_create_file_aux(attr->name, attr->mode, q->debugfs_dir,
>> +                data, (void *)attr, &nvme_debugfs_fops);
>> +}
>> +
>> +void nvme_debugfs_register(struct gendisk *disk)
>> +{
>> +    const struct nvme_debugfs_attr *attr;
>> +
>> +    if (nvme_disk_is_ns_head(disk))
>> +        attr = nvme_mpath_debugfs_attrs;
>> +    else
>> +        attr = nvme_ns_debugfs_attrs;
>> +
>> +    nvme_debugfs_create_files(disk->queue, attr, disk->private_data);
>> +}
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index 2e58d4d6902a..d049b62b71d2 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -988,6 +988,7 @@ extern const struct attribute_group *nvme_dev_attr_groups[];
>>   extern const struct block_device_operations nvme_bdev_ops;
>>     void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
>> +
>>   struct nvme_ns *nvme_find_path(struct nvme_ns_head *head, unsigned int op_type);
>>   static inline int nvme_data_dir(const enum req_op op)
>>   {
>> @@ -999,6 +1000,16 @@ static inline int nvme_data_dir(const enum req_op op)
>>           return NVME_STAT_OTHER;
>>   }
>>   +void nvme_debugfs_register(struct gendisk *disk);
>> +static inline void nvme_debugfs_unregister(struct gendisk *disk)
>> +{
>> +    /*
>> +     * Nothing to do for now. When the request queue is unregistered,
>> +     * all files under q->debugfs_dir are recursively deleted.
>> +     * This is just a placeholder; the compiler will optimize it out.
>> +     */
>> +}
>> +
>>   #ifdef CONFIG_NVME_MULTIPATH
>>   static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
>>   {
> 
> Especially as you already add a debugfs entry, so moving
> the values from the previous two patches should be easy.
> 
Okay will move those two entries under debugfs.

Thanks,
--Nilay


