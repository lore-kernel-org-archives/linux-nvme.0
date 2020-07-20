Return-Path: <SRS0=fGVD=A7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBDEC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 21:11:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82419207DF
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 21:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nzI0WL5Y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VFkVsaDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82419207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=j45hyt7dlPmmxb3HIbyQvYsu49JNU0Xz8/MECG3yWQw=; b=nzI0WL5Y/Coq//Sewiw15+iT4
	kCFtAt2LKJhxwwW5G52lRzW7BWKEtQd0XHfjwxgXYUqhAf9cAtxcEL0/s1pL1e8sKOkh8HPUvd2vr
	LvWeYR6OdsZSPmBRNWNYarV18k9680oUN59VeNlYaQDWRug3WatrLr7Jgh4xvel8J2uCmONO64Jpq
	TAY9QMmlA65HclYd4MtwJlsDBwa4XTA4VVEp8gCO8QPoGuDb0Q0ROIRl5B7A+Tx2Mv6tKwK2Af8lq
	Q9hvlt7RUyzubdI6naXAiOw/fZzGb6zvIb7zFKwbZWDTIZiD+EnWexy8Xa3QYrNwz5VKPfboxlEW/
	N/FkkBdew==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jxd4e-0007ig-3x; Mon, 20 Jul 2020 21:11:48 +0000
Received: from aserp2130.oracle.com ([141.146.126.79])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxd4b-0007i7-Jr
 for linux-nvme@lists.infradead.org; Mon, 20 Jul 2020 21:11:46 +0000
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06KKCvoP129108;
 Mon, 20 Jul 2020 21:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=GePUqfEDRRfa2CgI4/OOfx9YLeWVDVDOMSDsxJqusp8=;
 b=VFkVsaDquHkSCE+yvbJC3krR3hZclwc/kBeWrylRf6uV5IKgZx6DRmpZl4ZIzp97DywF
 m8S74+3nfRrV0OkM1fiwDWkGWq8wBDP3ay0vf/asTQ+2eLdKQLYaRcGAkVf6R9+xOoK5
 03v8lJlFgd0XHGneW2VEAbzP3DFp6X41spSAWZmTRZCoOEKO5G2QsEjattHtC3f14+/J
 Rbzz8SSzgDfSZYo8wpu6xDDMn3RoDt3Uq6jvpt47k4XNXjCG9TJ5/U0lO3hAkWTCtrJz
 IueYIAF4RfDTZ55C1lL/VO2qeLVssxFtqXiW4G61Jaz2V32W8An6kyrKKdji+SAsP0aZ rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2130.oracle.com with ESMTP id 32bpkb1k45-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 20 Jul 2020 21:11:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06KL2OZx019408;
 Mon, 20 Jul 2020 21:11:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 32dju78ej8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Jul 2020 21:11:41 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06KLBffO004965;
 Mon, 20 Jul 2020 21:11:41 GMT
Received: from [10.154.128.234] (/10.154.128.234)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 20 Jul 2020 21:11:41 +0000
Subject: Re: [PATCH] nvme-fc: set max_segments to lldd max value
To: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org
References: <20200714190336.119013-1-jsmart2021@gmail.com>
From: Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle Corporation
Message-ID: <cbdbc8cd-65bc-49d7-b8d0-cb52ce4b36b4@oracle.com>
Date: Mon, 20 Jul 2020 16:11:40 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200714190336.119013-1-jsmart2021@gmail.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9688
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007200136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9688
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007200136
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200720_171145_752167_ACCD7CD9 
X-CRM114-Status: GOOD (  26.62  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Max Gurtovoy <maxg@mellanox.com>, "Ewan D . Milne" <emilne@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 7/14/20 2:03 PM, James Smart wrote:
> Currently the FC transport is set max_hw_sectors based on the lldds
> max sgl segment count. However, the block queue max segments is
> set based on the controller's max_segments count, which the transport
> does not set.  As such, the lldd is receiving sgl lists that are
> exceeding its max segment count.
> 
> Set the controller max segment count and derive max_hw_sectors from
> the max segment count.
> 
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> Reviewed-by: Ewan D. Milne <emilne@redhat.com>
> CC: Max Gurtovoy <maxg@mellanox.com>
> 
> ---
> Looks like the setting of max_segments has been missing from all
> fabric transports for a while. Rdma had a fixup (ff13c1b87c97) from
> Max last fall that corrected this. But tcp and fc were still lacking.
> Copying Max to look at tcp.
> ---
>   drivers/nvme/host/fc.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 6aa30bb5a762..e57e536546f7 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -3001,8 +3001,9 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
>   	if (ret)
>   		goto out_disconnect_admin_queue;
>   
> -	ctrl->ctrl.max_hw_sectors =
> -		(ctrl->lport->ops->max_sgl_segments - 1) << (PAGE_SHIFT - 9);
> +	ctrl->ctrl.max_segments = ctrl->lport->ops->max_sgl_segments;
> +	ctrl->ctrl.max_hw_sectors = ctrl->ctrl.max_segments <<
> +						(ilog2(SZ_4K) - 9);
>   
>   	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
>   
> 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

-- 
Himanshu Madhani                     Oracle Linux Engineering

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
