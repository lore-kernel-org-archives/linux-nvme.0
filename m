Return-Path: <SRS0=D3vR=ET=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E98C55ABD
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2020 16:52:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C77321D1A
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2020 16:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QHsNkmHs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h0zuYmCg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C77321D1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=d4XCJep9+wIJBEHxQtOyZ3NXiupn7iRzZzQie5WpgHU=; b=QHsNkmHsKE01sTs0/saA1tXVB
	AAuNJPQK8ElL9ISlvqufeXve2aIYLVDsEpL2tdOOIZatEC1/bkKlHQO7QfSoy1UERgOO9u7xM6pUR
	z1CB4FiI27HAxcPC88kOOSFXIhfXI9W6oP/n9YB7iWY8urL4LO4IpEmxuB6WdBAbfc88G4a4HXUUO
	oZcmdBnWGKMa3j0qD6THXhOl0QJuOIBqkhv4Haw4WYYbBQj4orD3JtsMb+WMPOAN5hFtZffxFprV6
	kG0CSA2k+gRB30fr+VG0HxyM6IrTw15OONzLJWk4124U6QKqccVUxkDe3ObWlofv+Pp/ekqpFvCNC
	Y//prk1xg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kdcJ8-0007Pr-RY; Fri, 13 Nov 2020 16:52:18 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kdcJ6-0007PW-5p
 for linux-nvme@lists.infradead.org; Fri, 13 Nov 2020 16:52:17 +0000
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0ADGXH87066679; Fri, 13 Nov 2020 11:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=20opIcxHL6KerUt1ZtOZ7lNdftubKY4nb3a7SIpkdXM=;
 b=h0zuYmCgYo5cXz2KTcmHrJ7bEe36PHxRyBFDdCq1OEwtxhkpRxzpeMlpGUe4FVx9BGTH
 6IVrO2tIQRosMqcGgG+tq6cQ6Y0tMSvYowSJ9edCalUV120fLzyTiMSqolhWq7+Ypk1b
 oRd+HtWfKQsfFx3NayQPW65jjBdb0H+4ny2I/aFlPHlUNIXgn6KeswLrvHPE+e9VOF4P
 gjPWdk0XatzcC0Q1IO9wv58VEFH8AzSe46kZ9MALWY3XAV6fgNMcqBxAkgsEnJX6HepR
 0H42Lhsg6xcXvqK5o8KrSeu71sHAFiQRmt5B8l9+J3sB7kquMldCo9WUAPXPL7bHR/hI Mw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34swrd0gs3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Nov 2020 11:52:10 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0ADGpwN2016720;
 Fri, 13 Nov 2020 16:52:08 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma06ams.nl.ibm.com with ESMTP id 34njuh6w7p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Nov 2020 16:52:08 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0ADGq5Ml3539496
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Nov 2020 16:52:06 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C696E11C058;
 Fri, 13 Nov 2020 16:52:05 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E94A11C05B;
 Fri, 13 Nov 2020 16:52:05 +0000 (GMT)
Received: from [9.171.37.149] (unknown [9.171.37.149])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 13 Nov 2020 16:52:05 +0000 (GMT)
Subject: Re: [PATCH 0/2] nvme-pic: improve max I/O queue handling
To: Christoph Hellwig <hch@lst.de>
References: <20201112082302.82441-1-schnelle@linux.ibm.com>
 <20201112145325.GC2573679@dhcp-10-100-145-180.wdc.com>
 <10908f20-7e18-e967-76dd-1a38e216b378@linux.ibm.com>
 <20201112173634.GA2626470@dhcp-10-100-145-180.wdc.com>
 <c753af20-878a-91ad-c5c2-692016fe2014@linux.ibm.com>
 <20201113162502.GA16940@lst.de>
From: Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <822e0e06-28c2-a069-6cc1-a0810b17fbdd@linux.ibm.com>
Date: Fri, 13 Nov 2020 17:52:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201113162502.GA16940@lst.de>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-13_10:2020-11-13,
 2020-11-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015
 phishscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011130107
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201113_115216_652243_093D0422 
X-CRM114-Status: GOOD (  23.19  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 11/13/20 5:25 PM, Christoph Hellwig wrote:
> On Fri, Nov 13, 2020 at 02:15:59PM +0100, Niklas Schnelle wrote:
>>
>>
>> On 11/12/20 6:36 PM, Keith Busch wrote:
>>> On Thu, Nov 12, 2020 at 04:45:35PM +0100, Niklas Schnelle wrote:
>>>> You got to get something wrong, I hope in this case it's just the subject
>>>> of the cover letter :D
>>>
>>> I suppose the change logs could be worded a little better :)
>>
>> Do you think I should send a v2 with an improved message?
>> I just realized I'm pretty alone (and wrong) in starting
>> the commit message body lower case too.
> 
> I'll pull in soon, no need to resend.
> 

Thanks, appreciate your effort!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
