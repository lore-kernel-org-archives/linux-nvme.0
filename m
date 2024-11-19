Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D02FD44153
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Nov 2024 12:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bkXfidarT1QXKPD6rHUc+8xdWlcBCxeFQcwFv5jtMm8=; b=o+SqLHQavBStUXqg+Ke6VmDu3B
	jn/H9milsK4W6R2UASPgNOTB55pkp7mUT69AsHCNcqJnGcNZcSkNhhco5WMX8QAah9RKEezpXZ6Q2
	/P5a+mLvFMR0Iyd8S6EavKfbiouLhIKbTLsSJ12aiem8r0unTwLYO0cR/QPbo/dzvtNxPpm4C/PUn
	kJ269cKEhjWhCFRmH/YD4twuH/eZtpNl667dV+PVsI6dRhKgJJubFUmP43OklznPOgkkEZo6I7LBc
	oxB9ClqOsrxD0IB1ph1KX9kd32wOnWgJg6rZIUzUzupaAqbZdOW/eRn1YApFqnJSDhixb0/glXT9i
	XCe63KWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDNQV-0000000CNgK-3hlY;
	Tue, 19 Nov 2024 12:33:51 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDNQS-0000000CNfK-3q6P
	for linux-nvme@lists.infradead.org;
	Tue, 19 Nov 2024 12:33:50 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJBkZvE014043;
	Tue, 19 Nov 2024 12:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bkXfid
	arT1QXKPD6rHUc+8xdWlcBCxeFQcwFv5jtMm8=; b=jvlRSSv2aswIXfypZp4sNk
	g57q388L2HluVkkaAaO05/ynpp48WkfDrWZfQXXS3083m2RDZqG+dFAsWJJZypw1
	i15Wx7VAs1xEqCb8Q5hzt3E/tfs1TcWeLGFeKhuGjEil+hk96UPixs3L5ZVoVsPJ
	8hGYNLNdDbIrunUtvEMPwYgtJZcj1vb/pGc06p2MrTZuBU+DyymXLIJgH4Jf0sBu
	i06niMXXIzU/EQUo/bcrRh9GD+ydvMMTfNeFU1E/a9Mg945JBJJkd2lCEMaW53rQ
	IHVLOC/7VlLQ1FcKGa/VIfDClKBSzlyL0HtU7v7iaaOsd8GdIHtMayYvwGGb/t5g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xyu1nq3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 12:33:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ23dh6024623;
	Tue, 19 Nov 2024 12:33:37 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42y8e1cdg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 12:33:37 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AJCXbE757934110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 12:33:37 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A5E05805A;
	Tue, 19 Nov 2024 12:33:37 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DC2358052;
	Tue, 19 Nov 2024 12:33:34 +0000 (GMT)
Received: from [9.109.198.240] (unknown [9.109.198.240])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Nov 2024 12:33:33 +0000 (GMT)
Message-ID: <facc4d66-034a-4131-b60f-15ac1455b93a@linux.ibm.com>
Date: Tue, 19 Nov 2024 18:03:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 0/2] nvme: fix system fault observed while shutting down
 controller
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        ming.lei@redhat.com, axboe@fb.com, chaitanyak@nvidia.com,
        dlemoal@kernel.org, gjoyce@linux.ibm.com
References: <20241105061212.1008143-1-nilay@linux.ibm.com>
 <ZypXRi8R4uOIrkc0@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ZypXRi8R4uOIrkc0@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NaypT7RlKGl8MeAWcTPj_FK_3iXaAHeM
X-Proofpoint-ORIG-GUID: NaypT7RlKGl8MeAWcTPj_FK_3iXaAHeM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 bulkscore=0 spamscore=0 mlxlogscore=940 adultscore=0 mlxscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190091
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241119_043348_966952_E07543D7 
X-CRM114-Status: GOOD (  16.08  )
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

Hi Keith,

On 11/5/24 23:05, Keith Busch wrote:
> On Tue, Nov 05, 2024 at 11:42:07AM +0530, Nilay Shroff wrote:
>> This patch series addresses the system fault observed while shutting down 
>> fabric controller. We already fixed it[1] earlier however it was later 
>> relaized that we do have a better and optimal way to address it [2].
>>
>> The first patch in the series reverts the changes implemented in [3].
>> So essentially we're making keep-alive operation asynchronous again as 
>> it was earlier.
>>
>> The second patch in the series fix the kernel crash observed while 
>> shutting down fabric controller. The system fault was observed due 
>> to the keep-alive request sneaking in while shutting down fabric 
>> controller. We encounter the below intermittent kernel crash while 
>> running blktest nvme/037:
> 
> Thanks, this all looks good to me. I think Sagi had reviewed patch 2
> already, but I'll wait a day or two before queuing this up in case he
> has any last minute comments.

Just wanted to check, did you get a chance to queue this up?

Thanks,
--Nilay

