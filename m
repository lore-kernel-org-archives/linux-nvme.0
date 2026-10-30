Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A975F606A31A
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2026 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Y+tBPKyZ;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XKXbNkGv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=DiWmH6VT1ts1tWWaNPnQxXhfyfIj8U3S1OV+JIFkAFk=; b=Y+tBPKyZ2a0h17
	N/RHr1maKBpYcRRoiYCkMJJF2EXeeMLtNFlh4XrGKvolsYcwYcIXG1B2Z1oU4JUHXpUOblfrZbzve
	GDmIa6Q46tfl+2b4qO1PEVZ6zUHWnb/JXIz4Vwv3ZYka+jAryhb7NqQSwInn4h455uBXrzEMiH41h
	2a0Rrxq5D3iF4q/CLt1R6Qk3rPb3pSHk8FU+Bi+6NGF/qxbhHkDQ8qUBwPrHRxXs4C12X833ciFbK
	G6xRKkiV90dSAKFs7CnkFRmRhbRDpszRhNSQInx8DzJjzf0A5lEjbv2vfppYI6Y75+jRebKNByRIB
	RgGmwnepN7UKNBy97TMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMoAi-0000000BwNf-0EyI;
	Fri, 30 Oct 2026 15:05:36 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMoAe-0000000BwMi-3HV4
	for linux-nvme@lists.infradead.org;
	Fri, 30 Oct 2026 15:05:34 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UEiKFw3121898;
	Fri, 30 Oct 2026 15:05:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DiWmH6
	VT1ts1tWWaNPnQxXhfyfIj8U3S1OV+JIFkAFk=; b=XKXbNkGvzUx681xsTfKbWS
	qeyA8dB7BhWXdrSo2ADmiXx+46NFjpMo9+XE5zU2qQ47fafMCpnwFEK6bfCNqfnB
	wkjia8zRfH6riGE3aWTHbq2tkqlJ4KojU7+ofsA+6HFhHODpD4AIMzyyXZnE3xQT
	EOhX329d3o9TPEA1IL3rxD8igqFyTM3dmLawR1yCNy6vGVD8rmQRtQ1rpKVdf/pa
	Ga/zfo6wbqR8O+Uc3jhZ2xNg4BdbtTU+/rokafIJXY02S3GWMgNFbEeRTQW9e6l3
	LrczYBmL9myjTs1TQVDNg7QlPfAGrQVeXFmi0n5FYRny9MfSA45viK+HcI1r5Z2w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hmeb03b3x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 15:05:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69UEYv7a710150;
	Fri, 30 Oct 2026 15:05:21 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hm6pbcxg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 15:05:21 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69UF5K1613173434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Oct 2026 15:05:20 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 599E958059;
	Fri, 30 Oct 2026 15:05:20 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7F7058061;
	Fri, 30 Oct 2026 15:05:17 +0000 (GMT)
Received: from [9.61.35.48] (unknown [9.61.35.48])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 30 Oct 2026 15:05:17 +0000 (GMT)
Message-ID: <104ce7b7-dea4-4a08-912b-a8222ff73db7@linux.ibm.com>
Date: Fri, 30 Oct 2026 20:35:16 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] nvme-tcp: NIC topology aware I/O queue scaling and
 queue info export
To: Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, chaitanyak@nvidia.com,
        gjoyce@linux.ibm.com, linux-nvme@lists.infradead.org
References: <20261026123411.1988949-4-nilay@linux.ibm.com>
 <28fc7035-2beb-4f67-9a55-09b31d873608@flourine.local>
 <a9d3333f-3b70-45c7-ba79-7b441336415e@linux.ibm.com>
 <7c9343a2-d69a-4215-b2c7-0d9d412c2e0d@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <7c9343a2-d69a-4215-b2c7-0d9d412c2e0d@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=bLaDs/+Z c=1 sm=1 tr=0 ts=6ae4b231 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=orY6XbTOmxIrMutoLZMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 5YEb8rh01DU-Qw1HYkruDUtU_rw1B7U8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OCBTYWx0ZWRfX6AzotjaqFJik
 EUu3fycMulSF2DTAZmcoaitx/hVsiQ1VuMNiiw+rncPjesfLSOta3mPBf+gpa7RsMEJlKdJqFf/
 s9aGrY5bTeDhP8C4W1nbFZmnE5sSpGBQlD9vKQy+cutaBtGEYculY9OFOwhY8ixonwQgarE/73J
 AbHC97EvWXg+HgMhPn69GswNkZIPC/6VHGuuB4E6oHJvC8BowXPp6Tj9MM6CnVbliKACLcblVmd
 sTJdmn7jIDNdqSFsjG4nPQhkuctVqL4z+f/HlENe8JTJsdk3XiPkUPrpm+mdiuavvWrN5tvBg71
 KzhWJ3igqRjcsGdt4FLVV5H/fb29PqoyaWpmYjlLrbmCVKdR8y2x0Yj0z7W66LIVqa2E0kdyuRl
 LUjHjqS/3eyWSWXuWHIxJ6/6RlWC6u2oIH5ebDqns630y1h73FLvhByrmqZtNDfIMylxcVWbqIl
 AwNrJF/hqweVf5yGlJQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OCBTYWx0ZWRfX5sGL7zKQlQMI
 5dlh3bMIS7royE5A31T9HcLNejDHTsQJ4qVQSXt46PLZGW3s06rPYELCQvVYOwq9s8DeLsMAvp7
 8KYNgtjadDb/szDDb38P+t6Il/1ECrE=
X-Proofpoint-ORIG-GUID: 5YEb8rh01DU-Qw1HYkruDUtU_rw1B7U8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300058
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261030_080532_986160_DB4AF2F3 
X-CRM114-Status: GOOD (  21.31  )
X-Spam-Score: -2.6 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 12:39 PM, Hannes Reinecke wrote:
> On 10/29/26 5:59 PM, Nilay Shroff wrote:
>> On 10/29/26 9:41 PM, Daniel Wagner wrote:
>>> On Mon, Oct 26, 2026 at 06:03:21PM +0530, Nilay Shroff wrote:
>>>> Following the feedback, the logic for determining the number of fabric I/O
>>>> queues (nr-io-queues) has been moved to userspace in nvme-cli [2]. As a
>>>> result, the first two patches from the previous series, which implemented
>>>> this logic in the kernel driver, have been dropped. This series contains
>>>> the remaining two patches, which export NVMe/TCP I/O queue information
>>>> through debugfs to facilitate host-side network tuning.
>>>>
>>>> The first patch introduces debugfs helper functions that can be used by
>>>> drivers to export debugfs attributes.
>>>
>>> What is the expectation, what's the use case here? Should this
>>> information be available in a productive system? In this case debugfs
>>> might not be the right choice.
>>
>> Ideally, this information should be available on production systems to
>> facilitate network stack tuning.
>>
>> Would you recommend exposing it through sysfs rather than debugfs? During
>> the last LSFMM, I received feedback suggesting debugfs, so I implemented
>> the interface accordingly in this patch series. However, I'm open to moving
>> it to sysfs if we agree that it is the more appropriate interface.
>>
> Hmm. This matches what netdevs do with their tx/rx queue mapping, and that is in sysfs. Typically I would prefer debugfs for this, but here
> I really don't mind as it's somewhere in the middle between generally
> useful and being a niche usecase.
> Alright, then I'll move this under sysfs and spin a new version.

Thanks,
--Nilay

