Return-Path: <SRS0=sW0/=5L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5C4C43331
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 16:36:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A35422078E
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 16:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xd4e6kVZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zHodvDBv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35422078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=D+23P74uJ6edv9Pgi4U/n2T56MJYom3Nzl34AyDBCaQ=; b=Xd4e6kVZPc4eq8+X22ChvPmD1
	y/e7bCZX7AsWT/IHTd57fViZjj3PUpFpV7BqfAjWtMuJ0G36mxe7jiNRlTt/EjTqf6K+wswgs5EFU
	Jv5SXfPo62crKBeqBPkAbTIy8Ea/GoBV26N4QCxURY0mK9OuBiRqxo2aymaYEiyo8v4CY/mUfWr2T
	63JYZT/m9RdcwwtKsydQwPijWUINOhzFVRHTMU5MhMOP9ChHq3jADYyNoz18d9Pe7rqkSvJE2Y0k6
	vc0XGp9GvCE8bXI9QY323GPFVhMxMYWzPNJIBX8sjTChyZXD1wTIUhIJ5jo6CtQ73USxSjyV1QYfX
	pls875YWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHVUQ-0003VS-Ks; Thu, 26 Mar 2020 16:36:18 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHVUN-0003V2-I2
 for linux-nvme@lists.infradead.org; Thu, 26 Mar 2020 16:36:17 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QGXFYY023257;
 Thu, 26 Mar 2020 16:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=HQHLCn/KjqJzEqBeCZ1oYcYRYEXIAW5yTTqzcz5KvIA=;
 b=zHodvDBvI417cACGZhAvduYTYN4LxzWjJJDnAPAte0fIk5S5B9z03fXf2HsJtdOlh8KH
 xnH3WQl35zMBVoCFIcOrHs3PKdZM5gBAwPPmuZMWC2Dq7rwPtRTFiKOLMxuxmpddr9X2
 WSADTZFdjw/p5t8M97KM5xG8J3gkNxypZAznDJDa1RoA1zpfF4pWO1NQXqaI3Vvx3d66
 Sx2/vkx65PzGKsEU2NyqIVm48FKwqyXhiKoKVSWRmMJ8rzB1oLAzJRSPyN6RsgfIe9cX
 vOYLMl/XpGrlpeXCWjgCtF+B9S+x0wh8/rWFexmr8zCN72BUM8vXJh649JC35j2hv6mh Zw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2ywabrgxf9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Mar 2020 16:36:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QGVsQX046883;
 Thu, 26 Mar 2020 16:36:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 3006r8r5n7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Mar 2020 16:36:12 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02QGaAfT031732;
 Thu, 26 Mar 2020 16:36:11 GMT
Received: from [10.154.135.52] (/10.154.135.52)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 26 Mar 2020 09:36:10 -0700
Subject: Re: [PATCH 07/29] nvme-fc nvmet-fc: refactor for common LS definitions
To: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org
References: <20200205183753.25959-1-jsmart2021@gmail.com>
 <20200205183753.25959-8-jsmart2021@gmail.com>
