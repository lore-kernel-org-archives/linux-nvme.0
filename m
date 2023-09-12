Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F386CA0ECA
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Sep 2023 13:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sT5hkNHSklDXxqIqGTiB5JxDUiL0ifRJogdFgfoijc8=; b=L5tRyeKIbkYo8j/87y3O5A65EQ
	DK/mx6AGaeSEgIja3x4XcuFrSnp2dZ4Ea59YgKP7A6GmbU7zZEdnIDlLYKmafFLprAWo0LZEdcJkb
	b4uzCtoQJCr/y4hYBrbyqtQRWEAM2b+O10BvJaALLVbqHalARxizPQCqNmtPxqL2Ta3k6JRIZ0631
	SYS0P8q1l8b773Lzvo8V0DYR1dSn3MjmEHricJ4AnrM/IJpCu0AW5uiC2EkEIVV9a8uf+xC3OEeMK
	kixj42fuxuddnGeIjBM2u0Ju5L9YgEZYGcNm9u4vkz2vCuIMnRJD21TSNT0t6Ka1OUmuw3D9FLf+m
	ocBMdSIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg32I-003NbW-20;
	Tue, 12 Sep 2023 13:02:34 +0000
Received: from mail-ed1-f44.google.com ([209.85.208.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg32G-003NZf-1f
	for linux-nvme@lists.infradead.org;
	Tue, 12 Sep 2023 13:02:33 +0000
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-523029050d0so1204215a12.0
        for <linux-nvme@lists.infradead.org>; Tue, 12 Sep 2023 06:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694523747; x=1695128547;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sT5hkNHSklDXxqIqGTiB5JxDUiL0ifRJogdFgfoijc8=;
        b=up6foqtz9ylgPtIq7u+rjVDlFuBgNFxP8/c7+nlJswihuC6ntcNJ7VPSNwdRiQ/W5d
         KyAGPa8EXsZHET4E1Rman/TJ0KrKuFPYjOdMLFRa6wJrI6rSg4zfsJrjPjMVp+9v9jzD
         R/0ShtqkhNitJOWluUQE0NSrHyP5oJ0IujSwQQ/PAK9twoMYYt6xllk7Y70kknVu1wA0
         WWtWAp9/+ftsJqfPfHB3WatquGDM1xS7r/EQiB2xnQg5kuIchOlqVeq+ocyTIgf/+i63
         J8OUKr30RiVhWEN3BfS6q1Wn0/T5OANbw7xbVUqzPcj9X5qPblwtXcDJfkcMFgfeqwss
         yArg==
X-Gm-Message-State: AOJu0Yyu8bjbeNl28B9KWDXUaERGB7wSc879bBUWqbe+yr+pUhRQe9mP
	o/RUTyR/gYdZXZLZvXk8O+U=
X-Google-Smtp-Source: AGHT+IHVizLaVpP4etNJGTvJ2pja7Pk/pIO1fVmsH+jYArILy5wl+bk0U82Ex0dK4UPZvuChDt0oeg==
X-Received: by 2002:a17:906:212:b0:9a6:5340:c337 with SMTP id 18-20020a170906021200b009a65340c337mr8856928ejd.2.1694523747462;
        Tue, 12 Sep 2023 06:02:27 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id u14-20020a17090657ce00b00992afee724bsm6756230ejr.76.2023.09.12.06.02.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 06:02:26 -0700 (PDT)
Message-ID: <013478c2-ed6a-eef5-c39c-6108671de0ab@grimberg.me>
Date: Tue, 12 Sep 2023 16:02:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/3] nvme-tcp: Do not terminate commands when in RESETTING
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230908100049.80809-1-hare@suse.de>
 <20230908100049.80809-2-hare@suse.de>
 <b21a2472-2afb-5a38-1029-1db153102a0c@grimberg.me>
 <25a59314-ff11-4217-b1d8-d06f684312f5@suse.de>
 <9f5afd8d-b1b5-53de-9229-8b48d87f4106@grimberg.me>
 <f4a41d0b-b2ff-4623-a155-c227e92b02d1@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <f4a41d0b-b2ff-4623-a155-c227e92b02d1@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_060232_549192_0CECCCC7 
X-CRM114-Status: UNSURE (   9.64  )
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


>> firmware download? what happens if err_work is yet to run when
>> this request times out?
>>
> But that's fine, as it's queued, and as such will be run eventually.
> It'll have a delay until it's completed.

But there is a window between the ctrl state RESETTING and the
work being queued, you are fine with failing the commands in
this window?

