Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3930E77182
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2024 13:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hE2wGr2drKqZP79YHyO7wZhk1Oa+w9rZ2SWDWO5n+Go=; b=Go1sa1IyhHb1prSaMGu7XX4HYc
	EMa61oNeL9HlZ6kt+zIq82SelYDsz/mjTJNoWibbK4IFz9AykOC9jKZf7tPaOortQnKRDea3uSuS1
	Ww9UZNmTbgKtwiSyLohiMWuuSWgVrzM/YLTl5Wz1VJM2Rpql8dj162HTMfea/Gx7s4GRJ4cI+wZeu
	q4DDJPf3d4aezTEG9EaUC7qRFEJ2b7QttQ8bnm7M3OLmdxgQ9cxebJxucr2dKsJyEhUrxDB/eDwVU
	yJZuWgcoVoZux00DxUTwWgyEjpgdcIIS1yP4XvTq/AZIeqs54Uv4UX7Nto8HZtIWz2+62cmVDBU//
	e56iQtyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKzz9-0000000BXNL-2l9Q;
	Tue, 10 Dec 2024 13:09:07 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKzsg-0000000BW7K-1BDD
	for linux-nvme@lists.infradead.org;
	Tue, 10 Dec 2024 13:02:27 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAB0OQJ027745;
	Tue, 10 Dec 2024 13:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hE2wGr
	2drKqZP79YHyO7wZhk1Oa+w9rZ2SWDWO5n+Go=; b=TpghoXJauQdWNq46uu2vf+
	Ui733kGNnkoTKV2RTC+UZVT2QmNIjqqmx49STuAtn1iU8GIiL1cVv2JFIV3z0YgN
	gxNHDaq2hO0xQiKzGC7zDgo/7JzmKg3iW6G888U1Nr6lrcoVhlkm8yGeEVBLp/Ho
	E1m+SvKG6StAce4351enRqRnKO8nnYsLc4/QHJZuw+HIW0sfl0WDaos/jbEg+Z1S
	AxLKU666mecFsuAbeOFvoJjhkpwcUNXS2rDLOpNWQxU8KvC6UOev4rdI7BTK3b0t
	UwGadE7kUKjyH3jD7I7wmSUoqJhp7Wvu9MK31qEQnxHmQ5Q+qBOP/adF/+OdPnHQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cdv8q5dj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 13:02:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAAiYIK032744;
	Tue, 10 Dec 2024 13:02:14 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d0psbw5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 13:02:14 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BAD2D6Z30212858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 13:02:13 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A6D958067;
	Tue, 10 Dec 2024 13:02:13 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C12C58052;
	Tue, 10 Dec 2024 13:02:10 +0000 (GMT)
Received: from [9.171.62.7] (unknown [9.171.62.7])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Dec 2024 13:02:10 +0000 (GMT)
Message-ID: <27e11ef9-4798-4d51-989f-e576b3d10050@linux.ibm.com>
Date: Tue, 10 Dec 2024 18:32:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 RFC 1/3] nvme-multipah: Add visibility for round-robin
 io-policy
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hare@suse.de,
        kbusch@kernel.org, hch@lst.de, =axboe@fb.com, gjoyce@linux.ibm.com
References: <20241030104156.747675-1-nilay@linux.ibm.com>
 <20241030104156.747675-2-nilay@linux.ibm.com>
 <7cba4ddb-5db1-4468-b1a6-69440d359701@flourine.local>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <7cba4ddb-5db1-4468-b1a6-69440d359701@flourine.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JYjwsEclK5vdMLnsXopNJZLVnIOq5tET
X-Proofpoint-ORIG-GUID: JYjwsEclK5vdMLnsXopNJZLVnIOq5tET
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100097
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241210_050226_332910_FEDCCAB9 
X-CRM114-Status: GOOD (  36.74  )
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