From: Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle Corporation
Message-ID: <05ae8564-816a-7d15-0199-829b1afb9aa1@oracle.com>
Date: Thu, 26 Mar 2020 11:36:07 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200205183753.25959-8-jsmart2021@gmail.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003260128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260128
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200326_093615_685104_EED1B74B 
X-CRM114-Status: GOOD (  23.72  )
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
> Routines in the target will want to be used in the host as well.
> Error definitions should now shared as both sides will process
> requests and responses to requests.
> 
> Moved common declarations to new fc.h header kept in the host
> subdirectory.
> 
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> ---
>   drivers/nvme/host/fc.c   |  36 +------------
>   drivers/nvme/host/fc.h   | 133 +++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/nvme/target/fc.c | 115 ++++------------------------------------
>   3 files changed, 143 insertions(+), 141 deletions(-)
>   create mode 100644 drivers/nvme/host/fc.h
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index f8f79cd88769..2e5163600f63 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -14,6 +14,7 @@
>   #include "fabrics.h"
>   #include <linux/nvme-fc-driver.h>
>   #include <linux/nvme-fc.h>
> +#include "fc.h"
>   #include <scsi/scsi_transport_fc.h>
>   
>   /* *************************** Data Structures/Defines ****************** */
> @@ -1141,41 +1142,6 @@ nvme_fc_send_ls_req_async(struct nvme_fc_rport *rport,
>   	return __nvme_fc_send_ls_req(rport, lsop, done);
>   }
>   
> -/* Validation Error indexes into the string table below */
> -enum {
> -	VERR_NO_ERROR		= 0,
> -	VERR_LSACC		= 1,
> -	VERR_LSDESC_RQST	= 2,
> -	VERR_LSDESC_RQST_LEN	= 3,
> -	VERR_ASSOC_ID		= 4,
> -	VERR_ASSOC_ID_LEN	= 5,
> -	VERR_CONN_ID		= 6,
> -	VERR_CONN_ID_LEN	= 7,
> -	VERR_CR_ASSOC		= 8,
> -	VERR_CR_ASSOC_ACC_LEN	= 9,
> -	VERR_CR_CONN		= 10,
> -	VERR_CR_CONN_ACC_LEN	= 11,
> -	VERR_DISCONN		= 12,
> -	VERR_DISCONN_ACC_LEN	= 13,
> -};
> -
> -static char *validation_errors[] = {
> -	"OK",
> -	"Not LS_ACC",
> -	"Not LSDESC_RQST",
> -	"Bad LSDESC_RQST Length",
> -	"Not Association ID",
> -	"Bad Association ID Length",
> -	"Not Connection ID",
> -	"Bad Connection ID Length",
> -	"Not CR_ASSOC Rqst",
> -	"Bad CR_ASSOC ACC Length",
> -	"Not CR_CONN Rqst",
> -	"Bad CR_CONN ACC Length",
> -	"Not Disconnect Rqst",
> -	"Bad Disconnect ACC Length",
> -};
> -
>   static int
>   nvme_fc_connect_admin_queue(struct nvme_fc_ctrl *ctrl,
>   	struct nvme_fc_queue *queue, u16 qsize, u16 ersp_ratio)
> diff --git a/drivers/nvme/host/fc.h b/drivers/nvme/host/fc.h
> new file mode 100644
> index 000000000000..d2861cdd58ee
> --- /dev/null
> +++ b/drivers/nvme/host/fc.h
> @@ -0,0 +1,133 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2016, Avago Technologies
> + */
> +
> +#ifndef _NVME_FC_TRANSPORT_H
> +#define _NVME_FC_TRANSPORT_H 1
> +
> +
> +/*
> + * Common definitions between the nvme_fc (host) transport and
> + * nvmet_fc (target) transport implementation.
> + */
> +
> +/*
> + * ******************  FC-NVME LS HANDLING ******************
> + */
> +
> +static inline void
> +nvme_fc_format_rsp_hdr(void *buf, u8 ls_cmd, __be32 desc_len, u8 rqst_ls_cmd)
> +{
> +	struct fcnvme_ls_acc_hdr *acc = buf;
> +
> +	acc->w0.ls_cmd = ls_cmd;
> +	acc->desc_list_len = desc_len;
> +	acc->rqst.desc_tag = cpu_to_be32(FCNVME_LSDESC_RQST);
> +	acc->rqst.desc_len =
> +			fcnvme_lsdesc_len(sizeof(struct fcnvme_lsdesc_rqst));
> +	acc->rqst.w0.ls_cmd = rqst_ls_cmd;
> +}
> +
> +static inline int
> +nvme_fc_format_rjt(void *buf, u16 buflen, u8 ls_cmd,
> +			u8 reason, u8 explanation, u8 vendor)
> +{
> +	struct fcnvme_ls_rjt *rjt = buf;
> +
> +	nvme_fc_format_rsp_hdr(buf, FCNVME_LSDESC_RQST,
> +			fcnvme_lsdesc_len(sizeof(struct fcnvme_ls_rjt)),
> +			ls_cmd);
> +	rjt->rjt.desc_tag = cpu_to_be32(FCNVME_LSDESC_RJT);
> +	rjt->rjt.desc_len = fcnvme_lsdesc_len(sizeof(struct fcnvme_lsdesc_rjt));
> +	rjt->rjt.reason_code = reason;
> +	rjt->rjt.reason_explanation = explanation;
> +	rjt->rjt.vendor = vendor;
> +
> +	return sizeof(struct fcnvme_ls_rjt);
> +}
> +
> +/* Validation Error indexes into the string table below */
> +enum {
> +	VERR_NO_ERROR		= 0,
> +	VERR_CR_ASSOC_LEN	= 1,
> +	VERR_CR_ASSOC_RQST_LEN	= 2,
> +	VERR_CR_ASSOC_CMD	= 3,
> +	VERR_CR_ASSOC_CMD_LEN	= 4,
> +	VERR_ERSP_RATIO		= 5,
> +	VERR_ASSOC_ALLOC_FAIL	= 6,
> +	VERR_QUEUE_ALLOC_FAIL	= 7,
> +	VERR_CR_CONN_LEN	= 8,
> +	VERR_CR_CONN_RQST_LEN	= 9,
> +	VERR_ASSOC_ID		= 10,
> +	VERR_ASSOC_ID_LEN	= 11,
> +	VERR_NO_ASSOC		= 12,
> +	VERR_CONN_ID		= 13,
> +	VERR_CONN_ID_LEN	= 14,
> +	VERR_INVAL_CONN		= 15,
> +	VERR_CR_CONN_CMD	= 16,
> +	VERR_CR_CONN_CMD_LEN	= 17,
> +	VERR_DISCONN_LEN	= 18,
> +	VERR_DISCONN_RQST_LEN	= 19,
> +	VERR_DISCONN_CMD	= 20,
> +	VERR_DISCONN_CMD_LEN	= 21,
> +	VERR_DISCONN_SCOPE	= 22,
> +	VERR_RS_LEN		= 23,
> +	VERR_RS_RQST_LEN	= 24,
> +	VERR_RS_CMD		= 25,
> +	VERR_RS_CMD_LEN		= 26,
> +	VERR_RS_RCTL		= 27,
> +	VERR_RS_RO		= 28,
> +	VERR_LSACC		= 29,
> +	VERR_LSDESC_RQST	= 30,
> +	VERR_LSDESC_RQST_LEN	= 31,
> +	VERR_CR_ASSOC		= 32,
> +	VERR_CR_ASSOC_ACC_LEN	= 33,
> +	VERR_CR_CONN		= 34,
> +	VERR_CR_CONN_ACC_LEN	= 35,
> +	VERR_DISCONN		= 36,
> +	VERR_DISCONN_ACC_LEN	= 37,
> +};
> +
> +static char *validation_errors[] = {
> +	"OK",
> +	"Bad CR_ASSOC Length",
> +	"Bad CR_ASSOC Rqst Length",
> +	"Not CR_ASSOC Cmd",
> +	"Bad CR_ASSOC Cmd Length",
> +	"Bad Ersp Ratio",
> +	"Association Allocation Failed",
> +	"Queue Allocation Failed",
> +	"Bad CR_CONN Length",
> +	"Bad CR_CONN Rqst Length",
> +	"Not Association ID",
> +	"Bad Association ID Length",
> +	"No Association",
> +	"Not Connection ID",
> +	"Bad Connection ID Length",
> +	"Invalid Connection ID",
> +	"Not CR_CONN Cmd",
> +	"Bad CR_CONN Cmd Length",
> +	"Bad DISCONN Length",
> +	"Bad DISCONN Rqst Length",
> +	"Not DISCONN Cmd",
> +	"Bad DISCONN Cmd Length",
> +	"Bad Disconnect Scope",
> +	"Bad RS Length",
> +	"Bad RS Rqst Length",
> +	"Not RS Cmd",
> +	"Bad RS Cmd Length",
> +	"Bad RS R_CTL",
> +	"Bad RS Relative Offset",
> +	"Not LS_ACC",
> +	"Not LSDESC_RQST",
> +	"Bad LSDESC_RQST Length",
> +	"Not CR_ASSOC Rqst",
> +	"Bad CR_ASSOC ACC Length",
> +	"Not CR_CONN Rqst",
> +	"Bad CR_CONN ACC Length",
> +	"Not Disconnect Rqst",
> +	"Bad Disconnect ACC Length",
> +};
> +
> +#endif /* _NVME_FC_TRANSPORT_H */
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index aac7869a70bb..1f3118a3b0a3 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -14,6 +14,7 @@
>   #include "nvmet.h"
>   #include <linux/nvme-fc-driver.h>
>   #include <linux/nvme-fc.h>
> +#include "../host/fc.h"
>   
>   
>   /* *************************** Data Structures/Defines ****************** */
> @@ -1258,102 +1259,6 @@ EXPORT_SYMBOL_GPL(nvmet_fc_unregister_targetport);
>   
>   
>   static void
> -nvmet_fc_format_rsp_hdr(void *buf, u8 ls_cmd, __be32 desc_len, u8 rqst_ls_cmd)
> -{
> -	struct fcnvme_ls_acc_hdr *acc = buf;
> -
> -	acc->w0.ls_cmd = ls_cmd;
> -	acc->desc_list_len = desc_len;
> -	acc->rqst.desc_tag = cpu_to_be32(FCNVME_LSDESC_RQST);
> -	acc->rqst.desc_len =
> -			fcnvme_lsdesc_len(sizeof(struct fcnvme_lsdesc_rqst));
> -	acc->rqst.w0.ls_cmd = rqst_ls_cmd;
> -}
> -
> -static int
> -nvmet_fc_format_rjt(void *buf, u16 buflen, u8 ls_cmd,
> -			u8 reason, u8 explanation, u8 vendor)
> -{
> -	struct fcnvme_ls_rjt *rjt = buf;
> -
> -	nvmet_fc_format_rsp_hdr(buf, FCNVME_LSDESC_RQST,
> -			fcnvme_lsdesc_len(sizeof(struct fcnvme_ls_rjt)),
> -			ls_cmd);
> -	rjt->rjt.desc_tag = cpu_to_be32(FCNVME_LSDESC_RJT);
> -	rjt->rjt.desc_len = fcnvme_lsdesc_len(sizeof(struct fcnvme_lsdesc_rjt));
> -	rjt->rjt.reason_code = reason;
> -	rjt->rjt.reason_explanation = explanation;
> -	rjt->rjt.vendor = vendor;
> -
> -	return sizeof(struct fcnvme_ls_rjt);
> -}
> -
> -/* Validation Error indexes into the string table below */
> -enum {
> -	VERR_NO_ERROR		= 0,
> -	VERR_CR_ASSOC_LEN	= 1,
> -	VERR_CR_ASSOC_RQST_LEN	= 2,
> -	VERR_CR_ASSOC_CMD	= 3,
> -	VERR_CR_ASSOC_CMD_LEN	= 4,
> -	VERR_ERSP_RATIO		= 5,
> -	VERR_ASSOC_ALLOC_FAIL	= 6,
> -	VERR_QUEUE_ALLOC_FAIL	= 7,
> -	VERR_CR_CONN_LEN	= 8,
> -	VERR_CR_CONN_RQST_LEN	= 9,
> -	VERR_ASSOC_ID		= 10,
> -	VERR_ASSOC_ID_LEN	= 11,
> -	VERR_NO_ASSOC		= 12,
> -	VERR_CONN_ID		= 13,
> -	VERR_CONN_ID_LEN	= 14,
> -	VERR_NO_CONN		= 15,
> -	VERR_CR_CONN_CMD	= 16,
> -	VERR_CR_CONN_CMD_LEN	= 17,
> -	VERR_DISCONN_LEN	= 18,
> -	VERR_DISCONN_RQST_LEN	= 19,
> -	VERR_DISCONN_CMD	= 20,
> -	VERR_DISCONN_CMD_LEN	= 21,
> -	VERR_DISCONN_SCOPE	= 22,
> -	VERR_RS_LEN		= 23,
> -	VERR_RS_RQST_LEN	= 24,
> -	VERR_RS_CMD		= 25,
> -	VERR_RS_CMD_LEN		= 26,
> -	VERR_RS_RCTL		= 27,
> -	VERR_RS_RO		= 28,
> -};
> -
> -static char *validation_errors[] = {
> -	"OK",
> -	"Bad CR_ASSOC Length",
> -	"Bad CR_ASSOC Rqst Length",
> -	"Not CR_ASSOC Cmd",
> -	"Bad CR_ASSOC Cmd Length",
> -	"Bad Ersp Ratio",
> -	"Association Allocation Failed",
> -	"Queue Allocation Failed",
> -	"Bad CR_CONN Length",
> -	"Bad CR_CONN Rqst Length",
> -	"Not Association ID",
> -	"Bad Association ID Length",
> -	"No Association",
> -	"Not Connection ID",
> -	"Bad Connection ID Length",
> -	"No Connection",
> -	"Not CR_CONN Cmd",
> -	"Bad CR_CONN Cmd Length",
> -	"Bad DISCONN Length",
> -	"Bad DISCONN Rqst Length",
> -	"Not DISCONN Cmd",
> -	"Bad DISCONN Cmd Length",
> -	"Bad Disconnect Scope",
> -	"Bad RS Length",
> -	"Bad RS Rqst Length",
> -	"Not RS Cmd",
> -	"Bad RS Cmd Length",
> -	"Bad RS R_CTL",
> -	"Bad RS Relative Offset",
> -};
> -
> -static void
>   nvmet_fc_ls_create_association(struct nvmet_fc_tgtport *tgtport,
>   			struct nvmet_fc_ls_iod *iod)
>   {
> @@ -1407,7 +1312,7 @@ nvmet_fc_ls_create_association(struct nvmet_fc_tgtport *tgtport,
>   		dev_err(tgtport->dev,
>   			"Create Association LS failed: %s\n",
>   			validation_errors[ret]);
> -		iod->lsrsp->rsplen = nvmet_fc_format_rjt(acc,
> +		iod->lsrsp->rsplen = nvme_fc_format_rjt(acc,
>   				NVME_FC_MAX_LS_BUFFER_SIZE, rqst->w0.ls_cmd,
>   				FCNVME_RJT_RC_LOGIC,
>   				FCNVME_RJT_EXP_NONE, 0);
> @@ -1422,7 +1327,7 @@ nvmet_fc_ls_create_association(struct nvmet_fc_tgtport *tgtport,
>   
>   	iod->lsrsp->rsplen = sizeof(*acc);
>   
> -	nvmet_fc_format_rsp_hdr(acc, FCNVME_LS_ACC,
> +	nvme_fc_format_rsp_hdr(acc, FCNVME_LS_ACC,
>   			fcnvme_lsdesc_len(
>   				sizeof(struct fcnvme_ls_cr_assoc_acc)),
>   			FCNVME_LS_CREATE_ASSOCIATION);
> @@ -1498,7 +1403,7 @@ nvmet_fc_ls_create_connection(struct nvmet_fc_tgtport *tgtport,
>   		dev_err(tgtport->dev,
>   			"Create Connection LS failed: %s\n",
>   			validation_errors[ret]);
> -		iod->lsrsp->rsplen = nvmet_fc_format_rjt(acc,
> +		iod->lsrsp->rsplen = nvme_fc_format_rjt(acc,
>   				NVME_FC_MAX_LS_BUFFER_SIZE, rqst->w0.ls_cmd,
>   				(ret == VERR_NO_ASSOC) ?
>   					FCNVME_RJT_RC_INV_ASSOC :
> @@ -1515,7 +1420,7 @@ nvmet_fc_ls_create_connection(struct nvmet_fc_tgtport *tgtport,
>   
>   	iod->lsrsp->rsplen = sizeof(*acc);
>   
> -	nvmet_fc_format_rsp_hdr(acc, FCNVME_LS_ACC,
> +	nvme_fc_format_rsp_hdr(acc, FCNVME_LS_ACC,
>   			fcnvme_lsdesc_len(sizeof(struct fcnvme_ls_cr_conn_acc)),
>   			FCNVME_LS_CREATE_CONNECTION);
>   	acc->connectid.desc_tag = cpu_to_be32(FCNVME_LSDESC_CONN_ID);
> @@ -1578,13 +1483,11 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
>   		dev_err(tgtport->dev,
>   			"Disconnect LS failed: %s\n",
>   			validation_errors[ret]);
> -		iod->lsrsp->rsplen = nvmet_fc_format_rjt(acc,
> +		iod->lsrsp->rsplen = nvme_fc_format_rjt(acc,
>   				NVME_FC_MAX_LS_BUFFER_SIZE, rqst->w0.ls_cmd,
>   				(ret == VERR_NO_ASSOC) ?
>   					FCNVME_RJT_RC_INV_ASSOC :
> -					(ret == VERR_NO_CONN) ?
> -						FCNVME_RJT_RC_INV_CONN :
> -						FCNVME_RJT_RC_LOGIC,
> +					FCNVME_RJT_RC_LOGIC,
>   				FCNVME_RJT_EXP_NONE, 0);
>   		return;
>   	}
> @@ -1593,7 +1496,7 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
>   
>   	iod->lsrsp->rsplen = sizeof(*acc);
>   
> -	nvmet_fc_format_rsp_hdr(acc, FCNVME_LS_ACC,
> +	nvme_fc_format_rsp_hdr(acc, FCNVME_LS_ACC,
>   			fcnvme_lsdesc_len(
>   				sizeof(struct fcnvme_ls_disconnect_assoc_acc)),
>   			FCNVME_LS_DISCONNECT_ASSOC);
> @@ -1676,7 +1579,7 @@ nvmet_fc_handle_ls_rqst(struct nvmet_fc_tgtport *tgtport,
>   		nvmet_fc_ls_disconnect(tgtport, iod);
>   		break;
>   	default:
> -		iod->lsrsp->rsplen = nvmet_fc_format_rjt(iod->rspbuf,
> +		iod->lsrsp->rsplen = nvme_fc_format_rjt(iod->rspbuf,
>   				NVME_FC_MAX_LS_BUFFER_SIZE, w0->ls_cmd,
>   				FCNVME_RJT_RC_INVAL, FCNVME_RJT_EXP_NONE, 0);
>   	}
> 

Makes sense.

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
