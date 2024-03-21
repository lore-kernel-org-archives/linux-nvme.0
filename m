Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CC6C54E58
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Mar 2024 19:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=thXLZIgbAuHNgfpjsghymw/KdOFdu47uhCMZ7EnlTAk=; b=wcd0jOcouWy61jB7WgMh0Wdg9f
	nO76iaaiq6SrISr87xU74Ee2QNdiBYrxuK4rQ1HFCgS/47iFJffedIbyEZhnLRV+/mj9xCyUs8Wy1
	zE8wwOPgfYBBP58EowT6suoOHu+tJhbtDhsfUvznsZVMKNpNiNdHjY0E+rf63EHjWrTk0zHWynSvL
	+YU2MvKOtawcgcmtJ1lXASuPyBvC5D0gz/TOBf4Jlu7w3uBpnp+ZoYNXLOLFvQR4EF/zl6zzNVAGe
	F1OoGxI3POPQ7gaolzaRjZbI8i3IU0kVduoEaCd7JANCU6LMkIzaeLdhzKbvnqWgwDnir+r/37hRf
	uTcavIkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnO10-00000004NfR-0Htu;
	Thu, 21 Mar 2024 19:23:50 +0000
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnO0x-00000004Nej-1J3C
	for linux-nvme@lists.infradead.org;
	Thu, 21 Mar 2024 19:23:49 +0000
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so19175139f.1
        for <linux-nvme@lists.infradead.org>; Thu, 21 Mar 2024 12:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1711049024; x=1711653824; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=thXLZIgbAuHNgfpjsghymw/KdOFdu47uhCMZ7EnlTAk=;
        b=lUt/GgrhozQlFQGTLGKzCYX08bGll22jr6GQWOMCTDE4/XbUoc6RofKtZ5+EFvZGTN
         Fem4nLR7UFSpGdGUBF07843saotdkzjCIeObn81LpU2kJIn1o9erAYCC5x7KOl6J8/iT
         EUxnjFNB0F7oHfPZ4rogGQyQJGoxLFfExocaNTGHNA01KPnxI1Nv0aq6ociFGl/aybyj
         GfLL0k/hH/AJ9IenVDLAiy0R9oa0iOnchCVk0Hv478mwcJG3An9Nq44VWOjCgn5DPwis
         bVDJ5j7fZC0YwkOqpwsIogMzmkr5vxKucbkPnZ0R52QD1yqbc/PIOaIM2ychD2WJAWgp
         jHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711049024; x=1711653824;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thXLZIgbAuHNgfpjsghymw/KdOFdu47uhCMZ7EnlTAk=;
        b=a2Pg6Wu4TUPceXkPkA9ONFoYLZOAx2/EE07uwZ/fp2SdeHGQuhm+E12FVPuVtKqbTL
         nPKhbZCKIiRJho3MzSGrlQ8ummZncE0Zui3zb9K8UBIt6EASM3R5Qk+n3U9sO/hRnWNq
         z8twfbLiKGOjUWsjDK+d4EEpgAyedPIfnHJoAg0WvPhK0HJMOhLVoHSSzRXCqxwhSsI8
         YWy5mmltsTCsSz+lAYjIDjUONCo5X3C3jiflI+xo9cvxQvnJHRVKY2LeHa51tFhXsT7d
         yaIGPenh4HNyzuGvGneyeh2AtZjwBkysbgSOsB0YGrEhg8pNpzP+bXVE7lbmUHFovMrC
         A9UA==
X-Forwarded-Encrypted: i=1; AJvYcCXSIWDha3EbIXiiU5TxAdmTCrcYWcWEeZdMXl1liORbWdh4WHlOLeJyU3p2m+GvU41yTzxYanid16q0W/IVW0io+YYolWUlRjsJmk6Ar2M=
X-Gm-Message-State: AOJu0YwhvsjPNEY2Ia/2nr/IuAghDGsBXwxC5zOjcHXu5sTBfBbqljdP
	2FYLXfOCfsvM/2nOG8Ih8K/ekhs0X22KKO2Id+mKBT68pNzF9FIBvDpyKkpwgfI=
X-Google-Smtp-Source: AGHT+IFQcsWgkjQOduxv0ijcERzC8HSDu7R5faONEUfEqMuKt4oeo/ywSYtWk8pj7wgbg+Q6yKPL7Q==
X-Received: by 2002:a5d:888b:0:b0:7c8:ad73:a702 with SMTP id d11-20020a5d888b000000b007c8ad73a702mr487544ioo.0.1711049024624;
        Thu, 21 Mar 2024 12:23:44 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t10-20020a5e990a000000b007d023ca861csm110397ioj.32.2024.03.21.12.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 12:23:43 -0700 (PDT)
Message-ID: <83e12fb9-8086-48c0-a724-1a39faf3308a@kernel.dk>
Date: Thu, 21 Mar 2024 13:23:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme updates for Linux 6.9
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <Zfx5KbCt1RDMXmzO@kbusch-mbp>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zfx5KbCt1RDMXmzO@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_122347_495847_49B904D4 
X-CRM114-Status: GOOD (  10.74  )
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

On 3/21/24 12:15 PM, Keith Busch wrote:
> The following changes since commit 0dc31b98d7200a0046de5c760feb0aaff6c4b53c:
> 
>   cdrom: gdrom: Convert to platform remove callback returning void (2024-03-07 11:53:30 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.9-2024-03-21
> 
> for you to fetch changes up to 910934da9444dbb102294796481ab05e4419d311:
> 
>   nvmet-rdma: remove NVMET_RDMA_REQ_INVALIDATE_RKEY flag (2024-03-21 10:46:53 -0700)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 6.9
> 
>  - Make an informative message less ominous (Keith)
>  - Enhanced trace decoding (Guixin)
>  - TCP updates (Hannes, Li)
>  - Fabrics connect deadlock fix (Chunguang)
>  - Platform API migration update (Uwe)
>  - A new device quirk (Jiawei)

Pulled, thanks.

-- 
Jens Axboe