On 12/10/24 14:52, Daniel Wagner wrote:
> There is typo in the subject.
oh yes, I will fix it in the next patch.
> 
> On Wed, Oct 30, 2024 at 04:11:41PM +0530, Nilay Shroff wrote:
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
>>  drivers/nvme/host/core.c      |  3 ++
>>  drivers/nvme/host/multipath.c | 81 +++++++++++++++++++++++++++++++++++
>>  drivers/nvme/host/nvme.h      | 18 ++++++--
>>  drivers/nvme/host/sysfs.c     | 14 ++++++
>>  4 files changed, 112 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 84cb859a911d..c923bd2c5468 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -3940,6 +3940,9 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>>  
>>  	if (!nvme_ns_head_multipath(ns->head))
>>  		nvme_cdev_del(&ns->cdev, &ns->cdev_device);
>> +
>> +	nvme_mpath_remove_sysfs_link(ns);
>> +
>>  	del_gendisk(ns->disk);
>>  
>>  	mutex_lock(&ns->ctrl->namespaces_lock);
>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>> index 6a15873055b9..43c87a946cc7 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -682,6 +682,8 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
>>  		kblockd_schedule_work(&head->partition_scan_work);
>>  	}
>>  
>> +	nvme_mpath_add_sysfs_link(ns->head);
>> +
>>  	mutex_lock(&head->lock);
>>  	if (nvme_path_is_optimized(ns)) {
>>  		int node, srcu_idx;
>> @@ -764,6 +766,25 @@ static void nvme_update_ns_ana_state(struct nvme_ana_group_desc *desc,
>>  	if (nvme_state_is_live(ns->ana_state) &&
>>  	    nvme_ctrl_state(ns->ctrl) == NVME_CTRL_LIVE)
>>  		nvme_mpath_set_live(ns);
>> +	else {
>> +		/*
>> +		 * Add sysfs link from multipath head gendisk node to path
>> +		 * device gendisk node.
>> +		 * If path's ana state is live (i.e. state is either optimized
>> +		 * or non-optimized) while we alloc the ns then sysfs link would
>> +		 * be created from nvme_mpath_set_live(). In that case we would
>> +		 * not fallthrough this code path. However for the path's ana
>> +		 * state other than live, we call nvme_mpath_set_live() only
>> +		 * after ana state transitioned to the live state. But we still
>> +		 * want to create the sysfs link from head node to a path device
>> +		 * irrespctive of the path's ana state.
>> +		 * If we reach through here then it means that path's ana state
>> +		 * is not live but still create the sysfs link to this path from
>> +		 * head node if head node of the path has already come alive.
>> +		 */
>> +		if (test_bit(NVME_NSHEAD_DISK_LIVE, &ns->head->flags))
>> +			nvme_mpath_add_sysfs_link(ns->head);
>> +	}
> 
> Remind me, why do we add the link here? Couldn't we add it earlier and
> so we don't have to check the ctrl state? At least I read this here that
> we want to add the link independent of the ctrl state.
> 
Yes we always add link earlier for a case when path's ANA state is LIVE (i.e ANA state 
is either optimized or non-optimized). However there's a scenario when we allocate the
namespace path and its ANA state is anything but LIVE and in that case we would fall
through the above code path. 

Assume we create a shared namespace and attach it two different controllers. One of the
path of this shared namespace is advertising its ANA state as non-LIVE and the another 
path is advertising its ANA state as LIVE.
Now, if first we allocate a namespace path, which is advertising ANA state as non-LIVE,
then in that case the head disk node wouldn't come live and without the head disk node 
we can't create the sysfs link to that namespace path. Later when we allocate the second
path, which is advertising ANA sate as LIVE, the head disk node comes live, and so we can
now create the sysfs link to both paths. 

So it's important to check the state of head disk node in the above code path. Idea here's
that we always want to create the sysfs link from head disk node to each namespace path
irrespective of path's ANA state. However we could do that only when at-least one path is
advertising its ANA state as LIVE so that its corresponding head disk node would come live
and then we could create sysfs link to all paths. In fact, this requirement was proposed by
Hannes[1] and so I implemented it in v5 patchset.
 
> Or do you want to say whenever the link exist the path is usable? Trying
> to figure out if this is a good idea or not when nvme-cli/libnvme
> iterates over sysfs and it races with this, what's the user experience?
> 
If a link to path from head node exists then it doesn't mean always path is usable. We need
to read its ANA state to determine whether path is usable or not.

> I am sorry if this has been already discussed. I just completely lost
> the state :)

No worries..:) Please let me know if you have any further comments/questions.

[1] https://lore.kernel.org/all/3c92b9ae-1223-4787-90e3-955f82161269@suse.de/

Thanks,
--Nilay

