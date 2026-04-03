Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FB8E8537F
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Apr 2026 15:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zSCgjVJz9eeVBEEUU1IXdknmbKao8mKdyogJ6jR9jy4=; b=qeUlE9/PCUXUYi6VxjrwSuYhvM
	wKwP7gacQt5QqKzvZ3EfXaID0dwFTrV6xEavEwed6D5MVCrHSVkcWZW4FChbfubWK+x/yBxaDUbSS
	Vfme2NnAzg+yeE0CsZTk1OaY1+h2E+2n1C+SaZ5Qvpwvoy47k2QG/5X6N/hDVvSQ0RfmNu2kaEngg
	5G6lc9aMmHZYDYUNwizBeKwjMhZDJC+uOOomjYcZF7Af+0bCJj4yxsMjMCqBMKjIrnjXvrWhQ6zSu
	uHZ5koDItJR6mwlZGzKFg5X5J/I1UOf/ZuLhgG/OwFz7xVS/iHkXtEUVEeSLQRdrELWWkKFkVRzcc
	xvbMAY1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8gZw-00000002DyI-2ZMl;
	Fri, 03 Apr 2026 15:37:00 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8gZo-00000002Dxp-0bb1
	for linux-nvme@lists.infradead.org;
	Fri, 03 Apr 2026 15:36:53 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6331ihZx133554;
	Fri, 3 Apr 2026 15:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zSCgjV
	Jz9eeVBEEUU1IXdknmbKao8mKdyogJ6jR9jy4=; b=EO4X9JGKSxB9cMUg8BxQoD
	ztAZa7dZVzhBSUFyZkDFAtohf2dLUErh7cgM1Y88gtVNIMF47nN+MC5weEZkUFt+
	JTJ07bXKyItyYZJNEKBxMBDH3a5BkX3DO+1z6ZvdsPglBbV8twuTJZs3SBTbpN3s
	SJJ6v7e/h9twvqckVptGdu6JVD/7knR+F7STcHa+waYRizKxBvU+rCAachDTc1Vs
	wJay8x0lr1/YLVon4DwetfwvrEEqHY1EoE0XQ5P9d79Rc8026UOYfNqKeczLD5WC
	mWZbRo1OMTREn/GQPqVMgYMHAe8oikbtaLy68Pwi1qHnJY38f8uS7xN35yH/dsAQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66np19kk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Apr 2026 15:36:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 633CfQnr021659;
	Fri, 3 Apr 2026 15:36:41 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6sasxr0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Apr 2026 15:36:41 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 633FadtL26083904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Apr 2026 15:36:40 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7F4A5803F;
	Fri,  3 Apr 2026 15:36:39 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 624DA58054;
	Fri,  3 Apr 2026 15:36:32 +0000 (GMT)
Received: from [9.39.19.5] (unknown [9.39.19.5])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Apr 2026 15:36:31 +0000 (GMT)
Message-ID: <c3156dd7-366e-4451-9423-e73ded44a602@linux.ibm.com>
Date: Fri, 3 Apr 2026 21:06:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] libnvme: add support for retrieving per-path gendisk
 I/O statistics
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, hare@suse.com, kbusch@kernel.org,
        hch@lst.de, gjoyce@ibm.com, wenxiong@linux.ibm.com
References: <20260321152823.3197870-1-nilay@linux.ibm.com>
 <20260321152823.3197870-5-nilay@linux.ibm.com>
 <1adcb39b-5e88-4ad0-86fb-8d794adc8744@flourine.local>
 <cc566b4c-fe9f-47c6-827f-d1d436fa477e@linux.ibm.com>
 <1e4eb9df-d260-4a72-91e0-b96a2447f6b9@flourine.local>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <1e4eb9df-d260-4a72-91e0-b96a2447f6b9@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: u5Q6Lc0ha8F9gYWjKuhOXp4d_gtyYAbq
X-Authority-Analysis: v=2.4 cv=KslAGGWN c=1 sm=1 tr=0 ts=69cfde8a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=A2nJTO0Ze7TOXp1MBTAA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDEzNiBTYWx0ZWRfX8lj5dqZMdSv5
 d5mW3QAEog7U0mEMecUH+ttgxaWOmjSjdAf0ElMrlvKpyMNIf6FV5rEEUTBloSWgPtjk9XNMYlM
 w2v3y1lxFxRXCVx9gDBKgbnMEKruKZac2vRDwPl5r7xjsuJDJ0gGEovAYFWPFeUkdUvlxaDGu+Y
 wtp0Aq48V+Pda11j60UjaGYAtl3lBZyby5nQj9WbE91biZ2Y4rd+wNCmg+MgDpDJoHGceL+megB
 OEedFGINwIhQdAGEHEVQvELbOBBO8RwO2+y4dVcq3QPyhc4xZkbXnwJXXRN06zG2PerlMrVCE7e
 9zuMN5SEoN56nBwP+cNBddjAOuKOVtbf+9U0LToR5/wEErFr2Zq2AD4XKx2gRrnhZR7x/nXeANA
 iHXvkhQTCrvBRs3uoXgh9lVo/6k2j6OMnLebuV9Z4zurWXrBVVtkmL3bm/g7mwea1Bc6qH56EXp
 zXLslk2UKLw61RN9hww==
X-Proofpoint-ORIG-GUID: u5Q6Lc0ha8F9gYWjKuhOXp4d_gtyYAbq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604030136
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260403_083652_208934_2E5DA098 
X-CRM114-Status: GOOD (  15.09  )
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

On 4/1/26 9:12 PM, Daniel Wagner wrote:
> Hi Nilay,
> 
> Sorry for the late response.
No worries:-)

> 
> On Tue, Mar 24, 2026 at 06:32:59PM +0530, Nilay Shroff wrote:
>> After updating the stat, the caller/nvme-cli invokes nvme_path_get_xxx()
>> APIs to retrieve specific metrics. These APIs also take the current index
>> and compute results by comparing the current and previous statistics.
> 
> Let's try to avoid leaking internal implementation details to the public
> API. This makes it unnecessary hard to maintain.
> 
> The stats update function could take an argument what it should do:
>    - update internal stats, calculate diff -> getters return the diff
>    - update internal stats, getters return the absolute value
> 
Yes got it.. I think we could do this way. I will give it a shot
and respin a new patchset with the above change.

Thanks,
--Nilay

