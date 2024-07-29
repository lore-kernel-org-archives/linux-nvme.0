Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85380C3DA4A
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jul 2024 04:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g1XBxAnvX54KuX1ZU3/mQt3QejHHysI6hnueTU9/mTs=; b=1rh6X+O5Jwr6RsFTxY3HHNGLV3
	PsmhZcRRtJmc8Cl6UjSSPr7/02ljvx6w/DyDP1jSQnxA8ak6SeV87/kpp7ITy+MO/ICzLBPgp0j4l
	/6ttU1gpnD/g8be4Zohg/UPkeKeRje7/6zQkn8kH6FRoYvS7b3mFDaXjhlH/l+Xq9/RDsza1ZYjdg
	NkDg0ZurOWnghvgOBWoNRaMOaCAzxYOEuGSebLiM0MeOPUDQEp1GZ/xZ7vG+gm/qkYeiGQnSGd+e2
	uZJv868jCWRoKFZTcWS/GhvnYcOKuf2kckD8IbBb3QJv1HMCPh85/2ajvgfCfpTxvBDWgApouNg3y
	6ROj+2RA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYILn-0000000A07S-10Ro;
	Mon, 29 Jul 2024 04:51:11 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYILg-0000000A06n-2vTc
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jul 2024 04:51:09 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46T2tUB1007133;
	Mon, 29 Jul 2024 04:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=g
	1XBxAnvX54KuX1ZU3/mQt3QejHHysI6hnueTU9/mTs=; b=FvOR6ufJBPviUIVl5
	EWS4EIsLkZXwOI2nriBVIaT3kXwF+9dM8IUjnQ8lsyNE0kWMsmBdj3YjPKG8NS06
	mvubb1Zl+RpSqBYMFB7fHhclSTm+bA490S5ycFzMb0qVwzOzjmvitMghp+9umbsg
	9v94c88MZ8FtSwN6gqqsLBh/TnPGkvc9M42XjUu0ZT1LTZ+sa2mKCXvLoUPaGmWZ
	govCmXCx6wRfR1UKZKT1ADf6rhV7g2iHl9gfQbKH802VTJOLOoKswUfXjNbb9Y/F
	arJX8Nod8nqvVdKbqCdO65iBubwOBdcCY3BWgvITSWTAae6SwI6FFzAtjrtN++Td
	27Rew==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40mwdn37r2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 04:50:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46T2lbVA011133;
	Mon, 29 Jul 2024 04:50:51 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40ncqmcrkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 04:50:51 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46T4onkx64880948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 04:50:51 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48B8E5805A;
	Mon, 29 Jul 2024 04:50:49 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A0545805F;
	Mon, 29 Jul 2024 04:50:47 +0000 (GMT)
Received: from [9.109.198.216] (unknown [9.109.198.216])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Jul 2024 04:50:46 +0000 (GMT)
Message-ID: <14377a5b-c83d-405a-bcec-6932dfdc99b9@linux.ibm.com>
Date: Mon, 29 Jul 2024 10:20:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/1] Add visibility for native NVMe miltipath using
 debugfs
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, axboe@fb.com, gjoyce@linux.ibm.com
References: <20240722093124.42581-1-nilay@linux.ibm.com>
 <ed89f058-93e8-40b7-936f-b5ee83c70bf8@grimberg.me>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ed89f058-93e8-40b7-936f-b5ee83c70bf8@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tlXuO0l5kwagbRR14sxdW_-IsI8iTCTm
X-Proofpoint-GUID: tlXuO0l5kwagbRR14sxdW_-IsI8iTCTm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_02,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407290025
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240728_215105_107963_B17104F0 
X-CRM114-Status: GOOD (  15.19  )
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



On 7/29/24 02:17, Sagi Grimberg wrote:
> 
>> # cat /sys/kernel/debug/block/nvme2n2/multipath
>> io-policy: numa
>> io-path:
>> --------
>> node  current-path  ctrl    ana-state
>> 2     nvme2c2n2     nvme2   optimized
>> 3     nvme2c0n2     nvme0   optimized
>>
>> The above output shows that current selected iopolicy is numa. And when we
>> have workload running I/O on numa node 2, accessing namespace "nvme2n2",
>> it uses path nvme2c2n2 and controller nvme2 for forwarding data. Moreover
>> the current ana-state for this path is optimized. Similarly, for I/O
>> workload running on numa node 3 would use path nvme2c0n2 and controller
>> nvme0.
>>
>> Now changing the iopolicy to round-robin,
>>
>> # echo "round-robin" > /sys/class/nvme-subsystem/nvme-subsys2/iopolicy
>>
>> # cat /sys/kernel/debug/block/nvme2n2/multipath
>> io-policy: round-robin
>> io-path:
>> --------
>> node  rr-path       ctrl    ana-state
>> 2     nvme2c2n2     nvme2   optimized
>> 2     nvme2c0n2     nvme0   optimized
>> 3     nvme2c2n2     nvme2   optimized
>> 3     nvme2c0n2     nvme0   optimized
> 
> Can we avoid a formatted output in sysfs? I'd much rather prefer that nvme-cli/libnvme to
> format this (maybe this may be wanted as json in the future for example)...
> 
> Can we simply expose the individual components and have userpace format the output?

Yes that's what I am planning to implement. The sysfs would only expose the relevant 
information from NVMe driver  and then libnvme/nvme-cli format the sysfs output as needed.

Thanks,
--Nilay

