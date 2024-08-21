Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21B3C52D7C
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Aug 2024 09:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XrAEh0ZtkvZoukS3TumB8LQejqAS1w9eI82HB9Hi1LA=; b=Kv7FGm+t/wgkLsdSosnccTAch5
	lUqq2yif4xmCwzMaH3hkVwO4t1h1Vpiikj+UuzIBJg3aKndL/h+9tJYIaFWVGJWy6wNJL0K5fmYTH
	Ppttq9LW8Cc18UaioDLa3QvLSSVbvqp6irs2X4IVL6nd0XPF/TwYPpKaJcio1NTSxQHPop6VQRYrk
	AaJAX8b5DNH+2uqbXTXO0tDBOtQo8ZD5VdDq3Z9TWp9T07fifrvANWHTnQyOyJRdJ0oxt95cKLJUI
	fdLdcldSSJUHJgZ1Z5m5KcCVke0cbAq0NDc+CsWeHd9or6gQU9G4rCG5aWf9DWfo8+eOcTGD5Outv
	obRRlckg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sghfF-00000008FTe-1qIX;
	Wed, 21 Aug 2024 09:30:01 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sghdl-00000008F87-3T6K
	for linux-nvme@lists.infradead.org;
	Wed, 21 Aug 2024 09:28:31 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L3nFOQ005315;
	Wed, 21 Aug 2024 09:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=X
	rAEh0ZtkvZoukS3TumB8LQejqAS1w9eI82HB9Hi1LA=; b=I8Dbj5bc3ct0S7aWS
	uW0s6jhccXdNV6oU4V9Ha6YP/hpZHE4WGLmr5AQ6cOT1/xK+nz36nxt/230R0oLL
	iTVIKskRyAh/WUIWfnkv/iSkC8HvI1tnI3bbGn4kw90+rq/ddl+QSx2gMhfdNH85
	pyroj+DYEKAFsj1m6QA8M1Fy2xY4/H8bF18PO3VAJZnzs2JVzHb1qkJmN9PWeBdL
	63VoKcTCVpWST7Z0yV/Nm8xXOuwEzIU033R+GvmCAJX3KJIa37VDdJ8OE/YKFqLL
	aTfcJ8VRZQyWrnhWHk6Nh5/4OgkD8nsZaIbWPDnxYTDN90qkgSHZ02wkx0dZydLJ
	sSd/A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mb5sy6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 09:28:27 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47L9SR2f011498;
	Wed, 21 Aug 2024 09:28:27 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mb5sy68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 09:28:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47L8c4qd002215;
	Wed, 21 Aug 2024 09:28:22 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4136k0q6e8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 09:28:22 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47L9SJ1635717462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 09:28:21 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D28B25805D;
	Wed, 21 Aug 2024 09:28:17 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3644258054;
	Wed, 21 Aug 2024 09:28:16 +0000 (GMT)
Received: from [9.109.198.144] (unknown [9.109.198.144])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Aug 2024 09:28:15 +0000 (GMT)
Message-ID: <0750187c-24ad-4073-9ba1-d47b0ee95062@linux.ibm.com>
Date: Wed, 21 Aug 2024 14:58:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] nvme/052: wait for namespace removal before
 recreating namespace
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Yi Zhang <yi.zhang@redhat.com>
References: <20240820102013.781794-1-shinichiro.kawasaki@wdc.com>
 <d22e0c6f-0451-4299-970f-602458b6556d@linux.ibm.com>
 <zzodkioqxp6dcskfv6p5grncnvjdmakof3wemjemnralqhes4e@edr2n343oy62>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <zzodkioqxp6dcskfv6p5grncnvjdmakof3wemjemnralqhes4e@edr2n343oy62>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qYZBf5hWhrESmD1YrzT9WddZsQ9EzYRr
X-Proofpoint-GUID: dc6ifAUSO-6ycMPpvGeXQIfJMS-I4SS0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_07,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408210065
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240821_022830_143044_F01976E2 
X-CRM114-Status: GOOD (  31.35  )
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



On 8/21/24 12:51, Shinichiro Kawasaki wrote:
>> Under nvmf_wait_for_ns_removal(), instead of checking the existence of "/dev/$ns", 
>> how about checking the existence of file "/sys/block/$ns"? As we know, when this issue 
>> manifests, we have a stale entry "/sys/block/$ns/$uuid" lurking around from the 
>> previous iteration for sometime causing the observed symptom. So I think, we may reuse the 
>> _find_nvme_ns() function to wait until the stale "/sys/block/$ns/$uuid" file 
>> exists.
> 
> It sounds a good idea to reuse _find_nvme_ns().
> 
>> Maybe something like below:
>>
>> nvmf_wait_for_ns_removal() {
>>         local ns
>>         local timeout="5"
>>         local uuid="$1"
>>
>>         ns=$(_find_nvme_ns "${uuid}")
> 
> I tried this, and found that the _find_nvme_ns call spits out the failure
> "cat: /sys/block/nvme1n2/uuid: No such file or directory", because the
> delayed namespace removal can happen here. To suppress the error message,
> this line should be,
> 
>          ns=$(_find_nvme_ns "${uuid}" 2> /dev/null)
> 
yeah I agree here. We need to suppress this error.
>>
>>         start_time=$(date +%s)
>>         while [[ ! -z "$ns" ]]; do
>>                 sleep 1
>>                 end_time=$(date +%s)
>>                 if (( end_time - start_time > timeout )); then
>>                         echo "namespace with uuid \"${uuid}\" still " \
>>                                 "not deleted within ${timeout} seconds"
>>                         return 1
>>                 fi
>> 		echo "Waiting for $ns removal" >> ${FULL}
>>                 ns=$(_find_nvme_ns "${uuid}")
> 
> Same comment as above.
> 
>> 				
>>         done
>>
>>         return 0
>> }
> 
> I found that your nvmf_wait_for_ns_removal() above has certain amount of
> duplication with the existing nvmf_wait_for_ns(). To avoid the duplication,
> I suggest to reuse nvmf_wait_for_ns() and add a new argument to control wait
> target event: namespace 'created' or 'removed'. With this idea, I created the
> patch below. I confirmed the patch avoids the failure.
> 
Sounds good!

