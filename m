Return-Path: <SRS0=7/ZJ=QG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97323C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Nov 2021 04:31:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5402E611C3
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Nov 2021 04:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5402E611C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jKkpEgqy21F+6MHgAKXtL1mfPkm3IkM1lMAPVxq134I=; b=ujEyu6ituPONszGk+PkOhSaOJd
	DirFLackzKjpMaik8+548/k+WoNo2jTGY+o3nSEwlqz57gipbTM1po2e/TzHeI+tHS9/DYm3F872m
	SWZx4aXAHI0Be3WRxw24ybw4DXVmV5Lwaa2uy5+p16Y5h88xIbTjoruJZOEYs29avJx44tw2RLlVN
	jBDE5lkjl5WUkUUdEUwiunvC5+tTsTeLNDhgaKXl9KKODPyIpVW9pCDQ6uYVDnCOjFFgmOVUuQmqq
	qtvJtvmN5RB2ST7S6RUJxIKqqtMkouWWBf9t2ZjjsDghaV07Uo6JMGl5I547WXaEgSxq8xw+VT6WE
	9Wc43pbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnvY8-009QAe-Pa; Fri, 19 Nov 2021 04:30:56 +0000
Received: from mail-pl1-f176.google.com ([209.85.214.176])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnvY5-009Q9u-LL
 for linux-nvme@lists.infradead.org; Fri, 19 Nov 2021 04:30:54 +0000
Received: by mail-pl1-f176.google.com with SMTP id b11so7138338pld.12
 for <linux-nvme@lists.infradead.org>; Thu, 18 Nov 2021 20:30:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:from
 :subject:to:cc:references:content-language:in-reply-to
 :content-transfer-encoding;
 bh=jKkpEgqy21F+6MHgAKXtL1mfPkm3IkM1lMAPVxq134I=;
 b=Obn2yfHXHiUyCXqEYQJO9U69N8rnnZGy8wblEKld+GQE+1bDK2xiOfCifF5SFSWdNK
 QjY1+w0z09poTKqlDgGWrvEfkAhVjcSVzu5eExOKQy/13kB33xyzY3IuH98pVxeF9/Gh
 quut2Zi5JQTikOvYwERFx2fbTHPjLXTlU7c/vxkawv1VmpQ/kCdQATWBxs0yWcSpypLe
 SDQBVdKEzSqvHGRRma0YNJBRP3rv9BONB4NmHfoECxUFFzWes3yMJ0ohLBXECtJ30512
 JUPyIWMQES8jDzNuv3RUO8tL/96FW9D3qzZXQlk7u4NkqdqWhJUuCoqyz/C518aI7vnI
 B90w==
X-Gm-Message-State: AOAM5322wdT/nuQSapo1deKkus1MaR4XZp68WRyqmOPxZON38l8UEdso
 TD+PFxjTh8c9P6+txEsqlXc=
X-Google-Smtp-Source: ABdhPJxeWkmCq0jJll1lI7VBTooLeihaoBCi0Kb4+SXOXNeC/pbSeIT5DrNT2lOoVc6HsGT3Bn/pHQ==
X-Received: by 2002:a17:90b:1812:: with SMTP id
 lw18mr1051673pjb.96.1637296252254; 
 Thu, 18 Nov 2021 20:30:52 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd?
 ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
 by smtp.gmail.com with ESMTPSA id m127sm892396pgm.64.2021.11.18.20.30.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Nov 2021 20:30:51 -0800 (PST)
Message-ID: <a3192b20-fa76-0b64-a2a9-c0c337741156@acm.org>
Date: Thu, 18 Nov 2021 20:30:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
From: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 1/5] blk-mq: move srcu from blk_mq_hw_ctx to request_queue
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>
References: <20211119021849.2259254-1-ming.lei@redhat.com>
 <20211119021849.2259254-2-ming.lei@redhat.com>
Content-Language: en-US
In-Reply-To: <20211119021849.2259254-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211118_203053_798623_DE64BD92 
X-CRM114-Status: GOOD (  11.78  )
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

On 11/18/21 18:18, Ming Lei wrote:
> +	bool			alloc_srcu;

I found the following statement multiple times in this patch:

WARN_ON_ONCE(q->alloc_srcu != !!(q->tag_set->flags & BLK_MQ_F_BLOCKING));

Does this mean that the new q->alloc_srcu member variable can be left out
and that it can be replaced with the following test?

q->tag_set->flags & BLK_MQ_F_BLOCKING

Please note that I'm not concerned about the memory occupied by this
variable but only about avoiding redundancy.

If this variable is retained it probably should be renamed, e.g. "has_srcu"
instead of "alloc_srcu".

Thanks,

Bart.

