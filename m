Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64637C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Dec 2021 12:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=apjUBGABWVbEp6FsO9s/iw1aNS
	7JOKC8XvOrNyHAsv2tD4E3ZQWKkAOJoyhwKgGPfU563JQD6USbuohdVTHGhH3WuR+doBeUB00MOj6
	MC/4i/e0vptLTtrpZAIArYILG4/3yUMGXqjWOYwPjWTJwUefYiZXTSTh2epEZVP++w/Xp8YA4NuU+
	J5Owquzsm7F30AXUkKP38rSZVnOUUPXceNOtXlgC2IOHap4pyG9k1LgAEsdmGSXRpexcE7lb/U2sh
	lIrl2DqyonIu8bVNz+/BO+1YpaPYdubCZ/Hw72QAaNP/vy1HrNrKL06c+GWD1/DXbdQgDd6kL0DoD
	Q/lJMILg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1muwMC-00CZAX-DI; Wed, 08 Dec 2021 12:47:36 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1muwM5-00CZ8B-7h
 for linux-nvme@lists.infradead.org; Wed, 08 Dec 2021 12:47:30 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 g191-20020a1c9dc8000000b0032fbf912885so1692448wme.4
 for <linux-nvme@lists.infradead.org>; Wed, 08 Dec 2021 04:47:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=SaL40f/ESwHhN9Fahej9zi/hEz1XSBWC0JnerhJcXD55APPyG7JAlwZeU1igfBdmuy
 oP+XBwZJwDLd4avm/9sepc785eOWtnVvHHP2MZXW35vr/M9J7HN97kufNcL+6lJiWQyo
 urI06YC+CtebMg3ngjTysNK/lyEfQhOlnPAChGWAEI/j9tLbXWDlmu1Y30aNx9LojeVY
 ZQZEkHDo1bA3yPLWguF+ZKS6JGxqYTE3Ev3S6qbrKTODmLkMt05E9lWBhq0ssG0sh8cv
 JvnqE/oEi1u7dZws0XZs9y1sxODY9Tq20adtVkuhUi/304n3cwkMPaLn8Mg5Pn0R4Y2A
 GdfA==
X-Gm-Message-State: AOAM530bBU8ZnPwKorMcNbI2FvgM4+vPoPwzk204Ltv7Dtb1MdZD7c8B
 IZEXFQuTliMUSKxYuqMa7+hz1i4giNM=
X-Google-Smtp-Source: ABdhPJwfww/q8VLl+i1g3RiXHzyWhPEY6AxeCyNivu8cc3kwiMTrbgdOyHsTXzeY4+qSw2EfNENq9w==
X-Received: by 2002:a05:600c:4108:: with SMTP id
 j8mr15680464wmi.139.1638967647167; 
 Wed, 08 Dec 2021 04:47:27 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id r8sm3316380wrz.43.2021.12.08.04.47.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Dec 2021 04:47:26 -0800 (PST)
Subject: Re: [PATCH 09/12] nvmet: parse fabrics commands on io queues
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, linux-crypto@vger.kernel.org
References: <20211202152358.60116-1-hare@suse.de>
 <20211202152358.60116-10-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <42582bda-2438-309f-ce71-2cddc831deef@grimberg.me>
Date: Wed, 8 Dec 2021 14:47:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211202152358.60116-10-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211208_044729_330568_05392567 
X-CRM114-Status: UNSURE (   8.97  )
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

