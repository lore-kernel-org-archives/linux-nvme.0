Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8BAC43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 08:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/q008JfUkpmx6O08E1rBSokT8TpQZlmACNyQ56rSsKY=; b=zKNQ9vtG1zLMLt4/xgvX5RKxyI
	qqy42bBjKc3IeRlxjlufS38M+SNVjj9kRRLdreZJi916OKPyXYLOqS0cGV6I7DBwDVt7hCCg4ZV4k
	zhyCwLtfxcghJVf63m/393sTZo2oComJk8kOrr+EwNNv9XPQBm275b432pgUwCwyCte8M4tLMCxhp
	3UAmBfQMNkmNahGGoK4JswZVI+Kl8OZYk/t2tMToL5yNteXrHkGYhJnnsn6wBiMHqcWtQW0fVPrel
	/Yre4wME1iaQUtO8Q373IH6qQV+Mstlt1w1zzr4SpEjPbzyNt64lvD42roAZzMmuFhlZA7R0Rp9SJ
	kqnNUeow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgest-0000000BrGn-2QLN;
	Mon, 06 Jul 2026 08:40:59 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgesq-0000000BrFm-443s
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 08:40:58 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665MJ5HJ2200370;
	Mon, 6 Jul 2026 08:40:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/q008J
	fUkpmx6O08E1rBSokT8TpQZlmACNyQ56rSsKY=; b=czSOdZYGSqFUnzHiJWZ8xV
	99k8jADoEZlLwJxRK3+5iQuA/P0Ig3+VJ087NXu38csoO1dUFeVN2FEtviBQw2zn
	Fg+bp4n6k4UXx98XKK9syG934JmvZoKR+SUrd5bC//Jgy2ShBSlQvhY+ke/NSN6h
	21RS9Ij1TadVgRabAELST3qUBngj7B1kRkHEikPUU8yoiA8c37oq+NHiw7nBINFv
	QswyYRRxEVMpuCZ+DqBi2aOOTHoS6fIR+d/RXTKnggbLLAmqdo4OHy5EXEGGzvNH
	FYMMlL6dFZ1jH8ciLxUhDGWLu6cykKPSRb5XIMmJjgLvxWxYNXLYxfU72dt+SlMQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4gfxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:40:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668YaNt022694;
	Mon, 6 Jul 2026 08:40:37 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqfvj1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:40:37 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6668eaHK62325100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 08:40:37 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF50D58058;
	Mon,  6 Jul 2026 08:40:36 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 302D55805B;
	Mon,  6 Jul 2026 08:40:33 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 08:40:32 +0000 (GMT)
Message-ID: <e03c8f93-56c8-4abd-bb27-578b46ea76fe@linux.ibm.com>
Date: Mon, 6 Jul 2026 14:10:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] nvmet: add ABI documentation for target configfs
 interfaces
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        John Garry <john.g.garry@oracle.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, xlpang@linux.alibaba.com,
        oliver.yang@linux.alibaba.com
References: <20260706023439.3054578-1-kanie@linux.alibaba.com>
 <20260706023439.3054578-3-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260706023439.3054578-3-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 263aIFasXVnVEAH5WAABAv23WBB_BTC_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfX1HQULa9OY0bC
 vQqoBdLheA2ro+vwQW396qmWm4UFCqhPivkwS+H6K9boqOwYahROUhSq8TFJf0A8JmkRV118e9O
 ZAQd+6bpOcYqahtZUPKpzovMgh3n/00mfMW6iI/+/76B3r8uOh5AKbAk4luAJAmJP4EryNgfkzI
 PHPh32sVzJbVbp3LXBp5RIl/hHkB6/k4O13UziynQ0gKz5yUAkjWoG/UfzV3bGuSL//IdY82Gll
 bjc6pwNLZNZ0z3qS2MyM/fj+tLxAGcooTr6bD3IhGFoKX3sgGtrVCp18lC0eQw+REjvkEid4cts
 v4TggvsRvKZw1DRIcucPHUX5xSgYcTrOhVeOn/gGLQO6OLzAQg52qPgMYDoL2mDFLTjRRyMqqm8
 0kkCq4b88a8aPQnSN5QSq7xHwSFaxpjrAt7UFGFa1lF25ojGfjHHixWroF7NdOD4xcgcH3/7xLa
 0vNsbZNF/SLz5EwZUIw==
X-Proofpoint-ORIG-GUID: yorgNzKihAJHXxi4VeOdeLomFCx00wU9
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4b6a06 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=SRrdq9N9AAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=njU50y270ML1EI6xftcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfX7+fC7cnQl2az
 OxV/J8qPmRkybxfh+52rpu9cL+Bm9EGlSvpH7rFzOa/uK2LAvu6mBuU16EpODC3kkledGXDWDBB
 TAiL7fURGf+p+IeL/rZKSJX4AuFB/sU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060083
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_014057_016482_CF9B8BCA 
X-CRM114-Status: GOOD (  10.87  )
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

On 7/6/26 8:04 AM, Guixin Liu wrote:
> Add Documentation/ABI/testing/configfs-nvmet documenting all NVMe
> target configfs attributes, covering port attributes, subsystem
> attributes, namespace attributes, host authentication, passthrough
> mode, and ANA configuration.
> 
> Each entry has been traced to its original introducing commit to
> provide accurate Date, KernelVersion, and Contact information.
> 
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>
> Reviewed-by: Hannes Reinecke<hare@kernel.org>

Looks good to me.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

