Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6EB3C4450F
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jul 2026 07:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zCYUXELNzvTp+PJOyYK3NfTVC7JEEX3e7pQKDUW4j/g=; b=minxzbRESDRlQECMFLhQnVJOMc
	9yob4yMIuZ/HTNK2SY9Xmw/yeN8ac/ao0ZBWzAPdJFKGnKR7xKilKnrxKp3dXU77gLgXPSJk6JaP2
	/FQ9Af/xMh4RhDUSJY4HyjOFdA2pvQkeJxW29QJMm7QXofLKUfZSJ6PAG5msgCRGGA8RT85mOAANW
	mt3Kpzp+gcpFqT21W23MiieSxCai6n1uqpxwiBbtehx/JryOaNpeCro10U+1BTr4eiH7Vj6EvMv1t
	VQFzpOd7jl1yP7fxZVAZQdXkpsAO99LOVEUPJn4DR7JFJVvmw132hLqaM48KiJ8eMfwl3/D4b8hgo
	734mEliw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkciF-00000001Mt7-3Wpk;
	Fri, 17 Jul 2026 07:10:23 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkciC-00000001MsT-0uoc
	for linux-nvme@lists.infradead.org;
	Fri, 17 Jul 2026 07:10:21 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H6fqn31214082;
	Fri, 17 Jul 2026 07:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zCYUXE
	LNzvTp+PJOyYK3NfTVC7JEEX3e7pQKDUW4j/g=; b=pX/+xWzpVedJ/ok3z2R2Zs
	ib6/9G969Zqsuim2b/IipYkdQZ28dn+BcFhzuQqDF3T2TjHbXfREgXuY4A4T3rby
	bJOHR4aBPkE1r9tiT5IxPyWnoffoatktBN8s0bQCbayG99Ibiwcc2b5yothqiFq4
	LokMnFJGsZeNdUHwMZ/tuFQJmxq3XPUklyci9QeKnqU3VDGO91EfTwa/w5vhOcjv
	UHvcYVF2levNxPfe4ywOlA+dmj/npMZ+Ygmwnhw99sOlj0AfiTE1s6N247WoGP9B
	YNjEV3Hj07GbGO3g7//OnyrT1rNzbfSmf8hOs7WsS2SBtnTSIZtb5yhcVLaTtzzg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2am6tm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 07:10:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66H74e8X010087;
	Fri, 17 Jul 2026 07:10:08 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15k8jp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 07:10:08 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66H7A7qG19464712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 07:10:07 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CB3E5805E;
	Fri, 17 Jul 2026 07:10:07 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB3E558059;
	Fri, 17 Jul 2026 07:10:04 +0000 (GMT)
Received: from [9.43.55.154] (unknown [9.43.55.154])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jul 2026 07:10:04 +0000 (GMT)
Message-ID: <c1df32ff-07e9-4f1c-b7f5-2dce2c43352b@linux.ibm.com>
Date: Fri, 17 Jul 2026 12:40:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] nvme: fix cdev lifetime
To: John Garry <john.g.garry@oracle.com>, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@fb.com
Cc: linux-nvme@lists.infradead.org
References: <20260713104238.3034640-1-john.g.garry@oracle.com>
 <20260713104238.3034640-3-john.g.garry@oracle.com>
 <01c56065-b785-4cc6-87b7-47a0078ebc67@linux.ibm.com>
 <d00a2702-4713-4f29-a7ee-7eff52aa5c23@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <d00a2702-4713-4f29-a7ee-7eff52aa5c23@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDA2NSBTYWx0ZWRfXw+pf1wZVK14v
 D8+2i8q/H7iZfqceJXunOgf55fNcYVNEXjHygkroUP0GaWU5Av9CRTQmCpUqRJPUjLDzmzbr8kj
 5EEJVNj/bycnDLzjBv1L2iscfjnbO7g=
X-Proofpoint-GUID: ytH-xX-9vkJ4fBzwsxSAmxj2seD1JEDR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDA2NSBTYWx0ZWRfX4QBqxLXlC3MH
 vaOmvWDTKVrleKgcqYQuW08laXgyZHDjWyEpTBhMwpERQyfeUdCcfnU5eBNuPs8/ZmQkH6ZiFs0
 0YxAzvYJ/tCLGeMrIT1fthGIg4f7BdUxm5PMtqXh+LOyZInRpkfJOI9V95cPfGi0hKlM0rdIpcp
 Q/YbcjcJb+TrVHd03xS+vM5WS+YAzhgCo3NBPpoGXVfRTaKqVhRa1XmOB5r9ywGaBInw5ANmNU9
 fACc1TyBXrCm//9/15BDDmlqW8EGeiH74JfSOIb2JqDhqPuJ6kQF0lSguNAs78muEiNKZ3TGLXK
 zzyNEV+0cFXfnhDGbmxN+NTdwBnq3mG+D5idKqM27dthgVkORto0o9aBQaImaHGv0zOqdDVjNUQ
 TIuS7g1z9V4CbBLzfJe1eDqqi1PwpwKO//QcCrdOIJEqFf9YzRcC+/zuLQxyjlCkpy5UgVu2Us3
 oBIxws1KNmWtk7qVaPg==
X-Proofpoint-ORIG-GUID: ytH-xX-9vkJ4fBzwsxSAmxj2seD1JEDR
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a59d550 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=2JJ1oFbItihQNQmMXm0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170065
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260717_001020_372300_5D387B8E 
X-CRM114-Status: GOOD (  19.70  )
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

On 7/16/26 10:03 PM, John Garry wrote:
> On 16/07/2026 16:03, Nilay Shroff wrote:
>> On 7/13/26 4: 12 PM, John Garry wrote: > Fix the lifetime for the cdev by making
>> adding the cdev add take a > reference to the NS head and drop that reference in
>> the > nvme_ns_head. cdev_device release function. > > The same problem
>>
>>
>> On 7/13/26 4:12 PM, John Garry wrote:
>>> Fix the lifetime for the cdev by making adding the cdev add take a
>>> reference to the NS head and drop that reference in the
>>> nvme_ns_head.cdev_device release function.
>>>
>>> The same problem exists for the NS cdev lifetime, so resolve that issue
>>> through a similar method by taking a reference to the NS for the lifetime
>>> of the cdev. Note that nvme_ns_chr_open() -> nvme_ns_open() also takes a
>>> reference to the NS. Now that should not be needed, but that code is
>>> common to bdev ioctl, so keep as is.
>>
>> The bdev ioctl uses nvme_ns_open() and nvme_ns_release(). So, IMO, you may also
>> remove nvme_ns_chr_open() and nvme_ns_chr_release() methods.
> 
> nvme_ns_chr_open() and nvme_ns_chr_release() call nvme_ns_open() and nvme_ns_relase(), respectively, and they do more than get and put a ref to the NS - specifically they also check that they are not called for multipath mode (as the NS bdev/cdev should be hidden) and take/put a reference to the controller ops module. Why are those addition actions not required for the cdev? Or should it be done when we add/del the cdev (like in this patch)?
> 

I think the first check in nvme_ns_open() that verifies we have not entered
while multipath is enabled is essentially a sanity/paranoia check.

As for the module reference, I think that is redundant for the cdev path.
chrdev_open() already takes a reference to module before invoking
nvme_ns_chr_open(), so IMO, nvme_ns_open() taking another reference to
module appears unnecessary for this path.

Unless I'm missing something, it seems nvme_ns_chr_open()/nvme_ns_chr_release()
don't provide any additional lifetime guarantees for the cdev beyond what is
already handled elsewhere.

Thanks,
--Nilay

