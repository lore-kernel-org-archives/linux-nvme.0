Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0123CFB441
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2024 13:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f02Fi//D4zY8JouLJRFP7PC79QWYIZ1f9/KyyJWJ9/M=; b=Egat3NRkQmL/wCaEb7wmoTCPps
	8NmNgMOCMkbax7kIYzQ83/Py8SZ3Uc0S0tJ/ETcTToRWraM+VrzaMoeKAGmkhhjNk5+CX0ZwpHAvK
	fzjhIUuCwvtxmVkg21JOJeL6JpKEvV1QhJfHmHmm4bnqhaHSZULZbmiJAZMr9be9q99QhA9SQy6YB
	53IEL4zOI/0pS4aw0WAgxTjTPtyKp9RxFLGkzkMjUYz026ocgOHOC3l7jm7u5Z4dPHbz1M1f7bX2O
	RyvSt/xnhlnTPo26oTuoV/XALIaI7aXG8GDwrrWi6k+cigpSpRGX/t8u3iC9+Ewhzb2dCOe1FZ/Fp
	tDwc07+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxo8Q-00000002a0V-26c0;
	Mon, 07 Oct 2024 13:50:50 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxo5Z-00000002ZRC-232F
	for linux-nvme@lists.infradead.org;
	Mon, 07 Oct 2024 13:47:55 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497BnVle006233;
	Mon, 7 Oct 2024 13:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=f
	02Fi//D4zY8JouLJRFP7PC79QWYIZ1f9/KyyJWJ9/M=; b=bXRctAaQfxmiucZuV
	jTDatdEGkG6iKFWz9Af4VU3uGQ2cNH2l3B6oDMBLXo2Vsl2tCBz2CVY7E523PmVi
	PmmKC9pxfb1xq3lh7VByN1Vb9jQD6M7mGu6kjsbWnxfEFZnpse/BeZ86ETVvoujD
	+xqWcPHgyqmE8k+O2FSs+TK+sDOMZ9DrgcJDWH64NeLmWhHwu+vcDbYVsnfFjwpr
	7R9krDrWswlpc6ckSa6RtYI2Vvyf5WDzCTQ7JwAl7sI7IW/+n9pSxRKog9fQkyOY
	P7WvfVc0Eu9rU8TXZDGAf7VDQXQUtDoNsYTUm7luc2mxw+5zGafmGG4dUB2/NdgQ
	dfE7Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424f40gntn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 13:47:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 497BntHn010728;
	Mon, 7 Oct 2024 13:47:35 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 423j0j6mus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 13:47:35 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 497DlYx924052410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Oct 2024 13:47:35 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97A9458056;
	Mon,  7 Oct 2024 13:47:34 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC9AD58052;
	Mon,  7 Oct 2024 13:47:31 +0000 (GMT)
Received: from [9.179.23.72] (unknown [9.179.23.72])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Oct 2024 13:47:31 +0000 (GMT)
Message-ID: <93af0dc5-c988-423c-9788-e93ca8703fd5@linux.ibm.com>
Date: Mon, 7 Oct 2024 19:17:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 RFC 1/1] nvme-multipath: Add sysfs attributes for
 showing multipath info
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, gjoyce@linux.ibm.com
References: <20240911062653.1060056-1-nilay@linux.ibm.com>
 <20240911062653.1060056-4-nilay@linux.ibm.com>
 <5050777a-2812-4fcf-bed9-00f0cb5706fc@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <5050777a-2812-4fcf-bed9-00f0cb5706fc@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pRib--w8Rt-nZguHa9KDNinj8K3FCpBw
X-Proofpoint-ORIG-GUID: pRib--w8Rt-nZguHa9KDNinj8K3FCpBw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_05,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 adultscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410070095
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_064753_786272_5535DE4A 
X-CRM114-Status: GOOD (  27.50  )
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



