Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4DBC3DA6B
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Aug 2022 09:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=kMLG72ekmf1uRfUABiv/3KrLZG
	DfFUmA2kyDXfPjfp2F511u/F++dxOppnsvWlRAuB81A1/mAGOUGp4rtMSKBUDFSnovaxsvILphhzy
	BsOEEQRIMUR/kgHKiXYrtOsNniJYc6cHG7P70nx4uZmLIIoqYCF6EcyDpMwr6zNH26ZATGWw3c3YV
	GbEJ5dXHXnhEE9G3OacY8uDumHAnr4LhneNtLwn7AsZ+cBhbMpz80BG9fxlQx8+F6Ktkux+jLipja
	iDOhIpZJzspvChgBTyUAGHVU2JfhiFcKQ7KfE40TcuWUYhSqzaqEgSs5TiPbsIPfgGkGkRXjIZbV7
	Xsp/o6mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSaen-006TwR-LH; Mon, 29 Aug 2022 09:02:09 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSaek-006TsD-R9
	for linux-nvme@lists.infradead.org; Mon, 29 Aug 2022 09:02:07 +0000
Received: by mail-wr1-f42.google.com with SMTP id bu22so8966934wrb.3
        for <linux-nvme@lists.infradead.org>; Mon, 29 Aug 2022 02:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=4ZXEx6GeRiUkidKRRNeBxGu2Z5yC143+gLIu4guwsozDRIr5KyzvRIxGBN1fC02I0K
         sEQl7IDl5o7HE8VQvAFGr/Oql1ixI6g56HxHWhgTOHG/vdu/Cst20Xrp0FhC1F2RN32I
         W5gRV1WDam2Ff/yP+ix+qC1qufYq8EYssB/kduFT2y3n7eQI3TXzs93e4/hf042MXM/n
         RD6mOnNEAWLzI9Xy+uJ8tgiH1dIaSvHdZ/F0WcpwzHsK3j9cSSszgRpS0UrnVtJTUODZ
         2Cy2555m6K8xU8xZ31kchn43+WBcXajOQnkZlnCcEHBgb267Twzcs2B3vT7oKI/9Efjw
         1Dqg==
X-Gm-Message-State: ACgBeo2EnzZY/H3DNindubfSEpeoHI6lnh/Y9w7MtVNW/Kc057EKPVfb
	y0ZKYLRizQDO/T57IvMnlxMiFazUMqY=
X-Google-Smtp-Source: AA6agR6bPZR2pygb1fkrxLJxfdfwIzA2PbZi6xcA/RItA6Em0LjdadAhNTSikhFcJpYCZduCFOrT5Q==
X-Received: by 2002:a05:6000:795:b0:226:d45a:ffe5 with SMTP id bu21-20020a056000079500b00226d45affe5mr4494804wrb.33.1661763723445;
        Mon, 29 Aug 2022 02:02:03 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l7-20020a05600c1d0700b003a317ee3036sm9344694wms.2.2022.08.29.02.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 02:02:02 -0700 (PDT)
Message-ID: <998f9ac9-15bc-e343-daf0-617a16ac2c60@grimberg.me>
Date: Mon, 29 Aug 2022 12:02:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 3/3] nvme-rdma: Handle number of queue changes
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>, Chao Leng <lengchao@huawei.com>
References: <20220829083856.1850-1-dwagner@suse.de>
 <20220829083856.1850-4-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220829083856.1850-4-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_020206_889284_83D407BA 
X-CRM114-Status: UNSURE (   6.27  )
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

