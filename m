Return-Path: <SRS0=sW0/=5L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108F3C43331
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 16:41:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBBA82074D
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 16:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BJjSlOJB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sVRnVWsn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBBA82074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ol3oSfVRF/5P0s8bqoK3b5SO/D6IC4uLSlL6wObD9nw=; b=BJjSlOJBOiq4HAzy/PgKwhNfz
	LJBcariYTN7SOLLR9NY17NvAyGoTuEmadiHdoAUvENJPInoe1XCTkvFtcRumorAnmpWDyyYa2G8zT
	zXFBGyrhdxkH5Wo/Ljjz4D7p4q+nIqA4M1s8GxRBN9dZm6IKkWZtKrhStPifuUCECzrWmZA5wO90l
	KEY03LtIlQLtdobhIrhAOzhIlKtNVVoixZpfTjZIN8MSr0KYhQMn1jCQV+CRwkhmzO2pvrUXV1S+L
	IgkkPqTLE6acGPCAGfRQ0g9a+3wB2523LXn9xpsxJXTTUPZmXjoPn/rM5Ld5fZvVReZqni6+PFgp/
	dA5FCD4gw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHVZS-0005TX-Pk; Thu, 26 Mar 2020 16:41:30 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHVZP-0005T7-TC
 for linux-nvme@lists.infradead.org; Thu, 26 Mar 2020 16:41:29 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QGeP9i020261;
 Thu, 26 Mar 2020 16:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=jAh7502XT9ULEWOuOftIP652MIatIIBbj8q5ArHHiiE=;
 b=sVRnVWsnsfdPD6k3vRwNCowLx02CZpBS+Z/4HOZJRNV9tej+DZZeIqQiUXopxClyvjpu
 YAJqC8wE6TaiHaN3xx7Nob8VOLH1h1Cc67Nq6Bto6SNuUeN2Jm3bWFKwNcrlCMkv+l9w
 RrefoV7N1urAq/aSnzud3tIkr5w+XXGMhvGlh9BagVFFblGCM9+uiJTtwHxcCyqOISRL
 bkYOSfWwfzMg9ODUXwTVESPM/X7FN4UhLdhchzIIETxwcv4plZ1waV02PiOBW/Ng9Jsz
 /ez1V9DEXyRf3avmV+MlKtZJtQMYLDjvrd0NIrLXYDyMdDW9uVPT+EJWuHhzoVNi3uus iQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 300urk1nqv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Mar 2020 16:41:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QGaaLj064329;
 Thu, 26 Mar 2020 16:41:23 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 2yxw4u0007-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Mar 2020 16:41:23 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02QGfLWa032570;
 Thu, 26 Mar 2020 16:41:22 GMT
Received: from [10.154.135.52] (/10.154.135.52)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 26 Mar 2020 09:41:21 -0700
Subject: Re: [PATCH 10/29] nvmefc: Use common definitions for LS names,
 formatting, and validation
To: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org
References: <20200205183753.25959-1-jsmart2021@gmail.com>
 <20200205183753.25959-11-jsmart2021@gmail.com>
