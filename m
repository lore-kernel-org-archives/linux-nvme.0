Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5303FCEACEF
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Nov 2025 22:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bl7sZ0YzOQsay7xbIBctjmSl+3K4PKn7Tr0++h8Xmbs=; b=U8U7KoG2D63qolmA12UiA5i6jT
	lh2MNvbZzIhw9Tdm3D40WviuAJfd1OrdvF8CBj5ltYUQ7aAiHmjTqkcz/FVlJg4jt7o9ZRLLI/o6G
	A6PebCbnqAw2wzKbc2hXRj5O5tnjKfPId5aQio4HbpU/S6ZcHiOhv9TGB2yDIsPVveaf6S1psXEaA
	NR0KjGUZsfDf0B1XAjJsyzCMubyeM9f45bQBhPX/HxtbrcMGChfceZsuxzWYfCb/ntz3fgfAtO2BX
	xu9kfPiNkBWCQDnaDt0DxdQnNzBLpycrAQrPuVEgtBUVS5K0rivbi4L385GyyFXPg1cKzrtG0EF2S
	TBm45kMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL7VB-0000000Gw3K-06uk;
	Mon, 17 Nov 2025 22:15:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL7V3-0000000Gw2B-0IEl
	for linux-nvme@lists.infradead.org;
	Mon, 17 Nov 2025 22:15:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763417703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bl7sZ0YzOQsay7xbIBctjmSl+3K4PKn7Tr0++h8Xmbs=;
	b=HqtVFUFtDisshHIKHoMjjMZH1XUojB32VAS1NyTCARcGFloq260AQBvp5hc0nYBNJf7unE
	CMVPkWBVC3DC27ToMvTAWrh/agcyeXFfj0XAlmv95WqNycA95g6XH1aoxDhwvxUFxZjql0
	hgNO5kjqPHZQwvSwD4J+1vrPbQINPjQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-iynfMq9zOLSSas4NlG-K1A-1; Mon,
 17 Nov 2025 17:12:38 -0500
X-MC-Unique: iynfMq9zOLSSas4NlG-K1A-1
X-Mimecast-MFC-AGG-ID: iynfMq9zOLSSas4NlG-K1A_1763417557
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E2041956095;
	Mon, 17 Nov 2025 22:12:36 +0000 (UTC)
Received: from [10.22.80.134] (unknown [10.22.80.134])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 411FF19560A7;
	Mon, 17 Nov 2025 22:12:34 +0000 (UTC)
Message-ID: <88864e05-c2ed-4dd6-935a-d2346b54cc44@redhat.com>
Date: Mon, 17 Nov 2025 17:12:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] nvme: expose active quirks in sysfs
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: mlombard@bsdbackstore.eu, bgurney@redhat.com, bvanassche@acm.org,
 linux-nvme@lists.infradead.org
References: <20251103144406.1148401-1-mlombard@redhat.com>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20251103144406.1148401-1-mlombard@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: itTiVxndbsSLlmNxz5qoWKDuAmhixEByas6YeI75rds_1763417557
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251117_141505_357865_CEAA0B21 
X-CRM114-Status: GOOD (  24.12  )
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
Tested-by: John Meneghini <jmeneghi@redhat.com>

Looks good to me. Testing this on my VM shows the correct quirk information for both

   -device nvme,use-intel-id=on and
   -device nvme,use-intel-id=off

root@target-vm:~# grep . /sys/class/nvme/nvme0/quirk* /sys/class/nvme/nvme0/device/{vendor,device}
/sys/class/nvme/nvme0/quirks:0x00040202
/sys/class/nvme/nvme0/device/vendor:0x8086
/sys/class/nvme/nvme0/device/device:0x5845
root@target-vm:~# grep . /sys/class/nvme/nvme1/quirk* /sys/class/nvme/nvme1/device/{vendor,device}
/sys/class/nvme/nvme1/quirks:0x00040000
/sys/class/nvme/nvme1/device/vendor:0x1b36
/sys/class/nvme/nvme1/device/device:0x0010

Keith, please merge this patch.

/John

