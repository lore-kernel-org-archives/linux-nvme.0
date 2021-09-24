Return-Path: <SRS0=ODQg=OO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1ABC4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Sep 2021 13:23:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63FB86103B
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Sep 2021 13:23:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 63FB86103B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=i54zSVqFyEl85PKyCGGwBq9AozEe9Lsbmf0Wksj5eyE=; b=ucKyDNIQkxuCgj4q+krckddpxZ
	6Mdw6BefjszR3NQbhOvP5HJzDAzRD8W2F6d8Ae+oZHgErCFk1+dGtRop4emRjA9GZZkh5uiUFsqoI
	BC3qRb81FkUF4y7KyfREm2MAnv+0sImOGvH32a/h9QyJzJLHA9mqrm+v51bwGZX3AVs9oAVLkJ0fA
	jM+KthVZ3wKRZwn85MyJvwv1VJ0MAjadgeJwjc7vfXur7p2sFuEiOsVd2KXGcTxgbHoEcVZOQ1gk9
	MGh2SWVO4xIqavf4IIQ8V4+byElDf2ME8arO4mWP9GwgU3lxuK4f8Jg95VIXkjw6wiOyuVaadrE8O
	aqf14cjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mTlB5-00EYQT-W1; Fri, 24 Sep 2021 13:23:48 +0000
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mTl3U-00EVAI-N2
 for linux-nvme@lists.infradead.org; Fri, 24 Sep 2021 13:15:58 +0000
Received: by mail-il1-x141.google.com with SMTP id b8so10240673ilh.12
 for <linux-nvme@lists.infradead.org>; Fri, 24 Sep 2021 06:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IQN9DP0M41u2cr727GWUuFS+FbSRmoFH5BT+NmKfBVo=;
 b=0ivsGxgqYM7TnLQGtxH5qjhcLwDtPTSjzgb2gzXSWk5YWRAAcXfHTkWOxIEQr6O14a
 dN1S2DmKdLHolCiP1kXzaa7YX7kJlbua1dmFUX+izljooBJAYVciEi8bJ9hofKKbD/wd
 KYVPWc1o0/IzHFXSppiWGYJS2fEpSvYm+h3PkrWxQU1PtLUV22mPXJFu3EXUODsdlfmc
 1oGcQ57nCDgpeWP1G58dAN1cmRXCNqvURVMr5fy431FhE9jneFQJClpd9a40rqJRHS/7
 uiiX8woixAXBalNgUdUhltv8q12oQrIdRLAcTDCpUEtvgiSL3dm6RYWFOwVWHHygJ1U1
 GSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IQN9DP0M41u2cr727GWUuFS+FbSRmoFH5BT+NmKfBVo=;
 b=2b22z402InnsUsuAU7aIOg5JyvgguYINJQfRFvMcnc0ZtJyTZbUzuYO3+11VDEK4qF
 QqGE5hmJUpmMv7bfYRY08NcGwHaLy1IqkESTiHVDWOPrVtpmzHExpVjpTWV9Iu7BeX4t
 8X03leO+N+taQlwbK/AQg/DyHH2d0/KMPfAuuMeg9yVpf+s9l1tkWWTdxc2Qfau4MdRX
 nBSfAVEYVIvkaPCFF3OJTr2rUQUhheaKyTxCRen9pcc6sQdYzN5rXWyCOVej/34ppJ5F
 /1x+zBltDKXOdJqJPt0ac1jgJVMNPlsp9TQGtjGtM3U7o5Hmz2oJoVyoDvT0ORcxktBG
 igwg==
X-Gm-Message-State: AOAM531OmSjU/Vb0GkkXbGvDox2SI3tM8vn0ADRcd5xFW5ffKth0Ipp7
 PISvnVB6c1VQOgVMJz+RwQFeAxBBN3cD+R71rI0=
X-Google-Smtp-Source: ABdhPJy/y4iAfP7x2vzAcTTt2bxFyqaDRkQ2Oj4i3wDUnG7kGhD5OtkI+slaMY38uFkKaMJQKYiO0g==
X-Received: by 2002:a05:6e02:b23:: with SMTP id
 e3mr6298407ilu.53.1632489351553; 
 Fri, 24 Sep 2021 06:15:51 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id r3sm4177181ilc.56.2021.09.24.06.15.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Sep 2021 06:15:51 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for Linux 5.15
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YU1yBgH+CqJu9h5u@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <cc838154-552d-56fc-37dc-393910b34f50@kernel.dk>
Date: Fri, 24 Sep 2021 07:15:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YU1yBgH+CqJu9h5u@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210924_061556_861872_2F3248E3 
X-CRM114-Status: UNSURE (   9.39  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/24/21 12:36 AM, Christoph Hellwig wrote:
> git://git.infradead.org/nvme.git tags/nvme-5.15-2021-09-24

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
