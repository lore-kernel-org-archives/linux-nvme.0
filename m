Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95FEE9B36F
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 12:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ws+SXhVs9EvRkLaA4gItpx5Qa/UstrEf9daIcO86wYE=; b=Hy98o26kF6aY4VxPQDd45pG+Eo
	iqixltf1L+tX2pLGFmKN4Em0l3AKi17T7rEO2Pn28QMxjSKfuzzi/Y0TqlPuCDm5hpCm6cRaT80Y7
	cKR4NmWzJAmLDqCTV6FJrzEp/dZ+7pFUGX9oyZtXpQRgqo+H9zL2XP1r4Us8/e5kGT3Nk9qeZgmN7
	3Yu5xk3U3PCCHaBfP8kgTj4Xktwg7Ms9RMjfQinZTc/iiUAH7JUXUWIQ016CPnFrvvAJkPvQXQuwh
	W3r7rQQo0dp89TS7GnypQkl2TmDUAnCeBGXVdpbYLW26Bo3M8agPbn6Pk+9qexMfC3/TFnoCc8kLB
	qSa2GdAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx2Z1-0000000D0fe-0Z35;
	Mon, 02 Mar 2026 12:39:55 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx2Yy-0000000D0ef-3e23
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 12:39:54 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6220qXc82350591;
	Mon, 2 Mar 2026 12:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ws+SXh
	Vs9EvRkLaA4gItpx5Qa/UstrEf9daIcO86wYE=; b=NivFBKyEp2GoGT1oNm0KeU
	Ido814ZOfIuf/QWNyzPy0JWsb0KhANXLt3yWa+PL9jneFJiDgjsn022dx1lqA5nS
	n+usnrgR3cNXt79B845XVnAYn2lMQpQ0112FWSz/GmSf8RPwHbCEC/Ngc+0iydsz
	laegcbT0hnJbirY/JRH1vBpdhBNg76qcGS9dPmX0flHtCuMxboQYAYM3OZA6/W0w
	LBo9/PrIbk9LmJzQkY0Dao6VBPyRoTMGW/vU0q94WYmN/1ctZYrVk9iqQ7r+OWnV
	nfjDXU6M8xopf6LaYoA3QIPf4ahbk2H968lWsH7+wzegA2q3suF6SXaTxzc/0CZQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksk3pc6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 12:39:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 622Aj209027692;
	Mon, 2 Mar 2026 12:39:46 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmcwj5t3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 12:39:46 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 622CdjXV55116156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2026 12:39:46 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF0325805F;
	Mon,  2 Mar 2026 12:39:45 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C5535805A;
	Mon,  2 Mar 2026 12:39:40 +0000 (GMT)
Received: from [9.79.192.112] (unknown [9.79.192.112])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Mar 2026 12:39:39 +0000 (GMT)
Message-ID: <a6ffe0f5-7ec3-423c-8702-cf4248fdc168@linux.ibm.com>
Date: Mon, 2 Mar 2026 18:09:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] libmultipath: Add bio handling
To: John Garry <john.g.garry@oracle.com>, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@fb.com, martin.petersen@oracle.com,
        james.bottomley@hansenpartnership.com, hare@suse.com
Cc: jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, michael.christie@oracle.com,
        snitzer@kernel.org, bmarzins@redhat.com, dm-devel@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260225153225.1031169-1-john.g.garry@oracle.com>
 <20260225153225.1031169-5-john.g.garry@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260225153225.1031169-5-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0a2LGJPmlm5lotNgx1QeK2BUAhw-jWHz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEwNiBTYWx0ZWRfXyGjMFWp7e3Qk
 RSz6moxPqwFy7fIUKGYu7M/wLijL5CjkRdJZKFdOMWKkga0zQxObL7grReTJvPabblcTzlGxCzS
 LK93E4qn+cni3B4w9TaB4gF0KzU54c3QtqE4b5vKimhM7p98YuSaexpdjtaXC7S+mhLm8RsdKAN
 ieRBQ1M/WfbpP+VHBHNsFRaGRA4dqmW2y1aa8WDXRFSc9XNfIJoaaW6nrq6A1g4zwCluJqHFBol
 /T1HtHfLvMuAQPNwRvfwEFGzxGZ8uexSUYMk9798B1wVWG2rOf3eTBpqnWTdQr2qZ53WSnreOHq
 zKfWEx6ElggRjXWz7RADkQulCfRojjb30snH/FqXFQOAX70qM9Dbomz8lOBx+FZ4q89cWmhHTHB
 9nyG3gpXeiIsOx2fmy5Xrl9AoMSlnDUq0RGlqIjHgjm+JZQJxvVv5Rv8TBVfVcoLx0YHwZF6HAu
 LjW+jkbK+A9d1Q3DMVg==
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69a58513 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=yPCof4ZbAAAA:8
 a=mrUUIEsjvcAo0JqLu1IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0a2LGJPmlm5lotNgx1QeK2BUAhw-jWHz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020106
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_043953_085655_B79371B2 
X-CRM114-Status: GOOD (  28.50  )
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

