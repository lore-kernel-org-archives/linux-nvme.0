Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B84C36008
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Apr 2025 07:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YbK/lSI2RgWL02dSJG6n2F8wLSVyJfyg/T4OBuslLqU=; b=qXU+aBzukBhQZyPADgax7nuEaa
	nRoriupCeS/FjhE3v9VTDf8Rm5mzjV/kXUhVpNI2orMj70MmegLv1oE/A2wyVCdqAWerQNIUQIcfN
	m0Y2HMpv7nfhKeSK/4pOaZ/+fo+NXB3QnmWtkPiXEAF0fEw1IJZX5AyN5lvLpMxfYF1lA38f9q/GK
	p9A0A+HNrSAtNVB2WesfX52rYkJJRAm0z2zxY8BUdC+eUVdzgHlvvAa29gD4RBYvjVrVUOFianhPK
	zyUOxKaoh/LFHjrajevP2I7faHvWY4n6XWrQTdRvs0cSMo2bTI9G4cP9H4M9qKJCJwMOqiclLZFlM
	Js050Oxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzVy2-00000002BEX-1DkS;
	Tue, 01 Apr 2025 07:23:26 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzVvr-00000002AzK-06w9
	for linux-nvme@lists.infradead.org;
	Tue, 01 Apr 2025 07:21:13 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5313jt7J026566;
	Tue, 1 Apr 2025 07:20:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YbK/lS
	I2RgWL02dSJG6n2F8wLSVyJfyg/T4OBuslLqU=; b=ZnuHMiZXg9aSBSKB8o1Xrz
	W2XSbdeeSndoGY7P857+Ij/yNPm7t/1ZOAhr0/KxN23eyST7tClF/CjzOl4v8aff
	/qpGUHk1jdiURiDK6/7svzw+obCErzM+yiYGKR/7ws2jeSih3hQXdc2bXD94XF06
	ukne2xLX6R7oSwc/32jTtObnUNsebOvm6kBjtv9SJQOECHKmpAlmhCa1SU7sNDKp
	gqwqhTc2PrHBtFwHKUCHS3Bzx/qr1BvJROTEr+8Jh0StXtWgumCiBWzJR6x2iILe
	ZK5lbz9Bvxw3CT9jBbBqExdcJqO6YO7g4YPfAw6gVLyFOrYZweLni4ejPD+C+XRg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45r8h9rtuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Apr 2025 07:20:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5315eno7005399;
	Tue, 1 Apr 2025 07:20:42 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45pww293m4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Apr 2025 07:20:42 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5317KfHE21758716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Apr 2025 07:20:42 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBB8C5804B;
	Tue,  1 Apr 2025 07:20:41 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AEA2858055;
	Tue,  1 Apr 2025 07:20:39 +0000 (GMT)
Received: from [9.109.198.185] (unknown [9.109.198.185])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Apr 2025 07:20:39 +0000 (GMT)
Message-ID: <a292b36f-f7f0-48c6-a0d3-5d7e7db3f883@linux.ibm.com>
Date: Tue, 1 Apr 2025 12:50:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-cli: attach ns to local controller if none specified
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
        wagi@kernel.org
Cc: hch@lst.de, dwagner@suse.de, Keith Busch <kbusch@kernel.org>
References: <20250331190843.2431830-1-kbusch@meta.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250331190843.2431830-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bnsCwvXUu7b8-QXf73a5mZCx8b1l73v9
X-Proofpoint-GUID: bnsCwvXUu7b8-QXf73a5mZCx8b1l73v9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_02,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504010046
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250401_002111_093723_D52ACA50 
X-CRM114-Status: GOOD (  22.40  )
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



On 4/1/25 12:38 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Assume the user meant to attach the namespace to the controller the
> command was sent to if the user didn't provide a controller id list.
> 
> Suggested-by: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  nvme.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/nvme.c b/nvme.c
> index bb412843..7a2c2e9f 100644
> --- a/nvme.c
> +++ b/nvme.c
> @@ -2953,9 +2953,6 @@ static int nvme_attach_ns(int argc, char **argv, int attach, const char *desc, s
>  
>  	num = argconfig_parse_comma_sep_array_u16(cfg.cntlist,
>  						  list, ARRAY_SIZE(list));
> -	if (!num)
> -		fprintf(stderr, "warning: empty controller-id list will result in no actual change in namespace attachment\n");
> -
>  	if (num == -1) {
>  		nvme_show_error("%s: controller id list is malformed", cmd->name);
>  		return -EINVAL;
> @@ -2965,7 +2962,18 @@ static int nvme_attach_ns(int argc, char **argv, int attach, const char *desc, s
>  	if (!cntlist)
>  		return -ENOMEM;
>  
> -	nvme_init_ctrl_list(cntlist, num, list);
> +	if (argconfig_parse_seen(opts, "controllers")) {
> +		nvme_init_ctrl_list(cntlist, num, list);
> +	} else {
> +		struct nvme_id_ctrl ctrl = { 0 };
> +
> +		if (nvme_cli_identify_ctrl(dev, &ctrl)) {
> +			perror("identify-ctrl");
> +			return -errno;
> +		}
> +		cntlist->identifier[0] = ctrl.cntlid;

Thanks Keith for working on this!

I think we also need to set the num of cntrls in the list here. In this particular case, 
we need to add the following line after we initialize the cntrl identifier:

cntlist->num = cpu_to_le16(1);

Otherwise changes looks good to me. 

Thanks,
--Nilay


