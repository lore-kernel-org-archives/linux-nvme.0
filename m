Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F40F43858
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Apr 2026 16:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gOK+xue+dDXL3P6AVGr8R6iiHDSpr0/afR0nsbsZPS0=; b=eiZZWO1FLx9y/voAsvNDPwG19e
	oX9nfQJy3MRvTGJ9P5yS8/H+LMWEQcsTeoPJHkePGzo6zE+lA7Oktp/B38Tu5EqXkAk1I1blVZCkj
	RpAupAc5RQbcFw8Amxjv7Vh1ze0qwHg/BOHeqUGt7H2QFoN/3hggtGM2rh3V1baX9mN4RrpNaLKqq
	4UCPZWEbtQRZULfUNfMwkSRjBMUAbalJnyObMH+mYTiS26n+jDK7PNpiARyDvZbAzZ3kb8zoacBwL
	MoZzF0nMj4Bge2M7CNM6xracW460JvtA9umvSDETnAKhviWjN28UMoyKdU9PplzVvjXiKc6HhYNGD
	zqwYtQmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wD2zs-00000001N8E-3oGc;
	Wed, 15 Apr 2026 16:21:48 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wD2zm-00000001N7m-3q21
	for linux-nvme@lists.infradead.org;
	Wed, 15 Apr 2026 16:21:44 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F3eD5U1842730;
	Wed, 15 Apr 2026 16:21:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gOK+xu
	e+dDXL3P6AVGr8R6iiHDSpr0/afR0nsbsZPS0=; b=Dgz/pp8YseIyd9H33/X36r
	NVa/e4tbJ12/RfUbaSLovK8CTorTJ8FdMTFPMDZwBzqo9kWDzwtvGwW27CdaS5vM
	6i0HM0IrIF6iuvtitrli+a12nPQiOg1gSCp4gx/7iuqqt4c1sktQ5+xACmsDBzKM
	3BJgOSRv71eiw2pb1S5PK1gyo+YLuTDzpR0O/8/4aUv5zsJ3xw7bP2clZeC1ZV7t
	GE1FdclhhPspmCOYVGo/HmNPBpMIJ/qJfUI0f6SDvjW0km3KvfRj29KsQ6VJKR/+
	Sise7lLkdTuvu+4UKbWlud5hPekXqTUW7PIWVJyLLw40wvQM7MRR+Iu/joQ03aBw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89ms1yy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 16:21:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63FD0nkv003581;
	Wed, 15 Apr 2026 16:21:38 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mneyb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 16:21:38 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63FGLcAp32244214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 16:21:38 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D5EB58052;
	Wed, 15 Apr 2026 16:21:38 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B22A5805A;
	Wed, 15 Apr 2026 16:21:36 +0000 (GMT)
Received: from [9.39.25.232] (unknown [9.39.25.232])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Apr 2026 16:21:36 +0000 (GMT)
Message-ID: <a9b04231-9a71-4108-867e-705f7b39cf65@linux.ibm.com>
Date: Wed, 15 Apr 2026 21:51:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: put module reference when delayed removal
 work is canceled
To: John Garry <john.g.garry@oracle.com>, hch@lst.de, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org
References: <20260415155358.1517871-1-john.g.garry@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260415155358.1517871-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE1MSBTYWx0ZWRfX4DEkSZl1lYbu
 vbGkqmkir8Wvh7JlXDkZJtJ930cqjXTOytJjNXtHqmvLOmIqoAs3G2tiaBraA76+of4V7+fT9+P
 qTWesbv9gVbppo4zJboa5qK96tt4KnC6x3Efg5a5aEro0TQ1PrnWVz1yzMaz/YMzd30Ajw4ySoY
 6rxCvv4IV7N7HBLZtxHMNEdqPxtoRCKAT+Qu9qiJ2i6TfHuDTcAeHF+I7bIsax5K8kaF2ObRTU9
 ks3jZ6tGRgO6DkrIKwCem73766dbDAqqeqdrNZCx8Kz8Kom2JdA/6D27XhFvklE8fGJ8MWuAD9u
 s28c7i0jTRBBSI6FrTDxqncZgJAx0t1uSxHneudITBwgIFtp66009YFju4Txffo2IyCTcFVcyVq
 5z9Z+0qeKrd+/d131ygOd0v7Hnd77hZ9cZtm+lxjOxtCm2e4eGN/+GoTrHU5fm0aIKDogbk6QUo
 HTMB+LWhyhNyRT+XDgA==
X-Authority-Analysis: v=2.4 cv=eJ4jSnp1 c=1 sm=1 tr=0 ts=69dfbb13 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=yPCof4ZbAAAA:8
 a=VnNF1IyMAAAA:8 a=UtDModhNMABtSJfBUaAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: n0Kt2-oEJhkuDz2gXaLzttycalrAPQza
X-Proofpoint-ORIG-GUID: n0Kt2-oEJhkuDz2gXaLzttycalrAPQza
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604150151
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260415_092142_992788_77962768 
X-CRM114-Status: GOOD (  13.17  )
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

On 4/15/26 9:23 PM, John Garry wrote:
> The delayed disk removal work is canceled when a NS (re)appears. However,
> we do not put the module reference grabbed in nvme_mpath_remove_disk(), so
> fix that.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 0d623476e36f8..fead3b7cd4bea 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4083,7 +4083,8 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
>   	mutex_unlock(&ctrl->subsys->lock);
>   
>   #ifdef CONFIG_NVME_MULTIPATH
> -	cancel_delayed_work(&head->remove_work);
> +	if (cancel_delayed_work(&head->remove_work))
> +		module_put(THIS_MODULE);
>   #endif
>   	return 0;
>   

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

