Return-Path: <SRS0=f2/u=AV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D6CC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jul 2020 04:48:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDFC720720
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jul 2020 04:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="3UPvBwP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDFC720720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3lED8ZZoYOgg7Z3Q/KlQTPKUnU5W9A1rboSB11qPhcQ=; b=3UPvBwP921hPhtDvZvIQ9lM28
	GX3E5dCi83jQApbM1O7PRfD9RqD55O7qZiuZGEYFG5XEXKWuhsFx0G6wWnneWm6uUXmi75BfwQepZ
	5KDnpXLFI+11AVISvKo+PUFfX5vL1vYeZCN0Vf4bv+/8rgrRP31Nbrh9e4o/Cvcdsuv25ep5dCsdV
	ekxJtzA3o9nxXGCGR9vYkJS4OVHl3/JN7nl08/qwetoFOeyr3JWzEkEgJtHLgIjF+FKo/GakmYtkO
	bjyZwGJkLVkDU/fnWti5zRBehSDGvqi9OlQkNN9fhta/MmRmxSamtBQBAkNbsYTAi7E52gl8DpXpP
	D0XOKMMrg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jtkx6-0005gJ-BY; Fri, 10 Jul 2020 04:48:00 +0000
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtkx4-0005ft-1f
 for linux-nvme@lists.infradead.org; Fri, 10 Jul 2020 04:47:58 +0000
Received: by mail-pf1-f195.google.com with SMTP id u18so1984372pfk.10
 for <linux-nvme@lists.infradead.org>; Thu, 09 Jul 2020 21:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UsLlt2DbrhFxC86DB28jO2t36OOzunzd2BY3+i2qneI=;
 b=Tdc+uPpJegYyIEp+lxl2NgiUK5IBG/qanJgS6QWvex3Wz7b2OnjCzDAncLmcFmkK12
 GP+2ECA2prc/ouNiLj9ceQ2GNV5ho7DTEEzjJx5+2tQVeFc1TrVve3DgEfce5uAGSKe7
 +kpsO1L0/wd26N8WVPG2LHv7A7az+DOTlz5u9GDDcsUHaQG/cTpkInegJgO1OonH9ZMk
 M24UEazSW2rHPRuHu6BwUvbxYAgwK/+s8hguBAyzwGvC+YRPEXuFIlkh6v8pYhFqDtE5
 JG8Fb4kaprJhj8S0cuqIWc3zXXZSJgwO0nO2nPpRRDPfzKfpM06DBYfWAL+8zAAAqikx
 YNNQ==
X-Gm-Message-State: AOAM531KDuBsjXpkVTl0Wft0FbhaYJ0Bq7tVjpbXpPDE3w0Jsw0FL07k
 aIBsTXszN7SpvvugQ6uWUjK9uqgM
X-Google-Smtp-Source: ABdhPJw+PVSldQ13gVrEGc0SYSIbiu12JYU30zBI2GenuP0jGkDToQ01VEEZzYudnH+d3L7INWU1tQ==
X-Received: by 2002:a62:7653:: with SMTP id r80mr38946941pfc.236.1594356476556; 
 Thu, 09 Jul 2020 21:47:56 -0700 (PDT)
Received: from [10.92.82.19] (h208-100-138-50.bendor.dedicated.static.tds.net.
 [208.100.138.50])
 by smtp.gmail.com with ESMTPSA id c27sm4317988pfj.163.2020.07.09.21.47.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2020 21:47:55 -0700 (PDT)
Subject: Re: [PATCH v2 for-5.8-rc 1/6] nvme: fix possible deadlock when I/O is
 blocked
To: Christoph Hellwig <hch@lst.de>, Anthony Iliopoulos <ailiop@suse.com>
References: <20200624001853.5408-1-sagi@grimberg.me>
 <20200624001853.5408-2-sagi@grimberg.me> <20200624062902.GA17594@lst.de>
 <84583b2e-d59b-01bc-1737-5db107999d84@grimberg.me>
 <20200707105735.GA16868@technoir> <20200708144227.GA23255@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <14fa863b-d189-7866-9343-3d5777461c83@grimberg.me>
Date: Thu, 9 Jul 2020 21:47:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708144227.GA23255@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200710_004758_130544_4CCF5DD9 
X-CRM114-Status: GOOD (  16.30  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Anton Eidelman <anton@lightbitslabs.com>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> The revalidation is still required there in order to update the blockdev
>> size when multipath is enabled. With this revert, the behavior regressed
>> back to before fab7772bfbcf, so the size isn't updated under multipath
>> when the device is in use (e.g. mounted), it will only be effectively
>> updated next time it is mounted as a side-effect of blkdev_open on first
>> opener. This prevents online resizing of filesystems.
>>
>>> And if you look at revalidate, it only calls fops->revalidate_disk
>>> (which is a noop in the mpath device) and checks the size change.
>>
>> The mpath gendisk doesn't have a revalidate_disk fop indeed, but call to
>> check_disk_size_change was needed to update its size. Otherwise, the
>> size change isn't reflected externally to userspace before next mount.
>> cb224c3af4df doesn't fix this as it skips revalidate and thus also skips
>> updating the size.
>>
>> The issue is that under CONFIG_NVME_MULTIPATH=y the ns->disk becomes a
>> hidden gendisk (see nvme_set_disk_name) and thus doesn't have a backing
>> bdev, while ns->head->disk becomes the "visible" one to userspace (with
>> a backing bdev), and therefore needs its bdev->bd_inode->i_size updated
>> when resized.
>>
>> The following patch seems to be working, although I'm not sufficiently
>> familiar with the code to tell if this won't cause any other deadlocks
>> with some confidence:
> 
> This looks sensible to me.  Sagi?

Looks sensible to me too, but let's add a comment to clarify the 
existence of this please.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
