Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958DDD3C52A
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 17:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OMkSb8BPvoVSLrXlyNMdZM0fsZU9mALmeiczlMJ58qs=; b=P5kfmf9Z8+EgLykorWocdEN9zp
	hoLyPhb9Qcidv+lhxUf27sNphkRiJQYyyoZ8/T6r22HxIvoZlqEkNYCQljsADQxjFK5gNHGlUtbJi
	nfdCO/wSWyS9wsOQdK2DB/WzRGM1bPSPCQ+vnNKd2LqAhieHkP5vYmVasxxypEcoTb0dJL8vdO/Xj
	ZH9w+oGbmaEX9kzPvLj4hiVyFsX3Eea1xZ0LErBqzN2e9c9HHpf/GNIY7rU7ceme0Q7ibidlcFkyp
	EUJbg9DL5q72Y0iqYf42PbnOuktFIUbSRf0X5ywclhframBPhakPrUQe6ndp4j4G+WRyJZhlijIjm
	c0fRjimw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1UUP-0000000FkLa-0hQg;
	Thu, 17 Oct 2024 17:40:45 +0000
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1UT9-0000000Fjxz-0pCk
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 17:39:29 +0000
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-7db54269325so1037480a12.2
        for <linux-nvme@lists.infradead.org>; Thu, 17 Oct 2024 10:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729186766; x=1729791566; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OMkSb8BPvoVSLrXlyNMdZM0fsZU9mALmeiczlMJ58qs=;
        b=sh5j4QwE5KemZ6F4vJu9MQT2WhFB1UXxMwA1L3dmX8ObKv/yQflGlENtibR6XAt/1/
         YloFHCEaKVt1S4f5+WFR1TaDVhxfvf6zw1rilfezL7//RUdgdtYfN13xZNF4tnBzQAfD
         qvNea5rrtNA14vZzAn8V912Q2hbqbY7ddJhl0nQPSLKnIOv3+yVSeO0u9k+PUBRC0tv1
         xsVzTU1ntfNfXbtEimku1w1y+Ej6GA/5w9LNINF8Aij/ZYQozOvV+Cbu8T0eQ2kZvhiu
         nIolxVaIJkb1VWbaGQvSg4AoIa+WqqNo9tolrIPqUVUQUNUVygnjnsdEspYzn0pQ/RiC
         0jTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729186766; x=1729791566;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMkSb8BPvoVSLrXlyNMdZM0fsZU9mALmeiczlMJ58qs=;
        b=JXV00MVEQTXY9bABz9BCVe3df2enX637wsEUr8NWXN7zK1zRUKPQ27foXWZBwszH/p
         Pf3bQ8AZGIFKyBFeKtnXSS7WlLsim5FGCKUEh4I27tp+Hy8IohP4r9MmAsUzgzjQzRC/
         vywh2gO/96zhRdZfjam6cWemjxER6El3rD07837H1u1DYmPvnnB+kidkC/mtgxUOdcnO
         wI0QxByuoeL2rGTwrmRH8tk85t8hl0ooLBCEbeoqxp/sbQhqzfFTfhWzU5yJNhUX+E14
         kZDOqDowJbhd9OJZFzmc0etPGhM3kU2utyHb7XaJ+JSPje0tCZNS722LvRxtGOjB7qc3
         eWiA==
X-Forwarded-Encrypted: i=1; AJvYcCXmfE7pDh9CpV2A1CLs/Bz17ZoXCodZ1IUGDiebq8GNFLbrgWUZDuCd3wVXeorfiYC5xrBluKYwxs8t@lists.infradead.org
X-Gm-Message-State: AOJu0Yzzyz0wNJrQ9O9MFbWSGz4AapZQ7AIlFjhcEAt0rtL7uvUwj9JD
	HOXji+xzq7GvcpSwif5W0qd1yLVb8aw/boT8nBAc+R06OsLbvHFlIM3KlKOBzcc=
X-Google-Smtp-Source: AGHT+IHH/rhn8/ktlIExag/ecGl25lPQ/S7Rb/yUyagkwwdZGFp3vK7opmxjhF3cGsuBkHqgcz9VPg==
X-Received: by 2002:a05:6a21:8cc4:b0:1d7:7ea:2f2d with SMTP id adf61e73a8af0-1d8c9576f6dmr31594662637.6.1729186765701;
        Thu, 17 Oct 2024 10:39:25 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e90e6a6a5sm1709650b3a.93.2024.10.17.10.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 10:39:25 -0700 (PDT)
Message-ID: <7846e57b-fb03-42ed-af8e-0df88cc566a4@kernel.dk>
Date: Thu, 17 Oct 2024 11:39:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-loop: set blocking flag
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Cc: sagi@grimberg.me, hch@lst.de, Keith Busch <kbusch@kernel.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20241017172052.2603389-1-kbusch@meta.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241017172052.2603389-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_103927_559312_DB82B7C4 
X-CRM114-Status: UNSURE (   8.97  )
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

On 10/17/24 11:20 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Commit 505363957fad ("nvmet: fix nvme status code when namespace is
> disabled") introduced a mutex lock in the io path for target. The loop
> target connects this to the blk-mq submission side, so it requires the
> blocking flag set so that queue_rq doesn't happen inside an rcu context.

Looks fine to me, but might be worth looking at doing that a bit
differently so that the target loop driver can remain non-blocking
as it should be considerably more efficient.

-- 
Jens Axboe


