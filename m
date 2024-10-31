Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9859EE6896B
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 09:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lcw4BlaIEx5MSTprP5TsHdnLw0xYyyZ7UV0Ks0UldHI=; b=ye4pP0ThUsEMeuI8CghLWOSC8H
	ISjBXV71jOuD74axpZjTnGFnPoplkq7hOW49WHctgEvhjOg+jxWAYsrcHdO/28HzoYQ5Re+WMF/Dy
	6LpWGUMSIOEOc8y8RrxPJ3LxFbU3SZ3mzjuvIZGFnwMbepLGFQwJPW//spvm1rnumFeu5Y+LITfdd
	vXcHMAuX/BJaMtMgby1z+C9Ur8fMtu8mys69IH16XZ2vdKVYE05GY61xPran04B4iEsieBPDN8xiS
	9GefvCw33E/F7xbIJnmcnSDHKkuMsPWkB8YMatdLj4XflAn6gjGVSi+lhvDUy9kSh7vqtSEVokIAj
	a5LEONlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6RnM-000000038RJ-3jaY;
	Thu, 31 Oct 2024 09:48:48 +0000
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6RmA-000000038KX-1myI
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 09:47:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730368051; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Lcw4BlaIEx5MSTprP5TsHdnLw0xYyyZ7UV0Ks0UldHI=;
	b=kYYw+uZdjVfOwcnFB1MX42P0sLRHT4iAM5InOLA2OsuT2V8dffaNgwIWNPvWn6y/y512xRDfaje9M3F4SE68xZPU33pZ8XskY2p6hBaGfFKMH7ed3pRBOf19psVMw0i+4CalflmOTNm9pStHFnVlHZYDMzGxVa3zYrZx5S14F0g=
Received: from 30.178.82.44(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WII4Qu3_1730368048 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Oct 2024 17:47:29 +0800
Message-ID: <505e459b-8c18-4c7c-bad5-23b9bbe4ca3f@linux.alibaba.com>
Date: Thu, 31 Oct 2024 17:47:25 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH blktests v2] nvme/{common/nvme, 051, 052}: introduce
 def_nsid
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "dwagner@suse.de" <dwagner@suse.de>,
 "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20241031023521.36012-1-kanie@linux.alibaba.com>
 <mb3o3dkfgvq7etpplvq6cvcbbkhmvvnmge4omxu7nqzihgzwdt@rbytctuhijw3>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <mb3o3dkfgvq7etpplvq6cvcbbkhmvvnmge4omxu7nqzihgzwdt@rbytctuhijw3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_024734_998341_0EE805C5 
X-CRM114-Status: GOOD (  17.87  )
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


在 2024/10/31 15:54, Shinichiro Kawasaki 写道:
> On Oct 31, 2024 / 10:35, Guixin Liu wrote:
>> Use def_nsid instead of hard code, the default of def_nsid is 1.
>>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> Reviewed-by: Daniel Wagner <dwagner@suse.de>
>> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>> ---
>> Changes from v1 to v2:
>> - change the hard code in _remove_nvmet_subsystem() to fix
>> the nvme/004 fail if change def_nsid to 2.
> Thanks for the update. I think you overlooked my other comments for v1, which
> were at the end of my e-mail [1].
>
> [1] https://lore.kernel.org/linux-nvme/33susvhlxjt2uf3gqldcb2n43pgrvt5m2wj6b27nbgeoxamfkn@az45ko2fsydt/
>
> Here I quote my comments:
>
> ------------------------------------------------------------------------------
> After this change, when def_nsid is larger than iteration=20, nvme/052 will do
> nothing. I think the change should be like this:
>
>      for ((i = 2; i <= iterations; i++)); do {
>          nsid=$((def_nsid + i - 1))

Sorry I miss this, I think here "i" can be start with 1, and 
nsid=$((def_nsid + i)).

Changed in v3.

> 	truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path).${nsid}"
>          uuid=$(_create_nvmet_ns --blkdev "$(_nvme_def_file_path).${nsid}" \
>                                     --nsid "${nsid}")
>          ....
>
> Also, same change will be required in nvme/016 and nvme/017. They also use the
> --nsid option.
>
> $ git grep -e "--nsid"
> common/nvme:                    --nsid)
> tests/nvme/016:         _create_nvmet_ns --nsid "${i}" \
> tests/nvme/017:         _create_nvmet_ns --nsid "${i}" \
> tests/nvme/052:                                 --nsid "${i}")
Also changed in v3, thanks.
> ------------------------------------------------------------------------------
>
> And I have one more comment below.
>
> [...]
>> diff --git a/tests/nvme/052 b/tests/nvme/052
>> index 1dcda23..781a9f0 100755
>> --- a/tests/nvme/052
>> +++ b/tests/nvme/052
>> @@ -57,10 +57,10 @@ test() {
>>   
>>   	_nvme_connect_subsys
>>   
>> -	# start iteration from ns-id 2 because ns-id 1 is created
>> -	# by default when nvme target is setup. Also ns-id 1 is
>> +	# start iteration from def_nsid+1 because def_nsid is created
>> +	# by default when nvme target is setup. Also def_nsid is
>>   	# deleted when nvme target is cleaned up.
>> -	for ((i = 2; i <= iterations; i++)); do {
>> +	for ((i = $((${def_nsid})) + 1; i <= iterations; i++)); do {
>>   		truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path).$i"
>>   		uuid="$(uuidgen -r)"
> The change above causes the shellcheck error below. Do you see the error in your
> environment?
>
> ------------------------------------------------------------------------------
> $ make check
> shellcheck -x -e SC2119 -f gcc check common/* \
>          tests/*/rc tests/*/[0-9]*[0-9] src/*.sh
> tests/nvme/052:63:15: note: $/${} is unnecessary on arithmetic variables. [SC2004]
> make: *** [Makefile:21: check] Error 1
> ------------------------------------------------------------------------------

If change to nsid=$((def_nsid + i)), no error report now.

Thanks, I will remember to run "make check" before I send the patch.

Best Regards,

Guixin Liu


