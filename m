Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D964EC3DA4A
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Aug 2024 13:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yGzMEPJqkAKEy2FBgLUaB84evIPM2OUJW/aQKNmxS/s=; b=PBzDosgUoyMJQ0HYoobNrSAwCx
	+GHs+Mq+ZbaiEdeCqjktdZcX6ZwmBjbovvjVgJITu9p7VevnWVOtWyq1gPszSBwzvZ0WFjcYZjwtK
	Xx6gIeMYTGvy45t61xY4KTwc17OLeBNFPMczIF/QkDRk2uYotKrn0srXrRBFmhwoCEHV3N46OVH2y
	o+Gat5uUbQ/H39a14n3K2xfzEce2DuVh9wnhFBNqTBm8+xPC6xbIL/VX+CudxjFT/2LdQXO8HRpJi
	phe+TEKxjW7qMrGlyA2A3t5fifM44AQF99DUVmBmkjTQPryukGgA6AulZ0kHki9DoVXh6hlV19Yne
	S7WflJxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg2Y0-00000001dio-02oG;
	Mon, 19 Aug 2024 13:35:48 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg2Xw-00000001dhO-2UfY
	for linux-nvme@lists.infradead.org;
	Mon, 19 Aug 2024 13:35:47 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JD9wX7007016;
	Mon, 19 Aug 2024 13:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=y
	GzMEPJqkAKEy2FBgLUaB84evIPM2OUJW/aQKNmxS/s=; b=GcMWYRhEzQWusLPMz
	ZJhIfH8dYaRg2QJFhIfUCh6KorzzXn+q6BxcXt5/d2MReU3yiqTy498sq/J6/EtM
	nQVpiksSJB8vtyrYDCDGlChgE0MFQDLjBTrD3pQXhLuprf9GsBog/GoQh7phpSXz
	8rLSlLXpmzA0ageIXSx/gfLSk22oP7ry4slkOs1E7NVKeWb45uFtq164vtEQ5qwv
	gPasB9EtIvocmz8mG6mErAB+jkmombtB9cIlWcQ1mFSPFbphFFIFAQ++VPhAdv5R
	krAFUotM51kgnhazw25wzrZdlgsCSpXPrUibFnPIYzBNe+1Jnz2wDdZjfOrRnKRY
	AdxSQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mb5gxcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 13:35:41 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47JDXU1E031883;
	Mon, 19 Aug 2024 13:35:40 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mb5gxcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 13:35:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47JDC7Ta014245;
	Mon, 19 Aug 2024 13:35:39 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4137pmp72t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 13:35:39 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47JDZawl31130162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 13:35:38 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2404B58059;
	Mon, 19 Aug 2024 13:35:36 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96D7C58055;
	Mon, 19 Aug 2024 13:35:33 +0000 (GMT)
Received: from [9.171.22.101] (unknown [9.171.22.101])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Aug 2024 13:35:33 +0000 (GMT)
Message-ID: <f2f9d5b4-3c50-41a9-bc53-49706f6f4e12@linux.ibm.com>
Date: Mon, 19 Aug 2024 19:05:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blktests failures with v6.11-rc1 kernel
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Yi Zhang <yi.zhang@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "nbd@other.debian.org" <nbd@other.debian.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <5yal5unzvisrvfhhvsqrsqgu4tfbjp2fsrnbuyxioaxjgbojsi@o2arvhebzes3>
 <ab363932-ab3d-49b1-853d-7313f02cce9e@linux.ibm.com>
 <ljqlgkvhkojsmehqddmeo4dng6l3yaav6le2uslsumfxivluwu@m7lkx3j4mkkw>
 <79a7ec0d-c22d-44cf-a832-13da05a1fcbd@linux.ibm.com>
 <CAHj4cs-5DPDFuBzm3aymeAi6UWHhgXSYsgaCACKbjXp=i0SyTA@mail.gmail.com>
 <1f917bc1-8a6a-4c88-a619-cf8ddc4534a4@linux.ibm.com>
 <tczctp5tkr34o3k3f4dlyhuutgp2ycex6gdbjuqx4trn6ewm2i@qbkza3yr5wdd>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <tczctp5tkr34o3k3f4dlyhuutgp2ycex6gdbjuqx4trn6ewm2i@qbkza3yr5wdd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4tIkaY5x4q2LKG2zWm7K19zKJ5S5eR52
