Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA52ECA1009
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Sep 2025 13:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9uq3+6xQypcWg7NPRZHhqikgoEPycbfS/CwjG9m7izo=; b=mqDjOvCPg+KGYnrMstS6HuzEan
	Q4Sqlfk/LqtXfo5owGfU8aUFHuLGTsqXDuT1yfFFqA3Y9P7+KL/UpIpt6e2wkFZGl9h+3SBM3I4o8
	h8NjkPbeYODDNJp7FXwQuKho5eXrRhIXUiUnhbJinH2gUpGtSPE9f+xVYaOjTH0BDb6OPC7BsKyLy
	09eh3zWQdLB6cfxoqpBWtNjDDV57ArC8RpUXOhObxVdo33wd/20FCpIMGfaeb2TO2EDsxkwzrqX/o
	rRcAQL1RiX+4lji1siEQPz/nR5U9MZ/T7mf8pO9lLsWdBjTFVwD3t6NxyCjOHNrQ/VeZMw9ELh3ez
	sw6iVoPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utnLT-00000006YBy-24gR;
	Wed, 03 Sep 2025 13:16:15 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utmSf-00000006Mqm-3LkD
	for linux-nvme@lists.infradead.org;
	Wed, 03 Sep 2025 12:19:39 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5836Hnrv017948;
	Wed, 3 Sep 2025 12:19:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9uq3+6
	xQypcWg7NPRZHhqikgoEPycbfS/CwjG9m7izo=; b=UFgPPUI7UZTWfH7wfk2hrc
	VjBTX3Sj0XofIlDoKj8Tg0yDu8NxxBmj1Ix31qLj83TsnjqngZKtaPzvJ0ka5DI3
	gLeqR2dGM7xHccGjb/OAlnq1jGgc2kaW75iIyGj/o9MwXLXjxc9qOu7LUpuQE3fS
	JWOLHTt05XdcH38On6NKLn0083xFkvrTilpdo3NCQFGLqRXkPRIrt+hJ5KtxVyOs
	SlZs/ZhlfAV7cZgfrvT45kQC6JCMwMFYNfHMvsqQK6wEfqahfqgn9DazVWrW7CKt
	d1rrpKOGs+LziqkvHtreXxul9L57cZM3I95a3Uk3Usbw8QBJiqJmVV8lDTMR8f1Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usur46qw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 12:19:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 583CBmre014038;
	Wed, 3 Sep 2025 12:19:29 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48veb3f35h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 12:19:29 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 583CJSwl10421604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Sep 2025 12:19:29 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5D6E58063;
	Wed,  3 Sep 2025 12:19:28 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3DE658055;
	Wed,  3 Sep 2025 12:19:26 +0000 (GMT)
Received: from [9.43.42.28] (unknown [9.43.42.28])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Sep 2025 12:19:26 +0000 (GMT)
Message-ID: <39141817-e3b6-4d74-8fe0-7cd567c656db@linux.ibm.com>
Date: Wed, 3 Sep 2025 17:49:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/4] nvme: extend show-topology command to add support
 for multipath
To: Daniel Wagner <dwagner@suse.de>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
        kbusch@kernel.org, gjoyce@ibm.com
References: <93be5b21-8897-44d3-a590-42ba8f1b6abb@suse.de>
 <a06660fb-821f-447e-9ea6-ef0f3372a844@linux.ibm.com>
 <ecd33303-830d-4e26-b49a-14a558725e67@suse.de>
 <4f504c94-e6da-4a33-aa12-9dcb447e7021@flourine.local>
 <4e20561b-8b51-45c5-ad83-24b3d7ae092d@suse.de>
 <180fd47e-ffe6-4ef1-986e-5885afc34c01@linux.ibm.com>
 <8de91a15-3d89-4801-911a-00e45bb6a2f1@linux.ibm.com>
 <2eeba3ca-293c-429b-8afa-c5ba401c67b6@flourine.local>
 <ee0d329a-334b-429c-a916-f03c64bbb323@suse.de>
 <d904e2bf-1b59-4511-998d-f53249137428@linux.ibm.com>
 <9a878215-da92-408a-afb1-0e54e5770518@flourine.local>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <9a878215-da92-408a-afb1-0e54e5770518@flourine.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMCBTYWx0ZWRfX4yVVmCv6rqMK
 BSPWlVMAGKYfOWAyXqDhxqIYPiyPvP5SmE2c18XFPTimplzikxXGjoh6uGadlsvlHYdcgZtvw+5
 bVBquML0o4Dg0+rvWROmtL2gENBcmhFjj3EUefzEAmOZDBlKWKnB3IZk6ES5gGkn6XB9bPoQb89
 2PAE7kQohtiU4Vky+tC5W/R5JEqPjRynDHIs26iwfwuDGEIsepXLan7AHVBp4ng1uBpypKlNCzk
 QqXcV917tWj9q3x9FJ+/CF4/oHMmJrvw98nlM+thSI60qdhfVxaFsBREtdRPHQbcTLF1mgwjOHe
 RavfgPVwNgkKX3y6VCXHSjdnIuzgMT77F4L6zLDoo2y1Mn0KfyadK0uJgADYhvZp4se97G5LXDe
 BIO1Ni31
X-Proofpoint-GUID: McIZjjYuHgw87BE9wJUqLMc96ucE0moA
X-Proofpoint-ORIG-GUID: McIZjjYuHgw87BE9wJUqLMc96ucE0moA
X-Authority-Analysis: v=2.4 cv=Ao/u3P9P c=1 sm=1 tr=0 ts=68b83252 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=dRTOrBfqEdQex_4neEEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300030
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250903_051938_187670_0ADA1690 
X-CRM114-Status: GOOD (  16.89  )
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



On 9/3/25 12:54 PM, Daniel Wagner wrote:
> Hi Nilay,
> 
> On Wed, Sep 03, 2025 at 09:52:13AM +0530, Nilay Shroff wrote:
>> Having said that, the “monitor” idea seems worth pursuing separately as a
>> longer-term feature. For users who want a live view today, they can already
>> run something like "watch -n1 nvme show-topology ..." to refresh the snapshot
>> every second. A built-in --monitor feature would be nicer and more efficient,
>> but I think that’s orthogonal and can be discussed separately. And I believe
>> "minitor" feature shall be useful as well for implementing nvme-top command
>> (as I recall we (me and Daniel) discussed it during LSFM-2025).
> 
> Yes, I remember the discussion, me trying to convince you to implement it :)
Yeah I was convinced at the time :)

> I've created an issue on github, so we can track this feature:
> 
> https://github.com/linux-nvme/nvme-cli/issues/2904
> 
Okay good. I'll work on it once this patchset is merged.

Thanks,
--Nilay


