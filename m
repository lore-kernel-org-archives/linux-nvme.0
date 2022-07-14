Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B41C43334
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jul 2022 16:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j73152At3Tez8Ku+H4U593w6FOIkEmXuldDavt74jYo=; b=c6SeOZC9GqPqWW/DOX1IKuj7VM
	y5cBnn6kz9WSCRpyUv69lIbmFikIGT41JtYABsjYXKNc1rfqqIVRwoV6ZMvhBbLPzxAkQDNT1YwyN
	1MY0VCj6+cFoxqFzJm99PfcIgw1mHiR6dYa2+SOlkj2Fv8tNlwy5mNZHEH2TvHIhZGdpL3LKYeG4q
	FInN2PE5APkUWenzSnhmPSYJK52wRZMTu/WeddCUQ28cXeJVu7l7VQtOxmwv+INVzNrZn71aH/xOd
	g1KNwvkAY4JE+ze8es8D8r92B3mQDdcNZTk6zA6JFz62Rn1qOk0Ro6hh2KLj0F4E32auZYT9DSgu6
	YobwKfrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oC1jj-00GHUn-Fx; Thu, 14 Jul 2022 16:30:47 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oC1jh-00GHSZ-4l
	for linux-nvme@lists.infradead.org; Thu, 14 Jul 2022 16:30:46 +0000
Received: by mail-pj1-x1031.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso9143280pjc.1
        for <linux-nvme@lists.infradead.org>; Thu, 14 Jul 2022 09:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=j73152At3Tez8Ku+H4U593w6FOIkEmXuldDavt74jYo=;
        b=E+ZrkllF13Yqbcs1uNnH2jjnHMT80auNTYEwrH3XGniySbcAACKd5ogvvsdrNp5tiH
         IOo3E2VIKZPfTWPAtp4s+s7IloMz6BUulDqleWS96wxVXlMIEIIMC3oo5bfqfT7UqXRa
         74vfVdm9H2a3BveGtIsrsxcUQORrFpx+Gc7aKrCcI9jFAxggsHYb+GHVEW7WDHuVfcTI
         GfOWnxNP1xca5GNsmY26wPCgQ25JYuP6nz2J+ne2zHLtLib1pIBZgfP45yNr3BXbUiST
         du9OsVq9rYm8N37nr1QlSb+06/WM9VZ9m/yWKYmbz0gZCfpoiWMw8J/sraSwGuGcLSFX
         Fxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j73152At3Tez8Ku+H4U593w6FOIkEmXuldDavt74jYo=;
        b=G0PhcuYL89H+M2QRGdLEqNAMJtbfdJs+Ek4t6XeaAZA0B3TTOIyKOok4wpz29yitk7
         sivbSyjrxskEZUT5fa4z4q7pUVaArkoepYf3B/b1TTaxIvMc3Ua8yM2W28ggaYmePfvp
         CbxEgH4boL8T0O7jKYVh99QmysBY9Q1kb9GpKiBkmK9BP18IGJu1X5zF34hyPmRVKoYw
         MAT1J23EeK0nRL+dRL2xSVqVpccDlJw+kcRGmNxwnou03SzoPrjqA4NMZGozHiA2c1mD
         1eznkTWZ1+SCdWAoF2/xRHHA7TnebcsksjWM6xvbmM+gZs47JLQBv0nfBsbWmJQqRJe2
         dbTQ==
X-Gm-Message-State: AJIora+HqUWS+DxMvIpwhSEbv6Lq1CETpnwc/Ej6LvsGrrzOX+zHACkf
	y3VJa8wfw75rElV/bTeouUi+CQ==
X-Google-Smtp-Source: AGRyM1tAcOJzsWy+ScsCmtUZKsxabSBS8iERcX/7YK6OSUV65sWQU7PAE0VP4P1XIREHrjomgIJ6HA==
X-Received: by 2002:a17:903:445:b0:16c:5d4f:c329 with SMTP id iw5-20020a170903044500b0016c5d4fc329mr9197186plb.104.1657816243043;
        Thu, 14 Jul 2022 09:30:43 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l1-20020a63da41000000b004114aad90ebsm1579313pgj.49.2022.07.14.09.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 09:30:42 -0700 (PDT)
Message-ID: <f67a182c-7f56-8e6a-9a0d-5b333afd1135@kernel.dk>
Date: Thu, 14 Jul 2022 10:30:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [GIT PULL] nvme updates for Linux 5.20
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YtApX8HC+BcN3NvL@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YtApX8HC+BcN3NvL@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220714_093045_192309_E070B1F4 
X-CRM114-Status: UNSURE (   9.57  )
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

On 7/14/22 8:34 AM, Christoph Hellwig wrote:
> The following changes since commit 3b56590b1715b998cb5c73a5bd2e9d340ccb42dc:
> 
>   rnbd-clt: make rnbd_clt_change_capacity return void (2022-07-06 07:38:40 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.20-2022-07-14

Pulled, thanks.

-- 
Jens Axboe


