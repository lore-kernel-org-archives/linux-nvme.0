Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCE0C54EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 08:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=AGirIiC3XqssaZu46kqyP/EwZp
	bwcFR1INUGBTAak3YnNiVmiFOWNtNVQkysl14COWH/DR9fF0Q7IJPM+3Fxgpn9hwyMisTo8WWYx1j
	wE+SKUIIsbxj1cK273yfzsMsyD7QcnS1T6GtyprdWL4YeAuXqKU8s16A+bwFc8VNBj7vi4teF3YVd
	vtyX2ulwKTSPGtt0KDURz6hCuQf/X41PDJuNNn4Bv/KJslFur4OjYIOT4AwAnthyqtmyPQ0quUrs7
	a+fhtToRdBNmeb+kyQl61z0oLxQSvU+t8aCO36aLDcf03+EzzPF1hqvZtxOmyD+kUSEYt67qzys2X
	jOUO8mkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaYXB-001lXv-IB; Tue, 20 Sep 2022 08:23:13 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaYX9-001lTW-3E
	for linux-nvme@lists.infradead.org; Tue, 20 Sep 2022 08:23:12 +0000
Received: by mail-wr1-f45.google.com with SMTP id g3so2923537wrq.13
        for <linux-nvme@lists.infradead.org>; Tue, 20 Sep 2022 01:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=4iQ19x4Ll7tH8+ezZpsBR+mPbG3lw5PcmGOt+iQGhexjv1i+AxbfkWwpHZYO9JSF5+
         bNYxudT1S/Ayub/zHEamGP35JGW91doYwB4ItCYLwOt6NXPogv3YGRDb+HtZiBZLlhDb
         CytpWvvu+CSvZukxUI+JCGO7yOqW1Cz68sTWCubdcc+E2cCdDIkoB6DEr2H9hvOHpO1Y
         E0lArdQawftjenKnVzLP7z9LCsZQnnRUqoJawhS6yVk1N8wav0kOEyQ79b8NIoHcMLkt
         aqLkHdTkYe+Dg+gBTyCWqIRq3NxKS2QnWI42vOo/tO/keke/0miamAPeuOgJZaVhoH+r
         q1RA==
X-Gm-Message-State: ACrzQf24Gm9L11ggREWzDrNIbpc0P3Gf9oGxO8zjAPOwbVA/1ylZDttf
	tG4IdDZlNWceUKBJ1mR4k2g=
X-Google-Smtp-Source: AMsMyM5/7YH54CbCG//DqhXfOFpGRmE7p9ln64E508hZYnXN0sPJVCkDvNmN02MqLwFqjdOiTBKKxA==
X-Received: by 2002:adf:e192:0:b0:228:d066:a844 with SMTP id az18-20020adfe192000000b00228d066a844mr13767189wrb.54.1663662188585;
        Tue, 20 Sep 2022 01:23:08 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id l9-20020a1ced09000000b003b49aa8083esm1338179wmh.42.2022.09.20.01.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 01:23:07 -0700 (PDT)
Message-ID: <221a606f-2be5-b950-f0a0-1d8098f663c3@grimberg.me>
Date: Tue, 20 Sep 2022 11:23:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvme: copy firmware_rev on each init
Content-Language: en-US
To: Keith Busch <kbusch@fb.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>, Jeff Lien <jeff.lien@wdc.com>
References: <20220919194508.1704346-1-kbusch@fb.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220919194508.1704346-1-kbusch@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_012311_169240_30255CB8 
X-CRM114-Status: UNSURE (   6.49  )
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

