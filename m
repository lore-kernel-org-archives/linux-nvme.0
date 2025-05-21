Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DEBC2D0CD
	for <linux-nvme@archiver.kernel.org>; Wed, 21 May 2025 15:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CykUaHHiZoLO4CQZzFMQm7+4pA7vOPJvJJ5fg2eQ6W8=; b=FIZ7xP3PeeTVHWDwaYZLMLeQkV
	aP51Y4qw2b5PtdNhfkYfkF4lQgRQHY9OF/y8VLCMcQ74QSQ+bip9MncoTQwo+VgsNEE7Sdrmpem3t
	aRn+jJEGff8xMbZcD15uiR43soZ/LBcanTyCTHrX5xPrzL2/ERZmMU5vFdh0yag+/RlCDPqJsd4ge
	gSJSeiDDAGZLxhv5wNPziaFv+XoPmVQqcHPjbRuTa06TZycFUXpZJWpfrHoJ7LYI+mcEeWvdPmipN
	fCs1wDCUkuEZB2A7iplAqWhI6q4yba5XUl48dqaCaQnKAJRaB7M1hfajmDMqvmAkMpjwYnnghPCRV
	Besz+yLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHkwd-0000000GCck-3yND;
	Wed, 21 May 2025 15:01:23 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHktx-0000000GC3p-2cBh
	for linux-nvme@lists.infradead.org;
	Wed, 21 May 2025 14:58:39 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LEViSs003099;
	Wed, 21 May 2025 14:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CykUaH
	HiZoLO4CQZzFMQm7+4pA7vOPJvJJ5fg2eQ6W8=; b=JcSjfQraKIVlMPy6ALeDnA
	90mO9vJP2Abc89gSgxP3Dhwz74GiW2VZUDSv33L/EnAHSIuWUH5c1wq04XE5Dvu/
	7yheRA6EJifFsmfMdYXuHr2GE/SoCXtbyoCiZ0BOPmeoB+PqbZwigSqQj8uft9ku
	8flj6UnoVKcFHns65M4UxmYBnTfueqwQU4UcThGmqMsFm6I7hrndRg7m/gUkF8ZI
	F2s5iWexxnsIuXoZSGQfjxoFjVdqKdhd/6rI218YyYYYtP7a0YAlk54cwthB6fGT
	3x+R0VSBZuk/YsE1X/rASbuz4zgJYqMFuEcxFn1eotBfE3PcwPLHwJSQczfaLBnw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46s9estf5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 14:58:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54LDPDKu032024;
	Wed, 21 May 2025 14:58:25 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46rwmq4prh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 14:58:25 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54LEwOxv61276660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 14:58:24 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 944D558058;
	Wed, 21 May 2025 14:58:24 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89F1A58059;
	Wed, 21 May 2025 14:58:21 +0000 (GMT)
Received: from [9.67.3.11] (unknown [9.67.3.11])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 May 2025 14:58:21 +0000 (GMT)
Message-ID: <81fc81da-c379-4449-8ef4-ba2ac62ada95@linux.ibm.com>
Date: Wed, 21 May 2025 20:28:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: avoid creating multipath sysfs group under
 namespace path devices
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, hare@suse.de, kbusch@kernel.org,
        sagi@grimberg.me, dwagner@suse.de, gjoyce@ibm.com
References: <20250521124137.99939-1-nilay@linux.ibm.com>
 <20250521124851.GA30983@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250521124851.GA30983@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDE0MiBTYWx0ZWRfX88l8XALiz10B J3kdDUxH1FvUUG//tQYC4Pg9uJEM9JlZZg1tC9U+ZyLnB4Za55O3swD2TUpRy+qvQrIsbTSc5Uc +/Q1Np4LK4K+AU3f+WzypMrsdBm7oatSCIGqFGV0uv0ahhiGWoUiOj3/QqAyalMYNdAxcTnNMCP
 d9FQQMPJ4XNRXF9D9Sx6BL/CCmOr937KD1Q5xsQ6bfciaR9SqsMqQSp9H29fVcipdeAtIEZdawK /q3YvJlZsQLK52Ps+woSEVFH3IMIBHlS42tbI9frKRtEdXy/oChFnuB1/4qpFkVwIjB8X7UmzXZ lSgO17AF7YZXUuqisDxnBuZ+ihPDMjpRfo8lj1nmOD9oYuwyZUDKAMFpMvLm+vWQB8AUFYYbyTP
 LCT3mCKLsU3zgxLPT8UHIyXc2mSnt2rWwdbFlme81NvPR4UCHrnI4mXdjqOb4cLNXMCUz06n
X-Proofpoint-ORIG-GUID: P4zybsxQBv8wzf95uLUIFw2R3IbcMgGV
X-Proofpoint-GUID: P4zybsxQBv8wzf95uLUIFw2R3IbcMgGV
X-Authority-Analysis: v=2.4 cv=PsWTbxM3 c=1 sm=1 tr=0 ts=682dea12 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=6gFztdfKP3dsfUBlnJgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=686
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210142
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250521_075838_019059_C954F3F2 
X-CRM114-Status: GOOD (  18.07  )
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



On 5/21/25 6:18 PM, Christoph Hellwig wrote:
> On Wed, May 21, 2025 at 06:11:23PM +0530, Nilay Shroff wrote:
>> The multipath sysfs group should only be exposed through the namespace
>> head gendisk node. This is sufficient, as the head device already
>> provides symbolic links to the individual namespace paths it manages.
>>
>> This patch fixes the issue by preventing the creation of the multipath
>> sysfs group under namespace path devices, ensuring it only appears under
>> the head disk node.
> 
> Yeah.  Looks like we should still try to rush this into 6.15?  I'll
> tentatively queued it up because the pull request needs to got to
> Jens tomorrow for that.  Any expedited reviews would be appreciated.
> 
Yeah it'd be good if we can push this one into 6.15. 

>> +static struct attribute dummy_attr = {
>> +		.name = "dummy",
>> +};
> 
> The double tab here looks wrong.  I'll fix it up.
> 
Thanks!

--Nilay


