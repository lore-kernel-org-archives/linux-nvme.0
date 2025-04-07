Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64310C36010
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Apr 2025 09:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nctNoG+x2oC/8s378ZDfa189cv1d0GKDph6XLnF085o=; b=rs9OkqvcGcXG8jdBOLwNhv6dKH
	vLmj+ExRmwYB3MC8Maf3reHY+l/3OsaKC9D8j6trlyA7t3khoJylqe7e83fmYBMRUoZukr06POyd0
	tqyC/yUe5Mlvwf9rBXF4n2HUPTCEAWA8WbpEFz7I1uu5MNGPtD0S71ZNrJH1r8LbNtTsaHTZyP+q6
	jc+MhWtRpgaVWQwd/zCzHizJFXRxoC610PvJvdDRqFtIMHywuLP8LcutKxjstOBbShq/4HRkVtN7J
	K/veAXi1xmJwG6JxCq9R34epRqdayH/Y/j8S5fiYWFysDuCqJZaKctSzW+lw16FoG3sI7c3QEO95R
	YXQ0RxzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1ixh-0000000HDtn-1TZa;
	Mon, 07 Apr 2025 09:40:13 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1iuK-0000000HDKn-1ccX
	for linux-nvme@lists.infradead.org;
	Mon, 07 Apr 2025 09:36:45 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5379TnBA021141;
	Mon, 7 Apr 2025 09:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nctNoG
	+x2oC/8s378ZDfa189cv1d0GKDph6XLnF085o=; b=WFbIF/VIEmW0P9DB6gucDE
	cGoS2cwI0SS8sNYTQbBFFX6VJWUVOHJRdhvgjQej9Mht0Or05qTmHNY760Aolr+1
	5fzetqrq+5vVEa4I0cZZoH7eTXINn440PjLR3Q+1x3a8Lmh0hUWDZvhWSvr6fwKj
	/eB7eyRw4Yf4l6zpfN+OIlHhwHHZ3OGYNqHHC2lrpZIv88JLUv19C5lAObbxoDnM
	vGQ+dftZCQW6kmcjXSi7sWBKRE4BlpWV+gsSceUexeWdke/bFHXIN58XGbhr0c8L
	E2qxcWECvLnoJpjaHUWR1jkIzj8bIxhwC02+ukZcTMfZ4WXQhphyRu4uVBUA/itA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45v0u0jg06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Apr 2025 09:36:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5379ULKj024590;
	Mon, 7 Apr 2025 09:36:38 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ueut5cbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Apr 2025 09:36:38 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5379abNN27132372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Apr 2025 09:36:37 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63A4F58056;
	Mon,  7 Apr 2025 09:36:37 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 372815805E;
	Mon,  7 Apr 2025 09:36:35 +0000 (GMT)
Received: from [9.171.84.95] (unknown [9.171.84.95])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Apr 2025 09:36:34 +0000 (GMT)
Message-ID: <6a43255d-df71-4121-9aa2-5f094094d190@linux.ibm.com>
Date: Mon, 7 Apr 2025 15:06:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tree: add support for discovering nvme paths using
 sysfs multipath link
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, hare@kernel.org, kbusch@kernel.org,
        gjoyce@ibm.com
References: <20250405130255.448345-1-nilay@linux.ibm.com>
 <20250405130255.448345-2-nilay@linux.ibm.com>
 <6a1f8acc-acf6-4a72-abdd-84aa81623ec7@flourine.local>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <6a1f8acc-acf6-4a72-abdd-84aa81623ec7@flourine.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aezRdiok5hWcxprVjDS08T-VPE65cXjV
X-Proofpoint-GUID: aezRdiok5hWcxprVjDS08T-VPE65cXjV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_02,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504070067
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_023644_565525_AAE7C4FC 
X-CRM114-Status: GOOD (  22.22  )
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



On 4/7/25 12:49 PM, Daniel Wagner wrote:
> Hi Nilay,
> 
> On Sat, Apr 05, 2025 at 06:32:47PM +0530, Nilay Shroff wrote:
>> With kernel v6.14, when NVMe native multipath is enabled, it is possible
>> to discover all paths to a shared namespace using the sysfs multipath link.
>> Leverage this functionality to update the path links for each shared NVMe
>> namespace, simplifying path discovery and management.
> 
> Since this is not a trivial change, could you extend this section a bit
> how it works? I understand from reading the patch, a new head namespace
> object is introduced which links to the different paths. 
Sure, I will update the commit and add more details.
> 
>> Please note that
>> this change is fully backward compatible.
> 
> Could you elaborate what that means? libnvme should still work on older
> kernels.
Yeah I think as it's given that libnvme should work with older kernels, I 
probably don't need to spell that out explicitly. The intention is just
to mention that this change would not break running libnvme on older kernels.
But I think I could remove this sentence.

> 
> Also could you add a tests for this? The is already a test for the
> current sysfs tree parser, see test/sysfs.
> 
Yes I'd add a testcase for this change. How about extending the existing 
test/sysfs/tree-dump.c? Or do you want me to add a new test case for this
change?

Thanks,
--Nilay

