Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46446E7717D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 17:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h941mq+FTPDZRu/rGivGIolQM9MOQNVOJux2SD6Qt0o=; b=Oc2hQK/dynYBi+c7WZELY+Zh2i
	z8Ya5c/WihWj7x5u0eygF1KS4FMc+xODIOCktatOocgxd/8Inqhr2qAIfI+E3LLmsmU89gaAjvyDx
	M2oplDopCR8q6PxYhmy2E407Z1Gv6AgMCr5/mw96aCBWbxz5weCw06s7cjUspKbugBc9KrkTAzt/3
	SxfPilkxwda0fb5Ihe86nnHG4CkTwizfKuRPadLnOwp+gO9jxrS3QbzcDpTKoCuSS+PjGWPjA3TQY
	iV6KoegcUt41Sd4UQR1F095mhX/3HWvNL7BXz6EJ83SlEoJJTBJ832FxdN8/EIBA3Ovw1IzC4TepJ
	/ia0hP+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKhhz-00000008l6V-16ZP;
	Mon, 09 Dec 2024 17:38:11 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKhhw-00000008l5n-4783
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 17:38:10 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B99jagg009918;
	Mon, 9 Dec 2024 17:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=h941mq
	+FTPDZRu/rGivGIolQM9MOQNVOJux2SD6Qt0o=; b=bQWg/1/7/DFr/Mfn6GWx1l
	5T2LYLscZyWC40dbYttjyVSHP8Bus1bjJKKRmr2Vw2NLbbielnDC8mrwGuvagbij
	Y2tDeso2fTKPySNrNumPYtTPvGYVir61dRHPxfg/k5ccZGqFaUHA2ivYzWuuPgY/
	lA4a/F8b4+GCEwCO8+ActOz+GTATLX/L8hzfWk2OA4NgJU3vfd6PbsyZWmoDFdJv
	6GTOt4GrXfcRmYfuZvyol4eBhBUe5hTU0gdA3/kYk4K0WD9OI8hiZVvqCLj9uIRw
	4t/NXkPhNVmjm2RDCWpOPNwyYpJSwb1sZQbVyYZ+0M0VVEGtDJXuVhSL05wAHN3A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cdv8js9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 17:38:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9EwJ4O018598;
	Mon, 9 Dec 2024 17:37:59 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d26k7ky5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 17:37:59 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9HbwbR3408636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 17:37:58 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B87158045;
	Mon,  9 Dec 2024 17:37:58 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC7B658052;
	Mon,  9 Dec 2024 17:37:54 +0000 (GMT)
Received: from [9.171.71.154] (unknown [9.171.71.154])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 17:37:54 +0000 (GMT)
Message-ID: <b643ca9e-ca9d-458c-8a8b-e03d97f75bd9@linux.ibm.com>
Date: Mon, 9 Dec 2024 23:07:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-loop: avoid using mutex in IO hotpath
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, shinichiro.kawasaki@wdc.com,
        kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
        chaitanyak@nvidia.com, gjoyce@linux.ibm.com
References: <20241129104838.3015665-1-nilay@linux.ibm.com>
 <20241209080159.GA24776@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20241209080159.GA24776@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RmlXbfMBfx1pu-499UUM-aBNZIG-SrD-
X-Proofpoint-ORIG-GUID: RmlXbfMBfx1pu-499UUM-aBNZIG-SrD-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=490
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090136
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_093809_027488_6A79E8C1 
X-CRM114-Status: GOOD (  14.10  )
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



On 12/9/24 13:31, Christoph Hellwig wrote:
> On Fri, Nov 29, 2024 at 04:18:33PM +0530, Nilay Shroff wrote:
>> -	xa_for_each(&ctrl->subsys->namespaces, idx, ns) {
>> +	xa_for_each_marked(&ctrl->subsys->namespaces, idx,
>> +			ns, NVMET_NS_ENABLED) {
> 
> Given that this is duplicated quite a bit, maybe add a
> nvmet_for_each_enabled_ns wrapper for it?  And also a nvmet_for_each_ns
> one that iterates all namespaces?

Yeah sure, I will add those wrappers and spin a new patch.

> Otherwise this looks good, and I really like the use of the xarray
> mark to simplify things!
> 
Thanks,
--Nilay

