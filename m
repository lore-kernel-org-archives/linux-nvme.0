Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23E0C6FA8E
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Sep 2022 09:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=rHeTVdmKRDiPuyE51GpwTBM51l
	Jbcl4nB80u5Yf2KEKRFDd0kDNTl1LoWKJn5Spk87r8OEgtaAnUnnIDIjvwNjb6lOqEF9L52nGjfDA
	csApOIP4XMFcYdiCNPxQGNq0RCwQTcgQKXMalq9+RoRaDp0CJZoXD+cpNU2ku9ujGRuTtwjXZ+CH2
	MI3ja/4NUnb8M0lXN5lImIuAwOLcLTzBpevQeD3b4g5TYG6xnZ7iQGJaSlcxclKRoVMFu/6nnipA5
	FIkbee+XzN8iANBDrIs63gD8xxTCHCbdezXNGUfmq/q7wvO0en0yz4pJ9FUX8DIRetcg64nHihkZJ
	per/mSEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaw67-00AR3K-Ia; Wed, 21 Sep 2022 09:32:51 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oavzH-00ANmI-Rh
	for linux-nvme@lists.infradead.org; Wed, 21 Sep 2022 09:25:49 +0000
Received: by mail-wr1-f41.google.com with SMTP id t7so8779186wrm.10
        for <linux-nvme@lists.infradead.org>; Wed, 21 Sep 2022 02:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=vwhBBXaCFp/J+iWXT5dlVS6wDJ+tD3gYkMDgOAz1XZWiQ6oK9nrP9MGQRAIzYs7Vm1
         j8ETVTU2kaL9F4LMKZed+lc773Frg7MBeZYWQnY8DrXDwlwlyoArTr89jdkzVr14Zbcy
         EUiojrOjY3mgAWzLLg4rKbf93gQILzOqs07Ertx6lDt6APfqE0EV4QITEicgctPWlqKV
         QixJ0IHuw2kwLUghB3sfVSPp+AGNRrId4bDz08Vnr2EJDyhyQSn7CQWt/VajSRQ0DjFk
         O2X0HWOrDlgYOkSPMHyKp7gud9BFauSZs073wBWU0xGfazVjJaurHi03fN4XgiZY4e0U
         MmzA==
X-Gm-Message-State: ACrzQf2sSFUQyT7BSOYgQrmfExiA4Gb1ht2h8pgUYSJR55PyqwHBUnfT
	BUWmMAFxjXVllGtOxUs29lk=
X-Google-Smtp-Source: AMsMyM6b8g2F7RgucDAxXKWAF+3k26GSR9j7AUWFbl5CV6RWCLNkUjU3eulD6PFX+hOkkObVIaOrKA==
X-Received: by 2002:a5d:6dc1:0:b0:22b:1256:c3e5 with SMTP id d1-20020a5d6dc1000000b0022b1256c3e5mr4955461wrz.336.1663752345158;
        Wed, 21 Sep 2022 02:25:45 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n37-20020a05600c3ba500b003a5c244fc13sm2330520wms.2.2022.09.21.02.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 02:25:44 -0700 (PDT)
Message-ID: <1d8f7d04-1442-2f5c-3e46-eedbb1611bb8@grimberg.me>
Date: Wed, 21 Sep 2022 12:25:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 03/13] nvme-tcp: store the generic nvme_ctrl in
 set->driver_data
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
References: <20220920171611.1289361-1-hch@lst.de>
 <20220920171611.1289361-4-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220920171611.1289361-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220921_022547_944498_BD5F1104 
X-CRM114-Status: UNSURE (   7.29  )
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

