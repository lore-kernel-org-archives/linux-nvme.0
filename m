Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE1FE77198
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 09:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nqt19LjA7V6SFxJ3HfBT8AU+vaazARI3YF1sz5W0Vfg=; b=hWHak3zxiGFhn/FSiIDh6ChHmJ
	ttZi2qsWOOHxTs/rEcG7nyPzfQeiE8YBZTg+kBFZXvDacwH9jXwMXHdH5rVDks6PXucvToL2oZvuV
	iY0+Kn7XO3RSmccnY2oWTnv7m3yuOR/6GRp/rB7bl+kCVNyQA6u4r/XUsUeG1Idhqq+Wuz2URM2rp
	HqB4LTVOhWyG6tfYc7DF/JFK5IzeTG/Lyd6oB+ftRdjVVGGtY4XSxxSnJH8O3DGI7KY2bTeKPzWnI
	RyW6wNnpypMsiLtJBhjaEcYcN9U6YxVd8hqtf3cuqXza7m0Zw0+/TwC6T/BZf/XHfcdl+zxggqFX3
	uoYRVb9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV5tu-000000047p5-22hu;
	Tue, 07 Jan 2025 09:29:26 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tV5tr-000000047ny-1ShE
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jan 2025 09:29:24 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 506NaH29007319;
	Tue, 7 Jan 2025 09:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Nqt19L
	jA7V6SFxJ3HfBT8AU+vaazARI3YF1sz5W0Vfg=; b=o10GpuTNcyBlukFrThp6Bu
	K7cw3v/Vrlj73CvrsSZm2+vFHwXOhAnQ3E7CAYuctevI9RhUD227dedNlMs0Fj9h
	E38Hr5bVaCEOVah+5/XxYOSQJ6hKnhsgnkNWiUEN7pQxbcEBDXZvY9vgXjYyY01G
	0KgpmF/SscNVW+0jCx7k2Psz3KT+LiNgnUcZi6mDbxGn+sY6sv9ocWiUOrofZ6O9
	NVUjkwkHfwrvh0Wi2xO7DfYr3Vkz3cAdfceezw3iMZCpFOaNRS72cD2qIPNXpZNn
	PW2AWss2+Uqafkn7pplBoL8cyzaUnVKM/lWWrSaWIt9Y0BWefAGPQhzHTBLOazpA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 440s0a9yn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 09:29:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5075lY9X027963;
	Tue, 7 Jan 2025 09:29:19 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yhhk1k3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 09:29:19 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5079TIOr23855864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jan 2025 09:29:18 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDFD458074;
	Tue,  7 Jan 2025 09:29:17 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9A9258056;
	Tue,  7 Jan 2025 09:29:14 +0000 (GMT)
Received: from [9.109.198.241] (unknown [9.109.198.241])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jan 2025 09:29:14 +0000 (GMT)
Message-ID: <de4159dd-d0c8-4638-9c2f-c2d4fd1c64a6@linux.ibm.com>
Date: Tue, 7 Jan 2025 14:59:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] nvme: fix queue freeze vs limits lock order
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, nbd@other.debian.org,
        linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
References: <20250107063120.1011593-1-hch@lst.de>
 <20250107063120.1011593-7-hch@lst.de>
 <96c48ba0-3db5-4504-a456-e57440aa1b56@linux.ibm.com>
 <20250107082224.GB15960@lst.de>
 <263963d9-ac40-4f87-b38a-edb4202d294c@linux.ibm.com>
 <20250107085825.GA16827@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250107085825.GA16827@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EwIytq_W9xmRz7cg4BLBWcJ2PsLco0gO
X-Proofpoint-ORIG-GUID: EwIytq_W9xmRz7cg4BLBWcJ2PsLco0gO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 mlxlogscore=753 lowpriorityscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070079
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_012923_517916_3C324781 
X-CRM114-Status: GOOD (  13.64  )
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



On 1/7/25 2:28 PM, Christoph Hellwig wrote:
> On Tue, Jan 07, 2025 at 02:15:05PM +0530, Nilay Shroff wrote:
>> The nvme_set_ctrl_limits() sets certain queue limits which are 
>> also used during IO processing. For instance, ->max_segment_size
>> is used while submitting bio.
> 
> nvme_set_ctrl_limits only sets them in the on-stack queue_limits
> structure, which is local to the calling thread.
> 
> 
Oh yeah, I didn't notice it while reading patch. Agreed, we don't 
require freezing queue here. Sorry for the noise.

Thanks,
--Nilay

