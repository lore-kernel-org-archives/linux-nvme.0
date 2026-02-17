Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B5AE9A029
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Feb 2026 17:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4dyoQALK3UpZsKvQZapV/kBgywQgWDNhj/strtjOdpc=; b=upfCAA8nlLvmu1CIjcjNf17Yhv
	bz2X/6cx1pBQgjj2lGyqd/bF91P+D2HdnnWY0ZhCAcNti6Uob4BSms4fK+HSYAjW6o6o7qFLP5hEL
	zv6ephsxAATtL4dlCOcmMp+7KXZD8BX7kuKlWtD3lYrLsf/DOIgq4ezC6Oew89xqRX6UIlZm8MZmf
	MlCtHTOq9jO2tVMdgXJFik7yJl0WmBfIayVMQiqAPCFm1Kr+fG6gKFo9Fx9P9sHaDHo9cJdN6C5gf
	WT9sJwZTMBWnI0DRcnPI+PrBuYN35finxecDRZQa4y7J4q1nGqngWOASdGPHVi1KV95cZ9hABRUfY
	HeG2C+0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsPLg-00000008gnn-1AVs;
	Tue, 17 Feb 2026 17:59:00 +0000
Received: from mail-dy1-x1331.google.com ([2607:f8b0:4864:20::1331])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsPLX-00000008gnR-2Ejc
	for linux-nvme@lists.infradead.org;
	Tue, 17 Feb 2026 17:58:53 +0000
Received: by mail-dy1-x1331.google.com with SMTP id 5a478bee46e88-2ba68df3687so7717671eec.1
        for <linux-nvme@lists.infradead.org>; Tue, 17 Feb 2026 09:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771351130; x=1771955930; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4dyoQALK3UpZsKvQZapV/kBgywQgWDNhj/strtjOdpc=;
        b=fqJlzYsfZLM3DMD2NksD8RSTtajwdNhT+ORuicZRifXgVSdWUm2NCVUPB80PmaRa9D
         yHm7ktjclv0m1hBiaSqN+uXHwM6Bxf7E1tif+/9EkOy6qMLlo6FARPWIut8X3lIfytRS
         3S7BpDyq3ZCQ3Gpfc25jw75/PN54aFGn8Cy2JXmQkC2zh6AMdZQO9Nr7EyKPW3AwlzVU
         Z2xbvp41hw0P01vPtiLkjEzBy/PGltuIBysk6GQ0WMv2kvLUf4cFvVT0/fEqKceocJeA
         Ev2icfbLW4L3/Xja+BLOSQwYuNwN1YSeGqgmsh7yEBBft44rD6ttvtY/ALLEDCIWPKwx
         U/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771351130; x=1771955930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dyoQALK3UpZsKvQZapV/kBgywQgWDNhj/strtjOdpc=;
        b=nVMYRyeHeOTZUcmkItjT/DzmDZGPhkI8VR8SxxmCzjA94euTi8A9CWDbQJey0KIXh5
         924qdfUgC2SE4M4W0G9DxDX5bjWIr8tvK3x8i+7vL5qKpMytk+rYMEOaPrOQpyZ39W6u
         SBMekc1UrYifT06lDQahOO9pYAFUoTIyO5hTYBm4pdbQ00PPXATnyTIXIIHnAirtH7m+
         om/YZgVBiTq9Phfv6YoNMNLzCwS1qQkb4TjxeCAGMfCLvGoF7HHMz0BBuFWDxsKfnknk
         i0M+MmEGN22PRFU3Tb/t874IDkSLbW4LcD2GBVSwAWzDIOhawfXO2GhPyLTRtFH6bs09
         COng==
