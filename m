Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEC1E99049
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Apr 2026 07:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xW5+18kbOsYw/bz44pcat1GAwh/u86zyWX234R3wHtU=; b=U0w+BEWlZsipztfRGT6lRY4eC6
	TqwkLI2cGSedgrqDUqASh/+ZKdInOh5nakcrFmtCsCodWZMYA6QtfOHlpoWWJlsZjuOohrYAZcMNR
	R7B1fKr5YVyNMaYdECILp7Ep0SqrqVC06gw2mI/lXlVe7lNfjehLXFzsSeOi29uyw+rycUrB8OzxF
	nVFRC/HcqoX4rIsvFJSDN0GYSGIeE/y1iaxwhk2tCUaI9GdNVwN2iLZ6ps2gZEilsn4tZvOv17Vkk
	f/4sW0jZM4ZrfUSps/tWC9HEtrVcczpept0QN9jcU2i0tr8nGddDNUN7kXGPmM6ETMd/Dt/ttH1Mp
	J0Crrrrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB6NH-0000000Bjt1-2oZO;
	Fri, 10 Apr 2026 07:33:55 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB6NE-0000000Bjsf-3odm
	for linux-nvme@lists.infradead.org;
	Fri, 10 Apr 2026 07:33:54 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639KgrT22326605;
	Fri, 10 Apr 2026 07:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xW5+18
	kbOsYw/bz44pcat1GAwh/u86zyWX234R3wHtU=; b=VbRim2xzdQaQlUuNWSVV6O
	dtBglOxrphRtYLGdWgWHdfahah+CfHkeNS7c6l9ZG0qgaIGdZ6qZQmX1qWycUdzv
	ps5TXD6spzAfxKpeo8j3MPDh2qgmpFWyh4QxeT00oSM1xqQ36QMDWSuOpuZ27ULF
	ssKlS3D31FVsISi5TLUGmkOMP2oOZGaHKYF/M+jum8ZSQff63m771Sc+Xt+5Vs66
	OciwPIROgHFSnEWJbE1x4icv8aUB4sDceUR3alQ4VzLn4H6jzjKxHsa0JRcPBsMd
	LPp60Sh+7k9f++cQu4O5Sa0BbBJ2Uf/WFBUJTWk0nBwsO3gjIk2G/RPKulFpjI2w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2kqshp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 07:33:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63A38j97026723;
	Fri, 10 Apr 2026 07:33:47 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg87039-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 07:33:47 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63A7Xj9o5177972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Apr 2026 07:33:45 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55FE458052;
	Fri, 10 Apr 2026 07:33:45 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 239A358045;
	Fri, 10 Apr 2026 07:33:42 +0000 (GMT)
Received: from [9.39.26.31] (unknown [9.39.26.31])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Apr 2026 07:33:41 +0000 (GMT)
Message-ID: <85a95cf8-1fa0-4651-9e6a-8d224e943813@linux.ibm.com>
Date: Fri, 10 Apr 2026 13:03:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 0/9] libnvme: add support for retrieving additional NVMe
 stat
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, hare@suse.com, kbusch@kernel.org,
        hch@lst.de, gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
References: <20260404101504.44539-1-nilay@linux.ibm.com>
 <19ca03c7-1bb3-4468-b1ad-4c44ea9b8c17@flourine.local>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <19ca03c7-1bb3-4468-b1ad-4c44ea9b8c17@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA2NiBTYWx0ZWRfX+qjJduTvWJNA
 tIDZpBTa29RqcRIpGhtwhkSCqHNSdlV9f6jgoEvh9Sv22wYdSAME1+CgxyB1B+dFQwU8Bh8l8F+
 Ohn5eYJG5ktoJ7RU5GrfGfdUq5Fv/VI9E/ifKDs0miWqbHt6wVOsfkaMW9hTMDFTzNZBy65fMYD
 LCsMsHxMuAAcJdBY+H5O3hUJfKUy0CiylB5I1WCFMqKwP6Vy6Lktqq00nF/b0/Twa4F2NR4tP7C
 gqbLYFpM5qMOlyDVGwvjvYe+NBt83bXnC8vrFcM3dKHJgbrEYNu9uCrsUvF5BBRD0ioF/2Ldsyp
 7z2f2LmgloUh7HQp7SoUOlj8Uv9sthFHcRnh2G9cdFMFF66Wz+PCDvNng6T7zLe9tm7fY01qwzI
 Z9EZYs8abIXzVDTuM3d9tcR+3nglvoaygU8wf30NWO2zsCxp6l4AlJ+j02R4T39HlLa6hx4Dgcb
 tiLcZ2trZQriqW4WVjA==
