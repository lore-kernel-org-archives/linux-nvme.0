Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BB4C7EE2A
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jun 2025 19:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JynrP5TGuxhjWxQiqEKOXeWc2e5BPWFMVYNl8GD1NSI=; b=JrO8ssKDfL590oIKh8fsZehJPJ
	kMjXseepZV7hBKWdgYC5v15IONhsYa4GX/EzbRtzAZ2siV/7Sj8LFejtv89wi7Z8smjzq41ACEeTB
	RqKwDwh5MAaeraFCCrYHSl/gCROC6lHiIpFVvRJ147jgPiO+BJZqopY0fyprxyY0rpKdJcuAUMFfR
	2jKtAiQTr5TpWedIkCKxeqSuXzzmducl3Ht3CDwaCJdzBmqiQHiunbDOwFWGbaoAyNZN43Nyjlcmn
	L01YnAy6ATROpH1ujd9z3K20eJjnKR33WDL3rAj1s+SD+3XFb/cM+wh4OSJiac1yqMtsSS7zBfPf7
	BNiCR9gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTn3G-00000003oxz-2kdu;
	Mon, 23 Jun 2025 19:41:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTjCM-00000003FtH-49sc
	for linux-nvme@lists.infradead.org;
	Mon, 23 Jun 2025 15:35:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750692905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JynrP5TGuxhjWxQiqEKOXeWc2e5BPWFMVYNl8GD1NSI=;
	b=WZRv/oZxsS2xYyeLwtN4RDihThDJlPLbiiaHJ6dX9SUm1M0t+9rNyqHDV1RwqLAaFqMFa0
	dcxC4DqIooDKdMkMY8Csh3ER13fSjye5qBxZDgGXK/nD84+AH1dXA5s15u7Es6/Papkp9r
	s/yK5xhXps8oKgPYssAyqbDn4eiDF+k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-orDf3zvkOOOoPf7Oj7N2gw-1; Mon,
 23 Jun 2025 11:33:25 -0400
X-MC-Unique: orDf3zvkOOOoPf7Oj7N2gw-1
X-Mimecast-MFC-AGG-ID: orDf3zvkOOOoPf7Oj7N2gw_1750692804
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2FFDA195608E;
	Mon, 23 Jun 2025 15:33:23 +0000 (UTC)
Received: from [10.22.90.20] (unknown [10.22.90.20])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 587C2195608D;
	Mon, 23 Jun 2025 15:33:20 +0000 (UTC)
Message-ID: <84781ea1-3faa-4afe-8158-f41bdb8974e1@redhat.com>
Date: Mon, 23 Jun 2025 11:33:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/6] qla2xxx: enable FPIN notification for NVMe
To: Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk
Cc: james.smart@broadcom.com, dick.kennedy@broadcom.com, njavali@marvell.com,
 linux-scsi@vger.kernel.org, hare@suse.de
References: <20250620175800.34769-1-bgurney@redhat.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20250620175800.34769-1-bgurney@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250623_083507_163252_A2CDB66C 
X-CRM114-Status: GOOD (  12.68  )
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

Reviewed-by: John Meneghini <jmeneghi@redhat.com>


On 6/20/25 1:58 PM, Bryan Gurney wrote:
> From: Hannes Reinecke <hare@kernel.org>
> 
> Call 'nvme_fc_fpin_rcv()' to enable FPIN notifications for NVMe.
> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   drivers/scsi/qla2xxx/qla_isr.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
> index fe98c76e9be3..cfe7afc905b4 100644
> --- a/drivers/scsi/qla2xxx/qla_isr.c
> +++ b/drivers/scsi/qla2xxx/qla_isr.c
> @@ -46,6 +46,9 @@ qla27xx_process_purex_fpin(struct scsi_qla_host *vha, struct purex_item *item)
>   		       pkt, pkt_size);
>   
>   	fc_host_fpin_rcv(vha->host, pkt_size, (char *)pkt, 0);
> +#if (IS_ENABLED(CONFIG_NVME_FC))
> +	nvme_fc_fpin_rcv(vha->nvme_local_port, pkt_size, (char *)pkt);
> +#endif
>   }
>   
>   const char *const port_state_str[] = {


