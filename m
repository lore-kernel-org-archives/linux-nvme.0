Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8A2C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jan 2022 21:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LYLlklMTUvV+FFlO3h4bv2YOG1Oacb6orFnQKqnpfcI=; b=oU8VXQRQ3YrRa3A5gAFbkGrCvD
	1Y3PbaBAFy7ImpALdajmHGLphheI7Eo6FD0KfdEJaSC+lWCyMl6cbQXl96fw+pCP63Rcj7edcKLag
	IABmAac2y370BvNDxZl9DxQN/p23TD9pDCfcCupY3hXTdjsPMwRvFeYeY/+IiGoiNcoAQieIjz+Ya
	ciPgLeHZK/+cB7RGRN85ZdNvP9ttX473YsSYfWp0ZfAAkVkCwxs1OE/1EyhsJI9FyrPNYTa97mo89
	kf4m6IgYqod8LuZMHNk9udzgeRdY5dPO2rAq4R2D8WPR+7rEfwCarEDs/5Waujha0s5nu2LS3kkOI
	LZNqJscQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nC6cj-005H9H-Td; Mon, 24 Jan 2022 21:11:37 +0000
Received: from mail-ed1-f46.google.com ([209.85.208.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nC6ch-005H8s-LD
 for linux-nvme@lists.infradead.org; Mon, 24 Jan 2022 21:11:37 +0000
Received: by mail-ed1-f46.google.com with SMTP id p12so58910129edq.9
 for <linux-nvme@lists.infradead.org>; Mon, 24 Jan 2022 13:11:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:from:to:cc:references:in-reply-to
 :content-transfer-encoding;
 bh=LYLlklMTUvV+FFlO3h4bv2YOG1Oacb6orFnQKqnpfcI=;
 b=cz0MZydsBxJRWbG0jGOXDIeme3ejQctgUR+Is13xqr+YoISAQeuTog/6+jREiR2b5o
 ZtfPOjtZUT2Jc/hTWXsX0ir1Z7KfpdWjhv0TZjuKpS4DG+9zJ2RY9FNT3lK0DVgYFW2b
 adH3lE8z4kwy2QwK+OK9TgMJTHXOwdlW51nGbNkNlbBT+lww1O489vyFP5ChGqr7XP3H
 ivWxe8oxzHv1QkkSirtaP0OPHgUBJjurV9vQ0xcETMp1IzcjB+9jJB0PnZOE2VFMiy7o
 zgucYxmQfo27XjjRaQBpALBL+KMQzWmpBDh4m8audiPJLz1PlLHytCtKzAj4j7W0cCxw
 MTLw==
X-Gm-Message-State: AOAM532L+uRV1uKtnFsg7d3iO1cEqKQ9SXAxpwWWZncLaF/UMv5jnPt7
 sgpPXbBhN5dpK/hWMlM98bJHvxq/Ngo=
X-Google-Smtp-Source: ABdhPJxQeMgocWLNh3c0C5sl15KXk+QDhJdT9HpWgybrrggFpf5VAPj4mmYCbhW+aZS74h2hOPUvyg==
X-Received: by 2002:a05:6402:483:: with SMTP id
 k3mr17293615edv.323.1643058692880; 
 Mon, 24 Jan 2022 13:11:32 -0800 (PST)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119])
 by smtp.gmail.com with ESMTPSA id l11sm5330831ejr.224.2022.01.24.13.11.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jan 2022 13:11:32 -0800 (PST)
Message-ID: <98f61e6a-5bc2-788a-a0e0-557001adcf51@grimberg.me>
Date: Mon, 24 Jan 2022 23:11:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4] nvme-tcp: send H2CData PDUs based on MAXH2CDATA
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Varun Prakash <varun@chelsio.com>, hch@lst.de, kbusch@kernel.org,
 Ran.Anner@dell.com
Cc: linux-nvme@lists.infradead.org
References: <1642870664-3401-1-git-send-email-varun@chelsio.com>
 <23ddf451-2540-86c2-c403-2614477c130f@grimberg.me>
In-Reply-To: <23ddf451-2540-86c2-c403-2614477c130f@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220124_131135_726106_F8929FD8 
X-CRM114-Status: UNSURE (   7.43  )
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


> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Let's wait with this for a moment..

Keith,
Is it possible that you guys take this for a test run?
This is the area that exposed a few issues in the past
working against your target device...

Ran, maybe you can run it against your target as well?

Would love to get your tested-by/acked-by tags.

