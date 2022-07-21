Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CA6C43334
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jul 2022 22:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c4FOMxx1ooXa84wdQskKp9gtmfP18foERSdO4ldi5JI=; b=THNy5ohZ8je4mDySctKbKf51Gd
	gMACciOcGM/IF14arei1hIkpGyBTlm7fyIhDtu39zwvKjbgQ/ce3LmG21+U2mqZwgSdfngtzKvjKR
	Z3DQYXAFFV5Nuhy/D5TNcqM0C3ko78JV25vNGNFVckXRTTShHtEO57VL1WdmiwTgP9BW3etPGQYlW
	Rh9p+O+Z4qHOlo4VouQeUKx//q9PtObSweJXDxJoESJPgtuhWf4f2Pf+9RGF5JpVpPWcHv36gUlYZ
	mzf+lke36vUwQJdUY5XqxTTPlsaYKAydi9kt56gBphjv+nKEQlwEn/0+3/HczXHS9OPeEuBD/cLAr
	qIIEvSvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEeVE-00Clnw-HA; Thu, 21 Jul 2022 22:18:40 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEeVB-00ClhY-OF
	for linux-nvme@lists.infradead.org; Thu, 21 Jul 2022 22:18:38 +0000
Received: by mail-wr1-f47.google.com with SMTP id k11so3723291wrx.5
        for <linux-nvme@lists.infradead.org>; Thu, 21 Jul 2022 15:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c4FOMxx1ooXa84wdQskKp9gtmfP18foERSdO4ldi5JI=;
        b=ygvfytuNRKxoMeKSrp0X2kvR0fowlG8bWfi61HtyhttukdO/1sZ+g6R8Lpj/JYUH8V
         jGynbHxwvI0hqEdgC2Bg8dgm7WPw/i61HHQ0lu6KP+RCRWRygIc0YiDDRllIqm60hgEO
         FGe0KgS2Jl4BuLLpRy61VKLxcjz2V99mVIVCEapQ2eBT+Hayhc1jYJ1v6Q/UVI/1+9rg
         GYb6jmMV2HbtgidCZoAlXnXQ+lYLf4YmvzFhgnF2bsvC4JUKxHnDVNddHrxt4yMrU1jn
         Sp3JzRmq8IPDl0kmoYjGnSmvt9LvS9sFw61ChcP1SusbABjgVZRstpJNHLQtSQ1uon/L
         XlNQ==
X-Gm-Message-State: AJIora+otHmea9JWZxXFPOhDFPBVW8v5Sux/XWgscOk9O0HDWcRqqA0y
	4NZNr4/UG0idzMtbOxxP0xw=
X-Google-Smtp-Source: AGRyM1t0ypuyZw85DkqQAtxcOdylgD4uOVetHzJ1JMiUZNfeTntftlJSGShapQh53PunMhMUCqmd3g==
X-Received: by 2002:a05:6000:d1:b0:21d:ad67:c320 with SMTP id q17-20020a05600000d100b0021dad67c320mr351387wrx.27.1658441915098;
        Thu, 21 Jul 2022 15:18:35 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id d16-20020adff2d0000000b0021d4aca9d1esm3550240wrp.99.2022.07.21.15.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 15:18:33 -0700 (PDT)
Message-ID: <88a11ed4-3061-dda6-e483-b69cb8c30246@grimberg.me>
Date: Fri, 22 Jul 2022 01:18:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/4] nvme-pci: split nvme_alloc_admin_tags
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org
References: <20220721062506.1712176-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220721062506.1712176-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220721_151837_812398_7BB9AD92 
X-CRM114-Status: UNSURE (   5.49  )
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

Series looks good,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

