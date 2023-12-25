Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6ACC3DA6E
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Dec 2023 09:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qFGbcFuvxj1oJJmvJkaRPM64VClsQEZ0ZoC3CaWjLw4=; b=Bpw9cnpQukrMebMAFuw1sr/8/J
	mY4B6fOLiux9aFm0oL9fNG0zIvCTSV5d1MwVkwTfLpjwfYo+UCb2IAhy1GziOBtCrkdrsVnpPuaoJ
	MpX8V/9UeIVeFNGQ9pItkqOSX7rjH8Bvk/H64ior5cY2bt4eXnLajD2eCjNpQkOH6joMDzT7kzKIM
	g6UKXi2T3Qua3Qp4nTTwUJ7+dclMDRHDfpV+MVfF7JUuvc2dNbJ8HIsInEUqdAncQa5noHFfY9Tmu
	oLf9N4kCB+ZlPg9aMlsp4jpNpLxvFXAqeWNPIRDaFfIC2QLMt6AwpKmnA3XbHz+p+7N5UtkwpANLM
	swE9V+mA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rHh91-00ASU9-1u;
	Mon, 25 Dec 2023 09:21:07 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rHh8z-00ASTg-0P
	for linux-nvme@lists.infradead.org;
	Mon, 25 Dec 2023 09:21:06 +0000
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3367f8757d0so652110f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 25 Dec 2023 01:21:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703496062; x=1704100862;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qFGbcFuvxj1oJJmvJkaRPM64VClsQEZ0ZoC3CaWjLw4=;
        b=KCMz93u9Yc5H331ragx60hlTN1FGhu8EWRNCApT2wui2NCY6641uD6XUKJOq4C6ljg
         xZ1Qi1m9E5QJ0MU1d/CNCeGUXU3zft5I762Kv1kT5ieqNqOdW5KH5lwTsq4tywI9COtK
         nxJZU5sYlBMHKQ0EmVQSJ4f3vGI3eu9t8W7OwWMRulMNLpwZI3ikYPKwi3sa8h/IxHDH
         IvMEkQPNSE4FdfTi1FW0oJn4PAx2i4Ggm8+/QBIy3IA+dz/nKCDwRZ922Lp8G7is7ZGx
         rKRAJseAWAbmXt1rUc1i5MmH1YHmSd/QjOaAPku8Uutz/9mHCjffdimaHvmVyKQj0Mp0
         vZcg==
X-Gm-Message-State: AOJu0YwlTkW5WVq6tdyUrAWa2/BI5pQwjZjk606xPP4NzLB8KF/6ST15
	gQ4rS3zzm+9R/u1DgTQBcjA=
X-Google-Smtp-Source: AGHT+IHFEtrsxSRtPl+040Ge40OVup+8/UVS7vRi0YeAGCOuZcAU2yOEVWhgCFYmHliAD/uNLiQAOg==
X-Received: by 2002:a05:600c:3584:b0:40d:5329:96a3 with SMTP id p4-20020a05600c358400b0040d532996a3mr3587122wmq.0.1703496062269;
        Mon, 25 Dec 2023 01:21:02 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c154b00b0040d556513d0sm4129139wmg.39.2023.12.25.01.21.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Dec 2023 01:21:01 -0800 (PST)
Message-ID: <cc4f51f1-baec-4356-b297-62cd3d7db394@grimberg.me>
Date: Mon, 25 Dec 2023 11:21:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvme-fabrics: don't check ioccsz/iorcsz for discovery
Content-Language: en-US
To: Caleb Sander <csander@purestorage.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, dwagner@suse.de, kbusch@kernel.org,
 hch@lst.de, linux-nvme@lists.infradead.org, oren@nvdia.com
References: <20231220092745.35325-1-mgurtovoy@nvidia.com>
 <573c2ad1-8407-4c8d-b31d-b89b16f0fea0@grimberg.me>
 <CADUfDZrhPONOEK6xhbn3Uig4UZ+nwg0hDCRUziW8NA_g01raHQ@mail.gmail.com>
 <5694a097-eec9-45af-8bf5-2e5d3963a03f@grimberg.me>
 <CADUfDZo5zxgidqjt-OmQVzGXdoONvX=LV0dpm0rCsjjXPhnBpg@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CADUfDZo5zxgidqjt-OmQVzGXdoONvX=LV0dpm0rCsjjXPhnBpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231225_012105_168806_1C34F9B3 
X-CRM114-Status: UNSURE (   7.59  )
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


>>> Why? As Max points out, the base NVMe spec says those fields are
>>> reserved for discovery controllers.
>>
>> Oh, didn't understand that it was already the case, I thought
>> that the intention was to made it as such. Can you point us
>> to this part in the spec?
> 
> https://nvmexpress.org/wp-content/uploads/NVM-Express-Base-Specification-2.0c-2022.10.04-Ratified.pdf
> Figure 275: Identify – Identify Controller Data Structure, I/O Command
> Set Independent
> Both fields IOCCSZ and IORCSZ have "R" in the "Disc" column,
> indicating that they are reserved for discovery controllers.

Thanks Caleb.

