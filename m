Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C6ED1CA0E
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 03:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=55NEy9DHeGDhSrsAwciZjYZ9pkn8zq6dUKZVxyN3tD0=; b=HELRUzTtw3/FtfoYNzl3enBMUf
	ugQAH8GZOS1MSByVzFAFXozkGcd2W3z79C+ApPA1NHdY/wZ4+mYMWoZ2dNV5RdaaF8OQ7/3D3POOK
	S3w22F6/ETXHVCOLgeEPhi6ENgWngEZZz5ONLUBElzObAVSrwvNUExK/FbR6HtfuLcTDyfmKHgZt6
	nTzOoYyh5+M1blZFfuoge2SJFqKbtBI8z46qLcLR3jg6Sck+0QZ61ot9neWaLDiCLMTENMC+WbbRh
	ATTIkIfJE6ZJ9zsCo6w1COXaA66mpB0aRs3R1UgSjrjogqV/H4/Z34CVEbq1GPIi6aFhy41gG/gsl
	k3VtcGaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t89oR-0000000FhtY-0sBh;
	Tue, 05 Nov 2024 03:00:59 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t89oK-0000000Fht7-0QjE
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 03:00:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730775647; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=55NEy9DHeGDhSrsAwciZjYZ9pkn8zq6dUKZVxyN3tD0=;
	b=ln6Q7Kt6xhoJM1z4uzVyEpFqQWYGGwVW1nyBjGuZKMsWG/WjInmUvLwgtvH/AhGTPG+r4rDRi0Q8rdhLsHZwBgZqULefQzuZdoU+TPOTkTNMW4v0PWVeJfvpo3JpyGwX7FB7nZU4uTibunRfPq6iZiJMHE1W1cxmcjfOPAEmgaE=
Received: from 30.178.81.152(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WIlHpxb_1730775643 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 05 Nov 2024 11:00:44 +0800
Message-ID: <45a15c19-cc26-4015-8f86-a258026acb01@linux.alibaba.com>
Date: Tue, 5 Nov 2024 11:00:41 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH 3/3 v2] nvmet: add rotational support
To: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>, kbusch@kernel.org,
 hch@lst.de, dlemoal@kernel.org, cassel@kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, wangyugui@e16-tech.com,
 martin.petersen@oracle.com, hare@suse.de
References: <20241010123951.1226105-1-m@bjorling.me>
 <20241010123951.1226105-4-m@bjorling.me>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20241010123951.1226105-4-m@bjorling.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_190052_319700_C0C2CD79 
X-CRM114-Status: GOOD (  14.71  )
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


在 2024/10/10 20:39, Matias Bjørling 写道:
> From: Keith Busch <kbusch@kernel.org>
>
> Rotational block devices can be detected in NVMe through the rotational
> attribute in the independent namespace identify data structure.
>
> Extend nvmet with support for the independent namespace identify data
> structure and expose the rotational support of the backend device.
>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/target/admin-cmd.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
>
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index f7e1156ac7ec..f08f1226c897 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -675,6 +675,35 @@ static void nvmet_execute_identify_ctrl_nvm(struct nvmet_req *req)
>   		   nvmet_zero_sgl(req, 0, sizeof(struct nvme_id_ctrl_nvm)));
>   }
>   
> +static void nvmet_execute_id_cs_indep(struct nvmet_req *req)
> +{
> +	struct nvme_id_ns_cs_indep *id;
> +	u16 status;
> +
> +	status = nvmet_req_find_ns(req);
> +	if (status)
> +		goto out;
> +
> +	id = kzalloc(sizeof(*id), GFP_KERNEL);
> +	if (!id) {
> +		status = NVME_SC_INTERNAL;
> +		goto out;
> +	}
> +
> +	id->nstat = NVME_NSTAT_NRDY;
> +	id->anagrpid = req->ns->anagrpid;

Hi Matias,

Here should use "cpu_to_le32(req->ns->anagrpid)",

And I send 3 patches to support ns's respective vwc which depends on 
your patch,

you can search "[PATCH RFC 0/3] set nvme ns's vwc respectively" to find 
my patches,

waiting for your patch applied, and I will work continue.

Best Regards,

Guixin Liu

> +	id->nmic = NVME_NS_NMIC_SHARED;
> +	if (req->ns->readonly)
> +		id->nsattr |= NVME_NS_ATTR_RO;
> +	if (req->ns->bdev && !bdev_nonrot(req->ns->bdev))
> +		id->nsfeat |= NVME_NS_ROTATIONAL;
> +
> +	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
> +	kfree(id);
> +out:
> +	nvmet_req_complete(req, status);
> +}
> +
>   static void nvmet_execute_identify(struct nvmet_req *req)
>   {
>   	if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
> @@ -719,6 +748,9 @@ static void nvmet_execute_identify(struct nvmet_req *req)
>   			break;
>   		}
>   		break;
> +	case NVME_ID_CNS_NS_CS_INDEP:
> +		nvmet_execute_id_cs_indep(req);
> +		return;
>   	}
>   
>   	pr_debug("unhandled identify cns %d on qid %d\n",

