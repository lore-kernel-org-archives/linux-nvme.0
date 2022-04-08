Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDD4C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Apr 2022 07:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fWqWKmE1mosoPgsTNf2ttX4Gob3HWGggnV1qGyC1iWA=; b=0rnMrvnkqS0T42gAnl/i3iHZ7V
	GLwXPt3OA+TAZETJlLJno9vprkHwp8WNZmZ8bFZm/eKhE2rL84ZvESu8ISar3Z02fBn4HyUvvl5Jo
	X4+hw1psBq6IMM+d7Zyah9v08XajfRx/PEdlKkz1tfLwRgiM4zJ690qTyG0OmxvSCjsaQef5zWTP0
	uDNYruq8QlQi9Dsmq0QeeRlPqKD2TuhDuTN/BTd/XjJMsDlh/QWDZ4Q+sAIkGIutHKMY73qwcNrfw
	IICu3v5a8VKn07c67aYhKh3tYtLjolc3Aw35wJzVgGgCIyN6JwdP7mwHX+WyDSlE7+OxcLFpaJXcO
	Cnl4R+Iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncjUF-00FePd-Bw; Fri, 08 Apr 2022 07:56:55 +0000
Received: from mail-m118206.qiye.163.com ([115.236.118.206])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncjUC-00FeO5-5K
 for linux-nvme@lists.infradead.org; Fri, 08 Apr 2022 07:56:53 +0000
Received: from [192.168.1.164] (unknown [222.20.98.78])
 by mail-m118206.qiye.163.com (HMail) with ESMTPA id BB4ABBEE37F;
 Fri,  8 Apr 2022 15:56:49 +0800 (CST)
Message-ID: <7b59552e-196e-d06a-f057-aaa3e9432841@kingtous.cn>
Date: Fri, 8 Apr 2022 15:56:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] fix: nvme_update_ns_info method should be called even if
 nvme_ms_ids_equal return false
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, linux-nvme@lists.infradead.org, axboe@fb.com,
 sagi@grimberg.me, kingtous <kingtous@qq.com>
References: <20220408051915.GA31955@lst.de>
 <ABwAxgCYBwe5Iq2fM1-8qqrc.3.1649398333597.Hmail.me@kingtous.cn>
 <20220408062210.GA410@lst.de>
From: =?UTF-8?B?6YeR6Z+s?= <me@kingtous.cn>
In-Reply-To: <20220408062210.GA410@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
 kWDxoPAgseWUFZKDYvK1lXWShZQU83V1ktWUFJV1kPCRoVCBIfWUFZQx9DQ1YfQksZSkNNTx0dGB
 1VAhYTFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS09ISVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MRQ6NAw6NTlKT04wCT1OVh0S
 MRMaCzVVSlVKTU9CT0tPTUpLT0hOVTMWGhIXVRYeOxASFRwPFA4IVRgVRVlXWRILWUFZSUlJVUlL
 VUJDVUxDWVdZCAFZQUhNT0M3Bg++
X-HM-Tid: 0a80082d06402d28kusnbb4abbee37f
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220408_005652_401774_8E4910F6 
X-CRM114-Status: GOOD (  14.62  )
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

This is output from dmesg. Seems that "eui" has changed.

[    2.086226] loop0: detected capacity change from 0 to 8
[   26.577001] eui changed from 0100000000000000 to 0000000000000001
[   26.577003] nvme nvme0: identifiers changed for nsid 1

在 2022/4/8 14:22, Christoph Hellwig 写道:
> On Fri, Apr 08, 2022 at 02:12:13PM +0800, me@kingtous.cn wrote:
>> Yes, I only have one controller with one namespace.
>> I've done `nvme id-ns /dev/nvme0n1` times before and after suspend. The only difference between the two output is nuse address. The nuse address's output is dynamic, the outputs are different each time I execute the nvme id-ns command.
>> When the laptop wakes up, tty will show "identifiers changed for nsid 1". I checked the "nvme_ns_ids_equal" function, it will check uuid, nguid, eui64 and csi. So maybe there is something changed in uuid or csi?
> 
> Let's try this:
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index efb85c6d8e2d5..0c38184a3ffa2 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1631,10 +1631,28 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
>   
>   static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
>   {
> -	return uuid_equal(&a->uuid, &b->uuid) &&
> -		memcmp(&a->nguid, &b->nguid, sizeof(a->nguid)) == 0 &&
> -		memcmp(&a->eui64, &b->eui64, sizeof(a->eui64)) == 0 &&
> -		a->csi == b->csi;
> +	if (uuid_equal(&a->uuid, &b->uuid)) {
> +		printk("uuid changed from %pU to %pU\n",
> +			&a->uuid, &b->uuid);
> +		return false;
> +	}
> +	if (memcmp(&a->nguid, &b->nguid, sizeof(a->nguid))) {
> +		printk("nguid changed from %16phN to %16phN\n",
> +			&a->nguid, &b->nguid);
> +		return false;
> +	}
> +	if (memcmp(&a->eui64, &b->eui64, sizeof(a->eui64))) {
> +		printk("eui changed from %8phN to %8phN\n",
> +			&a->eui64, &b->eui64);
> +		return false;
> +	}
> +	if (a->csi != b->csi) {
> +		printk("csi changed from %u to %u\n",
> +			a->csi, b->csi);
> +		return false;
> +	}
> +
> +	return true;
>   }
>   
>   static int nvme_init_ms(struct nvme_ns *ns, struct nvme_id_ns *id)
> 

