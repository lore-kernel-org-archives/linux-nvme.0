Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B510ACEFC27
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2024 15:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Uu+snekPOGgOEoFynkug/vm/LlegzLv9MWA+X0tlJWM=; b=sf3fszwQOWJ0i6ejslXCb7x5RA
	gu07ZomZAmjw1OtUnlHaITjPC77Dk1eXQoii2kdn3xJtezT1n+Mi7HSESs98W2PQzRW3Kk9f4e/3A
	LwZxyNPeJsTYuOJ9f+Vj/QHHCVmcpa/SwviJG3uVL1f6G/XF8aVVDbiiYEVKL4Kjw3LbtltythOma
	/VJX4+tZz5JQw3yL2PfaPpTCwJeTObPEYQNsbLbjSP6sMWbWvBBApsSJYUgMsWBWyCMQmAQvIfb3Y
	RoHhTRheHuzZGXffvfclpZHFI0h5V9qF9DXLtlHepiZtH6VxpElQjIv8iDPbhqX2WdqO07DWwkXZW
	LS0y7vzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syCQd-00000006PBT-3bur;
	Tue, 08 Oct 2024 15:47:15 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syCQE-00000006P6b-3lIk
	for linux-nvme@lists.infradead.org;
	Tue, 08 Oct 2024 15:47:13 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498Eo702015824;
	Tue, 8 Oct 2024 15:45:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=U
	u+snekPOGgOEoFynkug/vm/LlegzLv9MWA+X0tlJWM=; b=a7TAMUbvAl3seRV3Y
	SgQlDgdINxf96KJ2aLH2lrpAvbrGY8NPNSFlpxEKethqNNjQsGizEvKtAN+CYqYD
	CmrkFLOR0ypguyaRdLOWeikaaYl4PJmU9NgrS8ZTADa658o/d483c/Kgq332G+NO
	mV4Uo+bOL9XoahfiuL5Z9XseQzYTPsaFw6rqjiUrfnG44S8XeNtiTTSy5oSfmlOz
	RNCieyasQAZ5hy1zK7sK/lKg1PF7hGIVC4WUHzJARBy2JOmf9Jan1PQ4gUCu2B2u
	xcM6i2bXPmukbQT/vagLwaPHIMGtuG3Rtbn8a1x8aTNimXoiMGO6A+dqmr1B8eZw
	0Il0w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4256uk0axv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 15:45:52 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 498FjpsT007243;
	Tue, 8 Oct 2024 15:45:51 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4256uk0axj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 15:45:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 498DtuVC022867;
	Tue, 8 Oct 2024 15:45:50 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 423jg0vu64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 15:45:50 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 498Fjomh37683624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Oct 2024 15:45:50 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5247A58061;
	Tue,  8 Oct 2024 15:45:50 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1274358058;
	Tue,  8 Oct 2024 15:45:47 +0000 (GMT)
Received: from [9.179.0.95] (unknown [9.179.0.95])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Oct 2024 15:45:46 +0000 (GMT)
Message-ID: <99bf368e-5970-44a4-8407-49747f0e2339@linux.ibm.com>
Date: Tue, 8 Oct 2024 21:15:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] nvme: disable CC.CRIME (NVME_CC_CRIME)
To: gjoyce@linux.ibm.com, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        hare@suse.de, dwagner@suse.de, msuchanek@suse.de,
        jonathan.derrick@linux.dev, okozina@redhat.com
References: <20241007193324.5846-1-gjoyce@linux.ibm.com>
 <20241007193324.5846-2-gjoyce@linux.ibm.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20241007193324.5846-2-gjoyce@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gVkMm1W53dLn3w8t7TyjnKcMpd5eLHel
X-Proofpoint-GUID: uM2f9dRTXsz548uZb7Ge3x-jWwkqHTLD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_14,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 impostorscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080100
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_084651_193114_32B0306F 
X-CRM114-Status: GOOD (  22.12  )
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



On 10/8/24 01:03, gjoyce@linux.ibm.com wrote:
> From: Greg Joyce <gjoyce@linux.ibm.com>
> 
> Disable NVME_CC_CRIME so that CSTS.RDY indicates that the media
> is ready and able to handle commands without returning
> NVME_SC_ADMIN_COMMAND_MEDIA_NOT_READY.
> 
> Signed-off-by: Greg Joyce <gjoyce@linux.ibm.com>
> ---
>  drivers/nvme/host/core.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ba6508455e18..10eca7660ca7 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2458,8 +2458,13 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
>  	else
>  		ctrl->ctrl_config = NVME_CC_CSS_NVM;
>  
> -	if (ctrl->cap & NVME_CAP_CRMS_CRWMS && ctrl->cap & NVME_CAP_CRMS_CRIMS)
> -		ctrl->ctrl_config |= NVME_CC_CRIME;
> +	/*
> +	 * Setting CRIME results in CSTS.RDY before the media is ready. This
> +	 * make it possible for media related commands to return the error
> +	 * NVME_SC_ADMIN_COMMAND_MEDIA_NOT_READY. Until the driver is
> +	 * restructurade to handle retries, disable CC.CRIME.
> +	 */
> +	ctrl->ctrl_config &= ~NVME_CC_CRIME;
>  
>  	ctrl->ctrl_config |= (NVME_CTRL_PAGE_SHIFT - 12) << NVME_CC_MPS_SHIFT;
>  	ctrl->ctrl_config |= NVME_CC_AMS_RR | NVME_CC_SHN_NONE;
> @@ -2489,10 +2494,7 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
>  		 * devices are known to get this wrong. Use the larger of the
>  		 * two values.
>  		 */
> -		if (ctrl->ctrl_config & NVME_CC_CRIME)
> -			ready_timeout = NVME_CRTO_CRIMT(crto);
> -		else
> -			ready_timeout = NVME_CRTO_CRWMT(crto);
> +		ready_timeout = NVME_CRTO_CRWMT(crto);
>  
>  		if (ready_timeout < timeout)
>  			dev_warn_once(ctrl->device, "bad crto:%x cap:%llx\n",

Looks good to me.

Reviewed-by: nilay@linux.ibm.com

Tested the above patch on Kioxia disk supporting TCG Opal SED. My test 
confirmed that the patch works as expected and we don't see 
NVME_SC_ADMIN_COMMAND_MEDIA_NOT_READY error during opal discovery or 
any admin command executed during disk initialization.

Tested-by: nilay@linux.ibm.com

