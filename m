Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3D1C3DA5D
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jul 2024 06:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WIzjbZgZWfIvcmK4gs4AZ5lEXxWLXMNnJPY+J3noUro=; b=AeGQYmvIycD1c+gw/5NG7y5mJb
	EYqHrTV/bVgUm2XqEkr3M+JdAkkcTkGyap7k/tVE8gDCJUX3u7RVnBKJ5wgtBsidPSdmMh8OT0TWd
	ozbRMms+925918T1ZHiEQI2aGmVS02c8RKLq4UaEQdLf4wBg/IZjU8DLGmGDjgecKREXvNR1Usc9R
	ONrEZBeZdnQghLIulAH+1l1Qe/wRJFZlAEBb26WcbSbxXfG/AhA7OKEFLFLxJKatKQJcfCB6/z2ms
	YtJomQCTiblM2+YZ2d/atK2WrBdPTVknMOqP5CgB1qUZpTUj+AGYqHn2iT/WmEPUg7XvIdzSpdIgS
	CknbWLbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWrw7-000000001Fl-3XYd;
	Thu, 25 Jul 2024 06:26:47 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWrw4-000000001Ec-3Hus
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jul 2024 06:26:46 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46P5SIlu030404;
	Thu, 25 Jul 2024 06:26:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=W
	IzjbZgZWfIvcmK4gs4AZ5lEXxWLXMNnJPY+J3noUro=; b=XwBa8XYQZOYWrngwX
	ZMafR55gb1tx+OgbEpFhdM0vhK0mxCUzsDd3fe9at4eRC+AS9xoyBNlHwfwJo9+c
	xoWDnDPwEmtwkn0HkRawt3X6G4nrr9Pu3E7Ar6qtPY0JNT9nCFB6S0eFb0kKZZoC
	Qqvxn4kymEDk/yvDUmtoWLrj6oZrM7ol/SCD/Op/gPFpEgIE6VhxOANHy/jm1ox/
	TxgyhcJ81y/KFXjaBmzPM4pjonwl5UQALKxX3kxeiDa/7Eah6H8fSsS493kbZK+T
	ibTiNSJb0R4j9xKGSxYG1yUlrqJHtgmvOwTgJXZ6jCDN07TPWqiBwaNXnn49/oLe
	bgmoA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40kgk8r38r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 06:26:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46P4G9Ya006227;
	Thu, 25 Jul 2024 06:23:35 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40gqjunrx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 06:23:35 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46P6NWuM24052316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jul 2024 06:23:34 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33DB258057;
	Thu, 25 Jul 2024 06:23:32 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7D1A58059;
	Thu, 25 Jul 2024 06:23:29 +0000 (GMT)
Received: from [9.109.198.186] (unknown [9.109.198.186])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Jul 2024 06:23:29 +0000 (GMT)
Message-ID: <b24ac7d2-d5ea-4e5a-b59a-099ce4c48929@linux.ibm.com>
Date: Thu, 25 Jul 2024 11:53:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/1] Add visibility for native NVMe miltipath using
 debugfs
To: Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, gjoyce@linux.ibm.com
References: <20240722093124.42581-1-nilay@linux.ibm.com>
 <5nwflcpqoyknrruzdlvgnt5bpcoxh6nrirjwnjes4oazkr7nai@uwsynbuduibr>
 <831af264-7f8a-495e-99b0-51f294e0948f@linux.ibm.com>
 <dpwafli2lwjlita6pcxwg5ilvxbqm4c4tckjcawhzzwfqywpow@o47xxyrwcmmw>
 <20240724134152.GB12516@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20240724134152.GB12516@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FC_aDlrUDEtvqukRnKmTLfdvRI2Degat
X-Proofpoint-ORIG-GUID: FC_aDlrUDEtvqukRnKmTLfdvRI2Degat
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_05,2024-07-25_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=640 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407250038
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240724_232644_876087_6D87E241 
X-CRM114-Status: GOOD (  15.16  )
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



On 7/24/24 19:11, Christoph Hellwig wrote:
> On Tue, Jul 23, 2024 at 09:40:55AM +0200, Daniel Wagner wrote:
>> debugfs might always be available. IIRC when lockdown is enabled, debugfs
>> is not available or parts of it.
>>
>> I'd suggest going the full way and add expose the relevant information
>> via sysfs and extend libnvme and nvme-cli. But this just my take on this.
> 
> Yes, if we want to do this properly sysfs is the place to go, not
> debugfs.
> 
Alright, I will send out another patch with relevant changes for
sysfs and then latter in libnvme/nvme-cli.

Thanks,
--Nilay

