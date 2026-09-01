Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BDEC61DD3
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2026 09:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kM4t8Jb31k24K8kCqlFQiBk9Am2FIxtPeVzKx43QXSc=; b=O9XJkGr4KvD8bTftGItXEdcRyT
	fScEo6civd+CTwCYqgkasOcOGjs9jzC7YaVzZmSB8DftVTlx4Kyc4COB3z8RFjdWTOHTg5ipZOgE4
	j5+hDb0e+AnrvMipQWGlXR7hiz4lOHsoBdT2sbYCZojcDvJKzkSUxqgOLLfmL+n0ISRqZVQHbSQl+
	dRZY3NaBfCwDKtEP0J4+himJ6orh16d9QxlMlz7g5zg48lEQYJJrOg1B2kC60im5tav3560aK5ltL
	aZ0Q6OqwEqZ3owb23SwKk/1bjCQoFZSBQqJCgl/1xjxucw3t+zEWCEz88uYxluxQ75FndeRO5RkW4
	y+ZGMydg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1L6Q-0000000BTIC-3moo;
	Tue, 01 Sep 2026 09:48:26 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1L6L-0000000BTHj-0R4P
	for linux-nvme@lists.infradead.org;
	Tue, 01 Sep 2026 09:48:22 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6817VWaR571705;
	Tue, 1 Sep 2026 09:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kM4t8J
	b31k24K8kCqlFQiBk9Am2FIxtPeVzKx43QXSc=; b=KYZnPk06KkVBFvvP47/Q+Y
	4rYHKuPQYomqUA5xj14W+Q0YS4VrulWuPrNuN3TrIAuJKGdRPZKg4UZzRg3Qj9AO
	JCRPK07qyfHPocqvZ82SwUOOXLzna4KCvHtWM0cYRCGWaHz0BMT+Akr6sEWoqZur
	tcQGN5IeP173I5tBcIeujFYdfqaPd8PP9g804s2MToOcICRd1Nsn2dt6DsXoRCT2
	KEByltUbPhA6Knp928Rs9tVR7zFKk3p5XrQdpm9nW5NVeaXPjeTQNlZLAMox3NwN
	rWEMdduYrZ/rVVQ2YJRrKxvttwL5iPR8d1XeUwxIpZlLj9jaW3hb0q2L4N6ZJabA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq54py44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 09:48:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6819fJVL009658;
	Tue, 1 Sep 2026 09:48:03 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcark2yh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 09:48:03 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6819m1sL64487856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Sep 2026 09:48:02 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E00995805D;
	Tue,  1 Sep 2026 09:48:01 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6553558057;
	Tue,  1 Sep 2026 09:47:58 +0000 (GMT)
Received: from [9.61.83.86] (unknown [9.61.83.86])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Sep 2026 09:47:57 +0000 (GMT)
Message-ID: <e45bf216-3853-4c52-8bf9-2835e0c65509@linux.ibm.com>
Date: Tue, 1 Sep 2026 15:17:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] nvme: add reference counting for transport modules
To: John Garry <john.garry@linux.dev>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, sagi@grimberg.me, hch@lst.de, axboe@fb.com,
        john.g.garry@oracle.com, wenxiong@linux.ibm.com, gjoyce@linux.ibm.com
References: <20260831152006.819471-1-nilay@linux.ibm.com>
 <eb76f8b4-3730-410c-bdcd-3a36c46686ab@linux.dev>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <eb76f8b4-3730-410c-bdcd-3a36c46686ab@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA4NCBTYWx0ZWRfX8nakXz/gKo+R
 cK41SvvOxmM/A5nMlXQyaeTuKoX724OPUE4xR3DezPFac6959kpM9aTCG5wyHTV5wrnns1c5sX4
 OF2iGWVhkGcN49rZkC/zYdxQglrMUvMOouoZUAiUHVC/S5/YCKV3Pl3buMFED0hbQK/ODfq7TrQ
 /0MQrTnM2HD5u+WFNbBgDhuxFlIzwtGn8SDQRLAFAEV0Z2mmXTFc7SjCUOzgSgXwm3g/gbs+ImZ
 3RncXTf+lLQwFsDDqyTeJeYFhpIGUEKX9EM+HrBjsql9JO3H3NDs+7PTjpPAMQwiGsAuzBFMDIy
 GmwF9EOFGmZcF3Hy9kVscpOHPqjMCqX3wn6EM0me9ivubSV6Uy35sTs/eQjdB4BVDRAVj8pYMWo
 GeMMtJom6JtIsd0+UYwzK5m2GnU9qZMyUjJ5wbCATHkNhcn7pl3b9fdZPiKRZAaNNL94D8YBgO+
 +8KuBqSpRDcRS3sOifw==
X-Proofpoint-ORIG-GUID: 3SWGk2N1vVoX710m9cTovzVMrkXFbowv
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a969f54 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=vuhj89a5FObyDXJrHggA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 3SWGk2N1vVoX710m9cTovzVMrkXFbowv
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA4NCBTYWx0ZWRfX/uP/wu6+4DPa
 mbhwnoQBRWxyfXmLTw7rGpcoVLjFQViIrg3YEsuPwWONFXzIMEExC1/xp6BnCEazImSDooJi8hf
 32MCyfl8mjNUVM1WYyQv3JRN3p2IKC0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010084
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260901_024821_236809_5A336C3F 
X-CRM114-Status: GOOD (  23.46  )
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

On 9/1/26 1:44 PM, John Garry wrote:
> On 8/31/26 16:19, Nilay Shroff wrote:
>> Hi,
>>
>> This patchset adds reference counting for NVMe transport modules while
>> the corresponding multipath head node is open. This prevents the
>> underlying transport module from being unloaded while it is still in
>> use by the multipath head node. Unloading a transport module while it
>> is still in use can result in undefined behavior.
>>
> 
> What is the undefined behaviour specifically?
> 
Yes, so far we have observed I/O errors when the transport module is
unloaded while a filesystem is mounted on the multipath NVMe disk. This
becomes particularly problematic if the root filesystem is on that
device: once the transport module is unloaded, I/O fails and we can no
longer run commands to reload the NVMe transport module. In our testing,
the only recovery option in that situation has been to power-cycle the
system.

> When the ctrl ops module ref counting was originally introduced, the commit message mentioned a crash which it solves.
> 
> So far for this problem we have seen a report that if we remove the module, the mounted FS will have IOs fail. The same can be experienced if the admin unbinds the device from the driver. However, I have not seen a mention of a crash, kernel data corruption, a hang, etc.
> 
Yes I have also not observed a kernel crash or data corruption.
Regarding unbinding, this is triggered through the PCI/device-model
unbind path. The driver unbind callback returns void so the NVMe driver
has no way to reject or otherwise prevent the unbind operation from the
driver side. The purpose of this patch is therefore to protect the transport
module from being unloaded while the multipath head is still open.

Thanks,
--Nilay

