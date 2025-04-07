Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F51FC3601A
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Apr 2025 10:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hhrpGpYA/Vw10hIMohU6uECzti3bzGaS9tFQwnAEvuw=; b=oNKHTQ3gfi834W6kublSp46qcC
	B9npJpaRCsYKjYa2K9//T+TylE/24gomKhJ8/3tFy5qOOUtzcAuhmwqXG1z+I2OxkbTKmUXGFwDX+
	9r2Z3dZY/FjiiJFkBaBBEfSBuVZ7TGwAEMQElhxfu1cJ10eZ37OFBC3Q25m4RCHVyu9O17SIPZBXI
	NAWzn+aNSlkFmnjITiUCQBdG3i+UE4Usd60Fuc+H1qs1LDxnd4MyLYYEXB1sf6OHDR1dL4AVm8x1U
	fz5ACPMQvyKsLagfg1Tn8vz9c18YCNK2tnT9emwVcf34AC6NzXOeC9T5PXUr3nf15UiVYP2jPK4sf
	HBgxnnNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1jIW-0000000HJKX-0K7S;
	Mon, 07 Apr 2025 10:01:44 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1jGs-0000000HIrx-1Uhn
	for linux-nvme@lists.infradead.org;
	Mon, 07 Apr 2025 10:00:03 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5377W5kx018669;
	Mon, 7 Apr 2025 10:00:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hhrpGp
	YA/Vw10hIMohU6uECzti3bzGaS9tFQwnAEvuw=; b=LgZUhbF+lB/3grG/3aAzuJ
	63GND8QIqZUGc8dXXRFWLij9Sv3bVPh9TVF/77SU+w+nHAwOhbp5zRgLfiITMxAa
	O9kaRYC1DbY+uBJ5SyuNU8OaQyGn48p1fDez0WWOLTIpMv/eYmKmqMN6qgfbR0qE
	fxdweXTEt047+e9nGyvzzvAEHF6kf8upNp4EMnFQmcTp+5X1FBOAMuoSiFS1qSIk
	ynJ1O7NijpRbVIt9KqI9dXxgS/zMRQ9iNc6FvN6j4q9iqzF8J4HEgLI7BQBWaaaF
	oISWhkh3FIVut4ZYGsKgrlOZG8QgxdiwSxMpe13olME2bu9+WzqRgCUCsPjM0wlQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45uu1pkq58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Apr 2025 09:59:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53792cOn011522;
	Mon, 7 Apr 2025 09:59:58 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45uf7ydcqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Apr 2025 09:59:58 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5379xwQR29032986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Apr 2025 09:59:58 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5BB158062;
	Mon,  7 Apr 2025 09:59:57 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 880665805E;
	Mon,  7 Apr 2025 09:59:55 +0000 (GMT)
Received: from [9.171.84.95] (unknown [9.171.84.95])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Apr 2025 09:59:55 +0000 (GMT)
Message-ID: <4db3b302-3a07-4e82-aa5c-c63c55de2c6f@linux.ibm.com>
Date: Mon, 7 Apr 2025 15:29:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tree: add attribute numa_nodes for NVMe path object
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, hare@kernel.org, kbusch@kernel.org,
        gjoyce@ibm.com
References: <20250405130255.448345-1-nilay@linux.ibm.com>
 <20250405130255.448345-4-nilay@linux.ibm.com>
 <1f88256a-f36f-4a34-96e2-53d2b6da7764@flourine.local>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <1f88256a-f36f-4a34-96e2-53d2b6da7764@flourine.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: u4wmA6mqFlPjPDX3-hlPzndtP6E0-sOS
X-Proofpoint-ORIG-GUID: u4wmA6mqFlPjPDX3-hlPzndtP6E0-sOS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_03,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 mlxlogscore=857 spamscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504070071
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_030002_404789_78015047 
X-CRM114-Status: GOOD (  17.92  )
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



On 4/7/25 1:14 PM, Daniel Wagner wrote:
> On Sat, Apr 05, 2025 at 06:32:49PM +0530, Nilay Shroff wrote:
>> Add a new attribute named "numa_nodes" under the NVMe path object. This
>> attribute is used by the iopolicy "numa". The numa_nodes value is stored
>> for each NVMe path and represents the NUMA node(s) associated with it.
>> When the iopolicy is set to "numa", I/O traffic originating from a given
>> NUMA node will be forwarded through the corresponding NVMe path.
>>
>> The numa_nodes attribute is useful for observing which NVMe path the
>> kernel would choose for I/O forwarding based on NUMA affinity. To support
>> this, export the attribute in libnvme.map so it can be accessed via
>> nvme-cli.
> 
> This one has the same limitation as the previous one. Given that libnvme
> currently caches everything, we could just accept this limitation for
> the time being. Any thoughts on this?

Yes agreed. So how about adding a new API, for instance, 
nvme_path_get_numa_nodes__no_cached which would not return 
the cached value but instead re-read the latest value from
sysfs attribute and return the latest value? We may similarly
extend other APIs where we don't want to retrieve cached 
value. 

Thanks,
--Nilay

