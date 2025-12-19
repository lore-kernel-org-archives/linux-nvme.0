Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9BED711CC
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Dec 2025 01:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y991gCg6skPoUl7hk1LGAAp54++d4tKnHzuC7vMFxyM=; b=I1ytLNPaYuCMj+9qsP/r1sKM00
	yKMBxjk7Ck9bo7psdXQ9ECuULbAB25jZMz2Vgg4ou6IlIons+agINHi8ltDX5gRSjR+/4ey4Mfs7T
	kCUVygQ4Xor3Lc9YDO6fZGhPS/mmEuyNhU3HuVfoKfmtIpBDQyRTilmE2mddmJLEpnSdav6byNs1v
	6Cr87pe4DGoryvfigsWuAZ0bKHnz4D/e3Fl2EvJ4WP3OCBSgkI1xgN9RHW7+7wqJf2RWj2mxfQYp7
	5ONfh7W6dHhttd/9p3M64hJyRZxtAToSfDbtq0BI4wjXu/nwd/1FmGIh7woVvJw3fhubDVE1zCwkO
	fPb+iDZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWPSl-00000009RYl-2Tti;
	Fri, 19 Dec 2025 01:39:23 +0000
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWPSj-00000009RYI-26JD
	for linux-nvme@lists.infradead.org;
	Fri, 19 Dec 2025 01:39:22 +0000
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-93f64ae67dbso340602241.1
        for <linux-nvme@lists.infradead.org>; Thu, 18 Dec 2025 17:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1766108360; x=1766713160; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y991gCg6skPoUl7hk1LGAAp54++d4tKnHzuC7vMFxyM=;
        b=BhS6hrUlTNoMAj7dcu+Kqb8mcGH25AY07iDZvRB0Lay+IYWQ5vsnmETvSDSvqTITtu
         UxF+400OLHKlbdLDTOaojZ1BlSvW1Cb96RDkEYNGpcT7V4BPht86pPqFuX09fi7p76fY
         Lc9bM5naCqNwFHQkjLDJLQlAmphHQjIbNJWiyRmGRLQWIJvUhdKLJrp6lgSlEquk6Y0T
         cJqkiRPUTMl1yDLpEfzN3TM4okVRB5SH4kDAb7058G5pZrMybBccu31+6reCaG3q5p5n
         9LdsJCrNXUUN9wQNGXpH1Ppa13oSGxhUMI3M//F1yAOBrljVv+Dy7FrdULt4I88xgc07
         gaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766108360; x=1766713160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y991gCg6skPoUl7hk1LGAAp54++d4tKnHzuC7vMFxyM=;
        b=f+qibMxpifKtt25BNsFlJVZwimwlSG2oK6u/rX7Yg3OJZGefS4Zkaa4mSBytdTGv+b
         /Rg35onRsGnqDBv7TOV/zGUh6dK/1/sTeXMqIWRm6wSOXbYp0bHwW/k1XgHXB9nb5Hf2
         1h7iQBG3r+2zaWYS5rjCEZKI3fwo0DiEByPN1+glze+QtdfacBmckeW2CSdqGC1nSaNL
         14puHpW+NS6P2RXoiYc75O/5F/p8r9WyG46F+bnXpiftWiypomwWG1fNhuB4E3nI8KK0
         Myk1m/bH1+/4HQpsSsOPF1gF9TdS+a1bMmOaC/BRxmnV9nmlWfVpClXxq6TUtpQtkfac
         eOxA==
X-Forwarded-Encrypted: i=1; AJvYcCW5v3GHyPvvecd7g4s8d6QHQ24f8IU1NT5UpqVV0+UzmYjydN+xS0DRNrOl8SMKR/D8hsk9S17yVdgn@lists.infradead.org
X-Gm-Message-State: AOJu0Yw+i6e2MGzI3OVXosEMM6povViggAQMgV+NqMvpFC5+Vmi79UbI
	xoQue2M+2yHnOx7rSDiqa8OAnM0GQUednliQSjw026kfB0W2sSezWbtIoosF03qDfV+UwgPJq1p
	xBZxF88dFGkJiPCwDctnwoaWZ/5eXBDRsTb+BA9Cb4h6qGkh4ci/CDko=
X-Gm-Gg: AY/fxX7XCq99LrtQFYdgUPXkFfyIJc3LIqQgaEx1diNICBjBxgr2riUDlwSoWnPfZs1
	qH00gpi5Ynt87LLGzvOQftARP3qT1K1GRzL6Sp5VfxsZX+pl7rKOIY1HfeXFlxF2EdxpzycVIAH
	0S6Wr8/cJiQ0tAtTNmV7XYH94jzXQIHQcIaNAUIy8igguhJuXivfX+xLUtQ/25luWTEIikogvp/
	k0OZztZtneAJ3lho01eS67E9qEFM963UG/Cfdi0dU43URB4fM9vWW5a54hvIUEISoobP9JX
X-Google-Smtp-Source: AGHT+IF3k4A63bMOgzbH+ccOVAnDMrdbusMJ++6s8tOYz1k9rrF8SDnneARhwD3EqZ/hivzYwsFPSqaZal9E/ogbc7M=
X-Received: by 2002:a05:6102:568d:b0:5db:b7d9:4db with SMTP id
 ada2fe7eead31-5eb1a663348mr418572137.14.1766108360173; Thu, 18 Dec 2025
 17:39:20 -0800 (PST)
MIME-Version: 1.0
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-8-mkhalfella@purestorage.com> <CAPpK+O1j7_AeMMgysEkzyqr48hWGzD8H97DzNnP46mnxQEQF1A@mail.gmail.com>
In-Reply-To: <CAPpK+O1j7_AeMMgysEkzyqr48hWGzD8H97DzNnP46mnxQEQF1A@mail.gmail.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Thu, 18 Dec 2025 17:39:07 -0800
X-Gm-Features: AQt7F2qCwSmPBGiIdoDazTbE7PyCnbUYQ7fUq2YddJOS4LZubtkVz7n5CxB142o
Message-ID: <CAPpK+O0LDYrrErxkGDQ6fF-hP2mUNPHXKm5B=w-Fua_Gjb6g2w@mail.gmail.com>
Subject: Re: [RFC PATCH 07/14] nvme: Add RECOVERING nvme controller state
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Aaron Dailey <adailey@purestorage.com>, John Meneghini <jmeneghi@redhat.com>, 
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251218_173921_569948_573C6DBD 
X-CRM114-Status: GOOD (  10.15  )
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

On Thu, Dec 18, 2025 at 3:18=E2=80=AFPM Randy Jennings <randyj@purestorage.=
com> wrote:
>
> On Tue, Nov 25, 2025 at 6:13=E2=80=AFPM Mohamed Khalfella
> <mkhalfella@purestorage.com> wrote:
> >
> > Reset codepath takes care of queues teardown and inflight requests
> > cancellation.
Note: Tearing down the connection (with the queues) after going through
CCR-based recovery or time-based recovery is late.  CCR will trigger a
disconnect on the host side, and, because we stop traffic to the nvme
controller, KATO should kick in if CCR does not, so I accept your
argument that  tearing down the connections first could be considered
an optimization that can get implemented later.

Sincerely,
Randy Jennings

