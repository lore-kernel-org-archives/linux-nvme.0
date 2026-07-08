Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADFDC43458
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2026 13:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d6hzTvTdzgqUTLjlgTVXyubUz2RRjrvCphV9Lw7UDSs=; b=qgkPLh0c/iwaNM9M0WCGK1XkVx
	GjQn+/BySg5gDM/FfBDTzjMKDzOvwlA1CL8hkJpUO1flD9nky58MS+AK5+DKizyjQI1MISkv8DLEc
	mdBifqcNXvW0BCEv1guSQ2qpN1aGx88JboMnOzGPSxVYOPC3wMFF4BMzaRcY9F50qC1GDXHv00FJF
	/MnoOeRaKshUi12t0E0OsqCrgrZ/kO+enVr/xRG0MVKoJn4HJsmEg0OK0PY8iBWP6SKqhlOuokeIs
	KkJLcFK1kRejQ+LXZex+VC6jESazy7qYkOXA7vGUs1drC8U8VoN3Wurgz9UbrLAPIDEKDprPWgto+
	wABBFZJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whSRH-0000000HCP8-3ihH;
	Wed, 08 Jul 2026 13:35:47 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whSRF-0000000HCOa-2Ku8
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jul 2026 13:35:46 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668CIhOl3007391;
	Wed, 8 Jul 2026 13:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=d6hzTv
	TdzgqUTLjlgTVXyubUz2RRjrvCphV9Lw7UDSs=; b=eyQCF72TiMOrPc5kQBh3Q0
	vb5MUnHRCOVoiol2C7pz3LHOaH7HNXbgu42/7D+HQSLM83+vVmrRs3od9mzGc1JS
	c3K0P0fj10IU8RXGlVz+7pEUdeowTjQAmkNMAHJ+LmJIz3physjNTHPSSV/tDJKj
	BiXzzYAyx2+iP+O+E8A+AF3UZQFrdHtDEX//JFsNiErNSVbnd+pMOv71wzykP0Ob
	kLR6UeNxbH2QxE2CWxzpb3FNPTCmjuvVgxaXKpw5YugbDMC2NmdtcKVblWadwG6c
	WP3n6Tke7Cdr79FfahZEQ3Zxu6NL9I7LWfg7KJLqDOgn6FmsuePYnV+b9krEyn7g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4vkkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 13:35:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 668DYZ6a002054;
	Wed, 8 Jul 2026 13:35:30 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgq8dym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 13:35:30 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 668DZTY964946582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2026 13:35:29 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91DF85804B;
	Wed,  8 Jul 2026 13:35:29 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 908B858065;
	Wed,  8 Jul 2026 13:35:26 +0000 (GMT)
Received: from [9.43.121.235] (unknown [9.43.121.235])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jul 2026 13:35:26 +0000 (GMT)
Message-ID: <6849f4db-500d-41ec-b6ac-7bc82fa6ea73@linux.ibm.com>
Date: Wed, 8 Jul 2026 19:05:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: swap synchronization ordering in nvme_remove_head()
To: John Garry <john.garry@linux.dev>, kbusch@kernel.org, axboe@kernel.dk,
        hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, John Garry <john.g.garry@oracle.com>
References: <20260707135744.1470014-1-john.garry@linux.dev>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260707135744.1470014-1-john.garry@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: G53R5SqPKr5Abp6oh8lr6EAChDTd7N20
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDEzMCBTYWx0ZWRfX8V2dPKBy7Zdx
 +dZ662TF2XmllZY7bzV/z8MpejmQ3y5qLmS/6XqADmtOYbImqa8B7LcT+FIRSrw57j8kTxLcL/5
 iLrrkHLTnV9nHE5junn3OVjoBFsS9f3vH8pOEF9H/fvV2zV1FRG2iTcpUK0hVD/P4jVK8dHeRuN
 DiF6oOGqGqBPXrtIPKkVBOUU2USEdM6yzuyL+bKlbTwo7NVbd/0PmCb0lrhr4EnOOSa7+FFGWXJ
 EoviJBcuPU4HnYBZ2jRtwa8VRoh18eFH0cnHkOZHBOovz5WpMIWPzkq7a3965RSvwe676bB8lhn
 PyjX918qZm+9st+4ntfw5WK+rDdoMe7qVYgiAd9WBqe29ctB0bzb2Aw8JYJ7Wl/PKeNacxZ7YY0
 MtdK2BXES8yIaDMZ34lEnUFNqP1TokIhNlGYfzDijUAUUcKPB+jK4+0+5f+R10xcNmzRIYAlif8
 jHBlPq7pZ8079ROFw/Q==
