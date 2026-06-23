Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1ACCDB46F
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2026 14:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i5QMhpagsL1hSIa8spNGIjmtjiarjF3XbgMPWmkWVl8=; b=VWDDwODhBr7DIKsPepYL8FP9Mu
	T7VWwHLDIFmeBwozyE73oxKlUxIYi/OP7Cmt3Tf6VIIxGdz/drLOVC08Hybnz4eWzmBWptEuo1yjy
	bJ5DRamXN2HVeG5DoiZHjueXn6UDYcD28xiujoe522ccl0HtWEYoVTbn5ipd6mxhh/+zYjmo0vREt
	IOOvttmH1Pu5cpkzkirlN6Z3n1gdVEFtcHsPyQ0XD+fna+kQmlWHy0gxlfMvVfTRG1D2ACCm8caRC
	c3uijtrKf1bIUBNd/GmJtSUAi/xqUxQvT5pGEO/6ajQ0WdoMszqw6hz7EDqYhnhlweaSzhrHX5a+l
	+v3xFEog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc1hc-00000006OZa-41pw;
	Tue, 23 Jun 2026 14:02:12 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc1ha-00000006OZA-05aq
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jun 2026 14:02:11 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmckn2136394;
	Tue, 23 Jun 2026 14:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=i5QMhp
	agsL1hSIa8spNGIjmtjiarjF3XbgMPWmkWVl8=; b=bkGXompDOi8USMeB7TMYZ1
	cB8diSNrk2vY3vnl/Rsqn/2hJisg7foi88YVySwTE9p7NyogJnDOI+MoxwUwhcwe
	MZmeksrgfIqtsYrkkvY9hbweQYcVuzM+VRKfPrggrg8xZ4PPEgrK6/m+GGGaMDJD
	81HY3HIt/5gkKrobJIC2+wb+UdgE0D1xdx8ryFdVS6xitP89JS4eZJuinV8wmb/a
	J3HxYVSM1lchVV5PwxsZehQsHdzvsJxBq1pgYRYrlaefoRquN5hUoT8cMVP29mmR
	FUuPiIX6gMB1ab9phSJtO7pP7Ae9RRMH/lQhs0nWmiXPfl3HowQgTDu5P71IBA+w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhqpu2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 14:01:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NDne6U015398;
	Tue, 23 Jun 2026 14:01:50 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66k3ju5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 14:01:50 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NE1oMQ52494656
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 14:01:50 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2592D58062;
	Tue, 23 Jun 2026 14:01:50 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A93258058;
	Tue, 23 Jun 2026 14:01:47 +0000 (GMT)
Received: from [9.43.75.139] (unknown [9.43.75.139])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 14:01:47 +0000 (GMT)
Message-ID: <1d4a2988-96e3-46a9-955e-a36cba41c7b3@linux.ibm.com>
Date: Tue, 23 Jun 2026 19:31:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-multipath: expose path_state via sysfs
To: Keith Busch <kbusch@kernel.org>, Guixin Liu <kanie@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        linux-nvme@lists.infradead.org
References: <20260622130318.2346995-1-kanie@linux.alibaba.com>
 <ajp9gHepQX-j1-Lz@kbusch-mbp>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ajp9gHepQX-j1-Lz@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3a91d0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=eBeaEUT2Rfq-W78KMvwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDExNCBTYWx0ZWRfX5iz1rdBNpB3P
 ImZJ5GL2+aDtJBfkHO+/OQMIU4FgFml33R2iw8kuiZIHNs41tIm66zY4gOaROBnvIyL8MvVUgvJ
 Pf1Lx6p8roJSxPePOhzedkoTUZYtyHK07D39qWIWS0stEpcsSwIjmDu3KPabHkmS/MDh8mvN6Ft
 a5v9ddniTN7YJo2dLmL6RJM24kF1KRTvcZKzfOredNHq7Z8YX+yNF0cTuqp5PU0Ke4rTsBjM7WL
 B4r9y0SrFhOZSdoagwjEDQw6USxlMNCeD982+zmZ29z/uQJ1+XrIeWF5mO7R0GUh8QYqXf8we7+
 gxQrumMPm+Tad7c5I1QqMVVBEmkpSNAJlL04PlLHrvDTEiLi4Z4BR+7VS0At5lyhJmzD/uEPBHO
 2j0CQWkP8BGMpBE2ba5FPTfrOxOGYBWf7hDbaynA0kqdX5tWQ8lmDa6+ER256muC3dNPdJihphx
 l+BOIqamua45sG/EZug==
X-Proofpoint-GUID: oJhORTg0KeiYA8jZ3uqUeI4gH2iS4Anm
X-Proofpoint-ORIG-GUID: 6sxDjZqGwbHYhJ46yXIZ5C9syNuwMm-Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDExNCBTYWx0ZWRfX/Dqzy4UjC1oN
 aA32fB0NQE7GdJa678PonjEa9x3Bh+FjKSVnb/ISgosqvGK4LcfK59cOWaAWQ9isVqiBqqS4gIb
 ovdrKyJ4iKTs0H4YgNrhLbEy8o0D/ok=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230114
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260623_070210_088522_00C92502 
X-CRM114-Status: GOOD (  14.40  )
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

On 6/23/26 6:05 PM, Keith Busch wrote:
> On Mon, Jun 22, 2026 at 09:03:18PM +0800, Guixin Liu wrote:
>> The attribute reflects the result of nvme_path_is_disabled() checks:
>>    - "enabled"                   : path is available for I/O
>>    - "disabled (ctrl_down)"      : controller is not live/deleting
>>    - "disabled (ana_pending)"    : ANA state change pending
>>    - "disabled (ns_not_ready)"   : namespace is not ready
> 
> I'm a bit late to looking at this, but just a knee jerk thought,
> wouldn't you want to distinguish "enabled optimized" vs "enabled
> unoptimized"?

This is a good idea. I think, we should consider reporting this.

Thanks,
--Nilay

