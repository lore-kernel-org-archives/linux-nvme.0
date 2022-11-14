Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C4BC433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Nov 2022 06:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=QOWwNiM6t/KeG5rV3SZS+3qcJQ
	WBn0xobWABf5UFitIlvF0UbRLilqg83mAGwNABCpFgqnsUne4cCVI6ow8WWCpt7GyrVEVArTbvWuO
	dXpygrgtjnbCAdejkyo6ay7wuy8qVXw8v5/A3SItCDQxdxK2geqe1NB6UhNbbGNFilxfTxmKCA2ZH
	7D9Ri+BqSC0JkYoyz7YAr1EEURtiLDokSVX9oq7rXq7rUo+Du4ZRaXbsr+BHPdLII7IA6uD2+0TSd
	roqseQUi+rxNUgO9+JwyEJBJwZtfcbu0B/tDq4nE+oVPVYglkkOVXRXTJuUbc07BxB6Eue12dkSFj
	GNMdWNnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouSuX-00GEpC-EI; Mon, 14 Nov 2022 06:25:37 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouSuU-00GEmn-O1
	for linux-nvme@lists.infradead.org; Mon, 14 Nov 2022 06:25:36 +0000
Received: by mail-wr1-f45.google.com with SMTP id d9so11559284wrm.13
        for <linux-nvme@lists.infradead.org>; Sun, 13 Nov 2022 22:25:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=fiC58724M/44qf/x7MdatiUqT9BfJ9kLvumOyIJ3X8gCiC6JaT0CHaXmHq4byD2CUE
         NO8OTFerrQMzGc76UuFuND3aE0rcvdrw7a7c2TKiV2W72gN5Pqub1PIiePD9S/rqd7/1
         3wOINATewYHqWWd84XderVZVbek+KoPrFvGAKy7cbBjxRtVZooOQ/81toKyfittpqrMC
         8NyzRTiDaU9J2sl7swHdUJRgC2B6//zsLiRDoLEvPibPzhXsrWBu98zqkVbrETCfwR+l
         +ymUjWhAu9d5vyCfnrWwaCHLsrWlSAB53/0VN67Ywa2rF5zfEliUXRXm4N2ehJ50Avs/
         zyig==
X-Gm-Message-State: ANoB5pnmAu/iYymjfOJJsUsFIBjYgTwEEXU9Q9/WpbRBskxxZKtK8wdb
	8oIvT62V+I/ITfADIimW3nqKMU5hHJQ=
X-Google-Smtp-Source: AA0mqf5jUvs7XHRTnRU6IUIwbNgv3dcPsH39/jeddxmzz9QgNd+Z1vxCQFdz0JDXY91QQO4M+kGU5Q==
X-Received: by 2002:a5d:538e:0:b0:236:71fe:c9c6 with SMTP id d14-20020a5d538e000000b0023671fec9c6mr6154284wrv.501.1668407130853;
        Sun, 13 Nov 2022 22:25:30 -0800 (PST)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id o37-20020a05600c512500b003cf54b77bfesm18094824wms.28.2022.11.13.22.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 22:25:30 -0800 (PST)
Message-ID: <43868b9f-548d-6d8d-197e-b5c21d7ea856@grimberg.me>
Date: Mon, 14 Nov 2022 08:25:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 01/13] nvme: don't call nvme_init_ctrl_finish from
 nvme_passthru_end
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Gerd Bayer <gbayer@linux.ibm.com>,
 asahi@lists.linux.dev, linux-nvme@lists.infradead.org
References: <20221113161138.883195-1-hch@lst.de>
 <20221113161138.883195-2-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221113161138.883195-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221113_222534_810959_61C02BD2 
X-CRM114-Status: UNSURE (   6.70  )
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

