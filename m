Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18995C4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Nov 2022 17:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ie27LHciP15/G/joM2RTTUyPO3R/G3vri7/Wv2kqzM0=; b=HF41ECte15lC/D8EYXk8mRWsYH
	LvubmK7Um+WfXqPZfGVfXjd2k86nA9rDxZK0lNDEwh+xmJPF2FrEaGQBst37dduE/alndbkIsGiBp
	6c7l9WL7q2Hmgjz/BZSMVyaZMy5pHI8xJZ8GqYXVDkb/lMz3vYAIudHPZXaYjweNg0JuC8C1vOFK/
	HfF9F97yLNDDNJdv0mpKoDrt3fMk9AItsuv2Wh31GBIPB7a5u/WcOGVwGqoOXJB78FpDvvyDahLEH
	zUkm4J+q7WL7IlsI7IY3k8bOOUte5jffMOxNJSrMEbbOyH5NCBIQeaSpWREf9z5j68vVpOwYyZ2li
	sGLuKPHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osSWF-0072wb-Rz; Tue, 08 Nov 2022 17:36:15 +0000
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osSW4-0072tR-2U
	for linux-nvme@lists.infradead.org; Tue, 08 Nov 2022 17:36:09 +0000
Received: by mail-il1-x12e.google.com with SMTP id e19so7825597ili.4
        for <linux-nvme@lists.infradead.org>; Tue, 08 Nov 2022 09:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ie27LHciP15/G/joM2RTTUyPO3R/G3vri7/Wv2kqzM0=;
        b=EWVfAUTumk4AQ08iyW9Q5OaA+9vWPO6YXORW8T5vAzOH6R3K7ePQEkc/AHQzv4NKuL
         axNwPnt9zkKFcnumeuq3Ni1HnW4BX34Gn59FgjBhrGjPTd7VNT02mNylwqxlosNEpljw
         gLj1g5pPGDGSu6B3Cm6i4ai6v4hnqaafLqm+ZgKjB2oZ3rA8N/es+FSCve4w7CPWpPJ/
         hQ4h4K2FlUn0ck3GDKUnxoSEdgFcMavTdrYKR5NbpX6LOqJPIkI1BOtWMGSlsYzuBv7p
         VRAR7d0ny4wxqRYewMATM3IX2ICxnAgla9kFsIz76KsTayT2UWLTnPsofs3xrHEHKeSJ
         BhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ie27LHciP15/G/joM2RTTUyPO3R/G3vri7/Wv2kqzM0=;
        b=lVEpYgaDR7b8qM8S9n6DITGoGFcHHkklxw3ksi1xhNEvB2JEu6WL3v0hr55VU31A5H
         pxBv2oZqqSfH+LZyEZk1aVEj1JsOjWxF1f7I5STcWnZhf0BORuO3Nw6FFnf42yo6KpN1
         39wJf5XxfAAFYrU8KKbr8eA/vEpsHZeYdfv/TvcsAl3gdQKs7JQvZKqcb+XedqAiOq8S
         WOa4Juf9fivLMipDWoNU1QUxHkNJ+V5kPbixTCER9Fkto6+8n/qrP7a8pZcEtogm9isH
         br1eOB2FYUfC2sl8pseaKJPDX6ks3/6pa98SmfhJSszmmruSEZ0oot0IaedLyR1uAT3h
         guuQ==
X-Gm-Message-State: ACrzQf3g0gWg4B2E9Vu3vvv12I56LwZPFtwAhRs773UAwbegvB2jHPGh
	CTFIU0JfKRYJDcy/NXt5ioAwrQ==
X-Google-Smtp-Source: AMsMyM45bvy/64lNW4dHL3SZe0PN0KsWFFiszerLfZ0l1x4JN7xNJQy40y5C6TaqXPGbKUXelxVvNA==
X-Received: by 2002:a05:6e02:be3:b0:300:c33d:4ad7 with SMTP id d3-20020a056e020be300b00300c33d4ad7mr22795761ilu.150.1667928958975;
        Tue, 08 Nov 2022 09:35:58 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v14-20020a056e020f8e00b002fa9a1fc421sm4018267ilo.45.2022.11.08.09.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 09:35:58 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Sagi Grimberg <sagi@grimberg.me>, Serge Semin <Sergey.Semin@baikalelectronics.ru>,
 Scott Bauer <scott.bauer@intel.com>, Jonathan Derrick <jonathan.derrick@linux.dev>, Keith Busch <kbusch@kernel.org>,
 Rafael Antognolli <Rafael.Antognolli@intel.com>, Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>, linux-nvme@lists.infradead.org,
 Serge Semin <fancer.lancer@gmail.com>, Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
 linux-kernel@vger.kernel.org
In-Reply-To: <20221107203944.31686-1-Sergey.Semin@baikalelectronics.ru>
References:  <20220929224648.8997-4-Sergey.Semin@baikalelectronics.ru> <20221107203944.31686-1-Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v3] block: sed-opal: kmalloc the cmd/resp buffers
Message-Id: <166792895795.7601.10122514732945288817.b4-ty@kernel.dk>
Date: Tue, 08 Nov 2022 10:35:57 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_093604_135065_A29D4554 
X-CRM114-Status: GOOD (  10.45  )
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

On Mon, 7 Nov 2022 23:39:44 +0300, Serge Semin wrote:
> In accordance with [1] the DMA-able memory buffers must be
> cacheline-aligned otherwise the cache writing-back and invalidation
> performed during the mapping may cause the adjacent data being lost. It's
> specifically required for the DMA-noncoherent platforms [2]. Seeing the
> opal_dev.{cmd,resp} buffers are implicitly used for DMAs in the NVME and
> SCSI/SD drivers in framework of the nvme_sec_submit() and sd_sec_submit()
> methods respectively they must be cacheline-aligned to prevent the denoted
> problem. One of the option to guarantee that is to kmalloc the buffers
> [2]. Let's explicitly allocate them then instead of embedding into the
> opal_dev structure instance.
> 
> [...]

Applied, thanks!

[1/1] block: sed-opal: kmalloc the cmd/resp buffers
      (no commit info)

Best regards,
-- 
Jens Axboe