On 10/7/24 15:44, Hannes Reinecke wrote:
> On 9/11/24 08:26, Nilay Shroff wrote:
>> NVMe native multipath supports different IO policies for selecting I/O
>> path, however we don't have any visibility about which path is being
>> selected by multipath code for forwarding I/O.
>> This patch helps add that visibility by adding new sysfs attribute files
>> named "numa_nodes" and "queue_depth" under each namespace block device
>> path /sys/block/nvmeXcYnZ/. We also create a "multipath" sysfs directory
>> under head disk node and then from this directory add a link to each
>> namespace path device this head disk node points to.
>>
>> For instance, /sys/block/nvmeXnY/multipath/ would create a soft link to
>> each path the head disk node <nvmeXnY> points to:
>>
>> $ ls -1 /sys/block/nvme1n1/
>> nvme1c1n1 -> ../../../../../pci052e:78/052e:78:00.0/nvme/nvme1/nvme1c1n1
>> nvme1c3n1 -> ../../../../../pci058e:78/058e:78:00.0/nvme/nvme3/nvme1c3n1
>>
>> For round-robin I/O policy, we could easily infer from the above output
>> that I/O workload targeted to nvme3n1 would toggle across paths nvme1c1n1
>> and nvme1c3n1.
>>
>> For numa I/O policy, the "numa_nodes" attribute file shows the numa nodes
>> being preferred by the respective block device path. The numa nodes value
>> is comma delimited list of nodes or A-B range of nodes.
>>
>> For queue-depth I/O policy, the "queue_depth" attribute file shows the
>> number of active/in-flight I/O requests currently queued for each path.
>>
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>   drivers/nvme/host/core.c      |  3 ++
>>   drivers/nvme/host/multipath.c | 71 +++++++++++++++++++++++++++++++++++
>>   drivers/nvme/host/nvme.h      | 20 ++++++++--
>>   drivers/nvme/host/sysfs.c     | 20 ++++++++++
>>   4 files changed, 110 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 983909a600ad..6be29fd64236 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -3951,6 +3951,9 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>>         if (!nvme_ns_head_multipath(ns->head))
>>           nvme_cdev_del(&ns->cdev, &ns->cdev_device);
>> +
>> +    nvme_mpath_remove_sysfs_link(ns);
>> +
>>       del_gendisk(ns->disk);
>>         mutex_lock(&ns->ctrl->namespaces_lock);
>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>> index 518e22dd4f9b..7d9c36a7a261 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -654,6 +654,8 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
>>           nvme_add_ns_head_cdev(head);
>>       }
>>   +    nvme_mpath_add_sysfs_link(ns);
>> +
>>       mutex_lock(&head->lock);
>>       if (nvme_path_is_optimized(ns)) {
>>           int node, srcu_idx;
> Nearly there.
Thank you for your review comments!

> 
> You can only call 'nvme_mpath_add_sysfs_link()' if the gendisk on the head had been created.
> 
> And there is one branch in nvme_mpath_add_disk():
> 
>                 if (desc.state) {
>                         /* found the group desc: update */
>                         nvme_update_ns_ana_state(&desc, ns);
> 
> which does not go via nvme_mpath_set_live(), yet a device link would need to be create here, too.
> But you can't call nvme_mpath_add_sysfs_link() from nvme_mpath_add_disk(), as the actual gendisk might only be created
> later on during ANA log parsing.
> 
> It is a tangle, and I haven't found a good way out of this.
> But I am _very much_ in favour of having these links, so please
> update your patch.
> In case disk supports ANA group then yes it would go through nvme_mpath_add_disk()->nvme_update_ns_ana_state(); 
and later nvme_update_ns_ana_state() would also fall through function nvme_mpath_set_live where we call 
nvme_mpath_add_sysfs_link(). 

So I think that in any case while multipath namespace is being created it has to go through 
nvme_mpath_set_live function. And as we see in nvme_mpath_set_live function, we only create 
sysfs link after the gendisk on the head is created. Do you agree with this? Or please let 
me know if you have any further question.

> Cheers,
> 
> Hannes

Thanks,
--Nilay

