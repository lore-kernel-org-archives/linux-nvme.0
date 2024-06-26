Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C594DC27C4F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 15:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ejiLOCPjQYH7ACXd016xEl0yCudpyXAA5MF+cxuWv6M=; b=OmLnAcVXt1cBsewt1OBCYo4IzD
	+P9H7otuK0xNvEzePaZYOJjCYdfJLWBEFVWysmEZXEc0nwT1EBQ5LvV5zorf0i1qZ1FD5VfPivlkc
	inkmQkvjFP7f384ZW5V3UUKQmcsQfFCX9GKqnQ1eJxrDxH+2TaG5SNhMSCtO48UIzjRrd/OjY6aZ6
	kqPP1ddEtoQnhQzdm2fAXVbq4U9MhP8DINm5uWjlDpjVlXm7FgZtxZPEcJuKAbMHpoQ62/Ye6SsGl
	c+ahOUHRFFxgCPAkSgt5CgfPEhyZMbuJvKp44AVskvtwye22cJMhmLxDmGpSWWDwJElaa2AQArFCY
	WEMK0uCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMUML-00000007Lwm-2wHl;
	Wed, 26 Jun 2024 15:14:57 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMUMJ-00000007LwF-08rE
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 15:14:56 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-7065c2a55e0so180216b3a.0
        for <linux-nvme@lists.infradead.org>; Wed, 26 Jun 2024 08:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719414893; x=1720019693; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejiLOCPjQYH7ACXd016xEl0yCudpyXAA5MF+cxuWv6M=;
        b=ZNeZUD/kKnbWn14NKd1HNDG95RnA1IgUTXn/zhtpUhZlEzih8fMvCvDYqsD/PIGK0n
         gzs9Y+lRYf+Eu/Y/I7RxPFfk7ULsGTOEXfOW9SN6H/KknV9IhRBn6ds8kC/Ib/o4M7gA
         c9aSHX0DIM3qHB6lObcbCbDd36w+i1mVHqhz+FI/rKAVHbGau103DN8QwgRw5lsUFp+S
         rQZRSb0ppRuxSOeWayLOU9KyAsTEwxCBDjn3NjhbgW3KlLBhP1WPY+KhEaKqnZVu5FUG
         tGNlRTqvMzqI9yiEZXbtOPFA5g3y/gjYJlNw2UIylVuYVNkuCISpk3rGkNa19L/FuVqm
         AVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719414893; x=1720019693;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejiLOCPjQYH7ACXd016xEl0yCudpyXAA5MF+cxuWv6M=;
        b=xNyLtC5bpHLasrDeTiJOcUDl30eQtsWXbB5U1c+WtiAs4ONfVI9LVUHcBfS/49zh7o
         VnNygRAc9wrvVUeR5rrS34aMU2bAGgQJSROmtnTwSmjvJeL4qJj7B7kcaPO0Ki8spO96
         9iDX9IEirntaaPUquQe5Cb2kzFpNE/EpQ2dFceugobZ1Y8bx1AxXYiQMb4MMK73QYwU0
         a2DUNC1hM8wb6fs1tsVebis3riHyeB1sMILT3JtKFKSso6y4WqXGOyP8P/GkVfhoZVmA
         MYyA+2V4BImE4CbcYOicUEwzLfIwKK/GePjh4CjHXD2SA7NduzCmOGlMEgVwfKfJZ18X
         02/w==
X-Forwarded-Encrypted: i=1; AJvYcCVrdRTyao77klFh43Ohf1/8Ho6OGzbDEa5+0Ef4jxWECefleG8fQ8C5DZ+L/WFGwmSfDVrqhVqfNJSaNftiwlEbaa/PZAESOb8zyZdGklY=
X-Gm-Message-State: AOJu0Yy7JC5AMB7KPZMEkraIVS5pFyitFixKCVkHeCqYvyPsFW/oje9W
	TKAymcJEr8R7WH5mLNgjqIdn25HMKUVCoLZti40pyjkJWES252QxKl94I/ZxDr0=
X-Google-Smtp-Source: AGHT+IFmzeqdqLg5SiV0tu6djto+9EcNyF5jowS1AcAqpWmkqpnRMXJ/vbnzGjN2TKNNd7d+87nUFA==
X-Received: by 2002:a05:6a00:6085:b0:705:d60f:e64e with SMTP id d2e1a72fcca58-70667e2b1cfmr12723111b3a.1.1719414893526;
        Wed, 26 Jun 2024 08:14:53 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7066c2ebd85sm8184326b3a.93.2024.06.26.08.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 08:14:53 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Mike Snitzer <snitzer@kernel.org>, 
 Milan Broz <gmazyland@gmail.com>, Anuj gupta <anuj1072538@gmail.com>, 
 Mikulas Patocka <mpatocka@redhat.com>
Cc: linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
 linux-nvme@lists.infradead.org
In-Reply-To: <719d2e-b0e6-663c-ec38-acf939e4a04b@redhat.com>
References: <719d2e-b0e6-663c-ec38-acf939e4a04b@redhat.com>
Subject: Re: (subset) [PATCH 0/2 v4] dm-crypt support for per-sector NVMe
 metadata
Message-Id: <171941489217.836289.13164322028417269597.b4-ty@kernel.dk>
Date: Wed, 26 Jun 2024 09:14:52 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_081455_109870_2F0FBDE7 
X-CRM114-Status: GOOD (  10.75  )
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


On Mon, 27 May 2024 17:39:14 +0200, Mikulas Patocka wrote:
> Here I'm resending the dm-crypt support for per-sector NVMe metadata. I
> made some changes to the first patch as suggested by Christoph Hellwig.
> 
> The first patch fixes a bug when splitting a bio with attached metadata.
> The second patch enables dm-crypt to use NVMe metadata for authenticated
> encryption. dm-crypt can run directly on NVMe without using dm-integrity.
> 
> [...]

Applied, thanks!

[1/2] block: change rq_integrity_vec to respect the iterator
      commit: cf546dd289e0f6d2594c25e2fb4e19ee67c6d988

Best regards,
-- 
Jens Axboe




