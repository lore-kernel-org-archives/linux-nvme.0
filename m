Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA17CCDB465
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Oct 2023 14:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5fifJ8M7Wg0VPiWIYsWFkV/TuHvKddh5n/jvR7Nb2rI=; b=IuWu5lPPH7AOIZ+gNECy3LpNsn
	Ka4s74+4mvIgDvXjsMdNN1mM4loM7NDguIb+yIdn/OSNCb7fgrMm2PAFjrgo0U8EK2jTXEv5bVGnq
	lydzpDmdAIpscY0DTQshcRFgQ8sUYTaSno/je9KnF6jC2Wmok39HQWPVVe1PP5WTkef0QyMA8sXUt
	LNiDRhIPYgR5oSv5rDbdSNS4zBDV3IIh7008KBhmB4Z/ftGEuzLr3+4niaa/aZuLCeDaSUQHhXxgu
	YEieFGqzFfUZNOHbZcrngUewsmDzf5tUetJFlNPgwwd3wy1oHHmKEQ/GOywP8ra8c4c2fCmuYAwyF
	vq2Cg9qQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtTqB-0002q7-39;
	Thu, 19 Oct 2023 14:17:36 +0000
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtTq8-0002pN-1Z
	for linux-nvme@lists.infradead.org;
	Thu, 19 Oct 2023 14:17:34 +0000
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7a6643ba679so16784939f.1
        for <linux-nvme@lists.infradead.org>; Thu, 19 Oct 2023 07:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697725050; x=1698329850; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5fifJ8M7Wg0VPiWIYsWFkV/TuHvKddh5n/jvR7Nb2rI=;
        b=KZb/DhaM264137eXbWlnDb7fyRE/DpyNXzNE9KzkxCRGViMvyUk+Bm9oJTNFd1xut1
         W56NJMm5aw9gKB8e1yVzWrdowbkl5P7yOG4The4y0J9hGLYpxbr9ZcF7B2SEvJL+kfqZ
         Apj4bkOHhn48GaEc7icqECrwtuLKz4sPL8md8jRdua4BPIvy+ySfCzNK7e1jVrflgt2G
         WkHTwzQUegIFggF4Z/XGhPKRWeSTUl4M06EBpkmXncNs7Uuv0YTmO7+XQYiFDP8He58y
         2P1ZsUiaZi9iYs+Dv5qjUN0Xl+TIu8DvMmA/6crNNXDnmOpc0bBETT6oyMqHUK2oqs63
         2BsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697725050; x=1698329850;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5fifJ8M7Wg0VPiWIYsWFkV/TuHvKddh5n/jvR7Nb2rI=;
        b=JfkIQgnqEJRcJUTNyFsxBJ10ddKosykA5AzTRMcgDkIno49I3aYpeUCLGcxcORbqkx
         G1qKP+2pnylDAOXZKZQU6KziiB/+hhp6bz0CRLoLLoSn4eTbWgK9bz77OUqASOtDKs4C
         o853SwhtXM5Q4r2gS/LpKZvbJTyY7cgl+ovXL3pn+3up+N0wZcHvHvuOVBPC0fOf1CYC
         EWvtGVfxZbZuWUnzX9WMOpsJnajpYKfO/MHXY5reCBoajKAhf3urbbD8Z24u88xCVThT
         xiYqwW1H6QXgXr0PPrtKNybeFPrso/XWHRlsOin45DF4oIt7RnbDeaNLy6fvl7oXMV8D
         yysg==
X-Gm-Message-State: AOJu0YzfTfJhSNXFOdBrbtlpQvMUrId+h/Ott2Ji2JdCDl01tEJjCtlO
	t9QwYZJhR7vwYzTJpJDKUESLCQ==
X-Google-Smtp-Source: AGHT+IHlDul50i0PyLiMy+ZUZ1Revdx3gNjD2qFfE9/VpayzyZzVT7I7aOLwPWdW/C9EFM81FnX2AA==
X-Received: by 2002:a05:6602:1b17:b0:79a:c487:2711 with SMTP id dk23-20020a0566021b1700b0079ac4872711mr2529631iob.0.1697725050234;
        Thu, 19 Oct 2023 07:17:30 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u6-20020a02c046000000b00457a6f281ddsm1922781jam.59.2023.10.19.07.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 07:17:29 -0700 (PDT)
Message-ID: <6beec109-8611-4dde-adaa-3d7bb0e3ca21@kernel.dk>
Date: Thu, 19 Oct 2023 08:17:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvmet-tcp: do not try to cancel uninitialized
 tls_handshake_tmo_work
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org,
 Maurizio Lombardi <mlombard@redhat.com>
References: <20231019133417.23440-1-hare@suse.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231019133417.23440-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231019_071732_737182_D7E1B076 
X-CRM114-Status: UNSURE (   9.53  )
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

On 10/19/23 7:34 AM, Hannes Reinecke wrote:
> The TLS handshake timeout workqueue is only initialized if TLS
> is configured, so we shouldn't try to de-initialize it
> unconditionally.

Please fix this properly rather than working around it. Either put the
work item inside CONFIG_NVME_TARGET_TCP_TLS so that any unintended use
can't happen in the future, or just initialize the darn thing at setup
time rather than have this conditional.

-- 
Jens Axboe