X-Forwarded-Encrypted: i=1; AJvYcCX60Tf8FaR7x5YgYWTuwBukRzzXLD8mBe0Tx5COjlB4irP1SEA5+ZPlhZt5YZS/12nVZuzWlFf+zgkb@lists.infradead.org
X-Gm-Message-State: AOJu0YwBzBRjjb0g6kp1AcK6aDVhAynhV6T9xCfG5dX9vZ/kWKe0SkrV
	0IZAYV/ukkCPqFuzPuG5Xd4uFm10szDN9nTNY/enBl0V3DjTEGUQbd5xDz2r85uYU88=
X-Gm-Gg: AZuq6aKUAbW43ovZPZ9v8qyEFfJ/4S1u60QQY43+WeQGzJG72D6oHqTzVXiwcsHyGM8
	7yXKqy5F/LdE03ULXTy+yvx17D1tNcJMhpN5hvDxs8A0TiZZZuAXfv8pbvgsjdePx1MokVMnduo
	qjL4iAN72FUDw3fmB6BmPnkJgWc09QnaZhhIMs4T1+BXLAUXHLeihnDyoGrBwPB8U+dWRqnXeXo
	xljGUu3P/V2QNFDNzO76uQfhuwu6iSwsPeVL4jwpo+RgMFgfq9vm0NGEoDjvuIRfV99RzGCt87I
	54FOCHEdBIp+cM8wgzCf9jvnXx3ljl14rXgWny7jt3N1ph6KMN7YXXoAAqJN6OB47S2nxIwGpR8
	+D/btSFo8qg1F640SpVeAs88dnG+vvXw/IwJP2vKVrysXcyx3G/RAngzZIS/zQz5/mMciTyRlIP
	NDPmgKVqkhuI5e/F9I3t4jMgbntoSY+ZK4+qLwD4RFiyI=
X-Received: by 2002:a05:7301:4083:b0:2b8:6b32:1cf1 with SMTP id 5a478bee46e88-2bac97c5053mr5778400eec.29.1771351130179;
        Tue, 17 Feb 2026 09:58:50 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id 5a478bee46e88-2bacb6782e5sm14878843eec.29.2026.02.17.09.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 09:58:49 -0800 (PST)
Date: Tue, 17 Feb 2026 09:58:48 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 19/21] nvme-tcp: Extend FENCING state per TP4129 on
 CCR failure
Message-ID: <20260217175848.GD3435530-mkhalfella@purestorage.com>
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
 <20260214042753.4073668-20-mkhalfella@purestorage.com>
 <7fcdb6bb-34b4-4b73-afce-75c423f8400b@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fcdb6bb-34b4-4b73-afce-75c423f8400b@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260217_095851_934120_E0AB113D 
X-CRM114-Status: GOOD (  19.60  )
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

On Mon 2026-02-16 13:56:10 +0100, Hannes Reinecke wrote:
> On 2/14/26 05:25, Mohamed Khalfella wrote:
> > If CCR operations fail and CQT is supported, we must defer the retry of
> > inflight requests per TP4129. Update ctrl->fencing_work to schedule
> > ctrl->fenced_work, effectively extending the FENCING state. This delay
> > ensures that inflight requests are held until it is safe for them to be
> > retired.
> > 
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > ---
> >   drivers/nvme/host/tcp.c | 39 +++++++++++++++++++++++++++++++++++----
> >   1 file changed, 35 insertions(+), 4 deletions(-)
> > 
> Can't you merge / integrate this into the nvme_fence_ctrl() routine?

ctrl->fencing_work and ctrl->fenced_work are in transport specific
controller, struct nvme_tcp_ctrl in this case. There is no easy way to
access these members from nvme_fence_ctrl(). One option to go around
that is to move them into struct nvme_ctrl. But we call error recovery
after a controller is fenced, and error recovery is implemented in
transport specific way. That is why the delay is implemented/repeated
for every transport.

> The previous patch already extended the timeout to cover for CQT, so
> we can just wait for the timeout if CCR failed, no?

Following on the point above. One change can be done is to reset the
controller after fencing finishes instead of using error recovery.
This way everything lives in core.c. But I have not tested that.

Do you think this is better than what has been implemented now?


