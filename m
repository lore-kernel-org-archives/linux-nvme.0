Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB21E7717D
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2024 12:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w5BxJBEp/8J5xFIEYmw/jEg41H5+c1CS6MBspkl53rc=; b=I4Dl7qAdecGzV7OE+5qsaq+EPP
	XSjoMaMPqLMgqBOQdDz3la29T8qa5eWSdP60V/oHFyEpVY3ZqsfiRORpwxNgw9vDjH7gxamIDPZii
	bXJzwJR5nbAkQCmQ6wYVbewUvvEhJlD+WF9Yx8i1pooErntY5je0aMS9XN1cAKbyikbD4FRQQ8SYl
	Biiopouo/wpIRcW2kuslKd/nu2732q2ydK0LNvv9VUNNg7ko9vVIxiu99nNBQjwmMyUsN+V9rPXA9
	GI8CCBdEGPV6SitM2pD54UrEyKFvpWUjIyx1ESgtYd9y1IdSXFNKbWorOor7is/gQhYs9g34aZjjA
	TOuqPVVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLLO4-0000000Elmw-1r8U;
	Wed, 11 Dec 2024 12:00:16 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLLO1-0000000ElmQ-0lLN
	for linux-nvme@lists.infradead.org;
	Wed, 11 Dec 2024 12:00:14 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBBePFl009021;
	Wed, 11 Dec 2024 12:00:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=w5BxJB
	Ep/8J5xFIEYmw/jEg41H5+c1CS6MBspkl53rc=; b=NCLWp8F+WeM/vzRPGp2csV
	VUoxxY/FUE/pxdV/mEymJJowRxVa5tfsLAjnD/RgVKGNpaix0UGSGwlrLZF5XnVz
	wlkuLCqzmettsqGwhhFa6WW4Q3+FT8WeuZRfkSHjyYFJYBAZ7ypm44E27wHxckjL
	Z+whKS6xKgqAkJv5pCTLG8hN4p7uwEonLiEn5Cep8e5zp0Bi0oapfqTizaSKh5Rf
	PZuqvR4JFYTO1tb7nuGSBRkCZpCN5OJ/zzI3Zc4AfwM4BAnVxpni0ewQYg6cQsxp
	NaCiLiDnt+IYimGVwAT5l2N2IIMYlOv3XhQ1p08d3zwmuU08tExrZdcC1b1/v44Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ccsjkytb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 12:00:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB8tT3Q016944;
	Wed, 11 Dec 2024 11:59:59 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d12y9er5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 11:59:59 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BBBxxp620120080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 11:59:59 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 446E858060;
	Wed, 11 Dec 2024 11:59:59 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 298B85803F;
	Wed, 11 Dec 2024 11:59:56 +0000 (GMT)
Received: from [9.171.17.138] (unknown [9.171.17.138])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Dec 2024 11:59:55 +0000 (GMT)
Message-ID: <bf2a7797-0eb9-4355-a8ac-ffcf2235d227@linux.ibm.com>
Date: Wed, 11 Dec 2024 17:29:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvmet-loop: avoid using mutex in IO hotpath
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
        shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com,
        gjoyce@linux.ibm.com
References: <20241211085814.1239731-1-nilay@linux.ibm.com>
 <faa65186-839d-4352-9d94-386e440abb48@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <faa65186-839d-4352-9d94-386e440abb48@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: M413LASix4qHT_aKC44XveEhX3aP98q2
X-Proofpoint-ORIG-GUID: M413LASix4qHT_aKC44XveEhX3aP98q2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412110087
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_040013_356327_E3171BEC 
X-CRM114-Status: GOOD (  32.39  )
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



