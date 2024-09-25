Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452D5CF9C71
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Sep 2024 05:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/P5pkH6V988JX/j1+ZFo6wtf3JvXWpptjE1sbPcullA=; b=f/nPepQPZ5jiAq8IXFmUTnS3aD
	3hcepKAtYI1RzbP+eNhxgggYrB8AfjDP23nV0I/0ilwPGCCSJyrXa9TPNzrXruXpOZUpnpMRzfzlT
	mLU6RdGo9Ga2HzYmmfdJwQKGxdkn8l2me5+bdzSjKquVcotoarog/rwnoovG+fgC1OObQOIANEZ23
	nZK99OQmatCl2H8SfTXlKSb1glB+hn+13ZKfCwJYCRolqcnwVb/5KncLWu1Fm9M1jX/No9uenpB6w
	KXoIwtxOUMlnzOwUhQki95T0DmvwGCdDEjAF1XJy6oc1XfoyD20Nb6V34KHZ35ENlhRpIcLJ/TpKi
	YWqfKWkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1stL0F-000000047G2-2MIU;
	Wed, 25 Sep 2024 05:55:55 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1stL0D-000000047Ff-0dh0
	for linux-nvme@lists.infradead.org;
	Wed, 25 Sep 2024 05:55:54 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48P1WhM3012527;
	Wed, 25 Sep 2024 05:55:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	/P5pkH6V988JX/j1+ZFo6wtf3JvXWpptjE1sbPcullA=; b=TvFVOS7NY4r079Dq
	s+0RNkeomSvwlTktAqQ0yymszb3NbZWjQkH0EZw8Y1/NPBGsxWYQrZwyVA50Xd0c
	fTC5JdtbYQeCt4zxUTNih9rJqZ61zo+WUxaa6bRtJSX6uWexIIsoyYDny6Z6HtM1
	r56FPMwMn2BLHcgzvTR/wfmmd0HUfbOdNh9X5jphPUmW/w+pGg89VwE7Y3R2KfIt
	0kD0dhacuFw6jvVyrx2FHiy9IP4V501xO8uubU2RBswaLsn9XoY58kimWrI4Ug+J
	6wY9RLNh8fEB7BBU8xNn56TzmrM6jnBIllXdcOAIqCX4wK2ok0IqwfhtS7Xi1QZt
	zclWnw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41smjjwx1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 05:55:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48P5O7Vj008707;
	Wed, 25 Sep 2024 05:55:51 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41t8v17w7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 05:55:51 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48P5toQR2884174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 05:55:50 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA18E5805C;
	Wed, 25 Sep 2024 05:55:50 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB96758062;
	Wed, 25 Sep 2024 05:55:48 +0000 (GMT)
Received: from [9.179.23.77] (unknown [9.179.23.77])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Sep 2024 05:55:48 +0000 (GMT)
Message-ID: <0289eaa5-4d6a-4302-96b0-9fc225da05b7@linux.ibm.com>
Date: Wed, 25 Sep 2024 11:25:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] nvme/{033-037}: timeout while waiting for nvme
 passthru namespace device
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "martin.wilck@suse.com" <martin.wilck@suse.com>,
        "gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>
References: <20240924084907.143999-1-nilay@linux.ibm.com>
 <e4xvyahvmmwcv7uenm4mptqp452kl2qq6ve57j7y7z4ylqli36@26ceqvdvry4k>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <e4xvyahvmmwcv7uenm4mptqp452kl2qq6ve57j7y7z4ylqli36@26ceqvdvry4k>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oLTpPkDvn6QJCpB1qXlYECx-LJCaqxms
X-Proofpoint-GUID: oLTpPkDvn6QJCpB1qXlYECx-LJCaqxms
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409250037
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240924_225553_371884_A1DC9531 
X-CRM114-Status: GOOD (  41.70  )
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



