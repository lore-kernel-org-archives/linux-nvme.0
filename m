Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFAA7C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 08:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HFaINRL63IBNxp0Soii4v8PCGz3DCo3roLnsnw7uKlA=; b=3bggK27k2QPDjbKGu3a5j4PCL+
	RLsmcYl37Azf8Jh+IR25hNG2YtNCjop0oPSFo9lDv/xz03XoL3kU8lX0xqrXgSAQ7VfwUoZ729EQq
	gZtK604tkfpKce5hVJ4H8PTr1wDoBaqZPqdIOVCDUi9Gv0TufO8rKWhXYPlPcVDSVcZx+bqk08ZKu
	79VNrai2uR50kTeUJ+bPhhgifu6psknozsk3KeroKxBv+BAwCRFT1dN3pPWCePYLpxnFUYyH8i7nR
	Ghpkkz6d46xcwDy4EQB9m2rPMPcllMzkcotAcweXY80VBEJISaaIPLxrkKDu/3zNAGst5u+E4aTXu
	/SSq6vjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpRZU-001NNR-Ja; Tue, 23 Nov 2021 08:54:36 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpRZS-001NLc-1n
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 08:54:35 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 p27-20020a05600c1d9b00b0033bf8532855so1333774wms.3
 for <linux-nvme@lists.infradead.org>; Tue, 23 Nov 2021 00:54:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HFaINRL63IBNxp0Soii4v8PCGz3DCo3roLnsnw7uKlA=;
 b=de4IrNV9j8Px/sSc3SvKLkzXGktSAyQP0KVQvHrn1PpZBBlBI/dQtqAmGVsQIZ3yiL
 u/FmOxhp2sEQGYahm5NMEhP6/7mXZLV5TGTn382Eauq3egG2WYQ+W2XCB55JSrz0L7sV
 5f6XesrVbbjZqXiGGTrT5GKNlH1ulEMdhCc+VbEQfO13H0Aksq5eYb9Y8IRQ4BWjdDqi
 wiQ0W4bLC1Fu903x2abbRyF5VmIUF+m60HenCSIBabmWHqF/gzb5ULSR+NMJBUvpCHRJ
 GkS3X52W5JToVFQmq41b2LA9vaIVYYYGNSXW4ILVJ4MlDxCXNYHuvCCySIeXfZs2x/bl
 04Bg==
X-Gm-Message-State: AOAM531BERXwtNCtQBxJSgSLznpZFT0NHe3EJ5q5dd0BwnZNZWbJv3oF
 XYiWIcHtTbefLOpzwT6W7qA=
X-Google-Smtp-Source: ABdhPJyFhDboZZAHwP1dMbmtQqaChktGrhfT/J1/+HcY10WP1jFZw9WdsEvIFetkr1Av3CMZx1G3gw==
X-Received: by 2002:a1c:7c19:: with SMTP id x25mr1081278wmc.42.1637657672093; 
 Tue, 23 Nov 2021 00:54:32 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id m36sm479864wms.25.2021.11.23.00.54.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Nov 2021 00:54:31 -0800 (PST)
Subject: Re: [PATCH 2/5] blk-mq: rename hctx_lock & hctx_unlock
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Keith Busch <kbusch@kernel.org>
References: <20211119021849.2259254-1-ming.lei@redhat.com>
 <20211119021849.2259254-3-ming.lei@redhat.com>
 <ed13ee7f-a017-874a-cd28-e40b3aa6b4a7@grimberg.me> <YZuZCsCIyQrc+539@T590>
 <737e0543-9b7b-4872-082c-9ea51069d57f@grimberg.me> <YZww/1iBDbou1yQY@T590>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c10b2729-d0ca-5705-5149-828dd269f191@grimberg.me>
Date: Tue, 23 Nov 2021 10:54:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YZww/1iBDbou1yQY@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211123_005434_134250_96FA2ACA 
X-CRM114-Status: GOOD (  12.17  )
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


>> Then look at q->has_srcu that Bart suggested?
> 
> Bart just suggested to rename q->alloc_srcu as q->has_srcu.

Yea, is there a problem using that instead of having callers
pass a flag?

