Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EAEC5DF8C
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2026 04:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LudEY7oTjatYQtv0F3kl7pUuQIEnxxfWZVr8tOIRACQ=; b=X8F/puNj8HrlKb6Z2V8YnXsOfs
	ytw0OCa1bxkYaniu+feWXicsKd312FQzgF4dJ0aL6I6KKWsKoxGDHhURx7Rx4Cy8BDCJci2UOUKNE
	CEUrZWlDU9FsPVJkjaMCmi4C8mCEfTAhW3f+Di8v50Nb9sWiYj3QShxyzMRXTworIs2oZZh53hWw+
	Uns5FnUb3fM3/XOrVsamD9BEuSywbWokQ2igscts0wdyoQi6/EyHhVNGr/sNfJqQ1IZlgwL5zbIip
	XvR7kQmsp7PwmhbpA/JMafhJnXjXId2Ay9I7jvZ1K6nMFImhCt/w+f55OblNx7qcdjxmqd4fQZiWI
	lIGAE3pA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwuFW-0000000AoCa-40ov;
	Thu, 20 Aug 2026 04:19:30 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwuFU-0000000AoBo-1YK6
	for linux-nvme@lists.infradead.org;
	Thu, 20 Aug 2026 04:19:29 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JLWOAP363674;
	Thu, 20 Aug 2026 04:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LudEY7
	oTjatYQtv0F3kl7pUuQIEnxxfWZVr8tOIRACQ=; b=JkezHklPAqcxXjGkTAm35j
	LT/ISMfqKJZLg+AaF7e1PDMzXUuxj3/A/nmTURHvRpd9nnvEV1MJLO+mvY0A3kAJ
	w8LVUfayosM5B7FOkInpRvUXormfOV3YWv0WZy8wUzcLGF/SxF1/eYDouTj207BW
	xGcjFAI/eQj2j/NOacMfyGx29BH5aY8fTDo+km3JMDH2vpI1qv9WyGJyahukT7Je
	ioz+semQ5/mukhApt7di57NrAYsHj2kPyvEpkYjlExoGzR2ezDcbOINpV65KqbqT
	ELABCRjUOsUH0NQpIM1fVZKtGV1aS4z42M7Sj4xXTgFagenl4ppBO6kxW0/KHI7Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu47sag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 04:19:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67K4BLFH020700;
	Thu, 20 Aug 2026 04:19:22 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354ym77s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 04:19:22 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67K4JJD827525704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 04:19:19 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7798B58250;
	Thu, 20 Aug 2026 04:19:19 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 503F85824C;
	Thu, 20 Aug 2026 04:19:17 +0000 (GMT)
Received: from [9.124.210.219] (unknown [9.124.210.219])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 20 Aug 2026 04:19:16 +0000 (GMT)
Message-ID: <4311bf7d-3f88-4a99-8ce3-5b435f90b48e@linux.ibm.com>
Date: Thu, 20 Aug 2026 09:49:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] nvme: Add module reference counting for multipath
 devices
To: wenxiong@linux.ibm.com, linux-nvme@lists.infradead.org, kbusch@kernel.org
Cc: gjoyce@linux.ibm.com, wenxiong@us.ibm.com, venkat88@linux.ibm.com
References: <20260812223206.720363-1-wenxiong@linux.ibm.com>
Content-Language: en-US
From: Nares Bannoth <nbannoth@linux.ibm.com>
In-Reply-To: <20260812223206.720363-1-wenxiong@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDAyNiBTYWx0ZWRfX036WX62sL3ZK
 2mVSY3vIkSCyjproDk29KafpANdSUFEhXTEmbFxB2g6pwyNqIFJsB25eRNj7ICgFwFJoeEkst7f
 iwkHF2I26RxjT/nCdeWHLAkcYhArMwA=
X-Proofpoint-GUID: IushSPgtRST3AFJvgd6B1e3X_M9rFhCk
X-Proofpoint-ORIG-GUID: IushSPgtRST3AFJvgd6B1e3X_M9rFhCk
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a86804b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=jSn5H0uHzrZjK6-VJCMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDAyNiBTYWx0ZWRfX7M6wG5aJIVUY
 C8zHUoY/QezjC9Cp2PLiBDxDu8CnhXLA4+7PGadcl6LzDt3YaCoLRqz86TveAHXxElF34sQ2lnf
 iCc/wT4QRSJib1RPFzPY/HBZPzUBJMxtOa2J9yYf1NYpfcSN/laFsYia0T/mjQmvE4yDTT/fEz2
 p4VmXADafhZ42xbIOjqjFDGCJsc62zXsLlMJStbe09ztPTlb7hNdAr/NalME04evN3dsQF+5KVS
 6C4H2yvuXISfuZwqrwwz0GmYsscMMtayxGb26jMNuo3PcRFH1/bZd+oyQIm9qDDaJUw+ZvDfXmh
 cmbWks+VUbaLZTzIysU50QJQ1IHgWXCAy/1LRf2+L31barTS57w7TllmCqZc2ZSeHwLh+oKezGz
 l7wO1E9W1pANIubWHd+CH+QRAS098nYXf5ZJ/UFZ14vPGxxIBPhcd14NdizxaZy6TV/LhaAUKhq
 fETFdJ94rX2Gt/1yRGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200026
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_211928_533272_42721339 
X-CRM114-Status: GOOD (  21.73  )
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


On 13/08/26 4:02 am, wenxiong@linux.ibm.com wrote:
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

Hi Wen,

I tested this patch and it is working as expected.

Patch Validation Results
--------------------------------
# lsmod | grep -i nvme
nvme_tcp              262144  0
nvme                  262144  9
nvme_fabrics          262144  1 nvme_tcp
nvme_core             458752  8 nvme_tcp,nvme,nvme_fabrics
nvme_keyring          262144  3 nvme_tcp,nvme_core,nvme_fabrics
nvme_auth             262144  1 nvme_core
# rmmod nvme
rmmod: ERROR: Module nvme is in use.
#
# rmmod nvme_tcp
#
# lsmod | grep -i nvme
nvme                  262144  9
nvme_fabrics          262144  0
nvme_core             458752  7 nvme,nvme_fabrics
nvme_keyring          262144  2 nvme_core,nvme_fabrics
nvme_auth             262144  1 nvme_core
# rmmod nvme_core
rmmod: ERROR: Module nvme_core is in use by: nvme nvme_fabrics
#
# rmmod nvme_fabrics
#
# rmmod nvme_core
rmmod: ERROR: Module nvme_core is in use by: nvme
#
# lsmod | grep -i nvme
nvme                  262144  9
nvme_core             458752  6 nvme
nvme_keyring          262144  1 nvme_core
nvme_auth             262144  1 nvme_core
#

Please add below tag :

Tested-by: Naresh Bannoth <nbannoth@linux.ibm.com>


Thanks and Regards,

Naresh.

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

