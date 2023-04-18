Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B88C77B78
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Apr 2023 16:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1po+Qokb8g5646qCqbO5j/GfDEEBHdXv/guAzjWb6AY=; b=UTIUsLzRVyyuLrKF0RUk16k3MR
	sHWfia2rNs/gjLI1P/3z4YG3wLVj7LlR5zsSz2vNwaqp9Y64qvSemfXU4Q2md6h5wjxe10Dv45Yum
	uRPvlELF2k2pXVO4KYFsQ9Q5oefZqR/7ohBKBdB2rfROiSzMkNcI5+Rzp0lOH1dcEIdaEczyoaijW
	GKUQQ2aHbhr0Nl7kpp5lj6nk1w4m2lAbYRANfwPXWrPaFj1fnbmAoHgQgJB0nohN7Azna9tYSsBe6
	ZMeVL6L/AGj7jVSLjc+d3SOVGp954KLuimmvLgIp7Gqp4IDFYLt4E3ap5CE3s9RvUbXt/y+mK5wYX
	wOj8ryfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poogO-002s2i-2C;
	Tue, 18 Apr 2023 16:59:56 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poogM-002s1r-10
	for linux-nvme@lists.infradead.org;
	Tue, 18 Apr 2023 16:59:55 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-3f0968734f6so12480755e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 18 Apr 2023 09:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681837193; x=1684429193;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1po+Qokb8g5646qCqbO5j/GfDEEBHdXv/guAzjWb6AY=;
        b=aCLP98gFbMXZs7b8+JwLYKbJLWJuQ05uDoiNxq8SeoDyyMgDOoU/eP10QCo1MQjx/R
         TGbnEpNARYqP4bOtg8hzPfoIhS4WLBKx+kIej5+hbyNVk6aIabRcL6VuImqMxp4NUpGo
         41eqWagf/5EoEt+9Id6aDGlPHAs5HknRdfxBy5yDdm+AQWBHKOT0hdrs+bK08cz3+oX2
         8CNja1Pv0I9JhuPbqV6vnZP7wUJlIRwiegon+zSk73MQ0AnG+T+ZEB1Y6pULxDnMQlHX
         GAc/vE/oi6BkeF2Buze4J3E1hFpE+ULG4A7JIw+41BIxrVoGMGna5yuhJgocPo26RlmW
         pF8A==
X-Gm-Message-State: AAQBX9fQSkaxVDcf4o1DjW0wpR8EyES2UqBZEKjaZUps8RRrWLBEoO+k
	eEanvHhb+dyj337lEzpuGuYyMEVjac8=
X-Google-Smtp-Source: AKy350a5jr3ndAzbvppHVHOuLo/Km3xqWAcfauUun91qPJkYzdRsWNQ6DZBJXxxo1KsJuD/+3ReIXg==
X-Received: by 2002:a05:600c:310e:b0:3f1:78bd:c38b with SMTP id g14-20020a05600c310e00b003f178bdc38bmr2819576wmo.4.1681837192987;
        Tue, 18 Apr 2023 09:59:52 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.11.dynamic.barak-online.net. [85.65.206.11])
        by smtp.gmail.com with ESMTPSA id c8-20020a05600c0a4800b003ee5fa61f45sm19475686wmq.3.2023.04.18.09.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 09:59:52 -0700 (PDT)
Message-ID: <8c3c82ba-2551-487a-4593-b9369e5ccfb0@grimberg.me>
Date: Tue, 18 Apr 2023 19:59:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/3] nvme: improve handling of long keep alives
Content-Language: en-US
To: Uday Shankar <ushankar@purestorage.com>,
 Costa Sapuntzakis <costa@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@fb.com>
Cc: linux-nvme@lists.infradead.org
References: <20230417225558.2890062-1-ushankar@purestorage.com>
 <20230417225558.2890062-4-ushankar@purestorage.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230417225558.2890062-4-ushankar@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_095954_344726_BD896F8F 
X-CRM114-Status: GOOD (  12.53  )
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



On 4/18/23 01:55, Uday Shankar wrote:
> Upon keep alive completion, nvme_keep_alive_work is scheduled with the
> same delay every time. If keep alive commands are completing slowly,
> this may cause a keep alive timeout. The following trace illustrates the
> issue, taking KATO = 8 and TBKAS off for simplicity:
> 
> 1. t = 0: run nvme_keep_alive_work, send keep alive
> 2. t = ε: keep alive reaches controller, controller restarts its keep
>            alive timer
> 3. t = 4: host receives keep alive completion, schedules
>            nvme_keep_alive_work with delay 4
> 4. t = 8: run nvme_keep_alive_work, send keep alive
> 
> Here, a keep alive having RTT of 4 causes a delay of at least 8 - ε
> between the controller receiving successive keep alives. With ε small,
> the controller is likely to detect a keep alive timeout.
> 
> Fix this by calculating the RTT of the keep alive command, and adjusting
> the scheduling delay of the next keep alive work accordingly.

Is this something that was met in reality?

it is surprising that host->ctrl is super fast and
ctrl->host is super slow to the extent that this
situation exists in reality...

