Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F776C36010
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Apr 2025 14:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ohJg95VFNK2VkxFDUx+QqxZvJyikEmewd/OovlkURUU=; b=nM6MqV9s82bdT+TpriNurH0mxz
	d8P/0OH0546oN9Z/YiP4J8QO1VYMFnRI/m8nNyG7nGDx54YAHKwVjMZrj/HRFPVXmgfXKH0qbsn/F
	6bv7Cd6Pz28GmDPPb7aI8RXUi8yPJxVVg/Pw5mbhFmD6YiRox9C9pgr2qI0Ocsx5idR41XJBQ7c0u
	bwr+vMv05aZ2Gjs9F5mUuvr7xFGUYcPwotZqK1Zon8k2mIvxFATSt3K0q8loYHaRf9W4nXXhqWncd
	WMhUMZEd/ALNTIVphMVzCRcX/erPX3Ak/oOiMLuHdN66lPw5gMmvEKRRYahBq54oFOZRiE/wveFFt
	L4jG7D+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1n1B-00000000dQ9-1bny;
	Mon, 07 Apr 2025 14:00:05 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1mlO-00000000a06-1Uzz
	for linux-nvme@lists.infradead.org;
	Mon, 07 Apr 2025 13:43:47 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5378JRYX019535;
	Mon, 7 Apr 2025 13:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ohJg95
	VFNK2VkxFDUx+QqxZvJyikEmewd/OovlkURUU=; b=d4uFexZ1ap9DP4yOB4tev/
	dOzLLCCKzkabXLBdEOeEF5IUbhvgCfLYnRZIKicaIUBkgU7te/OlWPHgfJTNR+Rc
	i79yQPSPypvi3+cwP746VnjhOhb6Qfd9jsWwrUmroPPZ94+VRmgkNSm9wYAjHwqQ
	58hIkOmOZFbjp0QCl7Br+tJ4JaI/N3qpx20ejdFCYPn0xYj0ybS84VZKFm5uU1Pm
	Otu/YDAZNNOz6ue7RiPMBiDxGNfWPTgT9XHodUuS8GExJJNgNau+BS2YBdYlC0/f
	hsMLn9BdC6b1kgX0hsnlLCBf7NlIHoVzrDN+aXC6vBlwaSgExMctFsbBOfjpJyPA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45uwswv9hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Apr 2025 13:43:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 537BsEIF018863;
	Mon, 7 Apr 2025 13:43:41 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45uhj25pj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Apr 2025 13:43:41 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 537DhfF83473942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Apr 2025 13:43:41 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52E4D58052;
	Mon,  7 Apr 2025 13:43:41 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D5AF5805E;
	Mon,  7 Apr 2025 13:43:39 +0000 (GMT)
Received: from [9.171.84.95] (unknown [9.171.84.95])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Apr 2025 13:43:38 +0000 (GMT)
Message-ID: <ad3cd1d7-48c7-42e4-a742-ea619c72d32f@linux.ibm.com>
Date: Mon, 7 Apr 2025 19:13:37 +0530
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
 <6a43255d-df71-4121-9aa2-5f094094d190@linux.ibm.com>
 <da954049-0c85-4675-80da-ec6e30752ae2@flourine.local>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <da954049-0c85-4675-80da-ec6e30752ae2@flourine.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: o7SzsPG8DWHr_IgNIPaq27yYe4GuzDj-
X-Proofpoint-ORIG-GUID: o7SzsPG8DWHr_IgNIPaq27yYe4GuzDj-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504070095
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_064346_523553_6F172E16 
X-CRM114-Status: GOOD (  20.27  )
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



On 4/7/25 4:31 PM, Daniel Wagner wrote:
> On Mon, Apr 07, 2025 at 03:06:33PM +0530, Nilay Shroff wrote:
>>>> Please note that
>>>> this change is fully backward compatible.
>>>
>>> Could you elaborate what that means? libnvme should still work on older
>>> kernels.
>> Yeah I think as it's given that libnvme should work with older kernels, I 
>> probably don't need to spell that out explicitly. The intention is just
>> to mention that this change would not break running libnvme on older kernels.
>> But I think I could remove this sentence.
> 
> For some reason I read 'this change is NOT fully backward compatible'. My
> bad, sorry.
> 
>>> Also could you add a tests for this? The is already a test for the
>>> current sysfs tree parser, see test/sysfs.
>>>
>> Yes I'd add a testcase for this change. How about extending the existing 
>> test/sysfs/tree-dump.c? Or do you want me to add a new test case for this
>> change?
> 
> Ideally you just need to add new sysfs dump
> (scripts/collect-sysfs.sh) and have the corresponding output placed in
> the data directory. If not, yes please extend tree-dump.c.

I see that the current tree-dump.c test program neither dumps namespace nor
dumps namespace path. So I'd extend this program. I'd also replace the existing
sysfs dump with another dump which shall have two nvme subsystems. The one
of the subsystems shall represent a multi port disk with a shared namespace
reachable through multipath, and another subsystem shall represent a single-port
disk with a private namespace. So this way, we'd be able to cover both shared/
multipath namespace as well as private namespace use cases. 

Thanks,
--Nilay

