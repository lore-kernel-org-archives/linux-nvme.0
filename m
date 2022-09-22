Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDEFC54EE9
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 18:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZXkuoJN7DK7qQfm5r7ECOHzIgNY6d3HZTieo4WxgmDg=; b=uYBHVLqYqeobDGVSZM5xBxHCyN
	uIx8LAT/zrv/KCMyg48rzWVjvPWPP2IR2zpOqhcAtVKEKIVfKteIcgGkSnHWJ+7Atl+nQvwUHXoaa
	AbCGm8FRJs+n6FZV619o0yWe7ew1JHDHYXC5RSZhAh8Zijq1nSVg1HH69dzro3dZ04PctfNK53z1+
	yhi6zKccU5MNaOiNbe3Edwh0ZdhYZ8xYaOgRBEUIEJSe7/LY79gsFPi2TRjOuKstZ7OAbP1yG2ppP
	19wj8V9ZBO4oBwIpC0AWG4s+csP3Szb7aVzLY2r/6QqwD59e684XbnhBCyuUlIOkmp9um+N8q3K0E
	LIBCgW0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obQvk-00HL9d-Nr; Thu, 22 Sep 2022 18:28:12 +0000
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obQvi-00HL77-Te
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 18:28:12 +0000
Received: by mail-io1-xd32.google.com with SMTP id y141so8456656iof.5
        for <linux-nvme@lists.infradead.org>; Thu, 22 Sep 2022 11:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ZXkuoJN7DK7qQfm5r7ECOHzIgNY6d3HZTieo4WxgmDg=;
        b=TC+pJhfEN/PyAXFz9y6nGede4tCH/WFNjMjWPIjHTuEQpw8cxk7XrbKNF2DJmY48jP
         OMXtozYtcQaXjwXQIh5dyupZ3vsYSgI3pgg54c3aV1P0/lVY5wsRWyr3OjpKpoupjlif
         xHeHXkQHHz9zloxEyG/49pm8yN6eRu4Z+6bll/V6pIjIYBC8iar5KFGGbanhuD827JQJ
         zLfsxwUt2iPe7PTqqrqNLFDdgeavsSr69K+zKE1VqxLJwY8YLHH6EfGDkXi7mK6UVC8H
         GX0VrV6IEWs24StfNrAtfWZrKGeTBhtsmuxiH/X7MuV+/Mw0FvM1uleEODvJNUFG722z
         1LEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ZXkuoJN7DK7qQfm5r7ECOHzIgNY6d3HZTieo4WxgmDg=;
        b=LixqiMKNUUburOtDeI0v/FGIvZUa3vH344URnUQh3TyEaK22sX3Av+7jNQrCtovTbA
         D4UsS/ZCV9zTul7DrJ2RJ01i8nmEQqorDsZc8ghTwlOuV4pqcs/eGAgwajCrh8P/wbh+
         2E9G7+khKI1cKYYXUvVxlgowObFNys9l77YMc2dTjm2tJtSmjI7F3NQ2LuHDNDFmEiQq
         ybr38KDpAdUL9WOMUm2w1nUhycojGA92jAVPxkolCW6XQO0yqs5Lclf82ZE6bfsror4t
         ldWqwlNKarZ949lCUErQs+iGNfW7g7WpQPFo1iX+6JYR1DysXRID6oK8B1PHu/xi6mgH
         rRgA==
X-Gm-Message-State: ACrzQf2W+DnbFozN0ebAInWM03N9gZiqZTVqIOyhnn0P8We8tPfje4sn
	xDXfCHuD6T2EqxXzqK5nNo+C9g==
X-Google-Smtp-Source: AMsMyM5/mw+f8DSISvPa79cGNBFPKxngRjSrKI07M17BHrjwAKNBmZT/eBpWILXqY0PAsnK6yyWCzQ==
X-Received: by 2002:a05:6638:300e:b0:35a:ab7a:4509 with SMTP id r14-20020a056638300e00b0035aab7a4509mr2787464jak.82.1663871287586;
        Thu, 22 Sep 2022 11:28:07 -0700 (PDT)
Received: from m1max.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id q20-20020a05663810d400b0035a468b7fbesm2440646jad.71.2022.09.22.11.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 11:28:07 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCHSET 0/5] Enable alloc caching and batched freeing for passthrough
Date: Thu, 22 Sep 2022 12:28:00 -0600
Message-Id: <20220922182805.96173-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_112810_978937_64561B78 
X-CRM114-Status: UNSURE (   6.46  )
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

Hi,

The passthrough IO path currently doesn't do any request allocation
batching like we do for normal IO. Wire this up through the usual
blk_mq_alloc_request() allocation helper.

Similarly, we don't currently supported batched completions for
passthrough IO. Allow the request->end_io() handler to return back
whether or not it retains ownership of the request. By default all
handlers are converted to returning RQ_END_IO_NONE, which retains
the existing behavior. But with that in place, we can tweak the
nvme uring_cmd end_io handler to pass back ownership, and hence enable
completion batching for passthrough requests as well.

This is good for a 10% improvement for passthrough performance. For
a non-drive limited test case, passthrough IO is now more efficient
than the regular bdev O_DIRECT path.

-- 
Jens Axboe



