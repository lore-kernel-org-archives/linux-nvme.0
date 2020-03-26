Return-Path: <SRS0=sW0/=5L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C70FC43331
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 16:42:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC0FA2074D
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 16:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UdatHHms";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SI1IiL+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC0FA2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NalKhpFMt+lh7d9TjcjKU6UTpjFr27HL0mWLoeQ4P50=; b=UdatHHmsEhfIvosCzy6GZkg7H
	yE7IbhqzbKGgXMn2jDew16+85ePRj3baTpJWdbepJ4hXhV+5vW1wzkYCL3GoV5dpbHQsPmi+Vv2yW
	EkS7fS7EhTr46W0xyzWImo8YqntBC3zGQHRWjEzk4/1/tpEePzinmxcnEKYiUALKwvQJdo1QVlKtD
	bybxvTmuRv3jrxL8w+E/OnDN2rxzrj14GD9XEIiHgyK1e/sexZfFySEAT6q9dokNM96iY7W+JprfC
	QvCjp2b9kBdu+zubku1YtQgBydSD5LLjCnl8plJ4m3k4+I42WsfgWjtsvbUlWS/GXSVORucjMLpgD
	lpgoIspyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHVZt-0005eD-3u; Thu, 26 Mar 2020 16:41:57 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHVZp-0005dn-HZ
 for linux-nvme@lists.infradead.org; Thu, 26 Mar 2020 16:41:55 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QGeVoG020384;
 Thu, 26 Mar 2020 16:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=MMv7n/lctrPxtpLwBIs0Lrt6K6wtF7Vm86qHB1y29/U=;
 b=SI1IiL+Kv3EE8iUTtjnTchUMRXePKE4sCr9zmW5QjaDBcdtqC05UyN+8jdnzldx5p77Q
 siRK+2DyOC1F22H4zoTo0x/A2jrzkDyTx9TqHKjVP3Rj511cA+QUr3QHMjSE+f1jABxG
 ReoqOtOTvms9ajxzRBCXSNP4DfeeU8/IU+WisSvAaLtqZZ2PTKDsmEcvuS4V2KUhmrsI
 9Z0OxvluzeMNaot68/0ohQYQ3q1snmUb9zd8/wHLQq9V5zq7JBN4OqatUmYXITyUL7GE
 ZO7SY1WSv1FOi05xuT0dt2wEgfM4IsV1KaQzhEQrWTDU+36Sd4kFURTayiDK/FXcEOKs oA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 300urk1nt2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Mar 2020 16:41:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QGaVZc063887;
 Thu, 26 Mar 2020 16:39:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 2yxw4tyw5k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Mar 2020 16:39:50 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02QGdn4g008174;
 Thu, 26 Mar 2020 16:39:49 GMT
Received: from [10.154.135.52] (/10.154.135.52)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 26 Mar 2020 09:39:49 -0700
Subject: Re: [PATCH 09/29] nvme-fc: Ensure private pointers are NULL if no data
To: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org
References: <20200205183753.25959-1-jsmart2021@gmail.com>
 <20200205183753.25959-10-jsmart2021@gmail.com>
