Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06507EB48F8
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Feb 2026 11:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wCldroI7429Qp90gcUTtFsnAvy8jQqFz5POUC1/x6i8=; b=oZP7rX2Nf0gJHWGlQXGauUzbRf
	6o0ygabiXZ+736N1D3RT2QtXxYXWcIw3e2jQNzXfQLNwKOzUBe9Vh/OOAne/N5EryvtCDt462YZRT
	T5Aao2+jqH0Rh1d82Ulru4NiqL/0s4g61ZLoGy0OuolmtFMrPtJbAUCc781QWDGKExRoAbA2iJxQC
	b37PQW4LOF+oQrUDNLLhwaar8rC2gQ4xGJzJPEV6neWvn3fqCobsVWqu9t665i+wLboUCcwqDXbm1
	wEYj7l4EKsCs8taa/J0C/3GEd+omm0gRur/R4n3tsSQKU0iWmL+C2UmqKIJfTmcmgRV+2y4fHtPVb
	dMNhqhEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqUql-00000001zrW-0rkn;
	Thu, 12 Feb 2026 11:27:11 +0000
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqUqg-00000001zrD-2jF5
	for linux-nvme@lists.infradead.org;
	Thu, 12 Feb 2026 11:27:08 +0000
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-45c9f47e1e8so2652648b6e.0
        for <linux-nvme@lists.infradead.org>; Thu, 12 Feb 2026 03:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770895625; x=1771500425; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCldroI7429Qp90gcUTtFsnAvy8jQqFz5POUC1/x6i8=;
        b=xFeJaCameS40DFdYStUXrX5ai86rylzg5DSgoThp9Pgtp6ywT8p9eWSck7b+/g1cC8
         yPuGIWYzFUmOh0W0gu8yo9tDj5OQm5aXtLbti84P9sQ2AgDhNYbzZldOrC78MrttNayf
         XTZgw30D5oBxn8xhGcatbQ48jJs5YCnhOwhIkUmafIsWjpEUqYiR7b93eiyRiQxqedUP
         TdxtoPQ/qYXo7iOv2MGmJtoZssFm76oHgj9qlaQW8eVqD4nyX8vIxeWhl5pUKZknknol
         +1WRjBpDTPTIhrIaa5FzD5YZpJBPSsSakUfKnhGiTlsyUq1efAOw6BbTjrN0OsqG4H9x
         QFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770895625; x=1771500425;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wCldroI7429Qp90gcUTtFsnAvy8jQqFz5POUC1/x6i8=;
        b=K7v+yK6L/QoYIkfJd8Qbq3VcyRb+7rb+pxx8bBHJkbrrbataqGQsmAQe7VCSu6HsV7
         E8RG6NU0kyZ9HPwVd94akp2pGhQ32VqB8XYaouQo8MqA786VIRPJbgr6cF14EHKrN47h
         yvFT+N+v47GPLYZepM7S5cOudnd5A+SP0dghd3OxR328iOynAr0J901r6hqv5bAdIBHC
         sGnP+oLdtk5+ddxb74LV6SXVpBQedu6OC3SEfKi/RULhTbUe2JpTuyaOXQnVZ6CLmC1Z
         UqW07rAcg/T9rrgJdOuIueqdtZe3tMWZjo96c0SN7byl56nvJG/dSqss67o7Y+aEofsz
         V4tQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx32qTbRWa5cbYyR/+lbWXs4+rfAoOOBjGyaWF6YE9tLtAbhvJbqrTDnRMjSv5F+DRW6DFdspS9Ijc@lists.infradead.org
X-Gm-Message-State: AOJu0YxCJDZa3HTwVaTI58b4HhCUz67DhKjdc9YQmPuVSNzxI2gVel82
	NA8IORnMVaQYp5Jhcu68+RsbOtu6WiZnEuMsNkn2RnzhvRMXB4mNMZynkwLjsYiR06M=
X-Gm-Gg: AZuq6aJOCb/IhJHCfPqtJbkbQQii2Vkh2mfNdyzCAr6HgbeQyg47ckNjh+2iy65IFx6
	OzVYtjxkYccDHLQHG9HVtXUmP+nEeKi8hucQO6P+WdXP5xXqDFkIq0wtsuppJ3HmRkQRRb4OvE4
	vy2oDdtFm9l/hb5LUdtOip9nEY+RZCF+UpJxZkbymO7xxh3HxNzPAQNF/eysxO0zV7M9WqOVV8B
	ad599AvJkddlLVMqffiVF5n8S2U15HyHmfWWfXVvA/Ef0ZjGRGMJHUdGghs8y2cvQn1qkLVInvt
	qQWL0owtMSKBfe3Y3jo0wOwcK0qhdXQYA+wWW3VerOemAYL3LWKCPaXODGMKxKl86WVEC0URWrW
	bKrhBijpkdm+5jtAdj61w0RffOPqrc/QC7GH2Sf7mWEO5zIgCbQLdzvPB+96WfLBCCBZWceH6LA
	Ty6HwBPXOs6xLihxuMWQxO9D4ebMJtG1qmf0JXuhqFWj8TINnDOGNKuOKUfDZ2Fgl6Kd0spSyzX
	iyS
X-Received: by 2002:a4a:ee84:0:b0:673:e6c4:749f with SMTP id 006d021491bc7-6759bf89abamr817782eaf.76.1770895625029;
        Thu, 12 Feb 2026 03:27:05 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6747293e4c2sm2232685eaf.2.2026.02.12.03.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 03:27:04 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linan122@huawei.com, song@kernel.org, yukuai@fnnas.com, hch@lst.de, 
 sagi@grimberg.me, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-block@vger.kernel.org
In-Reply-To: <20260211204438.22568-1-kch@nvidia.com>
References: <20260211204438.22568-1-kch@nvidia.com>
Subject: Re: [PATCH V4 0/3] block: ignore discard return value
Message-Id: <177089562347.419890.12862098263545903682.b4-ty@kernel.dk>
Date: Thu, 12 Feb 2026 04:27:03 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260212_032706_721960_400495E0 
X-CRM114-Status: UNSURE (   9.27  )
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


On Wed, 11 Feb 2026 12:44:35 -0800, Chaitanya Kulkarni wrote:
> This version has remaining patches from the original series to change
> __blkdev_issue_discard() return type from int to void.
> 
> First two patches make md and nvmet drivers ignore the return value of
> __blkdev_issue_discard() call and last patch changes the actual function
> return type from int to void.
> 
> [...]

Applied, thanks!

[1/3] md: ignore discard return value
      commit: 699fcfb6cb80a9df67fd2086a1c930d196d709f2
[2/3] nvmet: ignore discard return value
      commit: 38d12f15c4772b5383b1249b2afb0d206a430f0f
[3/3] block: change return type to void
      commit: 453daece381e60df20da16c49ccc6a9bc5c6515a

Best regards,
-- 
Jens Axboe




