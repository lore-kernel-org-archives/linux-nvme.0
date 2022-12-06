Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B38C352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 12:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=HFcsNtIoROVWjJ0a+CkafMOXQf
	Wvq8888v7YpMd0NdkByrocuRXbkwjj/5UraUdx3f8sz/cp+frOt/rTD+02zgKK1vrN5rFN0/SlBqK
	ciYtb/1x17JE9OpAEnmYFLR8fZzzPDMldJnH7SErEXXHe2Tc56mR4n9JIkIE9+FI3uOzlfDxUCmw1
	A60bdrJsaY7G1FDhBIBvAljsobXAndZOE/+1LTqR5d3l4ZA0Z+egtbyQXCkHHNx6Z88nyY5EqV3Ql
	2HVZvKvc8L9E/N8ZX15X8l0tk+E79mzIjVPRSGVgylR750crMONnYrdZQTZJol7TG74CvF4zpQASF
	uEmfNW8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2WcD-008tDW-5p; Tue, 06 Dec 2022 12:00:01 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2WcA-008t86-JV
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 11:59:59 +0000
Received: by mail-wr1-f54.google.com with SMTP id h10so13583623wrx.3
        for <linux-nvme@lists.infradead.org>; Tue, 06 Dec 2022 03:59:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=OuxMY6LNGzjnoREOHUaw2fFec+MBSglCHCOY1cB6JF1CH3SKOUl1mFbHh3L7xOJiaN
         OvMJAnnDmhu3Wey+a8ofeWy3Gt06LRy9ii2qNCcDD5j3hAg5FNLHnL5p3bCUlCuCrIiS
         uTgX68xbUrXK3JR5Z8GC5DM5AkLtR0TUp4fQPfQf/z+qkrck6XA7vFSFf7lHrWy6zch+
         kZMfTa8/TzQDcPelBvY0o80KftNTrgn22od2DnKEKlVKk1RhLeatuqG/HAfsTb9oqSWW
         jA7EyYjnJHtIFkuTjWC4cbbZ5u2s2j3XWNkaRYQSaBopDUXO6SxkLE17jGjFhXyRf4WL
         IT2Q==
X-Gm-Message-State: ANoB5pmRy+VGdGq53ryeCwhZt4NszYVI6I74/3IoXlAatl8PeHgCdGJk
	oqsI1S+ygmxfOQjqiaP/nuNjhdhVOpo=
X-Google-Smtp-Source: AA0mqf4r/slh6LVyCJ17jyjgco3L5gFfKXMc4lIKtU61TdyaBcmOSSj0j6dcl99MZkTloZYdPUYivA==
X-Received: by 2002:adf:d235:0:b0:242:2bbe:1059 with SMTP id k21-20020adfd235000000b002422bbe1059mr16623209wrh.496.1670327996002;
        Tue, 06 Dec 2022 03:59:56 -0800 (PST)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id o22-20020a05600c2e1600b003d1e051f671sm4423130wmf.9.2022.12.06.03.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 03:59:55 -0800 (PST)
Message-ID: <bd85499c-310a-1403-4ea2-a577ae375117@grimberg.me>
Date: Tue, 6 Dec 2022 13:59:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/5] nvme: pass nr_maps explicitly to
 nvme_alloc_io_tag_set
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
References: <20221130174240.227616-1-hch@lst.de>
 <20221130174240.227616-2-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221130174240.227616-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_035958_674108_C691AC47 
X-CRM114-Status: UNSURE (   7.41  )
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

