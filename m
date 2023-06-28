Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A782EB64D7
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jun 2023 06:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1pZbFxIcZMSIDGAB65+74vd6qFZmRBObj/WnklXfrb8=; b=k4ZtAwe/LiWlYxA4/kPWsGMFDz
	g5tqVBkOnum5FAcykqyLQct2gn9ZASvmxs5ejxSYfD0a3OvXlMQPnkHb+aAXANLteHfK1aCV03tP5
	q1Tja0sa9/m8Gwc3YQfnGMQ/sP+5mS/bvKeNxLzvY1KsAmSIXieOKm1zHzQnVuRQDa3abjb+qX0HC
	Rtm/hGP1557bxxYkp8BPEMheTRnoTmz+VyqRj2l4FYq3kGDFFUge8O9svQtBBNuk3Khnfbw8CmyeW
	MNry1581ReM2b3Bs4QQiwHHOWtjUMX1SCKSWQZ04NGeHDEdUTBtayCzVnZk+p/gX0Umwg5o3ZIzTI
	1V2dSkSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEOv4-00EyhY-0u;
	Wed, 28 Jun 2023 06:44:50 +0000
Received: from mail-ed1-f48.google.com ([209.85.208.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEOv2-00EygH-0S
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jun 2023 06:44:49 +0000
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5183075a5ecso1190335a12.0
        for <linux-nvme@lists.infradead.org>; Tue, 27 Jun 2023 23:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687934681; x=1690526681;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1pZbFxIcZMSIDGAB65+74vd6qFZmRBObj/WnklXfrb8=;
        b=cCHoXTawZrs3rf5f5PRA7QeEKiTAxqhnsvL8s2PpCkCWMKnYIhmaj7X7RtKY84KahE
         mqXItSppYNJZO34O7rlnxoHXHsFu7khPu2CGf1ca7kcOhEOO+q0E/WAFhX3bofowSlal
         60DL3d1Sm0D14uohF32iT73J6T+z/oODZkrL5CzIryFzyKKdBBn9vf6/hMeaMnnECfT0
         IdLl3VZfM20NjUkOCN6f7sBNMJ2IkZh92FT/VNgP7K8FEmrEaQKOWDSlOrb0kPqjKTcQ
         tovEo0uGN7FkuiWU0M2aa3m5QGdQA4vECiZCt/EWUWkjW5YC6QGwoWJvlrUQASkIn/md
         ToFg==
X-Gm-Message-State: AC+VfDyVUyURVZbIulfczIxQqIa/V/G55wbVDaUxKjSJsMViYF+bQ3Iy
	+ncUHWeHPX4ZcHS6sT+52iI=
X-Google-Smtp-Source: ACHHUZ51mLFVptgVLuS8G/S4W7bTQGVCBD2vo+fQonFZNX7WnhyX548DdNPJEq1uJDaC2rQnv6Pq0w==
X-Received: by 2002:a05:6402:520d:b0:516:463d:8a10 with SMTP id s13-20020a056402520d00b00516463d8a10mr3397057edd.3.1687934681205;
        Tue, 27 Jun 2023 23:44:41 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id 25-20020a05600c029900b003f42158288dsm15773817wmk.20.2023.06.27.23.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 23:44:40 -0700 (PDT)
Message-ID: <8dc6852e-ee90-ed64-1d3e-9ecdc9f4473b@grimberg.me>
Date: Wed, 28 Jun 2023 09:44:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] nvme: mark ctrl as DEAD if removing from error recovery
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>, Chunguang Xu <brookxu.cn@gmail.com>,
 stable@vger.kernel.org
References: <20230628031234.1916897-1-ming.lei@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230628031234.1916897-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_234448_180399_83728CCC 
X-CRM114-Status: GOOD (  11.79  )
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


> namespace's request queue is frozen and quiesced during error recovering,
> writeback IO is blocked in bio_queue_enter(), so fsync_bdev() <- del_gendisk()
> can't move on, and causes IO hang. Removal could be from sysfs, hard
> unplug or error handling.
> 
> Fix this kind of issue by marking controller as DEAD if removal breaks
> error recovery.
> 
> This ways is reasonable too, because controller can't be recovered any
> more after being removed.

This looks fine to me Ming,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


I still want your patches for tcp/rdma that move the freeze.
If you are not planning to send them, I swear I will :)

