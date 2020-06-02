Return-Path: <SRS0=vW9m=7P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1219C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2020 14:47:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F4D52068D
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2020 14:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mF4Gx4yK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BHIv0WnW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4D52068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XuAYApbkvACptO7ywNEFMYQ/DxcPAnQxlvwohftmRrA=; b=mF4Gx4yK9x0T+0QLbA9AjEdzC
	ScskQIIAOcpu2aKA5nuzQ2l9Fos23I4pLlAHw1CDA+FRXY6U4mobUDPtYq/SN6UCnBE9KFETXQT4K
	+AFCZ4iELeokSCGRPMYjAGXUNcJEOP/NcBJgcmX0S2xekmJ/fnBH5/3vYVC/vrScAYVlmTAQP9PeB
	rA0JSGSRmMUovn/FpboDUmmGkQ9lJ0ZzZ4xFKY88hoz7pHBUMQhKtzN9bdDIVgsVgVOKBmoYyJaMF
	hfO8UaxZk1HVMV5vj8KlITiHBKn1tDfLqLzi4QDMDBnVNLuu/QDA7SyKQc4H7oI+v0T/3HJoM47fn
	0zPQwUu3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jg8Bu-0007Kl-B0; Tue, 02 Jun 2020 14:46:58 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jg8Br-0007Gu-PG
 for linux-nvme@lists.infradead.org; Tue, 02 Jun 2020 14:46:57 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052Eg9OG009245;
 Tue, 2 Jun 2020 14:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=goeSsaFFE1a1gAGYzIwB9TM7Ebyq8VeCLgFoKYf8a+Y=;
 b=BHIv0WnWIXjP0MgQvGh6MgupJd3nNhMyDEaXqREtBk0/CsUFUKZ/qhzz5z+Xjw+3hHl+
 q5U09YgvKRT1N5WnFupswmAzMvTD1VaY4BYkCTP8GAONBDYgjUPL+WEoGcEPDc+nUaiB
 G3AC2Sis/rkp83tUY3H5PN6p+Xxim+0Hvi5Aq6OthkptDeEpBG92J5synZBsxkslYup0
 mZ9Zw8e61IJSrNg1xAn0qvOLA0rqZNhI4wvaOpZpE7+7ngIoqKXXL5HnxmGH4AcYidLi
 ixeLVO2ATrNnoAkUrH2j39oEF37qfw7RbGLdROAT28ObPKf4HtIjOwCW+7Id5G55KiFz zA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 31bewqvgn1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 02 Jun 2020 14:46:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052EhwY0054062;
 Tue, 2 Jun 2020 14:46:51 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 31c25p4msn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 02 Jun 2020 14:46:51 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 052Ekoe1008819;
 Tue, 2 Jun 2020 14:46:50 GMT
Received: from [10.154.114.83] (/10.154.114.83)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 02 Jun 2020 07:46:50 -0700
Subject: Re: [PATCH 3/5] nvme: replace transport name with trtype enum for ops
To: Max Gurtovoy <maxg@mellanox.com>, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 james.smart@broadcom.com, chaitanya.kulkarni@wdc.com
References: <20200602131546.51903-1-maxg@mellanox.com>
 <20200602131546.51903-4-maxg@mellanox.com>
