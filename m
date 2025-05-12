Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E07C3ABCD
	for <linux-nvme@archiver.kernel.org>; Mon, 12 May 2025 13:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l7uLEvnL9It+L+ySuSLMLY956fbhswBH9YYBR/9I38A=; b=YEkSIo4m03vhBjluyQEOfsfiO8
	DQqg5uo/NSbhFrdJsnfgTwsCzsYftDJk6IaeLltCxIFZP4fu7k/dWrxHtPmNTrAEMQ74YPx0cGlC0
	CUCDGyZrJZRtcctKYRfxXBFUoWl0sLPS8uur2J0guzX619FKJGPUgKPyKaJcy/zsjaQboJVOu6ifd
	8gocAy2F9+934eDRTYZYp5Oz+Qo6qjwwzLtkotfaJBRBigGtwr9JLpR7gci1+tHq82crnt6h5SJdm
	bOIuqc6qQsOizAXeoE+jsWttlgp/KK7eD3CiSS051aGb2EWsj5isTuN/srrLGWzwlBSG+nG71w9ot
	tGsPA0MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uETXE-00000009cFP-2Zbd;
	Mon, 12 May 2025 13:49:36 +0000
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uESzD-00000009V7Y-2ZAQ
	for linux-nvme@lists.infradead.org;
	Mon, 12 May 2025 13:14:29 +0000
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-4774d68c670so75254321cf.0
        for <linux-nvme@lists.infradead.org>; Mon, 12 May 2025 06:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747055666; x=1747660466; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7uLEvnL9It+L+ySuSLMLY956fbhswBH9YYBR/9I38A=;
        b=KdvsKgBu6wxeUvM2bRgCVMQi/XOg236gzYzDrxYA0VpIU49TO1VtB/TWT9cyc9xcuM
         oIrEZWdBQjRw6WB54fTGfIQdawk1Y5xlSRT03rqNlzTcLw96z64daVXo0cVS8QJrCCs4
         Ww3ZruOsR6JNhz1emGR2Gpvfl1iNl/JulDe6VSrHLZjCDWIqRbdUJqXdmw8zomwm1kuy
         YJaj9YaQeVreAyg5AH4GSUa9X3XLsHRPB0wBeokWA8AEgYoRzj55oXrIDPbxZVA7qKdm
         wxRhkAqdyeDfwxyXu7/K9UDaj+f1A7kXR5BOat/hFIxSuP9kVFcF4y4pucX4RrT+XUZY
         aB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747055666; x=1747660466;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7uLEvnL9It+L+ySuSLMLY956fbhswBH9YYBR/9I38A=;
        b=d+5sbmM4JxAUGIxWZFlvZEYVdp1Sn15Sb3iBAQUXL6JCX2ThLmg27ZAo/IidT/VJCo
         CYOUW5FGPGnID7u4oZ27k7xxLZtonFs4v6wkzK7LGT7p9+OLd6CfImKC6nhnMinMC9zS
         KGc0axI3EB3zU2ihG3gs85vKkRRGBF+orWw3pcrfNu5eY6FEwV/QpAX9mhW0dVQtvZ1D
         u2NzyF7oPwVgrbno7DZttP67t8TjzNasphdGJy8Hm9iBP0M3HzdMNz3FYbDfcCQHL2AZ
         IGtnx7xA1eiuandIS58jTupZkj8hfW+EmS9HS2iebZ4WwCUY9CazY1R9Zaf5mamjSDe0
         gxiA==
X-Gm-Message-State: AOJu0Yyrmbe+MbgOoshAD7dNVljE/55zKMTZgGAk6U1keke8Iqwr0tVd
	Jr41X8hiVBjS4nlHUzFgCaJqO6TeuTfZNBSvueqHvh8rjKrEZ/HtuQIFFPtfj0JYrcd2AXSc3Yp
	3
X-Gm-Gg: ASbGncsaxdFDRzw5ooaZMoURlDXLBxLZglnw2UMtHKFYJUBVMBfXlevqR0HrytOav+0
	xKDC2SHtkeisoG6j0i1B17+QehSFQB5AN+ppsSJi4TTGliIy3V1Zn8IOU9oPkVRK6439Rw+sanT
	e3UFBjSoLYWxOcz7XQVuzlyvhcmq9JTato4MO3kGSlFcyNVUAOfn/hMdCHgHvTn1AeV0HUH5HTw
	JPCqbX8HNWjdYmB7V8yCkjCar5zHU/dV+ZMxF1tTfDzGjr+unKYjsuMWiXiU4DV3bOnEJqKo72/
	7hiVYKsJ/s0Z2EKLL7qj5wCj95Kpryou+TCzfjcdschiFpwzL4ZU
X-Google-Smtp-Source: AGHT+IEg5qkUNjUgTohGchi7m7P7l8taw6AjG4tuQQkB8eUk9z/8Q4ao9ohGewENQxJuvxHQc7cs4g==
X-Received: by 2002:a05:6e02:2292:b0:3d6:cd54:ba53 with SMTP id e9e14a558f8ab-3da7e21658cmr157478745ab.22.1747055655568;
        Mon, 12 May 2025 06:14:15 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3da7e1136f4sm23046545ab.35.2025.05.12.06.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 06:14:15 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, martin.petersen@oracle.com, hch@lst.de, 
 Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
In-Reply-To: <20250509153802.3482493-1-kbusch@meta.com>
References: <20250509153802.3482493-1-kbusch@meta.com>
Subject: Re: [PATCHv4] block: always allocate integrity buffer when
 required
Message-Id: <174705565470.246281.8071371916977870882.b4-ty@kernel.dk>
Date: Mon, 12 May 2025 07:14:14 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250512_061427_927882_C072F95F 
X-CRM114-Status: UNSURE (   9.96  )
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


On Fri, 09 May 2025 08:38:02 -0700, Keith Busch wrote:
> Many nvme metadata formats can not strip or generate the metadata on the
> controller side. For these formats, a host provided integrity buffer is
> mandatory even if it isn't checked.
> 
> The block integrity read_verify and write_generate attributes prevent
> allocating the metadata buffer, but we need it when the format requires
> it, otherwise reads and writes will be rejected by the driver with IO
> errors.
> 
> [...]

Applied, thanks!

[1/1] block: always allocate integrity buffer when required
      commit: 8098514bd5ca98beca6ec725751d82d0d5b492d8

Best regards,
-- 
Jens Axboe