X-Proofpoint-ORIG-GUID: G53R5SqPKr5Abp6oh8lr6EAChDTd7N20
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4e5223 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8 a=gfKPkXzsn3guey2hK0cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDEzMCBTYWx0ZWRfX9hnyBp9RoEib
 bv8hlZUrMws2A+Zk0gG7CYCOjFKhPeb/Q8yH5UzoIGGGj/BlsjWvBwly+zbsk+DxsoPK4VFoN7a
 0d7PRTLOqVqUVoUUOEuPQyjrFgzhGqU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_063545_612730_B3CB182F 
X-CRM114-Status: GOOD (  25.11  )
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

Hi John,

On 7/7/26 7:27 PM, John Garry wrote:
> From: John Garry <john.g.garry@oracle.com>
> 
> sashiko bot reported a potential issue in the requeue handling in [0] -
> the code there is same as the NVMe driver.
> 
> The issue is that when we schedule the requeue work, if a bio is added to
> the requeue list afterwards in nvme_ns_head_submit_bio(), it is missed by
> the requeue worker.
> 
> This issue can be recreated by hacking a large delay in the bio submission
> requeue path:
> 
>          } else if (nvme_available_path(head)) {
>                  dev_warn_ratelimited(dev, "no usable path - requeuing I/O\n");
> 
> +               msleep(30000);
>                  spin_lock_irq(&head->requeue_lock);
>                  bio_list_add(&head->requeue_list, bio);
>                  spin_unlock_irq(&head->requeue_lock);
> 
> 
> Then if we issue a write after removing all paths, a hang can be seen:
> 
> # echo 20 > /sys/devices/virtual/nvme-subsystem/nvme-subsys1/nvme1n1/delayed_removal_secs
> #
> # ./ini_nvme_teardown.sh
> [   25.877224] nvme nvme1: Removing ctrl: NQN "nvme-test-target"
> [   25.939569] nvme nvme2: Removing ctrl: NQN "nvme-test-target"
> #
> # xfs_io -d -C "pwrite -b 64k -V 1 -D 0 64k" /dev/nvme1n1p1
> [   29.883653] block nvme1n1: no usable path - requeuing I/O
> 
> Fix by re-ordering the SRCU synchronization and scheduling the requeue
> work.
> 
> [0] https://lore.kernel.org/linux-scsi/20260703102918.3723667-1-john.g.garry@oracle.com/T/#m72af1f29deb0ebfb2973464207f201f1be1f660c
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
> I am not sure if we still require the synchronize_srcu() after nvme_cdev_del().
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 016b6b0128c7..0b017eeb82b2 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -690,14 +690,15 @@ static void nvme_remove_head(struct nvme_ns_head *head)
>   {
>   	if (test_and_clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
>   		/*
> -		 * requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared
> -		 * to allow multipath to fail all I/O.
> +		 * Requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared
> +		 * to allow multipath to fail all I/O. First synchronize to
> +		 * add any bios to the requeue list.
>   		 */
> +		synchronize_srcu(&head->srcu);
>   		kblockd_schedule_work(&head->requeue_work);
>   
>   		if (test_and_clear_bit(NVME_NSHEAD_CDEV_LIVE, &head->flags))
>   			nvme_cdev_del(&head->cdev, &head->cdev_device);
> -		synchronize_srcu(&head->srcu);
>   		del_gendisk(head->disk);
>   	}
>   	nvme_put_ns_head(head);

With the above change now I wonder do we really need to schedule ->requeue_work
from nvme_mpath_put_disk()? Maybe we still want to keep it as a defensive
"safety net". Though having it doesn't harm but looks redundant.

Otherwise, this change look good to me,

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>


