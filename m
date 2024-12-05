Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930F9E77170
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Dec 2024 11:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ucImk//OQnArSj/v3rFzD3SUHRwXCgKQbKlozmPvBrQ=; b=m9q/20R32Z7o9hlXif39FI3W7t
	XPjk4je2+Zx1g1qvoQk1i6LynGvxyKTE3efLXl1FZUk3eDDvygS3UwpOFL01SiXXn+Bm+qYtkR/6z
	kfJglo3FssKfeU4P+JGLnpGtuB/hqGtSLmz4fsjKQqkJaQ1jbeZVZXbBbCzxbqPFJhC5XihlsYXs4
	/PoDn8BgzsbEqSy/TnB3zpS+JMCKRB1iHNUz9EwL/rIcs/nAMgSe8BQpA7EEgfIMgl4vDEERIomzk
	GnmURkeLLzublNS6D1MBaF2+jEhOXm9yG5YRcJsnvvhi7tnQfK7HJFJIMhUdWc+XLAV1JjKosowfL
	TnJns3+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJ9h7-0000000Fem1-30ER;
	Thu, 05 Dec 2024 11:06:53 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJ9h4-0000000FekF-3qTT
	for linux-nvme@lists.infradead.org;
	Thu, 05 Dec 2024 11:06:52 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5A0hfZ027888;
	Thu, 5 Dec 2024 11:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ucImk/
	/OQnArSj/v3rFzD3SUHRwXCgKQbKlozmPvBrQ=; b=Fn7dmzdHq9riCjsjUz3bDA
	fcrLwTz19UidXSVEGiLQqCSYWQKFgrJFp2KkaRSiCk+pULIoNMdhsEGTcVFB+8td
	8B49cgY2sFktYBcwn2vI1OzC84Jfla0HhA1Jco60z/bPhNHDcmUHniks3QyZzf/9
	49BRSutv8CX8U9+RAz9qDg3oJiyXNw3drumMgDcu23uvHvPRm5hY/H2AHicklavz
	CnM/B9o4elFMCZSdc+FiYZre8CGhMnzkbJllLkZI1ZNUjTQec1Upo6L67Bd1nAe6
	2NVQ59a/+0lIY8c2OKI+yGVeHjFBRjfbOb3lcMbbcfZPjgKkFIX8ctyRvaiLTAoQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ba1yga56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 11:06:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B59AP5b020500;
	Thu, 5 Dec 2024 11:06:31 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 438d1shn5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 11:06:31 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B5B6UYC26215072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Dec 2024 11:06:30 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72A2958068;
	Thu,  5 Dec 2024 11:06:30 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7815B58097;
	Thu,  5 Dec 2024 11:06:27 +0000 (GMT)
Received: from [9.109.198.241] (unknown [9.109.198.241])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Dec 2024 11:06:27 +0000 (GMT)
Message-ID: <fb1058c3-ca47-4a54-8c1b-7eb9fa449fa0@linux.ibm.com>
Date: Thu, 5 Dec 2024 16:36:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 blktests 2/2] nvme: add test for writing to file-ns just
 after disabling it
To: Daniel Wagner <dwagner@suse.de>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>
References: <20241204114755.190660-1-nilay@linux.ibm.com>
 <20241204114755.190660-3-nilay@linux.ibm.com>
 <5178056a-4297-43ca-b15b-dfb8d9b21857@nvidia.com>
 <62addb0a-d115-4b2d-af3c-cedc41991f7c@linux.ibm.com>
 <adbeb95d-40aa-44c3-bb63-01c0a49f5182@flourine.local>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <adbeb95d-40aa-44c3-bb63-01c0a49f5182@flourine.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Jb6jUhLv7K59drt9cH0kQOPXj0GdjMLn
X-Proofpoint-GUID: Jb6jUhLv7K59drt9cH0kQOPXj0GdjMLn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050074
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_030651_073011_739F1785 
X-CRM114-Status: GOOD (  24.33  )
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



On 12/5/24 16:17, Daniel Wagner wrote:
> On Thu, Dec 05, 2024 at 03:10:23PM +0530, Nilay Shroff wrote:
>>>> +	img="$(mktemp /tmp/blk_img_XXXXXX)"
>>>> +	dd if=/dev/urandom of="$img" bs=512 count=1 status=none
>>>
>>> why can't we just use the standard block device backed ns ?
>> Using standard block device would also work however using the file backed block 
>> device would be handy in case user doesn't have a spare standard block device 
>> available which could be used for writing a random junk to it.
> 
> If I understood Chaitanya correctly, he would prefer to use the existing
> helpers to setup the backend, either file or block. If so, I am also on
> board with this idea, not to hard code backend into the test. We have
> moved this into the helpers so that it's a test parameter.
> 
>> OK I think maybe there's a confusion, let me clarify one thing here: We're
>> *not* disabling AEN functionality but only masking the ns-changed async even 
>> notification from target and I believe that's perfectly legal per spec. I 
>> shall update the comment added in the test case to avoid this confusion. 
>>
>>> Can this be an exception for some reason ?
>>>
>>> Shinichiro, Daniel any thoughts ?
> 
> I haven't really checked what the spec says on this topic. Nilay, could
> you give a pointer, so I don't spend too much time trying to find the
> right spot in the spec. Thanks!
> 
Sure, you may refer "5.27.1.8 Asynchronous Event Configuration (Feature Identifier 0Bh)"
in NVMe base spec 2.0. And then refer Figure 236, Namespace Attribute Notices: 

>>> +unsigned int ns_disable_error_inject;
>>> +module_param(ns_disable_error_inject, int, 0644);
>>> +MODULE_PARM_DESC(ns_disable_error_inject,
>>> +                "delay xa_erase() in ns-disable path in seconds 
>>> (default 0)");
>>> +
> 
> Please no. This type of debugging/testing interface is hard to use IMO.
> It should be in one of the psydo FS, sysfs, configfs or debugfs if
> really needed.
> 
> Daniel
> 
Thanks,
--Nilay

