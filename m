Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C377C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Dec 2021 09:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OXNu3NbVhjb05wvPMJ846q0OhvtM549laf+HJ+CfGY0=; b=qEdy2JLjz9Mj3oHVfe5oSYLuTB
	Ae4bz9u80nCTgsb2CudmhdS1KidcuhrhFzCTPn80MWhL7ZM/b7oAq0E36k/1wQ9QPgxnMHmudi8FA
	NOdO8FNDNHX3RSvzIN8xJ65o2BsDTnleWmk7HJjvEOWCq11NJH8B+GltiAsOhmAAyMcY/bBpVG8ux
	+HHu6LCZ/wy0xSeIMlLb0Riqj/4v6UG7MMQjAlRrEVUMeko9CyiHH267+sjUfkUEGS0UWY88VD6dx
	7xouFLcV+3n4HL+qwTf51E3P2wm4M+woVBGtxuHuQv0DxViYsMAdzaRDWr+oUcmZtF9AsfNJEAw89
	X6oWLRyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwLCR-006EtK-Ah; Sun, 12 Dec 2021 09:31:19 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwLCO-006Esz-1A
 for linux-nvme@lists.infradead.org; Sun, 12 Dec 2021 09:31:17 +0000
Received: by mail-wr1-f46.google.com with SMTP id u17so22188989wrt.3
 for <linux-nvme@lists.infradead.org>; Sun, 12 Dec 2021 01:31:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OXNu3NbVhjb05wvPMJ846q0OhvtM549laf+HJ+CfGY0=;
 b=PpGF07D/uo/PVeKRgr8+HdlTL2UBQ72rM7e7W+my7qDkpN+HIaR8dxN0t7fPXcsfCt
 6AYK4KfwjE/RNog6AoNCxIth8/tRrn+kVTZdXLwKRuKsmXx4JZ6Bx1n1mj2kL1a4eca5
 09+qZ3p9Bl17REmOeLVcKov0uOk5ut5JA/BkSdyRl3xwvMYsthMSROezzhj4RRIecCc1
 1V82SHsrLqJF3IE7W1bIReXCfhH1dpuNmedIP6f4nl7OpMI1RMqYqw9qq7lHPybl9TDe
 VASrvLPMPRnJV6OQzyXRD8sHRlQ6PzSD4gaRqP2vr+CE1867NCuBsq2zp3a57hlStlJ1
 S0xw==
X-Gm-Message-State: AOAM531Sq9H+1PUXtIdFbhz6113+yoFqNFPhG12dZzc1Q0xMZQb500hB
 dvRWL9sFY/paW7Lyur7YB8RGgoocPhg=
X-Google-Smtp-Source: ABdhPJw8QggKTv/XZteWhKKD/+UqBGjQbGQ47Whomd4PlBhx8RUnAP1WkA7LoJ0ZSPgu68np/E65qA==
X-Received: by 2002:a5d:64af:: with SMTP id m15mr25771694wrp.267.1639301474323; 
 Sun, 12 Dec 2021 01:31:14 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id o1sm8056041wrn.63.2021.12.12.01.31.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Dec 2021 01:31:13 -0800 (PST)
Subject: Re: [PATCH] nvme: add 'iopolicy' module parameter
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20211210131444.120946-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2164d771-935f-db52-08bc-d103bb611a52@grimberg.me>
Date: Sun, 12 Dec 2021 11:31:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211210131444.120946-1-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211212_013116_109599_B75E5940 
X-CRM114-Status: GOOD (  14.30  )
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


> While the 'iopolicy' sysfs attribute can be set at runtime, most
> storage arrays prefer to use the 'round-robin' iopolicy per default.
> We can use udev rules to set this, but is getting rather unwieldy
> for rebranded arrays as we would have to update the udev rules
> anytime a new array shows up, leading to the same mess we currently
> have in multipathd for configuring the RDAC arrays.
> 
> Hence this patch adds a module parameter 'iopolicy' to allow the
> admin to switch the default, and to do away with the need for a
> udev rule here.

This seems fine to me:
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

What do other think?

