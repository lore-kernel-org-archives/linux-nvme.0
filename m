Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2951CC433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 11:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ttpTIbofLsUG8grz7OGVh3/t1pK66IdyVLhlZSTgIyw=; b=anKwgKfL6H2xHyWl4yEYHs1lxa
	NRIYxBW3sRwSpZFy7Jy/gXPxdaqQzXOPkwl/Peq5bHC5rHE3Kforr6AvFYQ5aH57+j+0V/4HxQDjO
	Svgp08/B9goyLSVrvLsxy0oXqQQk7x0IPWSDb6P8IE5/GGi3Ik6AgWV5cwoLUB6SzgZjqvcC2Buy3
	e5ziOvDcyK1usrnUaN7idjaq2dtPEigHTtODoqQHRuJkhvZW0u3Zi4KWCQLERgPsmPkNgxjNtyOW8
	eFGhVAImSp5B6zVR4HwhBA/gvmSPmz++Ras+A2TnOuny/Lla5K/yPU/mw7wGw4pVv1r3ZKCvIbsq1
	IOH5uc8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncQh8-00BfXv-8R; Thu, 07 Apr 2022 11:52:58 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncQh5-00BfVt-E3
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 11:52:56 +0000
Received: by mail-wr1-f49.google.com with SMTP id w21so7510597wra.2
 for <linux-nvme@lists.infradead.org>; Thu, 07 Apr 2022 04:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ttpTIbofLsUG8grz7OGVh3/t1pK66IdyVLhlZSTgIyw=;
 b=XYUSDHQGPgy7ou3EXT+0LFb6gStcliqRlMAh4N+s5a5jJHcFYXoF2PUVVqhnYV415h
 ZZ7/SZTrIrQWcnWS42HPXqX2MQkLQ5jliGBi+TF3xLL13aV33XPA2TwWgK4flsQs+SB9
 Dcay1u6UBjRG1N6zJVeFF+m0Zt+LAJ6Mus461xWnFXl8XmtK9PAYzPFqbtZqjRx5D6l4
 2W6UdPwuno38p3p+iUsQcyUuYZv1IX07UvK6DkKZ6KtNAnEkvD8MXOLey6Ruv2eHGCPq
 udXmTO0jS+h9br0VZdNNZ2Bt5rjG6WLa2Qc4unxNJQBsLSrMP6cyP2vNyXW61qeIA9X8
 msGw==
X-Gm-Message-State: AOAM530V81Nyn6jEqg7T/6fr7uIZvMqogdPy+VIbqdsxhCLh2sciCc5J
 pMTKeZfL4S6S/hDmQEwGR50GP10Pe7Q=
X-Google-Smtp-Source: ABdhPJz4GIzV5u5DkeGWlsmXNQnY7CN0TNvbD9kNJukSmTZZgGv7n1DYfQIAkp++EcZyWcQlWcUBtw==
X-Received: by 2002:adf:e74a:0:b0:1f0:25cb:3ad5 with SMTP id
 c10-20020adfe74a000000b001f025cb3ad5mr10518556wrn.231.1649332372895; 
 Thu, 07 Apr 2022 04:52:52 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 o29-20020a05600c511d00b0038e3532b23csm7494117wms.15.2022.04.07.04.52.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Apr 2022 04:52:52 -0700 (PDT)
Message-ID: <64ff1e92-6c6c-da38-8753-0e6098394622@grimberg.me>
Date: Thu, 7 Apr 2022 14:52:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] nvme-core: mark passthru requests RQF_QUIET flag
Content-Language: en-US
To: "hch@lst.de" <hch@lst.de>, Alan Adamson <alan.adamson@oracle.com>
Cc: Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20220406164109.30449-1-kch@nvidia.com>
 <Yk3FT78uVW+9rRV5@kbusch-mbp.dhcp.thefacebook.com>
 <21a3a237-5f3b-a608-2d79-e0a5fdcc0d88@nvidia.com>
 <Yk3MNrI3YfjvbRqZ@kbusch-mbp.dhcp.thefacebook.com>
 <92C8BCED-6845-46D4-BCD0-78E790A5F86E@oracle.com>
 <20220407085113.GB19062@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220407085113.GB19062@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_045255_535774_B3B6A7C8 
X-CRM114-Status: UNSURE (   9.19  )
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


>> Using RQF_QUIET or blk_rq_is_passrhrough() will mean no nvme admin-passthru command will log an error.
>> I ran into this using the blktests I’m coding up for verbose errors.  Is this the behavior we want?
> 
> Well, you submitted the logging so we're curious about your use case.
> SCSI skips logging errors for internally submitted commands, but not for
> userspace passthrough.  So we could move the RQF_QUIET into
> __nvme_submit_sync_cmd / nvme_keep_alive_work / nvme_timeout / etc.
> 

Makes sense to me

