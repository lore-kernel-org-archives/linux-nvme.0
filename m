Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF3CC4167B
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Nov 2023 22:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dsnhXi2Np1/7AoJ4oiM3UjWdMUQBZrbcqrKbF2bClr0=; b=b8xBoHT4CgLsZOS7CI6owkWDU/
	+yhrAT/ysci5qBAl8pSQW7ze3mma/fVv0MZMEzMGk+SgeWZkO5//+4IUpopZiH3FwmSm4QVjoldwN
	i3W9+ZQDXwDGTOLVWNWpqpRyhvipCahz033GXTot7iF8Fr3Sjb6+M5NeMAzXkhhV/K4tJCbsynwBf
	mvWLm8ncTf7b3YRkugZGnrY4VPTlfytIyl7R6GrbSVIGtIpRLH5xTr2tjRhy97whlh14HbRyHiBRC
	jTbjCz7JA/yKphnA1h6ppzkdYlGa6/TEqov+9xkaKZBO/6xo9k3ntoPVPEj4xXkanZB8aFm7gebgZ
	IhsupJHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8p5y-00C0kq-0k;
	Thu, 30 Nov 2023 22:01:18 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8p5v-00C0jG-1v
	for linux-nvme@lists.infradead.org;
	Thu, 30 Nov 2023 22:01:16 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cfc3f50504so13494965ad.3
        for <linux-nvme@lists.infradead.org>; Thu, 30 Nov 2023 14:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701381671; x=1701986471; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsnhXi2Np1/7AoJ4oiM3UjWdMUQBZrbcqrKbF2bClr0=;
        b=CfZqSljPB/HB7YL68RrV5INbMlGmzRVCByqVKC3sRau3RVvj8vnAQg5tpQQZ8hfAEQ
         QKtkUSLrl+YHMUMNc0g7oRFIjgB1P3CpZuGLKj/QcUxob3shgF033HwgPHJrqnkP9hS2
         307QA2DaMwK8TRAQ6u9pwnApqcDwrieeOE4So=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381671; x=1701986471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dsnhXi2Np1/7AoJ4oiM3UjWdMUQBZrbcqrKbF2bClr0=;
        b=ivgYI0NG7LntgphFaWFiYOyWRdf2geZdg0wIYCc3ATghAYN4r8A1G36ixauTvbiVG+
         mWGtUbIB91C51gOyh4zceFz7p/kl47As/CPpIpfNGOUBtezIqXHwGYcFgnUJhKMHANq0
         jiFvEdbWOIGvmvPQCcwE4k7+PzXuoQ9rlHLjYlLtNwwwXTKyCRJMx5NEdKK4wgruwl8T
         xkQBd9+liVYNl8sYPUyse7fTpkBCa0pfBVZIdMJGivH4Uw+XBV2/2hmyYng//EF4LpBl
         MUKqSSUTppqtwwTfMTW7cVJ3SjuTNrkGZNyKzVpDppfQtY7QGMmA+IdCliAmXVLu7rXa
         KVvA==
X-Gm-Message-State: AOJu0YwOWG5tysBP8zjZIGrfXggAeeWkVBznYj0GArxfZyrjYmXo0jXr
	SUy8ksSs0LwJ8aWCClDgP6CxRQ==
X-Google-Smtp-Source: AGHT+IGY5agfDsFxlB2k5UH8mpj8C0v/Uh2rRzfKYSgYUHnOdDJozZIQ756ghTwfc+TZrv+C9gsLzw==
X-Received: by 2002:a17:903:244e:b0:1cf:de3e:e4df with SMTP id l14-20020a170903244e00b001cfde3ee4dfmr15071465pls.58.1701381671024;
        Thu, 30 Nov 2023 14:01:11 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l3-20020a17090270c300b001cf6783fd41sm1911702plt.17.2023.11.30.14.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 14:01:10 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: James Smart <james.smart@broadcom.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] nvme-fc: replace deprecated strncpy with strscpy
Date: Thu, 30 Nov 2023 14:01:08 -0800
Message-Id: <170138166766.3649510.14295562251346849867.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019-strncpy-drivers-nvme-host-fc-c-v1-1-5805c15e4b49@google.com>
References: <20231019-strncpy-drivers-nvme-host-fc-c-v1-1-5805c15e4b49@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231130_140115_632198_9B649930 
X-CRM114-Status: GOOD (  10.59  )
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

On Thu, 19 Oct 2023 21:34:35 +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> Let's instead use strscpy() [2] as it guarantees NUL-termination on the
> destination buffer.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] nvme-fc: replace deprecated strncpy with strscpy
      https://git.kernel.org/kees/c/f62cacf390b7

Take care,

-- 
Kees Cook


