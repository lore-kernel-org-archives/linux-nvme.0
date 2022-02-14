Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC02C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Feb 2022 11:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6/vGNi/3UPli3fNCzGm+9Xt66Yypim/rFrC1TdRns68=; b=DDC6jYLiLTW7JZ2Cy4+/rrmZOk
	2GTVa3+9kYq3kchsll5AeOb0Nv3fzEmHMWcghNR25tOIKcOvgVOQENXz+0IlHlECyg/AKs3iSV4vu
	BtRMEBpU9oG1czMtHdAI7qBAG0VkAi2YnJ2jcE88JD36oxFt6zX8zjs6ylAsbbnau0IjY1VpPLGrO
	YeMLO/yOpa9faWJ4cEeXelRFPqvxlfa3W+J4vRgtD+KUncrEG4H+cBzexMYGosxKFCbOjBhKe2Siq
	+L96+jDX8qMeN3TsIaKGRUZQTV+/iLDjnYEjvNMdzJ9OzxLOgp+5I5qrjN6uYDHKfyavpocasBtnr
	keCxLsBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nJZlb-00EuK2-Ow; Mon, 14 Feb 2022 11:43:39 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJYUm-00EU1f-Op
 for linux-nvme@lists.infradead.org; Mon, 14 Feb 2022 10:22:14 +0000
Received: by mail-wr1-f50.google.com with SMTP id e3so26074388wra.0
 for <linux-nvme@lists.infradead.org>; Mon, 14 Feb 2022 02:22:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=6/vGNi/3UPli3fNCzGm+9Xt66Yypim/rFrC1TdRns68=;
 b=p40IglciOQRUfASLiQj3clzpVo0WhUwvJNneCdoEezE/r6s6oiKMG3aUFoCh6MnI0c
 nlfX7Lb9LBTHjQTfryK2Xr7KKs6600Rwt/eBJM+lpCW4eBlyS3MIpBzLf2X8kFMJ2eOo
 jOcJBuh9XdRDOFmHXaA0sdy6F3cDIQ3tKgFcXww1YcZBiS9U6DeGn0+LCJH/3iyJLWmm
 Fi5OQAZWDnXIr3lseCJw+sB10Pu8tWhyThplug8EhqqEjl04OKHBtxhGy7UNat3CFm72
 fqB/iaGAqoVd7Ce99V2Vvm7pGhBarp+sCzjuIR0ZS1Z8AWqGwUBYK5+9EYyWHrYhFKYr
 B7ew==
X-Gm-Message-State: AOAM533KJscJlDR+B62H069lzsO1AqIz7BLGub3LY6sp2TZXrkSFc2cp
 fjSSga0xy+7ub2qOzCrCqR0=
X-Google-Smtp-Source: ABdhPJyxLTgAh6sQLcDjxyJOlBO57CBs8rP/acNGsEC3mneT7BQdQ5yz76sYVP1VSRqXimCaxVHL5A==
X-Received: by 2002:a5d:588e:: with SMTP id n14mr11525907wrf.45.1644834130696; 
 Mon, 14 Feb 2022 02:22:10 -0800 (PST)
Received: from [192.168.81.96] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id bg23sm14886814wmb.5.2022.02.14.02.22.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Feb 2022 02:22:10 -0800 (PST)
Message-ID: <02763496-0104-4616-ef57-117eb741b82e@grimberg.me>
Date: Mon, 14 Feb 2022 12:22:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/7] nvme: cleanup ida_simple_[get|remove]
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20220214090732.479193-1-sagi@grimberg.me>
 <c6d8ce0b-7d75-7d6e-ecc7-e505de85aa4e@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <c6d8ce0b-7d75-7d6e-ecc7-e505de85aa4e@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220214_022212_860404_1A9FF8E8 
X-CRM114-Status: UNSURE (   8.93  )
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


>> We have the simpler and more convenient idr_[alloc|free], use them
>> instead.
>>
> 
> you sent the same series :) either ways seems like a useful cleanup..

Didn't see yours for some reason... Did you CC me? Can you point me to
it?


