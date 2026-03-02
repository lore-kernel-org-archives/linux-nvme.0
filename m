Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C56EE9B376
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 12:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HGxsnLYfy9kHPdT/nhG4VlprNXrSE18ZkeT+apwbbHo=; b=pPwXuxQotQA9riXJj04rjwoze5
	YrOHQK/TWZQ+99rR/ozORKBROfX7j5db+p4HyeoQhswe6NleKby1hktbg303gCJYUUgJwyfcLN5cl
	6bSkyas9mLNPV9AqgBZp6C5YdXKjEFujAum6ztHO45rirz79Dr8WIoOzpHWyk8K/7CWf0bgm9RHsQ
	WB9zz+wsYS8i2sry0BtratSq8pEpPNLU/pzgN0enbbbU7TUWWXMDazjYUjD0qxgv3sPu19zrPvk8H
	MMiy7OIV8WhLHkNntODIAZmrQqsm5dHBW161wfMHexDPePCokobC2XDyZLgXUPoqWUi6yjsVRvDXP
	picH256A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx2q3-0000000D2t6-0P4P;
	Mon, 02 Mar 2026 12:57:31 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx2q1-0000000D2sf-16Td
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 12:57:30 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 621KiDCG1941479;
	Mon, 2 Mar 2026 12:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HGxsnL
	Yfy9kHPdT/nhG4VlprNXrSE18ZkeT+apwbbHo=; b=j1HJk5Micy3UEBWVybBLb4
	y/CoykrpD+y5spqD4mq7pRQ4RqYy/VdMN+op1dnRE5kCwDPk4FP4/r4WOa+ywACw
	9924BaKbvbomfZ2M48lB+8TIPsi2Tt25IFvNw48O/v9czGCuqoS6xh+oMElnkFJg
	lFnaeN0UxC7wxbgCZ6jTBasRb+7EH5j905TQxls3Gnp6ehgiVb/qyR6q2k+7ziYh
	lrk+xgUDlpBeBLRPBnpKjE6b1WBeC1QucUSC/W8PVVRFD9MgtnmKQsYBEfNVZI/D
	K7xAFibvHzzq4RNxtqSCOUEl6TwFuDb1/TdBktnuJr5sDg8PCChEh/M0T0eMKGLg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckssmef16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 12:57:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 622AOjTE027704;
	Mon, 2 Mar 2026 12:57:19 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmcwj5w68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 12:57:19 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 622CvI4162718236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2026 12:57:18 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CA325805E;
	Mon,  2 Mar 2026 12:57:18 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFC635805C;
	Mon,  2 Mar 2026 12:57:12 +0000 (GMT)
Received: from [9.79.192.112] (unknown [9.79.192.112])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Mar 2026 12:57:12 +0000 (GMT)
Message-ID: <bfc2bfa4-a28d-47dc-9362-b9ff6680cfab@linux.ibm.com>
Date: Mon, 2 Mar 2026 18:27:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/19] nvme-multipath: switch to use libmultipath
To: John Garry <john.g.garry@oracle.com>, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@fb.com, martin.petersen@oracle.com,
        james.bottomley@hansenpartnership.com, hare@suse.com
Cc: jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, michael.christie@oracle.com,
        snitzer@kernel.org, bmarzins@redhat.com, dm-devel@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260225154007.1033735-1-john.g.garry@oracle.com>
 <20260225154007.1033735-20-john.g.garry@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260225154007.1033735-20-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEwNiBTYWx0ZWRfX08ZG4mfYdE6+
 Pgtc0Q/jGKa+jDQNE0D+GrQjHKgMnFzoHCqSu1ifqjMpkeREbPJtmEaIO9GDdlyqoix0A4iKnHM
 cWPTqmGukRD+IAgnETbDg4A6HsMmzcl3mFPG7whALYPLnrPwsfSmk1d1HmZsuB3/sJnjvrcC+ws
 jrR24Dv2Nb41sT1mxJEx7tjCxkwzHlmsRf/oGegnyhGZfHMj7tY/ZXlIJfTJgNj+4eYSdTHnN23
 VToJkQiBTVF7qOd756gghV+boAmuRDWm+lRlynZeh1XKhyAQJZ4pBkmcVgZ7y/gwxByv15H44fi
 ih3mFr+3mKU1Jx+t5maDc4pBFEK1wLhsR/5WxfDXr+lGl9dlfVYLVIU354rQFSrtrdOF+X+vi1s
 /jrdGPpTmejHF9fPkuh+jbj3TYi0P2fTwTjgcFf7fs9l9egIJER25DB/fhJCYN66PvOFOO/v2yQ
 I6RLWIDDP3LRYFqC9Xw==
X-Proofpoint-ORIG-GUID: 9hUb9hBF3IRM0ca70u5en9RE3Z-TTG7C
X-Proofpoint-GUID: 9hUb9hBF3IRM0ca70u5en9RE3Z-TTG7C
X-Authority-Analysis: v=2.4 cv=AobjHe9P c=1 sm=1 tr=0 ts=69a58930 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=CpEX-UuAubdY51wu2XgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020106
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_045729_430261_46BF1FC0 
X-CRM114-Status: GOOD (  15.53  )
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
>   void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
> @@ -277,30 +279,35 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
>   	srcu_idx = srcu_read_lock(&ctrl->srcu);
>   	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
>   				 srcu_read_lock_held(&ctrl->srcu)) {
> +		struct nvme_ns_head *head = ns->head;
> +		struct mpath_disk *mpath_disk = head->mpath_disk;
> +
> +		if (!mpath_disk)
> +			continue;
> +
>   		nvme_mpath_clear_current_path(ns);
> -		kblockd_schedule_work(&ns->head->requeue_work);
> +		kblockd_schedule_work(&mpath_disk->mpath_head->requeue_work);
>   	}
>   	srcu_read_unlock(&ctrl->srcu, srcu_idx);
>   }
>   
> +static void nvme_mpath_revalidate_paths_cb(struct mpath_device *mpath_device,
> +					sector_t capacity)
> +{
> +	struct nvme_ns *ns = nvme_mpath_to_ns(mpath_device);
> +
> +	if (capacity != get_capacity(ns->disk))
> +		clear_bit(NVME_NS_READY, &ns->flags);
> +}
> +

I don't quite understand the intent of the above function.
Here I see that we compare mpath_disk capacity with per-path
disk. Do we really have sectors allocated for mpath_disk?

Overall, IMO abstracting out common multipath function into
a separate library is a good move. But then I just want to
understand layering here with libmultipath. Does it sit above
the driver or below? I see in some places we have back and forth
callbacks from driver to libmultipath and then back to the
driver, for instance:
nvme_mpath_add_disk          => driver
  -> mpath_device_set_live    => libmultipath
   -> mpath_head_add_cdev     => libmultipath
     -> nvme_mpath_add_cdev   => driver

Does this intentional? Or am I missing overall picture...

Thanks,
--Nilay


