Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D2D4E77197
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2025 09:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l/LNgdJ3X41kyHYEfqchK/B/OMLKba7Bna5ZeeYJCcc=; b=47I+T5RCo6K8Z4KwY4P61sanpE
	93E4BwZ/B2FZ+m36lp7xkpH7xSo5coxZ/bZQC2lZRe+X7nDuhLIidDpB+S7zyAnCAn/Vp6BLaQg2p
	6YKTQIMF2oyF/OnnthwamKkvqgooW/37OtpEsRaz2A78Q+cPQSXVfdO5LqbBYeaR6wMgvXv5ElHvz
	uORgoxgjTgPQVKL2qjRejS1gBINVVBIyYPO36PU8EICMXRRihJJd/xZtqtJ4ATjjLC/IKtbWVS1kg
	jv5MX4ZK/xzNoasaOaCVwz08et8vjo0l8UgVgsogc2bVN0ZoPJ/qpDQ2XTxthD6If/qmIK1cYdMlO
	UnxsVyRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVoYS-0000000BHhe-3Q4T;
	Thu, 09 Jan 2025 09:10:16 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVoSX-0000000BGKr-14jK
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jan 2025 09:04:10 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5093qUu9005305;
	Thu, 9 Jan 2025 09:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=l/LNgd
	J3X41kyHYEfqchK/B/OMLKba7Bna5ZeeYJCcc=; b=aJFhay3J9HTWE2hibWgZeS
	g+/WwRAK9JGUfR/yegoeYOFMgjj2eEBwCgsk/Eq6mqhD9+eBxvQutP/GSRpo3Ghn
	X2TDz7VFDOf0yvGvf8yG6C4w4lNva5+3a28T+e52mvhLEQmH2/KCuVaJT47zknvW
	e2TgZqR/3coetnLSjFUGobpkygN2zs4TdxytONSl3gu9UTIJEEU0TQwck+6KrtKT
	Xr+XKdBPmnLPUcBQ2qQPvKbmq/ptRVTmnflfwzrg75h9kupw6qB/1865SxfKzLKn
	g1ovZO/9Kvcr1u8Ed6V4g1wvTYzol8gOhxf6xcvIwkG8txL/y3YvV8iKFXjDvCrw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4426xc96su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 09:04:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5098CpGM008869;
	Thu, 9 Jan 2025 09:04:04 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43yfq04g13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 09:04:04 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 509943kb31654642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jan 2025 09:04:03 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C53E95805D;
	Thu,  9 Jan 2025 09:04:03 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EB3D58058;
	Thu,  9 Jan 2025 09:04:00 +0000 (GMT)
Received: from [9.171.90.198] (unknown [9.171.90.198])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jan 2025 09:04:00 +0000 (GMT)
Message-ID: <c35b5ece-e346-43a7-8e6b-8c8abdba6f50@linux.ibm.com>
Date: Thu, 9 Jan 2025 14:33:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] block: check BLK_FEAT_POLL under q_usage_count
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        nbd@other.debian.org, linux-scsi@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net
References: <20250109055810.1402918-1-hch@lst.de>
 <20250109055810.1402918-4-hch@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250109055810.1402918-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K5lR1t4kQGyPizKm16dwYsbsFGZOWOe8
X-Proofpoint-ORIG-GUID: K5lR1t4kQGyPizKm16dwYsbsFGZOWOe8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=723 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501090074
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250109_010409_438012_FE92A790 
X-CRM114-Status: GOOD (  11.90  )
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



On 1/9/25 11:27 AM, Christoph Hellwig wrote:
> Otherwise feature reconfiguration can race with I/O submission.
> 
> Also drop the bio_clear_polled in the error path, as the flag does not
> matter for instant error completions, it is a left over from when we
> allowed polled I/O to proceed unpolled in this case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me:

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

