Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C119BC433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Nov 2021 12:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=s1xhy8Ao67drFon6ousiTjOOZwQVHfxXahHRdI9vx+I=; b=vpIi4nwRDjcf4eTyD6l1jUbhe0
	R0NHBLtz7MJrFhIY5jNd9vnQor57FBQ8GxUdmf18SvuzfwZwGZDidlWq58ClDBRr1LqPd4WtfWmjX
	QHofuwnId2ZNaxQlgzwfBvVD1HNqAzMq8pjx6yCw1HAC7o5CyAz4QsIE2ysb8YHjJlKqo/BiKUB//
	9hXD9pwX+V0h78VPvSTS485rB7th/JYzl06hMJOYZtvwbG198zSMEEmJ9xiKif2LRf9hDXx3aIcYW
	p5h3qVwqY385FpOXbz8o1pup9AeFAh0xckWDsD6BeJ6FVDXSgw/7vL+gRmq4gshjHrC5YiYCyj2/I
	M9zc9ybA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mrIsz-00Fbxq-MZ; Sun, 28 Nov 2021 12:02:25 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mrIss-00Fbx6-K4
 for linux-nvme@lists.infradead.org; Sun, 28 Nov 2021 12:02:19 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 77-20020a1c0450000000b0033123de3425so14549375wme.0
 for <linux-nvme@lists.infradead.org>; Sun, 28 Nov 2021 04:02:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=s1xhy8Ao67drFon6ousiTjOOZwQVHfxXahHRdI9vx+I=;
 b=MnvS7xWJLal4rG7OBHEwP2pnD1ODtVorM0Z/C7HQNXegV/QDKj901pXMVIHmnlIPcU
 xXj1X1+/qCl4V/h/cDWdtIOLcl7oAsCuJLFheYJDWjkAmZ/yc8HyeNK416paDjNfDVKb
 OZCRQ/HeDeCMQy4WPEH1+E4X+s3vDEiMGdOVZpkJH9rROjj61W/u7ryCz6Qp1d1WQ/4V
 UoB0pjytNnQcBaxRcNCeV6RjeMbm2ZaOU9G+CRHOoA4bP/mhZzm50JTuSyrkc6jw7rcm
 8P8wMEcLppDeWPrHFkH8BXgY7I86PhN0gRJP7RangkJe4pMOSuXufBagVv9W+0pO9TcT
 ygNQ==
X-Gm-Message-State: AOAM530WPw5S2FpPwuI6uH35Qo6J+Xpvbh+xlKc+dJMoEEQ4UpdQnJPC
 gfiNOd9mUjOcyuFgvrsYxTQ=
X-Google-Smtp-Source: ABdhPJxQiVvALtLBRckOng7283vve4cUiB/mbnRpLuiV4bQuhJuDBcrJMIzj74bRq0QvIsct66inwg==
X-Received: by 2002:a1c:7907:: with SMTP id l7mr28751626wme.72.1638100936301; 
 Sun, 28 Nov 2021 04:02:16 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id q123sm15907602wma.30.2021.11.28.04.02.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Nov 2021 04:02:15 -0800 (PST)
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Hannes Reinecke <hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Subject: nvme connect-all endless loop?
Message-ID: <81576b69-07c0-a8ff-f818-6e8d2fbe691c@grimberg.me>
Date: Sun, 28 Nov 2021 14:02:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211128_040218_715419_D0846A8C 
X-CRM114-Status: UNSURE (   6.08  )
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

Hannes,

Seems that now that nvmet discovery service returns itself nvme
connect-all loops forever?

This was fixed before, and must have been broken with the
switch to libnvme...