From: Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle Corporation
Message-ID: <d9050476-d4df-6e5d-dd4d-a58daa3dd0ed@oracle.com>
Date: Tue, 2 Jun 2020 09:46:49 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200602131546.51903-4-maxg@mellanox.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006020105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=0 impostorscore=0 cotscore=-2147483648
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006020105
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200602_074655_979797_D5BA28F5 
X-CRM114-Status: GOOD (  22.40  )
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
Cc: israelr@mellanox.com, nitzanc@mellanox.com, oren@mellanox.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 6/2/20 8:15 AM, Max Gurtovoy wrote:
> Use common code to map transport type to transport name instead of
> duplicating logic.
> 
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> Reviewed-by: Israel Rukshin <israelr@mellanox.com>
> ---
>   drivers/nvme/host/fabrics.c | 3 ++-
>   drivers/nvme/host/fabrics.h | 4 ++--
>   drivers/nvme/host/fc.c      | 2 +-
>   drivers/nvme/host/rdma.c    | 2 +-
>   drivers/nvme/host/tcp.c     | 2 +-
>   drivers/nvme/target/loop.c  | 2 +-
>   6 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 2a6c819..bd5e44e 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -528,7 +528,8 @@ static struct nvmf_transport_ops *nvmf_lookup_transport(
>   	lockdep_assert_held(&nvmf_transports_rwsem);
>   
>   	list_for_each_entry(ops, &nvmf_transports, entry) {
> -		if (strcmp(ops->name, opts->transport) == 0)
> +		if (strcmp(nvme_trtype_to_name(ops->trtype),
> +			   opts->transport) == 0)
>   			return ops;
>   	}
>   
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index a0ec40a..1fd52f0 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -119,7 +119,7 @@ struct nvmf_ctrl_options {
>    * @entry:		Used by the fabrics library to add the new
>    *			registration entry to its linked-list internal tree.
>    * @module:             Transport module reference
> - * @name:		Name of the NVMe fabric driver implementation.
> + * @trtype:		NVMe fabric transport type
>    * @required_opts:	sysfs command-line options that must be specified
>    *			when adding a new NVMe controller.
>    * @allowed_opts:	sysfs command-line options that can be specified
> @@ -141,7 +141,7 @@ struct nvmf_ctrl_options {
>   struct nvmf_transport_ops {
>   	struct list_head	entry;
>   	struct module		*module;
> -	const char		*name;
> +	u8			trtype;
>   	int			required_opts;
>   	int			allowed_opts;
>   	struct nvme_ctrl	*(*create_ctrl)(struct device *dev,
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index cb00075..67db0ae 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -3694,7 +3694,7 @@ struct nvmet_fc_traddr {
>   
>   
>   static struct nvmf_transport_ops nvme_fc_transport = {
> -	.name		= "fc",
> +	.trtype		= NVMF_TRTYPE_FC,
>   	.module		= THIS_MODULE,
>   	.required_opts	= NVMF_OPT_TRADDR | NVMF_OPT_HOST_TRADDR,
>   	.allowed_opts	= NVMF_OPT_RECONNECT_DELAY | NVMF_OPT_CTRL_LOSS_TMO,
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index f8f856d..5e7dda3 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -2329,7 +2329,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
>   }
>   
>   static struct nvmf_transport_ops nvme_rdma_transport = {
> -	.name		= "rdma",
> +	.trtype		= NVMF_TRTYPE_RDMA,
>   	.module		= THIS_MODULE,
>   	.required_opts	= NVMF_OPT_TRADDR,
>   	.allowed_opts	= NVMF_OPT_TRSVCID | NVMF_OPT_RECONNECT_DELAY |
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 7c7c188..c678f97 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2487,7 +2487,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
>   }
>   
>   static struct nvmf_transport_ops nvme_tcp_transport = {
> -	.name		= "tcp",
> +	.trtype		= NVMF_TRTYPE_TCP,
>   	.module		= THIS_MODULE,
>   	.required_opts	= NVMF_OPT_TRADDR,
>   	.allowed_opts	= NVMF_OPT_TRSVCID | NVMF_OPT_RECONNECT_DELAY |
> diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> index 0d54e73..257ee60 100644
> --- a/drivers/nvme/target/loop.c
> +++ b/drivers/nvme/target/loop.c
> @@ -674,7 +674,7 @@ static void nvme_loop_remove_port(struct nvmet_port *port)
>   };
>   
>   static struct nvmf_transport_ops nvme_loop_transport = {
> -	.name		= "loop",
> +	.trtype		= NVMF_TRTYPE_LOOP,
>   	.module		= THIS_MODULE,
>   	.create_ctrl	= nvme_loop_create_ctrl,
>   	.allowed_opts	= NVMF_OPT_TRADDR,
> 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

-- 
Himanshu Madhani                     Oracle Linux Engineering

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