X-Proofpoint-GUID: GuWjpb6itoRoiNMSYiKg-Glfkr5JnBqZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_11,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408190090
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240819_063544_894702_CE9231CC 
X-CRM114-Status: GOOD (  44.61  )
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



On 8/19/24 18:04, Shinichiro Kawasaki wrote:
> On Aug 14, 2024 / 18:05, Nilay Shroff wrote:
>>
>>
>> On 8/13/24 12:36, Yi Zhang wrote:
>>> On Sat, Aug 3, 2024 at 12:49 AM Nilay Shroff <nilay@linux.ibm.com> wrote:
>>>
>>> There are no simultaneous tests during the CKI tests running.
>>> I reproduced the failure on that server and always can be reproduced
>>> within 5 times:
>>> # sh a.sh
>>> ==============================0
>>> nvme/052 (tr=loop) (Test file-ns creation/deletion under one subsystem) [passed]
>>>     runtime  21.496s  ...  21.398s
>>> ==============================1
>>> nvme/052 (tr=loop) (Test file-ns creation/deletion under one subsystem) [failed]
>>>     runtime  21.398s  ...  21.974s
>>>     --- tests/nvme/052.out 2024-08-10 00:30:06.989814226 -0400
>>>     +++ /root/blktests/results/nodev_tr_loop/nvme/052.out.bad
>>> 2024-08-13 02:53:51.635047928 -0400
>>>     @@ -1,2 +1,5 @@
>>>      Running nvme/052
>>>     +cat: /sys/block/nvme1n2/uuid: No such file or directory
>>>     +cat: /sys/block/nvme1n2/uuid: No such file or directory
>>>     +cat: /sys/block/nvme1n2/uuid: No such file or directory
>>>      Test complete
>>> # uname -r
>>> 6.11.0-rc3
>>
>> We may need to debug this further. Is it possible to patch blktest and 
>> collect some details when this issue manifests? If yes then can you please
>> apply the below diff and re-run your test? This patch would capture output 
>> of "nvme list" and "sysfs attribute tree created under namespace head node"
>> and store those details in 052.full file. 
>>
>> diff --git a/common/nvme b/common/nvme
>> index 9e78f3e..780b5e3 100644
>> --- a/common/nvme
>> +++ b/common/nvme
>> @@ -589,8 +589,23 @@ _find_nvme_ns() {
>>                 if ! [[ "${ns}" =~ nvme[0-9]+n[0-9]+ ]]; then
>>                         continue
>>                 fi
>> +               echo -e "\nBefore ${ns}/uuid check:\n" >> ${FULL}
>> +               echo -e "\n`nvme list -v`\n" >> ${FULL}
>> +               echo -e "\n`tree ${ns}`\n" >> ${FULL}
>> +
>>                 [ -e "${ns}/uuid" ] || continue
>>                 uuid=$(cat "${ns}/uuid")
>> +
>> +               if [ "$?" = "1" ]; then
>> +                       echo -e "\nFailed to read $ns/uuid\n" >> ${FULL}
>> +                       echo "`nvme list -v`" >> ${FULL}
>> +                       if [ -d "${ns}" ]; then
>> +                               echo -e "\n`tree ${ns}`\n" >> ${FULL}
>> +                       else
>> +                               echo -e "\n${ns} doesn't exist!\n" >> ${FULL}
>> +                       fi
>> +               fi
>> +
>>                 if [[ "${subsys_uuid}" == "${uuid}" ]]; then
>>                         basename "${ns}"
>>                 fi
>>
>>
>> After applying the above diff, when this issue occurs on your system copy this 
>> file "</path/to/blktests>/results/nodev_tr_loop/nvme/052.full" and send it across. 
>> This may give us some clue about what might be going wrong. 
> 
> Nilay, thank you for this suggestion. To follow it, I tried to recreate the
> failure again, and managed to do it :) When I repeat the test case 20 or 40
> times one of my test machines, the failure is observed in stable manner.

