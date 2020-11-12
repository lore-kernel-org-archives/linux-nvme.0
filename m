Return-Path: <SRS0=6u0/=ES=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0ADC56201
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2020 15:45:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20F18221E9
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2020 15:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hbepdTIC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tcHZWvAF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F18221E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=j1olWSjbbBLAp50ozD2cYYgxudLhLj3cfE5jesSVC7U=; b=hbepdTICbxVZsTXCq8yPMgblL
	gYL+ldPpJ4z9U9pZK9HnsEz14FKjI2NIV+gRASh0BTk3ebESqvhFY03ycSTsJCBkTvqTuspXxmI41
	Pec8G1dmniuG/T/aR3Q0FhjnhR4yHg5uEzfhJUHfRfHHQu0Kp1aZrfZfmh808uYqsCnTqf6d4RUpV
	+r2//HQ/C2kXjKPiTKWA4w8X4MHbzqAXBM6s+nQETw1cQPo7V92Vqud35f65TVC+VI2gtX7ozkzBx
	OWuCvlHTGZpPQWrJiXz1wXk8lOliWj+PCTfkylK3bsJPLMWmY7LwZajfjesB8wLQQiShWI8z6PcYC
	bnL8Wbziw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kdEnE-0006oF-TK; Thu, 12 Nov 2020 15:45:48 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kdEnB-0006n8-Ak
 for linux-nvme@lists.infradead.org; Thu, 12 Nov 2020 15:45:46 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0ACFX3IU190272; Thu, 12 Nov 2020 10:45:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=aMlyye4rrFcjn8vxBO/cshtHW6Pbn22aPrH1Hrnofpc=;
 b=tcHZWvAF+X1+9DdRIxvCpTp8eNRVV2y8Z6Y855iagIDhfFlOwpwzQDrr+OscJMEd/cvh
 9vCuv7t7qVzlkVxEiqn5kTdR+kqpC7XI2zlNRck19HaPfLNsWl9xCsWX4f8KDrbv6AH4
 Wc0y0KUPbDJ4AiWKC/hTMp/6c0O5cFilpHJ9Zo6bnW5xm/INjUMrxjMvphZce6Za9vf+
 qX0qOU7LJSSatl9UJ0zhN6Ltz8vRI4ogDHf/eYsbGLxIb4GkHi/NUKXmadSpKlBgfGVC
 /w8HLvcCEtiD4Z7kxKczt8nnWry44uKiH2xa/DqOxd8ynMDDK9N6TBSG5m4egpyoBH3N 0g== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34rjnps6b3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Nov 2020 10:45:40 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0ACFTRbT007103;
 Thu, 12 Nov 2020 15:45:38 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma06ams.nl.ibm.com with ESMTP id 34njuh5u0u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Nov 2020 15:45:38 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0ACFjaMZ45810040
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Nov 2020 15:45:36 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01885AE05D;
 Thu, 12 Nov 2020 15:45:36 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B00D5AE045;
 Thu, 12 Nov 2020 15:45:35 +0000 (GMT)
Received: from [9.171.86.225] (unknown [9.171.86.225])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 12 Nov 2020 15:45:35 +0000 (GMT)
Subject: Re: [PATCH 0/2] nvme-pic: improve max I/O queue handling
To: Keith Busch <kbusch@kernel.org>
References: <20201112082302.82441-1-schnelle@linux.ibm.com>
 <20201112145325.GC2573679@dhcp-10-100-145-180.wdc.com>
From: Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <10908f20-7e18-e967-76dd-1a38e216b378@linux.ibm.com>
Date: Thu, 12 Nov 2020 16:45:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201112145325.GC2573679@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-12_06:2020-11-12,
 2020-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011120091
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201112_104545_629099_3CEB5F6E 
X-CRM114-Status: GOOD (  30.79  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 11/12/20 3:53 PM, Keith Busch wrote:
> On Thu, Nov 12, 2020 at 09:23:00AM +0100, Niklas Schnelle wrote:
>> while searching for a bug around zPCI + NVMe IRQ handling on a distro
>> kernel, I got confused around handling of the maximum number
>> of I/O queues in the NVMe driver.
>> I think I groked it in the end but would like to propose the following
>> improvements, that said I'm quite new to this code.
>> I tested both patches on s390x (with a debug config) and x86_64 so
>> with both data center and consumer NVMes.
>> For the second patch, since I don't own a device with the quirk, I tried
>> always returning 1 from nvme_max_io_queues() and confirmed that on my
>> Evo 970 Pro this resulted in about half the performance in a fio test
>> but did not otherwise break things. I couldn't find a reason why
>> allocating only the I/O queues we actually use would be problematic in
>> the code either but I might have missed something of course.
> 
> I don't think you missed anything, and the series looks like a
> reasonable cleanup. I suspect the code was left over from a time when we
> didn't allocate the possible queues up-front.
> 
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> 

You got to get something wrong, I hope in this case it's just the subject
of the cover letter :D
Thanks for the review, I appreciate it. Might be getting ahead of
myself but I'm curious who would take this change through their
tree if accepted?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
