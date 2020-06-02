Return-Path: <SRS0=vW9m=7P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34317C433DF
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2020 14:41:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F18F12068D
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2020 14:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i8OLY6Iu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aMWc7kby"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F18F12068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pliKto7p+uGjY+s/s3A3qKW98+7grSCuTjwlBdXo4bg=; b=i8OLY6IuXws3hfN68eWhAhlxD
	yh4O/y5jDRjjFWbkH4+U7SLqMTazqHbxDLhicRRuuiI3/jPbjFWxx1KeehSqR4+mO5D2jPw8d4Sx0
	8jr9FVAOsOQrHl0Y6uF7l1L3WznJrU7txv1oWhMxIeDJu16mQaFYEcA4U18ErP8sdNUIy/AjqOOT+
	UVJyadCxPCdfrSQnUzGxldDhQ5mgQ3CnO+mY+lk4R3NfjKmtfcB42m+9KL4MN+CHc1LRiL9hUsTXf
	lVgfN/l/psvf6obL1TzgSQTQkIax9Rs0yA+OHStCxl6b+ZiwyUm3fwyjy5NxU3D5hSH4H6aSNe//q
	iaCEJMqMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jg86C-0003iu-H9; Tue, 02 Jun 2020 14:41:04 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jg869-0003iO-HN
 for linux-nvme@lists.infradead.org; Tue, 02 Jun 2020 14:41:03 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052EcC2a005492;
 Tue, 2 Jun 2020 14:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ESGx9IfdHV0040rr60WFjALjTs8hwBDhZg764l7BvQk=;
 b=aMWc7kbyB6uHfgAsSFtkls7JFnDcswExeew9hR+4SMETj7FSNojv5jbX1rq8znHBtBu/
 Y218UHs3X7lkcsv/y5kjL1jxVMJE/MBWVsSodAjVKev6yVtQBoksYOQKtQzGX5Q8QaCz
 z5xNwvdHLw6XLwaAu16OYyfx57PHvPXsgokn6YNdxZd7UzQweO57yHXhN+bPNVMlr7LE
 hRZh1pVN4HqNGdFHQbkm+qtL+zmu0FQEdBIHkp+hz4f/mjfOUFa57YElSDv6j0MmkTCg
 SuMAytClGv4kp1hiTwp+/d6FMq3RN52BMaDf1dV89NpgEIDd3OyWXXmIAwe/PT5ErNiP FA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 31bewqvfns-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 02 Jun 2020 14:40:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052EY0BB193631;
 Tue, 2 Jun 2020 14:40:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 31dju1k14e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 02 Jun 2020 14:40:42 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 052Eee7t005362;
 Tue, 2 Jun 2020 14:40:40 GMT
Received: from [10.154.114.83] (/10.154.114.83)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 02 Jun 2020 07:40:40 -0700
Subject: Re: [PATCH 1/5] nvme: introduce nvme-types header file
To: Max Gurtovoy <maxg@mellanox.com>, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 james.smart@broadcom.com, chaitanya.kulkarni@wdc.com
References: <20200602131546.51903-1-maxg@mellanox.com>
 <20200602131546.51903-2-maxg@mellanox.com>
