Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94607C5DF81
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 18:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xdHxS0sIoHsk7x7C8f0KNSu1Gu1JgMccMZDhHi/JGzQ=; b=1xnWVPgs/oCLw/8p3xrgGsc2rH
	+ba78UXRauFTprKkqPpaOGJRXlic1xBynQ8JNIjCD3hQYxGx5evB2t1kEQ74R8uyJuScYYA32c4lJ
	qqkuarXMGA2uaP4rf2tqWUvOvIvEOpB530e2ySBk5lHDvm2Rt8ubxcGv4wfj7p1lbu+LGjNbVL9RZ
	cjiCKN4O4bTavOxtKsDO34P+sPcvUBZDLBLcA3lALgpOodw0QaluNWJTUyE/1XNnidHW2UkmJPleZ
	oqyoK479R3PI0Woqba3F8UuDYCcZtA5g1PUiBctUmPKlvoPR83OZTM537g8SkDnruG4oZpfrHp2wT
	gfBMNQlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyCnl-0000000FWqa-1cOI;
	Sun, 23 Aug 2026 18:20:13 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyCni-0000000FWqA-1pxC
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 18:20:11 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2cc61541f8cso39108615ad.0
        for <linux-nvme@lists.infradead.org>; Sun, 23 Aug 2026 11:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1787509209; x=1788114009; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xdHxS0sIoHsk7x7C8f0KNSu1Gu1JgMccMZDhHi/JGzQ=;
        b=YlEKmGfcMGtzJTDaniIvTbg31ohDSQrOFzSZPD4IhNtOVRHSXx8IIsNNdkHQf9C4YI
         IfNIoG+IzURj/KAkpE6GAavu70TtL1LfTsMHxbxX3YImIwIi/XvAuhhbpLm5Ijap9jPS
         /87FnjXtEIyZ5VqhBfa9bfoqbxyAyS4Bjxv1jKJ3U+gJMTJSEcBsD+b2smPXOmj/UrR9
         fYx2sZQwHqi3ZIhg+AnZrJj0ByUzkQVsrk8jc5A9bFoNZj7MDap+DkPp1VeGd1Sxce0j
         5uus+KGkLIDEhF4+39m5BYluFWSyQZ/d4FEz7O2bQVCwp2kCgiUzsCnfCuvOF6HIIRU1
         QJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787509209; x=1788114009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xdHxS0sIoHsk7x7C8f0KNSu1Gu1JgMccMZDhHi/JGzQ=;
        b=mASqHY9txcqaoU7RQeWTRFLhAKKs/vqnzL7IgxNqKqMxCX3rloWnQfPRw8f2qaq2IX
         kcjqMSmBJgtAre8l7Py2CwYQLBmP6RxXGvC7CSHzncmaRkEmHvRVlqDct/mgVIoYS/Po
         UrvJnoFYsFm/hWg/r8QOcKqFot8RHZCUBErTmOZjMmjoR4epe0ICT3NAJ3A0Lru/XVRi
         MrzRQcFTplnlBnYcEFBa8XgNpbxYNgfK3dkRFValNE62GYdAV6hFrpIoSwrC+tMqW1rB
         hIv2kmxig/LXLioa0QYfIoKRuZwbprsUxrdGZ/GXwfpF01NKFG+iRQwXzoj3XoJ+4gu1
         rAcA==
X-Forwarded-Encrypted: i=1; AHgh+RqjhOEYPv11OX/a5FTmkeZhX+9nJfLZ62Uwmi5+7tz/sxhWJMuc4gpAa1ZPwKVWbMLzc6zSxv3AwpNi@lists.infradead.org
X-Gm-Message-State: AFuF++mZQpVKuD6L8rQGu/BZMqKEUzeAUGYLuP5s/Ae+kVbN6HVnIENK
	Z8cDabpjyOUt0N0KKS+G59Z0dcqhu7Y47hmYbfKdslNsSUgwxLlhA8wk72X9Od651N0=