> One drawback of this new patch based on your suggestion is that it extends
> execution time of the test case from 20+ seconds to 40+ seconds. In most cases,
> the while loop condition check in nvmf_wait_for_ns() is true at the first time,
> and false at the the second time. So, nvmf_wait_for_ns() takes 1 second for one
> time "sleep 1". Before applying this patch, it took 20+ seconds for 20 times
> iteration. After applying the patch, it takes 40+ seconds, since one iteration
> calls nvmf_wait_for_ns() twice. So how about to reduce the sleep time from 1 to
> 0.1? I tried it and observed that it reduced the runtime from 40+ seconds to 10+
> seconds.
> 
If using sleep of 0.1 second saves execution time then yes this makes sense.

> diff --git a/tests/nvme/052 b/tests/nvme/052
> index cf6061a..22e0bf5 100755
> --- a/tests/nvme/052
> +++ b/tests/nvme/052
> @@ -20,23 +20,35 @@ set_conditions() {
>  	_set_nvme_trtype "$@"
>  }
>  
> +find_nvme_ns() {
> +	if [[ "$2" == removed ]]; then
> +		_find_nvme_ns "$1" 2> /dev/null
> +	else
> +		_find_nvme_ns "$1"
> +	fi
> +}
> +
> +# Wait for the namespace with specified uuid to fulfill the specified condtion,
> +# "created" or "removed".
>  nvmf_wait_for_ns() {
>  	local ns
>  	local timeout="5"
>  	local uuid="$1"
> +	local condition="$2"
>  
> -	ns=$(_find_nvme_ns "${uuid}")
> +	ns=$(find_nvme_ns "${uuid}" "${condition}")
>  
>  	start_time=$(date +%s)
> -	while [[ -z "$ns" ]]; do
> +	while [[ -z "$ns" && "$condition" == created  ]] ||
> +		      [[ -n "$ns" && "$condition" == removed ]]; do
>  		sleep 1
>  		end_time=$(date +%s)
>  		if (( end_time - start_time > timeout )); then
>  			echo "namespace with uuid \"${uuid}\" not " \
> -				"found within ${timeout} seconds"
> +				"${condition} within ${timeout} seconds"
>  			return 1
>  		fi
> -		ns=$(_find_nvme_ns "${uuid}")
> +		ns=$(find_nvme_ns "${uuid}" "${condition}")
>  	done
>  
>  	return 0
> @@ -63,7 +75,7 @@ test() {
>  		_create_nvmet_ns "${def_subsysnqn}" "${i}" "$(_nvme_def_file_path).$i" "${uuid}"
>  
>  		# wait until async request is processed and ns is created
> -		nvmf_wait_for_ns "${uuid}"
> +		nvmf_wait_for_ns "${uuid}" created
>  		if [ $? -eq 1 ]; then
>  			echo "FAIL"
>  			rm "$(_nvme_def_file_path).$i"
> @@ -71,6 +83,10 @@ test() {
>  		fi
>  
>  		_remove_nvmet_ns "${def_subsysnqn}" "${i}"
> +
> +		# wait until async request is processed and ns is removed
> +		nvmf_wait_for_ns "${uuid}" removed
> +
As nvme_wait_for_ns() returns either 0 (success) or 1 (failure), I think we 
should check the return status of nvme_wait_for_ns() here and bail out in case 
it returns failure same as what we do above while creating namespace. 

Another point: I think, we may always suppress error from _find_nvme_ns() irrespective
of it's being called while "creating" or "removing" the namespace assuming we always 
check the return status of nvme_wait_for_ns() in the main loop. So ideally we shall 
invoke _find_nvme_ns() from nvme_wait_for_ns() as below:

ns=$(_find_nvme_ns "${uuid}" 2>/dev/null)

On a cosmetic note: Maybe we can use readonly constants to make "created" and "removed"
parameters looks more elegant/readable. 

# Define constants
readonly NS_ADD="added"
readonly NS_DEL="deleted" 
 
Now we may reuse above constants instead of "created" and "removed". You may rename 
constant name if you don't like the name I used above :)

Thanks,
--Nilay

