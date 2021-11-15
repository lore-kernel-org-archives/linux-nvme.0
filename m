Return-Path: <SRS0=a356=QC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28DAC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Nov 2021 13:53:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66E4161AF0
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Nov 2021 13:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 66E4161AF0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=fZEMvyS9z1vvZqqi2t8twTdrwJ
	m7fZ4q/o6xtaagu/60eBJ/2ClkBl56alKhz2AstS4NwmACBdKFU0DGAl0ydZ/U8nJ3u6c6pZ2pLJq
	EvyKMUGrw4jvlATj/PwQYxaM9LeGlZPD1jKJplRjNernQrJy90qnuoYb0PSGQFUq2ZGMjRoSgmeZf
	6u56Ojn04oN6pYl4NFujqdaV73rC3aZTiKySXr1+N5HenZaPLAfboTR40Rct5w2L4nkJ8nDFdIE60
	Yhe9L8P6H7ere9+WauxOi2Msegs9V1FFHH/nx5Y4qDvvtXnOthd65rRoX/O2ZkxZ9AdAkUPwwDnqQ
	ILSYe1HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmcPz-00FmDr-47; Mon, 15 Nov 2021 13:53:07 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmcPv-00FmC8-Id
 for linux-nvme@lists.infradead.org; Mon, 15 Nov 2021 13:53:05 +0000
Received: by mail-wr1-f53.google.com with SMTP id d27so30892647wrb.6
 for <linux-nvme@lists.infradead.org>; Mon, 15 Nov 2021 05:53:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=0e+CrRQJSbv/CBDYhiOdl/0UhQJXyEwbdMtJMiJq9XkeW0yuD2x/U2fPPtPWEHD3bE
 176vTMbCNEKzRQHfpcI/bRkGxyU9ZPhdIFIfmzRz4d22NPGMghP1Zhvn54/K1kfwhHmz
 tLvWWecCKYU1juMgkdnmZo3cXIegACy+pQcxQvtGu1wj+lOm41agTP98EIEXhZdblxd3
 XX57HQvIGs1qKhzG8f/MdVrOkpU4/n3X6U3UAlFd3Cy3MdwuVIf43I0m6S5V6GrpfBJ4
 8XDGKbWIM2Es5N5QXMA01fgfKBwlq2ZPmpdQd4PnvFgTenyrJdy7JaV5fldqptLgauNZ
 Johw==
X-Gm-Message-State: AOAM530VcShZVeeC+CfDUmonP+bE2wnbMjYfb97grpzxo4AgbHZtU4e1
 xULfIbijz/tRdDoo3f62eWg=
X-Google-Smtp-Source: ABdhPJzK7eMS1hwY+MoQbTGFv1Cot6XrOyknR0Pit0LgAdSGZfzMR02284vs9Zmiu3sSAU313saw7A==
X-Received: by 2002:a05:6000:1681:: with SMTP id
 y1mr47195169wrd.52.1636984381600; 
 Mon, 15 Nov 2021 05:53:01 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id p62sm12978354wmp.10.2021.11.15.05.53.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Nov 2021 05:53:01 -0800 (PST)
Subject: Re: [PATCH 03/12] crypto/ffdhe: Finite Field DH Ephemeral Parameters
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>,
 David Miller <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20211112125928.97318-1-hare@suse.de>
 <20211112125928.97318-4-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <34063c15-8f9c-b862-6a02-66cb2c904390@grimberg.me>
Date: Mon, 15 Nov 2021 15:52:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211112125928.97318-4-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211115_055303_663635_36F84658 
X-CRM114-Status: GOOD (  10.13  )
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

