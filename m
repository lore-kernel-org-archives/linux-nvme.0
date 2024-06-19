Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF91DC27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jun 2024 10:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qioqf/KSNvBoKmz5a81KS4KivkoGRWFgAHkeLB1D67w=; b=sUhiY67HaGPhnuVOcQ1ml2um3H
	9CXmmHMMZFseXYFqfmzAxSqPUYUTfqqgWKOTed7dDk18/ivMOwHPsGQSWXbvc3843xObMZ64fXz84
	QJmnc7CvCqwrKq4lOxpOoOttWq2Xump6bvs3Kn4BPjjMW6VVnMxtludaRfEL+MBZTpSkeN6cXmRkh
	9sEGSjvlsvqGjfjVHKq7YplQcXVS9DPueItL1c7T54KqQUw7XnuoiZDBUSkKvLWXqbj/+Rv+9/1fu
	IHd3s6kDTjdiIF9ihsV5uZo0MDdEEGVC2aOkTWqcFphA7mnwz+Go+A7Vh5deuHbPMlbM8uVD5av3j
	ixg7c+Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJsEa-00000000iZ9-3TV4;
	Wed, 19 Jun 2024 10:08:08 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJsEX-00000000iYb-2mkU
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jun 2024 10:08:07 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J8tv80013711;
	Wed, 19 Jun 2024 10:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=q
	ioqf/KSNvBoKmz5a81KS4KivkoGRWFgAHkeLB1D67w=; b=h+ZznwQgr9gms7rAH
	xE9sw3j06EGTAm5PD1LJXQBq5UVp5+MzxH1jsAEWcIejungtTQyYjhFJmhz1dIJt
	xqbxaeGMEe9c0t8oRRdqxVnZbhqS/o2s7bwb8AxhHiwGYteaRBmb50yL2kiC9A0a
	nlwuOtN0Z0ub+v79Pki4EGVvklf2QbD8RdwkQTBuLHmDpOjs6rY/NMt3ihnwdxYw
	gYARsvjZbsJDvFN5swc4FJYoZlVk0OSj2jcz1kXtVBXjfziNaUv9otyTPlFvPktw
	4N4BUExQ2T/pPAy5yvt/xsGA+8mWru07S1197rpxsNA+PqC6aSB1HbYx6MEAH4uN
	DaUTg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yusnarjdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 10:08:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45J92t4q013389;
	Wed, 19 Jun 2024 10:07:59 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysr03tvbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 10:07:59 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45JA7ui239977218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 10:07:59 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C284E58058;
	Wed, 19 Jun 2024 10:07:56 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C8E05805B;
	Wed, 19 Jun 2024 10:07:52 +0000 (GMT)
Received: from [9.43.48.107] (unknown [9.43.48.107])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Jun 2024 10:07:51 +0000 (GMT)
Message-ID: <fd0fab41-e7b0-4a41-8ac0-8c482aa92537@linux.ibm.com>
Date: Wed, 19 Jun 2024 15:37:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] loop: add test for creating/deleting file-ns
To: Daniel Wagner <dwagner@suse.de>
Cc: shinichiro.kawasaki@wdc.com, kbusch@kernel.org, sagi@grimberg.me,
        hch@lst.de, linux-nvme@lists.infradead.org, chaitanyak@nvidia.com,
        venkat88@linux.vnet.ibm.com, sachinp@linux.vnet.com,
        linux-block@vger.kernel.org, gjoyce@linux.ibm.com
References: <20240617092035.2755785-1-nilay@linux.ibm.com>
 <gpatyu3gqzfswxishsa7juix2z2upmbrkec7n57pbgfzw56jla@lyjvwhv5dvc6>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <gpatyu3gqzfswxishsa7juix2z2upmbrkec7n57pbgfzw56jla@lyjvwhv5dvc6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q_j6pTffEguM3cUiw44qVg8TdVMBwDD_
X-Proofpoint-GUID: Q_j6pTffEguM3cUiw44qVg8TdVMBwDD_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=859 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190073
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_030805_750511_AB5C8A8F 
X-CRM114-Status: GOOD (  13.97  )
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



On 6/19/24 13:20, Daniel Wagner wrote:
> On Mon, Jun 17, 2024 at 02:47:22PM GMT, Nilay Shroff wrote:
>> +test() {
>> +	echo "Running ${TEST_NAME}"
>> +
>> +	_setup_nvmet
>> +
>> +	local subsys="blktests-subsystem-1"
> 
> Use the default variables instead of duplicating them.
Yes that makes sense.
> 
>> +	local iterations="${NVME_NUM_ITER}"
>> +	local loop_dev
>> +	local port
>> +
>> +	truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path)"
>> +
>> +	loop_dev="$(losetup -f --show "$(_nvme_def_file_path)")"
>> +
>> +	port="$(_create_nvmet_port "${nvme_trtype}")"
>> +
>> +	_nvmet_target_setup --subsysnqn "${subsys}" --blkdev "${loop_dev}"
>> +
>> +	_nvme_connect_subsys --subsysnqn "${subsys}"
> 
> As far I can tell this could just be:
> 
> 	_nvmet_target_setup
> 
> 	_nvme_connect_subsys
> 
I updated test case using default subsysnqn and blkdev that works as expected. 
So yes I can use defaults for setting up and then connecting to nvme target.

I will update this in next patch.

Appreciate your review and suggestion... 

Thanks,
--Nilay

