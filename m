Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF52E77197
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 18:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tixua4/8Yt4K/L4Isd6EPPDe8vWlwzBHW/TvX++YAOc=; b=NTCRWz/EMM2JLUCDvH3oe/7ww6
	tOK5sYLaAs2mGePG2AtlClZZkCD4EAIxgaFLVw0xqxBY+3cnJGstoMtQY93CuwEn+cRceHf2Dy7bf
	l4S6onH/xWSzD5ytDpUKnzebFnvPe/JvQAR/b+4KqeYGgQ6ROOfw6Oh8/8HQzljtZYZoYukwAtmZW
	vimO4MFh8+A8oZtFiPwkIuVHG45z8bP+0kkzdZvw6+ogR0XGHbrbMBLmwbRXSksovggEGMbdOba0m
	WwLwk7khvo+jl795rpcV05giuuMgtmYD7LpXAOzhPmEVuD0iGlqTdcSV3cYvaBVZeM/lw3JExeSV/
	ovjgXGpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVE12-00000005yKJ-1Dfp;
	Tue, 07 Jan 2025 18:09:20 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVDxF-00000005xH1-0l6H
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jan 2025 18:05:26 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507I4Ban018493;
	Tue, 7 Jan 2025 18:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Tixua4
	/8Yt4K/L4Isd6EPPDe8vWlwzBHW/TvX++YAOc=; b=Ev85Fl4ILjJFeZ02ehq/bA
	ND6HfW6sPMhkbbmSdN5HdFCqyeMrnlFUr4mYfDw6f/veaMUli4OVB4zKrruqJf14
	UsxRd7ApRVzOKkA71eVPnbAKFbOTN9dldhcBoIT60WgKyKAtJSNrjint9I1GBnxM
	W9VZbXf/R41AYBnWc0O86OA6hSJJBONOdzD98d0BkL/MOti9LXrJ00BBA9DRwX+Q
	+XqeJqNU43w+lnGJ2veTnPCCgYmlt1NdvkewPcHW2NMN5nc9m/tq9haZcwPoPvK3
	+/sMoQX5xq/4BEzmFNHJkg1WyIlN1PtwLYOFNWFs92fOZwNZ9QAkCKGvqNVJ8aNw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 440s0accw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 18:05:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 507HR8vJ027938;
	Tue, 7 Jan 2025 18:05:19 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yhhk3k95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 18:05:19 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 507I5HP023986906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jan 2025 18:05:18 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 268E458052;
	Tue,  7 Jan 2025 18:05:18 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8C3258062;
	Tue,  7 Jan 2025 18:05:14 +0000 (GMT)
Received: from [9.171.94.59] (unknown [9.171.94.59])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jan 2025 18:05:14 +0000 (GMT)
Message-ID: <1230ea6b-172d-41ae-9c11-402ae7503227@linux.ibm.com>
Date: Tue, 7 Jan 2025 23:35:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] block: fix docs for freezing of queue limits updates
From: Nilay Shroff <nilay@linux.ibm.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        nbd@other.debian.org, linux-scsi@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net
References: <20250107063120.1011593-1-hch@lst.de>
 <20250107063120.1011593-2-hch@lst.de>
 <668698f6-98d9-4e23-9ea9-ce78bafe64a5@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <668698f6-98d9-4e23-9ea9-ce78bafe64a5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jbKDqevyCgUeJ6YQW_pDfbACbntzIcE7
X-Proofpoint-ORIG-GUID: jbKDqevyCgUeJ6YQW_pDfbACbntzIcE7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 mlxlogscore=944 lowpriorityscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070149
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_100525_342943_73B0B454 
X-CRM114-Status: GOOD (  19.07  )
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

On 1/7/25 12:31 PM, Nilay Shroff wrote:
> 
> 
> On 1/7/25 12:00 PM, Christoph Hellwig wrote:
>> queue_limits_commit_update is the function that needs to operate on a
>> frozen queue, not queue_limits_start_update.  Update the kerneldoc
>> comments to reflect that.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>  block/blk-settings.c   | 3 ++-
>>  include/linux/blkdev.h | 3 +--
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/blk-settings.c b/block/blk-settings.c
>> index 8f09e33f41f6..b6b8c580d018 100644
>> --- a/block/blk-settings.c
>> +++ b/block/blk-settings.c
>> @@ -413,7 +413,8 @@ int blk_set_default_limits(struct queue_limits *lim)
>>   * @lim:	limits to apply
>>   *
>>   * Apply the limits in @lim that were obtained from queue_limits_start_update()
>> - * and updated by the caller to @q.
>> + * and updated by the caller to @q.  The caller must have frozen the queue or
>> + * ensure that there are outstanding I/Os by other means.
> 
> Maybe typo: "ensure that there are *NO* outstanding I/Os by other means"

Other than typo, everything else looks good. Once the above typo is fixed, please feel free to add:

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>