On 2/25/26 9:02 PM, John Garry wrote:
> Add support to submit a bio per-path. In addition, for failover, add
> support to requeue a failed bio.
> 
> NVMe has almost like-for-like equivalents here:
>      - nvme_available_path() -> mpath_available_path()
>      - nvme_requeue_work() -> mpath_requeue_work()
>      - nvme_ns_head_submit_bio() -> mpath_bdev_submit_bio()
> 
> For failover, a driver may want to re-submit a bio, so add support to
> clone a bio prior to submission.
> 
> A bio which is submitted to a per-path device has flag REQ_MPATH set,
> same as what is done for NVMe with REQ_NVME_MPATH.
> 
> Signed-off-by: John Garry<john.g.garry@oracle.com>
> ---
>   include/linux/multipath.h | 15 +++++++
>   lib/multipath.c           | 92 ++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 106 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/multipath.h b/include/linux/multipath.h
> index c964a1aba9c42..d557fb9bab4c9 100644
> --- a/include/linux/multipath.h
> +++ b/include/linux/multipath.h
> @@ -3,6 +3,7 @@
>   #define _LIBMULTIPATH_H
>   
>   #include <linux/blkdev.h>
> +#include <linux/blk-mq.h>
>   #include <linux/srcu.h>
>   
>   extern const struct block_device_operations mpath_ops;
> @@ -40,10 +41,12 @@ struct mpath_device {
>   };
>   
>   struct mpath_head_template {
> +	bool (*available_path)(struct mpath_device *, bool *);
>   	bool (*is_disabled)(struct mpath_device *);
>   	bool (*is_optimized)(struct mpath_device *);
>   	enum mpath_access_state (*get_access_state)(struct mpath_device *);
>   	enum mpath_iopolicy_e (*get_iopolicy)(struct mpath_head *);
> +	struct bio *(*clone_bio)(struct bio *);
>   	const struct attribute_group **device_groups;
>   };
>   
> @@ -56,12 +59,23 @@ struct mpath_head {
>   
>   	struct kref		ref;
>   
> +	struct bio_list		requeue_list; /* list for requeing bio */
> +	spinlock_t		requeue_lock;
> +	struct work_struct	requeue_work; /* work struct for requeue */
> +
>   	unsigned long		flags;
>   	struct mpath_device __rcu 		*current_path[MAX_NUMNODES];
>   	const struct mpath_head_template	*mpdt;
>   	void			*drvdata;
>   };
>   
> +#define REQ_MPATH		REQ_DRV
> +
> +static inline bool is_mpath_request(struct request *req)
> +{
> +	return req->cmd_flags & REQ_MPATH;
> +}
> +
>   static inline struct mpath_disk *mpath_bd_device_to_disk(struct device *dev)
>   {
>   	return dev_get_drvdata(dev);
> @@ -82,6 +96,7 @@ int mpath_set_iopolicy(const char *val, int *iopolicy);
>   int mpath_get_iopolicy(char *buf, int iopolicy);
>   int mpath_get_head(struct mpath_head *mpath_head);
>   void mpath_put_head(struct mpath_head *mpath_head);
> +void mpath_requeue_work(struct work_struct *work);
>   struct mpath_head *mpath_alloc_head(void);
>   void mpath_put_disk(struct mpath_disk *mpath_disk);
>   void mpath_remove_disk(struct mpath_disk *mpath_disk);
> diff --git a/lib/multipath.c b/lib/multipath.c
> index 65a0d2d2bf524..b494b35e8dccc 100644
> --- a/lib/multipath.c
> +++ b/lib/multipath.c
> @@ -5,6 +5,7 @@
>    */
>   #include <linux/module.h>
>   #include <linux/multipath.h>
> +#include <trace/events/block.h>
>   
>   static struct mpath_device *mpath_find_path(struct mpath_head *mpath_head);
>   
> @@ -227,7 +228,6 @@ static struct mpath_device *mpath_numa_path(struct mpath_head *mpath_head,
>   	return mpath_device;
>   }
>   
> -__maybe_unused
>   static struct mpath_device *mpath_find_path(struct mpath_head *mpath_head)
>   {
>   	enum mpath_iopolicy_e iopolicy =
> @@ -243,6 +243,66 @@ static struct mpath_device *mpath_find_path(struct mpath_head *mpath_head)
>   	}
>   }
>   
> +static bool mpath_available_path(struct mpath_head *mpath_head)
> +{
> +	struct mpath_device *mpath_device;
> +
> +	if (!test_bit(MPATH_HEAD_DISK_LIVE, &mpath_head->flags))
> +		return false;
> +
> +	list_for_each_entry_srcu(mpath_device, &mpath_head->dev_list, siblings,
> +				 srcu_read_lock_held(&mpath_head->srcu)) {
> +		bool available = false;
> +
> +		if (!mpath_head->mpdt->available_path(mpath_device,
> +				&available))
> +			continue;
> +		if (available)
> +			return true;
> +	}
> +
> +	return false;
> +}

IMO, we may further simplify the callback ->available_path() to return 
true or false instead of passing the result in a separate @available 
argument.

Thanks,
--Nilay



