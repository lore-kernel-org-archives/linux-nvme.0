Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FC4CD6E4A
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2026 12:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cFxhpVick/m2eBX2Kmz4bK5oFHGM6slO66GGYlync4A=; b=UjkcQXAPo+DQ0qBvoD0tocjt4s
	Wff1efqFi2mP0V8lo3kI8qKHAPKjkNHDc2B+r5eFUDanf7/ygJ7JubJ5nIcGXt0DSaeZ09wxlnip/
	MY/tF4Shf++dm4lyTgtLN9sQQ+Cg0WlDpq2kNpHMTmwdE4p24V0XoTPJ49HYdkgo9DxfHuIAlmdbN
	omTrAtKMCsq/C9N1pU02w6mLg/e1MGr/ehpJRNBJgJHbtGObziEGDd95zQsZ7FKNML1u1fq6SxR5A
	4xsVjKRjN8fSdLdlkguMjmPDsmPjUzrmVgrrMiV8m0JsBwnvIdunSyK8IW8c5cEE02PETKYartUjw
	BXscV4Xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUkZd-0000000F3Th-3max;
	Wed, 03 Jun 2026 12:19:53 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUkZb-0000000F3TG-00wH
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jun 2026 12:19:52 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6537TcdV1956882;
	Wed, 3 Jun 2026 12:19:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cFxhpV
	ick/m2eBX2Kmz4bK5oFHGM6slO66GGYlync4A=; b=IoIcz0d/zRXioucmOw79v4
	/I5C5aqRxd2XjYkprgEqUZHxxE7ckOgpdRAsVyg+VDGhp0VYLVso0l4dNXhUQA4p
	9yIh089K+qny21602H3VLmRqIhG3B6rfadwov0E9SAxwmVkGzc985dxdymjQZaGL
	XZ/3Wb3FPsBI0TzwUSyLMfEcKxQW48wB+BjSGkh6qZlJfeO5ISiZmVU8Dlh7Bfgd
	rT7qm/75589Y08tZW7h1RBsJvlhnPrs7hWjHFQPxkhuR2/+KkgOpKvYg+4KFC1qI
	TYr12SLOhPhCfxeeMxRWh2I9/ygTUxdordLhZkqDbhO+bj/uRQkUr+v6jSqZkX7A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahte6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 12:19:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 653C97uJ015094;
	Wed, 3 Jun 2026 12:19:29 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegqtsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 12:19:29 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 653CJSeQ31261404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 12:19:28 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFBF358052;
	Wed,  3 Jun 2026 12:19:28 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09E2C58045;
	Wed,  3 Jun 2026 12:19:26 +0000 (GMT)
Received: from [9.43.101.61] (unknown [9.43.101.61])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jun 2026 12:19:25 +0000 (GMT)
Message-ID: <34707988-b1be-4ff0-9786-ef02b26eb0de@linux.ibm.com>
Date: Wed, 3 Jun 2026 17:49:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-tcp: lockdep: use dynamic lockdep keys per socket
 instance
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>
References: <20260603112533.375925-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260603112533.375925-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDExNiBTYWx0ZWRfX9R/AypMBqoeu
 /Jw9r1834t6+KRzQAKG2CAZPeSAT5ycucfvSI8GyxKlbdFwDthnSD9UdU/LZ1HsofmDkAMEAbQz
 /g/vABqyXrg8kk94bdQ0rYXoateB/lMpZE56ZodnYNMBDzflQxnYqn5yFUhdCgB1MSEwTZ6CtL7
 +qCaMqBQTBNs65BgDjQYMDDbVrcTTbtDSRrO/+hCopRkbCZ69IYYGFA7jqwOdcdgWQXuvlKXr2l
 8nghcglu5S3c3CQzF+2cG3zQu+rV0UQHyZNT7EziM31+oAr0YnSbYS8LwYl8uRO+0oVWKi4Oq1t
 /SDB44YX2D+hKkSv4oY9voj6ASEwZetQGV8a8TMlAAshhkcPGsZkAvlNIO4lw1HezrgrqgWluZM
 nMZ9gVilL0Yy81fMV5sNzjHB143+2XDx+DSqLa1EMFetE3WLq1YetoFP9sBE9CPONpwQeBMEFuo
 FGyr9ZA47iklbFvSNSg==
X-Proofpoint-ORIG-GUID: 9oWRsfZU-2zk0i3d35FexHIPOuk9B5u3
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a201bd2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=p3UdGyPDsOXEwFfnFAwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9oWRsfZU-2zk0i3d35FexHIPOuk9B5u3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030116
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_051951_168660_A20287AC 
X-CRM114-Status: GOOD (  12.81  )
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

On 6/3/26 4:55 PM, Shin'ichiro Kawasaki wrote:
>   static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
> @@ -1813,7 +1818,12 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
>   	}
>   
>   	sk_net_refcnt_upgrade(queue->sock->sk);
> -	nvme_tcp_reclassify_socket(queue->sock);
> +
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	lockdep_register_key(&queue->nvme_tcp_sk_key);
> +	lockdep_register_key(&queue->nvme_tcp_slock_key);
> +	nvme_tcp_reclassify_socket(queue);
> +#endif
>   
>   	/* Single syn retry */
>   	tcp_sock_set_syncnt(queue->sock->sk, 1);
> @@ -1921,6 +1931,11 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
>   err_destroy_mutex:
>   	mutex_destroy(&queue->send_mutex);
>   	mutex_destroy(&queue->queue_lock);
> +
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	lockdep_unregister_key(&queue->nvme_tcp_sk_key);
> +	lockdep_unregister_key(&queue->nvme_tcp_slock_key);
> +#endif
>   	return ret;
>   }

I think we shouldn't call lockdep_unregister_key() from under err_destroy_mutex
label, and instead it should be moved just before the err_destroy_mutex label.
The reason being, when the code jumps to err_destroy_mutex label, it hasn't
yet registered those lockdep keys.

Thanks,
--Nilay

