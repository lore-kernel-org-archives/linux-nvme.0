Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F33C352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 18:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4IgAV0xIyvbwpM5yKjLqn+3xEvTqGQImla8lRmFjooY=; b=zLsgMJvWv3uQsL3uFPNLcjLEW1
	yvtzdnzHbb/bSRAn7G/Y2ojndYNpDBHQ+Q4EcEuq1fUCcQNbvTw+I4NPEvTMGBFgINt2YaDyoEUgt
	OYIh3GGyviv0irojg+zKy3goP3MR+HFJdgI/uaMEnRYUMvekbDVX8p7UUdZK3K7s798wRPF5qlNnC
	Z5VbLRh5GlsO2bKOw8p6panhIkTy/HAzU9zwYVqI1NlZfYUCzTC75OTKznLQjVGq5XDXA3XrtwYBL
	BEer8ggk1dKXBFBSLeEz+XiD6c1ZLFN33iK/7gKh8uPvc5ygbW/JauopCB0KsNatlG70WS54VZtle
	7fm4akbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2ceK-00HFxB-Ak; Tue, 06 Dec 2022 18:26:36 +0000
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2ceD-00HFwA-OL
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 18:26:31 +0000
Received: by mail-il1-x12b.google.com with SMTP id g7so6877029ile.0
        for <linux-nvme@lists.infradead.org>; Tue, 06 Dec 2022 10:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4IgAV0xIyvbwpM5yKjLqn+3xEvTqGQImla8lRmFjooY=;
        b=XJPXSnXYtqzyoEvG44PNoB+1gOv5k1OID8qM6iICUEPJA6HHkW4GMQrQVFvIJqguuk
         OGOdxnwkdbTGq6LjlVM1f27XJb3Ep44/YwPY7wrnw+/rNvpd4qJQuyoESdtuuvrdbeKH
         ao/8ht7AedDebOx4LiMMCtrbO4VSJ9fcjASSJ1g3EIQSvtLkUTsuLqR9ywJ1o5KwBaJb
         lzXZUB7AM29agYXILjmEyFzyjOjplMZHP6+hfWMxHw2ruxJf3CvI95Ue1gc0WcWxWvSo
         40cBJupRlPOhpXVpJVuRyp3hCjx8phcTIXoj8CbVh6dh2SOcqINnjOKbYxcS5XYdHwzg
         XEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4IgAV0xIyvbwpM5yKjLqn+3xEvTqGQImla8lRmFjooY=;
        b=ULmtcsCZSx0solYO/wfYQf8J6St2/aiMr+R2EHU7rkaai/wzzqomwFQG9NIdK1svyM
         fTuZhy6N3icK81CPtADpJYuI6g0oZW2DwzsLru3Ghr0su64Sg7Q6/6l9Nut7+rSXHB4U
         8cSTvhBbyYsvF7H7+z2l1wr7XuSrIkn/ouGpPAoUr6+eCbWLXy31L4y5lK3MXfNGd/Tn
         mIIunN9NYiiC8owFja9liLtwcPtKAEbAyXYWcnOLb5WnSlRquSklSxpvNra+qiqUcZZ9
         uk6kfL6msbr3ZVlvje5ralIz68g+k3t6mzennZ4epKzOP4NnxPfUowmO177GesLwxZ6J
         8JYw==
X-Gm-Message-State: ANoB5pm84lEOYhBratHqtmcxi/H9nqsNq3mS89qyGPtCR+8UPRXOltzO
	vKTLJQr8wrvYBQ3k5H9R1kJz5FLtEbmhzoWTmkTxhw==
X-Google-Smtp-Source: AA0mqf4OFLTHTjVrQA6b2z/UjNJEshTdpsFl+xYEou0s/2/0KkWYoGxGNXdyK9Sb1If+AAfg1/RuRv752BxW7M+hQoM=
X-Received: by 2002:a92:d702:0:b0:302:8a13:6744 with SMTP id
 m2-20020a92d702000000b003028a136744mr31558581iln.52.1670351187587; Tue, 06
 Dec 2022 10:26:27 -0800 (PST)
MIME-Version: 1.0
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
 <Y49ucLGtCOtnbM0K@fedora> <20221206113744-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221206113744-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Tue, 6 Dec 2022 20:25:50 +0200
Message-ID: <CAJs=3_CfwV=gzgsM=PseLoigzU+CFOXHk=9Sy-SBro5HHn_uhQ@mail.gmail.com>
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
To: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, 
	dm-devel@redhat.com, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_102630_031573_031F3E68 
X-CRM114-Status: UNSURE (   4.70  )
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

Thanks,
I will fix it in the next version.

