Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B1AC3ABC0
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 19:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=21mGnYgG+wuNzQ0NCK0FeXxCQ3SdNbLRMfTjgDhHlLA=; b=v2151QLvJtJjjHjgRbEGaBf5Ey
	dqPvDpuEJbcVGihteqfUWQVvS1LnZBHSDSWLno8djgfLSReidRp+iUWws9W3kQPqXD+TQUSMH/SbV
	yVHwvo7BjXgE2kyTDcJSD7VSVogvM1evUuXOjhxumgxcOUIdnTyOKNFFqthq6yYI5t5GngTjPfLn9
	2h9U1V17XeCx4gr+9dsLbU3/T4HJoFezHJNQvaoodiEpKCDRZqRAIn2J3iSFch+ysT9Em8lU9/3K7
	sDRkGF959R738Uu7Y01Hcmn55VUW7yRv1p7aQxo2UqaGO1PBFkHVh/X9dSKAF9h0jSfjTIB2oKCsb
	Yqvtm4/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCktC-0000000Gckn-06jI;
	Wed, 07 May 2025 19:57:10 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCkse-0000000GcVQ-4Apj
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 19:56:38 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547Jevjj011582;
	Wed, 7 May 2025 19:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=21mGnY
	gG+wuNzQ0NCK0FeXxCQ3SdNbLRMfTjgDhHlLA=; b=cd9yRmYPmHMMuQRM3Cpjkt
	29NuP0U5/hAA29ZpvQ92YO9phc6cRqifv1pUshPZmJJBuq9p/rZ1Z5QdBTwCKHab
	8VdoO6Y+GHnI2lngfVrWs+v3vJcCEI/UbpLeIvJlkQMsj2yY8wxrfhIeHgbiCxvX
	CeooH+ATVc4IkciRdu/7ZIYDpMcVoMVP39ig78dJaUofu5JqwGee53tLkbOYQGwW
	UFpaffpeHgtPDJGZX9gXaLjhw6U6WVdhvRC7VbPzJSA7dcDgWH/LSMUXsdw/wYDF
	MX4uQsUX9PiYu+plG4HHNacVMBEu0ec03gxuWqLGNDfWxrMS3YDRJuhRQMix2GTg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46g5ejtvrm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 19:56:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 547G99eX001272;
	Wed, 7 May 2025 19:56:22 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dwftjh0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 19:56:22 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 547JuLeb29688460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 May 2025 19:56:21 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5EF15805D;
	Wed,  7 May 2025 19:56:21 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 856BC58055;
	Wed,  7 May 2025 19:56:18 +0000 (GMT)
Received: from [9.67.78.42] (unknown [9.67.78.42])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 May 2025 19:56:18 +0000 (GMT)
Message-ID: <6fa58716-8995-43b9-b01e-3bbcf2cc6b2f@linux.ibm.com>
Date: Thu, 8 May 2025 01:26:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv3 1/3] nvme-multipath: introduce delayed removal of
 the multipath head node
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, sagi@grimberg.me,
        jmeneghi@redhat.com, axboe@kernel.dk, martin.petersen@oracle.com,
        gjoyce@ibm.com
References: <20250504175051.2208162-1-nilay@linux.ibm.com>
 <20250504175051.2208162-2-nilay@linux.ibm.com>
 <dd7330a2-6499-4af7-af3a-489ab86d2b5f@suse.de>
 <20250507065050.GA31543@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250507065050.GA31543@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SvuQ6OO0 c=1 sm=1 tr=0 ts=681bbae7 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=HBjKgjWE6QSMYBg_uj0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8u6oNxvKEtxpUV5XxFsrIxgC4K_7DVte
X-Proofpoint-ORIG-GUID: 8u6oNxvKEtxpUV5XxFsrIxgC4K_7DVte
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE3OSBTYWx0ZWRfXz9rer4aimnhV Iw+Q0//4/4l1Th2Xiokxk/Cr2CT5kfh31JQEnT3d4otOd/1Yiwbf04KF4KCnywlHYS3Gr5KwDwm QEtzdB0N1syI/EdBvRI0eUiIJGWtVDg1Aqi/aGYan16ShB95Nujt42NXjKjKgwijK+91Y2138f+
 sabKMRZFb44CXrCYjxuLKE1aTMGwpZ+qe54RKjOIJxIApZWYkOrwgQw2tgHFlcNM+JZ70daUuQh xXgP5Tuzq3ZQBcfhehI1rzb7NDmA64CFso7OECHtdKLwfgUCVNxlJFn2p/VB7AAP+mlpqHP5637 0gw2QkakLeU3bZc0dljADQXnfbR4aCCDyXN5ZDTK9K6zehfV+QU0BtL9fo5v5v+UP/vC8kW/oTS
 WR095KE/5z+MAo6suukv56NGuLUt0+qGc9Z2PQUke6mrjuoJbqS02AUjBtpBPpMQLEUN4+jn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_06,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 mlxlogscore=834 phishscore=0
 adultscore=0 priorityscore=1501 spamscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505070179
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_125637_044851_2C09FF1E 
X-CRM114-Status: GOOD (  16.26  )
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



On 5/7/25 12:20 PM, Christoph Hellwig wrote:
> On Mon, May 05, 2025 at 08:39:11AM +0200, Hannes Reinecke wrote:
>>> +	if (ctrl->ops->flags & NVME_F_FABRICS)
>>> +		nvme_mpath_set_fabrics(head);
>>>   
>>
>> Please make this a separate patch.
> 
> Absolutelty not if we keep this, as there is no other user.
> 
> But I still don't like the fabrics special casing at all.
> 
> I'd much rather just disable it if opts is present and max_reconnects
> is set to non-0.
> 
That's a possible approach; however, the challenge arises when the head node
points to multiple namespace paths, each associated with different fabric 
controllers.
As we know, max_reconnects is a per-controller attribute. So, if only one of
the fabric controllers has max_reconnects set to a non-zero value, but others
do not, how do we decide whether to implicitly disable head->delayed_removal_secs?

In such case, should we assume that if any one of the controllers has max_reconnects
set to a non-zero value, then the configured head->delayed_removal_secs should be
ignored?

Thanks,
--Nilay

