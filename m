Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448A2C6FD1D
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 07:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=4fEkTnLFwvlOsP/OLClIvbAtZv
	a4VLcxkopeJNs7Ds9IVCsHnoM9Aiq2oEEkEETM5ODU1G6rehrsF3BsKiQEddPXZvyB8dpP4VUlSll
	+YMy+uTVkZBgYxWmsciDiUiYJ2lA2LTw4LQwP0lMo8Sa/cSaQKkRSjn1ZRqG9qvVD+Jyb4cBzjj5h
	M2hGssChCIbH4tbboNxQU6mA9QXxkW1T5yl+F4Cso+06J1x3ALnJL9xhvJq+xG8Go1A5ULklU3hJ4
	1O726pjK8Tit0KbPf2FFtr2mzYrqjRO3r7HMFfRrpumhRDlIvETaM5lnQ9VFwxvmqseUJ1wsjotjP
	KX9LgoAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFp1-001BYY-2Z;
	Thu, 23 Mar 2023 07:57:19 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFoz-001BXT-13
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 07:57:18 +0000
Received: by mail-wm1-f44.google.com with SMTP id p34so7870418wms.3
        for <linux-nvme@lists.infradead.org>; Thu, 23 Mar 2023 00:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679558235; x=1682150235;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=PRXEC2Kms7bF9ORqVQ59em924VmXxK+D5givkyaV5mx9RvgA/XSu+1vABGi1FbBMy1
         4nqrat/MHskJn2jrrXFBT2wuiLuu2kZVPkISGL+Vw22QHd/vEko4nA0RW5NjyYAMV/yr
         0NaTj+1hAE159+x3N60UwcWdRTCAF6LoAmkZdJzOJTZripJ3F2s/6nLqj4bTC1q2qrfT
         E+L3WJ9T460h3p+S5MUZuOjAl4t9hL0D8TINm3mMtb3eOvXB0+SljQQbM/XeX7N8Y5Ax
         WYKQo5xZi95R9qhyluhRBDY+qWNjy0+o9REeDCWNkkAozq4sII7P+Btxwcya/6Sl73Jb
         N/mA==
X-Gm-Message-State: AO0yUKXKpflxb7teTJD3X2eeqMkKy9PuoctxhVBsfGtx4LdsXWLZPaZi
	72O3nGoPqWQbAsZ4szFhUiS+GENgnVo=
X-Google-Smtp-Source: AK7set9rNa6ls2x0DpE0IXzaTl8BmhIXvMLq6DSUjlxcq3LCyo8j+U6ljPGeWrjdZZOdbT9k8amxVw==
X-Received: by 2002:a05:600c:1c9a:b0:3ee:7d85:e0d1 with SMTP id k26-20020a05600c1c9a00b003ee7d85e0d1mr1593906wms.2.1679558234882;
        Thu, 23 Mar 2023 00:57:14 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o10-20020a05600c510a00b003edd2ec9f85sm1136288wms.6.2023.03.23.00.57.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 00:57:14 -0700 (PDT)
Message-ID: <b8e5c89b-1f4b-edab-8212-90da36d14357@grimberg.me>
Date: Thu, 23 Mar 2023 09:57:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/9] nvme-core: remvoe extra line at end of function
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de
References: <20230323033636.812758-1-kch@nvidia.com>
 <20230323033636.812758-4-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230323033636.812758-4-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_005717_360052_5BDAA2A2 
X-CRM114-Status: UNSURE (   6.26  )
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