On 12/11/24 16:59, Hannes Reinecke wrote:
> On 12/11/24 09:58, Nilay Shroff wrote:
>> Using mutex lock in IO hot path causes the kernel BUG sleeping while
>> atomic. Shinichiro[1], first encountered this issue while running blktest
>> nvme/052 shown below:
>>
>> BUG: sleeping function called from invalid context at kernel/locking/mutex.c:585
>> in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 996, name: (udev-worker)
>> preempt_count: 0, expected: 0
>> RCU nest depth: 1, expected: 0
>> 2 locks held by (udev-worker)/996:
>>   #0: ffff8881004570c8 (mapping.invalidate_lock){.+.+}-{3:3}, at: page_cache_ra_unbounded+0x155/0x5c0
>>   #1: ffffffff8607eaa0 (rcu_read_lock){....}-{1:2}, at: blk_mq_flush_plug_list+0xa75/0x1950
>> CPU: 2 UID: 0 PID: 996 Comm: (udev-worker) Not tainted 6.12.0-rc3+ #339
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
>> Call Trace:
>>   <TASK>
>>   dump_stack_lvl+0x6a/0x90
>>   __might_resched.cold+0x1f7/0x23d
>>   ? __pfx___might_resched+0x10/0x10
>>   ? vsnprintf+0xdeb/0x18f0
>>   __mutex_lock+0xf4/0x1220
>>   ? nvmet_subsys_nsid_exists+0xb9/0x150 [nvmet]
>>   ? __pfx_vsnprintf+0x10/0x10
>>   ? __pfx___mutex_lock+0x10/0x10
>>   ? snprintf+0xa5/0xe0
>>   ? xas_load+0x1ce/0x3f0
>>   ? nvmet_subsys_nsid_exists+0xb9/0x150 [nvmet]
>>   nvmet_subsys_nsid_exists+0xb9/0x150 [nvmet]
>>   ? __pfx_nvmet_subsys_nsid_exists+0x10/0x10 [nvmet]
>>   nvmet_req_find_ns+0x24e/0x300 [nvmet]
>>   nvmet_req_init+0x694/0xd40 [nvmet]
>>   ? blk_mq_start_request+0x11c/0x750
>>   ? nvme_setup_cmd+0x369/0x990 [nvme_core]
>>   nvme_loop_queue_rq+0x2a7/0x7a0 [nvme_loop]
>>   ? __pfx___lock_acquire+0x10/0x10
>>   ? __pfx_nvme_loop_queue_rq+0x10/0x10 [nvme_loop]
>>   __blk_mq_issue_directly+0xe2/0x1d0
>>   ? __pfx___blk_mq_issue_directly+0x10/0x10
>>   ? blk_mq_request_issue_directly+0xc2/0x140
>>   blk_mq_plug_issue_direct+0x13f/0x630
>>   ? lock_acquire+0x2d/0xc0
>>   ? blk_mq_flush_plug_list+0xa75/0x1950
>>   blk_mq_flush_plug_list+0xa9d/0x1950
>>   ? __pfx_blk_mq_flush_plug_list+0x10/0x10
>>   ? __pfx_mpage_readahead+0x10/0x10
>>   __blk_flush_plug+0x278/0x4d0
>>   ? __pfx___blk_flush_plug+0x10/0x10
>>   ? lock_release+0x460/0x7a0
>>   blk_finish_plug+0x4e/0x90
>>   read_pages+0x51b/0xbc0
>>   ? __pfx_read_pages+0x10/0x10
>>   ? lock_release+0x460/0x7a0
>>   page_cache_ra_unbounded+0x326/0x5c0
>>   force_page_cache_ra+0x1ea/0x2f0
>>   filemap_get_pages+0x59e/0x17b0
>>   ? __pfx_filemap_get_pages+0x10/0x10
>>   ? lock_is_held_type+0xd5/0x130
>>   ? __pfx___might_resched+0x10/0x10
>>   ? find_held_lock+0x2d/0x110
>>   filemap_read+0x317/0xb70
>>   ? up_write+0x1ba/0x510
>>   ? __pfx_filemap_read+0x10/0x10
>>   ? inode_security+0x54/0xf0
>>   ? selinux_file_permission+0x36d/0x420
>>   blkdev_read_iter+0x143/0x3b0
>>   vfs_read+0x6ac/0xa20
>>   ? __pfx_vfs_read+0x10/0x10
>>   ? __pfx_vm_mmap_pgoff+0x10/0x10
>>   ? __pfx___seccomp_filter+0x10/0x10
>>   ksys_read+0xf7/0x1d0
>>   ? __pfx_ksys_read+0x10/0x10
>>   do_syscall_64+0x93/0x180
>>   ? lockdep_hardirqs_on_prepare+0x16d/0x400
>>   ? do_syscall_64+0x9f/0x180
>>   ? lockdep_hardirqs_on+0x78/0x100
>>   ? do_syscall_64+0x9f/0x180
>>   ? lockdep_hardirqs_on_prepare+0x16d/0x400
>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> RIP: 0033:0x7f565bd1ce11
>> Code: 00 48 8b 15 09 90 0d 00 f7 d8 64 89 02 b8 ff ff ff ff eb bd e8 d0 ad 01 00 f3 0f 1e fa 80 3d 35 12 0e 00 00 74 13 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 4f c3 66 0f 1f 44 00 00 55 48 89 e5 48 83 ec
>> RSP: 002b:00007ffd6e7a20c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>> RAX: ffffffffffffffda RBX: 0000000000001000 RCX: 00007f565bd1ce11
>> RDX: 0000000000001000 RSI: 00007f565babb000 RDI: 0000000000000014
>> RBP: 00007ffd6e7a2130 R08: 00000000ffffffff R09: 0000000000000000
>> R10: 0000556000bfa610 R11: 0000000000000246 R12: 000000003ffff000
>> R13: 0000556000bfa5b0 R14: 0000000000000e00 R15: 0000556000c07328
>>   </TASK>
>>
>> Apparently, the above issue is caused due to using mutex lock while
>> we're in IO hot path. It's a regression caused with commit 505363957fad
>> ("nvmet: fix nvme status code when namespace is disabled"). The mutex
>> ->su_mutex is used to find whether a disabled nsid exists in the config
>> group or not. This is to differentiate between a nsid that is disabled
>> vs non-existent.
>>
>> To mitigate the above issue, we've worked upon a fix[2] where we now
>> insert nsid in subsys Xarray as soon as it's created under config group
>> and later when that nsid is enabled, we add an Xarray mark on it and set
>> ns->enabled to true. The Xarray mark is useful while we need to loop
>> through all enabled namepsaces under a subsystem using xa_for_each_marked()
>> API. If later a nsid is disabled then we clear Xarray mark from it and also
>> set ns->enabled to false. It's only when nsid is deleted from the config
>> group we delete it from the Xarray.
>>
>> So with this change, now we could easily differentiate a nsid is disabled
>> (i.e. Xarray entry for ns exists but ns->enabled is set to false) vs non-
>> existent (i.e.Xarray entry for ns doesn't exist).
>>
>> Link: https://lore.kernel.org/linux-nvme/20241022070252.GA11389@lst.de/ [2]
>> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>> Closes: https://lore.kernel.org/linux-nvme/tqcy3sveity7p56v7ywp7ssyviwcb3w4623cnxj3knoobfcanq@yxgt2mjkbkam/ [1]
>> Fixes: 505363957fad ("nvmet: fix nvme status code when namespace is disabled")
>> Fix-suggested-by: Christoph Hellwig <hch@lst.de>
>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>> Changes from v1:
>> - Added nvmet_for_each_enabled_ns wrapper for xa_for_each_marked (hch)
>> - Added nvmet_for_each_ns which iterates all namespaces (hch)
>> - Removed now ununsed function nvmet_subsys_nsid_exists
>> - Pick up Reviewed-by: Hannes Reinecke <hare@suse.de>
>> - Pick up Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>> - Link to v1: https://lore.kernel.org/all/20241129104838.3015665-1-nilay@linux.ibm.com/
>> ---
>>   drivers/nvme/target/admin-cmd.c |   9 +--
>>   drivers/nvme/target/configfs.c  |  12 ----
>>   drivers/nvme/target/core.c      | 108 +++++++++++++++++++-------------
>>   drivers/nvme/target/nvmet.h     |   7 +++
>>   drivers/nvme/target/pr.c        |   8 +--
>>   5 files changed, 79 insertions(+), 65 deletions(-)
>>
>> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
>> index 2962794ce881..fa89b0549c36 100644
>> --- a/drivers/nvme/target/admin-cmd.c
>> +++ b/drivers/nvme/target/admin-cmd.c
>> @@ -139,7 +139,7 @@ static u16 nvmet_get_smart_log_all(struct nvmet_req *req,
>>       unsigned long idx;
>>         ctrl = req->sq->ctrl;
>> -    xa_for_each(&ctrl->subsys->namespaces, idx, ns) {
>> +    nvmet_for_each_enabled_ns(&ctrl->subsys->namespaces, idx, ns) {
>>           /* we don't have the right data for file backed ns */
>>           if (!ns->bdev)
>>               continue;
>> @@ -331,9 +331,10 @@ static u32 nvmet_format_ana_group(struct nvmet_req *req, u32 grpid,
>>       u32 count = 0;
>>         if (!(req->cmd->get_log_page.lsp & NVME_ANA_LOG_RGO)) {
>> -        xa_for_each(&ctrl->subsys->namespaces, idx, ns)
>> +        nvmet_for_each_enabled_ns(&ctrl->subsys->namespaces, idx, ns) {
>>               if (ns->anagrpid == grpid)
>>                   desc->nsids[count++] = cpu_to_le32(ns->nsid);
>> +        }
>>       }
>>         desc->grpid = cpu_to_le32(grpid);
>> @@ -772,7 +773,7 @@ static void nvmet_execute_identify_endgrp_list(struct nvmet_req *req)
>>           goto out;
>>       }
>>   -    xa_for_each(&ctrl->subsys->namespaces, idx, ns) {
>> +    nvmet_for_each_enabled_ns(&ctrl->subsys->namespaces, idx, ns) {
>>           if (ns->nsid <= min_endgid)
>>               continue;
>>   @@ -815,7 +816,7 @@ static void nvmet_execute_identify_nslist(struct nvmet_req *req, bool match_css)
>>           goto out;
>>       }
>>   -    xa_for_each(&ctrl->subsys->namespaces, idx, ns) {
>> +    nvmet_for_each_enabled_ns(&ctrl->subsys->namespaces, idx, ns) {
>>           if (ns->nsid <= min_nsid)
>>               continue;
>>           if (match_css && req->ns->csi != req->cmd->identify.csi)
>> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
>> index eeee9e9b854c..c0000db47cbb 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
>> @@ -810,18 +810,6 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
>>       NULL,
>>   };
>>   -bool nvmet_subsys_nsid_exists(struct nvmet_subsys *subsys, u32 nsid)
>> -{
>> -    struct config_item *ns_item;
>> -    char name[12];
>> -
>> -    snprintf(name, sizeof(name), "%u", nsid);
>> -    mutex_lock(&subsys->namespaces_group.cg_subsys->su_mutex);
>> -    ns_item = config_group_find_item(&subsys->namespaces_group, name);
>> -    mutex_unlock(&subsys->namespaces_group.cg_subsys->su_mutex);
>> -    return ns_item != NULL;
>> -}
>> -
>>   static void nvmet_ns_release(struct config_item *item)
>>   {
>>       struct nvmet_ns *ns = to_nvmet_ns(item);
>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>> index 1f4e9989663b..fde6c555af61 100644
>> --- a/drivers/nvme/target/core.c
>> +++ b/drivers/nvme/target/core.c
>> @@ -127,7 +127,7 @@ static u32 nvmet_max_nsid(struct nvmet_subsys *subsys)
>>       unsigned long idx;
>>       u32 nsid = 0;
>>   -    xa_for_each(&subsys->namespaces, idx, cur)
>> +    nvmet_for_each_enabled_ns(&subsys->namespaces, idx, cur)
>>           nsid = cur->nsid;
>>         return nsid;
>> @@ -441,11 +441,14 @@ u16 nvmet_req_find_ns(struct nvmet_req *req)
>>       struct nvmet_subsys *subsys = nvmet_req_subsys(req);
>>         req->ns = xa_load(&subsys->namespaces, nsid);
>> -    if (unlikely(!req->ns)) {
>> +    if (unlikely(!req->ns || !req->ns->enabled)) {
>>           req->error_loc = offsetof(struct nvme_common_command, nsid);
>> -        if (nvmet_subsys_nsid_exists(subsys, nsid))
>> -            return NVME_SC_INTERNAL_PATH_ERROR;
>> -        return NVME_SC_INVALID_NS | NVME_STATUS_DNR;
>> +        if (!req->ns) /* ns doesn't exist! */
>> +            return NVME_SC_INVALID_NS | NVME_STATUS_DNR;
>> +
>> +        /* ns exists but it's disabled */
>> +        req->ns = NULL;
>> +        return NVME_SC_INTERNAL_PATH_ERROR;
>>       }
>>         percpu_ref_get(&req->ns->ref);
> 
> Now I have to ask: Why do you set 'req->ns' to NULL here?
> The way I read this it would mean that the first call to nvmet_find_req_ns() would return INTERNAL_PATH_ERROR, and the
> second call would return INVALID_NS.
> 
> Is that intentional?
The nvmet_req_find_ns function returns error code for following two cases:
1) namespace doesn't exist in the config fs 
- the namespace entry doesn't exists in subsystem Xarray
- For this case req->ns would be always NULL as xa_load would return NULL
- We return error (NVME_SC_INVALID_NS | NVME_STATUS_DNR)

2) namespace exists in config fs but it's disabled
- the namespace entry exists in subsystem Xarray but it's marked as disabled
- As the ns is disabled, we don't increment refcount of this ns. So we set req->ns 
  to NULL and return error NVME_SC_INTERNAL_PATH_ERROR to the caller. Later in
  the call stack when we complete this request (please refer __nvmet_req_complete()), 
  we don't need to put the reference of the ns as req->ns is NULL.

Essentially, if nvmet_req_find_ns() returns error then we don't get reference 
to ns and hence set req->ns to NULL. And we don't need to make two different calls
to nvmet_find_req_ns(). It's based on one of two cases explianed above, 
nvmet_find_req_ns() would either return (NVME_SC_INVALID_NS | NVME_STATUS_DNR) or 
NVME_SC_INTERNAL_PATH_ERROR.

You may also refer this commit 505363957fad ("nvmet: fix nvme status code when 
namespace is disabled") where we first added error code NVME_SC_INTERNAL_PATH_ERROR in 
nvmet_req_find_ns().

Thanks,
--Nilay

