Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54F6C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jul 2022 22:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=nbfYzwZR3T80H/S4uYPy/pPD/M
	QrxagJ+RCfy5CrClW5/4MLYEjQMqYpMt2w+vwbfsgWWJ5aiqyklX1mGJ56gk34GMxHL4JI8MugtgN
	XqzfaQjmWr72YkScHsNKTmg5giPmMRFd/v0KEoXDM/3xLjh9ZN1OnHIA53LockU6zpwd4TBWLq1a8
	XbSsL0FdN83Pl1jtLrGLwVVuJ5QSNLyLtfAg+Hhw+yASkJymgj1kEJjp3TwHB/8tMzJpHqo5HGfGM
	aRl2o5bQXb7F6K+ZQsL3u80nlwWqsuSNB+LUlPZ4O1VMP8ChPbxg2+5OmyxITRN1ynBYMkXV/dskZ
	ysEDoFKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEeWT-00CmXi-EX; Thu, 21 Jul 2022 22:19:57 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEeWQ-00CmV6-GJ
	for linux-nvme@lists.infradead.org; Thu, 21 Jul 2022 22:19:55 +0000
Received: by mail-wr1-f41.google.com with SMTP id d8so4154594wrp.6
        for <linux-nvme@lists.infradead.org>; Thu, 21 Jul 2022 15:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=t0soHoanlwcBFC73hq7hBqgmSPaA+5ikfIoNCD6UE0VmwySQFOpN1no8sP8qnZoPmM
         YC4s4xRK4APNVRqPk0fPZoYQ4kkHaBtdw7wMU9gnOclpamt4YF4o25inS0Z8+mm0nBJy
         AgMWJuU++ETzd+wH9xkvkwrf8ofdAlJnRt0bEy1ObhFSt+ox8H4YUhBGzsw933tD/fc9
         uNZDINCbMJ/U2mdxAnD+/dDRdCkvBjzsUwFa1bsNPDOj5xo3go6ft6jjGwDQiJLqvlZ+
         w1fE2HppuQvJjYqRiOUaDb2yBm+P/dg0zS+qpy+v1MdQqk/+/zAd+JTwjs3tlR2iAGYK
         51VQ==
X-Gm-Message-State: AJIora/sivg2RtglD+6lj6iiFdQiVYtdw9suGOckrij1PTM9UaRaCy9z
	ZqVjSh/xAOKe5IaZVHn0Kv0=
X-Google-Smtp-Source: AGRyM1v/S7RwEbUBHDG9wp+JdNL0JyxOhb+0qa6ke3uOBoGaQUuyOy+ANKeH6rVx658W7tApRavUmw==
X-Received: by 2002:a05:6000:156f:b0:21d:887f:8ddf with SMTP id 15-20020a056000156f00b0021d887f8ddfmr370662wrz.534.1658441992682;
        Thu, 21 Jul 2022 15:19:52 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id o17-20020adfead1000000b0021e4536a948sm3061347wrn.79.2022.07.21.15.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 15:19:52 -0700 (PDT)
Message-ID: <79f5effe-0f82-b8f5-d505-9f9742b1c66c@grimberg.me>
Date: Fri, 22 Jul 2022 01:19:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvmet: fix a format specifier in
 nvmet_auth_ctrl_exponential
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Cc: linux@roeck-us.net, hare@suse.de
References: <20220718050356.227647-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220718050356.227647-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220721_151954_549781_4007D7A5 
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

