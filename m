Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA25C04A95
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 14:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OprNhGuB4OzYpf8SHeulDdudJfBdEdddEPeFXs/ZcU8=; b=KdnpkOoCqA62xAcDqUWqRk4jME
	2y7aWYzwDwaE/RPObSDIXUwXQY83ilyS6WOwbByw/7WiX6nv/2Qd6Bz7lIjtpPlgvhytnRJWUtd4i
	JgKUV6RP33ZuSSv5FQpm8C9WNNwySDzeh02SvWXmv8WRZfeYuNUNW21cSfiVTJEIqQCa0LOmoQH5+
	xdxqukdutX99TNBYExpbK5DIiAOSZtpZDxxx3dinWeA6JrxNFyCdDhCugdDbfFudn94BBibHRf24w
	fmhitTcsu1Vz0DxtG4bl1uyllvoalsOEf2O1w9BE89uc2VOFiWDf+YOMOU89ZFqRm0YYGmqUH9s9q
	SbdawIPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odYGA-00GiQz-2C; Wed, 28 Sep 2022 14:42:02 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odYG7-00GiPO-Ox
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 14:42:00 +0000
Received: by mail-wm1-f49.google.com with SMTP id d12-20020a05600c3acc00b003b4c12e47f3so1133162wms.4
        for <linux-nvme@lists.infradead.org>; Wed, 28 Sep 2022 07:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=OprNhGuB4OzYpf8SHeulDdudJfBdEdddEPeFXs/ZcU8=;
        b=brA35AgdXNTMfAVh0Euq0w8rcwjbiCWiFyVyZuwYXxJF10zu2vLQayGdv1NDvFbOP6
         0Y4QA8R0cM2kkI8mrJfhBNkkRerKmJ1wcmcXpQtNFfHyqe+KTeyFJ2GiOr5qggx6Plie
         DlbgbIOloJ65zoKKjd38Dpp/m68uS0etUI/0sbvFGs56y6XpTjzFj86aURvu31tyXHHv
         H0zl2OULZGEAdB9NdbczpMBcpPPfuPY49NJkvhrQDHL5q8qXqzgGWl5aqm/RG36Jx2zZ
         Wx+ehUhftvmggYTOHhRAcBDjD6s3a9eYQKjoMg/yZMWrqvU5VyNSO6qClTzuR1lQwBLB
         gDyg==
X-Gm-Message-State: ACrzQf3JhO4KJ1G/V33tuwQNDyxrG+CUSjTYf9GJaXAqII0KPY0yR6sM
	RNPOkYh0eUVXMiI+BZvkkVc=
X-Google-Smtp-Source: AMsMyM4u0MZhNjYPZX2YBpNP8BT2U893uqxHcPmGOd2TkE60K/guHV9WYbas5e+JsJKsMrVx7gDXxw==
X-Received: by 2002:a05:600c:1e08:b0:3b4:8fef:d63c with SMTP id ay8-20020a05600c1e0800b003b48fefd63cmr7013537wmb.158.1664376110630;
        Wed, 28 Sep 2022 07:41:50 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c154b00b003a3442f1229sm1954929wmg.29.2022.09.28.07.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 07:41:50 -0700 (PDT)
Message-ID: <47de21f9-3322-573c-eb92-1f52bd9a61a7@grimberg.me>
Date: Wed, 28 Sep 2022 17:41:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] nvme: fine-granular CAP_SYS_ADMIN for nvme io commands
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, kbusch@kernel.org,
 axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, gost.dev@samsung.com
References: <CGME20220927184633epcas5p2b4a49bdfb2748fb4218f1fb901f305a0@epcas5p2.samsung.com>
 <20220927183620.12583-1-joshi.k@samsung.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220927183620.12583-1-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_074159_836947_745501DF 
X-CRM114-Status: UNSURE (   9.16  )
X-CRM114-Notice: Please train this message.
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


> +bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c, fmode_t mode)
> +{
> +	u8 opcode = c->common.opcode;
> +
> +	if (capable(CAP_SYS_ADMIN))
> +		return true;
> +
> +	/* admin commands are not allowed */
> +	if (ns == NULL)
> +		return false;

As Christoph suggested:
	if (!ns)

Other than that, this look good to me
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

