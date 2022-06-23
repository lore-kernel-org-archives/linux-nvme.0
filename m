Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF6EC43334
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jun 2022 13:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vyl3MVsTJITPEqW0N8buYuq986ADki9XTkUMF1TuePg=; b=t2xv4HyfIcGY2al0q3TveWzk+b
	DjgbyXUyajDVvmusZukYp9ll5MtJP6CFddRufdp1osrrJQS6TCTQWyQLVJGwp0dIndKKOGE7fZ4OM
	NvaPIV/3EiHOjQ0mNdMrkELh6adQAY57z7DtxyIIL44BZsVPDnclzpyF83FhfO+28Vi4M7OV2GXP+
	EDB69HmpeCdoTha0d+dHTA4eS5yhLSB7Jzzu9++djQ+yT+5OgSl41vZZZmwOVCr2JmVpsYsHrmhU4
	/dDSuAlsqfsIm9FEZC1zVT++4ld8ZRrQUCdPRZ+JqbC5/7Inuxzlikhofr3BMDAoHCFNvv8OcBIaW
	HhEQs9GA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4NJG-00FR0f-7M; Thu, 23 Jun 2022 13:55:50 +0000
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4NJE-00FQzc-0r
	for linux-nvme@lists.infradead.org; Thu, 23 Jun 2022 13:55:49 +0000
Received: by mail-io1-xd2f.google.com with SMTP id s17so14726292iob.7
        for <linux-nvme@lists.infradead.org>; Thu, 23 Jun 2022 06:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vyl3MVsTJITPEqW0N8buYuq986ADki9XTkUMF1TuePg=;
        b=K8LkDWESjxCVRqHy4/VcSS/W3Z+WD7/Rl5LQ4+OG+U3uPFMNkUGR07RKMq8VfLa0uE
         tjF6hq25EGBvFVQwesl/WoxZRQXk8PAGrMLcHCoqxFqrtJHlAJT1K0dyw/a5KkguqZ51
         f827IbMQVA8IrB8mvMxNZVUiRKb6ionrbSUjPx5xjx28jr5Rtp47GtE+BYnGDGOUYiGs
         KxIxPyPInFtkxF3cRl/93rrkhz5AKQCgPDQh8nBZQclQw5Gw4rm8b01jGmKkdEo8aXGF
         T+FFZF6/c2ckGR6/bifespv9J8QJ94c0+ChmFE/Jq4MLFNm5DfIDep2761IoRBKTgOtu
         tryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vyl3MVsTJITPEqW0N8buYuq986ADki9XTkUMF1TuePg=;
        b=UW7s8AhEWOJwtIzPr+U8zvkGobBii5KUqrgZzIGeKhorBI6dGd661UnRI73vdzvkRY
         bK2jhhxVu050GQbPvuga/HsAIEvadVzYjdd8ypUAsnKRsh/rNpJtvoTU0XC6H6o1E0yW
         0sb9l2iVC05+jLRb4B29tNciYGgd+Au+4MetlCetQXWj5jCT6A16kNSkFkAlo0ooVY9c
         JMXAhiP6vb00stS9952J1HPho1WjIs9cB/i6WvH0WlT49ijtcsS/lkYEBEVWmkU2MMcm
         79dPvDTa5UlWUK/6QCrfUemYHOaTBM+pNp6L7nxTYzkVgVSNXAEh9Tzgi2ts0eS7Wc3+
         ohgQ==
X-Gm-Message-State: AJIora/QYAD7vwFwAwkoU9QJm+lM4tE29mmLp33fP6gpQfcJGgwZSi5l
	NGBSjbtwjls1t+8QudOh+2MkOQ==
X-Google-Smtp-Source: AGRyM1u59WCPRQ+922XZMwCmGKVmkmNCphLi65/kEOJDsYAMjuXKceUjlnia9MSeMuywd4RIO5XatA==
X-Received: by 2002:a05:6638:ec9:b0:339:c3a2:b14c with SMTP id q9-20020a0566380ec900b00339c3a2b14cmr5346253jas.128.1655992543649;
        Thu, 23 Jun 2022 06:55:43 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t18-20020a92dc12000000b002d909e3d89esm5782494iln.60.2022.06.23.06.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 06:55:43 -0700 (PDT)
Message-ID: <ea17cebe-ea71-db73-2f91-199ddfd051f2@kernel.dk>
Date: Thu, 23 Jun 2022 07:55:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [GIT PULL] nvmes fixes for Linux 5.19
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YrRwn7dWdJcI9DSL@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YrRwn7dWdJcI9DSL@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220623_065548_112240_08E9E625 
X-CRM114-Status: UNSURE (   8.82  )
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

On 6/23/22 7:54 AM, Christoph Hellwig wrote:
> The following changes since commit 2645672ffe21f0a1c139bfbc05ad30fd4e4f2583:
> 
>   block: pop cached rq before potentially blocking rq_qos_throttle() (2022-06-21 10:59:58 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.19-2022-06-23

Pulled, thanks.

-- 
Jens Axboe


