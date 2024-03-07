Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6BBC48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 08:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WR9GpqvZqv3kgk+k1QCQJN0lj8bPs0odrR3grdxUnh4=; b=ozNduIe24dS8ALljNuB3dJmh4f
	mCf8txzlLF9VHmh+O1BM0l1VA4LP9u/kUJnHOt6HOBsqlwoL4E7nEY2JBiiMfzidS4ftnJgLAxqfK
	BOw0gdNA1IQ2AQx/TRjNyb73wxCGE5b0J5CkJgRYS3sSMIx0k0yHpiDzSQJ5os2xQaTpME1j11Iie
	Y9Ah+py/E7SN/H8W+TdyKP8u0pmZlSZ7b4F9W9qKiCGEpCTlfr92LrwPdL3r4CEpK9fb+H60C9/T1
	xAr0HEMjRzHLedV8HGSl3rhwPmXskdLt753B4DBSkuWnQC3A3urE3jO/tczjIe6Q6CdWw0Fy9Nieb
	su/xWoVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri9Y9-00000003jA0-1kdV;
	Thu, 07 Mar 2024 08:56:25 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri9Y6-00000003j9R-05Nk
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 08:56:23 +0000
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33dc6df042aso144635f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 00:56:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709801780; x=1710406580;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WR9GpqvZqv3kgk+k1QCQJN0lj8bPs0odrR3grdxUnh4=;
        b=rbHAsJOgIhHk92CZM7JycUn78IQaDq86stIXoBdzSPFETx0PndUd/kH615+Ifo6vVo
         2aK8KLHQBTjgACvXnunNrdnIHiYMWPoC5CPnYx5xJ5z019gcJwfeytOeF7QERY1gURJJ
         IDC8oKMyP99M2ZmE3x6sSS0gLgQxbw7gx+kGfd2jdeYDAlCWGMEOSNRO1I248h85Jelm
         mRbkocD85D47ORo+9M+3U67GfefrL/OePTIrD8pyZE2bu7D0e0NetJm1H7xVPYB60iWd
         v5eqCz5xSf8UVkCwcbZ8/Ma8JbeUWxUcN7DwZGc94sJBqN92VYqLMVHV0geKZrvvSAzN
         tfRg==
X-Forwarded-Encrypted: i=1; AJvYcCWZCRcrWMF1ho9SRJTFaTILs/VhUpniaigUJDMn5mSLuskYWUasnwSmMze88eQaHchT1wyHYtJlKpU6Q3567Xb8bY3NMSD9kDmhFxVksYQ=
X-Gm-Message-State: AOJu0YygKqVF0ST7xIKyLVLNIZmiQ9SZb7xqQupsFipj6VtXW9HfgMH/
	y83xhbc/mXvWzm4uuV+WhhjG9heYd7E9rnn3iScrj6LOSSpmGoM3
X-Google-Smtp-Source: AGHT+IHN2GPS0yTeTpcw2BZEBJXLm50lo/sBFLOHuk4m9ZLYCHwyBETsWV1FneMvN7/6js2Mm89JZg==
X-Received: by 2002:a05:600c:4711:b0:412:f3f0:d8af with SMTP id v17-20020a05600c471100b00412f3f0d8afmr947150wmo.0.1709801780425;
        Thu, 07 Mar 2024 00:56:20 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id bn20-20020a056000061400b0033e43756d11sm9119695wrb.85.2024.03.07.00.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 00:56:20 -0800 (PST)
Message-ID: <38d98acc-4042-4fef-af1d-cee2eccc98d8@grimberg.me>
Date: Thu, 7 Mar 2024 10:56:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] nvmet: return DHCHAP status codes from
 nvmet_setup_auth()
Content-Language: en-US
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240301112823.132570-1-hare@kernel.org>
 <20240301112823.132570-4-hare@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240301112823.132570-4-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_005622_101874_8D418484 
X-CRM114-Status: UNSURE (   7.68  )
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



On 01/03/2024 13:28, Hannes Reinecke wrote:
> A failure in nvmet_setup_auth() does not mean that the NVMe
> authentication command failed, so we should rather return a
> protocol error with a 'failure1' response than an NVMe status.

Shouldn't nvmet reply NVME_SC_INTERNAL like in other similar
cases?

