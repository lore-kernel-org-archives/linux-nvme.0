Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62EBAC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Dec 2022 22:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D4ShxVlrRZZEw3kTc9+Eq/CqWjpW5gfckjD4M0oORfY=; b=0A+H+sNeFPLAih
	JhPeAjLbTIhgrqJoZXjiEpvU3cDL27QJlCGEtX7IZHoz5irfC/EWgQMRv+v1wQcFm7oSCsXqQd7k3
	6R7xEp4Kb3PmNyYLWG+v+3k/lGMBS8j+pmke1aAA3217vOcqCe0aTAh0tW8ngBa/lPAY6heiKAHN1
	GOghKupmI+5rLmxqWca9NOtEsM1Cr6m/vOGow8uTHziOVpMjd4pZ7e/2UtojqxPHeznQtaGZKP2XB
	ApVn2LflmtFmTs4CyGPp4UG4UQd9KaOobO1dX8N7POdw4bk/5y7gNYdF/jTzT1h3eGRxfqmyPbLPw
	uW7BzRkXwVxNzg7xc2iQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5wko-00BcNL-Ni; Thu, 15 Dec 2022 22:31:02 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5wkm-00BcMp-Jg
	for linux-nvme@lists.infradead.org; Thu, 15 Dec 2022 22:31:01 +0000
Received: by mail-pj1-x1035.google.com with SMTP id fy4so675062pjb.0
        for <linux-nvme@lists.infradead.org>; Thu, 15 Dec 2022 14:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D4ShxVlrRZZEw3kTc9+Eq/CqWjpW5gfckjD4M0oORfY=;
        b=EcP/9n1FR9+wLDaHYwamP+LZkypIvjOGCnFd3vnWCK4B2x3nTN5cPc/0w8QhegJ8wc
         qH0yl3BMsMf0dgqu8u901C4gHUXCjqrZQIIoF+Pmpb+4Kz/tEvDsSB3IRPfd2GV8gG9t
         cqZ6J+YbRhj7pzSy2Ue0pr6iYUSuUXfCLGlu/6JrsiHUYQHQ7htWNHASoWV97SwhLw3t
         g0QKPFDJh7b94RtkdTAikcAQVpQ2RRY09kYquO0V23uK1hYwyoQw6ybMyurmavpafr7p
         Gbeq9ZQ+hHNtpvbr4OQtJ4gwJiDxOTeAJv9f+jv0WrcnQ8+HXDTaHDcAja8mWaJhcRYC
         eWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D4ShxVlrRZZEw3kTc9+Eq/CqWjpW5gfckjD4M0oORfY=;
        b=uIwEhHH0U/wJXs/JW1J7rN7lYJyN5bWMwIshTlO+aZysA4xZCRUie7MU6Rz4mqRQ9r
         WTiJ4ch2zXGW9QcxL5v+/3J/LE3S6q8+dGs3Ymm6Q6CcUH+9RsHoIiCx5T5GfojqbI94
         q+kwl4CEwd2A3ZpTMSPUDJOrPEUHSZ2yb7UhpunikKamtnUobkzO/PsuwFBXYBIYY7+P
         6MTUHp8eFWOhSqcZYQLz1MjeP/xD8zx/xK4sOwtaZoOL9SZ0RPD6hS8F86i77eq8RVxE
         M5LIDLCHU5lvfQKh7VZd0sq5BDo8O/8TPLMid3d/OMig41SRPuODsDQNG49sXHFN9T2/
         mDDg==
X-Gm-Message-State: ANoB5pkQzMKrDBrdLD8yZ0KanH8tKM42mbxDIZBCzcSbtEPeeX5+qco0
	XKPniVRWiPcd9g/NKDNaZOU=
X-Google-Smtp-Source: AA0mqf6h6PhuNRHVRaMxzbMnSLJ/fprH6RnvYUhf2FyA2fxz6RhmD08ivPJfmkVnlczGYOQXr82nGA==
X-Received: by 2002:a05:6a21:158c:b0:a7:16c4:d2c4 with SMTP id nr12-20020a056a21158c00b000a716c4d2c4mr34216553pzb.47.1671143459112;
        Thu, 15 Dec 2022 14:30:59 -0800 (PST)
Received: from [192.168.0.23] (q014251.dynamic.ppp.asahi-net.or.jp. [203.181.14.251])
        by smtp.gmail.com with ESMTPSA id 62-20020a620441000000b0056d98e31439sm98458pfe.140.2022.12.15.14.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 14:30:58 -0800 (PST)
Message-ID: <581e0725-93cb-b796-e2c6-455737cc8ea1@gmail.com>
Date: Fri, 16 Dec 2022 07:30:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: nvme nvme0: I/O 0 (I/O Cmd) QID 1 timeout, aborting, source drive
 corruption observed
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 axboe@fb.com, sagi@grimberg.me
References: <fe013f52-ac3c-4be2-6f1e-e68fea46e4c2@gmail.com>
 <20221215082344.GB3816@lst.de>
 <d4c4eea9-e573-df0c-cca5-536bcff6c0a9@gmail.com>
 <20221215090941.GA5062@lst.de>
 <3c22a234-f042-4859-a3ab-f911874696b1@gmail.com>
 <Y5tambspBYRHU5B4@kbusch-mbp.dhcp.thefacebook.com>
From: "J. Hart" <jfhart085@gmail.com>
In-Reply-To: <Y5tambspBYRHU5B4@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221215_143100_673301_027B315E 
X-CRM114-Status: GOOD (  13.37  )
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
Reply-To: jfhart085@gmail.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I've tried the obvious ones and that didn't help either.  I guess I'll 
have to give up on it and return it as defective.  I'll go back to 
normal operation and to try and find a controller/device combination 
that works with the linux driver if there are any.

In any case, thanks again very much for your kind assistance.

J. Hart

On 12/16/22 2:34 AM, Keith Busch wrote:
> On Thu, Dec 15, 2022 at 10:33:30PM +0900, J. Hart wrote:
>> [ +26.890018] nvme nvme0: I/O 0 (Write) QID 1 timeout, aborting
>> [Dec15 21:35] nvme nvme0: I/O 0 QID 1 timeout, reset controller
>> [ +30.719998] nvme nvme0: I/O 13 QID 0 timeout, reset controller
>> [Dec15 21:38] nvme nvme0: Device not ready; aborting reset, CSTS=0x1
>> [  +0.014796] nvme nvme0: Abort status: 0x371
>> [Dec15 21:40] nvme nvme0: Device not ready; aborting reset, CSTS=0x1
>> [  +0.000024] nvme nvme0: Removing after probe failure status: -19
>> [Dec15 21:42] nvme nvme0: Device not ready; aborting reset, CSTS=0x1
>> [  +0.000324] nvme0n1: detected capacity change from 976773168 to 0
> 
> This looks like your device is completely unresponsive: no ack to IO
> commands, admin commands, or reset sequences. Unfortunately these are
> typically firmware bugs. Without additional guidance from the vendor,
> we don't really have many options to try from the driver: just disabling
> some optional power and performance capabilities, though that often
> doesn't help either.


