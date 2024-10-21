Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B54D15D83
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2024 12:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZD4icNi8/y4CTQxE8K3EtB3xkbWCjTrHIuccW88t7qQ=; b=4zqBWYMhx+gA4NHLAi7U11+E3D
	vXTdqpv0yBEOeCWWFdeM1bPasxhydZ9c6LtzxgFHlgh7JsqssMI6ueqREBzGFo/QduGgZhi72ZR9M
	hnyE+BdwMBPzsZqiodxbQ8bKpYGGZUtd+qv4COxJmqvySsleeqVQoNtNL++h12+MdTtQ0DwK9kovg
	EACTiJ2r5piLpC4LH7945b8no15CXlkaO0C+l4pF5mg+FB1zMuxB6Kf+dgQHP9Q9q7/dwpOKy3y8l
	XRKwzPLECVvMTqV+WNLh4PF9O8aRrRmC/eKNL131S7OxnC+mRqnwzuTUT7rtxi8Lwo8584zTL2tjn
	sfop/rYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2r9M-00000007A6W-1rW1;
	Mon, 21 Oct 2024 12:04:40 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2r8A-000000079lT-2NXg
	for linux-nvme@lists.infradead.org;
	Mon, 21 Oct 2024 12:03:27 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L2KdQ7002452;
	Mon, 21 Oct 2024 12:03:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZD4icN
	i8/y4CTQxE8K3EtB3xkbWCjTrHIuccW88t7qQ=; b=hlwMie0fosofL19dq3jzB7
	nOtZ/fenN9sdBA8ETDgeCzli81fgGJbRYt+2aO6IDDJiEtHtueybSb9SU1Uydxv8
	kOOWUEGXzq2+0YbXOr9i38u0B6XacnKtnhpap6LXJeViM5+KyDSg4QYEHqrsjEdL
	OK4X+XETlu54abfRXS8k66wsPTj/vJhfPWI83qvbm48e5YBwshkahAcaND1IWlEm
	UtcY5khbeHx4WUoeVxF6naL0rzbiCyJt0igd2wyr5/X68vCuxV+WUsM4b9rxWA8M
	78ml4FAjXqW5ImQcaONN0dclQ0eHAQyHeQQU0v2vRMwgrz59BUiGqDZsBMO5biqQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5gch2qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 12:03:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49L9IWqQ018613;
	Mon, 21 Oct 2024 12:03:15 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42csaj5y0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 12:03:15 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49LC3E9G34210110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 12:03:15 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6DED58043;
	Mon, 21 Oct 2024 12:03:14 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5ED758053;
	Mon, 21 Oct 2024 12:03:11 +0000 (GMT)
Received: from [9.171.30.180] (unknown [9.171.30.180])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Oct 2024 12:03:11 +0000 (GMT)
Message-ID: <935f1302-ce01-4645-858d-ae57cb63e9b9@linux.ibm.com>
Date: Mon, 21 Oct 2024 17:33:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] nvme: system fault while shutting down fabric
 controller
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, axboe@fb.com,
        chaitanyak@nvidia.com, dlemoal@kernel.org, gjoyce@linux.ibm.com
References: <20241016030339.54029-1-nilay@linux.ibm.com>
 <ZxFSkNI2p65ucTB5@kbusch-mbp.dhcp.thefacebook.com>
 <14a85dd6-87ac-454d-9429-4142cd0ce9ff@grimberg.me>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <14a85dd6-87ac-454d-9429-4142cd0ce9ff@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jqlNRj1JKPnVXC3VNSETMRl03VvgNvmb
X-Proofpoint-ORIG-GUID: jqlNRj1JKPnVXC3VNSETMRl03VvgNvmb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 clxscore=1011 suspectscore=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410210085
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_050326_685325_820C11F8 
X-CRM114-Status: GOOD (  17.37  )
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



On 10/21/24 03:21, Sagi Grimberg wrote:
> 
> 
> 
> On 17/10/2024 21:08, Keith Busch wrote:
>> On Wed, Oct 16, 2024 at 08:33:13AM +0530, Nilay Shroff wrote:
>>> We observed a kernel task hang up and a kernel crash while shutting down
>>> NVMe fabric controller. These issues were observed while running blktest
>>> nvme/037. The first two patches in this series address issues encountered
>>> while running this test. The third patch in the series is an attempt to
>>> use helper nvme_ctrl_state for accessing NVMe controller state.
>>>
>>> We intermittently observe the blow kernel task hang while running the
>>> blktest nvme/037. This test setup NVMeOF passthru controller using loop
>>> target, connect to it and then immediately terminate/cleanup the
>>> connection.
>> Thanks, applied to nvme-6.12.
> 
> ugh.. looks like I'm late (after a too long of a delay... I know)
> 
> I think we want to sort this out, it is not clear to me that the approach
> taken is the correct one.
I welcome you comments and also willing to fix this if you think the approach 
is not optimal... 

Thanks,
--Nilay


