Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88034C43458
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jul 2026 08:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RxWH21QQiYPfjn/BXrqhXLmNZxbu1oTypd8/l5wuzIY=; b=QMbbOZDnJJ4SShmrup6Khg7VBi
	XvBI50oWvokkdCkSpxCpmjGyG4RA3xVhP7+1V7eCnmt/tobaQi3rgmxqBvxneYnQ5I29ZkmWvtokK
	wsWDf1chl2pmIPTSjAuimZAo1pO17V3vJhvzmVF6k/jNnyzaxNJlFnMhRKUAo6u/GgG0JZN8wsJvT
	qacvXu/BfNrJIaWlN5mKgytPtxcEUjAFhorEoIOvm15oNV+2Hi/sCd7R9x3LBMlvGBqqjFcg7NQ8U
	F1HheXKU1GKFnW//Q5CFgRWqe/9wO+O5IXob655n5tcwOlU0WLt9KZIjS6BV8vaEw29Ixwrjvsyk5
	5Bt0kIGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi6DC-00000004PZc-0c4L;
	Fri, 10 Jul 2026 08:03:54 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi6D9-00000004PYY-3Ldo
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jul 2026 08:03:52 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7mbFv605544;
	Fri, 10 Jul 2026 08:03:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RxWH21
	QQiYPfjn/BXrqhXLmNZxbu1oTypd8/l5wuzIY=; b=AeTeyoE+jWgUmwIFoc0UDI
	DMAwyIBfbGDHaU5sr0AGpvFVYUBaMm8tRex0Rrd6B+6UsSZYHI0FSSJ9IA247rPr
	4JUspPO3oDvxDQZ99YmYiNgcvZ5Y1zLLv7JXWgyQck9vMyNV2r2VXCbX6ZW2OO6f
	1zki/uWsxR38BOcd+YLrAAaFelcDRiSaupl/d73AhtoA8ONCeGvdeN1ayZOMk4wi
	lWwbRjdEpoYCKyim3pVEmAMAyS0p7T7b7W4n1DcRp7DXKhh73F0i4cQVQo9W+0JU
	H00Uct0gbIHTgfNCXy8vlG3Oz//9HvvQWMcmrxBC4Zd6ki/sahNiYeJqfG+R3bcg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknw1e2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 08:03:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66A7o4Lx025133;
	Fri, 10 Jul 2026 08:03:42 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqgguen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 08:03:42 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66A83flY55968154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 08:03:41 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A8135805F;
	Fri, 10 Jul 2026 08:03:41 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 596215805A;
	Fri, 10 Jul 2026 08:03:37 +0000 (GMT)
Received: from [9.43.90.92] (unknown [9.43.90.92])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jul 2026 08:03:37 +0000 (GMT)
Message-ID: <692bc5a1-45d0-4406-9694-9f58cc184a8c@linux.ibm.com>
Date: Fri, 10 Jul 2026 13:33:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/18] nvme: add context annotations for
 nvme_queue::sq_lock
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        elver@google.com, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, gjoyce@linux.ibm.com
References: <20260706141452.3008233-1-nilay@linux.ibm.com>
 <20260706141452.3008233-13-nilay@linux.ibm.com>
 <20260709063214.GF18056@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260709063214.GF18056@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a50a75f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=vE7gBlHlhecNIzUQAzgA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: xK_jCbt-va-G2C9sjr3XPmQNSPuKj3X6
X-Proofpoint-ORIG-GUID: tX7hDpQiZq0ZPipcpbJY7YQtAHxaktlK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA3NCBTYWx0ZWRfXy8MMBUhAmiYM
 QbDLsFtjCoAuLlVlXwR9osQcY3nHYXLdMI7AtJoY2w8WRx0xDCtEelwmGFuCBxZyiEV7TTEAscZ
 mPN7FN0mWJY1DpVe52Piz8Lj+1Jyujc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA3NCBTYWx0ZWRfX8RJOIZ5wtsy4
 5Z9GeOuzdOucMthKsOF+Bh/rso6mqYMWbzKUTrjVa9DnRzEAX5QhDV1vJBH8nkwIvOr0h2PbDFJ
 tEUAuU0T7oex5CQyw4ODEiHOWlUbow0XR6LAbn7l8ni6OXA+NO87/NHUfULc34GBoS/xy96Nkc1
 hLoEK5Q0XRts65kPOMnGAlSOv7ez7HB3FiOTmBUJCX/2TzW2zAVcNUKY8r1VTgEdrR8bhUGh4OU
 lDqmK+TvjtsyzHZ6Nt/3jmW/E+KeuiPPUGDi+wQ+jiP8R5zHkqDJ3vjCw+2dG08/G37N6ofB5xA
 ITi0Mq7lvvMfNBhjMsIA5qx8r9iCwThwURRxITwKFVNyxO+3Kuv0A1H2hXbmhVqblagRBFIjQ7n
 q/mQ1ANxIclJ9m/IsQYigJGJtcJoklSEjSXTOsA1nrXU52JXgN+cGNhxG6Rpp/L+z65aJ8RmCbt
 ilgNINT+BqMjAw2JVOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100074
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260710_010351_953961_C1EE184A 
X-CRM114-Status: GOOD (  14.43  )
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

On 7/9/26 12:02 PM, Christoph Hellwig wrote:
> On Mon, Jul 06, 2026 at 07:44:14PM +0530, Nilay Shroff wrote:
>> +	/* Initialize unpublished lock-guarded variables. */
>> +	context_unsafe(
>> +		nvmeq->sq_tail = 0;
>> +		nvmeq->last_sq_tail = 0;
>> +	);
> 
> We'll still need to find a way to avoid this mess..
> 
Okay so then I think lets annotate init function using
__context_unsafe and remove the initialization of variable
from within context_unsafe(...) statement expression.

Thanks,
--Nilay

