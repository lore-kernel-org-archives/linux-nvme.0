Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95890C27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jun 2024 17:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NqVqmZf7o66qtFALGxyAkq1hY04A7knwb9qvzNapXoE=; b=llW3KlVqMWgW00l6c+9xD+PrlY
	pgRUCOB+tmpaxWqWVzlHHfWn2C8DwsSiOyqWwDlQ9HlYgSOXu93q+qvNJqyShxIbr4J0Wvbc/3KbN
	zeaXtS7dihrpUcQphhwXshTykHDAULmYrAbggFn8waDW3YMF9o7NNglQKrYVvIrsGqKpp/i4NTCmo
	DDO8v8Je4O5PMz8f7CfkjrGi/DodBSGOLcGxL7gU5Vs4e1XhFahYfeobbnMC7QoaANf9vi3t871U5
	vVmbJD3AhYRPElnEhpB+07VtBQ10GW3i1GJGpJpYd2hBuSjIOdzsrGfRPZWUoekEp1ABdMvtK2dKk
	PWiRZ+RA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJz4w-00000002Cng-0eoc;
	Wed, 19 Jun 2024 17:26:38 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJz4s-00000002ClK-0jgs
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jun 2024 17:26:36 +0000
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JHQUaf032764;
	Wed, 19 Jun 2024 17:26:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=N
	qVqmZf7o66qtFALGxyAkq1hY04A7knwb9qvzNapXoE=; b=CmpNnMd4K4Vq1JkUg
	hoTihyCa3sI8slIGglYBRyvrff/XT6DpmaDGKrbgdFcGdjLLxeTB0fI5v7hzn3zz
	VIuDa01lja0nGmnUe+F2Qjm1F3sPPyYwFUIWLZjQHHmwnAdMqEB6XN5CJ0y4cBBt
	ActL7PITGadpnIx/gGjI7PE+K/kL3CKhMKk10aAQ6zNtm5z0HAKSyr/7o0HR1KHt
	EYvZjty9DYqrWKKDEKqUiOmhO4E/jsclfDoWC7tHFjEMEYjKksLiGWx3Htvqmnpa
	bVQGs0NhE0msZxmN3+jms8jgHPDUJGamKZYm1cV90UauHOmNMmQ4VgRq926+VxWG
	r1M+g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yv20ggaxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 17:26:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45JG64C4013477;
	Wed, 19 Jun 2024 17:22:00 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysr03xd0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 17:22:00 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45JHLvUq44892754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 17:21:59 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C66758054;
	Wed, 19 Jun 2024 17:21:57 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB37258055;
	Wed, 19 Jun 2024 17:21:52 +0000 (GMT)
Received: from [9.43.26.82] (unknown [9.43.26.82])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Jun 2024 17:21:52 +0000 (GMT)
Message-ID: <9797ab67-e7d1-4624-87bc-9d7cd8406089@linux.ibm.com>
Date: Wed, 19 Jun 2024 22:51:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 blktests] nvme: add test for creating/deleting file-ns
To: Daniel Wagner <dwagner@suse.de>
Cc: shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com, kbusch@kernel.org,
        sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org,
        venkat88@linux.vnet.ibm.com, sachinp@linux.vnet.ibm.com,
        linux-block@vger.kernel.org, gjoyce@linux.ibm.com
References: <20240619104705.2921801-1-nilay@linux.ibm.com>
 <b4itgwyvsk6xhlgccleshe2v5dmyqwh2tkualueotqdz3ljxef@lfrrwqcofuuf>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <b4itgwyvsk6xhlgccleshe2v5dmyqwh2tkualueotqdz3ljxef@lfrrwqcofuuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eaxO1vH_6SyibgYyMRyW6IMSzj7bGt4W
X-Proofpoint-GUID: eaxO1vH_6SyibgYyMRyW6IMSzj7bGt4W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 suspectscore=0 mlxlogscore=888 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406190131
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_102634_643282_6AE8D4E0 
X-CRM114-Status: GOOD (  14.67  )
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



On 6/19/24 16:29, Daniel Wagner wrote:
> On Wed, Jun 19, 2024 at 04:16:40PM GMT, Nilay Shroff wrote:
>> +	# start iteration from ns-id 2 because ns-id 1 is created
>> +	# by default when nvme target is setup. Also ns-id 1 is
>> +	# deleted when nvme target is cleaned up.
>> +	for ((i = 2; i <= iterations; i++)); do {
>> +		truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path).$i"
>> +		_create_nvmet_ns "${def_subsysnqn}" "${i}" "$(_nvme_def_file_path).$i"
>> +
>> +		# allow async request to be processed
>> +		sleep 1
> 
> This looks a bit fragile to ensure all request have been processed. Would
> it possible to wait on a state?  E.g. something like
> 
>   nvmf_wait_for_state()
> 
> ?
OK that's a good idea! I think it's possible to wait using _find_nvme_ns() instead 
of using sleep here. We can write a wrapper around _find_nvme_ns() and wait until 
namespace is ready/created.

I will send next patch with the above change. 
> 
>> +
>> +		_remove_nvmet_ns "${def_subsysnqn}" "${i}"
>> +		rm "$(_nvme_def_file_path).$i"
>> +	}
> 

Thanks,
--Nilay

