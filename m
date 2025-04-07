Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902EBC369A3
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Apr 2025 14:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2vPLbd/3minhQjSXQBEWy+Ov0YdPbcUMzKpqjUnXjGs=; b=Cg8VOyJshpaUeRB0xAY3bOMB/P
	OmjjVRcK7alJ8hp33M5f1W2PTk6zHswjX38ma3aqksT2XS2LrHFqH4Az+8QtahAsL1muXbQgW1AtA
	sDcr4jTz+UNunY2rSfpiTa8Pz4C8wqH1Ta9Tu0j7fxkvB5NkjR34Z+co43YjxpKnG/Eyu30f8sHQr
	JJEaV+CO+bwupJT/DeK7tszMdNLsIXbpzHacxlodID8vStRx7hXK5cfFwxEMVjbYemQod8mwpsKY7
	dUYGl8skLzfQPIIOSyjeWhUGY+BjsaJYTjOkh0UvGhxr7HMPWKZjRCk3kL1R5JhBFcIrgPW/j8K0h
	MPO+a1UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1nQC-00000000ioQ-33nH;
	Mon, 07 Apr 2025 14:25:56 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1nKK-00000000hGv-3JyI
	for linux-nvme@lists.infradead.org;
	Mon, 07 Apr 2025 14:19:53 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 537E3KAc025694;
	Mon, 7 Apr 2025 14:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2vPLbd
	/3minhQjSXQBEWy+Ov0YdPbcUMzKpqjUnXjGs=; b=h276krSw8phrdJCeTtl92e
	8WPrvae3yXRNPoFro+VF3S464tWy9WEeqOxc5PlnhHmppB1EfcvOxuXk24cOpqcp
	CnBVD+SVlWZrKQv4rCE52DmMWUY00NDsGEcnICYBIBxDcdBJ0+HMupQjiCZaY1jY
	+cKfhnR96BiZ0vNgvME0/KzZKz66dWYIU2+h+gFyz+rS2cUalOe/uxHgiJ0GRtu3
	KYo5At11pNaJ6fXKlNCNBH/Q8kVDXV+G0NwXdlpGSxiegBmv5LdLBsUJuLnLY0JN
	bzsu9CF/XaLcXNZAeMEmSsFEqk+1umj0itAi4ZUQOReKAt5XOycqvj8Wc5bHk1Lg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45vg4q82mf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Apr 2025 14:19:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 537E6pR4013858;
	Mon, 7 Apr 2025 14:19:47 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufune5mv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Apr 2025 14:19:47 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 537EJkIR31589058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Apr 2025 14:19:46 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CE5658062;
	Mon,  7 Apr 2025 14:19:46 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFA3458052;
	Mon,  7 Apr 2025 14:19:43 +0000 (GMT)
Received: from [9.171.84.95] (unknown [9.171.84.95])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Apr 2025 14:19:43 +0000 (GMT)
Message-ID: <fd2407c9-e180-4785-a71f-944ea40edfe3@linux.ibm.com>
Date: Mon, 7 Apr 2025 19:49:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tree: add attribute numa_nodes for NVMe path object
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, hare@kernel.org, kbusch@kernel.org,
        gjoyce@ibm.com
References: <20250405130255.448345-1-nilay@linux.ibm.com>
 <20250405130255.448345-4-nilay@linux.ibm.com>
 <1f88256a-f36f-4a34-96e2-53d2b6da7764@flourine.local>
 <4db3b302-3a07-4e82-aa5c-c63c55de2c6f@linux.ibm.com>
 <89bce70c-8eac-4dee-a5ca-4aa52fa5687f@flourine.local>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <89bce70c-8eac-4dee-a5ca-4aa52fa5687f@flourine.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9eHm9SwunJx6xL2gTrj2LvNuCAARa6Z-
X-Proofpoint-GUID: 9eHm9SwunJx6xL2gTrj2LvNuCAARa6Z-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=971 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070098
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_071952_839568_35C82861 
X-CRM114-Status: GOOD (  22.50  )
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



On 4/7/25 4:40 PM, Daniel Wagner wrote:
> On Mon, Apr 07, 2025 at 03:29:53PM +0530, Nilay Shroff wrote:
>> On 4/7/25 1:14 PM, Daniel Wagner wrote:
>>> On Sat, Apr 05, 2025 at 06:32:49PM +0530, Nilay Shroff wrote:
>>>> Add a new attribute named "numa_nodes" under the NVMe path object. This
>>>> attribute is used by the iopolicy "numa". The numa_nodes value is stored
>>>> for each NVMe path and represents the NUMA node(s) associated with it.
>>>> When the iopolicy is set to "numa", I/O traffic originating from a given
>>>> NUMA node will be forwarded through the corresponding NVMe path.
>>>>
>>>> The numa_nodes attribute is useful for observing which NVMe path the
>>>> kernel would choose for I/O forwarding based on NUMA affinity. To support
>>>> this, export the attribute in libnvme.map so it can be accessed via
>>>> nvme-cli.
>>>
>>> This one has the same limitation as the previous one. Given that libnvme
>>> currently caches everything, we could just accept this limitation for
>>> the time being. Any thoughts on this?
>>
>> Yes agreed. So how about adding a new API, for instance, 
>> nvme_path_get_numa_nodes__no_cached which would not return 
>> the cached value but instead re-read the latest value from
>> sysfs attribute and return the latest value? We may similarly
>> extend other APIs where we don't want to retrieve cached 
>> value. 
> 
> Adding _no_cached function is certainty an option for libnvme 1.x.
> 
> One of the API changes for the next major version of libnvme (aka 2.x)
> is to add an handle to all functions. Currently, we only have it for the
> fabrics API. If such handle is available, we could add no-cache flag
> instead duplicating all functions.
> 
> Maybe adding an explicit flags argument for 1.x is an option or should
> we just keep going with the cached only approach?
Both approaches — either adding a no-cache flag or introducing dedicated 
__no_cached APIs — would work. However, in my opinion, we should aim to 
use a consistent method across both libnvme 1.x and 2.x versions.

As we discussed during LSFMM, if we plan to implement an "nvme top" command, 
we would need non-cached versions of these APIs even for nvme-cli. So, 
using the same mechanism for both versions makes sense. Otherwise, we’d 
also have to maintain different logic in nvme top depending on the libnvme
version, which adds unnecessary complexity.

Thanks,
--Nilay


