Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F92AC433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Feb 2022 12:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=qcG3X/u6X9K2GGY2K//dupnGNs
	Sbocc84Zfus+xrvESSoV8IItvapFxQH0qLKimjb1y4YSkmqHRpb5vGYtVnVHSDJjLC7nf1vID0vgq
	wv0m7qTIpxmMFj+k0JdOf/lpGP9YNCggDNDusdU0IkhA6K/1Qvg4Y0AEoZ+zhOkMrNOMagm2JOof/
	W0at3uhytctUoUrxFmq0H4xEp67BKqiRAxLpdrCuknNyMKAZjFZhnkrKo/9hlg9oZaPIzpzl+asfT
	UFxR1bnXy7FB/+mxuRXnsbkJY7eXqELoN4dnksLmmD4jz3bgu5ZryY9Jgz84dIfSkWkHT7/yTrZeN
	tfs1WQkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nLlju-001M1b-Cg; Sun, 20 Feb 2022 12:54:58 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nLljg-001Lyw-Pf
 for linux-nvme@lists.infradead.org; Sun, 20 Feb 2022 12:54:45 +0000
Received: by mail-wr1-f47.google.com with SMTP id p9so22386094wra.12
 for <linux-nvme@lists.infradead.org>; Sun, 20 Feb 2022 04:54:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=pQneykGa8/hWfNce6DmVW9Sv0RXt0r3byu2s+26H1sgnHb3KEykSE/7g0URN6O7zT6
 7pDWY965eQQAQpUwMTnsiOGwzu1abanjdL/pSl12pZm07X+k/coVH29d7vJapfme1Qzc
 c6l+toddjbDZRcL+H9SV9KLudTNxXfBvtVWcxeG2x276xcYMVfmhhUX0gd6ZMx8O7hAd
 78ZPeTRmpZAukxbFqHcnhwXg4GjXLWKIWyu1SwAJDyiqCwJgsDTTFJLT2GorU34FKUFL
 69AcnVYnFuJ7GHQkPbBhIUE2SAcwffJgRPh7Ozt/JGrFHgFJOgd8GsWXL+VmzHFuVWcX
 8tWw==
X-Gm-Message-State: AOAM530wWY/NWWHIxeD26DQ98NM6yXZp0PxzEuomTM3aif/T8hbdveyx
 NZUFRW1qQAKTUJTjPw7Xjwc=
X-Google-Smtp-Source: ABdhPJxzk1d/s2I9LiEQcefyYLNZVEpSDP5tL7jT75um9F8KgiQhS6IiVxtknOPr5g7OYeDO224K5A==
X-Received: by 2002:adf:f34d:0:b0:1e3:3e54:cc96 with SMTP id
 e13-20020adff34d000000b001e33e54cc96mr12266134wrp.84.1645361683158; 
 Sun, 20 Feb 2022 04:54:43 -0800 (PST)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 a17-20020a05600c069100b0037ddbe6da71sm4595681wmn.20.2022.02.20.04.54.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Feb 2022 04:54:42 -0800 (PST)
Message-ID: <31426dde-6735-b8e9-2639-f8548849a92e@grimberg.me>
Date: Sun, 20 Feb 2022 14:54:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] nvme: also mark passthrough-only namespaces ready in
 nvme_update_ns_info
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org
Cc: dwagner@suse.de, joshi.k@samsung.com, linux-nvme@lists.infradead.org
References: <20220216141220.4162670-1-hch@lst.de>
 <20220216141220.4162670-2-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220216141220.4162670-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220220_045444_843704_0FEF5D1D 
X-CRM114-Status: UNSURE (   6.21  )
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

