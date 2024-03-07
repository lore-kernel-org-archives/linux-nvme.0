Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71305C48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 08:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gF8bMckiGK/orGQSQLOnHOoeQYTQXbZE1poMDWDyy34=; b=WX2AduZMNZx+9HV9TH+k/CvDG8
	IYFjR5QuxcZpBnb5HSf3mXnGtSaNAEV89o5yN/QJkB34LQWa1kOctORywhGnyaCfCxqgAfgjw4iRZ
	denvjakNHBnrNlTwY3QzQRz/HlzlvM/QdVdmMXHHukPKNYc+bxGCW3OOPcAX4DuoJBw/7DAbPPH5s
	3nYHDFNqokwt3u7bLwMUBWUZ8ZylvABZHC08UDlMbfJHS2doq/ZWXdJ6/GnQvmu++WPkfdUWKl3FH
	8jWbI55WjS3GdbIdZrI0cNNBiVsVE7aLkzuruS7rjlOAdRrERm9M+Wi1CjfaJe+RUqYhfcePrU/Ck
	MKKlWT1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri9aS-00000003jjn-0aYT;
	Thu, 07 Mar 2024 08:58:48 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri9aO-00000003jiS-3dUV
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 08:58:46 +0000
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33e12bcf6adso204720f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 00:58:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709801923; x=1710406723;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gF8bMckiGK/orGQSQLOnHOoeQYTQXbZE1poMDWDyy34=;
        b=to52mnenCrDQBXetv2Q463MzJ+oNOlUOZAaEDO/HJotMlzs/3rKJkMjiBnNQIWG77u
         vDeWsFHOPaWoejKHXGwrHLcofSAgFAqBixYRQvPB4LPj8W1i+pJmMiFbgKaSoH6OMxM3
         /xq+3MkJcNyl7iyHoS/qbW6ZOAJ0C7cH+W4J3KHTOfTnN7MZAV0NhbXUCmoP6OvgdR/h
         QxIISByWoEQ9u/qHpw4zc5xd/8hQiym0PH+j8Ipsv83ha/fLAH09SXsRRJ4LTp9Q6NgD
         z2WQBqf2pLINgkj+OMtCy53vhDH0Y5ikVfWXF1+UGp2DkR9jLHI2GvVpCKgAMx42hfrb
         Fg/w==
X-Forwarded-Encrypted: i=1; AJvYcCXMDeiPJjCj4dOdolUWOkN7jLWYmwn/3VbztNZKBRcjBMJOt/p16ytAaGRP/5kba9ucS9IJj3CGWjy2QuulHVbykADrgXiyfwHKFwT0qyY=
X-Gm-Message-State: AOJu0YzDUZT6mBM8N7sIm8WT8kKZ0fguxbPo/+LiDaIcQRHeNCpR/ZYW
	uTBXc0xvmw0HAo84mZ9jG3KejjFMJISN23gZTpSnr9m36B63B0nT
X-Google-Smtp-Source: AGHT+IGcpfGTFPpytNQ379EgPRTRldvjLmqMJnzGT0ynoaL9vUpFYruu7Al807J09QMpATcLzdvGvw==
X-Received: by 2002:a05:6000:4024:b0:33e:6a7d:41b8 with SMTP id cp36-20020a056000402400b0033e6a7d41b8mr343418wrb.5.1709801922885;
        Thu, 07 Mar 2024 00:58:42 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id p3-20020a5d4583000000b0033b47ee01f1sm19602753wrq.49.2024.03.07.00.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 00:58:42 -0800 (PST)
Message-ID: <8a46bb74-d3ea-4c6d-9393-01bef661388b@grimberg.me>
Date: Thu, 7 Mar 2024 10:58:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] nvmet-loop: do not call nvme_ctrl_put() after
 nvme_ctrl_uninit()
Content-Language: en-US
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>
References: <20240301112823.132570-1-hare@kernel.org>
 <20240301112823.132570-5-hare@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240301112823.132570-5-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_005844_942968_A18566B2 
X-CRM114-Status: GOOD (  15.12  )
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

Looks fine,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

But I think it would help if loop would behave like other transports
that do have the extra put.

On 01/03/2024 13:28, Hannes Reinecke wrote:
> nvme_ctrl_uninit() already calls nvme_ctrl_put(), doing it twice
> will cause an UAF.
>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/target/loop.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> index f1d5eee3daec..82db181f0168 100644
> --- a/drivers/nvme/target/loop.c
> +++ b/drivers/nvme/target/loop.c
> @@ -615,7 +615,6 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
>   	kfree(ctrl->queues);
>   out_uninit_ctrl:
>   	nvme_uninit_ctrl(&ctrl->ctrl);
> -	nvme_put_ctrl(&ctrl->ctrl);
>   out:
>   	if (ret > 0)
>   		ret = -EIO;


