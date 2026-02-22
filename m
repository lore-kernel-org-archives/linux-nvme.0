Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBDAC636A0
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Feb 2026 15:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3pLZO2XxRbGi6S5b/IAgjH0Kp7SFWr/FmhyWvV6Gwwo=; b=TMpEDfWRD87EmE3Eodh1Oy0/nN
	pvv1HM87GU0pJliK42bWGWYRdMfFdyZAjqM1a0/eNha+i75sThMdkugjdXxM45eVhzhGSdbflossf
	A6UcC9IqC7RwwrObymRgRaiFt9cpCkw6D8vN3Mi8L2qSHXbfLDCeo+QUq7e2080p528KIZJYyH61E
	6zsnRjxZ10J0nb6jIU1h75f4gBoAoO6VwazpKbE8g06kioHZMIUj58KuO6pdttlU9Fkla2V3VSkXb
	7Q8IOqfyVpSI1VjZUbyGIpYpC8/vnc5v4Mu/WODxGY+Fz3YqaJsSKEjWC2/A81R3Jw1WSB9ueY1JF
	dp5ZrJHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuB37-0000000GlfF-3l8M;
	Sun, 22 Feb 2026 15:07:09 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuB35-0000000Gleu-1Ve1
	for linux-nvme@lists.infradead.org;
	Sun, 22 Feb 2026 15:07:08 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61M8UC0M1098719;
	Sun, 22 Feb 2026 15:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3pLZO2
	XxRbGi6S5b/IAgjH0Kp7SFWr/FmhyWvV6Gwwo=; b=bcOGINUHdE9BUA9Kw8M4aY
	myLAJmPuLE0N1JxSq1ccvpvCYSCHYh+XjHEHfqPJb5+ZKVX1z2yvpU9lQoZ+il4/
	vvSxOQfEXo0mu88Zp8QbDQeXk8ve6cz9pxPNG0nu/N7eyc4AOa3C2dkUHM/ZtWzn
	DAnIz2CCY8451inGRbSb3J6qZO2eQsYfQHPQwnzfxh+g5njExhNB6TaLCWQG7BAR
	nvox7kASFJzmNOExlfQSgre5n2oE2Zp+yzbBvqdcfzvsIjbDiSXgkuDEsWKFqz1M
	ZaRs8GrbSNM8PmyU3aX61G8lxeixHtFmQeATzSSgFVtxwtat0hQTia2+L/xMt6NQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4e34822-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Feb 2026 15:06:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61MA7ZTn004541;
	Sun, 22 Feb 2026 15:06:54 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfs8jhgry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Feb 2026 15:06:54 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61MF6rXi33030810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Feb 2026 15:06:53 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 137A65805D;
	Sun, 22 Feb 2026 15:06:53 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 899A55805C;
	Sun, 22 Feb 2026 15:06:49 +0000 (GMT)
Received: from [9.61.253.145] (unknown [9.61.253.145])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 22 Feb 2026 15:06:49 +0000 (GMT)
Message-ID: <5fa4ac53-0303-4c60-92da-04026e718417@linux.ibm.com>
Date: Sun, 22 Feb 2026 20:36:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 0/7] nvme: export additional diagnostic counters via
 sysfs
Content-Language: en-GB
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
        hch@lst.de, sagi@grimberg.me, hare@suse.de, dwagner@suse.de,
        wenxiong@linux.ibm.com, gjoyce@ibm.com
References: <20260220175024.292898-1-nilay@linux.ibm.com>
 <37EF3123-DD53-4280-8299-DF49868CFF8E@linux.ibm.com>
 <a5861e66-b1fd-4ef8-815f-d4655880a22e@linux.ibm.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <a5861e66-b1fd-4ef8-815f-d4655880a22e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XMs9iAhE c=1 sm=1 tr=0 ts=699b1b8f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=N06o56H0tzwM1UHp-ToA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8kNG06FgXwFiVbOsLT_795q9OhPU8kqN
X-Proofpoint-ORIG-GUID: 8kNG06FgXwFiVbOsLT_795q9OhPU8kqN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIyMDE0MiBTYWx0ZWRfX0OvZ/7TjoaHY
 CNB0lgoMO9bxOGtJ/Bd8+0I3JJAhJ73+DlUZ17BaO1jkPRH5s2EOYMYcupyF3ntoEDZDMBoIg7T
 Xqe2x85rtNYZheGMzAGNW9e7zPGfYESoMvRixln3gkhDUBvXpcwD18sKtMFz3LKjWFSdDyV38ny
 KyaXJ3w2Rzq162gTikEtE0QEAoLX5PCN5ckN8AFwryU8iKpSmuRbfh5t4TgbCc0lviHXI+FJ8vf
 X/aAOlAtatR6Q2dres4uZxevhSWsj7wSfhfOFd7m/WX0bW2vP9TWQmp2r9yfJY4aXWsbS+bZZLo
 dloit93GkB05k+XFM6Pt8j4SiLSUsx/T/FyEdfVjZ4mRiCY+/diMPvILllLid4M5L4jyTvbPBDk
 1bfd4gXtW6bbLQKG2Z3h5R5kkWbLKMMgI3AiY5uzsA8b8ZXUECXEea96y39eSevcu+q+dqzY+5q
 HomhydD9kvmX1+SmHdA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-22_03,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602220142
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260222_070707_440515_03BB9E02 
X-CRM114-Status: GOOD (  11.95  )
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


On 22/02/26 7:40 pm, Nilay Shroff wrote:
>
> On 2/22/26 6:06 PM, Venkat wrote:
>> Hello Nilay,
>>
>> I tested this patch series and found couple of attributes are missing.
>>
>> Missing diag counters:
>>
>> 1. I/O requeue count
>> 2. I/O failure count
> These counters are exported under head node. So you should be able
> to access it under here:
>
> # ll /sys/block/nvme3nX


Thanks Nilay, for pointing it to me. With this, all the counters are 
exposed.



Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


=== /sys/block/nvme4n1 ===
fail_no_available_path
requeue_no_usable_path

=== /sys/block/nvme4n10 ===
fail_no_available_path
requeue_no_usable_path

=== /sys/block/nvme4n2 ===
fail_no_available_path
requeue_no_usable_path

=== /sys/block/nvme4n3 ===
fail_no_available_path
requeue_no_usable_path

=== /sys/block/nvme4n4 ===
fail_no_available_path
requeue_no_usable_path

=== /sys/block/nvme4n5 ===
fail_no_available_path
requeue_no_usable_path

=== /sys/block/nvme4n6 ===
fail_no_available_path
requeue_no_usable_path

=== /sys/block/nvme4n7 ===
fail_no_available_path
requeue_no_usable_path

=== /sys/block/nvme4n8 ===
fail_no_available_path
requeue_no_usable_path

=== /sys/block/nvme4n9 ===
fail_no_available_path
requeue_no_usable_path


Regards,

Venkat.

>
> Thanks,
> --Nilay

