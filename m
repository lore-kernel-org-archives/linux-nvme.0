Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58839C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Feb 2022 16:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FnXQKYtEeAcpLcpO9qk/QCkyOjMgi4O8VmqwVdYO+50=; b=lh4/wjWOAEh+dne76naGZaogJP
	rh04wT4pzOIHGfuHXV6zbHFosxQc4mgQmNbDf0HAjQRcSpdFOdwlu4bjnnlK8F2zpbf6uVC2Nqot4
	2qZchiSx4QUMshMEtx/K/uX41UQTiCSAjRyrNeYIONGT7/0yBB64lEwVdPvqxsK/ZzTwu+QyvYKMH
	W4qywn8F6TPQCMAxpA2nzoIoIH6q+cwrsTxtdetU/0/KeS+SQFBrFCizvqH6Gg7frnw/f6uGrd1dK
	EXgxFTkqaJBvZiNrmpIuwmSsiV0H2AVmKsJD2PZpYIXjXSNa0Srz798DR41Mi+KQVPeIERevbmMd0
	z0wb2Dqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nK0Hv-003XHG-8d; Tue, 15 Feb 2022 16:02:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJzxX-003NGE-EY
 for linux-nvme@lists.infradead.org; Tue, 15 Feb 2022 15:41:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644939700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FnXQKYtEeAcpLcpO9qk/QCkyOjMgi4O8VmqwVdYO+50=;
 b=D/kZOem9OFhLJHTmtvmn83IDjziNwjOyz5Kgixpz9GpsXLMyhniR9xtiY7vQvc9jS3DHtX
 ZVYXipDQddDzFUAxFSaD5v7bhmidtPHRtsqdnWhoyAT2UdcTf9W56qdEe92qD4ZGmP1Vof
 jdz0msZha1sWxmKEpjv33Y0AYVIl6k8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-I-DDe7z3MYW4sQ_mS_xO_w-1; Tue, 15 Feb 2022 10:41:37 -0500
X-MC-Unique: I-DDe7z3MYW4sQ_mS_xO_w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C611802924;
 Tue, 15 Feb 2022 15:41:35 +0000 (UTC)
Received: from [10.22.32.107] (unknown [10.22.32.107])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5AA587744F;
 Tue, 15 Feb 2022 15:41:34 +0000 (UTC)
Message-ID: <b2b4556c-5d6f-9dcd-5a45-9dd160e7b1c0@redhat.com>
Date: Tue, 15 Feb 2022 10:41:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv3 1/2] nvme: send uevent on connection up
To: Martin Belanger <nitram_67@hotmail.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hare@suse.de, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me, stuart_hayes@dell.com, charles_rose@dell.com,
 Martin Belanger <martin.belanger@dell.com>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20220208193346.22580-1-nitram_67@hotmail.com>
 <BL0PR13MB4291421C8BC621EEA559A88D9C2D9@BL0PR13MB4291.namprd13.prod.outlook.com>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <BL0PR13MB4291421C8BC621EEA559A88D9C2D9@BL0PR13MB4291.namprd13.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmeneghi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220215_074143_615008_989E1613 
X-CRM114-Status: GOOD (  21.75  )
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

On 2/8/22 14:33, Martin Belanger wrote:
> From: Martin Belanger <martin.belanger@dell.com>
> 
> When connectivity with a controller is lost, the driver will keep
> trying to reconnect once every 10 sec. When connection is restored,
> user-space apps need to be informed so that they can take proper
> action. For example, TP8010 introduces the DIM PDU, which is used to
> register with a discovery controller (DC). The DIM PDU is sent from
> user-space.  The DIM PDU must be sent every time a connection is
> established with a DC. Therefore, the kernel must tell user-space apps
> when connection is restored so that registration can happen.
> 
> The uevent sent is a "change" uevent with environmental data
> set to: "NVME_EVENT=connected".
> 
> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/core.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index dd18861f77c0..b5e452aa3c0e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4229,6 +4229,13 @@ static int nvme_class_uevent(struct device *dev, struct kobj_uevent_env *env)
>   	return ret;
>   }
>   
> +static void nvme_change_uevent(struct nvme_ctrl *ctrl, char *envdata)
> +{
> +	char *envp[2] = { envdata, NULL };
> +
> +	kobject_uevent_env(&ctrl->device->kobj, KOBJ_CHANGE, envp);
> +}
> +
>   static void nvme_aen_uevent(struct nvme_ctrl *ctrl)
>   {
>   	char *envp[2] = { NULL, NULL };
> @@ -4396,6 +4403,8 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
>   		nvme_queue_scan(ctrl);
>   		nvme_start_queues(ctrl);
>   	}
> +
> +	nvme_change_uevent(ctrl, "NVME_EVENT=connected");
>   }
>   EXPORT_SYMBOL_GPL(nvme_start_ctrl);
>   

Reviewed-by: John Meneghini <jmeneghi@redhat.com>


