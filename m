Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2A7E668AD
	for <linux-nvme@archiver.kernel.org>; Sun, 24 Nov 2024 12:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=njF8xiHlKW1gepR/5HbPE7eYM9cc7ArAKPjzVCMZzNs=; b=nvuIF/fNJvs9iKHyOZNLwkv0Ls
	uaPxZ6CZ/BRBHlgjl+4W1G2FlwdRzdsJOfjhavUev/diTzQjzCfsHOrIBBJvCXbE20Q76JAuNlANg
	2XNlo0IK+7p7rnzLlmhDe3MxaFGUTkN61vOj07nwrhI/cLvYz9bPWH1wV1F+2D/CaXeNfb0QkgMLe
	+4jq/x7RBN1oRowceORorusoLMy5qsgDj82X9XadQW5Fr0BmKo0QLQFQ/SWvIC2c/Cau+PedZuNVO
	hFXnoP4lxz3U6wJz3f2QTuxTnDRg8YZX2TwCUe/6lcMFAW+gzMIohM9z1+CYhzfQbj1QJjbsjahmV
	Z6/esjJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFC7m-00000005neR-02Xn;
	Sun, 24 Nov 2024 12:54:02 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFBxj-00000005kdy-1Yf3
	for linux-nvme@lists.infradead.org;
	Sun, 24 Nov 2024 12:43:40 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AOBjqAS014663;
	Sun, 24 Nov 2024 12:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=njF8xi
	HlKW1gepR/5HbPE7eYM9cc7ArAKPjzVCMZzNs=; b=oCSs7T1SS1MBmmrNXzb7Ew
	lEQ3PvZz/ZqlclPhi+hPw5ZBI34HIrOtZBXAKJCvEtqyGNgCyU3mc4UZhWgLx/UD
	AA/RDlqYWXxgQOnYFNzp4iNv9mYNRv8C2kMosbbXqPHx0xgc0VVrzOjs0tU+AQ0u
	+jAbHkvdfhEgBDp2t+ZWtgOCce+b/kQVW7KgzCPiE5bmQcz7x78dPxO9iwAiEdeQ
	H+2WCJ+DbJSbTzGZABBpqsyqNc7pJSFjWXhPwMgysaMBXUuCndeTKluB2y+7SVNK
	TONoCHXY7t0TLo0GUh4Ces1G5AZxdY/6zM9B4YB06Q304Z8AXrcDd48h5KhIW1lQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386n45yp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 Nov 2024 12:43:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AO3FOAM026337;
	Sun, 24 Nov 2024 12:43:24 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 433v30rjh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 Nov 2024 12:43:24 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AOChN1h48693644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 24 Nov 2024 12:43:23 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6318E58055;
	Sun, 24 Nov 2024 12:43:23 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9ACAE5804B;
	Sun, 24 Nov 2024 12:43:19 +0000 (GMT)
Received: from [9.179.4.180] (unknown [9.179.4.180])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 24 Nov 2024 12:43:19 +0000 (GMT)
Message-ID: <54d2875b-0658-46a6-9bc0-4fb5faf5d816@linux.ibm.com>
Date: Sun, 24 Nov 2024 18:13:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: fix the use of ZERO_PAGE in
 nvme_execute_identify_ns_nvm()
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        sagi@grimberg.me, axboe@fb.com, chaitanyak@nvidia.com,
        yi.zhang@redhat.com, shinichiro.kawasaki@wdc.com, mlombard@redhat.com,
        gjoyce@linux.ibm.com
References: <20241122085113.2487839-1-nilay@linux.ibm.com>
 <20241122120828.GB25707@lst.de>
 <Z0CqnBhIpmf2snuY@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Z0CqnBhIpmf2snuY@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5fqu_IulKl6aVlfSOAiS-Qa45HVd_2T3
X-Proofpoint-ORIG-GUID: 5fqu_IulKl6aVlfSOAiS-Qa45HVd_2T3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=992 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411240110
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241124_044339_431432_95FDF375 
X-CRM114-Status: GOOD (  15.59  )
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



On 11/22/24 21:30, Keith Busch wrote:
> On Fri, Nov 22, 2024 at 01:08:28PM +0100, Christoph Hellwig wrote:
>> On Fri, Nov 22, 2024 at 02:20:36PM +0530, Nilay Shroff wrote:
>>> The nvme_execute_identify_ns_nvm function uses ZERO_PAGE
>>> for copying SG list with all zeros. As ZERO_PAGE would not
>>> necessarily return the virtual-address of the zero page, we
>>> need to first convert the page address to kernel virtual-
>>> address and then use it as source address for copying the
>>> data to SG list with all zeros.
>>>
>>> Using return address of ZERO_PAGE(0) as source address for
>>> copying data to SG list would fill the target buffer with
>>> random value and causes the undesired side effect. This patch
>>> implements the fix ensuring that we use virtual-address of the
>>> zero page for copying all zeros to the SG list buffers.
>>
>> I wonder if using ZERO_PAGE() is simply a little too smart for it's
>> own sake and it should just use kzalloc like a bunch of other identify
>> implementation..
> 
> Sure. That'll make it easier to report non-zero values if we decide to
> implement a non-stubbed version of this identification later.

Ok, so if we prefer using kzalloc instead of ZERO_PAGE() in 
nvme_execute_identify_ns_nvm function, as we're using kzalloc 
at other identify call sites, then I would update the patch 
and send v2 where we would replace ZERO_PAGE() with kzalloc. 

Thanks,
--Nilay

