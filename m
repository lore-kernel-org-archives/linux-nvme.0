Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7925EC43334
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jun 2022 13:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=POgT05wM42hBLTc+NksssttlaUWlhKOkLi32+nH5MUA=; b=wejRmy4WKbzVJ3GHhMVNEc30ba
	rr+SHRn0CqIZ0m1BSOJlHYfG4K7fkj8WkP7HdoJm7b217qrWys6zXQNMzoInhAmV7pMpQDGNj1Uoe
	p7oe1HWVykFj7Ncxsf+SCdxRyQS3aB9Mc7p++Ze+SbCdLw8oIubP2e9iSwnb7s4NvBtKhmJ+suav0
	ThDnSGtcIIGPzPthx1K6OruaBqniBd8q+tGNuJ30pphyV6chVOGuRsk0snxvPHwrSxmalaMMIl6Rk
	bs0OuHYDnccZ0R8X8aff71HQPVDpCz6gvmv5l/to88BM95RaUYrlzS6N7QuA5vEL9T1U26ZR2U3ia
	ExTwaTzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4N83-00FOv4-EE; Thu, 23 Jun 2022 13:44:15 +0000
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4N80-00FOsa-0C
	for linux-nvme@lists.infradead.org; Thu, 23 Jun 2022 13:44:13 +0000
Received: by mail-il1-x136.google.com with SMTP id i17so3623090ils.12
        for <linux-nvme@lists.infradead.org>; Thu, 23 Jun 2022 06:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=POgT05wM42hBLTc+NksssttlaUWlhKOkLi32+nH5MUA=;
        b=LqT+L49PT3urDtzqdiAjCmeWHPWxeUeLUrMno1wQER54DeyWdKLjiJU/0cm4KcCD5R
         6YN0T8weshpuIVqLu6Se+VTirg8aDKKBQpfgyIy4W5tTtz477MEMyv9RQwRak2a/U5bP
         nR2cPhhS/f4eBARJuS7XSck2aM5pi5SU50/XKySFdJUiB22chyV0eIBfS9CDRp5ckbbn
         06ZIp/MtyqMIo1y+USIbBRL7D+0B7DQONHC+PpkB6ssvc6Bfov5S6moSAyQabD7sSMwC
         rfW/9R7Gslm7MDMGA8Mk32RO29DqoevchI7MTbfXFPGAAWCrSwZr8Vz0vn3C8UoQ4Xxw
         V73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=POgT05wM42hBLTc+NksssttlaUWlhKOkLi32+nH5MUA=;
        b=x1e7ns1OfoMUwkAKas4Mww5v6MdwGRpo17yrdz/QJ7dI9uZeYFpnmX0Lon3QBjVdb6
         aVJ7FKwMYAFEL/Q3Ev2peEFORppUSFvMtU3MxJERzC6k0nP0xMJXpDYRTLROWt45lZVU
         9eiLtZ4AnW8UMgtamZfly9ZKDmLuJm7wpG6YZuwClvm4mBJ4uOphweBPkgL7bvZ9/QyJ
         6DGxmpLX/Y+isTGULOrAog5Aj2RJr+IU/qb8yqH7imkfq+rYmESAgpPWgnoE3HgP3vGt
         H86L8ujI4H0hnt9PrAwRBG8NfjAAy1+q96qvGvDpTea988KdLyDxt3aVQrjyOBMrFU4c
         cOww==
X-Gm-Message-State: AJIora9im6r2C3QAfkHfGDiHp/JCQXDusHUJknoZtSE9GSPmmGKM5Dpy
	jvTNjxfOeex6474VTM1ez+kBvw==
X-Google-Smtp-Source: AGRyM1ua8L2T3z8C21vx8QfT/rpIV/U6cTgN7AXoTVVJRBdxGrpID0+DqzEaZGsUe6RGErw8msoGmA==
X-Received: by 2002:a05:6e02:154a:b0:2d1:d151:3c26 with SMTP id j10-20020a056e02154a00b002d1d1513c26mr5122360ilu.24.1655991850162;
        Thu, 23 Jun 2022 06:44:10 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id u135-20020a02238d000000b00332044db2aasm9856481jau.95.2022.06.23.06.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 06:44:09 -0700 (PDT)
Message-ID: <49f60048-1307-6860-794a-82020c9f2ffd@kernel.dk>
Date: Thu, 23 Jun 2022 07:44:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [GIT PULL] nvmes fixes for Linux 5.19
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YrRpb4LlxotvjCML@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YrRpb4LlxotvjCML@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220623_064412_308454_46109B47 
X-CRM114-Status: UNSURE (   9.83  )
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

On 6/23/22 7:23 AM, Christoph Hellwig wrote:
> The following changes since commit 2645672ffe21f0a1c139bfbc05ad30fd4e4f2583:
> 
>   block: pop cached rq before potentially blocking rq_qos_throttle() (2022-06-21 10:59:58 -0600)
> 
> are available in the Git repository at:
> 
>   ssh://git.infradead.org/var/lib/git/nvme.git nvme-5.19

Usually I'd just turn that into the right git://, but it seems it's
missing the signed tag this time too. Can you generate one?

-- 
Jens Axboe