On 11/3/25 9:44 AM, Maurizio Lombardi wrote:
> Currently, there is no straightforward way for a user to inspect
> which quirks are active for a given device from userspace.
> 
> Add a new "quirks" sysfs attribute to the nvme controller device.
> 
> Reading this file will display a human-readable list
> of all active quirks, with each quirk name on a new line.
> If no quirks are active, it will display "none".
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
> 
> V2: Do not expose kernel-internal constants to userspace.
>      Move the quirks attribute to the controller device, where it belongs.
> 
>   drivers/nvme/host/nvme.h  | 54 +++++++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/sysfs.c | 23 +++++++++++++++++
>   2 files changed, 77 insertions(+)
> 
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 102fae6a231c..647f19dd57e9 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -180,6 +180,60 @@ enum nvme_quirks {
>   	NVME_QUIRK_DMAPOOL_ALIGN_512		= (1 << 22),
>   };
>   
> +static inline char *nvme_quirk_name(enum nvme_quirks q)
> +{
> +	switch (q) {
> +	case NVME_QUIRK_STRIPE_SIZE:
> +		return "stripe_size";
> +	case NVME_QUIRK_IDENTIFY_CNS:
> +		return "identify_cns";
> +	case NVME_QUIRK_DEALLOCATE_ZEROES:
> +		return "deallocate_zeroes";
> +	case NVME_QUIRK_DELAY_BEFORE_CHK_RDY:
> +		return "delay_before_chk_rdy";
> +	case NVME_QUIRK_NO_APST:
> +		return "no_apst";
> +	case NVME_QUIRK_NO_DEEPEST_PS:
> +		return "no_deepest_ps";
> +	case NVME_QUIRK_QDEPTH_ONE:
> +		return "qdepth_one";
> +	case NVME_QUIRK_MEDIUM_PRIO_SQ:
> +		return "medium_prio_sq";
> +	case NVME_QUIRK_IGNORE_DEV_SUBNQN:
> +		return "ignore_dev_subnqn";
> +	case NVME_QUIRK_DISABLE_WRITE_ZEROES:
> +		return "disable_write_zeroes";
> +	case NVME_QUIRK_SIMPLE_SUSPEND:
> +		return "simple_suspend";
> +	case NVME_QUIRK_SINGLE_VECTOR:
> +		return "single_vector";
> +	case NVME_QUIRK_128_BYTES_SQES:
> +		return "128_bytes_sqes";
> +	case NVME_QUIRK_SHARED_TAGS:
> +		return "shared_tags";
> +	case NVME_QUIRK_NO_TEMP_THRESH_CHANGE:
> +		return "no_temp_thresh_change";
> +	case NVME_QUIRK_NO_NS_DESC_LIST:
> +		return "no_ns_desc_list";
> +	case NVME_QUIRK_DMA_ADDRESS_BITS_48:
> +		return "dma_address_bits_48";
> +	case NVME_QUIRK_SKIP_CID_GEN:
> +		return "skip_cid_gen";
> +	case NVME_QUIRK_BOGUS_NID:
> +		return "bogus_nid";
> +	case NVME_QUIRK_NO_SECONDARY_TEMP_THRESH:
> +		return "no_secondary_temp_thresh";
> +	case NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND:
> +		return "force_no_simple_suspend";
> +	case NVME_QUIRK_BROKEN_MSI:
> +		return "broken_msi";
> +	case NVME_QUIRK_DMAPOOL_ALIGN_512:
> +		return "dmapool_align_512";
> +	}
> +
> +	return "unknown";
> +}
> +
>   /*
>    * Common request structure for NVMe passthrough.  All drivers must have
>    * this structure as the first member of their request-private data.
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 29430949ce2f..16c6fea4b2db 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -601,6 +601,28 @@ static ssize_t dctype_show(struct device *dev,
>   }
>   static DEVICE_ATTR_RO(dctype);
>   
> +static ssize_t quirks_show(struct device *dev, struct device_attribute *attr,
> +                char *buf)
> +{
> +	int count = 0, i;
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +	unsigned long quirks = ctrl->quirks;
> +
> +	if (!quirks)
> +		return sysfs_emit(buf, "none\n");
> +
> +	for (i = 0; quirks; ++i) {
> +		if (quirks & 1) {
> +			count += sysfs_emit_at(buf, count, "%s\n",
> +					nvme_quirk_name(BIT(i)));
> +		}
> +		quirks >>= 1;
> +	}
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RO(quirks);
> +
>   #ifdef CONFIG_NVME_HOST_AUTH
>   static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
>   		struct device_attribute *attr, char *buf)
> @@ -742,6 +764,7 @@ static struct attribute *nvme_dev_attrs[] = {
>   	&dev_attr_kato.attr,
>   	&dev_attr_cntrltype.attr,
>   	&dev_attr_dctype.attr,
> +	&dev_attr_quirks.attr,
>   #ifdef CONFIG_NVME_HOST_AUTH
>   	&dev_attr_dhchap_secret.attr,
>   	&dev_attr_dhchap_ctrl_secret.attr,


