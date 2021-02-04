Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D217C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 15:25:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D4F564E08
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 15:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4F564E08
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8C20Fu0z0aSpOE5O3w6U+eTFpkHJgCX5HsOQ5AtsVlo=; b=bKhaDvhyzILnaPVXBD8u24Ngd
	vf8C/XDwT1t0p5BUnIkVWocURK9gt8suAVZeuUiHUairOWeFFykXorE6S/P646AnRxA9/Bn6+3OG4
	QC9R+yIDpyRicadp6JB0Ha6BvgNTHgXfSkUC/zNspXixkxlAHWeDv3Wu6GwN+QnEPpkAGetYq5Sy8
	NUKcnLPLk16suUeZ7fOmxEqwZ695XR4Mxrr6ZAUhEz1gPGcMRjBQ0hICUyHf1cbNnww45lDWDPXl8
	octS+WGO8kRGn35cxIa4ZBB2kb6+YH4kpKOS8aac7EM5eLQLEdyK/HMSAFEgRo6NxnjJeeDgcJJ5C
	4Uc3x6t+g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7gVP-0002KX-4z; Thu, 04 Feb 2021 15:25:15 +0000
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7gVK-0002HP-MQ
 for linux-nvme@lists.infradead.org; Thu, 04 Feb 2021 15:25:11 +0000
Received: by mail-il1-x133.google.com with SMTP id p15so2895692ilq.8
 for <linux-nvme@lists.infradead.org>; Thu, 04 Feb 2021 07:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Sai1+6RvSPig1mj2EiQ4vDagcziu7Bdngd2FkgBnOJQ=;
 b=OZbZVdo7cGClKymLkR0ySZFsAezEKOlcNuUn81XUGo0ZOyuJZ4K2KBmboTd+0P64NE
 sdVTkjI3A3rq+eVCEka+tZ9uYlRqhiY3WlrqJstrpbmbVLkNZ0/YfCvlUzO6LbaIKGdS
 7UHLwzkfc3A+GHvOgExu8INoO8SsIFMEBccjmcuqhiExLoYlSBeaGU3whyJRhvshzvd9
 3n00pxoKyqoZ4hWUY1q0EWo+TycsbSJ98w+1AcmL/l3zRG0/1OT7TZ7c60UwUQPolkrb
 2gOjUPF4VqWRekUPKcow/S2KaMM6OqW58Vt7//4vSqe562ZFSuHpHfLp1Ar5QdoKItyd
 MQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Sai1+6RvSPig1mj2EiQ4vDagcziu7Bdngd2FkgBnOJQ=;
 b=j8iRTTIZ1GTtcdZEAQLssoA5lY+7q1wZ9DEYEHhcUJuMeezLdvzojnP3bAqyXcfKT8
 MOPNx48B2isM/8n4B3bNQteSO4s6hlB5Ll+hDCjySeFYJNsGWPZ7K8D6AFys9A1vPvxP
 /sNN2O8mMCISw0cdOM1SCXIXoPyqtz2nfPpwlz2/yK2P4hDUjc2Y49IF9r36cvssW0Uk
 Lvlm2Y6BZccobU0qC81eEfoyKww3hqO7emOdkGT1AFCADlVKpi3Fo0JH15NMhGo3VhV0
 EVLkv3yq5TAsTzUlfhAlJXMGVeXgh4NnLnKeKVOLY6Gh/EpFj5o0SZTHA2zrbbEOPOFL
 t1Iw==
X-Gm-Message-State: AOAM530vDetOZ9e0XyvgEHSV6uwSY5NS/q9ixjiObAH7yCMAaQQujl6W
 xiqailLrqpzDf994voYCs5Z6dxYDm4zg35ax
X-Google-Smtp-Source: ABdhPJy5JJSK6zSOIARcwTjlz4jZA5OUcE/LTqoMFoK0Cyig2FdsLY5dwyPLh0PQY5PEAuH0QTtNHA==
X-Received: by 2002:a92:3f06:: with SMTP id m6mr7143541ila.283.1612452306896; 
 Thu, 04 Feb 2021 07:25:06 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id h23sm2607517ila.15.2021.02.04.07.25.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Feb 2021 07:25:06 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for 5.11
To: Christoph Hellwig <hch@infradead.org>
References: <YBwNukLwQfsXQL9U@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e407087c-3760-b725-4b02-692eee28041b@kernel.dk>
Date: Thu, 4 Feb 2021 08:25:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YBwNukLwQfsXQL9U@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210204_102510_787024_9CF378D0 
X-CRM114-Status: GOOD (  11.25  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/4/21 8:07 AM, Christoph Hellwig wrote:
> git://git.infradead.org/nvme.git nvme-5.11

You forgot the signed tag, but I pulled it.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
