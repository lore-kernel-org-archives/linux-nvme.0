Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6B3FA3740
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Oct 2022 13:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FW8SDDyFoIgZ11fCIDEb5/njIXheP9SuXFNwX7gCdRo=; b=JapZ+cYd0kMQJ4w06ZGo5NDKIn
	BGixO9LAcGCc80HXbaUnzfiLbfmMeZs2Gu9/ax+TxtnX0xWpTqPY5GN09u7S5zRouH2eImM1aYziZ
	1RpJGdcFVPxlDTliir1l+/OJxMm0h17REAaAhw/ClrGaNSNTtOUDHVne9dW7JHJXC+S3lobbLAclr
	ui3bDKo7ZJk4UhcnVV8x9yxgRFuFzNtuVwe7XHLMqumImRb3RuRI7pVbDT+PrOZI1fDZLkUnlVlrs
	2PHJJQyMwJu1wOr87MU5f7GazVW4KrX/YP3TSbIGfz5SZtx0nd4B0DF9S5m336le7LV+NHVgYtFR0
	0kR2RjXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo3H6-00DgyX-Oy; Thu, 27 Oct 2022 13:50:24 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo3Gu-00Dgt9-7s
	for linux-nvme@lists.infradead.org; Thu, 27 Oct 2022 13:50:20 +0000
Received: by mail-pf1-x434.google.com with SMTP id 130so1565747pfu.8
        for <linux-nvme@lists.infradead.org>; Thu, 27 Oct 2022 06:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FW8SDDyFoIgZ11fCIDEb5/njIXheP9SuXFNwX7gCdRo=;
        b=ray4nfHffyq7wCaoQJ9uQlQj/pCf7S6TJAXjZhh4ad+oNuCYd/SfDjmc77hoNQ/4l+
         4gyVN4X3rutBPHsezP22Dj+xroj0007DMiBKb3G7LW0DA7ZcDY2cPV9dAZD7s71eIbwg
         +Ebqmfhho9ibASmGzecwP/y8ZVkp9GPDzjUaAsMqLraNIXrLDCSPuFemw+5B4CqpUKVj
         XZeAodAb7Zjw70OddrkE8aSXCDupItRibKvLhphxLfqUN5TA0TlzKMrQzWZFxAZVjQqs
         7Khnir2K5Xf1du6SQs+fPa5XNIGXUvvGRyiIi6CvsmlpxOphi9YHoFokDQXfSnGQCF72
         Oteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FW8SDDyFoIgZ11fCIDEb5/njIXheP9SuXFNwX7gCdRo=;
        b=yz+wG7hlOMMLgqYSjyz68V3A1aXM7EFzFOGfXgcBAxlj19N3i6TP5fC2daZ4LsQ6cI
         zD1FCgjSMzS+/GI5g57KmNZInNoBrjTyE5uhBlvAB6jMp82GIqG0cqPQOAFLDCaZBBiU
         47/obIENW4ucpyDuUhqblt4kHP2UaghlMMiTaCXs18hNCnluMCLUnZm5acR85Q3hNLTE
         eO4YRGgm7001kGF4Q9JN/LQtDJ+tX4Bm+IvI6tATUGQVw/BBPvxgkd9CaBszPG/5RHij
         IBQr+zW/cs+ykFi1NafU2km6R7l4ph1p3/XifhMr6lFfVeWom8urhFb2+Masy5GNnTXv
         mQkw==
X-Gm-Message-State: ACrzQf0PGQ2VidDO/XUtehBpYp1l25U+9K5W3nGlMIpzGHo6rQ7EbGp7
	LuqPf5RxA3oxFvTseCkqx4w67FRLfOQS85kg
X-Google-Smtp-Source: AMsMyM6/UqY2wxYkRITNJDsA3m1jKb4ifNK/phsUmeXLP92Q2pWQ3mpu6Pos+qOD9W1NFosMwxYe+w==
X-Received: by 2002:a63:ea4c:0:b0:46b:2772:40a4 with SMTP id l12-20020a63ea4c000000b0046b277240a4mr41589073pgk.342.1666878608384;
        Thu, 27 Oct 2022 06:50:08 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902d2c800b0017f73caf588sm1226367plc.218.2022.10.27.06.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 06:50:07 -0700 (PDT)
Message-ID: <7cb31ceb-94cc-40ae-95c2-7e26e4c9a8ac@kernel.dk>
Date: Thu, 27 Oct 2022 07:50:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [GIT PULL] nvme fixes for Linux 6.1
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <Y1qL1zsNFc6w2WTd@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y1qL1zsNFc6w2WTd@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221027_065012_362577_6AFA4CEC 
X-CRM114-Status: UNSURE (   9.19  )
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

On 10/27/22 7:47 AM, Christoph Hellwig wrote:
> The following changes since commit 02341a08c9dec5a88527981b0bdf0fb6f7499cbf:
> 
>   block: fix memory leak for elevator on add_disk failure (2022-10-22 15:14:38 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.1-2022-10-27

Pulled, thanks.

-- 
Jens Axboe



