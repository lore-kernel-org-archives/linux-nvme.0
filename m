Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F3DC61DBD
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Aug 2026 12:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=daUdgenTI11G4W5fFK+yf6S6qNvd08vY/rYfWY6rlZU=; b=Ks0fNkTL3fzkQT5sBeAU0VZ3x3
	l7opnKem25jmrtTpW2jQV5Ybkr/2Ole1nDKKZoeJOnEDK2E5tXR1Fc9p2YQ07fy+cWMP8bLhZK658
	oAOUGbJi5Gp2C6BLS1YFe1oRgb4xEdjDLUdyGC6KTPEeJw9mFBT79g6FyOnIjkrMw6fLADqZr9x6S
	nxzNvJ+0ACKKndMv8ioEnfrZtBYKCnoeRt1MxVHR5uqemaigR1C8lDnFj5S7OH7l65apmvPyaC3S9
	ajIbviZJKrCu516xmnqhvCIdnGxbBCGI5OaQx5NjtKhaSo3DIxdVG8rB1Up2PNfqEQWvArNQOIqut
	5KjhbFsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzCvb-00000002SQF-2TVr;
	Wed, 26 Aug 2026 12:40:27 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzCvV-00000002SOp-3oOq
	for linux-nvme@lists.infradead.org;
	Wed, 26 Aug 2026 12:40:23 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QCVsjm2127703;
	Wed, 26 Aug 2026 12:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=daUdge
	nTI11G4W5fFK+yf6S6qNvd08vY/rYfWY6rlZU=; b=dJyCLpIvJJGhwaig7BIgVU
	e6gTfm/LcB6jFTfrSdqXCrUFHQGd3hd5/su6ik101AXN+lxYF5QXtoS8bqfOPk4j
	GAjjq/Q0z80+9qdJtwbtvIFU0ZLoMqa7WF5PSBA8YJhD5xDwyQrXFPYo+rBI37uU
	IJS+HJxK4gca1ibERcNzhuLVNyI5kr5MoqTtn8PetVZL7ebzJM9GDGFkzEj99REJ
	CQf7HIX/JQZd5VZ1NSVm2nk/TCV1m2yGWXVXwuAwtMEUmwfeJMy8ei5WL0DAq9tE
	EXqEwIu9y57+TQPqNO4DG8LGLR0MV+81TnlFwh+iwQeB/S8XGtJvL0B+R6ptS2Dw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqxjh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 12:40:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QCQKpg032573;
	Wed, 26 Aug 2026 12:40:16 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsy9nmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 12:40:16 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QCeDkF32571668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 12:40:13 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BA3B58058;
	Wed, 26 Aug 2026 12:40:13 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50BC358057;
	Wed, 26 Aug 2026 12:40:11 +0000 (GMT)
Received: from [9.61.86.249] (unknown [9.61.86.249])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 12:40:11 +0000 (GMT)
Message-ID: <d3cb6438-f1b6-4b46-9f96-56819052bc02@linux.ibm.com>
Date: Wed, 26 Aug 2026 18:10:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] nvme: Add module reference counting for multipath
 devices
To: wenxiong@linux.ibm.com, linux-nvme@lists.infradead.org, kbusch@kernel.org
Cc: gjoyce@linux.ibm.com, wenxiong@us.ibm.com
References: <20260812223206.720363-1-wenxiong@linux.ibm.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260812223206.720363-1-wenxiong@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5t_Xf4dhh4Fv4C-T9FXBiBQiONxJymK8
X-Proofpoint-ORIG-GUID: 5t_Xf4dhh4Fv4C-T9FXBiBQiONxJymK8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfX2OV6UYom6AdK
 oAdbrViN3bs9bG9GVDCo5sGBhG5HKujjmBIz3ZNU+8TRrrDDq4wuCJHoHODu+Nyv4x3uiMi+39f
 m602mzYJ2b6EmC+kPEcwdNfhZUIoR2muJdIdx1hSxXLDeZEdGU5TeLPEcyjIkE/gRSgid4vyQ/w
 fAuw39VpWDxOwx/Y8jaco57s2PpqZV5qLsXbr7yONa3FqskqbzCMu67fmw7rHa9j4n6gfDdH8no
 PKLP1oCAIMFkpemKhtId3reViDbhpqxhUEuia4teoJTFPLvatfpZCkB2UKFUFafOqcsLUnmFtch
 X9UD497nmY2QEqm9ihakUNAa4qwe45OQlNKLV0Jj+ShhG6zpYiM1aHSeqUFXQEsdtKg2c1O9c1u
 mRh51R2/pSPguicVZbTeBpiyHywjAVNpiKrUwXaAWPNWbi5pWydoUv2huVxUQYhZXzKEr+tVeCc
 6BDDHwnXIS3OTOeJsLQ==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8edeb1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=i5cz4GWUwZtwwj5BGDoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfX07a+VhaFmaKA
 YlZXffotiSTDEK0V5HG2H4Gp6CqG4h3yJI7d0NYbF7dqiwbuX1gmjnBpObha//a5LsddqrACQkh
 MmLtpp7ymYgpV6b9J1Qmcn2VW9HjCOE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260104
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260826_054022_068227_2D043E45 
X-CRM114-Status: GOOD (  26.30  )
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

