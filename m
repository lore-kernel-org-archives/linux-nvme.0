Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADD1E7718E
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Dec 2024 11:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UFwpvCdRUncH1JIu1pRJYK0UGgBLlIrD0frDhYxw3mg=; b=mW3wzhgVFzNimjdTksMn/fl56T
	dOxtAq1s63kS35bSGonxMyi7PoQZP2o8PQFaOhJ4pRoUX+Y0QCaUiTwTqAXn0Jl2v4uSIFdUu3qch
	KNYhsQuyjbLvjbklUkwX4nEff5oJfn4/GeivXGo2SlCmW391K9hPcaryj8zV2Qfc4RTHuBB6BbpgF
	VIsu/rQuk0uyrwH6JciJrlg3vpHmkla1Hu4Gpsm2eng4m6X+usHIA4LlUAIn9qt6ydyAVkgz1urDC
	qgYOvWSU8lyK7WzlN83x0wlt0nihUUH4BlSjTzzanAhPKO5jqmnzpy3Zkz0qc+symXHWdxBXBkXmF
	vdX+1Alw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ39n-0000000Bs0X-3r2b;
	Tue, 24 Dec 2024 11:32:59 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ38o-0000000Brur-18Gu
	for linux-nvme@lists.infradead.org;
	Tue, 24 Dec 2024 11:31:59 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNNaO2j026702;
	Tue, 24 Dec 2024 11:31:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UFwpvC
	dRUncH1JIu1pRJYK0UGgBLlIrD0frDhYxw3mg=; b=dYPA9xPx3anCeyMPP4CZHI
	yTEVnjhWx/xZ818kwCqC7fnziXplCByqcREZkYAu41NPqnbxAoiTUuIF4U+jIBPq
	0vPgfZmsY9m1t/pgq82mphvSGXYz6zDiCaY92vmm9sj9uFf22LnFr56OaCwFjfSg
	esTiKyKnSetWy3QdE+BGUj/3ZL91ls/SbvKKpDPykGh+i13jl4Fp0vqXncJix5vi
	s0988ewARiwLgQZ7q4euCOdX5moHoy3IzkbUuVmTa60ZRprhDy8jrGMptEGSmYLw
	N+zDfO/w4XEl/UKfmUo+8tFvNMxkCBixIEkWcebPiUfmyWsYhAkbXCm0fDeevM1w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43qhpaa2u0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 11:31:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BOB0pn1010606;
	Tue, 24 Dec 2024 11:31:41 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43p90n1rtt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 11:31:41 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BOBVe3f30081732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Dec 2024 11:31:40 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CED55803F;
	Tue, 24 Dec 2024 11:31:40 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63F9F5805A;
	Tue, 24 Dec 2024 11:31:37 +0000 (GMT)
Received: from [9.171.25.27] (unknown [9.171.25.27])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Dec 2024 11:31:36 +0000 (GMT)
Message-ID: <4474cc50-8a23-45c1-880f-e077c11ed8dd@linux.ibm.com>
Date: Tue, 24 Dec 2024 17:01:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 RFC 1/3] nvme-multipath: Add visibility for round-robin
 io-policy
To: Sagi Grimberg <sagi@grimberg.me>, dwagner@suse.de, hare@suse.de
Cc: kbusch@kernel.org, hch@lst.de, axboe@fb.com, gjoyce@linux.ibm.com,
        linux-nvme@lists.infradead.org
References: <20241213041908.1381196-1-nilay@linux.ibm.com>
 <20241213041908.1381196-2-nilay@linux.ibm.com>
 <1e07dbd6-3d3b-4c73-aa60-159ade59fcb2@grimberg.me>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <1e07dbd6-3d3b-4c73-aa60-159ade59fcb2@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mG7EGL7Q_1pkytdiW8xA9w0Fl9b_4Zod
X-Proofpoint-ORIG-GUID: mG7EGL7Q_1pkytdiW8xA9w0Fl9b_4Zod
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412240098
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241224_033158_440274_1F51BD8A 
X-CRM114-Status: GOOD (  20.71  )
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



On 12/24/24 16:31, Sagi Grimberg wrote:
> 
> 
> 
> On 13/12/2024 6:18, Nilay Shroff wrote:
>> This patch helps add nvme native multipath visibility for round-robin
>> io-policy. It creates a "multipath" sysfs directory under head gendisk
>> device node directory and then from "multipath" directory it adds a link
>> to each namespace path device the head node refers.
>>
>> For instance, if we have a shared namespace accessible from two different
>> controllers/paths then we create a soft link to each path device from head
>> disk node as shown below:
>>
>> $ ls -l /sys/block/nvme1n1/multipath/
>> nvme1c1n1 -> ../../../../../pci052e:78/052e:78:00.0/nvme/nvme1/nvme1c1n1
>> nvme1c3n1 -> ../../../../../pci058e:78/058e:78:00.0/nvme/nvme3/nvme1c3n1
>>
>> In the above example, nvme1n1 is head gendisk node created for a shared
>> namespace and the namespace is accessible from nvme1c1n1 and nvme1c3n1
>> paths.
>>
>> For round-robin I/O policy, we could easily infer from the above output
>> that I/O workload targeted to nvme1n1 would toggle across paths nvme1c1n1
>> and nvme1c3n1.
>>
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>   drivers/nvme/host/core.c      |  3 ++
>>   drivers/nvme/host/multipath.c | 81 +++++++++++++++++++++++++++++++++++
>>   drivers/nvme/host/nvme.h      | 18 ++++++--
>>   drivers/nvme/host/sysfs.c     | 14 ++++++
>>   4 files changed, 112 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index d169a30eb935..df4cc8a27385 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -3982,6 +3982,9 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>>         if (!nvme_ns_head_multipath(ns->head))
>>           nvme_cdev_del(&ns->cdev, &ns->cdev_device);
>> +
>> +    nvme_mpath_remove_sysfs_link(ns);
>> +
>>       del_gendisk(ns->disk);
>>         mutex_lock(&ns->ctrl->namespaces_lock);
>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>> index a85d190942bd..8e2865df2f33 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -686,6 +686,8 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
>>           kblockd_schedule_work(&head->partition_scan_work);
>>       }
>>   +    nvme_mpath_add_sysfs_link(ns->head);
> 
> Why do you add the link in set_live? Why not always set this link? it is after all, another
> path to the device?
> 
It's because we would be able to create the link from head disk node to a device path node
only after the head node comes alive (i.e. head disk node entry is created under sysfs). 
For instance, in the below example,

$ ls -l /sys/block/nvme1n1/multipath/
nvme1c1n1 -> ../../../../../pci052e:78/052e:78:00.0/nvme/nvme1/nvme1c1n1
nvme1c3n1 -> ../../../../../pci058e:78/058e:78:00.0/nvme/nvme3/nvme1c3n1

The nvme1n1 (head disk node) is added under sysfs (/sys/block/nvme1n1) from 
the following code path:
nvme_mpath_set_live()
  -> device_add_disk()
    -> add_disk_fwnode()
      -> device_add()    

From device_add() we add the head disk node entry under sysfs.

So it's essential for us to only add the link in nvme_mpath_set_live() after 
the head disk node comes live. Hope it clarifies. Please let me know if you've 
any further query.
  
Thanks,
--Nilay 

