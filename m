Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E19C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Feb 2022 10:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=F0FRoP9r+wOPKO/6JdR3g8kbY8
	sTHtK8vO84Cloh2eOJGOsrbCw+R6P5DEwornfF3vhsKV8nrPQpTqJj/60hsS/40yVjLnepIDpQ/pe
	kC1XeCR9bKZFsHPutlxfyRc5tNYN2oUTyIhTPNNihoOfJ54uNAAgSVFwFvwIKFMJB53yTHzhY2cV2
	3EgTUSIeNb2JvTktmVc4pzkXsKmzWCsT8Mj/U3Rr/LQUww0k5fLBMZDzf2uLv6C0N9usD2LfzJdPh
	A7fCZau1g1RQ3ffU9k7bYytbd9LfL+gU3RyVLdTGbNE5PUCp7DZS4Mp+1REm0/BIVy+j/YvBDmVTh
	gp5BBsfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMp39-00DhXg-2K; Wed, 23 Feb 2022 10:39:11 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMp35-00DhWV-So
 for linux-nvme@lists.infradead.org; Wed, 23 Feb 2022 10:39:09 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 y6-20020a7bc186000000b0037bdc5a531eso2328843wmi.0
 for <linux-nvme@lists.infradead.org>; Wed, 23 Feb 2022 02:39:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=Mpntc5AQQyQTSiizywsMQpYFXiTslaJ27I5Kz3YcGYBT7dsxgM25Y0k4EUa96qcDRp
 ZclywFS9Gm0SisxUie4JMtYri24ZA89MxkOJrprdscULMSfXUqdCTelqmlaGTn71Wbiq
 ZBaECEIzIUUGTjpxeWl3MfqAil/fZZFjwJtD7R13LFA9HyZNLCrx17IlhQrtNZXzYW54
 BH/n8V5ZU/+xyBZTl+Nv3A8QomFYruGgSClagE+shaR0BfN8Tn0gZJOnMPNDdNoUJ9Eb
 YX6q/GVvStKhoIX7x3nHtyHDKXwIrhUg3zKdweS35zGzW4AcMjpu55CviUe2OM25KebQ
 gNGA==
X-Gm-Message-State: AOAM530ic1x1K5r2WtgfwkeQtT3KdRwbh7YVw89iwbNz7azMqfa4Fbvk
 h2ESx+gSG+DdCFuQ8Bcf62A=
X-Google-Smtp-Source: ABdhPJybeWPSy1eVc8/YowlMHnphgqFQ4/QwmtJz8UuW9ltgzOJQfRKj5hymTH8qmrS8BxV8khDaVg==
X-Received: by 2002:a1c:f705:0:b0:37d:f2e5:d8ec with SMTP id
 v5-20020a1cf705000000b0037df2e5d8ecmr7013831wmh.21.1645612745902; 
 Wed, 23 Feb 2022 02:39:05 -0800 (PST)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119]) by smtp.gmail.com with ESMTPSA id
 f13-20020a05600c4e8d00b0037bc5ce6042sm7572357wmq.27.2022.02.23.02.39.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Feb 2022 02:39:05 -0800 (PST)
Message-ID: <040bd8d0-5caa-1826-e321-b460fd5ce99c@grimberg.me>
Date: Wed, 23 Feb 2022 12:39:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] nvme-tcp: don't initialize ret variable
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
References: <20220223033657.208747-1-kch@nvidia.com>
 <20220223033657.208747-2-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220223033657.208747-2-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220223_023907_965589_A0BE3ADE 
X-CRM114-Status: UNSURE (   6.12  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

