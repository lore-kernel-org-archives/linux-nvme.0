Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7244BC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jul 2022 22:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=oZJxlnhYbwkaLCWBq+FEE6C0Mg
	0CNUsv0R5R7P4b6gATlgeHk057m2iw/3WaqC0GbV9jGZlrIDroQsFfvobEqjPa8reMjOECkM47XBm
	MzSIRNgGgndBPWCrJ1PKv8GE417BMfV/j9Y6skyxqYEXqfT1dyUM+xMh711GaSHOw4Hs6myhNH/ID
	jQ1GFo3cZON7aNMKt6biwZG+hms/4hHWjOxvrpi08vHomwYorJMJRtits+UTaWnyw3pRo2xxxOpzS
	1zxRLOiKkO66OwqcZuT9x7gcxpXW7BcO9IH4jGVd9TtskwMLusshU/7eukNfsJS/n/pVfjoGkV55t
	3godnxrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEeSi-00CkBe-G4; Thu, 21 Jul 2022 22:16:04 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEeSf-00Ck8s-QJ
	for linux-nvme@lists.infradead.org; Thu, 21 Jul 2022 22:16:02 +0000
Received: by mail-wm1-f52.google.com with SMTP id a11so1787491wmq.3
        for <linux-nvme@lists.infradead.org>; Thu, 21 Jul 2022 15:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=vRTY5el44MCbbJIBSssCHfozll4O1U2phMqf93F1R8D9iAHaKX3iWkFVZDq1XEKPnN
         lWTShSEQ9ze8LObaia13b/MtjeykI4YmWnB79HLYj5sKEF79ZtWWUng1FCZxLfwtGkWw
         4Is+OkHUpSAHrZTxF+q+PQZfBgNeCm17pbAF9HqhJ6x71qkXzwYZOM6oHr8TsFU9N0oG
         NaCsjQIXMjk/sREc4UKH1R2PLXlQh8yu93boixJJDrI8khJgv74gKWuNreizogGs7tXF
         ynUAByW+b4tSbgsCp17OZ0ldk7r+JWdTPkhIvAqeINgb35jIX2BSqbVj8OAU0EprahPl
         gvlw==
X-Gm-Message-State: AJIora+AZPEmjku4B3XrTFzKtpGLigxm6QC0Xxq6Et1ffgUImXVCI7G5
	+FymcwZeQ0pX6OOg9QR/pfwptGwgXtI=
X-Google-Smtp-Source: AGRyM1vNyH9A5UsxLsWv7WyBCZJScPlqMn/UqKRF7AqJULaFGwm1lVnO+84wptC9QFxiegQPjeUVmg==
X-Received: by 2002:a05:600c:1991:b0:3a3:3f0d:d9d9 with SMTP id t17-20020a05600c199100b003a33f0dd9d9mr164919wmq.79.1658441759158;
        Thu, 21 Jul 2022 15:15:59 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id y11-20020a5d4acb000000b0021e57963c4asm2191194wrs.77.2022.07.21.15.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 15:15:58 -0700 (PDT)
Message-ID: <7bccc717-3949-8273-0f8f-a6dab44ac067@grimberg.me>
Date: Fri, 22 Jul 2022 01:15:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] nvmet: type missmatch fixes for nvmet-auth
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, hare@suse.de
Cc: linux-nvme@lists.infradead.org, hch@lst.de
References: <20220718231233.3886-1-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220718231233.3886-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220721_151601_872436_DCD214B3 
X-CRM114-Status: UNSURE (   5.63  )
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

