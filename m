Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD56C6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 07:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hQZxVUExsv+856nPD5Ou3ZQ1TBRAOMCLVmmsu+x3CWY=; b=q/Do8L4uMdP7I3+fgWEgx50f+x
	9j9oLMewBfqmL7eLSyQ2uHkUW7wyP9yIYx6ojGFy549Blpl/ldZrkl4wT97vbVQBlYprKHLC0I1qs
	DRmU6SDF4gFu0VA5ncV0X3wwHyvp+uBw5wwl3YI+n5x/PW+mPzRP9geKf3r3a2sLhlQER7vAPsVg7
	wJMnKLmX7mCyaRDJsm/ZIcKGXCRk/h/Qp5nIFsCUe8iCM91ytdUEfiu5q8HMRXhpKIHXFqwtMM1/A
	+r8wHeJBNJbAETl59X7xp5GVPEDjJ8rscaI/4lnyvsoRL41U2FHAquXrPRUkr5YoUo7JG0DIe4K94
	4raRDtxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrueW-0000000ENNn-1CO0;
	Wed, 03 Apr 2024 07:03:20 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrueS-0000000ENNO-3xmt
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 07:03:18 +0000
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43370Rvp016397;
	Wed, 3 Apr 2024 07:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=hQZxVUExsv+856nPD5Ou3ZQ1TBRAOMCLVmmsu+x3CWY=;
 b=ZZqenvK2ICo/6xRVSFpfnIZzte/h2duLCl+bBu7FFWBHquP/YRB1zOB0qxSto2K3o+YU
 Fvczg/bMcskjjC3UH1rzqfdkKyCRwo010xkLE4WBfOGti+Ooltuiosq/70xcBQ65MSdC
 soTJkNqihs/J8F6436w8eycCuvLc9z2H7J//gQudHxcjEN/8akTGx/7hRCEGhzVHSNwG
 UC1pklXxOA7g4wI7KdfqgXHVmgkA99U0hhojHJ73mBt4NqYQFbvC+h1Ge3DL7jkgUGD+
 2V9FizGO+PgHFvF0Fl9qulHcjXoq2C17lUpjkBSkLe8X7Aw7dhN/oM4Q2PvKMwFLBWSD mQ== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x927m00nf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 07:03:12 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4334YXOO027151;
	Wed, 3 Apr 2024 07:03:11 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x6wf0bxb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 07:03:11 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4337389C16122524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Apr 2024 07:03:10 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85B1558078;
	Wed,  3 Apr 2024 07:03:08 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 783C95807A;
	Wed,  3 Apr 2024 07:03:06 +0000 (GMT)
Received: from [9.109.198.231] (unknown [9.109.198.231])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Apr 2024 07:03:06 +0000 (GMT)
Message-ID: <ff149ec9-9664-4d72-bbe5-1db2520df33b@linux.ibm.com>
Date: Wed, 3 Apr 2024 12:33:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug Report] nvme-cli commands fails to open head disk node and
 print error
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, axboe@fb.com,
        Gregory Joyce <gjoyce@ibm.com>
References: <c0750d96-6bae-46b5-a1cc-2ff9d36eccb3@linux.ibm.com>
 <20240402150446.GB1916@lst.de>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20240402150446.GB1916@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: scVKc_ct3q5yfhkq6_EyU8j4pav3UnDH
X-Proofpoint-ORIG-GUID: scVKc_ct3q5yfhkq6_EyU8j4pav3UnDH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_06,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 spamscore=0 clxscore=1011 mlxlogscore=999 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404030047
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_000317_355509_F1405618 
X-CRM114-Status: GOOD (  22.85  )
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


Hi Christoph,

On 4/2/24 20:34, Christoph Hellwig wrote:
> Hi Nilay,
> 
> can you see if this patch makes a different for your weird controller
> with the listed but zero capacity namespaces?
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3b0498f320e6b9..ad60cf5581a419 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2089,7 +2089,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>  	if (id->ncap == 0) {
>  		/* namespace not allocated or attached */
>  		info->is_removed = true;
> -		ret = -ENODEV;
> +		ret = -ENXIO;
>  		goto out;
>  	}
>  	lbaf = nvme_lbaf_index(id->flbas);
> 
I have just tested the above patch on my controller which has zero 
capacity namespaces. The patch works as expected and I don't encounter
any errors while using nvme-cli commands. Please note that I am using 
here the old version of nvme-cli (nvme version 2.6 / libnvme version 1.6).

Furthermore, with this patch, I no longer find any hidden disk nodes 
(i.e. nvmeXcYnZ or nvmeXnY) created for namespaces with zero capacity 
under /sys/block. So the behavior is similar to that of kernel v6.8.

IMO, we should upstream this patch.

Thanks,
--Nilay


 

