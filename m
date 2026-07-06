Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D052FC43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 08:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TJBuyjjp8BJWs8ClKNhlOD+uuiNIOO9llCuxRxYlWfw=; b=3z65+HbefkHxkjRiK012wzwfAW
	fnzHhtHkpE3LE5hrsYt0PPToP3wnbvDHag8q3WECoj1Y+uy/mjVPw4HfsEcNUF6vY9+LN9fUq3erJ
	CWkm6FBaMclgVT7gqtQPXxU0EysQ/UbZ6TCRNjfoJkAZbCckLKevmmREHiYsMIt6gpGG3smxh7OZX
	y3yQsYGeAoQpc06rT1utNmMzX+ZdVF8qP75jop8CVWhOqDQwAnERKn1kKSxqaMRbnl634bgjzDZ5o
	OCjmJpajORiSsFAaIBhrtYQzMe5YZ6jd6Yklm8AACWoEvLG748GAjQeQbr1FIPZ/cZUTFI7cQUrzh
	FAK7dsZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgets-0000000BrTK-2mTA;
	Mon, 06 Jul 2026 08:42:00 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgetk-0000000BrRX-1yQp
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 08:41:53 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665MIaMQ2198388;
	Mon, 6 Jul 2026 08:41:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TJBuyj
	jp8BJWs8ClKNhlOD+uuiNIOO9llCuxRxYlWfw=; b=SwM9lCk2VOLThSyAoDRXK9
	gZryEqBMBlTixCGa5Qw56BPzZcMilk2kNa8bUPB7kONw2rYvlydA03fOh/QB7ZWf
	IDZWLOV1GzCMFsCfkBgCnMWbzwMN9O9QKp0hYhXfl2n/YGwgJYcbJ/KuXa9XW15H
	WBXNWZmdh/hDwA78t54y8fytJIu+gQ1x5XF5aEkW+/VwtfZdzxeDviCCQ90xFr0a
	gdtb4RPCNdEc4CFGZxJwYTloH5WSWyBNY6qInO5blb7UlOOLxn96hN9WjLfwC1E/
	rihdoss1/7j+N3pQK069Zq9huntRQNbY4UjvPFzcSjIXi4MXPfGQXiRBmM5Iv5yQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4gg3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:41:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668Yasn031849;
	Mon, 6 Jul 2026 08:41:46 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6xvex6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:41:46 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6668fjFR23266046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 08:41:45 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 796595805D;
	Mon,  6 Jul 2026 08:41:45 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B61A158058;
	Mon,  6 Jul 2026 08:41:41 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 08:41:41 +0000 (GMT)
Message-ID: <269ae1ee-5f41-47f6-ad00-8a87e77e7e21@linux.ibm.com>
Date: Mon, 6 Jul 2026 14:11:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] MAINTAINERS: add missing NVMe documentation files
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        John Garry <john.g.garry@oracle.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, xlpang@linux.alibaba.com,
        oliver.yang@linux.alibaba.com
References: <20260706023439.3054578-1-kanie@linux.alibaba.com>
 <20260706023439.3054578-4-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260706023439.3054578-4-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: KFjcu440FB91yk_mbg5zAYRhgRyQtr93
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfX0Rdjhlp4iTXg
 Pi+m3ErhCDjqeXj+doY62IPkh1YUI478Bcan8Ff505Tss8WxP8baLQo7gHuJzU1oGeuqCWvLL3+
 rURefdjLuyq6gEnLNKpy8OjDwVQgXoGyzN18hMjlPLn7j89vqQ3VEXjUzRDfJbOMsDH3502LozN
 HaqpeccysDIjou4giPf3m79td/Dy1AKK5tMD3dKK0Xqf3Cgz7XqFgSexMzHsBvWZgXmC8JdlU3P
 1vNfhX27WVzGAcz/cQrvpX2fLiA2yEfdSZa+AmVW7vob/r9UKCDBI2xhvaKXfYAIXLkkbSLFcqc
 Js7UZfj/SfHMa4edFkKEHxrCMmI0GehbbC00Vdv6Vu7aetKqIzNmd9mmBAbgQSkMdDy/n/55FJV
 6Ner8AX8c9jhkl+kbq2bwGOZHiQMocTsmGuHiNzzYcg4/95vep4VYTWeo9ZWuP+tASOt5BzpKAl
 BTIzKHPKZu+mGT4Amtg==
X-Proofpoint-ORIG-GUID: SFIXE9SNniO7S31t8eRCEHAJyyZoDoC-
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4b6a4b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=SRrdq9N9AAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=2Wq210c3irZEzcCKGj0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfXz0fhmkbtB8EJ
 OfpsQ2ifhbJNY0BMn9II2xxtOyEdbmGErpJ+DdUIOw8NlUTQlFBWENiaXs3BXFQ2yIzVxoAFdAX
 Pc7ISZqK3WTIO7RiOvzqgoUmcvfh/uo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060083
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_014152_517772_B140B70C 
X-CRM114-Status: GOOD (  14.34  )
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
> Add documentation file entries that were missing from the NVM EXPRESS
> DRIVER and NVM EXPRESS TARGET DRIVER sections, so patches touching
> these files are properly routed to the NVMe mailing list and
> maintainers.
> 
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>
> Reviewed-by: Hannes Reinecke<hare@kernel.org>
> ---
>   MAINTAINERS | 4 ++++
>   1 file changed, 4 insertions(+)

Looks good to me.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

