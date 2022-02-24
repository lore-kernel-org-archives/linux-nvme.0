Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BC6C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Feb 2022 14:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sCiNyIsGOxqAa+8g0kd9PqEfF+2jVxczpLK8SIG1Tw4=; b=WPRpyRc1pYEQayOdQAI1h0h/TD
	+rwku7I6EGKMqWyzf8HxtdmrhMpHTF6csfry8rJdNBRhfjQhP6ocANW5y6IGFFXhWGDQoJTcSY3Fp
	gEV4qBj2PjP/74RW0B4XIes/CiGw8+rCq7t03eAzFuPf4qTF7RY4Ir9g5uC7OwJgF4ke0QQm+c4zn
	f7elzGFrypmHjrQj22LO/saKJJV9YL3x1IJ3Dv2BdpJ//mwGkn5n+gIvh8ihpaBY8kp3fwm2vjAaS
	j6Sd4UKTpq/0HKTAsBOawp1aEmVq1+4EoiXm+bjWeEgDMIkkn14ggoYb2H4y6iB+vmekZhOXpQCGW
	a9+arR+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNEiW-0014HH-Su; Thu, 24 Feb 2022 14:03:36 +0000
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNEiT-0014Fi-QB
 for linux-nvme@lists.infradead.org; Thu, 24 Feb 2022 14:03:35 +0000
Received: by mail-pg1-x52b.google.com with SMTP id o23so1788042pgk.13
 for <linux-nvme@lists.infradead.org>; Thu, 24 Feb 2022 06:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=sCiNyIsGOxqAa+8g0kd9PqEfF+2jVxczpLK8SIG1Tw4=;
 b=vMJN5Hl2knWeVOSfwAjcnWQuH0oBr3rK7YpSbZYkcxyPIli93eNnFgorZMWm8NUK93
 QoWx0qFY4JUtcjf7/+L1tor6C+LeEv0Srjbg2J7XMWkfPqrHaL6+Y6u/uLi4Glv1hG+W
 x7Mn+1MiHbcSnKiog/r+nFdM8+fJNJAI825reF0kc4WVinQC3QUN6Jnh/FZvAeiyP7hS
 nG7+YKFYQT8bQBm46v7NZmTi4jbANmO2jIP78GSuShM/jtbAfCTJdTcHBzmZ+DnarT07
 JR5g9eSkvd7UigAlhpu3XQgjU6XjmuMcaOskihpRA//Bf/8tQK0vsmZusbrp+MUMuerU
 uCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=sCiNyIsGOxqAa+8g0kd9PqEfF+2jVxczpLK8SIG1Tw4=;
 b=P7dmiTWnAf6ai2rqKbZpErWo817umckWZBfxvs8v7fj5hk2EVdP42xfgqRTYLshvuN
 zeZuRg+2RaST3v1+3NIEzQ8dbng5BPiaMMWnaxR+MZKeAW4CMN5VkxAhdKVhnXbkO7JV
 cY+Nb5HV+4OPYswXr1zTAnGGpWSakTTjxkD0I86vPUGwgzngMfRkjhxgTC8N7SVsSiBt
 QHBOgE7mNZAGNDBnygmk8ZTIcSNnXRrEXV7hIxXFms+pfNIjuUpOxknzwQtT3+l2oHKV
 ZOiFJqhdS0OF2Ztqtz5YoKZ1uyjnJBqlOheLPqHYNTETGbTS0tyoDYKDyJZEgczpi+vN
 rRMw==
X-Gm-Message-State: AOAM5330mhZNQpyga6QzpqnNIEDnR+z3i4fLnrKkW+FdjZ91gChmEXvU
 K6P3VO1MFinilI2VSgvHQbSCmw==
X-Google-Smtp-Source: ABdhPJz+ePxqdtPzoVNNFzIfNBpXfbeumQrkwTlau6nf8NoJJjy7oossvc42Y2IijnEM7zJ8TD4xIw==
X-Received: by 2002:a05:6a00:1a04:b0:4e1:294:e1e5 with SMTP id
 g4-20020a056a001a0400b004e10294e1e5mr2754361pfv.51.1645711411849; 
 Thu, 24 Feb 2022 06:03:31 -0800 (PST)
Received: from [192.168.4.155] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
 by smtp.gmail.com with ESMTPSA id h4sm3931052pfv.166.2022.02.24.06.03.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Feb 2022 06:03:31 -0800 (PST)
Message-ID: <60b3efbe-a4f2-71ac-dd3e-54643849df17@kernel.dk>
Date: Thu, 24 Feb 2022 07:03:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [GIT PULL] nvme fixes for Linux 5.17
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <Yhc01AadzWuqPuAe@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yhc01AadzWuqPuAe@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220224_060333_959474_EBB00328 
X-CRM114-Status: UNSURE (   7.07  )
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

On 2/24/22 12:33 AM, Christoph Hellwig wrote:
>   git://git.infradead.org/nvme.git tags/nvme-5.17-2022-02-24

Pulled, thanks.

-- 
Jens Axboe


