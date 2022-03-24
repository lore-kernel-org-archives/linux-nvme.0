Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A33C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 17:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=wOg7c+oSRwUR5UFf+PvysddQ69
	GkQI54u7fElrhrXAaY2cb6q3OzKH1ze/rcFEL6HM/BRP4Kve3E08wmYSH4x6DvCi9a5rOM60Odo3i
	It9Jt9sqfeW0wa1+djFtmcsZdEW3jezTzn4raUfrV6FIEDJpZyUAQYXQL57kW/G22zbRMRWOBvsE5
	rbprKMWgKBDdckBP7nDnQlWD/FUWnnW7bQmnT8K+5JZdNvaQly5/2144GGA1LP7XRkcFJxCeYinYc
	70iEwiDjJJw4oVUgQH9EtYdiJdTJXI4KTmrhFKINBXaVM3hhUvg9sWdD6BOx6ddqiqwkR176QJOgZ
	NDkS9Xkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXQqQ-00HHgr-2e; Thu, 24 Mar 2022 17:01:54 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXQqN-00HHfN-8G
 for linux-nvme@lists.infradead.org; Thu, 24 Mar 2022 17:01:52 +0000
Received: by mail-wr1-f54.google.com with SMTP id h23so7517920wrb.8
 for <linux-nvme@lists.infradead.org>; Thu, 24 Mar 2022 10:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=p4o63177gQxoc7Yi5JeEPwCaMIVGaP3O3a1i5V96kS453Tu69bLF+LvyjaWqSmOYcL
 7VyXBQM5cbfWfVOeeNSwx4wnMt+AuglTb5WkE1vNwHOxNiOBHFiQpuT7EPrZ0FPgboHh
 7UboNkkYJRhBNMIi4wjBBrNS67G8/LNGnpTyhpTAX5t6vAtZVjmvqc7ZWCRu8HnUYAgS
 gFciGY4sAzh1ae46luvTz+hkrqacbzwH7Gvrj805OGt2N0OOzQ/bOUgvx1NDDkfOzPn2
 uW+l1tjHTB/Bei3qqkXMQmT3cjiJxPPPU7iGJbKi1/oqqrDHU+wA111+Iwtnfp8guPXa
 mtSA==
X-Gm-Message-State: AOAM532hIL/zEeKH9d4fmSqsocLghcJos0ZSavFwUbF4fkBgZ2DFo6St
 dQOm/hm1O3xva6amGxpvSVw=
X-Google-Smtp-Source: ABdhPJxK7rWE7icoeMidqwyNcLebymg2Ww4nj/PkDkTH+s+iVH+PeZBjQLjwkoHVPCtJ5YvfEx/Pgw==
X-Received: by 2002:adf:fa4c:0:b0:205:7cb2:e6f0 with SMTP id
 y12-20020adffa4c000000b002057cb2e6f0mr5483364wrr.218.1648141309224; 
 Thu, 24 Mar 2022 10:01:49 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.129.dynamic.barak-online.net.
 [85.65.206.129]) by smtp.gmail.com with ESMTPSA id
 i1-20020a05600c354100b0038cceb205besm2095141wmq.7.2022.03.24.10.01.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Mar 2022 10:01:48 -0700 (PDT)
Message-ID: <36f60abf-f24c-9913-638f-d1e8c0c5a01d@grimberg.me>
Date: Thu, 24 Mar 2022 19:01:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] nvme: allow duplicate NSIDs for the private namespaces
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org
Cc: sungup.moon@samsung.com, linux-nvme@lists.infradead.org
References: <20220324154314.1571239-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220324154314.1571239-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220324_100151_329523_A8644CF4 
X-CRM114-Status: UNSURE (   6.33  )
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

