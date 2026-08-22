Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D038CC5DF94
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Aug 2026 00:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xinPbJQ2fX2HsEgHb17cs76xtzdXzl+FVY4VNtEK4RM=; b=Pmf5FJL2KSYOyytykN77LvJGGa
	Y2sQnIZFzV720lIsCui41bEzkeSMLrf/4bUmgekZiDak2rCn1i8t2d5YRMU07hfByhvmsLa7XXigC
	gALLlzQ6uvkVPX+siKcHICyFzKbabBPGWQZP5LirZHcg38XwU6h7oMCYiYXUAEcKC3r5Q5/l6mv8K
	hLw5dwVq8cCmWolc0lK5YELI7zSqJpg0rdmGI+rGjd09gUEUFXW9fVhj0ryY9VjKN0XiFn2eWQ+VD
	JjtQWgBKdpKWoCeJ2CRPLMceHCPKwoi8D4fGmPLRiZqdcLgZ7qmS8kxM8kupgxzUfEH7io2Y9sCl/
	/9DiyP+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxZvW-0000000ECpj-3qg4;
	Sat, 22 Aug 2026 00:49:38 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxZvU-0000000ECpP-0KH2
	for linux-nvme@lists.infradead.org;
	Sat, 22 Aug 2026 00:49:37 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so1612967b3a.3
        for <linux-nvme@lists.infradead.org>; Fri, 21 Aug 2026 17:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1787359775; x=1787964575; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xinPbJQ2fX2HsEgHb17cs76xtzdXzl+FVY4VNtEK4RM=;
        b=WtgdDx0dCB1WeHRYO94Jw98DOXcP1KxYHTTPetpa7I8nada+iNAhB0h52c5TsMQW8H
         ciV7PXHl7KogJQn+Et2Q2bjQpbYgZJI6/Y5Rzz+Yix9lBMJmhna0bIshNbFDmwbFqTaV
         /uYzN4PY9Royd+/psh3VjAkQVobJYgbcqv63mNMeMKyL2gFMtYdutIOIWj2wiOTRUUmB
         6urbQdbxjy741ZhIagWaKA4E4kMQhOSKKv1DcZjlRM38qwFdfgx90JyCgrd4nJOGdPPy
         SQdUOlHhvIfhFF2nQx7WbLkrizyeMGF+XY9Gg7gEWC/IGv3W9zsmblGks59owyY1CxCH
         u2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787359775; x=1787964575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xinPbJQ2fX2HsEgHb17cs76xtzdXzl+FVY4VNtEK4RM=;
        b=Ml1szPDNj+Sqjjp71fV7XU/4p+a+v77SyvLHEswJcmGexS2ZiSP6VOhXs0qBqvaiDm
         Q2u6KJO9XdXSqfLkOuD7mGECNsfDL/XEkczrBRY+PICbZp+Mkxfl3M1Bgvu2AClznvsy
         TmQGe5TUFHxInznmw+4tbHAmAJnrfdmc7yh5uyQH2HaYG1+J33Tzk1eyp32rZUZwkC4v
         ddSIOrshJ3A9eIXEqVZohXK6/99risw0gZpZmkdbbn/6LwFqrJjTTxwBwdULtbNGm6Tl
         eGpAyPsOvgjXc8VgkPl9ofZrK+mDVFothjQLmndaxzDODdOAY8b0CZv7i4riHHuWy14F
         WNcA==
X-Forwarded-Encrypted: i=1; AHgh+RqqcHfi+C7r9bjKO6VOyQsXD2Rwmvh05bSnc6iKfisSRe1t5XUgrpNkYTFo63P56gF9lU4xB3hSdhHB@lists.infradead.org
X-Gm-Message-State: AFuF++l8gPyfXXpUEVOwsUa0mNsqgQV7z3ViHtDoYs8dR4zcojQOTohV
	+DP3c1F0MQu5qJyDehAp5pu7R65X9iJD/bw3japjFQpSqxOaZw2pokePAyy2wO0P29k=
X-Gm-Gg: AR+sD13BpOWJDutziWouluSivOZS73Kkd6nu0d8A8looZhPup9fSxzaZsY51Mraoe7E
	JPP3EY+4UUNT6oaAbA/xKdJlIR32H2zlA2bSedNZWVxkCDCZ4gJ3/ZyjYtH7B+Tx6q+g3yI25DP
	ip9VTc72UVIr7byNixQVRK9EnlEwjgEE1qXjg2UElKwtjWjIWIfFOJfeAdyXbph6JL/pJ+VjyBE
	zeYMixNlmlIqRUhjRgpIlUyt2RAxIp5Y6mqrzEOKnQ5806vCuH2qI8m5RFgktP3bGBUxQhoNQDp
	Od8M6U+ns+sIUV4UvzgrWNpqjPmYIJznD3BeCvYRbaN1UuIAb1jiYzR1N9JNLXlFCN8gO9y37jE
	yFQi8F3PAGOar+Io5CX+10aNtIWHHF4SrD9OFf5zNHSE+GxIrgDWKy5gKCuk+FoOz4DEGp/LVbb
	lyEP4x0CBvSlag4liuVHMuENeatxB+vedTvQqjMNAdyoOw6utJlgUoT5qpS4bN8dB2xvc+EWfSh
	wGYGNk8ef22LhH+QVeRqge1OtvLjzZ+RR+LJYOqWoIe
X-Received: by 2002:a05:6a21:9204:b0:3cc:ec12:a788 with SMTP id adf61e73a8af0-3cd2fdba257mr19975952637.4.1787359774913;
        Fri, 21 Aug 2026 17:49:34 -0700 (PDT)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([67.208.231.220])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f9099ce7sm647747eec.5.2026.08.21.17.49.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Aug 2026 17:49:34 -0700 (PDT)
From: Saravanan D <saravanand@crusoe.ai>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Saravanan D <saravanand@crusoe.ai>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme-tcp: pin io_cpu to submitter cpu
Date: Fri, 21 Aug 2026 17:49:30 -0700
Message-ID: <20260822004932.79147-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <c194592f-6811-4eec-b5f1-2b015525c7a3@linux.ibm.com>
References: <20260820083634.71689-1-saravanand@crusoe.ai> <c194592f-6811-4eec-b5f1-2b015525c7a3@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_174936_143777_80CEABAB 
X-CRM114-Status: UNSURE (   9.71  )
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

On Fri, 21 Aug 2026 21:17:49 +0530 Nilay Shroff <nilay@linux.ibm.com> wrote:
> It seems that here multi tenants shares the same NVMe/TCP controller.
> So if the concern is CPU isolation between tenants, why are multiple
> tenants sharing the same NVMe/TCP controller? Wouldn't a per-tenant
> controller/connection provide better isolation and allow each
> controller's queues to be mapped to the tenant's CPU set?

The controllers are shared because the tenant VMs' virtio-blk devices 
are backed by namespaces under one multipath subsystem the hypervisor host
connects to. With many VMs per host, maintaining a per-tenant controller
is not always feasible because of the overhead on the host and risk of
running into target connection limits. blk-mq spreads any controller's
queues across every online CPU, so nvme_tcp_set_queue_io_cpu() picks io_cpu
from a machine wide map whether the controller is shared or dedicated.
Tying socket work to the submitting CPU will reduce VM steal time in 
these deployment scenarios.

Saravanan D.

