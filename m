Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47005C3ABD8
	for <linux-nvme@archiver.kernel.org>; Wed, 14 May 2025 13:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DUJ0vFQ4EMhAcvAIviGQjFkRDFullF2TekvCIPmgdLg=; b=Q/bQg14uvqGNEwscFllZ1dmnLj
	ByOg3CrgG5jJ8rLVGzQNUYge1bAX+B/5a3+itXpq5BHbLFNyZEsE8hKkTESiQDKV0+qGWYFzTlYGh
	oMXNdTdtkv9iB7xh36kppquHLPXDqRv0qzVM9TsTZyKXJJFFjm6NVVz6kTb8vnOn1ozZEe6ijbw+j
	VqYsUyswAgGoQ4XnUNxa76V9PRBggTXmVuepsBIhYQ55Ysr3SOptDxq6LzpvITVY9Q3OxnxrwaMDs
	4BHyvoQK/ZeyDhwuIL4+Lqfx97FeykI3G8uT1DWitle8cTr9UoKGr02Okw+NCGI3gJQnj0521aSbR
	4Px20yag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFCZC-0000000FJW5-0LeR;
	Wed, 14 May 2025 13:54:38 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFBlg-0000000F9eD-3dvE
	for linux-nvme@lists.infradead.org;
	Wed, 14 May 2025 13:03:29 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E6IP2g026384;
	Wed, 14 May 2025 13:03:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DUJ0vF
	Q4EMhAcvAIviGQjFkRDFullF2TekvCIPmgdLg=; b=FfNI8eZ1R5ScogZm5ansXj
	HoU6wqpCAdrNt7QJaOli0lUZposxcCA2aUfL42tsQnFpKpOWHRbEuiMLiEZWjDfj
	PGxldoT9/1JU2xJgGlkH6UXttxk23c6XUbXmT/FREX8fAhJP4u2OPGCdMFu7O2PX
	yAqlOr0ZvS+TRPT3RStHeP/nHXZeyzl9Rp1ugKjOTD8p766Ia69UbdUQsN2ecfJB
	ZRK5wa5zvQ++i43tIkb2tgP5JhaZXvT3nbS3Vc3muzVjfINwNIpRo6AClyCHPwGb
	lP6NyLoedvYo9DHtnn+xOg4UCP+etlUK4iU8SN2CozBVbw+qq7iAyeK0vwgVLPGg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mnst1u4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 13:03:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54E9r5nr026961;
	Wed, 14 May 2025 13:03:13 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfpc8d9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 13:03:13 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54ED3CPZ23986724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 13:03:13 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7F3658061;
	Wed, 14 May 2025 13:03:12 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B6AF5803F;
	Wed, 14 May 2025 13:03:09 +0000 (GMT)
Received: from [9.67.82.218] (unknown [9.67.82.218])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 May 2025 13:03:08 +0000 (GMT)
Message-ID: <962021a9-6e9c-4553-8cba-5478720bc4bf@linux.ibm.com>
Date: Wed, 14 May 2025 18:33:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv4 2/3] nvme: introduce multipath_always_on module
 param
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, hare@suse.de, kbusch@kernel.org,
        sagi@grimberg.me, jmeneghi@redhat.com, axboe@kernel.dk,
        martin.petersen@oracle.com, gjoyce@ibm.com
References: <20250509175158.2753396-1-nilay@linux.ibm.com>
 <20250509175158.2753396-3-nilay@linux.ibm.com>
 <20250514054228.GB24939@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250514054228.GB24939@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AIKItfjJTz82HLE9JnkZ85hjgMIpIaKb
X-Authority-Analysis: v=2.4 cv=V+590fni c=1 sm=1 tr=0 ts=68249492 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=I6Q5NhU1Q2n8aBOm5jkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: AIKItfjJTz82HLE9JnkZ85hjgMIpIaKb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDExMSBTYWx0ZWRfXyC0YtES4Bc91 J9/nt29pVwpmVFLB/oapYaqqoDZWzNbiJG6ki2tfCi3ndVruQvDxMU9bKy6yvvq4Ve8NiXTHEcr eHVoGE5xm+o5sOaDizcMfF5E+egfqcvYx5/8SVZIvNAYfinNJYwq5bLxX/HsoIPha8P3E2GODpx
 aLDN8yrvFUt2qt5ahpzitnQghfm0QUoBcNjcI05ETdk0t/65ynOtbOHyA344Ye2q4kTklD/M0Ou 7U1BHIzYR2IuzIf0SEzaQ6LnkFlO09Vno5zoL6RMFmkYrHqirM7l23zwy3JnXhSLjzZ7DQFZYS9 cO+aUojirdti3eh43OOP4l/MB93fD2g01rf0yWHz30YD52HGzo37m0tKC82n+ys3xZi4uQ6GUiG
 3kNQewugVB+9YFmkLUU1V+xEJWqcEjXngnlBKr9St6iK9SCf7tXTEO+kF9JjKis13EtGLtLG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=793 lowpriorityscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250514_060328_909240_779FCB2E 
X-CRM114-Status: GOOD (  13.11  )
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



On 5/14/25 11:12 AM, Christoph Hellwig wrote:
> I just applied this locally, but ran into somethig that I think is
> not addressed here.  NVMe allows private namespaces to have non-unіque
> nsids if certain features (like ANA) are not enabled.  I don't think
> we handle this here, and in fact we can't really support that with
> the multipath node.  But we'll at least need to reject that case
> gracefully somehow and document it.

Okay understood. I made the change to ensure that we don't create 
multipath node for private namespaces with non-unique NSID even
if multipath_always_on is configured and also documented it in 
the code. The changes are on the way...

Thanks,
--Nilay

