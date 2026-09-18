Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B5CC982D9
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 08:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MFHjuaoz4ERr0WSsjThNkyjewWe29aS7GK0NR+fLQm8=; b=symb8lV/Zt43hYG9yBJzvyYM/5
	uakbdOVqEx9f1KU8hg9jxNQ//fvlZIeFdeo6hfIj6z/MFBliHim9tG4UzdoG0WT+14zN7r/7C2kEV
	uZ/9Q+6hpNh9Y7ysEHW37lSk1GaTuYWDJHpEr/gabXMElN7oDMHRmmuEFDBO90RhCzmhls8muwfcD
	J37TlGITJyfZfA1TfW+OwIiHSqUH9YBBs2BqRaglLFAbVimgFMtlC3il3obVQnTOt76MPqQiOhMar
	f4axdooWn0txXUlyLOcoP/UuVkH5zqVKeC6wF83ZxAyIYzU8OYEPF/IR0iJxx3CalNByxT2qWxxOO
	EzUJuL6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7UR3-0000000DsKP-0ejD;
	Fri, 18 Sep 2026 08:59:09 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7UR0-0000000DsK2-3lI6
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 08:59:08 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I61anT498282;
	Fri, 18 Sep 2026 08:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MFHjua
	oz4ERr0WSsjThNkyjewWe29aS7GK0NR+fLQm8=; b=RqJUtE3ox/YnGV2ZTLCd4/
	DpKdw7fGNtsc9hAeYAzODaMP09Lt76fU6ne8J3KUNRd8D4j2THncQ71CNfVAi9Ye
	UGCdueVm3cH11oMPC3Po4IUbmitG0b84ShawvXZvS7NnMs+LzKQDjHe1917noef4
	EwegdWcJ0OkSt3MEwvYwgBFVcTa5/eJsDoxLgWCuKJUkJwlfYqKC8NbFVgjKq6CM
	lFthAnl73YmXjnv6jqXiwjBXgOemNrWN3msy+btHTAu1qdcPX6szYGrxD/xKModw
	sn72JL+trFmwGQzi7Lm9rKVXQXN9USUbKo4oz6o4QSJbtdHqDLAP2K/hwjq1BFrQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcvehr5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:58:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I653aM246091;
	Fri, 18 Sep 2026 08:58:55 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr5ffekas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:58:55 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68I8wsSA28574286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 08:58:54 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 719315804E;
	Fri, 18 Sep 2026 08:58:54 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D20F58054;
	Fri, 18 Sep 2026 08:58:50 +0000 (GMT)
Received: from [9.61.58.220] (unknown [9.61.58.220])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 08:58:49 +0000 (GMT)
Message-ID: <7b9e6dc8-6d44-4bfa-9c3c-9e51a5ba643f@linux.ibm.com>
Date: Fri, 18 Sep 2026 14:28:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-multipath: add fail_if_no_path sysfs attribute
To: Krishna Iyer <kiyer@crusoe.ai>, linux-nvme@lists.infradead.org,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>
Cc: SeongJae Park <sj@kernel.org>, Saravanan D <saravanand@crusoe.ai>,
        linux-kernel@vger.kernel.org
References: <20260917231647.79956-1-kiyer@crusoe.ai>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260917231647.79956-1-kiyer@crusoe.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDExNyBTYWx0ZWRfX/4Yhi2FYg16u
 6N5LKmINE1BGoPIJqaDZO9q/yHny1JLg/O9PCF1J2gwDOSNC6V3MpRB1zfGK0riGbC8uWSOZbx4
 xyAQR5NXkYtOd27gg/N7m1rbYOrgg8w=
X-Proofpoint-ORIG-GUID: 1tav0ShUU1oGP4q9LUsNUcTVVRZicn1p
X-Proofpoint-GUID: 1tav0ShUU1oGP4q9LUsNUcTVVRZicn1p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDExNyBTYWx0ZWRfX+G8DfdN4K1MD
 LJr0dIvUzlYakag+k2N9mm7N+LBb7uzxWqNWitgOD8oZHZazVYceUViECEl+nZ4+vTgDS55UO5R
 90HVz5LddlQBhEgDH5gM5h34/Z8neuq+uEbVZBsYQCh9fytWG98ZRJiy+xBPkmmG6ZOwvTVIsZm
 A4EE07STAJtEb88YcnaSeUhteAkPqIALzSQmFGGfhP6Xp0ndlUe1rg8oxCLYo7G7HIIrQJP3hZi
 4PdrndgeLTiKyZAJF/1aDaHXJgQZX/rnuf8g58LZa5j1cXE236pQlvNUXeoRzvM/ixj5KZZOn/y
 jfw2dXJXJPI1Bgf8E+GVkZQVR6E03xLVnF1drOv9Nfj1/jFbQjVMzfAl6HC/doduQKJPE1Yv4KO
 VeKVyv5u24/bkB9nrayeSxdUXCNEWqdvLGpOuA7dDTrHrtmetikNyc3HFQP+0+HZ+EaQfeIrtHk
 +K8DG1/VqPhB/fFgTdg==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aacfd4f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=B9cS5ykv82s0ofZVmBsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180117
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_015907_056080_C0E31719 
X-CRM114-Status: GOOD (  20.61  )
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

On 9/18/26 4:46 AM, Krishna Iyer wrote:
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 3d46c4f28a47..23aeb1737ab5 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -499,6 +499,8 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
>   static bool nvme_available_path(struct nvme_ns_head *head)
>   	__must_hold_shared(&head->srcu)
>   {
> +	bool fail_if_no_path = test_bit(NVME_NSHEAD_FAIL_IF_NO_PATH,
> +					&head->flags);
>   	struct nvme_ns *ns;
>   
>   	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
> @@ -510,14 +512,25 @@ static bool nvme_available_path(struct nvme_ns_head *head)
>   			continue;
>   		switch (nvme_ctrl_state(ns->ctrl)) {
>   		case NVME_CTRL_LIVE:
> +			if (fail_if_no_path &&
> +			    (ns->ana_state == NVME_ANA_INACCESSIBLE ||
> +			     ns->ana_state == NVME_ANA_PERSISTENT_LOSS))
> +				continue;
I think we have helper nvme_state_is_live() which could be used here.
  [...]

> +static ssize_t fail_if_no_path_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct gendisk *disk = dev_to_disk(dev);
> +	struct nvme_ns_head *head = disk->private_data;
> +	bool enable;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &enable);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (enable)
> +		set_bit(NVME_NSHEAD_FAIL_IF_NO_PATH, &head->flags);
> +	else
> +		clear_bit(NVME_NSHEAD_FAIL_IF_NO_PATH, &head->flags);
> +
> +	/*
> +	 * Ensure that update to NVME_NSHEAD_FAIL_IF_NO_PATH is seen
> +	 * by its reader.
> +	 */
> +	synchronize_srcu(&head->srcu);
> +
> +	/* Make already-queued I/O re-evaluate path availability. */
> +	if (enable)
> +		kblockd_schedule_work(&head->requeue_work);
> +
If the user stores the same value as the current setting, we could
return immediately instead of waiting for synchronize_srcu() and
scheduling the requeue work.

Otherwise changes look good.

Thanks,
--Nilay


