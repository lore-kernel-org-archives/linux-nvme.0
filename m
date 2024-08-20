Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 140CCC3DA4A
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Aug 2024 16:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6gSIYou9i+bKLPD08y2b43EPjjY0mXv1hPTGGbm6Xv4=; b=frGQ5iQVkU4A7TuPFyxtiMIPm8
	crGH6X35IZSts3Z1PD4gj3xIH75DA1j1s3Hjtx3gYjL0NyUMDlvW2cgiB4I86NJegj4FoSMC47AFZ
	2tp6sVewi3UcogvaPjdCuEtpyJKXUFYnXU5A5qv3fZflG2IdlnGy8LEOnHAiTtJeqzbMAaKRuEFhU
	Xoc+q0A904bTfjz37jpSmkzZFHeNHdknkKdAccDNQHwcD+rgOBRZc5oKsob9IJ8+jKWTgrLwNfi3o
	jT7F3v7J++eDnx4dr03Xu/33nL3VAjOmoDDxzgYwaUceEO8Y5RSHdRr0w8GZGDm0rxPgGN7RPxYLq
	6ruRZpeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgS99-000000065IE-0SaI;
	Tue, 20 Aug 2024 16:55:51 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgS94-000000065Hh-3ZpJ
	for linux-nvme@lists.infradead.org;
	Tue, 20 Aug 2024 16:55:49 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KDnjjn017487;
	Tue, 20 Aug 2024 16:55:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	6gSIYou9i+bKLPD08y2b43EPjjY0mXv1hPTGGbm6Xv4=; b=Mm51/+Wiwo80nXLV
	GnwR1qZovbnN4dOpX+1dKJlj5yfCflz9aoFx/EV4Gmi/yaOYOc1d4h/Kbvsqp378
	hXSFejRdTwfWgm0Ah3KzwofmtMFrAMVA+qO717sL/khLY0QM20FCMwS2f2eL3TWU
	aG5g+7Cx0ie2nDoXS4eTFyfVgAUDC8NZix2XbwOVFnlbRWNC04Zyqi6GJY/ZU6EQ
	b8+8ej153OKfzhPp/PN7oPFwYbs26YJNhPajy5BmVKn4LBXywq0LOxmgD9dXtvYW
	zAlj3lA1USOw7Bcy6a1L52/vnv95xZst1s0uwCqNfKhyCO0teUgTabowq8W1Hvcu
	e59gVw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412ma06tfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 16:55:44 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47KGtSGY002897;
	Tue, 20 Aug 2024 16:55:44 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412ma06tfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 16:55:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47KEUEdk002211;
	Tue, 20 Aug 2024 16:55:42 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4136k0kw3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 16:55:42 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47KGtdSN14942718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 16:55:42 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF9DA58058;
	Tue, 20 Aug 2024 16:55:39 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42B345805B;
	Tue, 20 Aug 2024 16:55:38 +0000 (GMT)
Received: from [9.171.27.8] (unknown [9.171.27.8])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Aug 2024 16:55:37 +0000 (GMT)
Message-ID: <d22e0c6f-0451-4299-970f-602458b6556d@linux.ibm.com>
Date: Tue, 20 Aug 2024 22:25:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] nvme/052: wait for namespace removal before
 recreating namespace
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>
References: <20240820102013.781794-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20240820102013.781794-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: I3ks5ew2yLW6TBvfTh-gip3WijqRXWUJ
X-Proofpoint-ORIG-GUID: pEo2KdDR6eyphNjUYynEWiPAAKk41Dvg
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_12,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408200123
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240820_095547_157941_0958E9E1 
X-CRM114-Status: GOOD (  31.28  )
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



On 8/20/24 15:50, Shin'ichiro Kawasaki wrote:
> The CKI project reported that the test case nvme/052 fails occasionally
> with the errors below:
> 
>   nvme/052 (tr=loop) (Test file-ns creation/deletion under one subsystem) [failed]
>       runtime    ...  22.209s
>       --- tests/nvme/052.out    2024-07-30 18:38:29.041716566 -0400
>       +++
> +/mnt/tests/gitlab.com/redhat/centos-stream/tests/kernel/kernel-tests/-/archive/production/kernel-t\
> ests-production.zip/storage/blktests/nvme/nvme-loop/blktests
> +/results/nodev_tr_loop/nvme/052.out.bad        2024-07-30 18:45:35.438067452 -0400
>       @@ -1,2 +1,4 @@
>        Running nvme/052
>       +cat: /sys/block/nvme1n2/uuid: No such file or directory
>       +cat: /sys/block/nvme1n2/uuid: No such file or directory
>        Test complete
> 
> The test case repeats creating and removing namespaces. When the test
> case removes the namespace by echoing 0 to the sysfs enable file, this
> echo write does not wait for the completion of the namespace removal.
> Before the removal completes, the test case recreates the namespace.
> At this point, the sysfs uuid file for the old namespace still exists.
> The test case misunderstands that the the sysfs uuid file would be for
> the recreated namespace, and tries to read it. However, the removal
> process for the old namespace deletes the sysfs uuid file at this point.
> Then the read attempt fails and results in the errors.
> 
> To avoid the failure, wait for the namespace removal before recreating
> the namespace. For this purpose, add the new helper function
> nvmf_wait_for_ns_removal(). To specify the namespace to wait for, get
> the name of the namespace from nvmf_wait_for_ns(), and pass it to
> nvmf_wait_for_ns_removal().
> 
> The test case intends to catch the regression fixed by the kernel commit
> ff0ffe5b7c3c ("nvme: fix namespace removal list"). I reverted the commit
> from the kernel v6.11-rc4, then confirmed that the test case still can
> catch the regression with this change.
> 
> Link: https://lore.kernel.org/linux-block/tczctp5tkr34o3k3f4dlyhuutgp2ycex6gdbjuqx4trn6ewm2i@qbkza3yr5wdd/
> Fixes: 077211a0e9ff ("nvme: add test for creating/deleting file-ns")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
> Nelay, Yi, thank you for the feedbacks for the discussion
> thread at the Link. Here's the formal fix patch.
> 
>  tests/nvme/052 | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/nvme/052 b/tests/nvme/052
> index cf6061a..e1ac823 100755
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
> +		echo "Failed to remove the namespace $ns"
> +	fi
> +}
> +
Under nvmf_wait_for_ns_removal(), instead of checking the existence of "/dev/$ns", 
how about checking the existence of file "/sys/block/$ns"? As we know, when this issue 
manifests, we have a stale entry "/sys/block/$ns/$uuid" lurking around from the 
previous iteration for sometime causing the observed symptom. So I think, we may reuse the 
_find_nvme_ns() function to wait until the stale "/sys/block/$ns/$uuid" file 
exists. Maybe something like below:

nvmf_wait_for_ns_removal() {
        local ns
        local timeout="5"
        local uuid="$1"

        ns=$(_find_nvme_ns "${uuid}")

        start_time=$(date +%s)
        while [[ ! -z "$ns" ]]; do
                sleep 1
                end_time=$(date +%s)
                if (( end_time - start_time > timeout )); then
                        echo "namespace with uuid \"${uuid}\" still " \
                                "not deleted within ${timeout} seconds"
                        return 1
                fi
		echo "Waiting for $ns removal" >> ${FULL}
                ns=$(_find_nvme_ns "${uuid}")
				
        done

        return 0
}

Thanks,
--Nilay


