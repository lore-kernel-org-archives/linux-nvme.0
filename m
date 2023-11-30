Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97493C4167B
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Nov 2023 14:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1XcxXYLpcvgiAa6or3y3pSoF/62eN2M1lsHonMpXalE=; b=koH7MRQJxsjmxz57ZZhcC9Fjx+
	Qazpg31noUrFJnDyLwNBvk524ZtL2y6aqzRUeuAzRkBj1zG/C4u++rDImJujoEtUbIDHZJMWxp/ii
	aysDgVwiL/Dp1GsUbYOamF7vbkieyzPmv4mtngwBOXL1jXNLf7QGHrkFEuiqw1aIAKRIMdFUbx2EN
	/BxUmh4OKo3TPmk/FCzuIfW27Vl9qq/2avZJlWgbwvB1t9PnotL8RSl5wGCbhqoDAZiASkJA4EPCN
	nH6wWK9J4IpYW2Gc+kgQmqBlHaOAMWbLogLNM2cWZWmc6oZZUUm+nWQX6dS7/KJmKYX3IKAVem+9A
	de+ajRmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8iFB-00B8Up-01;
	Thu, 30 Nov 2023 14:42:21 +0000
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8iF6-00B8UW-0t
	for linux-nvme@lists.infradead.org;
	Thu, 30 Nov 2023 14:42:17 +0000
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7b3867bfcc5so5841739f.0
        for <linux-nvme@lists.infradead.org>; Thu, 30 Nov 2023 06:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701355334; x=1701960134; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1XcxXYLpcvgiAa6or3y3pSoF/62eN2M1lsHonMpXalE=;
        b=rzEYDmNnO4nOIJ7/o/3RxA+300ywtwxdo5qBEx+5rvDk4qBOq4QxBvwRL5uYHlLDrw
         0Ahjhg7JZYnZ3t0AtB7/T5SbzLToKKU1leYE0VSQDKYYj4qG4rwFt+ig0SUS43ibVlk3
         SnO1K0pmSCyLJwLFOawfttwOxFeQUOLibnpo91Ll2sCACjt5xVfbt1wVLHkRke5L9maG
         vDKgjl/2SPsooLhgxmjQ6rpVFTPMU2Le7qUgDn+2v8B4oGxwb2NVRYpLlMxIJS1dRHP1
         y/GOYHDgTBm7ztBdch0skzzPxoyilj62svZ5S4D+whKDxlHWK57ZsfryoXBkzTxK/N1G
         iUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701355334; x=1701960134;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1XcxXYLpcvgiAa6or3y3pSoF/62eN2M1lsHonMpXalE=;
        b=gVR5/Rz17P8MRmrVw3SjCM3gw1kBo8Jpavgp+J5GUQ+QwroH9XNW124Mtc5mimg59r
         nOKlYTvIwluNeADxJinehOiRJNX17g82PMcrldv5OXpYo2AqVpsad6Br+wN1A2KElu1d
         eFzwfRLzKNk3DpSBlnopAcz4hedn450gjl/YAqVGTVz6ZaEgVFL4wc5v2Xh3AuKgec0a
         dExgdNium9Vn1O/VU8bfSeXJZe7OesYOjxTbYfETa0V1t+5FwQLIlU/OJPTSDcS/3wnF
         qTdYI7it9zkv6DUZij0Ri6KR6m7uz9GzfrxsSUbpWt2xGcZGbrKrVqwkd/ddESAUM7LE
         ZDnQ==
X-Gm-Message-State: AOJu0YyxTsSkIxhBhdJsVVIv1A1SJR54ViiuVmeM/IaUrhOHERXnRD1T
	VCaBMN9SolS/7nLUBQ3KgL2bZg==
X-Google-Smtp-Source: AGHT+IGfi4V6SGbqV7Zpgk0+cfgZpdX7HoHZb5NF1CX04/49d4XJ7EWcMgf/VDjUqHTBksqPan8kvw==
X-Received: by 2002:a5d:8b98:0:b0:790:958e:a667 with SMTP id p24-20020a5d8b98000000b00790958ea667mr23810253iol.2.1701355334354;
        Thu, 30 Nov 2023 06:42:14 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id dq35-20020a0566384d2300b00464556794a0sm317588jab.3.2023.11.30.06.42.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 06:42:13 -0800 (PST)
Message-ID: <690fe488-ff5e-418d-af45-fe567e02ff87@kernel.dk>
Date: Thu, 30 Nov 2023 07:42:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-rdma: fix nvme_ctrl_state() conversion
Content-Language: en-US
To: hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
References: <20231130134210.133103-1-hare@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231130134210.133103-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231130_064216_311964_F969095A 
X-CRM114-Status: UNSURE (   8.96  )
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

On 11/30/23 6:42 AM, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> The argument to nvme_ctrl_state() is 'struct nvme_ctrl'.
> 
> Fixes: b59ea0f40072 ("nvme: introduce helper function to get ctrl state")
> Signed-off-by: Hannes Reinecke <hare@suse.de>

The kerneltest bot has been complaining about this one for a few days,
it should get folded into the offending commit however.

-- 
Jens Axboe



