Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6D5E9B372
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 12:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S6a8y8thvqGz68SdposE1yh0zGtQahWh18yyJBA8xJY=; b=1mN+aG9lNStEy+mRCbep2IOXAA
	TBhPDXZ3/g6Kt9OFDEmIRv8gmh+kGh1MzbcTv9x0cN4MlpGLpxV/cG3r4EPCDnS8j+9VGWkOHsOvf
	H31qDc8IfTHDjY4u7lfMa4u1G1N/p8t1yjJ6KtJT4ycq+ifPNm0DuqNOmprE2/L4EjzniLoytxgl4
	+ExmjgJv7pHj+IDCWmP0lBJROy5II9B1jDCzjjTT3Qx6OwXHZ630lVEn3xBQCDToyPcwcGbW3hcIY
	3gYv/VeU2ML+gVCwvx7V8Wc8Akt4XP8ayd3+dwym6U9EKeGGICWwmCKG3y173mVRZYjZ/CJSz2keH
	HgfThvPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx2hm-0000000D27U-0S0R;
	Mon, 02 Mar 2026 12:48:58 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx2hk-0000000D26v-27Nu
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 12:48:57 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 621JuGwe2134901;
	Mon, 2 Mar 2026 12:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=S6a8y8
	thvqGz68SdposE1yh0zGtQahWh18yyJBA8xJY=; b=FMZ0GxTHK2jxJCNBNbdfnS
	tp3ucp/9AHoLl9jeh5GWEN+X83wmHBpzNI5Rfhw1Cie8nQqXUIVhh9m4fAnKIOn/
	VsfNAcMsdAfkeL875U7Goveq34Gc21nG3x0TVSuylp2o3tcCFIUkHSc53IpGlX2k
	RETJ4qx4uYrqMwiYWa4+jn6uGTz6GHIBUAPDpKkuCCQ1YpxpNqcektcV1rIXSYfa
	efe5nOPuOIIRYSQ7npufcAQOrxQWPzqS4zPSpc/Mafl8rYk0I7/eH3oaOH6ywFER
	bBKK/+vNiFOCORWiesjIBjLmqGwJj/nEmw74SzqoG66sNbanyZq1WNX1ia+W0Myg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksrhxkr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 12:48:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 622Awdoc008779;
	Mon, 2 Mar 2026 12:48:49 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmdd15sy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 12:48:49 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 622Cmmcr26346072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2026 12:48:48 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B21158051;
	Mon,  2 Mar 2026 12:48:48 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5F165805C;
	Mon,  2 Mar 2026 12:48:42 +0000 (GMT)
Received: from [9.79.192.112] (unknown [9.79.192.112])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Mar 2026 12:48:42 +0000 (GMT)
Message-ID: <82090fb6-7cdc-40e0-98a7-21b688aaeefc@linux.ibm.com>
Date: Mon, 2 Mar 2026 18:18:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/19] nvme-multipath: add nvme_mpath_{add,delete}_ns()
To: John Garry <john.g.garry@oracle.com>, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@fb.com, martin.petersen@oracle.com,
        james.bottomley@hansenpartnership.com, hare@suse.com
Cc: jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, michael.christie@oracle.com,
        snitzer@kernel.org, bmarzins@redhat.com, dm-devel@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260225154007.1033735-1-john.g.garry@oracle.com>
 <20260225154007.1033735-17-john.g.garry@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260225154007.1033735-17-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Rp/I7SmK c=1 sm=1 tr=0 ts=69a58732 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=yPCof4ZbAAAA:8
 a=ugQ3dgLpbsxIGXIanpkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEwNiBTYWx0ZWRfXzEalYYr+61kH
 etnmA0zGnnv7vfemNVr5hqvxHgj46JKMkOF8Yf4BV1FKQwiEsNwEnNwR80FaaqGYLJEuvHQN39F
 A/FKlN0MxYg0X1cUa6pKeXJvTc6viNHKzhC5qKIDoL0nJhY7b/oPo7X4SpdHNtM+qEF3/tD/ExZ
 3OK37ZLPcz6ql0I6SKl1rK2xjEGLVUkVn5kuv+eNfr+jhU0yA7mwHbZR/OTAswuuTi0+tMfHTyT
 JKBgapU3KkLNWUWE/UfiL2UP8eL3nbA6/v40kW2IafSlm2W1m5zj8xw0OxQC3jgLnkQD19VSgOk
 wLnWZula8cG1IQCbdaYGna6OMFfl1d6NEzjJNpmUAvJpwh3HsJZNtwdlLVrPVpoHCPT33J6wtmT
 e3kvgns0n3WtpNV3P9Uiu1AN4CzlmYhZW7hHETi841lrPHMlxMNShswwiEm/99syhdQxJNuHcrR
 y4lCqEKD6xFutzonw9Q==
X-Proofpoint-GUID: vnYz560JBUrvbE9RhXT8t9DlHlRiTd_H
X-Proofpoint-ORIG-GUID: vnYz560JBUrvbE9RhXT8t9DlHlRiTd_H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020106
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_044856_552636_D2A0A152 
X-CRM114-Status: GOOD (  19.87  )
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

On 2/25/26 9:10 PM, John Garry wrote:
> Add functions to call into the mpath_add_device() and mpath_delete_device()
> functions.
> 
> The per-NS gendisk pointer is used as the mpath_device disk pointer, which
> is used in libmultipath for references the per-path block device.
> 
> Signed-off-by: John Garry<john.g.garry@oracle.com>
> ---
>   drivers/nvme/host/multipath.c | 26 ++++++++++++++++++++++++++
>   drivers/nvme/host/nvme.h      |  8 ++++++++
>   2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 7ee0ad7bdfa26..bd96211123fee 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -982,6 +982,32 @@ void nvme_mpath_synchronize(struct nvme_ns_head *head)
>   	mpath_synchronize(mpath_disk->mpath_head);
>   }
>   
> +void nvme_mpath_add_ns(struct nvme_ns *ns)
> +{
> +	struct nvme_ns_head *head = ns->head;
> +	struct mpath_disk *mpath_disk = head->mpath_disk;
> +	struct mpath_head *mpath_head;
> +
> +	if (!mpath_disk)
> +		return;
> +
> +	mpath_head = mpath_disk->mpath_head;
> +
> +	ns->mpath_device.disk = ns->disk;
> +	mpath_add_device(mpath_head, &ns->mpath_device);
> +}

As we have now reference to mpath_device from struct nvme_ns
then why do we still maintain reference to ns->disk? We may
want to directly access path device disk using ns->mpath_device.disk,
makes sense?

Thanks,
--Nilay

