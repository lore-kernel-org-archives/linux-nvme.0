Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BC6C4828D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 08:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uWW6TQnU5riHI2KSut7hh/ocnGVTMrOpm9JzVIcsdq4=; b=Us3VQ95z/NJXvpBfuE35SKN+K7
	gJeeYLedO7i4QRcBNFhu/mBRaRtGsZdH3131oHd4vu8lAtIcG2P5Lrc8kcVaZpAHzOKXXi35m1NS9
	Sy+v3bw/Hpa+7HJc3C+R0cuDqKsSrgE3G6QJIWqyK7syM3UTNxurLlIU80Uwq1Wb3e/cM8Y5Nnjy5
	NPP+NSVSf0uEPwdB9VAaO0zOjSJfQ7+gdrpij7MgC9oHtsHE7ZoEZspeg8kPOPvwSzjsA5zXbQsoQ
	VjmOOcyKM+N2R06H8D0/phvW69R9ax9ftQHFIyqmkESJP5n7+r1tIodKPQrBlN1/z1rz9JKzFpkub
	ceI48lNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXdXK-0000000A4d7-2pTE;
	Wed, 07 Feb 2024 08:44:06 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXdXH-0000000A4bW-0vml
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 08:44:04 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4178YoN4008757;
	Wed, 7 Feb 2024 08:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=uWW6TQnU5riHI2KSut7hh/ocnGVTMrOpm9JzVIcsdq4=;
 b=Fa8HZjmMk+sHCqcZi5G3oQFRPuec7sjfHtF2wrgA+AOky6MH2zAcRWw4luEE+SasS/mb
 prnoIYkqZ86GkCCvV2qGZ/6aYpSYKUAZVP0PniHZdJ8jKvirzr1r/aF9exac1+bbpTSS
 KCPp341wVSkBUcKbwIVbrORDZ9FXVYiFBEsSJ9g1YUTZwaj1uuddbCiOYj+96wdOFy4K
 b4aiUj1GZhpR6FDqUveriE/7ptad6pZ/UBNiwHrH6pjpID/ETnl/S8Ht8lyzk7/Jmb3i
 BCoBlebDa2PyYt9SycTVTUZfRppLSdgZNfSitl6oAw+/KE5Iz5P1kBy9WaZS3Z1hOGyH wg== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w45wm16h0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 08:43:55 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4177Cu28014765;
	Wed, 7 Feb 2024 08:43:55 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w20tnvmrm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 08:43:55 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4178hsri35520868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Feb 2024 08:43:54 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FBC95805C;
	Wed,  7 Feb 2024 08:43:54 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 580F95805A;
	Wed,  7 Feb 2024 08:43:52 +0000 (GMT)
Received: from [9.43.10.191] (unknown [9.43.10.191])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Feb 2024 08:43:52 +0000 (GMT)
Message-ID: <d7fd051e-f81d-4ac9-8ffa-74829698c813@linux.vnet.ibm.com>
Date: Wed, 7 Feb 2024 14:13:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: move passthrough logging attribute to head
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de,
        sagi@grimberg.me
Cc: Keith Busch <kbusch@kernel.org>, Alan Adamson <alan.adamson@oracle.com>
References: <20240206175040.553999-1-kbusch@meta.com>
From: Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
In-Reply-To: <20240206175040.553999-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: leCxJJEOZiwgx_LnExKTClpUkWkqgZRa
X-Proofpoint-GUID: leCxJJEOZiwgx_LnExKTClpUkWkqgZRa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402070064
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_004403_515674_84AB2DFD 
X-CRM114-Status: GOOD (  27.87  )
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

Thanks for the Patch. I have tested the patch and the issue is fixed 
with the patch.

Tested-by: Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>

