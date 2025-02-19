Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B76FC021B0
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Feb 2025 14:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=allqKiueGaAXBRJ4vpQBjpSHtbMt9C7zoJnCo9rTS9k=; b=l7k8R0FK8/YfSYEUyfgWYgfFR6
	rzUUSL3t7IX2hrrgH1VoEDp5a0LSpAlmYZaAsF3LI5J4jyTezbgZ7lptfOhdNDFwgpbvAiNP9IaEm
	rPrwDmUdgk75zOcg69jYwBdegOpTmP0fmAeWcbZvyy5K/WBMyOj/Q9zxyYVzTABmPNq83UkgN3DX8
	Z/BEn03boPb1eiWA2bTrEd6XY+QgjDbrWx8Vv3dEobvAFMZGpGiXlRI2jNWiwoSHXJkfB5yV5UxKz
	F+S00hf68yM+8oXyAQl7QEsdet6LISI3Y4ep5nffJ+2W1XsRGUUvxExK7qZl93DjtGRQ0T112xuKC
	3ISyFzwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tklRI-0000000DODA-46Tw;
	Wed, 19 Feb 2025 14:52:40 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tklMS-0000000DMjI-0j0u
	for linux-nvme@lists.infradead.org;
	Wed, 19 Feb 2025 14:47:41 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J75NsE012080;
	Wed, 19 Feb 2025 14:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=allqKi
	ueGaAXBRJ4vpQBjpSHtbMt9C7zoJnCo9rTS9k=; b=CyR4X7pU+uzDN3Lbv5WQ33
	uIB3iPWTGHPtXsA0t+TY7MsQyE9LoGNsv4pEKLZAX1QzumQFoXAJK1h+GFH02gs1
	qv3Qq42BrnmjbCfnTRIo2cxBquIdZl056XQrYQ33U92prBjGNUyNB8twxk5/64oe
	xg17R8HKz18n4+VUZQoI5Fn3tJ9tkz0f0kAfZweYCGii+nIuvxOJOLs/AmhoRh1f
	3We7yHC5q0+YW5STlQu7+a1nlSmL+nASqOGFStCPSheLfovMcsYPQPVSdqzjSlcS
	rm1/vS5Q9nFvrDhW9AA24fhIXpbKBdu3IELqPyNMsb5CVz4JItaUsJBOJE9sKIfg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44w5c9bee9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 14:47:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51JDqXdf029296;
	Wed, 19 Feb 2025 14:47:30 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w024cjj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 14:47:30 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51JElUPE20251320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 14:47:30 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5855C5804E;
	Wed, 19 Feb 2025 14:47:30 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C57958054;
	Wed, 19 Feb 2025 14:47:27 +0000 (GMT)
Received: from [9.61.184.147] (unknown [9.61.184.147])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Feb 2025 14:47:26 +0000 (GMT)
Message-ID: <2ff87386-c6db-4f2e-be91-213504d99a78@linux.ibm.com>
Date: Wed, 19 Feb 2025 20:17:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: remove multipath module parameter
To: Keith Busch <kbusch@kernel.org>, John Meneghini <jmeneghi@redhat.com>
Cc: hch@lst.de, sagi@grimberg.me, bmarzins@redhat.com,
        Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
        axboe@kernel.dk
References: <20250204211158.43126-1-bgurney@redhat.com>
 <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com>
 <Z7Sh-3yHbXVmRbNL@kbusch-mbp>
 <8a1730a1-1faf-4722-99e1-c3a85257b6f4@redhat.com>
 <Z7TARX-tFY3mnuU7@kbusch-mbp>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Z7TARX-tFY3mnuU7@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5sDdhRf2rzB5W1cUsG7tc1BiCsSpIlov
X-Proofpoint-GUID: 5sDdhRf2rzB5W1cUsG7tc1BiCsSpIlov
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_06,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190115
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250219_064740_227450_7E0C6214 
X-CRM114-Status: GOOD (  21.95  )
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



On 2/18/25 10:45 PM, Keith Busch wrote:
> On Tue, Feb 18, 2025 at 11:31:58AM -0500, John Meneghini wrote:
>> On 2/18/25 10:06 AM, Keith Busch wrote:
>>> On Thu, Feb 13, 2025 at 03:37:28PM -0500, John Meneghini wrote:
>>>> Keith, Christoph and Sagi,
>>>>
>>>> This patch has been fully tested and analyzed by Red Hat's QA group and no
>>>> unexpected side effects or regressions have been found. Both NVMe/FC and NVMe/TCP
>>>> have been tested. Our QE engineer has asked me to report this upstream.
>>>
>>> What's the harm in leaving the parameter? *I* use it so I can test both
>>> ways without needing to compile multiple kernels.
>>
>> LOL.  We've been talking about this since 2017. The goal has always been to remove support for DMMP with NVMe.
> 
> I understand that disabling nvme native mp it is required for device
> mapper, and I get you want to prevent the possibility of anyone using
> dm-mp with nvme, but that isn't the only user that wants to see all
> namespace paths.
>  
Agreed! I do have nvme multi-controller disks and I toggle multipath module parameter to
test it both ways. One with each individual path to a shared namespace and another with 
a single head node path and then let IO policy determine which path to choose for sending
IO to disk. 
In fact, we have few nvme blktests which only runs if device is configured with single path
and so testing it on multi-controller nvme disk would require us to turn off multipath module
parameter. In that way this parameter is very handy. My typical way of 
toggling this parameter is:
1. disable multipath
# rmmod nvme
# rmmod nvme_core
# modprobe nvme_core multipath=0
# modprobe nvme

Now I could run all nvme blktests which require us disable multipath.

2. enable multipath:
# rmmod nvme
# rmmmod nvme_core
# modprobe nvme_core multipath=1
# modprobe nvme

Now if we get away with multipath parameter then it means we have to re-compile kernel
disabling CONFIG_NVME_MULTIPATH option and that's something we may want to avoid, 
if possible.

Having said that I'm not against this patch however we certainly have users who would 
be using multipath parameter and taking away this parameter may break those user 
application. So I'm wondering why is it not possible for RedHat to let their customer
know the fact that starting with RHEL-10, we don't support DMMP for NVMe device even
though the multipath module parameter is present?

Thanks,
--Nilay




