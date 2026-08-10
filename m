Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C628C5AD7B
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 17:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ALkbJ/TZtfWWZuEhsAI/vvk7MGxAgMK7rQfuDc7fgwY=; b=2mnWz6zHho9QYbLNutu1S3H5XB
	cxUkrZxifGH/08rhT7B5TWAHjzgkMvXGMBdaGnqc7JuXq2fJX+7RFDfq69waRxrdjmuiiQGYglWWw
	i+JBr8kgeFUMhUwwMLxnJBYPbQRzcES19s0kKboMzTmVqjfGxdWOShqrmobcTLTt9gpzUpvuL0QVB
	gfoKyppQU+WSgEeAbUgXaBpjWxx8gOdrgvTPhVg9ENc8Qf1u/xov1T85/CIQeg4UzNSfy5aakL+j/
	iRdCPGIQESXmMa0QPB3RTH11vtzff/2XLUM+Gr8iOjVPd6r/JWihtvypTOIRdbLS5T/Kxi0gdw61k
	BkXsCgpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtTkx-0000000CWEX-35by;
	Mon, 10 Aug 2026 17:25:47 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtTku-0000000CWAV-1e8E
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 17:25:45 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AGVnlJ2069928;
	Mon, 10 Aug 2026 17:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ALkbJ/
	TZtfWWZuEhsAI/vvk7MGxAgMK7rQfuDc7fgwY=; b=kHysSM9TjzfF6/PdvA/VD8
	AQfcWH7x0QS1CJwOP5de5vm4G9l+Ep9g2Ay/fJQr9zsOYA9vh0yBbYF+Mj4Mcw6j
	prJJiQW6MEJ8e/7ITBeETrkmz4jGD2YbeUodXE/yla8YYIarybj8A/KXrOlOezxk
	0Tp8HTN841z7NsvUfx3iZmjBuMxT7Oyk5hdimB7WCTR33gnm5x55j7tM+pk4qYIX
	w582dIGBHwDUrGjWwB9aRtJsHh/ujlJtXH0JrneiENHvf698TvXHTV+f/SfaQwQh
	mKzqZYJmbG89rZW9iSUiTy7+sYl/CompTEwFbfc0NkdP7kuFqc5eUFqKb1H4vA7A
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2rtyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 17:25:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AHBLUW014859;
	Mon, 10 Aug 2026 17:25:29 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjns9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 17:25:29 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AHPSwr26935924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 17:25:28 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3243C58059;
	Mon, 10 Aug 2026 17:25:28 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66E0E58058;
	Mon, 10 Aug 2026 17:25:23 +0000 (GMT)
Received: from [9.43.109.88] (unknown [9.43.109.88])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 17:25:23 +0000 (GMT)
Message-ID: <4e157ebe-7afd-45b9-9d35-f866b6f92097@linux.ibm.com>
Date: Mon, 10 Aug 2026 22:55:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/9] nvme-multipath: add support for latency I/O policy
To: John Garry <john.g.garry@oracle.com>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        gjoyce@linux.ibm.com
References: <20260809100825.2014133-1-nilay@linux.ibm.com>
 <20260809100825.2014133-5-nilay@linux.ibm.com>
 <2d0163f0-ecf3-4f59-9121-587f98eeb54c@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <2d0163f0-ecf3-4f59-9121-587f98eeb54c@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7a098a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=1xIkWWgTLhsQZ9xoJ6sA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: tqzgtmz8KwAJ1UEBDtN0xd_m0K68twnE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE0NiBTYWx0ZWRfX03YP1i+xW9Lk
 eQyxSAcpoBBx+lLo6l8iRPS3+kgLx9XsuyPIiNQK3/hMXEEf1e1WjF5eFDmdOOlxsDf+CA5vdSy
 PQdJhG5QJwevITKRlZgDxDgfwXjDPWNOcOzjQEJ20cvU138vuN04PSm5HCIJ9njnXOkd2JIL8+a
 cBwhdKxdrBoDL4836qsnWnDrufwXThIffEZ0URcLiXBvUFzugk/V4xW4RPh89oyVe310M0My4bp
 np7QNe7DtJZgyvLfkSKdFOAFiGEpdHOGtv/sPSzFZBbWWmb8Bb0icPXWLKRrGPPd1kX1ZSPx12A
 Fti83Lwnf1hd0pTxaIWIjXaQdEQ1o0cvC1XlLorKZw51ws2CaaP02Vu1C2zcFwmefNAhBLV9aGc
 G5efs5g2GTp39hni2cgUMS3OBn4Xn4G2BpSo5FQh3WwyfWJYz+JWMsUEyKdeAtQjvvo8ow+FI1Y
 db9f8GSJuC+Dc76DqrA==
