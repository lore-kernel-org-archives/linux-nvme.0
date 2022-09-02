Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF03C001B5
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Sep 2022 15:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kmWx6GQdEOtF/uL3thdhLU+yeJiJgGxBRHmkDdY8oDM=; b=kIMbne2W+xGjwacnFjJldnicWy
	nqdENYUII4wNwAG3NayphN1D+1YzfVcDM5HE/EOgXlYq8IJwnZ8WlolSXYtYvZqarsgtxrK+gzlYM
	g9xRSDkKVdXcKJDYXFjsZ2H6wmxGKYpvcwFdqh0sg/wAL2hvf1BBVcGubDxtIRQnw4JXdyrPH47qY
	PIfdZp4KgbHbIoDKMomlOHNS8hpki/D1XBi8lLMuocvWOshUjfI8XCDX8Ze5QhQC3ZDbk4V4DnNZD
	0zt5/RGnZ0IvdF08dVOLh7vgimJapKvbGzfB1lqrt0LllvcBY8flG8B+UMXxsWWhIWj2wsaBKLM7/
	rtRxb8Mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oU8hO-006Fyv-4Q; Fri, 02 Sep 2022 15:35:14 +0000
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oU8hK-006Fum-7P
	for linux-nvme@lists.infradead.org; Fri, 02 Sep 2022 15:35:11 +0000
Received: by mail-io1-xd34.google.com with SMTP id n202so1907318iod.6
        for <linux-nvme@lists.infradead.org>; Fri, 02 Sep 2022 08:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=kmWx6GQdEOtF/uL3thdhLU+yeJiJgGxBRHmkDdY8oDM=;
        b=u022k6EYXiOXMch99qyEGcZPDNWmlAKj0DNCn+w1cCZ1xdp4kimxRT8y3JB6kTXXlu
         dJo1S3YC7adSKZULoccPxd/74sppKhrenMLOSlqKR7V//ezSBTsQSZOFsLUhCxXFxcSR
         b8krgNQFz+GYhd+MnQAN1zJ9CfU6vp+uecvw604ydbfuULNwxQC+fUrnVy22Vgbod+Tz
         ZPMCX/M7xo2odcW06zRyET9u7dAaWHMw9pS2mXqYGngdoAuSkPEBztjWYyv3LDp/TYvw
         0J5S3AmLE0BA7OAdA0JM9ySULTOK7k+fSmc5cKMP3F+L4vOAo3/WKAOKeOuzXrUqppei
         L3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kmWx6GQdEOtF/uL3thdhLU+yeJiJgGxBRHmkDdY8oDM=;
        b=y2SPGDQcvE3aJL5tUTs+TU2xUvpICBJ0Qn+s3mUjdp+Ne+rvz4sDD5WpYdX32FaOcb
         Jg3ZSuqTSunfDH7Dvv+Wxhtsq1+ns0kwAPBbsp6/BWXHpyqhhMTqtu/ir6pqBe2ILaza
         Y/5Hp0CB1QC/Bf6xZ+TRMyX/pCeVK4vOnXzCeKj77Lu2MNuWn+SvZ9cg4HFzt9ffNQGN
         1RnFtz2RO8asEdjlabXWHUmu/OsQuzofHKG5ILJrRt3IpgrILedA/1H3M76fyV5ppDI6
         UTQBB9acLOAT9rSxfmS1cpSNjxMjU47YkNQP3obbUeFxMuExueOUy2COfU0uAjiit+28
         vPOw==
X-Gm-Message-State: ACgBeo0Y8leu99uCyYjc/6VAN5aOKDFxH0LfDPQTrLbGz0MEyZZQtnQ8
	WU6mjSzcK7j4VIzIVK/qnwcW1A==
X-Google-Smtp-Source: AA6agR7vi1T5kgnb2NiyyRAj3pUZQ0IJrIIFQrve79mFhm3NWuLo63V9wBE9wZcZmYId2u5+g2bnsg==
X-Received: by 2002:a6b:ba44:0:b0:688:876b:61c6 with SMTP id k65-20020a6bba44000000b00688876b61c6mr17159855iof.51.1662132907624;
        Fri, 02 Sep 2022 08:35:07 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i3-20020a02ca03000000b00349eece079dsm946495jak.35.2022.09.02.08.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 08:35:06 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: kbusch@kernel.org, Kanchan Joshi <joshi.k@samsung.com>, asml.silence@gmail.com, hch@lst.de
Cc: gost.dev@samsung.com, io-uring@vger.kernel.org, linux-nvme@lists.infradead.org, ming.lei@redhat.com,
 linux-block@vger.kernel.org
In-Reply-To: <20220823161443.49436-1-joshi.k@samsung.com>
References: <CGME20220823162504epcas5p22a67e394c0fe1f563432b2f411b2fad3@epcas5p2.samsung.com>
 <20220823161443.49436-1-joshi.k@samsung.com>
Subject: Re: [PATCH for-next v3 0/4] iopoll support for io_uring/nvme
Message-Id: <166213290569.98725.590739918203033888.b4-ty@kernel.dk>
Date: Fri, 02 Sep 2022 09:35:05 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-65ba7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220902_083510_318919_5E80F13C 
X-CRM114-Status: UNSURE (   8.77  )
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

On Tue, 23 Aug 2022 21:44:39 +0530, Kanchan Joshi wrote:
> Series enables async polling on io_uring command, and nvme passthrough
> (for io-commands) is wired up to leverage that.
> This gives nice IOPS hike (even 100% at times) particularly on lower
> queue-depths.
> 
> Changes since v2:
> - rebase against for-next (which now has bio-cache that can operate on
>   polled passthrough IO)
> - bit of rewording in commit description
> 
> [...]

Applied, thanks!

[1/4] fs: add file_operations->uring_cmd_iopoll
      commit: acdb4c6b62aa229c14a57422e4effab233b2c455
[2/4] io_uring: add iopoll infrastructure for io_uring_cmd
      commit: 585cee108ddaa8893611f95611e32ed605fc6936
[3/4] block: export blk_rq_is_poll
      commit: 2dd9d642edf01043885cefeaaa06d9c8e1aa4503
[4/4] nvme: wire up async polling for io passthrough commands
      commit: 5760ebead11801cdb73cdf3841e73231968f6af4

Best regards,
-- 
Jens Axboe



