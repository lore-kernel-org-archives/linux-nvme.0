Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D033C6FD1D
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 08:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=rhvQjm/TZbSOrM3654aS8t6eyb
	Ocx3NXomJGGdV2yefkezHeHmr5luPZnjDV2uogskGDhlLFO83HZBV+Urk61vQReeyCtz8lb1NaCDq
	klCPyMjJEYu9uPVygSm9n4WkfgfOk4r37ORqJXPtD6Uwx7HKTTKSEtRmgqPEdpbJTKt1IzxcZgYLs
	pEssbPdlhWq0EOipaviox6XF2Jbo9qz7X6pLOrzOJzhSyMff+LkFBTLAh6LHwjRdYpcqABj0Yiya6
	fUFEwTI/jlA2ksFGzUnMP1eyupn3aJVh985i6tJu2uD1aU6lFVYXthmHyXY/V/v/u+cDaq3YfP0OD
	B8flpedA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFxG-001D6j-2J;
	Thu, 23 Mar 2023 08:05:50 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFxE-001D60-0d
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 08:05:49 +0000
Received: by mail-wm1-f49.google.com with SMTP id s13so628983wmr.4
        for <linux-nvme@lists.infradead.org>; Thu, 23 Mar 2023 01:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679558747; x=1682150747;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=AYHXAXv0AZSBG0UbCtdbZ+nZeY/4GWSXD7LuHc554G2RalDryPJTqGIno3/luaV3ae
         kM3iHWBvl1tEXrF7nH37iiEjYpU0LPFh3bqagMdXKsWDmT1FM6VlRb8TPc381BrSGbV9
         i185fRpnNwDkzbTA4ncDYKl4UxJZ0FuFTVJQapKsJoJ6Wb5IiS7cXBcAuqH98wF4vl6y
         z/9l/Z0j4s6KcHzwBFLdniIPXAsqqw58Nsflzrk+PAd10CMuC78iM1PX2wROKqLtB4QA
         3s5GE779xIDJGUtCFVLhR7eVgbS40q72/nzh8Db+VTm9K95i+uJ3HDdCsfsd2Po6NkMp
         /Qyw==
X-Gm-Message-State: AO0yUKWmwsSshGlYE1pCz06YCU02vYT/1Mi7gZkV/7j8sgg1/WcN3d7F
	aqTJRCzfrV/fMK1gfzaGHBQ=
X-Google-Smtp-Source: AK7set8y8+lqcFY7J83+VVw58em4DDNKVzEhlqO9ggL0cHysz4rMn4mSFeYqhiKCBzV+MXYCeuFBLw==
X-Received: by 2002:a05:600c:1c9a:b0:3ee:7d85:e0d1 with SMTP id k26-20020a05600c1c9a00b003ee7d85e0d1mr1618459wms.2.1679558746605;
        Thu, 23 Mar 2023 01:05:46 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id z1-20020adff1c1000000b002c6e8af1037sm15527560wro.104.2023.03.23.01.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 01:05:46 -0700 (PDT)
Message-ID: <d8ea1378-043e-0980-1206-c321c880c56a@grimberg.me>
Date: Thu, 23 Mar 2023 10:05:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 6/9] nvme-core: open code nvme_delete_ctrl_sync()
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de
References: <20230323033636.812758-1-kch@nvidia.com>
 <20230323033636.812758-7-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230323033636.812758-7-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_010548_231044_4058F01D 
X-CRM114-Status: UNSURE (   6.13  )
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