From: Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle Corporation
Message-ID: <b51800ea-4e17-0468-29fa-2463cf494a0f@oracle.com>
Date: Thu, 26 Mar 2020 11:41:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200205183753.25959-11-jsmart2021@gmail.com>
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
X-CRM114-CacheID: sfid-20200326_094128_076536_C3C7F30E 
X-CRM114-Status: GOOD (  26.40  )
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
> Given that both host and target now generate and receive LS's create
> a single table definition for LS names. Each tranport half will have
> a local version of the table.
> 
> As Create Association LS is issued by both sides, and received by
> both sides, create common routines to format the LS and to validate
> the LS.
> 
> Convert the host side transport to use the new common Create
> Association LS formatting routine.
> 
> Convert the target side transport to use the new common Create
> Association LS validation routine.
> 
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> ---
>   drivers/nvme/host/fc.c   | 25 ++-------------
>   drivers/nvme/host/fc.h   | 79 ++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/nvme/target/fc.c | 28 ++---------------
>   3 files changed, 83 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 1a58e3dc0399..8fed69504c38 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -1421,29 +1421,8 @@ nvme_fc_xmt_disconnect_assoc(struct nvme_fc_ctrl *ctrl)
>   	else
>   		lsreq->private = NULL;
>   
> -	discon_rqst->w0.ls_cmd = FCNVME_LS_DISCONNECT_ASSOC;
> -	discon_rqst->desc_list_len = cpu_to_be32(
> -				sizeof(struct fcnvme_lsdesc_assoc_id) +
> -				sizeof(struct fcnvme_lsdesc_disconn_cmd));
> -
> -	discon_rqst->associd.desc_tag = cpu_to_be32(FCNVME_LSDESC_ASSOC_ID);
> -	discon_rqst->associd.desc_len =
> -			fcnvme_lsdesc_len(
> -				sizeof(struct fcnvme_lsdesc_assoc_id));
> -
> -	discon_rqst->associd.association_id = cpu_to_be64(ctrl->association_id);
> -
> -	discon_rqst->discon_cmd.desc_tag = cpu_to_be32(
> -						FCNVME_LSDESC_DISCONN_CMD);
> -	discon_rqst->discon_cmd.desc_len =
> -			fcnvme_lsdesc_len(
> -				sizeof(struct fcnvme_lsdesc_disconn_cmd));
> -
> -	lsreq->rqstaddr = discon_rqst;
> -	lsreq->rqstlen = sizeof(*discon_rqst);
> -	lsreq->rspaddr = discon_acc;
> -	lsreq->rsplen = sizeof(*discon_acc);
> -	lsreq->timeout = NVME_FC_LS_TIMEOUT_SEC;
> +	nvmefc_fmt_lsreq_discon_assoc(lsreq, discon_rqst, discon_acc,
> +				ctrl->association_id);
>   
>   	ret = nvme_fc_send_ls_req_async(ctrl->rport, lsop,
>   				nvme_fc_disconnect_assoc_done);
> diff --git a/drivers/nvme/host/fc.h b/drivers/nvme/host/fc.h
> index 08fa88381d45..05ce566f2caf 100644
> --- a/drivers/nvme/host/fc.h
> +++ b/drivers/nvme/host/fc.h
> @@ -17,6 +17,7 @@
>    */
>   
>   union nvmefc_ls_requests {
> +	struct fcnvme_ls_rqst_w0		w0;
>   	struct fcnvme_ls_cr_assoc_rqst		rq_cr_assoc;
>   	struct fcnvme_ls_cr_conn_rqst		rq_cr_conn;
>   	struct fcnvme_ls_disconnect_assoc_rqst	rq_dis_assoc;
> @@ -145,4 +146,82 @@ static char *validation_errors[] = {
>   	"Bad Disconnect ACC Length",
>   };
>   
> +#define NVME_FC_LAST_LS_CMD_VALUE	FCNVME_LS_DISCONNECT_CONN
> +
> +static char *nvmefc_ls_names[] = {
> +	"Reserved (0)",
> +	"RJT (1)",
> +	"ACC (2)",
> +	"Create Association",
> +	"Create Connection",
> +	"Disconnect Association",
> +	"Disconnect Connection",
> +};
> +
> +static inline void
> +nvmefc_fmt_lsreq_discon_assoc(struct nvmefc_ls_req *lsreq,
> +	struct fcnvme_ls_disconnect_assoc_rqst *discon_rqst,
> +	struct fcnvme_ls_disconnect_assoc_acc *discon_acc,
> +	u64 association_id)
> +{
> +	lsreq->rqstaddr = discon_rqst;
> +	lsreq->rqstlen = sizeof(*discon_rqst);
> +	lsreq->rspaddr = discon_acc;
> +	lsreq->rsplen = sizeof(*discon_acc);
> +	lsreq->timeout = NVME_FC_LS_TIMEOUT_SEC;
> +
> +	discon_rqst->w0.ls_cmd = FCNVME_LS_DISCONNECT_ASSOC;
> +	discon_rqst->desc_list_len = cpu_to_be32(
> +				sizeof(struct fcnvme_lsdesc_assoc_id) +
> +				sizeof(struct fcnvme_lsdesc_disconn_cmd));
> +
> +	discon_rqst->associd.desc_tag = cpu_to_be32(FCNVME_LSDESC_ASSOC_ID);
> +	discon_rqst->associd.desc_len =
> +			fcnvme_lsdesc_len(
> +				sizeof(struct fcnvme_lsdesc_assoc_id));
> +
> +	discon_rqst->associd.association_id = cpu_to_be64(association_id);
> +
> +	discon_rqst->discon_cmd.desc_tag = cpu_to_be32(
> +						FCNVME_LSDESC_DISCONN_CMD);
> +	discon_rqst->discon_cmd.desc_len =
> +			fcnvme_lsdesc_len(
> +				sizeof(struct fcnvme_lsdesc_disconn_cmd));
> +}
> +
> +static inline int
> +nvmefc_vldt_lsreq_discon_assoc(u32 rqstlen,
> +	struct fcnvme_ls_disconnect_assoc_rqst *rqst)
> +{
> +	int ret = 0;
> +
> +	if (rqstlen < sizeof(struct fcnvme_ls_disconnect_assoc_rqst))
> +		ret = VERR_DISCONN_LEN;
> +	else if (rqst->desc_list_len !=
> +			fcnvme_lsdesc_len(
> +				sizeof(struct fcnvme_ls_disconnect_assoc_rqst)))
> +		ret = VERR_DISCONN_RQST_LEN;
> +	else if (rqst->associd.desc_tag != cpu_to_be32(FCNVME_LSDESC_ASSOC_ID))
> +		ret = VERR_ASSOC_ID;
> +	else if (rqst->associd.desc_len !=
> +			fcnvme_lsdesc_len(
> +				sizeof(struct fcnvme_lsdesc_assoc_id)))
> +		ret = VERR_ASSOC_ID_LEN;
> +	else if (rqst->discon_cmd.desc_tag !=
> +			cpu_to_be32(FCNVME_LSDESC_DISCONN_CMD))
> +		ret = VERR_DISCONN_CMD;
> +	else if (rqst->discon_cmd.desc_len !=
> +			fcnvme_lsdesc_len(
> +				sizeof(struct fcnvme_lsdesc_disconn_cmd)))
> +		ret = VERR_DISCONN_CMD_LEN;
> +	/*
> +	 * As the standard changed on the LS, check if old format and scope
> +	 * something other than Association (e.g. 0).
> +	 */
> +	else if (rqst->discon_cmd.rsvd8[0])
> +		ret = VERR_DISCONN_SCOPE;
> +
> +	return ret;
> +}
> +
>   #endif /* _NVME_FC_TRANSPORT_H */
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 66a60a218994..5739df7edc59 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -1442,32 +1442,8 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
>   
>   	memset(acc, 0, sizeof(*acc));
>   
> -	if (iod->rqstdatalen < sizeof(struct fcnvme_ls_disconnect_assoc_rqst))
> -		ret = VERR_DISCONN_LEN;
> -	else if (rqst->desc_list_len !=
> -			fcnvme_lsdesc_len(
> -				sizeof(struct fcnvme_ls_disconnect_assoc_rqst)))
> -		ret = VERR_DISCONN_RQST_LEN;
> -	else if (rqst->associd.desc_tag != cpu_to_be32(FCNVME_LSDESC_ASSOC_ID))
> -		ret = VERR_ASSOC_ID;
> -	else if (rqst->associd.desc_len !=
> -			fcnvme_lsdesc_len(
> -				sizeof(struct fcnvme_lsdesc_assoc_id)))
> -		ret = VERR_ASSOC_ID_LEN;
> -	else if (rqst->discon_cmd.desc_tag !=
> -			cpu_to_be32(FCNVME_LSDESC_DISCONN_CMD))
> -		ret = VERR_DISCONN_CMD;
> -	else if (rqst->discon_cmd.desc_len !=
> -			fcnvme_lsdesc_len(
> -				sizeof(struct fcnvme_lsdesc_disconn_cmd)))
> -		ret = VERR_DISCONN_CMD_LEN;
> -	/*
> -	 * As the standard changed on the LS, check if old format and scope
> -	 * something other than Association (e.g. 0).
> -	 */
> -	else if (rqst->discon_cmd.rsvd8[0])
> -		ret = VERR_DISCONN_SCOPE;
> -	else {
> +	ret = nvmefc_vldt_lsreq_discon_assoc(iod->rqstdatalen, rqst);
> +	if (!ret) {
>   		/* match an active association */
>   		assoc = nvmet_fc_find_target_assoc(tgtport,
>   				be64_to_cpu(rqst->associd.association_id));
> 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
