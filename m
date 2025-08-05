Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B55C87FCB
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Aug 2025 04:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zb8+webijNeakWXpWwXXg6Y3WJdgKw2ZRx0o0hYcI8c=; b=xFN6JfMc8LZEXqttszAfOzxW0l
	+Mk7PLcPfuykHiUTajeor3JBSt3vofFuUQOn5/MNkU6IE56AUNSpRzALfF5r6Ue5kkk8lC5zy/REw
	ZE96nIANcIZOxrgIr8MUmNy3SpELzSopFyliAmIcXlQvp1jdxNt1fspLoFvhW7QIPnVru2IcD3yEC
	GQOQmKMZZkXlRtOMcYQLCB+LdsA3cxNiV2iUEY+lMmpOxnaN2w1hRXv1TehpdyOOlYO1vtQMwNUt8
	VXUsWeWrKMlbgi7usDkfqXT9/QN5VppfvyfXJrx1l7M6wpzZ6zoMr/6Lvu67V50WNf11b+FVrXQgN
	Wa2eOwKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uj9KQ-0000000Bkfy-1JoE;
	Tue, 05 Aug 2025 04:31:10 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uj9KJ-0000000Bkdz-0MkN
	for linux-nvme@lists.infradead.org;
	Tue, 05 Aug 2025 04:31:08 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574LU7Fg006083;
	Tue, 5 Aug 2025 04:31:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Zb8+we
	bijNeakWXpWwXXg6Y3WJdgKw2ZRx0o0hYcI8c=; b=qYKi+nqjLjwOOfp7gYqkEK
	1nCQYOw/r2NLiveRGVSz7RqVnBYLYsP50RXNeMJ9RBvHkM8Jf9qTIg2OlyUSh4q5
	vL53MgUnI4/nNjq/pIQDmo/vQ8aN8VPeFUw/NS9IDQPKqjwbkg0GadyI1UpDGdRD
	8Em7sg/d56S/RYuMvMlaAkmoQlBHRoRuFxMb9VV7WMVrDtL66xPmJW8z4JiCluQY
	yhWxO7QctoufgwDOBcM4gKSfDg7Ud2v1+mSXViOBeTe9imXbDr0Ktc9NzVFJUaX3
	Yh8rB9ZvXOio/Uiv6sJmpj5ayZ/di4MEZ8VP44Vs8NaFuuWNOItYQMIjXU6hPfBQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48983t4rqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 04:31:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57547KbU009971;
	Tue, 5 Aug 2025 04:31:00 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 489x0p0upj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 04:31:00 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5754UvcM26804606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Aug 2025 04:30:57 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 329A45805B;
	Tue,  5 Aug 2025 04:30:57 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F21858059;
	Tue,  5 Aug 2025 04:30:55 +0000 (GMT)
Received: from [9.43.82.116] (unknown [9.43.82.116])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Aug 2025 04:30:54 +0000 (GMT)
Message-ID: <9d5dfce1-4a6c-4b3a-af46-3c3d9ad67e2e@linux.ibm.com>
Date: Tue, 5 Aug 2025 10:00:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-list: fix verbose JSON output for 'nvme list'
 command
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, msmurthy@imap.linux.ibm.com,
        gjoyce@ibm.com
References: <20250721102946.1003295-1-nilay@linux.ibm.com>
 <175336669186.426033.4256373145639280312.b4-ty@kernel.org>
 <cc396386-3924-4198-bc05-e1a3137d59b7@flourine.local>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <cc396386-3924-4198-bc05-e1a3137d59b7@flourine.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDAyOSBTYWx0ZWRfX+4qj88EdHGZF
 2Icb7mA8CEIcXDa59CThhaawHzs5TMwHVFTJr81afmS+qF22JbyQNm1+ySn4S+b+1T5oU0Wg1VP
 hfVNszyJTEPgtP13KxSIik1IgpUWXS0uOx25tYDK7vhESWD3LTWkkxVpEKTumV9awfn6X6MPGEz
 6Mlyf3pLLpiEJjc8fJoMDqW9LhK5+M2dUAjiko2Crw2B/X9jrCpACDU+6dUxoKeL2yYJo59oGR/
 E8MxsmRFR6QqPZQh2mqNytQw7Ug/s3PJ2emXZcRjTaxFNOWvKj8HJG+/OWuXSWR8XEL5VB0mmFn
 J/wGTpORSqGdTyoh4AtB46fW9Iuu1PLzBWDHIRY685Dho3XlAUwVl9PzFNVaNtBP+hYVEHY21OJ
 wcS7U3H3Bhx/junPpEUkUi+vYWs10l9PU7z/JxFWJaztY+caZwDtf10aQhS5fMGKve3al0jt
X-Proofpoint-GUID: JGAQrCaGIeDd0_lDTA9qFZQxWZvuT1-I
X-Proofpoint-ORIG-GUID: JGAQrCaGIeDd0_lDTA9qFZQxWZvuT1-I
X-Authority-Analysis: v=2.4 cv=AZSxH2XG c=1 sm=1 tr=0 ts=68918904 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=NEAV23lmAAAA:8 a=ezUuKIbe1_I-1VFIdtEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_10,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=885 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508050029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250804_213103_886265_8D3A775E 
X-CRM114-Status: GOOD (  16.04  )
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



On 8/4/25 8:55 PM, Daniel Wagner wrote:
> On Thu, Jul 24, 2025 at 04:18:16PM +0200, Daniel Wagner wrote:
>>
>> On Mon, 21 Jul 2025 15:59:11 +0530, Nilay Shroff wrote:
>>> The verbose JSON output of the nvme list command is currently incorrect in
>>> both multipath and non-multipath configurations. Specifically, it prints
>>> empty Namespaces[] and Paths[] arrays in the wrong places, leading to
>>> confusion and invalid output. For example, on a system with single NVMe
>>> disk, signle controller and one namepsace created, 'nvme list --verbose
>>> --output json' prints the following output:
>>>
>>> [...]
> 
> FYI, this patch is causing a regression:
> 
> https://github.com/linux-nvme/nvme-cli/issues/2886

Okay so does it make sense to retain the old output with the
default --output-format-version=1? But then if the user selects
--output-format-version=2 then we'd switch to the new output 
format?

Thanks,
--Nilay


 

