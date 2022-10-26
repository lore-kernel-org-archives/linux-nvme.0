Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C21CC38A2D
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 12:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=aT3jARKKElglobONKKJmUYBg/k
	zAVSJUjKFXbyJxNiwe62TY0J/EVzfUhijuVRtyAE8Ens5tfe+/s6XolwF5YwVnF+/dSp8CsevuNzY
	xircJnVnBm3hti2RYzK2GPdQMpkJK/ZDjucWPjCtic3pgwg41ELCJ3P87ep8HLpH/iyQ7Qw1AXzCS
	ayCfOY+p7JN94pNQhlHLx0DmGsxRJZ1+TjrZ5Rso079j2TNfOQdSdDQdPfP1WorgaY3wtBnNK/YBq
	/UzRYQydH0q3yKWyoQKSkn1pJcD0tFArqnBVaeFQNJrA+NavcMt7CE8cJiCWT9PQWnvAvsQMp9K+8
	iT1rajhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onfsC-009HvU-9M; Wed, 26 Oct 2022 12:51:08 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onfs2-009Hrh-Rf
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 12:51:00 +0000
Received: by mail-wr1-f54.google.com with SMTP id l14so18909785wrw.2
        for <linux-nvme@lists.infradead.org>; Wed, 26 Oct 2022 05:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=AQj+6c+epFDYQ26WPFZcloD+JKmte+HepAk8uuia5RFKkQsc04doHpj1v/22A6/zVp
         WD2RisJH0yPFli5DN1Ro1rkdwnfogS2kpFalwpeuHGq9+bix5XQVig119FjaeM0g+Vyp
         LDomYbfMSrp/KadbMuLvshFciD2bc7do2kuI0BNzjS+5Hcm1HfBHst+B22LDf4u+GQxf
         dA7XuPgPe6fM2/UgQfXsNAifLlDut/t8NhTqguO98UeaiT1OAA39unxlMCuoC9jQb2bS
         fCpyfTiauWCyUajkLBqhkFAdLlUSuORfAuup7MZK4COfgcdo8sIhVcjHqB4Wl0F98A7B
         TOBA==
X-Gm-Message-State: ACrzQf0RQi+0omdf3hvbNBo8SlqPfbcnLl+geuGfQwniV0HhLbeiTA+8
	K2fpx4VuC/3NvEVp2rU13a8=
X-Google-Smtp-Source: AMsMyM7j8g5gDApICIiyw1GG+VZ7Ev7hCn0g5R6rwI4IFKu5jTHbwMyG0z8s60fQO5/jPbfTL1DZnw==
X-Received: by 2002:adf:ebcf:0:b0:22c:9eb4:d6f6 with SMTP id v15-20020adfebcf000000b0022c9eb4d6f6mr29024888wrn.251.1666788657578;
        Wed, 26 Oct 2022 05:50:57 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x21-20020a05600c421500b003c6b70a4d69sm1675224wmh.42.2022.10.26.05.50.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 05:50:55 -0700 (PDT)
Message-ID: <fbd7ea75-bae6-b597-b77b-fb7df88dad8a@grimberg.me>
Date: Wed, 26 Oct 2022 15:50:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 06/17] nvme: remove the NVME_NS_DEAD check in
 nvme_remove_invalid_namespaces
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-7-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221025144020.260458-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_055058_926470_71CFE4C5 
X-CRM114-Status: UNSURE (   7.19  )
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

