Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3164CC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 08:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=PY2ZT1d3rj0S94gtjxYijSo8YR
	CuFBq318kyiiw2+wUhZoV7KQCoN8c+jl2eU4BooP+QaIcLmO8zKPFOfXqYxYhme6GSt2n+lqgW4aC
	BJKDuoTQXCvPYhKl27U2xSQwfaZUfy7XIiXra5nIbBulFhN6S3WKZVGMK4aFgdknzMdbZp+8rSpXY
	q5zpQGP3Xsjyw871Ib1c5TNbPKJ33ovKfx95lL/jUVr/I4rThii/vx3/mrz0iDQAINqtRtfLSm/xC
	8nX1XqkHvTaX+Aoi/+5F2QIEheW2CtTQ927EVAfDiN0G0lKBtRNMHcbbIg/aZfsGJY2oMudhZqSa2
	TilNk1tA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU2oa-008LFu-4t; Tue, 15 Mar 2022 08:46:00 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU2oW-008LDv-SB
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 08:45:58 +0000
Received: by mail-wm1-f54.google.com with SMTP id r7so219272wmq.2
 for <linux-nvme@lists.infradead.org>; Tue, 15 Mar 2022 01:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=AICq8BaU5V+QokC+mRXEkYtfLrQvdbtesvF+b5GEBt+ckOFwztRw6Y/5Z5+HA4fFN3
 0WIYqlD8xHl1/QgyA1kDE8HRRRkhBjXKkIy0LZW2OLhP47AChuSBta831dklZp7dMxMy
 2hAc+OEAJnhDe3JlaW1Qute9hKTjDj9kHgp01VZI7+SuFy+IFFuT2dQDmiR3fw0Ym7q7
 yWosY5g58Kni3GOnLes3a3jS8Xg5VOy32VlNh2pmG+jQwOPHjq5efCx0Eokz9YXjenQ/
 H+xSEqY6MwQ+uGdW5aIQ3ppxCfBIG9SGHBOLNu8xAZEh6PbUzuSBlsqJ7f0Tg6YjX9vx
 XP3A==
X-Gm-Message-State: AOAM530udOji2L+iNXB6/mql4/5NRaP0oDUyQtRtrsMUhtWNsejftMd7
 iHPYAvtSDa5GJLQnTdAjHEU=
X-Google-Smtp-Source: ABdhPJwoid/NDiPZ+5kAYu/ST940he5uhPnsFlQnxbPIfEdEHnf2L0lyFpD2/EN6ebSB5Xlncf5hxA==
X-Received: by 2002:a05:600c:4ec7:b0:389:bf36:ce3a with SMTP id
 g7-20020a05600c4ec700b00389bf36ce3amr2374920wmq.118.1647333955017; 
 Tue, 15 Mar 2022 01:45:55 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 o12-20020adfa10c000000b001efb97fae48sm15756277wro.80.2022.03.15.01.45.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Mar 2022 01:45:54 -0700 (PDT)
Message-ID: <797f7fcc-bea3-3fc2-19b5-bce03fc028b3@grimberg.me>
Date: Tue, 15 Mar 2022 10:45:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] nvmet: move the call to nvmet_ns_changed out of
 nvmet_ns_revalidate
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org, Niels Dossche <dossche.niels@gmail.com>
References: <20220315071951.1903382-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220315071951.1903382-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_014556_962250_C5860835 
X-CRM114-Status: UNSURE (   7.18  )
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