Shinichiro, I am glad that you were able to recreate this issue.

> I applied your debug patch above to blktests, then I repeated the test case.
> Unfortunately, the failure disappeared. When I repeat the test case 100 times,
> the failure was not observed. I guess the echos for debug changed the timing to
> access the sysfs uuid file, then the failure disappeared.

Yes this could be possible. BTW, Yi tried the same patch and with the patch applied,
this issue could be still reproduced on Yi's testbed!! 
> This helped me think about the cause. The test case repeats _create_nvmet_ns
> and _remove_nvmet_ns. Then, it repeats creating and removing the sysfs uuid
> file. I guess when _remove_nvmet_ns echos 0 to ${nvemt_ns_path}/enable to
> remove the namespace, it does not wait for the completion of the removal work.
> Then, when _find_nvme_ns() checks existence of the sysfs uuid file, it refers to
> the sysfs uuid file that the previous _remove_nvmet_ns left. When it does cat
> to the sysfs uuid file, it fails because the sysfs uuid file has got removed,
> before recreating it for the next _create_nvmet_ns.

I agree with your assessment about the plausible cause of this issue. I just reviewed
the nvme target kernel code and it's now apparent to me that we need to wait for the 
removal of the namespace before we re-create the next namespace. I think this is a miss.  
> 
> Based on this guess, I created a patch below. It modifies the test case to wait
> for the namespace device disappears after calling _remove_nvmet_ns. (I assume
> that the sysfs uuid file disappears when the device file disappears). With
> this patch, the failure was not observed by repeating it 100 times. I also
> reverted the kernel commit ff0ffe5b7c3c ("nvme: fix namespace removal list")
> from v6.11-rc4, then confirmed that the test case with this change still can
> detect the regression.
> 
I am pretty sure that your patch would solve this issue.  

> I will do some more confirmation. If it goes well, will post this change as
> a formal patch.
> 
> diff --git a/tests/nvme/052 b/tests/nvme/052
> index cf6061a..469cefd 100755
> --- a/tests/nvme/052
> +++ b/tests/nvme/052
> @@ -39,15 +39,32 @@ nvmf_wait_for_ns() {
>  		ns=$(_find_nvme_ns "${uuid}")
>  	done
>  
> +	echo "$ns"
>  	return 0
>  }
>  
> +nvmf_wait_for_ns_removal() {
> +	local ns=$1 i
> +
> +	for ((i = 0; i < 10; i++)); do
> +		if [[ ! -e /dev/$ns ]]; then
> +			return
> +		fi
> +		sleep .1
> +		echo "wait removal of $ns" >> "$FULL"
> +	done
> +
> +	if [[ -e /dev/$ns ]]; then
> +		echo "Failed to remove the namespace $"
> +	fi
> +}
> +
>  test() {
>  	echo "Running ${TEST_NAME}"
>  
>  	_setup_nvmet
>  
> -	local iterations=20
> +	local iterations=20 ns
>  
>  	_nvmet_target_setup
>  
> @@ -63,7 +80,7 @@ test() {
>  		_create_nvmet_ns "${def_subsysnqn}" "${i}" "$(_nvme_def_file_path).$i" "${uuid}"
>  
>  		# wait until async request is processed and ns is created
> -		nvmf_wait_for_ns "${uuid}"
> +		ns=$(nvmf_wait_for_ns "${uuid}")
>  		if [ $? -eq 1 ]; then
>  			echo "FAIL"
>  			rm "$(_nvme_def_file_path).$i"
> @@ -71,6 +88,7 @@ test() {
>  		fi
>  
>  		_remove_nvmet_ns "${def_subsysnqn}" "${i}"
> +		nvmf_wait_for_ns_removal "$ns"
>  		rm "$(_nvme_def_file_path).$i"
>  	}
>  	done

I think there's some formatting issue in the above patch. I see some stray characters
which you may cleanup/fix later when you send the formal patch.

Yi, I think you you may also try the above patch on your testbed and confirm the result.

Thanks,
--Nilay