From: Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle Corporation
Message-ID: <2583ccc6-77e8-2199-9dda-eeaaa40082a5@oracle.com>
Date: Tue, 2 Jun 2020 09:40:39 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200602131546.51903-2-maxg@mellanox.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006020104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=0 impostorscore=0 cotscore=-2147483648
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006020104
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200602_074101_714480_F3F361BD 
X-CRM114-Status: GOOD (  24.63  )
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
> Centralize the mapping between name and type to a common header file
> instead of duplicating logic in both NVMe host and target drivers.
> 
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> Reviewed-by: Israel Rukshin <israelr@mellanox.com>
> ---
>   drivers/nvme/target/configfs.c | 92 ++++++++--------------------------------
>   drivers/nvme/target/nvmet.h    |  1 +
>   include/linux/nvme-types.h     | 95 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 113 insertions(+), 75 deletions(-)
>   create mode 100644 include/linux/nvme-types.h
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 419e0d4..daeb17e 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -20,27 +20,6 @@
>   static LIST_HEAD(nvmet_ports_list);
>   struct list_head *nvmet_ports = &nvmet_ports_list;
>   
> -struct nvmet_type_name_map {
> -	u8		type;
> -	const char	*name;
> -};
> -
> -static struct nvmet_type_name_map nvmet_transport[] = {
> -	{ NVMF_TRTYPE_RDMA,	"rdma" },
> -	{ NVMF_TRTYPE_FC,	"fc" },
> -	{ NVMF_TRTYPE_TCP,	"tcp" },
> -	{ NVMF_TRTYPE_LOOP,	"loop" },
> -};
> -
> -static const struct nvmet_type_name_map nvmet_addr_family[] = {
> -	{ NVMF_ADDR_FAMILY_PCI,		"pcie" },
> -	{ NVMF_ADDR_FAMILY_IP4,		"ipv4" },
> -	{ NVMF_ADDR_FAMILY_IP6,		"ipv6" },
> -	{ NVMF_ADDR_FAMILY_IB,		"ib" },
> -	{ NVMF_ADDR_FAMILY_FC,		"fc" },
> -	{ NVMF_ADDR_FAMILY_LOOP,	"loop" },
> -};
> -
>   static bool nvmet_is_port_enabled(struct nvmet_port *p, const char *caller)
>   {
>   	if (p->enabled)
> @@ -56,14 +35,8 @@ static bool nvmet_is_port_enabled(struct nvmet_port *p, const char *caller)
>   static ssize_t nvmet_addr_adrfam_show(struct config_item *item, char *page)
>   {
>   	u8 adrfam = to_nvmet_port(item)->disc_addr.adrfam;
> -	int i;
> -
> -	for (i = 1; i < ARRAY_SIZE(nvmet_addr_family); i++) {
> -		if (nvmet_addr_family[i].type == adrfam)
> -			return sprintf(page, "%s\n", nvmet_addr_family[i].name);
> -	}
>   
> -	return sprintf(page, "\n");
> +	return sprintf(page, "%s\n", nvme_adrfam_type_to_name(adrfam));
>   }
>   
>   static ssize_t nvmet_addr_adrfam_store(struct config_item *item,
> @@ -75,8 +48,8 @@ static ssize_t nvmet_addr_adrfam_store(struct config_item *item,
>   	if (nvmet_is_port_enabled(port, __func__))
>   		return -EACCES;
>   
> -	for (i = 1; i < ARRAY_SIZE(nvmet_addr_family); i++) {
> -		if (sysfs_streq(page, nvmet_addr_family[i].name))
> +	for (i = 1; i < ARRAY_SIZE(nvme_addr_family); i++) {
> +		if (sysfs_streq(page, nvme_addr_family[i].name))
>   			goto found;
>   	}
>   
> @@ -84,7 +57,7 @@ static ssize_t nvmet_addr_adrfam_store(struct config_item *item,
>   	return -EINVAL;
>   
>   found:
> -	port->disc_addr.adrfam = nvmet_addr_family[i].type;
> +	port->disc_addr.adrfam = nvme_addr_family[i].type;
>   	return count;
>   }
>   
> @@ -148,24 +121,12 @@ static ssize_t nvmet_addr_traddr_store(struct config_item *item,
>   
>   CONFIGFS_ATTR(nvmet_, addr_traddr);
>   
> -static const struct nvmet_type_name_map nvmet_addr_treq[] = {
> -	{ NVMF_TREQ_NOT_SPECIFIED,	"not specified" },
> -	{ NVMF_TREQ_REQUIRED,		"required" },
> -	{ NVMF_TREQ_NOT_REQUIRED,	"not required" },
> -};
> -
>   static ssize_t nvmet_addr_treq_show(struct config_item *item, char *page)
>   {
>   	u8 treq = to_nvmet_port(item)->disc_addr.treq &
>   		NVME_TREQ_SECURE_CHANNEL_MASK;
> -	int i;
> -
> -	for (i = 0; i < ARRAY_SIZE(nvmet_addr_treq); i++) {
> -		if (treq == nvmet_addr_treq[i].type)
> -			return sprintf(page, "%s\n", nvmet_addr_treq[i].name);
> -	}
>   
> -	return sprintf(page, "\n");
> +	return sprintf(page, "%s\n", nvme_treq_type_to_name(treq));
>   }
>   
>   static ssize_t nvmet_addr_treq_store(struct config_item *item,
> @@ -178,8 +139,8 @@ static ssize_t nvmet_addr_treq_store(struct config_item *item,
>   	if (nvmet_is_port_enabled(port, __func__))
>   		return -EACCES;
>   
> -	for (i = 0; i < ARRAY_SIZE(nvmet_addr_treq); i++) {
> -		if (sysfs_streq(page, nvmet_addr_treq[i].name))
> +	for (i = 0; i < ARRAY_SIZE(nvme_addr_treq); i++) {
> +		if (sysfs_streq(page, nvme_addr_treq[i].name))
>   			goto found;
>   	}
>   
> @@ -187,7 +148,7 @@ static ssize_t nvmet_addr_treq_store(struct config_item *item,
>   	return -EINVAL;
>   
>   found:
> -	treq |= nvmet_addr_treq[i].type;
> +	treq |= nvme_addr_treq[i].type;
>   	port->disc_addr.treq = treq;
>   	return count;
>   }
> @@ -282,14 +243,9 @@ static ssize_t nvmet_addr_trtype_show(struct config_item *item,
>   		char *page)
>   {
>   	struct nvmet_port *port = to_nvmet_port(item);
> -	int i;
> -
> -	for (i = 0; i < ARRAY_SIZE(nvmet_transport); i++) {
> -		if (port->disc_addr.trtype == nvmet_transport[i].type)
> -			return sprintf(page, "%s\n", nvmet_transport[i].name);
> -	}
>   
> -	return sprintf(page, "\n");
> +	return sprintf(page, "%s\n",
> +		       nvme_trtype_to_name(port->disc_addr.trtype));
>   }
>   
>   static void nvmet_port_init_tsas_rdma(struct nvmet_port *port)
> @@ -308,8 +264,8 @@ static ssize_t nvmet_addr_trtype_store(struct config_item *item,
>   	if (nvmet_is_port_enabled(port, __func__))
>   		return -EACCES;
>   
> -	for (i = 0; i < ARRAY_SIZE(nvmet_transport); i++) {
> -		if (sysfs_streq(page, nvmet_transport[i].name))
> +	for (i = 0; i < ARRAY_SIZE(nvme_transport); i++) {
> +		if (sysfs_streq(page, nvme_transport[i].name))
>   			goto found;
>   	}
>   
> @@ -318,7 +274,7 @@ static ssize_t nvmet_addr_trtype_store(struct config_item *item,
>   
>   found:
>   	memset(&port->disc_addr.tsas, 0, NVMF_TSAS_SIZE);
> -	port->disc_addr.trtype = nvmet_transport[i].type;
> +	port->disc_addr.trtype = nvme_transport[i].type;
>   	if (port->disc_addr.trtype == NVMF_TRTYPE_RDMA)
>   		nvmet_port_init_tsas_rdma(port);
>   	return count;
> @@ -1227,27 +1183,13 @@ static struct config_group *nvmet_referral_make(
>   	.ct_group_ops	= &nvmet_referral_group_ops,
>   };
>   
> -static struct nvmet_type_name_map nvmet_ana_state[] = {
> -	{ NVME_ANA_OPTIMIZED,		"optimized" },
> -	{ NVME_ANA_NONOPTIMIZED,	"non-optimized" },
> -	{ NVME_ANA_INACCESSIBLE,	"inaccessible" },
> -	{ NVME_ANA_PERSISTENT_LOSS,	"persistent-loss" },
> -	{ NVME_ANA_CHANGE,		"change" },
> -};
> -
>   static ssize_t nvmet_ana_group_ana_state_show(struct config_item *item,
>   		char *page)
>   {
>   	struct nvmet_ana_group *grp = to_ana_group(item);
>   	enum nvme_ana_state state = grp->port->ana_state[grp->grpid];
> -	int i;
> -
> -	for (i = 0; i < ARRAY_SIZE(nvmet_ana_state); i++) {
> -		if (state == nvmet_ana_state[i].type)
> -			return sprintf(page, "%s\n", nvmet_ana_state[i].name);
> -	}
>   
> -	return sprintf(page, "\n");
> +	return sprintf(page, "%s\n", nvme_ana_type_to_name(state));
>   }
>   
>   static ssize_t nvmet_ana_group_ana_state_store(struct config_item *item,
> @@ -1257,8 +1199,8 @@ static ssize_t nvmet_ana_group_ana_state_store(struct config_item *item,
>   	enum nvme_ana_state *ana_state = grp->port->ana_state;
>   	int i;
>   
> -	for (i = 0; i < ARRAY_SIZE(nvmet_ana_state); i++) {
> -		if (sysfs_streq(page, nvmet_ana_state[i].name))
> +	for (i = 0; i < ARRAY_SIZE(nvme_ana_states); i++) {
> +		if (sysfs_streq(page, nvme_ana_states[i].name))
>   			goto found;
>   	}
>   
> @@ -1267,7 +1209,7 @@ static ssize_t nvmet_ana_group_ana_state_store(struct config_item *item,
>   
>   found:
>   	down_write(&nvmet_ana_sem);
> -	ana_state[grp->grpid] = (enum nvme_ana_state) nvmet_ana_state[i].type;
> +	ana_state[grp->grpid] = (enum nvme_ana_state) nvme_ana_states[i].type;
>   	nvmet_ana_chgcnt++;
>   	up_write(&nvmet_ana_sem);
>   	nvmet_port_send_ana_event(grp->port);
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 8096912..ce57d5f 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -15,6 +15,7 @@
>   #include <linux/mutex.h>
>   #include <linux/uuid.h>
>   #include <linux/nvme.h>
> +#include <linux/nvme-types.h>
>   #include <linux/configfs.h>
>   #include <linux/rcupdate.h>
>   #include <linux/blkdev.h>
> diff --git a/include/linux/nvme-types.h b/include/linux/nvme-types.h
> new file mode 100644
> index 0000000..38ed980
> --- /dev/null
> +++ b/include/linux/nvme-types.h
> @@ -0,0 +1,95 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2020 Mellanox Technologies. All rights reserved.
> + */
> +
> +#ifndef _LINUX_NVME_TYPES_H
> +#define _LINUX_NVME_TYPES_H
> +
> +#include <linux/kernel.h>
> +#include <linux/nvme.h>
> +
> +struct nvme_type_name_map {
> +	u8		type;
> +	const char	*name;
> +};
> +
> +static const struct nvme_type_name_map nvme_transport[] = {
> +	{ NVMF_TRTYPE_RDMA,	"rdma" },
> +	{ NVMF_TRTYPE_FC,	"fc" },
> +	{ NVMF_TRTYPE_TCP,	"tcp" },
> +	{ NVMF_TRTYPE_LOOP,	"loop" },
> +};
> +
> +static inline const char *nvme_trtype_to_name(u8 type)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(nvme_transport); i++) {
> +		if (type == nvme_transport[i].type)
> +			return nvme_transport[i].name;
> +	}
> +
> +	return "invalid";
> +}
> +
> +static const struct nvme_type_name_map nvme_addr_family[] = {
> +	{ NVMF_ADDR_FAMILY_PCI,		"pcie" },
> +	{ NVMF_ADDR_FAMILY_IP4,		"ipv4" },
> +	{ NVMF_ADDR_FAMILY_IP6,		"ipv6" },
> +	{ NVMF_ADDR_FAMILY_IB,		"ib" },
> +	{ NVMF_ADDR_FAMILY_FC,		"fc" },
> +	{ NVMF_ADDR_FAMILY_LOOP,	"loop" },
> +};
> +
> +static inline const char *nvme_adrfam_type_to_name(u8 type)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(nvme_addr_family); i++) {
> +		if (type == nvme_addr_family[i].type)
> +			return nvme_addr_family[i].name;
> +	}
> +
> +	return "invalid";
> +}
> +
> +static const struct nvme_type_name_map nvme_addr_treq[] = {
> +	{ NVMF_TREQ_NOT_SPECIFIED,	"not specified" },
> +	{ NVMF_TREQ_REQUIRED,		"required" },
> +	{ NVMF_TREQ_NOT_REQUIRED,	"not required" },
> +};
> +
> +static inline const char *nvme_treq_type_to_name(u8 type)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(nvme_addr_treq); i++) {
> +		if (type == nvme_addr_treq[i].type)
> +			return nvme_addr_treq[i].name;
> +	}
> +
> +	return "invalid";
> +}
> +
> +static const struct nvme_type_name_map nvme_ana_states[] = {
> +	{ NVME_ANA_OPTIMIZED,		"optimized" },
> +	{ NVME_ANA_NONOPTIMIZED,	"non-optimized" },
> +	{ NVME_ANA_INACCESSIBLE,	"inaccessible" },
> +	{ NVME_ANA_PERSISTENT_LOSS,	"persistent-loss" },
> +	{ NVME_ANA_CHANGE,		"change" },
> +};
> +
> +static inline const char *nvme_ana_type_to_name(u8 type)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(nvme_ana_states); i++) {
> +		if (type == nvme_ana_states[i].type)
> +			return nvme_ana_states[i].name;
> +	}
> +
> +	return "invalid";
> +}
> +
> +#endif /* _LINUX_NVME_TYPES_H */
> 
Looks Good.

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

-- 
Himanshu Madhani                     Oracle Linux Engineering

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
