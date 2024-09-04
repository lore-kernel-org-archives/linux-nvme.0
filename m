Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C807ECD484F
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2024 14:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w2kuZTYEDV6HXIhhaJPMXSY/Q2prhHcDJ5j2xzyUZ38=; b=KZmXbAtQOacePCZDTXSS0+0i7i
	Z8PjOZ8inuWecXf62JkDULEJFpir3H68xZrWODpjLBKr4GqnV814NUbNNtl/XL9cMTi3tOBJBJ6jW
	3BirHoaNLeaPYv5ZNBIRZnVK2yn3O/in6tYT9Ag2tC3OEDl9KelbiOxxZTKUJ2YwPnFzRNV4JGCVi
	BNF9o1k97EBpg7wsQKEAaH6UJvr8k6ZLsWYcoAlV9vaRCqG9S8KmBc6MhYlxwX+KDokkA6eiib6Sz
	13cn7d6Dn4shaDqCeL9gqHEwSW/iAZF9aRUI4P0nbmCcspm0LZWTj8c9Fg9JoPBVKTfvx8DmVGLaL
	GCMI1HnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slrOb-00000004sXG-1tC9;
	Wed, 04 Sep 2024 14:54:09 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slrNI-00000004sF9-29H8
	for linux-nvme@lists.infradead.org;
	Wed, 04 Sep 2024 14:52:50 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484DlALu015112;
	Wed, 4 Sep 2024 14:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=w
	2kuZTYEDV6HXIhhaJPMXSY/Q2prhHcDJ5j2xzyUZ38=; b=YYXjLoW0ZcbdXFnjY
	RmX94E93gzYKvIQg3XOPrTdRTOq9rP7WOTrmwQfItnRLQj/vJv9zv3eu3mBONKRR
	lajZnmyWhHBUdwG/ktVjF6E68TyAIvnOjySOE9GPxoLSFr0eylzDYSSeIbSwdkzd
	Q85QZzzC8YYV5X3J/7BBwUXp6K2DB8bL8UJgguSLT1hPJKh+llmwFcOITUnvcnSU
	ZpGiOCcoZDHhXIZMSuvcs6gT5AzBVhnZEoeTRjQasWO9eHIWJkKZ09ehBzR0ZeDF
	UQsM0anzDX2JQcvg7XqlZMljHOW4rTH0nEozhIf4slH+HArwKjfRBsTBoox3wK6F
	aSxzg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btp9kq0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 14:52:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 484CSL5V018602;
	Wed, 4 Sep 2024 14:52:33 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41cdw18am6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 14:52:33 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 484EqWSo53018998
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Sep 2024 14:52:32 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A08858060;
	Wed,  4 Sep 2024 14:52:32 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5F865805D;
	Wed,  4 Sep 2024 14:52:30 +0000 (GMT)
Received: from [9.171.2.34] (unknown [9.171.2.34])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Sep 2024 14:52:30 +0000 (GMT)
Message-ID: <d3762e8e-dcae-46fd-b222-92b552d3449f@linux.ibm.com>
Date: Wed, 4 Sep 2024 20:22:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme-multipath: fix I/O stall when remapping
 namespaces
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20240903180345.35253-1-hare@kernel.org>
 <20240903180345.35253-3-hare@kernel.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20240903180345.35253-3-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Bdu05M7a_F8NT3imIO2TodeBVthePcur
X-Proofpoint-ORIG-GUID: Bdu05M7a_F8NT3imIO2TodeBVthePcur
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_12,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 malwarescore=0 mlxlogscore=897 adultscore=0 mlxscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040110
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_075248_819406_EA250D01 
X-CRM114-Status: GOOD (  27.52  )
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



On 9/3/24 23:33, Hannes Reinecke wrote:
> During repetitive namespace remapping operations (ie removing a namespace and
> provision a different namespace with the same NSID) on the target the
> namespace might have changed between the time the initial scan
> was performed, and partition scan was invoked by device_add_disk()
> in nvme_mpath_set_live(). We then end up with a stuck scanning process:
> 
> [<0>] folio_wait_bit_common+0x12a/0x310
> [<0>] filemap_read_folio+0x97/0xd0
> [<0>] do_read_cache_folio+0x108/0x390
> [<0>] read_part_sector+0x31/0xa0
> [<0>] read_lba+0xc5/0x160
> [<0>] efi_partition+0xd9/0x8f0
> [<0>] bdev_disk_changed+0x23d/0x6d0
> [<0>] blkdev_get_whole+0x78/0xc0
> [<0>] bdev_open+0x2c6/0x3b0
> [<0>] bdev_file_open_by_dev+0xcb/0x120
> [<0>] disk_scan_partitions+0x5d/0x100
> [<0>] device_add_disk+0x402/0x420
> [<0>] nvme_mpath_set_live+0x4f/0x1f0 [nvme_core]
> [<0>] nvme_mpath_add_disk+0x107/0x120 [nvme_core]
> [<0>] nvme_alloc_ns+0xac6/0xe60 [nvme_core]
> [<0>] nvme_scan_ns+0x2dd/0x3e0 [nvme_core]
> [<0>] nvme_scan_work+0x1a3/0x490 [nvme_core]
> 
> This happens when we have several paths, some of which are inaccessible,
> and the active paths are removed first. Then nvme_find_path() will requeue
> I/O in the ns_head (as paths are present), but the requeue list is never
> triggered as all remaining paths are inactive.
> This patch checks for NVME_NSHEAD_DISK_LIVE when selecting a path,
> and requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared once
> the last path has been removed to properly terminate pending I/O.
> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>  drivers/nvme/host/multipath.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index c9d23b1b8efc..1b1deb0450ab 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -407,6 +407,9 @@ static struct nvme_ns *nvme_numa_path(struct nvme_ns_head *head)
>  
>  inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
>  {
> +	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
> +		return NULL;
> +
>  	switch (READ_ONCE(head->subsys->iopolicy)) {
>  	case NVME_IOPOLICY_QD:
>  		return nvme_queue_depth_path(head);
> @@ -421,6 +424,9 @@ static bool nvme_available_path(struct nvme_ns_head *head)
>  {
>  	struct nvme_ns *ns;
>  
> +	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
> +		return NULL;
> +
>  	list_for_each_entry_rcu(ns, &head->list, siblings) {
>  		if (test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ns->ctrl->flags))
>  			continue;
> @@ -967,11 +973,15 @@ void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
>  {
>  	if (!head->disk)
>  		return;
> -	kblockd_schedule_work(&head->requeue_work);
> -	if (test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
> +	if (test_and_clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
>  		nvme_cdev_del(&head->cdev, &head->cdev_device);
>  		del_gendisk(head->disk);
>  	}
> +	/*
> +	 * requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared
> +	 * to allow multipath to fail all I/O.
> +	 */
> +	kblockd_schedule_work(&head->requeue_work);
>  }
Not sure, in your case, whether nvme_mpath_remove_disk() is called or not? 
The nvme_mpath_remove_disk() shall trigger the ns_head reqiest list. 

>  
>  void nvme_mpath_remove_disk(struct nvme_ns_head *head)

