Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9532D1CA35
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 06:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MvswJM80+636tK9a8dGnTDMXjRpr1q4pOooEOQzyfL8=; b=EbLQ8deNrgm/bp6C1hcOw7ktgf
	5XwvthYLlpPviMeblpkxtWGVMHPAT0xyKc1d+eO5FiosgjGTJp9Z7XqkLnb+vVZcS+yxVqvOREhh5
	m3ySUMvaD57zW2oa4Vk8DXJYhJPIJ8lLEgmQ0BuVvA+4QvCjIb/K2NmuBuZ2T64ieK+Fczaf3hX1y
	kEiwMi619EyXwy/8nLjdDG5BVqu+d584ycr3tniRLhNHTPtiAtresVOxny3GDsFoM93ZlN+dQ/mO6
	Jfc6stDCO9K5unWyCxzonfE+whC3f7VjBYxZoE6Wied+GttISi/4VTk6bFkvjkQQeTLIYLD3RycJY
	zbrll9jQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8CjW-0000000G1CR-3tk9;
	Tue, 05 Nov 2024 06:08:06 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8CjT-0000000G1Bp-2mgD
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 06:08:04 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A55cLWp032442;
	Tue, 5 Nov 2024 06:07:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MvswJM
	80+636tK9a8dGnTDMXjRpr1q4pOooEOQzyfL8=; b=rzb+DN5cJebd/6/rdYr8oy
	ljg01ErkALYDCQWpv+AN+MxsYzgn7WJQXp2PUMzru2QbXhdjIL+i7vWwawNW/YEA
	qnHBFH+PR0x6o5cbR0jFlOMhcMGp4w4HnAh+9Y37Y3dnTqJUZ7+MSU9m9us0z+nH
	m8kH8BjmksxyrAUiNy3l2ZKhr+Doi15ZdIMpl0n6kahOmc6ZWTaU6poKwOrNXGru
	FzEy1lcrTKUk7Czyko+ydOv46GaVGrm9oN5GtLO/ONTp9cDvjYRwOlbIcs0FLvzx
	oKD3baiiManOpBB0pwlALi4xpBCVFPtAgTEZ+J8diaaoA/6PnQps9gy6n9omeSyQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42qc3g0egf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 06:07:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A54fJd2008439;
	Tue, 5 Nov 2024 06:07:47 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nywkcwu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 06:07:47 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A567kVp55378216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Nov 2024 06:07:46 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BE3A58056;
	Tue,  5 Nov 2024 06:07:46 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C01A058052;
	Tue,  5 Nov 2024 06:07:43 +0000 (GMT)
Received: from [9.109.198.181] (unknown [9.109.198.181])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Nov 2024 06:07:43 +0000 (GMT)
Message-ID: <6e719910-a342-499b-98d7-578964126d0f@linux.ibm.com>
Date: Tue, 5 Nov 2024 11:37:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 1/2] Revert "nvme: make keep-alive synchronous
 operation"
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, axboe@fb.com, chaitanyak@nvidia.com,
        dlemoal@kernel.org, gjoyce@linux.ibm.com
References: <20241103181450.933737-1-nilay@linux.ibm.com>
 <20241103181450.933737-2-nilay@linux.ibm.com> <ZygVxkjQeOD_Jzy3@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ZygVxkjQeOD_Jzy3@fedora>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cR-HXox8aMUDzcPRd_cPMM6aJpswG0uT
X-Proofpoint-ORIG-GUID: cR-HXox8aMUDzcPRd_cPMM6aJpswG0uT
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 spamscore=0 mlxlogscore=661 bulkscore=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411050043
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_220803_750815_F4139260 
X-CRM114-Status: GOOD (  18.52  )
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



On 11/4/24 06:01, Ming Lei wrote:
> On Sun, Nov 03, 2024 at 11:44:41PM +0530, Nilay Shroff wrote:
>> This reverts commit d06923670b5a5f609603d4a9fee4dec02d38de9c.
>>
>> It was realized that the fix implemented to contain the race condition
>> among the keep alive task and the fabric shutdown code path in the
>> commit d06923670b5ia ("nvme: make keep-alive synchronous operation")
>> is not optimal.
> 
> One good commit log is supposed to explain a bit why it isn't optimal
> instead of "It was realized" without any details.
> 
I thought the link included in the patch would help. But I think you were correct,
it would help if we include the brief description here in commit log.
No worries... I would add it and spin a new patch version.
>>
>> We also found that the above race condition is a regression caused due
>> to the changes implemented in commit a54a93d0e359 ("nvme: move stopping
>> keep-alive into nvme_uninit_ctrl()"). So we decided to revert the commit
>> d06923670b5a ("nvme: make keep-alive synchronous operation") and then
>> fix the regression.
>>
>> Link: https://lore.kernel.org/all/196f4013-3bbf-43ff-98b4-9cb2a96c20c2@grimberg.me/
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> 
> The patch itself looks good:
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> 
> 
Thanks,
--Nilay

