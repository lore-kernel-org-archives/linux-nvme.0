Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6565FC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Apr 2022 12:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EcviS0AT57YPsp2F9MqcgJTFwpvExVaZsrbcRJUFZ4c=; b=uJk9rmNixWYNQeBDuz5caO1nXB
	Q9znEaHjdprK3EeQygtjVmwWXZzSyHJWY4IuvY3nLyWy3PHUwXPh0/WwSY+ZvrYSLBG7PutcLCoKe
	WYliLAd+7Qfvq4jEr017figDUp8NMS+0fE/NjNe0Y8ZY6MKkxbW/Ea9IJYNClIqqsHJIFkOw+RLdG
	utceoC9JTlQiZgPRnJAlUPoP7x6Phupmqm9WQwCghZOgDzaNPGfpIDadqnoBzG6rGsRJdsELIU9u9
	pfdSWQtOgFXKnJ6rh18gK1/TTXm0T8Jve7xKe+joE6XGVfYL664KZgSpPTo2OhkzIxqTLC2nT+VRQ
	l/DiAkuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neFpN-00EEQx-3e; Tue, 12 Apr 2022 12:41:01 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neFeI-00E8oq-Ii
 for linux-nvme@lists.infradead.org; Tue, 12 Apr 2022 12:29:35 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 l62-20020a1c2541000000b0038e4570af2fso1510351wml.5
 for <linux-nvme@lists.infradead.org>; Tue, 12 Apr 2022 05:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=EcviS0AT57YPsp2F9MqcgJTFwpvExVaZsrbcRJUFZ4c=;
 b=FVRMLAxGyQUoxhhrcO754EDaHAW1Vv2zl3S7MVm0+wlOXrmMVWt/Cu9P3acZLFOWwu
 u49O1EsthWi2/nEQt0DRs/CsejA4eZ6cCZXqrgfeIbv0XZkh8u60FFB61Qfp9S34hIvG
 1QC8ORYqbU1JMhANokfzx3bl5USl28wluX8fmoUJ/S0AVDlJlrwkrZWA6GLAaaSE4LIc
 tN0rYihuLYTnoTQmMggCfHUu5qFhP665Lh8jDMGCy6dnkpw40v5ax2bv5hJu2PXExfOt
 rEk2aglx/OrC/Av9Re1F5IdJAi0sDYid9pRa0iV7+6bdF4htxdIJUFt1tyqsw2K25Rar
 GBKw==
X-Gm-Message-State: AOAM532vH4lEUV080HkJNEsdYx+fP7d43OuXxYwdLtdvjjakMRAUZpfd
 C2LhKzXadT1l95NW5vuzvwo=
X-Google-Smtp-Source: ABdhPJyGPJq71lqm1jVA9HW42P+IhCciodm4GEgalevmsKk9BzXuG0sdDZaGe4P8M9AQoQdI1CtsZw==
X-Received: by 2002:a05:600c:3d14:b0:38c:9d85:781d with SMTP id
 bh20-20020a05600c3d1400b0038c9d85781dmr3875245wmb.191.1649766571415; 
 Tue, 12 Apr 2022 05:29:31 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 v15-20020a056000144f00b002079acb2349sm10685842wrx.1.2022.04.12.05.29.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Apr 2022 05:29:31 -0700 (PDT)
Message-ID: <626e3bf5-1faf-b169-9184-d6d3a0470a28@grimberg.me>
Date: Tue, 12 Apr 2022 15:29:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] nvmet: include all configured ports in the discovery
 log page
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220408065930.123015-1-hare@suse.de>
 <20220408065930.123015-4-hare@suse.de>
 <dddcb416-e4c8-b1d7-e893-416d819653dd@grimberg.me>
 <ff897f9c-0b7d-d745-b780-4336b0e4820e@suse.de>
 <e7ffdfcb-7617-4377-a427-080ef3eccaa4@grimberg.me>
 <13db553e-817d-c8b7-50ad-a5bc38667727@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <13db553e-817d-c8b7-50ad-a5bc38667727@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220412_052934_662361_02F93E9E 
X-CRM114-Status: GOOD (  16.88  )
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


>> My issue is that its causing the unique disc-susbsys behavior diverge
>> from the standard one...
> 
> Ah. Okay.
> That is true.
> 
> But having the default setup reflected in configfs is hard, as then you 
> would need to create links from the default discovery subsystem to each 
> port (on port creation!).
> The current configfs design simply doesn't allow you to do that, so 
> attempting something like that would break compability.
> 
> Which is the big plus for this patchset; it doesn't change the user 
> interface, and nvmetcli can be used as-is.
> 
> So sure, I can have a look to expose the default discovery subsystem, 
> too. But that would require a module or configfs parameter, _and_ will 
> require changes to nvmetcli.

Before this patch, you added support for unique disc-subsys NQNs, which
behaved similarly to the standard disc-subsys. In this patch, you
made unique disc-subsys return a different discovery log-page. That is
my issue.

There are 3 approaches we can take instead:
1. ignore this patch, and make the unique disc-subsys to be attached
to multiple ports, but return only subsystems in the same port where
the host is accessing it.

2. make the standard disc-subsys return subsystems on all ports like
what you proposed for unique disc-subsys in this patch.

3. introduce an explicit setting for unique disc-subsys to return cross
port log page. i.e. make the divergence explicit.

