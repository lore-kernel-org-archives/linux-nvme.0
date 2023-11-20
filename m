Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFA8C197A0
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 19:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ckiUV8HeIYQ/rsOxCbMNm/VjxU8EUESI63njQcctYnQ=; b=vODawihwig68+TFpFgd3wLyetk
	1Qb/gpjGk4gKY1XHioZrfGCwrIvNiBHnu2DE8w+vR5hs60MFB0EzcK70UeJG0w2Uzxx7bJ0V+KzGj
	NULWOueU8oKRBprQmDCT3JupLv04xLhKBKLC8gHq2t2JspQC+oLoA0L6US4Ohs4lsEKf/4bAiFok1
	eMS8+RPXtYHAEeWu6ithex3dSAfSv2rmh2IjAjIekIWSv/mdR6lHWDMtY7UmjBWFM+IaFxwPb3PxE
	yybyZnBja342YJofTvJK0L5EugyhLpbhnMXlQHTYX8y+Vzp1/wfu9F1LbxwnHpbt8jVOXnfqgL600
	kL8YaWdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r59cJ-00EffG-0u;
	Mon, 20 Nov 2023 19:07:31 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r59cG-00Efdo-1K
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 19:07:29 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3316d855828so253655f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 20 Nov 2023 11:07:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700507244; x=1701112044;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ckiUV8HeIYQ/rsOxCbMNm/VjxU8EUESI63njQcctYnQ=;
        b=Qwk7TkqAKTJ+6PXjR0cA5MIzRG325Ki70fDM+MOETJL7sJT+GTdwJ5OwaIFa+suSUh
         CjLH3MuoGwdHTwl0o3caVlUmY9/Y1C5E9xR5/zvn8JuSyqQVM8SS6NUdE/w6SpdApb7F
         b6Xhp/8CtOTzmTgZgR2/+xRG5FqQfaCQz4BGWxI6cL6ToQKOVZXLo1zeav3r4/lgz2CN
         r4+dN1LHFSfSE20yQMVLsLPGxfmbQTS3kTeuwkxorXNecOtBYS08cjfJevOhPd+evwlB
         Gl1SlhDe6T19kt9Fwwv4KFknl5z3VfwZRnqefv0kkSA7fngBaW8/FoYNMryRYL3negCx
         x7VA==
X-Gm-Message-State: AOJu0YzjL4mbafy7Zbt1XhQqUlUXmVeWaQojEWG81Xl3frpCg37IQnDW
	jBbOdMKBQc/aK2sBTorBLZ0=
X-Google-Smtp-Source: AGHT+IHtt6dyZp+rB9+yZ03tjAysF45cY77o7+qn6ght9J6Xaw9bX+7xqCCP4kffqw+HIBYtmdX0fA==
X-Received: by 2002:adf:ec87:0:b0:32f:730c:35e7 with SMTP id z7-20020adfec87000000b0032f730c35e7mr5855760wrn.2.1700507243847;
        Mon, 20 Nov 2023 11:07:23 -0800 (PST)
Received: from [10.100.102.14] (46-117-95-192.bb.netvision.net.il. [46.117.95.192])
        by smtp.gmail.com with ESMTPSA id m17-20020adfe0d1000000b0033130644c87sm12027998wri.54.2023.11.20.11.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 11:07:23 -0800 (PST)
Message-ID: <43dd2e84-9383-478c-b5b0-8877c5619aa6@grimberg.me>
Date: Mon, 20 Nov 2023 21:07:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/2] nvme: ensure reset state check ordering
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>, Minh Hoang <mh2022@meta.com>
References: <20231120175035.978147-1-kbusch@meta.com>
 <20231120175035.978147-2-kbusch@meta.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231120175035.978147-2-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_110728_444841_F72735E1 
X-CRM114-Status: UNSURE (   4.34  )
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

Looks good,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

