Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2319BC43458
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jul 2026 06:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TVmMUKAkHguF6YoTzmii7E3P+QgsTFF1WvG+WiGjqt4=; b=R48gNUhtKTkQNcoCh1T/onQThk
	f9ANxbeUY7T0QVjAQmamGjFCJIS3e2T0/aY8N+gnABJfYsyfZjVsMgKx5PAZzw4wl5PbdFmst3yqF
	6WTAYDlmeyYJ9EiWvOK481bJ71ZYtLWKkbQtT+Kp31zeJ4AA0VZSJkdIv92VI75bviApPNe8Vn+Zy
	33KyV+l1vvUn5vbw3sROt+bZVw2Rkxxsor9FsEycDiXfZ2JaW/tx8wDHd86EOcjh39/qYSxquX/Ih
	k3hxP+XEbaFDc0NTeg6BnnKT6c01VrYgtNhWmehrDlqYi2K1xoKS0Kpg4VHL2YCvZKsTFsrv3y+N1
	7gADWdvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfXgF-00000006CJ1-3kEt;
	Fri, 03 Jul 2026 06:47:19 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfXgB-00000006CIW-1yAt
	for linux-nvme@lists.infradead.org;
	Fri, 03 Jul 2026 06:47:16 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6636IWda1761314;
	Fri, 3 Jul 2026 06:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TVmMUK
	AkHguF6YoTzmii7E3P+QgsTFF1WvG+WiGjqt4=; b=kZR6ihWmarau8OxbpKMdEh
	UQsYGaV8QzjOSSO7WIj2BMCn0Z6ychDnkfuRUVSN988CNpKefG2sizaeaZu6/VIS
	G0/v/ao1OtlCVMEpPYN4e938QNflmJSkrvib1O9RzFlWIDYzgixKAYUwpqZ7JZKa
	63XLOFlXqgyjx+RMgalrRrdG3YbG7REty4eJA70MCAZZdBHmEnH3kZ7RNW/+2pzV
	oDo3JVhxv5iKH70uEdx6HWBRoWP4tH5jZHOFIvB7RAGG3nlsbnAM1uv5uF2JGMxS
	ZYmZSpWXzlO5ouWnqM7IPqXsyKjS6zG9SA5ICWqUvNe1OORgmI6PIiIbKzRDyXLg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mk5cmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 06:47:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6636YgdK001791;
	Fri, 3 Jul 2026 06:47:02 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhqhe8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 06:47:02 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6636kRXd20972036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jul 2026 06:46:27 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E31D258058;
	Fri,  3 Jul 2026 06:47:00 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF55558059;
	Fri,  3 Jul 2026 06:46:55 +0000 (GMT)
Received: from [9.43.125.166] (unknown [9.43.125.166])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Jul 2026 06:46:55 +0000 (GMT)
Message-ID: <f4b989ed-f661-4048-97e6-49989a1419e0@linux.ibm.com>
Date: Fri, 3 Jul 2026 12:16:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 6/8] nvme: export I/O failure count when no path is
 available via sysfs
To: John Garry <john.g.garry@oracle.com>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com,
        venkat88@linux.ibm.com, gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
References: <20260516183709.269937-1-nilay@linux.ibm.com>
 <20260516183709.269937-7-nilay@linux.ibm.com>
 <3bfd53f3-16b7-4585-b528-6745ee64e980@oracle.com>
 <54c163fa-91a1-4535-aded-4beee698591a@linux.ibm.com>
 <6cbf1ed3-9637-4c8e-a4f6-84a762161556@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <6cbf1ed3-9637-4c8e-a4f6-84a762161556@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA1OCBTYWx0ZWRfX+EGmU6VtF8ic
 U2aTisbrzD34fdlGXRTZsBc97ITiVWSejHaqSbL0xCGRGLAI6NC+7do+WlV8sbTTFO+dTgOJJIp
 3hsrbr1BM9WdhHGwwwaVOJU8eWCn++1SctQxmw3dB5V+rCBeOFhZz+boeVEWPLNQFhEl7vpuunc
 +qjFDlCaYUCYlWWcmlow1bK6zNfxOyhKBrnrQavrH6Nv+Tf1Hri8NBzf5KmkQvd8Y4G8aaKoR2A
 z3MYZt+8xplgTI7BCYNl9PmhdOs4Z/hqH8mor5gwFBYp4FNgfLS24g1TqRbs444kQxMT86eLFm7
 V3TYYJB977e9rrhs50DLbirNxvTKkRrLEkvhxpego5LI3axcsvdvkLeoip/pjvfAqldqY7QeXAO
 v+KXD/JCA23FoxgB+9ZBItbrn5IFmpGRTN+xS72hGMtu9HQRvPkIpvD1QDDoHgztT0txymvGiMb
 pI/BraRQw+Y75VrTWbw==
X-Proofpoint-GUID: l_jeYOvgZ_BIpKvr0yO4miqwFVm3CU6p
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a475ae6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=sWKEhP36mHoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22
 a=ZeNCurENlnX7_RCBNXEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA1OCBTYWx0ZWRfX/hqjbIOC/O+m
 G1/8s7q++01igg7ezplWXz6mNC8X/qvoOI/hjvyFlKy/swqg4IHMkPjxY/HYk6Ip7KXy6fNLdPk
 iUG+Qo1F/tR333M+LIiyXnoBVA0kkcA=
X-Proofpoint-ORIG-GUID: l_jeYOvgZ_BIpKvr0yO4miqwFVm3CU6p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030058
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_234715_626522_1DA37345 
X-CRM114-Status: GOOD (  17.53  )
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

On 7/2/26 8:18 PM, John Garry wrote:
> On 02/07/2026 14:10, Nilay Shroff wrote:
>>
>> The primary purpose of this attribute is to aid debugging. Under normal
>> operation, the counter is expected to be zero most of the time because
>> the namespace head is short-lived after all paths are removed. However,
>> if there is a subtle bug in the namespace head reference counting logic
>> that prevents it from being deleted, a non-zero value would remain
>> visible under:
>>
>> /sys/block/<nshead-dev>/diag/io_fail_no_available_path_count
>>
>> And yes this attribute is writable (as all other diag attributes), only
>> to allow users to reset the counter to zero and then observe subsequent
>> events.
> 
> It's something minor, but it makes sense to me that we only allow users to reset the value to zero, like:
> 
> @@ -1249,7 +1249,7 @@ static ssize_t
> io_fail_no_available_path_count_store(struct device *dev,
>          struct nvme_ns_head *head = disk->private_data;
> 
>          err = kstrtoul(buf, 0, &fail_cnt);
> -       if (err)
> +       if (err || fail_cnt)
>                  return -EINVAL;
> 
>          atomic_long_set(&head->io_fail_no_available_path_count, fail_cnt);
> 

Yes practically, I think no one would want to set these
counters value to anything but zero. So I'm okay with
the above change.

Thanks,
--Nilay

