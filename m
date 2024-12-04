Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB76E7716D
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Dec 2024 10:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VlMtqJRC1T3gP5QE+is3aLk46gSyehID0uWPMEv/Lo4=; b=F7vbacaPPkM8x70G+JHOdUVhqq
	lIiGBw0UXkPKph5w9zMxYzjTKt0sPtJTn7Bsk+2bflLuTn+RY0IqnFOoeRJsLb633GZkn1dnpFeWC
	RzuLfgcHoBre8HqzrOeKlSMJiqEyxE9L8NROPQoGYw7F9Ajtf9o3i4hZwJeWN1dwDWQNeAL/3Iua3
	iv2uqsbMGSyZxCIbbNm1oiHuAHCE9jJ5iJKq45dWFE+IhGxjqUgiMPAqpqznUL9taTG2Bqoygcivb
	U1JuyUzGhFS7+PcMj29JQlpj48GTQbj2DKqRlWFRhbegTxIDrp0CzGyVJJEvWT7vhu2mRwTYmPuWv
	zdnTe4Yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tImKK-0000000CAEm-064b;
	Wed, 04 Dec 2024 10:09:48 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tImJ7-0000000CA4s-3ilv
	for linux-nvme@lists.infradead.org;
	Wed, 04 Dec 2024 10:08:35 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B48ZVpX016386;
	Wed, 4 Dec 2024 10:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VlMtqJ
	RC1T3gP5QE+is3aLk46gSyehID0uWPMEv/Lo4=; b=LoWISldAhYEiWsjbCJIGuU
	L3c4dvqBaADyemVtUAmGk4uX7KdLWOeUo2vmJMFTQQfqZgFGFWyYNWUI9Rc87lPt
	lqFupXpRhLVWZCcbLwr+BZpEa+mphTfYByQIfl7cvQ4fZlblug0hoMc9JgCZGcm9
	Xax/u86SshVKsG/lbs5JrFTjpaD0rCgQrVo+l0rlWZQH2RVABriu4S0LqTYBf+7M
	1Tx7/tu0eleyR+c1ji+UobhEPOL2Wli24wx9Gff+pGpCHUP37x88R+cQO+3ZZtKT
	AMCbSQwFmu24Swxk5sRgyz96K2vIweM0SpKYmRQTnQBmch5STbwZKQ2BLx2kk6Dw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437tbxpqrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 10:08:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B48K7KE005226;
	Wed, 4 Dec 2024 10:08:23 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43a2kxk197-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 10:08:23 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B4A8M4v25952990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Dec 2024 10:08:22 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 791995805F;
	Wed,  4 Dec 2024 10:08:22 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8C875805D;
	Wed,  4 Dec 2024 10:08:19 +0000 (GMT)
Received: from [9.171.32.56] (unknown [9.171.32.56])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Dec 2024 10:08:19 +0000 (GMT)
Message-ID: <8efcf3a2-5f54-4a51-9749-afa6eea6cbfa@linux.ibm.com>
Date: Wed, 4 Dec 2024 15:38:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 0/2] add nvme test for creating sleep while
 atomic kernel BUG
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        hch <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>
References: <20241129080231.2994578-1-nilay@linux.ibm.com>
 <kuvftnq5cjwtzh557umohu7afvndg3tl4lx6qfjjuwd675phk3@y5iaypkzdsz6>
 <9d6b3b9c-c9df-4fcd-bf2e-6a5635171bcd@linux.ibm.com>
 <77fc8b7a-4d90-4496-bce6-94f3af5c70df@nvidia.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <77fc8b7a-4d90-4496-bce6-94f3af5c70df@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZL2OZ-gx5D8YcOhawDb9-Rdv3OowTNTA
X-Proofpoint-GUID: ZL2OZ-gx5D8YcOhawDb9-Rdv3OowTNTA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=836 priorityscore=1501 bulkscore=0
 phishscore=0 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412040078
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241204_020834_052262_CDAE284F 
X-CRM114-Status: GOOD (  31.53  )
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



On 12/3/24 13:56, Chaitanya Kulkarni wrote:
> On 12/2/24 21:38, Nilay Shroff wrote:
>> Hitting the kernel BUG depends on the race. In the test case, we disable the target ns
>> and then write to it and there's a time window between "disabling ns and writing to it".
>> During this time window, after disabling ns but before we actually begin writing to it,
>> if the target could clean up ns and remove it from subsystem Xarray then we may not hit
>> this BUG. So I run the test case in a loop for 10 times hoping that we'd hit it at-least
>> once. However, on my test system, I could hit it 2-3 times for each run of the test.
> 
> Thanks for the explanation, however we need a test that will hit the bug 
> 100% of the
> time and will avoid different behavior when users run it multiple times.
> 
> Luis has shared his general experience running block test and conclusion 
> was we need to
> have tests that are consistent and not have different results when 
> executed multiple
> times. From the feedback we got we can't really guarantee that every 
> user will know
> this and or adjust the testcase running loop to hit the bug and run it 
> for multiple
> times, that brings down effectiveness of the test. Not only that it also 
> becomes real
> problem when to build a CI on the top of blktest.
> 
> How about we add an error injection code so it will prolong the race 
> window in such
> a way it will stop the target from cleaning up the namespace and 
> removing it from
> xarray when disable ns command is executed and then writing to it ? 
> of-course
> before disabling the ns we will have to enable the corresponding error 
> injection code
> potentially sleep.
> 
> This is guarantee that we will his the race window and make the test 
> effective 100%
> of the time.
> 
> Or there any other simple solution we can think of ?
> 
I got what are your concerns here... 

So I have devised a way to recreate this issue 100% of time without needing a user to 
re-run the test multiple times. Idea here's that before we disable the target ns and write 
to it, we would first disable the ns-changed asynchronous event notification which target 
sends to the host whenever it detects any changes to the ns (including ns addition, removal 
etc.). So then later when we disable the ns on target, it wouldn't generate AEN for ns removal
and that would allow the host to write to a ns which is disabled on target. With this change, 
the test would trigger the kernel BUG 100% of time.

I will spin a new patch with the above change and send it for review later today.

Thanks,
--Nilay

