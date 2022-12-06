Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25157C4708C
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 12:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=UGSiYagy4XSTneKCjaLCynV7B0
	RuEMRAGD22qJ8+N0Ue4dcJd+9OzIrzotmje/J1BlXwaxJg5VqUynrbidKNJ87PwNUcghUMY/j132u
	Tvo4bSVVRJTq3daVxKj25uEbsy/+KZaBTkkXy9OstbyQTQooBe7TCwdLYbmSFWkU0415aP8yQRlKF
	05zyJLu6G3FPdNIAGHsT8ORzEfTXnePB5OFHUw9S/XmFj7Ou84a709zcEebFn1l19DEtBkfG72fWx
	7lOz8tI1KeIp7ibQEfnlnmfTnjQe/QiyRhcfTza4FsRD+h+fgOxhwCQngAJ2qd2cx1UWSmSiT20iF
	wnoJDI1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Wca-008teB-NC; Tue, 06 Dec 2022 12:00:24 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2WcY-008tXT-BQ
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 12:00:23 +0000
Received: by mail-wm1-f51.google.com with SMTP id h8-20020a1c2108000000b003d1efd60b65so630631wmh.0
        for <linux-nvme@lists.infradead.org>; Tue, 06 Dec 2022 04:00:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=rPdGEK3QF/5ogex78qBeTBHW7HYclgpMRK4U026UQNRoqjUQJgGQjYT1VGyOxR6Q1Q
         5SChb4per7ec2wuVmVyV+ekrkm4Sk8guv3MZpMYehvhI708OIZqt6Meh5x6PjAZ724/T
         W0SAvf5JLge3ijv/mu5ULqavJW7DQNmalQjAiwTNb9uNOIwfId9OI4EFHb3X/w8qg+1v
         q2v+/HlPp+lUWwhhjXj/Ex+2j7PJwcgwdB3SBiPAF+N+8NaASjMBTKG8ujPOmaYnW4QL
         fMjrq9sMKhR7JXgKnkFTSNlQvCahLfLSJWtrN60yW1jPdSUFMmF9CXYRWJlLLBW4hHes
         v9eA==
X-Gm-Message-State: ANoB5pm9m9Abmrv9jmYapodx6I+ENnOEKSovcyaujfxMCn0z1zZOa3T1
	lzRlUvGNIkBZWf9RoDqS2fy60pzSAeo=
X-Google-Smtp-Source: AA0mqf4tQt3eO2J8DTOJRJ1tdErciFtJob6G843ecbRqnh/LVpgFPb7z0Pw7mQ0ZQXUiU0EBqO1Low==
X-Received: by 2002:a05:600c:4f01:b0:3cf:8952:2fd2 with SMTP id l1-20020a05600c4f0100b003cf89522fd2mr54211358wmq.9.1670328019716;
        Tue, 06 Dec 2022 04:00:19 -0800 (PST)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600c314c00b003cfa81e2eb4sm23557728wmo.38.2022.12.06.04.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 04:00:19 -0800 (PST)
Message-ID: <df9b2f94-1e37-b253-6cdb-c9cdb0e1663d@grimberg.me>
Date: Tue, 6 Dec 2022 14:00:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/5] nvme: only set reserved_tags in nvme_alloc_io_tag_set
 for fabrics controllers
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
References: <20221130174240.227616-1-hch@lst.de>
 <20221130174240.227616-4-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221130174240.227616-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_040022_399052_36D1C679 
X-CRM114-Status: UNSURE (   7.11  )
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