X-Proofpoint-ORIG-GUID: y48Uf9HcHvCw3PnJO54kiluBfRtxLjgS
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE0NiBTYWx0ZWRfXzcE4AanL0ySe
 grOy0caP+JEHqg8ajApnCFWP0zd+/6D75iTaVqEOCBAVrCYXhqV6dZzLmBN81ziAn97lQ3OQRMk
 ZFx7lMuVGgU3e0JrG4pOWPUqf7Cb8TE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_04,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100146
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_102544_563554_FC945AE5 
X-CRM114-Status: GOOD (  18.88  )
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

On 8/10/26 1:42 PM, John Garry wrote:
> On 09/08/2026 11:07, Nilay Shroff wrote:
>> +    /*
>> +     * If latency > ~1s then ignore this sample to prevent EWMA from being
>> +     * skewed by pathological outliers (multi-second waits, controller
>> +     * timeouts etc.). This keeps path scores representative of normal
>> +     * performance and avoids instability from rare spikes. If such high
>> +     * latency is real, ANA state reporting or keep-alive error counters
>> +     * will mark the path unhealthy and remove it from the head node list,
>> +     * so we safely skip such sample here.
>> +     */
>> +    if (unlikely(latency > NSEC_PER_SEC)) {
>> +        stat->nr_ignored++;
>> +        dev_warn_ratelimited(ns->ctrl->device,
>> +            "ignoring sample with >1s latency (possible controller stall or timeout)\n");
>> +        return;
>> +    }
> 
> JFYI, I gave this series a spin and I see this warn a lot:
> 
> # ./fio_read.sh nvme1n1
> iops: (g=0): rw=read, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T)
> 4096B-4096B, ioengine=libaio, iodepth=100
> ...
> fio-3.38
> Starting 10 processes
> [  130.005374] nvme_mpath_add_sample: 29 callbacks suppressed03h:08m:36s]
> [  130.005387] nvme nvme2: ignoring sample with >1s latency (possible
> controller stall or timeout)
> [  130.009968] nvme nvme2: ignoring sample with >1s latency (possible
> controller stall or timeout)
> [  130.013176] nvme nvme2: ignoring sample with >1s latency (possible
> controller stall or timeout)
> [  130.019576] nvme nvme2: ignoring sample with >1s latency (possible
> controller stall or timeout)
> [  130.022275] nvme nvme2: ignoring sample with >1s latency (possible
> controller stall or timeout)
> [  130.024762] nvme nvme2: ignoring sample with >1s latency (possible
> controller stall or timeout)
> [  130.027268] nvme nvme2: ignoring sample with >1s latency (possible
> controller stall or timeout)
> [  130.130140] nvme nvme2: ignoring sample with >1s latency (possible
> controller stall or timeout)
> [  130.132316] nvme nvme2: ignoring sample with >1s latency (possible
> controller stall or timeout)
> [  130.139279] nvme nvme2: ignoring sample with >1s latency (possible
> controller stall or timeout)
> ^Cbs: 10 (f=10): [R(10)][0.4%][r=35.8MiB/s][r=9171 IOPS][eta 03h:07m:44s]
> fio: terminating on signal 2
> 
> iops: (groupid=0, jobs=10): err= 0: pid=821: Mon Aug 10 08:08:28 2026
>     read: IOPS=9239, BW=36.1MiB/s (37.8MB/s)(1434MiB/39744msec)
>       slat (usec): min=25, max=110836, avg=129.22, stdev=537.18
> 
> Note that I do have many heavy kernel debug options enabled, like kasan and kmemleak, which may influence this.
> 

Thanks for testing. Given that you're running with KASAN, kmemleak, and other
heavy debug options enabled, I think this is expected. Those configurations
can significantly increase I/O completion latency, causing some samples to
exceed the 1-second threshold. The warning is also rate-limited to avoid
flooding the log. That said, still if it's causing a lot of noise in the logs
then we could change it to dev_dbg_ratelimited() from dev_warn_ratelimited().

Thanks,
--Nilay