From: Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle Corporation
Message-ID: <e1a5f53d-1cd7-b3fe-b98a-38413483b92c@oracle.com>
Date: Thu, 26 Mar 2020 11:39:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200205183753.25959-10-jsmart2021@gmail.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 mlxscore=0 phishscore=0
 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003260129
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200326_094153_670784_B3F94FBE 
X-CRM114-Status: GOOD (  23.53  )
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
Cc: martin.petersen@oracle.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/5/2020 12:37 PM, James Smart wrote:
> Ensure that when allocations are done, and the lldd options indicate
> no private data is needed, that private pointers will be set to NULL
> (catches driver error that forgot to set private data size).
> 
> Slightly reorg the allocations so that private data follows allocations
> for LS request/response buffers. Ensures better alignments for the buffers
> as well as the private pointer.
> 
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> ---
>   drivers/nvme/host/fc.c   | 81 ++++++++++++++++++++++++++++++------------------
>   drivers/nvme/target/fc.c |  5 ++-
>   2 files changed, 54 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 2e5163600f63..1a58e3dc0399 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -396,7 +396,10 @@ nvme_fc_register_localport(struct nvme_fc_port_info *pinfo,
>   	newrec->ops = template;
>   	newrec->dev = dev;
>   	ida_init(&newrec->endp_cnt);
> -	newrec->localport.private = &newrec[1];
> +	if (template->local_priv_sz)
> +		newrec->localport.private = &newrec[1];
> +	else
> +		newrec->localport.private = NULL;
>   	newrec->localport.node_name = pinfo->node_name;
>   	newrec->localport.port_name = pinfo->port_name;
>   	newrec->localport.port_role = pinfo->port_role;
> @@ -705,7 +708,10 @@ nvme_fc_register_remoteport(struct nvme_fc_local_port *localport,
>   	newrec->remoteport.localport = &lport->localport;
>   	newrec->dev = lport->dev;
>   	newrec->lport = lport;
> -	newrec->remoteport.private = &newrec[1];
> +	if (lport->ops->remote_priv_sz)
> +		newrec->remoteport.private = &newrec[1];
> +	else
> +		newrec->remoteport.private = NULL;
>   	newrec->remoteport.port_role = pinfo->port_role;
>   	newrec->remoteport.node_name = pinfo->node_name;
>   	newrec->remoteport.port_name = pinfo->port_name;
> @@ -1153,18 +1159,23 @@ nvme_fc_connect_admin_queue(struct nvme_fc_ctrl *ctrl,
>   	int ret, fcret = 0;
>   
>   	lsop = kzalloc((sizeof(*lsop) +
> -			 ctrl->lport->ops->lsrqst_priv_sz +
> -			 sizeof(*assoc_rqst) + sizeof(*assoc_acc)), GFP_KERNEL);
> +			 sizeof(*assoc_rqst) + sizeof(*assoc_acc) +
> +			 ctrl->lport->ops->lsrqst_priv_sz), GFP_KERNEL);
>   	if (!lsop) {
> +		dev_info(ctrl->ctrl.device,
> +			"NVME-FC{%d}: send Create Association failed: ENOMEM\n",
> +			ctrl->cnum);
>   		ret = -ENOMEM;
>   		goto out_no_memory;
>   	}
> -	lsreq = &lsop->ls_req;
>   
> -	lsreq->private = (void *)&lsop[1];
> -	assoc_rqst = (struct fcnvme_ls_cr_assoc_rqst *)
> -			(lsreq->private + ctrl->lport->ops->lsrqst_priv_sz);
> +	assoc_rqst = (struct fcnvme_ls_cr_assoc_rqst *)&lsop[1];
>   	assoc_acc = (struct fcnvme_ls_cr_assoc_acc *)&assoc_rqst[1];
> +	lsreq = &lsop->ls_req;
> +	if (ctrl->lport->ops->lsrqst_priv_sz)
> +		lsreq->private = &assoc_acc[1];
> +	else
> +		lsreq->private = NULL;
>   
>   	assoc_rqst->w0.ls_cmd = FCNVME_LS_CREATE_ASSOCIATION;
>   	assoc_rqst->desc_list_len =
> @@ -1262,18 +1273,23 @@ nvme_fc_connect_queue(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
>   	int ret, fcret = 0;
>   
>   	lsop = kzalloc((sizeof(*lsop) +
> -			 ctrl->lport->ops->lsrqst_priv_sz +
> -			 sizeof(*conn_rqst) + sizeof(*conn_acc)), GFP_KERNEL);
> +			 sizeof(*conn_rqst) + sizeof(*conn_acc) +
> +			 ctrl->lport->ops->lsrqst_priv_sz), GFP_KERNEL);
>   	if (!lsop) {
> +		dev_info(ctrl->ctrl.device,
> +			"NVME-FC{%d}: send Create Connection failed: ENOMEM\n",
> +			ctrl->cnum);
>   		ret = -ENOMEM;
>   		goto out_no_memory;
>   	}
> -	lsreq = &lsop->ls_req;
>   
> -	lsreq->private = (void *)&lsop[1];
> -	conn_rqst = (struct fcnvme_ls_cr_conn_rqst *)
> -			(lsreq->private + ctrl->lport->ops->lsrqst_priv_sz);
> +	conn_rqst = (struct fcnvme_ls_cr_conn_rqst *)&lsop[1];
>   	conn_acc = (struct fcnvme_ls_cr_conn_acc *)&conn_rqst[1];
> +	lsreq = &lsop->ls_req;
> +	if (ctrl->lport->ops->lsrqst_priv_sz)
> +		lsreq->private = (void *)&conn_acc[1];
> +	else
> +		lsreq->private = NULL;
>   
>   	conn_rqst->w0.ls_cmd = FCNVME_LS_CREATE_CONNECTION;
>   	conn_rqst->desc_list_len = cpu_to_be32(
> @@ -1387,19 +1403,23 @@ nvme_fc_xmt_disconnect_assoc(struct nvme_fc_ctrl *ctrl)
>   	int ret;
>   
>   	lsop = kzalloc((sizeof(*lsop) +
> -			 ctrl->lport->ops->lsrqst_priv_sz +
> -			 sizeof(*discon_rqst) + sizeof(*discon_acc)),
> -			GFP_KERNEL);
> -	if (!lsop)
> -		/* couldn't sent it... too bad */
> +			sizeof(*discon_rqst) + sizeof(*discon_acc) +
> +			ctrl->lport->ops->lsrqst_priv_sz), GFP_KERNEL);
> +	if (!lsop) {
> +		dev_info(ctrl->ctrl.device,
> +			"NVME-FC{%d}: send Disconnect Association "
> +			"failed: ENOMEM\n",
> +			ctrl->cnum);
>   		return;
> +	}
>   
> -	lsreq = &lsop->ls_req;
> -
> -	lsreq->private = (void *)&lsop[1];
> -	discon_rqst = (struct fcnvme_ls_disconnect_assoc_rqst *)
> -			(lsreq->private + ctrl->lport->ops->lsrqst_priv_sz);
> +	discon_rqst = (struct fcnvme_ls_disconnect_assoc_rqst *)&lsop[1];
>   	discon_acc = (struct fcnvme_ls_disconnect_assoc_acc *)&discon_rqst[1];
> +	lsreq = &lsop->ls_req;
> +	if (ctrl->lport->ops->lsrqst_priv_sz)
> +		lsreq->private = (void *)&discon_acc[1];
> +	else
> +		lsreq->private = NULL;
>   
>   	discon_rqst->w0.ls_cmd = FCNVME_LS_DISCONNECT_ASSOC;
>   	discon_rqst->desc_list_len = cpu_to_be32(
> @@ -1785,15 +1805,17 @@ nvme_fc_init_aen_ops(struct nvme_fc_ctrl *ctrl)
>   	struct nvme_fc_fcp_op *aen_op;
>   	struct nvme_fc_cmd_iu *cmdiu;
>   	struct nvme_command *sqe;
> -	void *private;
> +	void *private = NULL;
>   	int i, ret;
>   
>   	aen_op = ctrl->aen_ops;
>   	for (i = 0; i < NVME_NR_AEN_COMMANDS; i++, aen_op++) {
> -		private = kzalloc(ctrl->lport->ops->fcprqst_priv_sz,
> +		if (ctrl->lport->ops->fcprqst_priv_sz) {
> +			private = kzalloc(ctrl->lport->ops->fcprqst_priv_sz,
>   						GFP_KERNEL);
> -		if (!private)
> -			return -ENOMEM;
> +			if (!private)
> +				return -ENOMEM;
> +		}
>   
>   		cmdiu = &aen_op->cmd_iu;
>   		sqe = &cmdiu->sqe;
> @@ -1824,9 +1846,6 @@ nvme_fc_term_aen_ops(struct nvme_fc_ctrl *ctrl)
>   
>   	aen_op = ctrl->aen_ops;
>   	for (i = 0; i < NVME_NR_AEN_COMMANDS; i++, aen_op++) {
> -		if (!aen_op->fcp_req.private)
> -			continue;
> -
>   		__nvme_fc_exit_request(ctrl, aen_op);
>   
>   		kfree(aen_op->fcp_req.private);
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 66de6bd8f4fd..66a60a218994 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -1047,7 +1047,10 @@ nvmet_fc_register_targetport(struct nvmet_fc_port_info *pinfo,
>   
>   	newrec->fc_target_port.node_name = pinfo->node_name;
>   	newrec->fc_target_port.port_name = pinfo->port_name;
> -	newrec->fc_target_port.private = &newrec[1];
> +	if (template->target_priv_sz)
> +		newrec->fc_target_port.private = &newrec[1];
> +	else
> +		newrec->fc_target_port.private = NULL;
>   	newrec->fc_target_port.port_id = pinfo->port_id;
>   	newrec->fc_target_port.port_num = idx;
>   	INIT_LIST_HEAD(&newrec->tgt_list);
> 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