X-Gm-Gg: AR+sD11M4z4KrAD30dayiNegsXogFvg+u/FPKrH8GCq3MnbzgnlLnxf8gMjItyrG0pE
	em3DPGfXVSGEow11Arp+XZyNCcqbDCsjYxTKdSbuc6fkYidig44CeGjMIzP3gfOAadkBZ1qgDh0
	DZ5bR+9jLx1rMBUuY/24dEyUhve20PDgaRt05iRr0mJuYODFy14F+NSaaelbttgOjDaTaGVG+E/
	pH1CI/gHwtBrTKaDw3wMUqJr5/zLfkNDIqbVEIFZtYJ995bX+wh2yszpuzaOZQPDUFKUSsL+iMD
	aZQ4bKfglylnMHNnmJtGJm9aQUzO4cb2wLNQge5daYqaZv3zIKg1WQclLtmgas2ALDpyXe7HDmQ
	gq329+zLGOcC3QIagkf5vsZJRkeLEBPOnmdQIk3pvI8wj3tTlNEokMyL6/tkv5mXKwuQmoeTdQ7
	J5dWiDFD8qIlsQe5Ld8XO1puk+DjifQMkLZBYYXyb6n7JWAwuFY+i6TGuE5/p9dnAEPbybwPed4
	wih8z4wDH6Bt++p4ypONgKAFWyyX0uxwXS+j+WNjykLR9Bb0JOClg==
X-Received: by 2002:a17:902:c944:b0:2d2:72b6:556b with SMTP id d9443c01a7336-2d61a1a54f5mr298394795ad.13.1787509209271;
        Sun, 23 Aug 2026 11:20:09 -0700 (PDT)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([2601:647:4380:3400:41a8:82b2:de7f:e948])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f91d36f9sm26804846eec.16.2026.08.23.11.20.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Aug 2026 11:20:08 -0700 (PDT)
From: Saravanan D <saravanand@crusoe.ai>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Saravanan D <saravanand@crusoe.ai>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v2] nvme-tcp: pin io_cpu to submitter cpu
Date: Sun, 23 Aug 2026 11:20:02 -0700
Message-ID: <20260823182006.52300-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <f2fa6f32-9df3-4bc4-8acc-1b8a73da76db@linux.ibm.com>
References: <20260820083634.71689-1-saravanand@crusoe.ai> <c194592f-6811-4eec-b5f1-2b015525c7a3@linux.ibm.com> <20260822004932.79147-1-saravanand@crusoe.ai> <f2fa6f32-9df3-4bc4-8acc-1b8a73da76db@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260823_112010_494139_C4B62583 
X-CRM114-Status: GOOD (  10.52  )
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

On Sat, 22 Aug 2026 17:48:17 +0530 Nilay Shroff <nilay@linux.ibm.com> wrote:
> My point was if we could instead make the queue-to-CPU mapping aware of
> the tenant's CPU partition when the controller is created [...] pass a
> CPU-placement hint/cpuset as part of the fabric connection setup [...]

Appreciate your time reviewing this patch and offering your suggestions.

You are right that a stable queue to CPU mapping has real advantages. It
is easier to reason about for NIC side steering and cache locality, and
where the CPU partition is known and fixed at connect time that is the
better design.

Our controllers do not fall under that category. They are host wide
and shared, the tenant VMs are namespaces under one multipath subsystem,
and the control plane creates, destroys and bin packs VMs continuously,
so a cpuset passed at connect would be stale as soon as the tenant mix
changes and could only be re-applied by reconnecting a controller many
live tenants depend on. Adoption needs no per tenant hint and follows that
churn on its own. I posted the concrete topology, 128 io queues over 384
CPUs with the straddling cpu_list groups and two live VM cpusets, in the
reply to Sagi.

The fleet operators who care about steal time already steer the NIC IRQs
and NAPI to a housekeeping CPU pool off the tenant cpusets, so network
processing does not land on tenant CPUs. That leaves the shared queue's
socket work, which this change pins to the submitting CPU so it stays
within the tenant's cpuset.

Thanks,
Saravanan D.