On 8/13/26 4:02 AM, wenxiong@linux.ibm.com wrote:
> From: Wen Xiong <wenxiong@linux.ibm.com>
> 
> Add proper module reference counting to prevent premature unloading of
> NVMe transport modules while multipath namespaces are still active.
> 
> When a namespace is added to a multipath device via nvme_mpath_add_disk(),
> the underlying transport module (PCIe, FC, RDMA, TCP, etc.) must remain
> loaded as long as the multipath device references that namespace. Without
> proper reference counting, the transport module could be unloaded while
> the multipath device is still using resources from that module, leading
> to the potential system crashes.
> 
> This ensures the transport module remains loaded for the entire lifetime
> of the multipath namespace association.
> 
> Signed-off-by: Wen Xiong <wenxiong@linux.ibm.com>
> ---
>   drivers/nvme/host/multipath.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 9b9a657fa330..707b8f95727d 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -1348,6 +1348,8 @@ void nvme_mpath_remove_sysfs_link(struct nvme_ns *ns)
>   	sysfs_remove_link_from_group(kobj, nvme_ns_mpath_attr_group.name,
>   			dev_name(target));
>   	clear_bit(NVME_NS_SYSFS_ATTR_LINK, &ns->flags);
> +
> +	module_put(ns->ctrl->ops->module);
>   }
>   
>   void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
> @@ -1379,6 +1381,9 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
>   	if (blk_queue_is_zoned(ns->queue) && ns->head->disk)
>   		ns->head->disk->nr_zones = ns->disk->nr_zones;
>   #endif
> +	if (!try_module_get(ns->ctrl->ops->module))
> +		dev_err(disk_to_dev(ns->disk),
> +				"Failed to get module reference\n");
>   }
>   
>   void nvme_mpath_remove_disk(struct nvme_ns_head *head)

I know I am late to the party here, but I don't think adding the
module refcounting in nvme_mpath_{add|remove}_sysfs_link() is the
right approach. That would increment the transport module reference
for every namespace/path, which means the transport module could
not be unloaded until all namespaces using it are deleted, even
when none of those namespaces are actually in use. So for instance,
with this change now, I can't rmmod nvme.ko until I delete
all namespaces/paths created under PCIe nvme subsystem, even though
no one is using the namespace/path under that subsystem.

Instead, I think the module reference should track the lifetime of an
active user of the multipath namespace. When the namespace is in use,
the corresponding transport module(s) need to remain loaded and once
the namespace is no longer in use, those references should be released.

Looking at the current code, nvme_ns_head_{open|release}() seems to be
a more appropriate place for this. When a multipath namespace is opened,
nvme_ns_head_open() could take the required transport module references,
and nvme_ns_head_release() could drop them when the last user releases
the namespace.

Also, since a multipath head can have paths through different transports
, we should not take a reference only to the transport of one namespace/path
found through nvme_find_path(), as was done in v1. Instead, when opening the
head, take a module reference iterating through each controller reachable
from the corresponding NVMe subsystem. This ensures that every transport
that can service I/O for the active multipath namespace remains loaded for
the duration of its use.

Thanks,
--Nilay