On 9/24/24 17:44, Shinichiro Kawasaki wrote:
> On Sep 24, 2024 / 14:18, Nilay Shroff wrote:
>> Avoid waiting indefinitely for nvme passthru namespace block device
>> to appear. Wait for up to 5 seconds and during this time if namespace
>> block device doesn't appear then bail out and FAIL the test.
>>
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>> Hi,
>>
>> You may find more details about this issue here[1]. 
>>
>> I found that blktest nvme/033-037 hangs indefinitely when 
>> kernel rejects the passthru target namespace due to the 
>> duplicate IDs. This patch helps address this issue by  
>> ensuring that we bail out and fail the test if for any 
>> reason passthru target namspace is not created on the 
>> host. The relevant kernel patchv2 to fix the issue with 
>> duplicate IDs while using passthru loop target can be
>> found here[2].
>>
>> [1]: https://lore.kernel.org/all/8b17203f-ea4b-403b-a204-4fbc00c261ca@linux.ibm.com/
>> [2]: https://lore.kernel.org/all/20240921070547.531991-1-nilay@linux.ibm.com/
>>
>> Thanks!
> 
> Thanks for the patch :) It's bad that you stumbled into the infinite while loop
> in _nvmet_passthru_target_connect(). I agree that it should be fixed.
> 
> Please find my comments in line.
> 
Thank you for your review comments!!

