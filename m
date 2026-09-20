Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E6DC982E6
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Sep 2026 11:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tZ1S/fDZzpwAgIDmvqKXm6kk1WfKNK7tBMSVcvE0C0Q=; b=pgVvXEvqB/rRMdqZDjqstLfEMV
	/woS1rmEwh7gVSPYM7Z26d5m8Mo4vrHliMg+nYk49lm0oTPukHNu5OdRmkGzcXI7XE7Q/kk+Aqm+a
	j+hiXXz1+p04XKAAMqGZag6hsu/lbNqdwgIfgvt7nhKwgpFkY0/zSruzBHhJXpykFwbwnusAR3wFs
	U/pxKpGPekHKhimUba8FWZA2+0m438c4O07Id5Wvh/sOIZH4Njitx7N4v4TBcNQSZomgmm/lJYWyh
	SZ9brbaQTbCbf9S9y7+UB3eYC5aONsv6neXHCFSyGnacZX29Q7oz95eqop8o9ZJqvW1SYwCIWL0md
	vKBep7pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8FOM-0000000HJ9v-0g4U;
	Sun, 20 Sep 2026 11:07:30 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8FOK-0000000HJ9P-1HQr
	for linux-nvme@lists.infradead.org;
	Sun, 20 Sep 2026 11:07:29 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68K8ZYNp373505;
	Sun, 20 Sep 2026 11:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tZ1S/f
	DZzpwAgIDmvqKXm6kk1WfKNK7tBMSVcvE0C0Q=; b=OvMHaCM17RoRD3TSAzEDsl
	uLjMwobp6WLkc44kWGlwqBnBOPVzv/EatyfkB6s/yfVzgLzeUKIJJqvSaDvgOkeB
	VAqbYSXy7ekI0/imUEEWe25wsa5kSKtoAhMzDR1aWoWTYpcZc1hTEJubq4COs/ET
	Ad5qifAib2Pwg9pTvAR3tQ922Ov+6YN5eS3DgW0UIU9c1Dx/mKrzDlYJgVyzS7ZG
	o59QUSpeVVG2+ku2gUXoIAiv3FWkO3XZ50K7vZSAuHODekui2WQ7hRUFx4h7QmA1
	vgkTZB9Az5tJXZj7b89rfIprfC+tOn6+IaU/pvJtk1DVf85xFRQq05pPRPutpZTw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1c90r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 20 Sep 2026 11:07:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68K8WVDP3689145;
	Sun, 20 Sep 2026 11:07:16 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qq1f6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Sep 2026 11:07:16 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68KB7FrP38797874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Sep 2026 11:07:15 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6773C5804E;
	Sun, 20 Sep 2026 11:07:15 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F3F35803F;
	Sun, 20 Sep 2026 11:07:12 +0000 (GMT)
Received: from [9.61.138.180] (unknown [9.61.138.180])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 20 Sep 2026 11:07:11 +0000 (GMT)
Message-ID: <baef058e-a502-4263-8d3d-1ad0a9550826@linux.ibm.com>
Date: Sun, 20 Sep 2026 16:37:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] nvmet: return Invalid Field for invalid NSIDs in
 Set Features 82h
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        John Garry <john.g.garry@oracle.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20260920033500.3209138-1-kanie@linux.alibaba.com>
 <20260920033500.3209138-2-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260920033500.3209138-2-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: mDo5Z2a-cqlHTaJWfXKPfKlGUNAJzllz
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6aafbe65 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=_owC5W0WRAQXWFV8-GwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIwMDE2MCBTYWx0ZWRfXz3wTR7j3mHx6
 XJdPHbFaWRBezIEYQvfduLMe9XtBduZc0tNC1tzMWgMHnsj5fShgKjIm4k5EDHVYzvi0masorIl
 lcc+/UleaL6rnkFu8ez9qNx4dLr+SxU=
X-Proofpoint-GUID: q11K6lcfTmORZD8IgwTe75qDWbvGqofE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDE2MCBTYWx0ZWRfX8K4jzRyfTOKN
 W9DK0tOC4fo095bT3ZMgGbdWfCaxBHLdiUmx/BlBEYhWq/0hGjsorGPO5kYXlhkW0qauJUn5nhT
 LIDoqqXJVkfs6Kd9b6hOG1xfIo4xsX+gOQhSfAJdoLwovMgREPs17UrC9S+aE/XKaFEl6FrQwU9
 98EMZGKWgd8c9QlCrLEZG9jVpOWVCNVOJhqZBC20Vf+lMKm9w3rcXa/a2hdepPnRiF3Og/9AGAC
 O2ALgop8rFUVazwNW+Jvom3BQx/ThZQgxgiCbyzq46DDg+D34YfL7oaMsZUqdy2kYO7NSI4tovL
 5YhnOVSpSP5b6flpWwbqYbfklRM7UfrOPj6cB/fGqSkxsgCqYCFhzMnS0i33ixpZQK1JyKuWuNc
 wffcQsxtfr8dmZR4s2Vz92YkXtUDu6vtd0iJqmiKxFTPN0P539gxCezYdOXRpSgdD/skRjn/Lo9
 4mgrMWFR52xiE1liP+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-20_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609200160
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_040728_355355_3FED86CD 
X-CRM114-Status: GOOD (  17.23  )
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

On 9/20/26 9:04 AM, Guixin Liu wrote:
> diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
> index 0948a690a1c0..a36c732883d4 100644
> --- a/drivers/nvme/target/pr.c
> +++ b/drivers/nvme/target/pr.c
> @@ -51,6 +51,8 @@ u16 nvmet_set_feat_resv_notif_mask(struct nvmet_req *req, u32 mask)
>   
>   	if (nsid != U32_MAX) {
>   		status = nvmet_req_find_ns(req);
> +		if (status == (NVME_SC_INVALID_NS | NVME_STATUS_DNR))
> +			return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
>   		if (status)
>   			return status;
>   		if (!req->ns->pr.enable)
> -- 

This looks good to me. However, to avoid hand-coding the same error
return code multiple times in the function and to make it a bit more
readable, how about modifying it as follows?

u16 nvmet_get_feat_resv_notif_mask(struct nvmet_req *req)
{
	u16 status;
	u16 err = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;

	status = nvmet_req_find_ns(req);
	if (status) {
		if (status == (NVME_SC_INVALID_NS | NVME_STATUS_DNR))
			return err;
		return status;
	}

	if (!req->ns->pr.enable)
		return err;

	nvmet_set_result(req, READ_ONCE(req->ns->pr.notify_mask));
	return NVME_SC_SUCCESS;
}

Thanks,
--Nilay


