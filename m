Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8BC0F54AB0
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2026 13:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JJL0Ksjjd+17M7NV6197NXVIf/uH81oWlrDc2fBdTAk=; b=d+qi/6SmuD1QmcEkeisyrBCB+W
	AJau3PAnOl/FTo8r3QbvDZMXcYgzNHbQ+Lh27nlpJqzAVUjQjdUXJuym5PKjMIVsnF2JxNks6MVuW
	E9f/hxLg+dchJiljbBu0Dkew4Pz0bR3rvo9pWqDXUkiNiWMttnoyu+yqxpTkcfIV02siXyy/oTxfF
	UrJ6WSLFLZqwSmp7flsHP3d0pl8alxLqCvIEOw6pIMW9TSn9iv39h8OUPOIPJxpb6eC7Ww/h16qmo
	YrHvUErfRB+39zEb8+nOyOcuhKPWIsYrb3KMqCXUG85Ur+ThwiD6tMRT1It9uigXkRVh/38nkJeHs
	X5gh2bfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w52D9-00000001aDJ-3nVK;
	Tue, 24 Mar 2026 13:54:23 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w52D7-00000001aCx-2cWn
	for linux-nvme@lists.infradead.org;
	Tue, 24 Mar 2026 13:54:22 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NMMtdx3105965;
	Tue, 24 Mar 2026 13:54:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JJL0Ks
	jjd+17M7NV6197NXVIf/uH81oWlrDc2fBdTAk=; b=CgKiZMk/QuOHxtI9ZYWc54
	4bBnbfHklgILlU8siDVTviuiGaSUfw1tIWDOTN4VsufOGnJ56N41c979mF00QIHP
	C/2VgU8y0hJsuR8P7qD76FcVzOxN2WZ27ok6dME5abjGxe6cAPSov4q+mSlJJj+C
	roAHeZofjoG2Njw86QTNEUpCDg7nTvDpA4fLLxymRPFLyQ9vKs8WFgSXXqpZfsnp
	RMcmaprOHBZkRCichdNLKlcqEismKOANaPb/QZ9VSavBBdFq0op/7uBX2Mq7DxmL
	R/EqHIPQjk7SfV+PPU7x3BoHYG4VBXy8ad7T3gykou5z/xI0oH6EkAPe1wtirFsg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktuu6x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 13:54:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OCPfpD026681;
	Tue, 24 Mar 2026 13:54:17 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275kt1vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 13:54:17 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62ODsGNu25625332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 13:54:16 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5817858056;
	Tue, 24 Mar 2026 13:54:16 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C25AC58052;
	Tue, 24 Mar 2026 13:54:13 +0000 (GMT)
Received: from [9.39.27.13] (unknown [9.39.27.13])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 13:54:13 +0000 (GMT)
Message-ID: <afc7e386-e474-4ba4-8e3f-b710eee781f2@linux.ibm.com>
Date: Tue, 24 Mar 2026 19:24:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] libnvme: add support for per-path diagnostic counters
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, hare@suse.com, kbusch@kernel.org,
        hch@lst.de, gjoyce@ibm.com, wenxiong@linux.ibm.com
References: <20260321152823.3197870-1-nilay@linux.ibm.com>
 <20260321152823.3197870-7-nilay@linux.ibm.com>
 <8b123263-297b-43bb-b9ea-272a9dd419c5@flourine.local>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <8b123263-297b-43bb-b9ea-272a9dd419c5@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RoIPChgUKssQkKT6YqaFex72OoMSfb_8
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c2978a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=7i5DFV7xLQiez7lCif4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEwOSBTYWx0ZWRfX/+O38Zf+6wKs
 8binsUEBXv8lWKZFdQ4hi9BuCEUoZCjmh7/DUeyP8h0voRzW+zJtEMUIN+HY7Pzhy8PMaSyiOD5
 Y/PXAJ2wJILknL3u/f0NwA3kCmM/WURpQacAmO/pAC1eZKhmRgvbVY04cU6RBLlxDgQ0Echhcys
 Y1irPmdT7+mmE/8Hp3XTe95daWYRPljYgxUlOEu4bspbZ1rWMLbXBsNXrI3dSUK/T9qOT2NEn0U
 zh5i55P4HDTd8wx3vBg7EVVzv62Znhv07Afy2iuyF9un3gZjldUotretMAG5Zx+t5MprMrW1jOm
 333fwaJTR2HoaihN2PkTFGeKUZWx2zwUXMo1nLlj2E/KmYo/GhIub/Q3N1iVfKZX3iJK7jiMfx/
 dp7a+H0Kbd6FwLWIu9S2GXIIkoDqxdFbS4z1lEnqCOpd9r8aMx2XMlx7tLLrZoudy5gR0F/9CEu
 pF90g9sMDbRvb6Zd1tA==
X-Proofpoint-GUID: RoIPChgUKssQkKT6YqaFex72OoMSfb_8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240109
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260324_065421_807907_50215A82 
X-CRM114-Status: GOOD (  23.93  )
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

On 3/24/26 2:48 PM, Daniel Wagner wrote:
> On Sat, Mar 21, 2026 at 08:58:05PM +0530, Nilay Shroff wrote:
>> Add support for retrieving per-path diagnostic counters such as
>> command_retry_count, command_error_count, and multipath_failover_count.
>> These counters improve visibility into NVMe native multipath behavior
>> and can be useful for tools such as nvme-top to display real-time
>> statistics.
>>
>> Unlike other sysfs attributes, these counters can change dynamically.
>> Annotate them with "!accessors:none" and provide custom implementations
>> to always retrieve the latest (non-cached) values.
> 
> If I got this right, this and the next patches depend on
> 
>     https://lore.kernel.org/all/20260220175024.292898-1-nilay@linux.ibm.com
> 
Yes you're correct, I am just waiting for Keith's response on that thread here:
https://lore.kernel.org/all/0832f4dd-0ab6-4e11-a404-fdb18ca699b2@linux.ibm.com/

> Should we wait with interfaces here until they are ready? As we
> currently still in the development phase of nvme-cli 3 and thus the API
> is not stable, we can touch it again. In the past we also added support
> for kernel feature which weren't there yet. I don't mind too much, just
> asking what would be best here.
> 

I’m fine either way regarding when to introduce these interfaces.
Even if we include the diagnostic counter patches now, it won’t break
anything. If the corresponding sysfs attributes are not present, the
library will simply return 0 for those counters.

There are essentially two options,

1. Include the diagnostic counter patches now:
    In this case, nvme-cli/nvme-top can start using the libnvme APIs immediately.
    If the kernel does not yet expose these attributes, the counters will appear
    as zero in the dashboard. Once the kernel support lands, the correct values
    will automatically be reflected without requiring further changes to libnvme
    or nvme-cli (unless the sysfs layout changes).

2. Defer the diagnostic counter patches:
    In this case, the counters would be omitted from the nvme-top dashboard for now.
    Once kernel support is available, we would need to update nvme-top (and libnvme)
    to add them.

Given these options, I would lean towards option (1), but I’m happy to go with
your preference.

> The whole series looks pretty good, just my nitpicks and the question
> on exposing 'cur'/'this'.

I will address nitpick comments in next patchset, and I have provided the rationale
about why we need to expose 'cur'/'this' in an earlier reply.

Thanks,
--Nilay


