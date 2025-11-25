Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8044D0E6E1
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Nov 2025 13:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=; b=ljblsvkqvpfQ4e51VpofvZkPkF
	k3xoxq5SkazBGBkGkyyRXos0cluklWbmlWrldx7ZhBtECC6jIJE5DaRgXksGOG65fl0kqTRhp0gMq
	p607epcNBepeygG3ihVApNnJ+5ibhZ7DnhZU+QkdlCoVlIRMHPmlDh1m9YZpRzZHHYz0XZnB5wAOo
	dI8daFoD+vQkOy7zA3LvZPdpVPLR9QpsBWgvuGrvl0o7+x2yWMHftsXu0hJeVeqQSirEPCd6jqWvb
	jwV0jifmR8RLOr56v2HyQI//NnunoNQJ0bRcPgM1tqYlKx0oDeH2I4TcdEm2Bx0QuWgnHva7qVqq9
	AmqAY90A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNsz4-0000000DKqx-2yHn;
	Tue, 25 Nov 2025 13:21:30 +0000
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNsz1-0000000DKqH-3OKD
	for linux-nvme@lists.infradead.org;
	Tue, 25 Nov 2025 13:21:28 +0000
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-6419aaced59so7580590a12.0
        for <linux-nvme@lists.infradead.org>; Tue, 25 Nov 2025 05:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764076886; x=1764681686; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=e+CZBt27DM073iDJ2eePKR1N8Fj5L98Ka3mimd7lpGKWosE3UmTOzY/9vtpOnWpvXg
         kB0pGazBH9y7wPu2XP7LMGmyQNFZa4X5AHAxeK7CkLe1OS6oj8Umy06ed67bcxBC0Rgp
         1AFChso4xDI4nDNY8QMsglk8MStMAocfIvczVBThGnmRiENvPqA92CQ+jOOHyklp0TjM
         65ad0FmXLVBQqBqmog/FZyWmqQXKi4K1NZl2iZV84deXPeJX37mOguShDNjO0cBmohmu
         eGSAPMQQLvfvNIHR7Sz4OA6r7MQGyurKoOgnRsS+UP6EeCwOBbFJmlSxCl8hivyTnnJa
         TQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764076886; x=1764681686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=WXzjkZhtMWPVZhLmilbRxSvUoNzFm7c3g09tHzLWp9GQ/kcap44TDMznr+Tzqe8FGv
         BsOnWgLB5lhFTzKZjW9TDAvSHevlGiNfBw1hZLxWsoQ2HD/yoOv8WMShbM5tYJ6IXklD
         1IdbyVZXIb4L12NtIEgZs6wxy54WfDo+bizJ59PCkhUvyW3q+GQxqsX7NKS0p1ejJTKl
         sL/QMinIVvxp1HUeXfbX++GNfF2ldE7Q3/pLDs8O1Fwgq8XqrNNp3xuXi9oGe2VkbxGc
         XscSjRxTWnmqHWwP56gyqOfFNcd2Hs7VXERs/OFArlovFPuQS/Hj0OEHZxkvJQCEuyTc
         oYaw==
X-Forwarded-Encrypted: i=1; AJvYcCXU2tddywYGk4ToBMgby7RA+YoVnjrpzxhlK7v1xT0ea5YAgfRTBwPqRbP+msQTTX8a8SrZo36FX6uA@lists.infradead.org
X-Gm-Message-State: AOJu0Yz0WKcgnEWpTHPInmWp47yxlJM1tVWF1MFURk0lUnhC2U1vrU4n
	aPR76dvcfxj74w5EZC1XTA4YhB1+Ue6gUt9T0aiv/edVljNDv2KcGAo83UlMCo+Mk7xxQiruSBw
	o6A8NYzYAa2I64CsdaEvbFUJHOsxdiA==
X-Gm-Gg: ASbGncvSVYCAqRojm/TWWQdh69zqP+DFfV0SBAOVaLxQntLYKeAcz4vCYT1TGaN7k3g
	l5H2y1IRdt1aqZ/E2FCzc7orkmeUBcDVjqw2rLPJSlGbZmqT4yVC03Wkg8RfO5OYjpeEmOf8tVZ
	TwlVfKopKGUlLr6wluKzvmv8ni4Rk0iogd7sCVE7JY2EvBqnUG9/TQDDlUjrK/42E8LXDrOEzWM
	mqqfnIsxmFfW+faBEUIrwxH5kMrheJfSP7vCH1GK8xc5DDqsJW7k24WN2Res9vGMbOZcKDaPsE+
	BRnmLZwS/LsAHmAyt7fRXRZXI2Eq0wC0aXZMlJJAKxZ6Vd/1QVRbtFA8ow==
X-Google-Smtp-Source: AGHT+IFdAjUbTCRihlcnMQbRe3kaTpxY0zS2TJvPnabL+VI06FANQqQrLV6dY7bbefHQ9hiFBD+KK4yE+DNgNHPMVMo=
X-Received: by 2002:a05:6402:280c:b0:640:96fe:c7bb with SMTP id
 4fb4d7f45d1cf-6455469c726mr15216782a12.28.1764076885654; Tue, 25 Nov 2025
 05:21:25 -0800 (PST)
MIME-Version: 1.0
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
In-Reply-To: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 25 Nov 2025 18:50:46 +0530
X-Gm-Features: AWmQ_bmI0Nc-U-7V1vG_PnxUMzavwAZMXSjJQCtXVqm1t0YM1hU1mPKj8-N19OU
Message-ID: <CACzX3Avd95DD0g1ec5y3Rqhs6fpo0dqcKBScUr17AOHcw_2JhA@mail.gmail.com>
Subject: Re: [PATCH V3 0/6] block: ignore __blkdev_issue_discard() ret value
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, 
	song@kernel.org, yukuai@fnnas.com, hch@lst.de, sagi@grimberg.me, 
	kch@nvidia.com, jaegeuk@kernel.org, chao@kernel.org, cem@kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-xfs@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_052127_849009_488845C7 
X-CRM114-Status: UNSURE (   5.01  )
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

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>

