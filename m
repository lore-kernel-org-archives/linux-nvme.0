Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E382F99340
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2026 07:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U/BBhYEhzgP93w8N4i9mKrhKCMuJ6h3LXwyV6rHuUn8=; b=mWN+dtR974yKF7huW72I3MXBCX
	BogVOlPIr0tx0+11omOo/FSJqw6t33G84sVKSgVWwTEs2sr4CbmtP9uOJYJ00J69hSp7WW3B/Hzp0
	RAe5LSrmgcNj+//B0f5bGgYE4H/BsZhTX+liSzWw6zaCdGsHTsxHPVyliW5poJvL3tMvt1rVuafeD
	4AymVR0UknN4S8T/EMZxgCCxjVhkXLqabJdbEAjbxQp9twiHGX/LCaCpbISKLcaaK9dv1fmetX2DL
	UrzNKfOHxPTOe2wYEWpiazZcjg0Qp/kcJpxEH7vyOgH2ypd6MtlN1Jjp9x7adpKPXZIvvf/QsW9vp
	JBWV/95g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFoji-0000000BAqb-3gAT;
	Thu, 23 Apr 2026 07:44:34 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFojg-0000000BAZk-2MNt
	for linux-nvme@lists.infradead.org;
	Thu, 23 Apr 2026 07:44:33 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MGMbnB3292279;
	Thu, 23 Apr 2026 07:42:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=U/BBhY
	EhzgP93w8N4i9mKrhKCMuJ6h3LXwyV6rHuUn8=; b=lcsA4oKc+abmBw0rdkeRrc
	EC7YsDgdAeY840RUCnP5yaE73vAM7e0du2/trwcqDj5/CQNBzPQ6L4jzyTxvmWYq
	uK/sh1Hi0f0qJHLA8bBdaBM6JCuqVgIkTpGXHax/JKvXitiStMqSFcE6Xji+kCnM
	VyEi4l4LuXbP2EeJszbA3+PiNrd3DGyOqXHJcJKsCrVj9wBHbKHktH75a7Lif0pt
	jq7ln/f5HNkxSmvH2VwQyc0NBVssEua9K6rTcXp8qQdjHkySqhGLKBVgtBnoE8M1
	YsbdP6Mn4MY2ESzFAp4WJzSYcQAe/qMgmD7Jmkgab/FGHFXD42KNJ0rVzEpD/WPw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dphfrex0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 07:42:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63N7ZONF024145;
	Thu, 23 Apr 2026 07:42:26 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjky5q0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 07:42:26 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63N7gP5D27460236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 07:42:25 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2299858054;
	Thu, 23 Apr 2026 07:42:25 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58CEA5805A;
	Thu, 23 Apr 2026 07:42:22 +0000 (GMT)
Received: from [9.124.217.242] (unknown [9.124.217.242])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Apr 2026 07:42:21 +0000 (GMT)
Message-ID: <480960f4-0a75-4a3e-886f-78f193508412@linux.ibm.com>
Date: Thu, 23 Apr 2026 13:12:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 0/9] libnvme: add support for retrieving additional NVMe
 stat
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, hare@suse.com, kbusch@kernel.org,
        hch@lst.de, gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
References: <20260421145038.3458987-1-nilay@linux.ibm.com>
 <1c081dc2-6b1e-45b4-ab3a-81decf431949@flourine.local>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <1c081dc2-6b1e-45b4-ab3a-81decf431949@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: a6GhabhS1ZWFAV8YzW1uzENMipPca0qA
X-Proofpoint-ORIG-GUID: a6GhabhS1ZWFAV8YzW1uzENMipPca0qA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDA2OCBTYWx0ZWRfX5UQ2TIt6gFmG
 9Gb1npD/UV0aUSmF324XMmmtFbn0Qifa1HvadAi1zUXFPp4D+4SDrMdkl6J9lZYf0NFsE6Wbl2u
 BUhHCgoJMITo8ZyA6w08Ai7b0cws70z7J/AHhVMIH2HQZvchVoe2MO2CFSAP1hyWaPHtcGPJtYQ
 xZy3fYRbHeMXhqbGYS0Hr3erGKgbgpZSb9DG3VFkGpdn30KUV1e3b5V8zDQglRJB55oftbqZrvT
 B7rPb+IlQb7e3R4MQeCtGIoQhNWjp8GFaNWqE4jbepFc8EjoUUw0lFjg6RRgpoPFtMr0YOg/jRt
 2cpxJMoKVyBWGYZWmrvqgokt1QonMLzAbgjIHYZ9xGQ2AtDeqzFsoTW7NCchFaccc+B1AzVD2n7
 0gmilJQqj+Xnw8FqDIdnTim8wRgU2AnYM2fIbZ5PueNR4Q/IwJ8TBpL6YkM5D9DvoE+sbkEoyfx
 ghw4JJmgNgMx87074Cg==
X-Authority-Analysis: v=2.4 cv=SJxykuvH c=1 sm=1 tr=0 ts=69e9cd63 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=T1zNt_XibDGkKeL9SyoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230068
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_004432_613019_20A77FD1 
X-CRM114-Status: GOOD (  16.60  )
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

On 4/22/26 2:21 PM, Daniel Wagner wrote:
> On Tue, Apr 21, 2026 at 08:20:21PM +0530, Nilay Shroff wrote:
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
> I went ahead and applied them. I did some cosmetic formatting changes
> for the accessors generator comment and added the manually written
> getters to the python binding define table.
> 
> This should unblock your work on 'nvme monitor'
> 
Thanks Daniel! I'll now work on nvme monitor dashboard.

Thanks,
--Nilay


