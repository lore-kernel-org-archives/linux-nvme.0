Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66761C02181
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2025 07:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6bDRD4iqBPY6EM+ZVnPl6jsSqQDP4+pIjP7B3uCrx18=; b=a0mdeAwoIhj9UaFDXMdCiEJkLu
	sQqhrl6Q8K+hb25F6kdk5AwJZzS5wYvPyqeYiqLCzRsYOd6yYFqUyu1UMV1tidvNzOGlbQSCSBFQ0
	bqFRtABc1mXHBFb/fr1p8OYE6kYoaahghnzoxOzQF/cgNb4i3/SCsGDxWlJ4oyEYXFVhqrlgstZ5F
	w3erF1qJdlYoIBvywaYnx9nAMw/O2N3DYb7/DoWunBFGaot6N4ATgIvUq+S6cwanAZ2Xdx9gCpPrv
	87D1YM5uAsQ9TwwIqkdY1dXCiU7nm5oJaZRxG1whJoFiU+l15mfCZpv84jhNh7el1Alb9hC4z2l0F
	EHKTXbuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbEHE-0000000E9N8-1C8s;
	Fri, 24 Jan 2025 07:38:52 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbEAS-0000000E7eZ-3IDJ
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jan 2025 07:31:54 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O213wQ008543;
	Fri, 24 Jan 2025 07:31:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6bDRD4
	iqBPY6EM+ZVnPl6jsSqQDP4+pIjP7B3uCrx18=; b=Rg6FcpG6E/cprEfs67kGWw
	ugNGDT5rWKWVAXwvODSG1Zf2cfYqWaiDBU3Kqa8Usm8Cu4pM7JcpEDKJuos3EQPv
	YzzW1E8NodHJYJr4JUwng1oGp6sWQ3R7y3IQilz2JdAaabL6vs/jfbsi7kxsXqwp
	3JUWd3EMoOV9GykhcLFk8nHD74YACcgoREAron8nyN2tRAnyW4R3Wbzpg6oQJXsp
	si6sV55qqUI4ab49h/X+73lRjZQvmL+iE3CpAZxQfXiyI7CfPfCIea3szhKHvfGh
	VBvItD+0HBwLdYcLB8OMMBy7SPQiFkkkbqwNe84IrZ/wU79EpvSTgLkUd3iDxSXg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44c1pyt65k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 07:31:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50O5hjXi032266;
	Fri, 24 Jan 2025 07:31:49 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 448ruk1ybx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 07:31:49 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50O7VnII25100886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 07:31:49 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 058C158056;
	Fri, 24 Jan 2025 07:31:49 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A76AE5803F;
	Fri, 24 Jan 2025 07:31:47 +0000 (GMT)
Received: from [9.171.53.174] (unknown [9.171.53.174])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jan 2025 07:31:47 +0000 (GMT)
Message-ID: <5ff778f7-3474-47e3-a4b0-ca1fb263b7c1@linux.ibm.com>
Date: Fri, 24 Jan 2025 13:01:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] nvme/058: detach loop device after test finish
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hare@suse.de" <hare@suse.de>, "gjoyce@ibm.com" <gjoyce@ibm.com>
References: <20250116132231.349917-1-nilay@linux.ibm.com>
 <vml6hqld7aqvpahyzgkt5syipzs64ncqzdr7imnbseqgkdcxn3@nyzraplwk6vx>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <vml6hqld7aqvpahyzgkt5syipzs64ncqzdr7imnbseqgkdcxn3@nyzraplwk6vx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: e6fKv50GTv3pVvY63wPguZqqvn2S0yAO
X-Proofpoint-GUID: e6fKv50GTv3pVvY63wPguZqqvn2S0yAO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_03,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240053
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250123_233152_959606_2D23D729 
X-CRM114-Status: GOOD (  24.87  )
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



On 1/23/25 10:23 AM, Shinichiro Kawasaki wrote:
> On Jan 16, 2025 / 18:52, Nilay Shroff wrote:
>> The nvme/058 creates three (temp file backed) namespaces and
>> attach each namespace to a loop device while starting the test.
>> However it never detach those namespaces from the loop device
>> once test finishes. Ideally, we should detach loop device from
>> namespace so that the associated loop device is later destroyed
>> and its resources are released. This patch helps detach each
>> namespace from its associated loop device after test finishes.
> 
> Thank you for catching this issue. This needs a fix.
> 
Thank you for your review and comments!
>>
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>  tests/nvme/058 | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/tests/nvme/058 b/tests/nvme/058
>> index d230a21..99e7e81 100755
>> --- a/tests/nvme/058
>> +++ b/tests/nvme/058
>> @@ -99,6 +99,17 @@ test() {
>>  	done
>>  
>>  	_nvme_disconnect_subsys
>> +
>> +	for ((d = 1; d <= num_namespaces; d++)); do
>> +		local file_path
>> +		local blkdev
>> +
>> +		file_path="${TMPDIR}/img${d}"
>> +		blkdev="$(losetup -l | awk -v path="${file_path}" '$6 == path { print $1 }')"
>> +
>> +		losetup -d "${blkdev}"
>> +	done
> 
> This for loop looks similar and redundant with the other for loop to set up the
> namespaces. How about to keep the blkdevs in an array, and refer to them to
> detach? The pseudo code below shows this approach:
> 
>  local blkdev
>  local -a blkdevs
>   ...
>  (in the 1st loop)
>     ...
>     blkdevs+=$("$blkdev")
>     ...
> 
>   ...
>   (after _nvme_disconnect_subsys)
> 
>   for blkdev in "${blkdevs[@]}"; do
>       losetup --detach "$blkdev"
>   done
>   ...
> 
Yes this looks good! I will incorporate this in the next patch.
> 
> Also I suggest to use long option names instead of short names for readability
> and code stability: e.g., instead of "losetup -d", let's use "losetup --detach".
> (No need to replace short option names in existing code. I'm suggesting this for
> the new lines to add.)
> 
Sure, will do the needful.

Thanks,
--Nilay

