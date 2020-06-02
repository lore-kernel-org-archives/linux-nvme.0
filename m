Return-Path: <SRS0=vW9m=7P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8D2C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2020 15:04:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DB802074B
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2020 15:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kCl9MJrD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oTkzTW4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB802074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PvZGkAPPzk631Y8Wd0RR4gSyA3XD8/asrKNEQ5+v8fY=; b=kCl9MJrDcc1ArRfH9pCFSrxV/
	XymsvyLReIXaaqZmvxhzuiJ3ig8Co9JoJWRc5Fck1E7uqTsm68JbmjQtj3rr5ZLI8qG61z64cGTxR
	IoMoXfHa5+JGKy5vqgOA0lB4MxGTpnd+smL/4ZkMIhPy4kCBv822miz4hqUUombOyRipkKQb3FCWL
	VnbdO3MVn/iWqybQVez1NVVFa5qs4Avio7K88x/3pTamA/GEumGicW2AD6xGUDogOxmuW6N6UDM6B
	rMbY2WRBbdhJdTe2i5gsmENFVzBMvn3lrOWEetieUvlVDW7raUVTaqEa6hPLdr/RsfrPK1D1A3hIW
	KUkV8cX8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jg8SX-00012A-7X; Tue, 02 Jun 2020 15:04:09 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jg8SV-00011k-52
 for linux-nvme@lists.infradead.org; Tue, 02 Jun 2020 15:04:08 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052F1tqI041102;
 Tue, 2 Jun 2020 15:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ac6gq583bolI1N4OA5meiYFkhRzYz0ke6IRmXTRj+mI=;
 b=oTkzTW4yM5kndcbjRoqibTVJ8teN+qpIYS6oC5A7A2SyWdiB72PGDXpoWBp1LfFGcNFn
 mWvCCPSMprF3dtqnDyg3jMHH/0CRACo8EgurlMCiiIC8o3ztChXfEGklf5wGSMn6ocYW
 s02Xv1iKs1n9I6Xd6utulgWp4p8VL9zLeWn4xQVcphr3+ceyGLLTFWgrl4Wp+VEtSvvo
 rLoJVBjd2f5dnxQkzjaRSxN8a1vBlkgKlCZTztaGjD1wLRKiXLaxgyWQ3rN11beFZ5kA
 4qDhHVxqav4Tsr9pZYKXmrCDXIDnKyEv661uTS6pDtYrZVAEgRGYefbW/PG3Z27IEM0G 7g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 31bewqvkpn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 02 Jun 2020 15:04:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052F3wfm141179;
 Tue, 2 Jun 2020 15:03:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 31c25p69qw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 02 Jun 2020 15:03:59 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 052F3ula008206;
 Tue, 2 Jun 2020 15:03:56 GMT
Received: from [10.154.114.83] (/10.154.114.83)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 02 Jun 2020 08:03:55 -0700
Subject: Re: [PATCH 5/5] nvmet: introduce flags member in nvmet_fabrics_ops
To: Max Gurtovoy <maxg@mellanox.com>, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 james.smart@broadcom.com, chaitanya.kulkarni@wdc.com
References: <20200602131546.51903-1-maxg@mellanox.com>
 <20200602131546.51903-6-maxg@mellanox.com>
From: Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle Corporation
Message-ID: <7de4e3e1-9826-a61b-4713-6255e6e0f7a9@oracle.com>
Date: Tue, 2 Jun 2020 10:03:54 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200602131546.51903-6-maxg@mellanox.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006020108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=0 impostorscore=0 cotscore=-2147483648
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006020108
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200602_080407_278296_94E6E07D 
X-CRM114-Status: GOOD (  22.51  )
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
> Replace has_keyed_sgls and metadata_support booleans with a flags member
> that will be used for adding more features in the future.
> 
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> Reviewed-by: Israel Rukshin <israelr@mellanox.com>
> ---
>   drivers/nvme/target/admin-cmd.c | 2 +-
>   drivers/nvme/target/core.c      | 2 +-
>   drivers/nvme/target/discovery.c | 2 +-
>   drivers/nvme/target/nvmet.h     | 5 +++--
>   drivers/nvme/target/rdma.c      | 3 +--
>   5 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 1db8c04..95bb3bc 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -427,7 +427,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
>   	id->awupf = 0;
>   
>   	id->sgls = cpu_to_le32(1 << 0);	/* we always support SGLs */
> -	if (ctrl->ops->has_keyed_sgls)
> +	if (ctrl->ops->flags & NVMF_KEYED_SGLS)
>   		id->sgls |= cpu_to_le32(1 << 2);
>   	if (req->port->inline_data_size)
>   		id->sgls |= cpu_to_le32(1 << 20);
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 6392bcd..86882d4 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -322,7 +322,7 @@ int nvmet_enable_port(struct nvmet_port *port)
>   	 * If the user requested PI support and the transport isn't pi capable,
>   	 * don't enable the port.
>   	 */
> -	if (port->pi_enable && !ops->metadata_support) {
> +	if (port->pi_enable && !(ops->flags & NVMF_METADATA_SUPPORTED)) {
>   		pr_err("T10-PI is not supported by transport type %d\n",
>   		       port->disc_addr.trtype);
>   		ret = -EINVAL;
> diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
> index 40cf0b6..f40c05c 100644
> --- a/drivers/nvme/target/discovery.c
> +++ b/drivers/nvme/target/discovery.c
> @@ -277,7 +277,7 @@ static void nvmet_execute_disc_identify(struct nvmet_req *req)
>   	id->maxcmd = cpu_to_le16(NVMET_MAX_CMD);
>   
>   	id->sgls = cpu_to_le32(1 << 0);	/* we always support SGLs */
> -	if (ctrl->ops->has_keyed_sgls)
> +	if (ctrl->ops->flags & NVMF_KEYED_SGLS)
>   		id->sgls |= cpu_to_le32(1 << 2);
>   	if (req->port->inline_data_size)
>   		id->sgls |= cpu_to_le32(1 << 20);
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index ce57d5f..daf3838 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -287,8 +287,9 @@ struct nvmet_fabrics_ops {
>   	struct module *owner;
>   	unsigned int type;
>   	unsigned int msdbd;
> -	bool has_keyed_sgls : 1;
> -	bool metadata_support : 1;
> +	unsigned int flags;
> +#define NVMF_KEYED_SGLS			(1 << 0)
> +#define NVMF_METADATA_SUPPORTED		(1 << 1)
>   	void (*queue_response)(struct nvmet_req *req);
>   	int (*add_port)(struct nvmet_port *port);
>   	void (*remove_port)(struct nvmet_port *port);
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index d514178..4c89f58 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -1968,8 +1968,7 @@ static u8 nvmet_rdma_get_mdts(const struct nvmet_ctrl *ctrl)
>   	.owner			= THIS_MODULE,
>   	.type			= NVMF_TRTYPE_RDMA,
>   	.msdbd			= 1,
> -	.has_keyed_sgls		= 1,
> -	.metadata_support	= 1,
> +	.flags			= NVMF_KEYED_SGLS | NVMF_METADATA_SUPPORTED,
>   	.add_port		= nvmet_rdma_add_port,
>   	.remove_port		= nvmet_rdma_remove_port,
>   	.queue_response		= nvmet_rdma_queue_response,
> 
Looks Good.

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

-- 
Himanshu Madhani                     Oracle Linux Engineering

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