X-Proofpoint-ORIG-GUID: _e5EtIwQLR9BO1i3QVVcbZU0zzMYpAA_
X-Authority-Analysis: v=2.4 cv=e9k2j6p/ c=1 sm=1 tr=0 ts=69d8a7db cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=zN9tajhJtQVXsz0dkFUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _e5EtIwQLR9BO1i3QVVcbZU0zzMYpAA_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100066
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260410_003353_077996_59398CC7 
X-CRM114-Status: GOOD (  23.47  )
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

On 4/9/26 2:40 PM, Daniel Wagner wrote:
> Hi Nilay,
> 
> On Sat, Apr 04, 2026 at 03:44:50PM +0530, Nilay Shroff wrote:
>> Certain NVMe attributes and statistics can change dynamically at runtime.
>> However, the current libnvme implementation caches attribute values while
>> scanning and building the topology. Subsequent libnvme API calls return
>> these cached values.
>>
>> While this approach works well for one-shot nvme-cli commands, it is not
>> suitable for use cases that require upto date information. In particular,
>> real-time monitoring tools such as nvme-top require access to the latest
>> (non-cached) values of such attributes.
>>
>> To address this, this patchset introduces support for retrieving
>> non-cached values for selected attributes whose values may change
>> dynamically. The first three patches disable auto-generated accessors
>> for ana_state, numa_nodes, and iopolicy using "!accessors:none", and
>> provide custom implementations that always return the latest values.
>>
>> In addition, libnvme lacks support for retrieving gendisk statistics, which
>> provide useful insight into disk activity (e.g., number of I/Os processed,
>> time spent servicing I/O, and in-flight I/O counts). This patchset adds
>> support for retrieving gendisk I/O statistics for both per-path and namespace
>> gendisks.
>>
>> Finally, this series adds support for retrieving diagnostic counters at
>> different levels, including per-path, namespace, nshead, and controller.
>> These counters should improve visibility into NVMe native multipath behavior.
>>
>> All of the above statistics and counters can be leveraged by tools such as
>> nvme-top to provide real-time monitoring and analysis.
>>
>> As usual, feedback and suggestions are welcome!
> 
> Looks way better. Thanks!
> 
> Unfortunately, the big renaming of the API has happened, thus could I
> ask to rebase (and rename the symbols accordingly)?
> 
Yes sure, I will rebase the code and spin a new revision.

> One thing I notices, is the first set of statistic getters have the
> 'bool diffstat' argument, the second one not. To make this a bit more
> consistent I'd say it would be great to have it on all functions. WDYT?
> 
The diffstat value is only set during the refresh/update phase (i.e.,
nvme_ns_update_stat() or nvme_path_update_stat()). These refresh APIs
take the diffstat argument so that the caller can specify whether they
want absolute statistics or differential statistics for getters.

In practice, the caller indicates this preference at refresh time—for
example: nvme_path_update_stat(p, diffstat);

After that, the getter APIs rely on the state established during the refresh.
Based on the diffstat setting, they will either:
- return the current absolute values, or
- compute and return the difference between the current and previous statistics.

For example, the following getters:
- nvme_path_get_io_ticks
- nvme_path_get_read_ticks
- nvme_path_get_write_ticks
- nvme_path_get_read_ios
- nvme_path_get_write_ios
- nvme_path_get_read_sectors
- nvme_path_get_write_sectors

Will return differential values if diffstat was set to true during the refresh.
Otherwise, they return absolute values. Does this make sense?

Thanks,
--Nilay