On 2/6/24 23:20, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
>
> The namespace does not have attributes, but the head does. Move the new
> attribute to that structure instead of dereferncing the wrong type.
>
> And while we're here, fix the reverse-tree coding style.
>
> Fixes: 9f079dda14339e ("nvme: allow passthru cmd error logging")
> Reported-by: Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
> Cc: Alan Adamson <alan.adamson@oracle.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/host/core.c  |  3 +--
>   drivers/nvme/host/nvme.h  |  2 +-
>   drivers/nvme/host/sysfs.c | 30 +++++++++++++++---------------
>   3 files changed, 17 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 75927e8579857..786bebcfa4f77 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -713,7 +713,7 @@ void nvme_init_request(struct request *req, struct nvme_command *cmd)
>   	if (req->q->queuedata) {
>   		struct nvme_ns *ns = req->q->disk->private_data;
>   
> -		logging_enabled = ns->passthru_err_log_enabled;
> +		logging_enabled = ns->head->passthru_err_log_enabled;
>   		req->timeout = NVME_IO_TIMEOUT;
>   	} else { /* no queuedata implies admin queue */
>   		logging_enabled = nr->ctrl->passthru_err_log_enabled;
> @@ -3700,7 +3700,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>   
>   	ns->disk = disk;
>   	ns->queue = disk->queue;
> -	ns->passthru_err_log_enabled = false;
>   
>   	if (ctrl->opts && ctrl->opts->data_digest)
>   		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, ns->queue);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 3897334e3950d..7b87763e2f8a6 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -455,6 +455,7 @@ struct nvme_ns_head {
>   	struct list_head	entry;
>   	struct kref		ref;
>   	bool			shared;
> +	bool			passthru_err_log_enabled;
>   	int			instance;
>   	struct nvme_effects_log *effects;
>   	u64			nuse;
> @@ -523,7 +524,6 @@ struct nvme_ns {
>   	struct device		cdev_device;
>   
>   	struct nvme_fault_inject fault_inject;
> -	bool			passthru_err_log_enabled;
>   };
>   
>   /* NVMe ns supports metadata actions by the controller (generate/strip) */
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index d099218e494a8..f2832f70e7e0a 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -48,8 +48,8 @@ static ssize_t nvme_adm_passthru_err_log_enabled_store(struct device *dev,
>   		struct device_attribute *attr, const char *buf, size_t count)
>   {
>   	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> -	int err;
>   	bool passthru_err_log_enabled;
> +	int err;
>   
>   	err = kstrtobool(buf, &passthru_err_log_enabled);
>   	if (err)
> @@ -60,25 +60,34 @@ static ssize_t nvme_adm_passthru_err_log_enabled_store(struct device *dev,
>   	return count;
>   }
>   
> +static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
> +{
> +	struct gendisk *disk = dev_to_disk(dev);
> +
> +	if (nvme_disk_is_ns_head(disk))
> +		return disk->private_data;
> +	return nvme_get_ns_from_dev(dev)->head;
> +}
> +
>   static ssize_t nvme_io_passthru_err_log_enabled_show(struct device *dev,
>   		struct device_attribute *attr, char *buf)
>   {
> -	struct nvme_ns *n = dev_get_drvdata(dev);
> +	struct nvme_ns_head *head = dev_to_ns_head(dev);
>   
> -	return sysfs_emit(buf, n->passthru_err_log_enabled ? "on\n" : "off\n");
> +	return sysfs_emit(buf, head->passthru_err_log_enabled ? "on\n" : "off\n");
>   }
>   
>   static ssize_t nvme_io_passthru_err_log_enabled_store(struct device *dev,
>   		struct device_attribute *attr, const char *buf, size_t count)
>   {
> -	struct nvme_ns *ns = dev_get_drvdata(dev);
> -	int err;
> +	struct nvme_ns_head *head = dev_to_ns_head(dev);
>   	bool passthru_err_log_enabled;
> +	int err;
>   
>   	err = kstrtobool(buf, &passthru_err_log_enabled);
>   	if (err)
>   		return -EINVAL;
> -	ns->passthru_err_log_enabled = passthru_err_log_enabled;
> +	head->passthru_err_log_enabled = passthru_err_log_enabled;
>   
>   	return count;
>   }
> @@ -91,15 +100,6 @@ static struct device_attribute dev_attr_io_passthru_err_log_enabled = \
>   	__ATTR(passthru_err_log_enabled, S_IRUGO | S_IWUSR, \
>   	nvme_io_passthru_err_log_enabled_show, nvme_io_passthru_err_log_enabled_store);
>   
> -static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
> -{
> -	struct gendisk *disk = dev_to_disk(dev);
> -
> -	if (nvme_disk_is_ns_head(disk))
> -		return disk->private_data;
> -	return nvme_get_ns_from_dev(dev)->head;
> -}
> -
>   static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
>   		char *buf)
>   {

-- 
Regards,
Tasmiya Nalatwad
IBM Linux Technology Center