>> ---
>>  tests/nvme/033 |  7 +++++--
>>  tests/nvme/034 |  7 +++++--
>>  tests/nvme/035 |  6 +++---
>>  tests/nvme/036 | 14 ++++++++------
>>  tests/nvme/037 |  6 +++++-
>>  tests/nvme/rc  | 12 +++++++++++-
>>  6 files changed, 37 insertions(+), 15 deletions(-)
>>
>> diff --git a/tests/nvme/033 b/tests/nvme/033
>> index 5e05175..171974e 100755
>> --- a/tests/nvme/033
>> +++ b/tests/nvme/033
>> @@ -62,8 +62,11 @@ test_device() {
>>  	_nvmet_passthru_target_setup
>>  
>>  	nsdev=$(_nvmet_passthru_target_connect)
>> -
>> -	compare_dev_info "${nsdev}"
>> +	if [[ -z "$nsdev" ]]; then
>> +		echo "FAIL"
> 
> I think some more specific failure message will be useful. How about
> "Failed to connect" or so? Same comment for the other test cases 034-037.
Agreed, I will add a meaningful error message in next patch.
> 
>> +	else
>> +		compare_dev_info "${nsdev}"
>> +	fi
>>  
>>  	_nvme_disconnect_subsys
>>  	_nvmet_passthru_target_cleanup
>> diff --git a/tests/nvme/034 b/tests/nvme/034
>> index 154fc91..7625204 100755
>> --- a/tests/nvme/034
>> +++ b/tests/nvme/034
>> @@ -32,8 +32,11 @@ test_device() {
>>  
>>  	_nvmet_passthru_target_setup
>>  	nsdev=$(_nvmet_passthru_target_connect)
>> -
>> -	_run_fio_verify_io --size="${NVME_IMG_SIZE}" --filename="${nsdev}"
>> +	if [[ -z "$nsdev" ]]; then
>> +		echo "FAIL"
>> +	else
>> +		_run_fio_verify_io --size="${NVME_IMG_SIZE}" --filename="${nsdev}"
>> +	fi
>>  
>>  	_nvme_disconnect_subsys
>>  	_nvmet_passthru_target_cleanup
>> diff --git a/tests/nvme/035 b/tests/nvme/035
>> index ff217d6..6ad9c56 100755
>> --- a/tests/nvme/035
>> +++ b/tests/nvme/035
>> @@ -30,13 +30,13 @@ test_device() {
>>  
>>  	_setup_nvmet
>>  
>> -	local ctrldev
> 
> Good catch :)
> 
>>  	local nsdev
>>  
>>  	_nvmet_passthru_target_setup
>>  	nsdev=$(_nvmet_passthru_target_connect)
>> -
>> -	if ! _xfs_run_fio_verify_io "${nsdev}" "${NVME_IMG_SIZE}"; then
>> +	if [[ -z "$nsdev" ]]; then
>> +		echo "FAIL"
>> +	elif ! _xfs_run_fio_verify_io "${nsdev}" "${NVME_IMG_SIZE}"; then
>>  		echo "FAIL: fio verify failed"
>>  	fi
>>  
>> diff --git a/tests/nvme/036 b/tests/nvme/036
>> index 442ffe7..a67ca12 100755
>> --- a/tests/nvme/036
>> +++ b/tests/nvme/036
>> @@ -30,13 +30,15 @@ test_device() {
> 
> This could be a good chance to add "local nsdev".
Yeah will do.
> 
>>  
>>  	_nvmet_passthru_target_setup
>>  	nsdev=$(_nvmet_passthru_target_connect)
>> -
>> -	ctrldev=$(_find_nvme_dev "${def_subsysnqn}")
>> -
>> -	if ! nvme reset "/dev/${ctrldev}" >> "$FULL" 2>&1; then
>> -		echo "ERROR: reset failed"
>> +	if [[ -z "$nsdev" ]]; then
>> +		echo "FAIL"
>> +	else
>> +		ctrldev=$(_find_nvme_dev "${def_subsysnqn}")
>> +
>> +		if ! nvme reset "/dev/${ctrldev}" >> "$FULL" 2>&1; then
>> +			echo "ERROR: reset failed"
>> +		fi
>>  	fi
>> -
> 
> Nit: unnecessary change here.
Okay, will remove this.
> 
>>  	_nvme_disconnect_subsys
>>  	_nvmet_passthru_target_cleanup
>>  
>> diff --git a/tests/nvme/037 b/tests/nvme/037
>> index f7ddc2d..f0c8a77 100755
>> --- a/tests/nvme/037
>> +++ b/tests/nvme/037
>> @@ -27,7 +27,6 @@ test_device() {
>>  
>>  	local subsys="blktests-subsystem-"
>>  	local iterations=10
>> -	local ctrldev
> 
> Good catch. And we can add "local nsdev" here.
yes will do.
> 
>>  
>>  	for ((i = 0; i < iterations; i++)); do
>>  		_nvmet_passthru_target_setup --subsysnqn "${subsys}${i}"
>> @@ -37,6 +36,11 @@ test_device() {
>>  		_nvme_disconnect_subsys \
>>  			--subsysnqn "${subsys}${i}" >>"${FULL}" 2>&1
>>  		_nvmet_passthru_target_cleanup --subsysnqn "${subsys}${i}"
>> +
>> +		if [[ -z "$nsdev" ]]; then
>> +			echo "FAIL"
>> +			break
>> +		fi
>>  	done
>>  
>>  	echo "Test complete"
>> diff --git a/tests/nvme/rc b/tests/nvme/rc
>> index a877de3..3def0d0 100644
>> --- a/tests/nvme/rc
>> +++ b/tests/nvme/rc
>> @@ -394,6 +394,7 @@ _nvmet_passthru_target_setup() {
>>  
>>  _nvmet_passthru_target_connect() {
>>  	local subsysnqn="$def_subsysnqn"
>> +	local timeout="5"
>>  
>>  	while [[ $# -gt 0 ]]; do
>>  		case $1 in
>> @@ -414,9 +415,18 @@ _nvmet_passthru_target_connect() {
>>  	# The following tests can race with the creation
>>  	# of the device so ensure the block device exists
>>  	# before continuing
>> -	while [ ! -b "${nsdev}" ]; do sleep 1; done
>> +	start_time=$(date +%s)
>> +	while [ ! -b "${nsdev}" ]; do
>> +		sleep .1
> 
> Is there any reason to have 0.1 second wait duration? When I changed this to
> "sleep 1", runtime of the test cases did not change on my test system.
> 
yes you're right there won't be any noticeable change in the runtime of 
the test unless we run this test in a loop for multiple number of times.
I would say that the gain would be only a fraction of a second in this case.
So I will use sleep 1 instead of .1 as you suggested.

>> +		end_time=$(date +%s)
>> +		if ((end_time - start_time > timeout)); then
>> +			echo ""
> 
> This echo doesn't look required.
> 
>> +			return 1
>> +		fi
> 
> If 1 second wait is okay instead of 0.1 second wait, the if block above can be
> a bit simpler, like,
> 
>               if ((++count >= timeout)); then
>                       return 1
>               fi
> 
> where, "local count=0" should be declared before.
> 
yeah with sleep 1 we can make it simple. I will update this in next patch.

>> +	done
>>  
>>  	echo "${nsdev}"
>> +	return 0
> 
> This "return 0" looks redundant. The previous echo succeeds always, then 0 is
> returned anyway. Also, all of the callers check the failure of this function by
> referring to the nsdev string echoed. They do not refer to the return code. So,
> it is not so useful to explicitly show that 0 is returned on success.
> 
yes I will incorporate it in the next patch.

Thanks,
--Nilay

