Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05946E7719A
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 09:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hU44U59ZPnTsKkBvwI3DzhStrcSw/HP28RyLvQxokUQ=; b=1bRkWW6IbyQUkmHZ2kiPqtDJjR
	zN6Xe87xzQ/WKFUgdUhs2JIcuFQH4e7+8zxWAqhrgo+eFg/Li0HSsRIErGWYHCxSRIbOG5MVUxNVP
	iTzZygZewnehDfMSz7bMgao5sCIltRNd8Kk0tWdst8GfgzoZuxkz8rijlSuG1XX7gc5lkrNCCgbC1
	kKEsG8g2Ben3LFttxSvKIiJey7xbDNlTwniP7YHKlXq1ZrIB7vFA2KBw/2w0/claJD6ZPXhSXqIka
	63SwUQAwZNWiHjI+su9kKy4WHP8QQOatYg2tNWIwQjy9YASyJBonMmI+TiYCNWJz2O7AwWGJlYgHk
	49G+jgMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV5qA-000000046v4-3olR;
	Tue, 07 Jan 2025 09:25:35 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tV5oZ-000000046VE-0qOT
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jan 2025 09:23:56 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50785iX5017803;
	Tue, 7 Jan 2025 09:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hU44U5
	9ZPnTsKkBvwI3DzhStrcSw/HP28RyLvQxokUQ=; b=tEB/gtlz3VLBRv6TIjIeaR
	G/UoHyezU5tDf9KEiaaRTIMmOs4riVS8sX0OK8M+oHj8BXt/o2A2AfrInTAJBQEU
	97UjlEksGo2QQQ+VGPBcpM1aiX8Neond16uLrqW7yCn6flUw3nZthNzYrY26GBg2
	zuSr3YKLiD5cS2fRK8H9Q/GmyhYV8jovOKEI7oaVCGf0Okquvnwlv7fV5MWaG3XZ
	gUWJjD7oZk1ZbyJuFrNy9nvUmzJ1xfcz1C5tcfggQJ1qB6UA1eoR7BSH1S3AoADN
	Ew5OBziCAEKrqeyMFKYfmuWmJz6daZcqrS7DLvT7i++FBe8gKdzLqrJ+F2LKcPIg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4410f38a8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 09:23:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50758vfh016144;
	Tue, 7 Jan 2025 09:23:51 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygtksng7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 09:23:50 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5079Nosw31326774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jan 2025 09:23:50 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4639E5806D;
	Tue,  7 Jan 2025 09:23:50 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FE3C58056;
	Tue,  7 Jan 2025 09:23:47 +0000 (GMT)
Received: from [9.109.198.241] (unknown [9.109.198.241])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jan 2025 09:23:47 +0000 (GMT)
Message-ID: <90ae40c5-b695-4e17-8293-6a61648ed24a@linux.ibm.com>
Date: Tue, 7 Jan 2025 14:53:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] block: don't update BLK_FEAT_POLL in
 __blk_mq_update_nr_hw_queues
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, nbd@other.debian.org,
        linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
References: <20250107063120.1011593-1-hch@lst.de>
 <20250107063120.1011593-4-hch@lst.de>
 <220cdd33-527f-405d-90af-2abaace36645@linux.ibm.com>
 <20250107082145.GA15960@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250107082145.GA15960@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eE9AB5kCacSOQMekbbKXzC7-ClDhEip8
X-Proofpoint-ORIG-GUID: eE9AB5kCacSOQMekbbKXzC7-ClDhEip8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=842
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501070070
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_012355_380428_7B1C8890 
X-CRM114-Status: GOOD (  19.52  )
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



On 1/7/25 1:51 PM, Christoph Hellwig wrote:
> On Tue, Jan 07, 2025 at 12:27:35PM +0530, Nilay Shroff wrote:
>> As discussed in another thread with Damien, shouldn't we need to 
>> move bdev_can_poll() to header file?
> 
> Well, if it was needed I would have done it, otherwise the code wouldn't
> compile, would it?
> 
I think, there won't be compile error because if we look at the show function
for "io_poll" attribute under sysfs, then I see it evaluates the queue limits 
feature flag BLK_FEAT_POLL and returns the value.

>> We also need to use this 
>> function while reading sysfs attribute "io-poll", no?  
> 
> This now reports polling support when the driver declared it but
> later resized the number of queues to have no queues left.  Which I
> think is a fine tradeoff if you do that.
> 
When I applied you patch on my system and access io_poll attribute
of one of my nvme disk, I see it returns 1, though I didn't configure 
poll queue for the disk. With this patch, as we're now always setting 
BLK_FEAT_POLL (under blk_mq_alloc_queue()) it return 1. So when I haven't
configured poll queue for NVMe driver, shouldn't it return 0 when I access 
/sys/block/nvmeXnY/queue/io_poll ?  

Thanks,
--Nilay


