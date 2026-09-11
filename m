Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E89CC88E4D
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2026 21:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4+gZNPWyIJ3mCtYhhOmkl1E9lPQeG02urbagnaEJsd4=; b=LjbJqdNi6F86ciIFtclkwFcjCl
	Yms5c0Hrmw71cujxCJ9SjqJt/APhY7FFsA6uMyHjqScEDh//ED+24PoUEH/Fbh6JFN8Ye1J+gw9YB
	mDAwHlXy/USvIDtU5vPabYmDCTfNxKwrTW8nnC7Z34HgbO78/LFi7q+ReTet4q7ELBXOlQRkA7QOC
	nJy9fP7MO/EpVChTy3MdDdktRLSVQaY1/vx8BxltLayuIS1D9HFGAMQS4LvHD3M/g6Og6vHAj5JxX
	Ynl/P3eT13GQyZ26qLb+c685M0/zchaZzFPyLGiy8U4654ZdY1NUD1Jku5o9+SfZ6sGrw/uUt5u2N
	IwL/vjdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x58bH-000000009R4-3IuI;
	Fri, 11 Sep 2026 21:15:59 +0000
Received: from mail-wm2-f12.google.com ([74.125.225.140])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x58bE-000000009Po-0p7c
	for linux-nvme@lists.infradead.org;
	Fri, 11 Sep 2026 21:15:58 +0000
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e66390995so164885e9.2
        for <linux-nvme@lists.infradead.org>; Fri, 11 Sep 2026 14:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789161354; x=1789766154;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4+gZNPWyIJ3mCtYhhOmkl1E9lPQeG02urbagnaEJsd4=;
        b=lRAq+g2nIZ3hjycqqKA7hZDLtsJ2hmCKKCjMh10dU01o1GilwyCmdCWv0tCmB+1cep
         LDsl+dLRF6+CaNlpq7eJoDLboTQ8d8D6bP/Eyz4L+8BDEIXiitaVdvpAtzR5JCp6xNBF
         /bkFjjd02WVW1rqDKJe45F/uy5YYE+jlFEi231p8LYocAxpY+skO7VTRokuejdZ9YViY
         JwfBMhBaBzIihvesSPVLmnMycbpHiyo7u7RHKi5m3BgCOs8OPBDzZYdTba9HiGHQJiCb
         St0uW3U1Qzd2wYRTZ85/66lkiPYcpS9qHlD5Y99S3aKnqUAi9TZ/OnNMqOx5SCP770Ez
         QSQw==
X-Forwarded-Encrypted: i=1; AKwUvByXpEVyRohkdJ15o6th4VDiStcnduKLD7OVvyOwo6a9U76rZ8uOIAijvG6zxjuPjoBo7l0IR7s5PBTQ@lists.infradead.org
X-Gm-Message-State: AFuF++kSm6TpmUNoDgefclW4YjPHda/Uqaer7iTfIelc1Ir22z84XqwN
	V98jz01HMcJ5H3W/LQvxhlERcTvDe+w+SDYT/JGWa3gRyg/J8vClYJTbfD0T7HF9
X-Gm-Gg: AYBFou3GmuMlJmjtTjeFocLOka8g8yPko8wMqD6PnIDRq0OF3bQ/oMs/nn06lXwZl6O
	lOWitKtMvBBajyJyRf5rl9GgRpXQ3v58YQ7kbmCI0azV6hh0na1Gc2G9KWO+uFzoZyQD3lDaUPo
	NUqB475bTCFHGxkqa3Mvedb1NNBW5RdB8k+zil2GFt8Ws5iratOfWXOc3RMvpdGy28Aus0Ka0g/
	ZxukwKcHI6zsbsCyfHmJtiCW3RSpmdGbVos3KwYp+vDjYZ4PN37LNJfEg48YL2YzfKwToK3AYNU
	qsUjwUEeAhya9cILYG/vcIwUmYpesfV80sDmmC+7h4ep4/Fwi7gCo/6LZ+NhDqDK6SA+fzb5+Z/
	E61vK7OsIAxPaau/DcV0Exwf+UT3EN7n9BTvJgFgGPLj8GPVLVsqrDOtvfkpGAodrrGZhS7whxs
	F3Fm8X/dOw3T+rwhdVorhriSTDH1L6uV6BwTXVn2KNe3vYTAAKk6mAewWnI8av0R9dCm9/AmG9w
	qyMs33O0sbH8vuZ9lWeQJJtbCYKBj98
X-Received: by 2002:a05:6000:491e:b0:482:9dc6:16c4 with SMTP id ffacd0b85a97d-486f6bd8b93mr285658f8f.1.1789161354138;
        Fri, 11 Sep 2026 14:15:54 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33ebe4sm7149818f8f.14.2026.09.11.14.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 14:15:53 -0700 (PDT)
Message-ID: <d040bea9-711d-4638-9d64-50516709b41b@grimberg.me>
Date: Sat, 12 Sep 2026 00:15:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: fix a hang on queue teardown with data digest
To: Shivam Kumar <kumar.shivam43666@gmail.com>, linux-nvme@lists.infradead.org
Cc: Greg KH <greg@kroah.com>, security@kernel.org,
 Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, stable@vger.kernel.org
References: <20260901014718.2835558-1-kumar.shivam43666@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260901014718.2835558-1-kumar.shivam43666@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260911_141556_237433_9DF0C0BE 
X-CRM114-Status: UNSURE (   8.22  )
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



On 01/09/2026 4:47, Shivam Kumar wrote:
> With data digest on, a command that has received all its data waits for
> the digest in NVMET_TCP_RECV_DDGST. has_data_in() is already false there,
> so need_data_in() is too, and nvmet_tcp_uninit_data_in_cmds() skips it on
> teardown even though it still holds the nvmet_req_init() reference.

So nvmet_tcp_uninit_data_in_cmds  is where this should be addressed.

