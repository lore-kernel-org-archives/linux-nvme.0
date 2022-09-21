Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFD0C32771
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Sep 2022 10:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=NMflgAlQYr4taBh6U9ih8c+Pi9
	VQRMICBUq2GQlgFys84QvqK8MctRzdb7hj2A3yaJY5ptkoPUo/tOTLAj2l2IARJlL4K2d2VoMryX/
	wqKeBNCMOsrma6t5k5/8YNL2wnQR/BcCDzN/b4N01yjgiwrALJFy+L2VExqjYYcWrvUoUB/1NbFjL
	Lqx2glAXozXlqRqVJm2Su1fBeQDBsW1QEUcO3Fkeaxbs3KBQtbwU0Z3SsmUjM68lsM8W6bX1WAt7z
	ryNY3qKjX51CFvs0mFXieh2vCS6nvoZB1azuzrL4HierH7gGm1brOV7lID6MpJihrSDuD9yTHGmo9
	EamJmBng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaxGu-00Ax5d-6G; Wed, 21 Sep 2022 10:48:04 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaw7K-00ARUo-Gm
	for linux-nvme@lists.infradead.org; Wed, 21 Sep 2022 09:34:07 +0000
Received: by mail-wr1-f48.google.com with SMTP id n10so8806964wrw.12
        for <linux-nvme@lists.infradead.org>; Wed, 21 Sep 2022 02:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=7Z9buiXpXgRTJ0LPZuUH7vZFlAok3M2D8Uo/D8Q0bEovi8BeUPiWQVg16bmwom8c4R
         i82V3VHoEqMqFPWQKUp7UGBPuxeT5mZ3yYiavQV4Pe3Ds+CLu8GM0WQT/L1si22MVJrM
         OX2YX1jhSfsnM8D4eIbOAOK+mYdxO8LpFLdflrfbAOV7VgmSQx94MDetqIurSf7x8NIz
         BjCgP+nwQEqV5+nGt3fcfJWRdHwgpvLzARa4ZoEmflWy3BAtbmrD1qezMM+TsVq75AN8
         Ko8k3H4eiPslDjuQ/qAiM4ORb4pIinamwVGd5jrbWG3AcfoWvXidj/XVrRooVl4miV5L
         GOAw==
X-Gm-Message-State: ACrzQf31VdTfyVIS98KX3H8vVYVqdJdhnY6NSu+aa+yEN+x/F8d7H37f
	TAvWla4ftNDQbSwmYk58NJ+kK82NLBQ=
X-Google-Smtp-Source: AMsMyM6z/ISWl0F9tNIVLCjD8NhD0Htw5IMfXUXFwJDKxCaInk7sx4iru6BsyG8KNF12H7oxxb/KVw==
X-Received: by 2002:a05:6000:1a8d:b0:22a:44e9:831e with SMTP id f13-20020a0560001a8d00b0022a44e9831emr17202702wry.575.1663752844819;
        Wed, 21 Sep 2022 02:34:04 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bn27-20020a056000061b00b0022762b0e2a2sm2276159wrb.6.2022.09.21.02.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 02:34:04 -0700 (PDT)
Message-ID: <bb7c5fe2-8115-95be-3291-8d3568000c53@grimberg.me>
Date: Wed, 21 Sep 2022 12:34:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 11/13] nvme-loop: store the generic nvme_ctrl in
 set->driver_data
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
References: <20220920171611.1289361-1-hch@lst.de>
 <20220920171611.1289361-12-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220920171611.1289361-12-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220921_023406_590701_A6E936CB 
X-CRM114-Status: UNSURE (   7.40  )
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

