Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C635CD5B86D
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 09:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zg+gOv/NDdBJEyd6f0L9clqulIt30xb8+qd5TdGxy6U=; b=B7CUJEm9igJTm+fkzLOSo3nb3R
	X+QeZLBPzPQ18aiXLUFf/hgISRRn2Yv7gdObnLdZSALfn/NY/UU4R4km4KRFxSPp/ODwTWCiWMDaj
	SZZG7hCUAvxE/VlywKi5NQZkzZmUMiVoPA8PulW8YhQiH/OXmD+OcqY0l1APnroKuxSr1mrc3Igvn
	dEWSwPoS0rZYU375vzrDMXnhLfU+NuLF7ZfsDezpcbRVUVKF0yEYzX9HihRuX9flw77iwwiiCB73y
	3/2q0cLcc3GSx9ObuRWvLub45Y6DZQHz9pr0rxiR5m7YSp5oyOrfLa17aFu14ijSa+b2XLFHzpdLF
	9Q48VhYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t65IW-0000000HR7F-2dxa;
	Wed, 30 Oct 2024 09:47:28 +0000
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t65Fl-0000000HQkI-0Tvo
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 09:44:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730281472; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Zg+gOv/NDdBJEyd6f0L9clqulIt30xb8+qd5TdGxy6U=;
	b=A29o8ulG8ROC/hUzw0V7wUlpYiAYDm+ozE5OHf1uyMWNqLxq3d/UOj3UcQAKe2jO9XEGlos3YeJfpUInVjURB3O1SEmJXdZABGERPFM6SiatLqpZG+dHU9rRch4FUVgPDL2+cbaRq4/d/ymfV+Cevy7GyxlhCLyYixXasXqFfG0=
Received: from 30.178.82.27(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WIDgNT4_1730281470 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 30 Oct 2024 17:44:31 +0800
Message-ID: <9f17db9e-da89-47ba-9825-7f713d413daf@linux.alibaba.com>
Date: Wed, 30 Oct 2024 17:44:28 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] nvme/{common/nvme, 051, 052}: introduce def_nsid
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "dwagner@suse.de" <dwagner@suse.de>,
 "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20241029031931.118305-1-kanie@linux.alibaba.com>
 <33susvhlxjt2uf3gqldcb2n43pgrvt5m2wj6b27nbgeoxamfkn@az45ko2fsydt>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <33susvhlxjt2uf3gqldcb2n43pgrvt5m2wj6b27nbgeoxamfkn@az45ko2fsydt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_024437_912552_3AE0465E 
X-CRM114-Status: GOOD (  20.15  )
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


在 2024/10/30 15:31, Shinichiro Kawasaki 写道:
> On Oct 29, 2024 / 11:19, Guixin Liu wrote:
>> Use def_nsid instead of hard code, the default of def_nsid is 1.
> Hi Guixin, thnaks for the patch.
>
> May I know the motivation to introduce def_nsid? Does it aim to improve code
> readability? Or does it aim to allow testing various def_nsid values?

Just like def_subsysnqn and def_subsys_uuid, avoid hard code in testcases,

and let us to know the ns_id created by default.

> I guessed that the latter one is the motivation, and tried it. After applying
> the patch, I edited common/nvme to have differnet value: export def_nsid="2".
> With this change, nvme/004 failed. I guess your patch missed a change in
> _remove_nvmet_subsystem(). With this change, nvme/004 passed.
>
> @@ -589,7 +589,7 @@ _remove_nvmet_subsystem() {
>          local nvmet_subsystem="$1"
>          local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
>
> -       _remove_nvmet_ns "${nvmet_subsystem}" "1"
> +       _remove_nvmet_ns "${nvmet_subsystem}" "$def_nsid"
>          rm -f "${subsys_path}"/allowed_hosts/*
>          rmdir "${subsys_path}"
>   }
>
Thanks, I miss this, will be changed in v2.

Best Regards,

Guixin Liu

>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>>   common/nvme    | 3 ++-
>>   tests/nvme/051 | 2 +-
>>   tests/nvme/052 | 6 +++---
>>   3 files changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/common/nvme b/common/nvme
>> index c1aa8d6..6371efe 100644
>> --- a/common/nvme
>> +++ b/common/nvme
>> @@ -16,6 +16,7 @@ def_hostid="0f01fb42-9f7f-4856-b0b3-51e60b8de349"
>>   def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
>>   export def_subsysnqn="blktests-subsystem-1"
>>   export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
>> +export def_nsid="1"
>>   _check_conflict_and_set_default NVMET_TRTYPES nvme_trtype "loop"
>>   _check_conflict_and_set_default NVME_IMG_SIZE nvme_img_size 1G
>>   _check_conflict_and_set_default NVME_NUM_ITER nvme_num_iter 1000
>> @@ -537,7 +538,7 @@ _create_nvmet_subsystem() {
>>   	mkdir -p "${cfs_path}"
>>   	echo 0 > "${cfs_path}/attr_allow_any_host"
>>   	_create_nvmet_ns --subsysnqn "${nvmet_subsystem}" \
>> -			 --nsid "1" \
>> +			 --nsid "${def_nsid}" \
>>   			 --blkdev "${blkdev}" \
>>   			 --uuid "${uuid}" \
>>   			 ${resv_enable}
>> diff --git a/tests/nvme/051 b/tests/nvme/051
>> index 624b42f..4757b80 100755
>> --- a/tests/nvme/051
>> +++ b/tests/nvme/051
>> @@ -33,7 +33,7 @@ test() {
>>   	_setup_nvmet
>>   
>>   	_nvmet_target_setup
>> -	ns="${NVMET_CFS}subsystems/${def_subsysnqn}/namespaces/1"
>> +	ns="${NVMET_CFS}subsystems/${def_subsysnqn}/namespaces/${def_nsid}"
>>   
>>   	# fire off two enable/disable loops concurrently and wait
>>   	# for them to complete...
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
>>
> After this change, when def_nsid is larger than iteration=20, nvme/052 will do
> nothing. I think the change should be like this:
>
>      for ((i = 2; i <= iterations; i++)); do {
>          nsid=$((def_nsid + i - 1))
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

