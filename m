Return-Path: <SRS0=D3vR=ET=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B426AC388F7
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2020 13:16:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DC422223C
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2020 13:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bo6BaM6W";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QXwUdO/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC422223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KBbq7BjbSO1Nuw3Xfh/0BKf8NT1qr9EFetHF/LeoZcg=; b=bo6BaM6WcOlfsKML9etaiXZuC
	+GU/ZWWAUFskxpoApn8WD3Hlyh7tYV0aheNosqefCemnbPyo04BYNceg5vWkRP9mQUCOp3OlTse2U
	xBv9ujL0gRkca3TTFbSOZ/nLPr5MCe1vpW6Km2mOm2zF9se7LmgO+I4uM7A2wOWUwidCfkJFANZ7Q
	yiVxrxXYYyRdeFFmWoyYXtJfGgiQwKyO91nZvIALHk822qnouxZho+UuKUJNJToZhM9wHPUExjXxu
	L/VCzHD4o8xwQQK9KcCzLXAOozWMaq9y//svNKvcOLjQk6GuLK1MH44eZ6NCPabNSVha53sCCwf3L
	sfdrlysRg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kdYwB-0003M4-3H; Fri, 13 Nov 2020 13:16:23 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kdYw3-0003L6-SB
 for linux-nvme@lists.infradead.org; Fri, 13 Nov 2020 13:16:17 +0000
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0ADD2uUR153810; Fri, 13 Nov 2020 08:16:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ECFI6KPxFa31akuWqpTX1KuNeumCiohWdrUgL9EHF64=;
 b=QXwUdO/G4Vhw90LxesI35YXw6CXjmXMxvAc+VT/0CC6Pp9ktCkZdHQzKBcrFmT4f7o5X
 fo6sZk+/6a38YKSB0eZhkk+3UyXzFV60A58QhDBZdYeKvdQ6nFS7VTHQU2OuJWZQwn59
 z9ZMXTLR//Fg7zxqPuG2l/FkgJ0r+LMbtxJIRIkWdV4IwaLyRWN3/WiDwQTV+mPHOkBk
 3OnS9jsT3JQWGLfiSKWzeefGDJvx+0idhgxJNz8ig8hBf+YYgmC7lKGQNsp4N7cdi5rl
 Scu/kqPSsFBRgIxNqT8xkIVR051klpiH6h8e1kl+sDTUrxKgzo3HSTwuc7LUSGnAVMAs Fw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34sqwrn2r3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Nov 2020 08:16:04 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0ADD8HF8011147;
 Fri, 13 Nov 2020 13:16:02 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma06ams.nl.ibm.com with ESMTP id 34njuh6qvm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Nov 2020 13:16:02 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0ADDG0Ug1966706
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Nov 2020 13:16:00 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C18042049;
 Fri, 13 Nov 2020 13:16:00 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E46B742042;
 Fri, 13 Nov 2020 13:15:59 +0000 (GMT)
Received: from [9.171.37.149] (unknown [9.171.37.149])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 13 Nov 2020 13:15:59 +0000 (GMT)
Subject: Re: [PATCH 0/2] nvme-pic: improve max I/O queue handling
To: Keith Busch <kbusch@kernel.org>
References: <20201112082302.82441-1-schnelle@linux.ibm.com>
 <20201112145325.GC2573679@dhcp-10-100-145-180.wdc.com>
 <10908f20-7e18-e967-76dd-1a38e216b378@linux.ibm.com>
 <20201112173634.GA2626470@dhcp-10-100-145-180.wdc.com>
From: Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <c753af20-878a-91ad-c5c2-692016fe2014@linux.ibm.com>
Date: Fri, 13 Nov 2020 14:15:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201112173634.GA2626470@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-13_10:2020-11-13,
 2020-11-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011130080
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201113_081616_343121_B9BA2CC4 
X-CRM114-Status: GOOD (  20.68  )
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



On 11/12/20 6:36 PM, Keith Busch wrote:
> On Thu, Nov 12, 2020 at 04:45:35PM +0100, Niklas Schnelle wrote:
>> You got to get something wrong, I hope in this case it's just the subject
>> of the cover letter :D
> 
> I suppose the change logs could be worded a little better :)

Do you think I should send a v2 with an improved message?
I just realized I'm pretty alone (and wrong) in starting
the commit message body lower case too.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
