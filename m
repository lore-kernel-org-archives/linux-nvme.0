Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88DCC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 10:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=plsFhNPT2nAQaT+BVTZqkhvH58bKHg1xVmV0bMSQzis=; b=vqb1skLWUTmrhCIuPMmYJURzsV
	drzAynBuDlyRkdFsWMaj0fe5/+gQAiW/HvIGFZAQckue2XhK3XWfIz9Hrz3hTxlovFx/5gJvf+DQm
	vzHMHibgvfTYU7Tr8gnVaKmKdzd5VteP2GWQz54JVpL+x7Gs2YPuFk6MwO/1kb+spJ9mxXAbkbpr6
	8khzpUxTidk1pOlwGvF26gRcjqQ/yOhqbCMWVjJCy0CIzh59bTk5cDs9MPWdEbHQsQMztuUHWz8AA
	jIQr5Tf85uxWYXRJsMMTQlTWSZdX5TY4vm9tAR6AQ8/YXMmXiVj5PDDI4knd/ttUhZoCWuZnMhcLy
	kr6lvlYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbgKk-000dUZ-Uz; Tue, 05 Apr 2022 10:22:46 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbgKh-000dSp-Qc
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 10:22:45 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 l7-20020a05600c1d0700b0038c99618859so1265434wms.2
 for <linux-nvme@lists.infradead.org>; Tue, 05 Apr 2022 03:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=plsFhNPT2nAQaT+BVTZqkhvH58bKHg1xVmV0bMSQzis=;
 b=VdFy9rd3ApBDj0jGnFbRKzMEv/Irn44AkIqyZdyXayfgW52AXddQ5+nCPdnzgRUD7t
 PuPawBc8HNDO3620aCtZUFEPA408QbkTS8dL6c7aBhVkAIX/9N764tezpLXmQDl2uDbP
 nGkEt3Rnd4e4f0+kSOBtcff9D+UVFeltWLFDJ8+fD1EllaIqD4gYNAicA8SfnvV3l9PN
 sZbvpR5lYS+DV/2jL3q7q6VWokvx1Q+uaHdEfiLSKNbwFJA85oSRB4H9TOa0nQOHbcD7
 5q5tA7pyjUjHEc6UUpcmwTPWuKYHS6hCJS2x7cmknZSGenQ29uA0ACfufc/pjAsfjuqS
 ESOg==
X-Gm-Message-State: AOAM530jgeVbM+GEdmsqDCRAlniM/vuY2jmIxvdhjAhft0rAPJbY3MwS
 cySGToE2v3/Eth6izUDG5vI=
X-Google-Smtp-Source: ABdhPJwSZmAgbLANOfDy4dlsDindjkNMaQP5a2QXAL3sZUYFd009VAzB5m5LsyoL8U/2q/04AZ28WQ==
X-Received: by 2002:a05:600c:1d9b:b0:38c:af70:9998 with SMTP id
 p27-20020a05600c1d9b00b0038caf709998mr2398458wms.169.1649154160871; 
 Tue, 05 Apr 2022 03:22:40 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 185-20020a1c19c2000000b0038a1d06e862sm1773616wmz.14.2022.04.05.03.22.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Apr 2022 03:22:40 -0700 (PDT)
Message-ID: <1105c039-372f-f105-8d69-887a62e0223e@grimberg.me>
Date: Tue, 5 Apr 2022 13:22:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] nvme: add namespace paths links
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 util-linux@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
References: <20220401092855.90652-1-hare@suse.de>
 <20220405054205.GA23466@lst.de>
 <289ee526-8f3f-9a2b-eef4-70816eb4f42e@suse.de>
 <20220405054836.GA23647@lst.de>
 <b997ceac-a391-cc5a-a397-0d68f91736eb@grimberg.me>
 <0d53d5cb-a22d-c620-1a35-1ab408e0f747@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <0d53d5cb-a22d-c620-1a35-1ab408e0f747@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220405_032243_894339_B440D954 
X-CRM114-Status: UNSURE (   8.73  )
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


>> Why not stick to slaves/ like the device mapper?
> 
> Because:
> 
> /**
>   * bd_link_disk_holder - create symlinks between holding disk and slave 
> bdev
>   * @bdev: the claimed slave bdev
>   * @disk: the holding disk
>   *
>   * DON'T USE THIS UNLESS YOU'RE ALREADY USING IT.
>   *
> 
> Not sure _why_ it's there, but it is there.

Fair enough

