Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B97C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 14:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qz6ea+Kr8k2MiaKZRozhl4QfX9wlsZ49scAW5YgmpE8=; b=Vkj5DcwqIz8NCwPsVBluIXQ4GM
	3yJwpjQ4Wjv1dvDg2rm7qH56xCt2lTkS76wc9yYS8wtjwHyk2xi4e0rqws2t8Y6OjOBT0f2fC1lnx
	0R9/w9KDNVfSCYdLA5rDMG20KQj/lgppiSM3464R4ECY/csJ1XqKIkcbGzNZr2u6GAGN347BhC3hh
	jbmKB0orBJZQX2wB1nrQTmALx8JbQEFJJ0BCd9tB2/R0CSVhc9kCFa1/L6nUFlaSFjC6lsmavKXuK
	T5utebzHlJU2yKPwMa7raLwvYx4uQbWF21HmnSWiwxDNyXAXxpSgEwzuO+bJxMwl+Yo5fxTseFgUJ
	xliBoykw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqEqi-00BXC9-K1; Wed, 02 Nov 2022 14:36:12 +0000
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqEqc-00BX9F-9e
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 14:36:10 +0000
Received: by mail-il1-x134.google.com with SMTP id 7so9525967ilg.11
        for <linux-nvme@lists.infradead.org>; Wed, 02 Nov 2022 07:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qz6ea+Kr8k2MiaKZRozhl4QfX9wlsZ49scAW5YgmpE8=;
        b=bXDUwcGlpoxz37InLUAP4K3juVLgX9H9o2uH3oek7Ir5N65Vab9M9WHD5giL4IVT6e
         kdV7yZ9lLG9FpzZKaxdMLBfL1VHTMo7OkW0+J7nOIUByYy+LyRYgXjS1Hsv9xXNoe9os
         5NNq+XXL8BDRiduDgqr/QmHvGJKhH3YtaynMzHWkaz225Bs3r2rYtWbUWhFCftWRSK0r
         2tVprrlPWYdHFMC0tm+dDjb9AiHRgMZbWiUDqN+yPYIk+AnEXqkvc7EsSSqURDrjPkMR
         XpZVxQlzDo/1u5Z/H3uxPt+JQesFceCqopobWYujLZqgrDbImVovUabBQyhb0y4amf9E
         194w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qz6ea+Kr8k2MiaKZRozhl4QfX9wlsZ49scAW5YgmpE8=;
        b=hap1mSmd9Y32TG/9I/LLuDvD7WFxIfLesM7huR7UM/gu4cvNmAMh2dhjz58DFalMzq
         6aH9+BcJbU02f1lG3Dn2shBvycGd0Hlq5QNNEnS1TdVJWNVImXqlXGZi/E+i+mC6MZTc
         AlNq7Nm3QG2kCR++jSEJGnv5MrZgZnJlvtRQ3BAUoYNhB5uir5Wg2VbexeCEivAm+KTD
         mfGoX/LW0RMkC6qel0UHDPcaFw0tmkcgG9K+1nFyzxB8r9o3/ZyG+T4ZIkegMPbFUdvP
         TTHwFSDb9Q4+POBL0lH6OSK44Z51pJ03Cob4E/X4B/dNJt7acpoqTDi4UHcoAhhEfm3N
         PHdQ==
X-Gm-Message-State: ACrzQf2Hlt3YaMHT3u0e2OuvNzUD/4ZT2e8OOTmPGxHMIuXz8ISGTA1x
	TIWZ9XzRdwGVmERU2AIeCXhkSb5kSoogIO/y
X-Google-Smtp-Source: AMsMyM76hs7+c9NebQPMkC81RNNN+f4ouHprG2iYyY7hXqgOWCzUfCf4ildt0w7TEmJBi6sZE8AvOQ==
X-Received: by 2002:a92:6912:0:b0:300:c48d:19cd with SMTP id e18-20020a926912000000b00300c48d19cdmr5975428ilc.216.1667399754142;
        Wed, 02 Nov 2022 07:35:54 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id ca11-20020a0566381c0b00b003711ce0dc15sm4978244jab.68.2022.11.02.07.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 07:35:52 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Chao Leng <lengchao@huawei.com>, Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
In-Reply-To: <20221101150050.3510-2-hch@lst.de>
References: <20221101150050.3510-1-hch@lst.de> <20221101150050.3510-2-hch@lst.de>
Subject: Re: [PATCH 01/14] block: set the disk capacity to 0 in blk_mark_disk_dead
Message-Id: <166739975247.45121.7499768633850018123.b4-ty@kernel.dk>
Date: Wed, 02 Nov 2022 08:35:52 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_073606_373850_BA20FAAA 
X-CRM114-Status: GOOD (  13.46  )
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

On Tue, 1 Nov 2022 16:00:37 +0100, Christoph Hellwig wrote:
> nvme and xen-blkfront are already doing this to stop buffered writes from
> creating dirty pages that can't be written out later.  Move it to the
> common code.
> 
> This also removes the comment about the ordering from nvme, as bd_mutex
> not only is gone entirely, but also hasn't been used for locking updates
> to the disk size long before that, and thus the ordering requirement
> documented there doesn't apply any more.
> 
> [...]

Applied, thanks!

[01/14] block: set the disk capacity to 0 in blk_mark_disk_dead
        commit: 71b26083d59cd4ab22489829ffe7d4ead93f5546
[02/14] nvme-pci: refactor the tagset handling in nvme_reset_work
        commit: 0ffc7e98bfaa45380b800deeb9b65ce0371c652d
[03/14] nvme: don't remove namespaces in nvme_passthru_end
        commit: 23a908647efade186576c9628dd7bb560f6e759b
[04/14] nvme: remove the NVME_NS_DEAD check in nvme_remove_invalid_namespaces
        commit: 4f17344e9daeb6e9f89976d811a5373710ed1f04
[05/14] nvme: remove the NVME_NS_DEAD check in nvme_validate_ns
        commit: fde776afdd8467a09395a7aebdb2499f86315945
[06/14] nvme: don't unquiesce the admin queue in nvme_kill_queues
        commit: 6bcd5089ee1302e9ad7072ca0866f0c5a1158359
[07/14] nvme: split nvme_kill_queues
        commit: cd50f9b24726e9e195a0682c8d8d952396d57aef
[08/14] nvme-pci: don't unquiesce the I/O queues in nvme_remove_dead_ctrl
        commit: bad3e021ae2bb5ac9d650c9a04788efe753367f3
[09/14] nvme-apple: don't unquiesce the I/O queues in apple_nvme_reset_work
        commit: 2b4c2355c5e155cdf341d9ce2c2355b4b26c32c9
[10/14] blk-mq: skip non-mq queues in blk_mq_quiesce_queue
        commit: 8537380bb9882c201db60a1eb201aac6e74083e8
[11/14] blk-mq: move the srcu_struct used for quiescing to the tagset
        commit: 80bd4a7aab4c9ce59bf5e35fdf52aa23d8a3c9f5
[12/14] blk-mq: pass a tagset to blk_mq_wait_quiesce_done
        commit: 483239c75ba768e0e2c0e0c503e5fc13c3d5773a
[13/14] blk-mq: add tagset quiesce interface
        commit: 414dd48e882c5a39e7bd01b096ee6497eb3314b0
[14/14] nvme: use blk_mq_[un]quiesce_tagset
        commit: 98d81f0df70ce6fc48517d938026e3c684b9051a

Best regards,
-- 
Jens Axboe



