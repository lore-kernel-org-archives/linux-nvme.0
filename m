Return-Path: <SRS0=HFDN=OT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25C3C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 11:53:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD3046136A
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 11:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AD3046136A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XSaMZfKZc9u5d1aY1guCQOqYaGOstQqnSoyztSOpXYw=; b=K3a/Ps1K76efa1cfMVV2oHux2O
	SeFboEwZfJkrpP8ArWGEb6+IVv8HSJaNLASyWdEvapFreSWfYYl7lPzJG1fS9PeN4tTqF2nuGhQEy
	t/bg79vd4GcECJmSfahLrAVUHbNXnE8AMboc1FeOe5HnPR6y5HCvg9NLL2lCCdp/ncrTUQ1bW0Ype
	oezrryxghYDNE2kDxNlxJm4JU3d0GvOmUPgfilbLG7B7zi71ubuZJK9c5UIi3gOEtK0bvE+Fo4rB5
	BgvvdQlUiUQHo+iaHZ1MA1orxbASSGzSZqf+XTw5r5JqvkDvW0j6J/oeuwO235Hqf4rdmYo74UWyb
	Qcwj+EzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVY9U-00Atc6-FY; Wed, 29 Sep 2021 11:53:32 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVY9R-00Atar-Sy
 for linux-nvme@lists.infradead.org; Wed, 29 Sep 2021 11:53:31 +0000
Received: by mail-wr1-f44.google.com with SMTP id k7so3691084wrd.13
 for <linux-nvme@lists.infradead.org>; Wed, 29 Sep 2021 04:53:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2Y1HuBf9lN+kQWKCO1g1Kb4iuwMOmOhY2Wh4y+H0eoM=;
 b=fT5V9FMYbQCKnDjdIHKstrzBVP6SEjF0JrJFy34VPbcPxzcZ74XtB3d2NpwH/q/T5f
 dMGJPkRkApqLpKaGwxZgib7A+IXSBMlV75bmx8VU4zgGNAEEp8cbL9cyXsEVIXptpv9/
 H8cBMUB2l0VVLsrR6+Pd/Pc9KTc82jUDZRjVAdiOlbS5/5bWOSgfWZqO+U0L9ibjhy4I
 6xQixN3RxudMwfEhL0K+f0ZMs4mq+RXYV7wui115shA8MvJIRH8XfNUWqZ/Tdddn1JSM
 v8g18QVhSUhDPgK+1YD1H4w82w7rzvjhGlSH9XfiIdRhOWTRcYuvAi/RR2AQEglVRnNU
 F0fg==
X-Gm-Message-State: AOAM530tsq5HbEp8JJVLGd071e8uRFNqpvvymtjYkdxFRDeZ4LAU2kyU
 ocy7a2fkNqpKK7i7A/jUZbqt/yHS2VI=
X-Google-Smtp-Source: ABdhPJzGhWGVbT3MlvchMuoy7R3Q5OKSNBay3CCJMwDPSmx6sCdOeLTR/AnuOZ2XrUegMeOgKkvtvQ==
X-Received: by 2002:a5d:64e2:: with SMTP id g2mr6264457wri.323.1632916408500; 
 Wed, 29 Sep 2021 04:53:28 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id 189sm1644821wmz.27.2021.09.29.04.53.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Sep 2021 04:53:28 -0700 (PDT)
Subject: Re: [PATCH 5/5] blk-mq: support nested blk_mq_quiesce_queue()
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
References: <20210929041559.701102-1-ming.lei@redhat.com>
 <20210929041559.701102-6-ming.lei@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <54b636d5-ede6-a700-4d02-4712db679234@grimberg.me>
Date: Wed, 29 Sep 2021 14:53:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210929041559.701102-6-ming.lei@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210929_045329_968507_5EA745CB 
X-CRM114-Status: GOOD (  15.65  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 9/29/21 7:15 AM, Ming Lei wrote:
> Turns out that blk_mq_freeze_queue() isn't stronger[1] than
> blk_mq_quiesce_queue() because dispatch may still be in-progress after
> queue is frozen, and in several cases, such as switching io scheduler,
> updating nr_requests & wbt latency, we still need to quiesce queue as a
> supplement of freezing queue.
> 
> As we need to extend uses of blk_mq_quiesce_queue(), it is inevitable
> for us to need support nested quiesce, especailly we can't let
> unquiesce happen when there is quiesce originated from other contexts.

The serialization need is clear, but why is the nesting required?
In other words what is the harm is running the hw queue every time
we unquiesce?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
