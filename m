Return-Path: <SRS0=a356=QC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662B7C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Nov 2021 13:12:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 202A461AA7
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Nov 2021 13:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 202A461AA7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lcU07j4Rod4Dd+9mHoihuNORYaJb9sSw0tUuWGbvdHc=; b=qBE/TYEv7rKdxp4m52b6cncT0M
	AnG1p91oNbI7HnLL+GCpBbp9Lgg4SbLCsU66LAYHPtly0WDbIQ6GyD/AQGOU+ty9RbufOzoJRoYhp
	hQyB3Fo59oVZ9NcTshsCVJ943QRrj8DHQ3/pbU5xTI73ds9jjvcgPvSehQIrFEGPiUSnyM334S6qO
	8ouKoEIiIUGg3G4cPkfHQw7QGjK/9t8V2biIdNxLq/SQ5U1+I3DqbOkrg12deY/DvNnNn3cEn3Dsv
	1KmrAkZ6vY7xdkEVyFXd7pOj5vsKFPy+7L9VGAorpLKSl4AmjlOERyqfOl+AhVEeAv9Kp9yIXuAWJ
	O2MLKL+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmbn0-00FcCy-Cp; Mon, 15 Nov 2021 13:12:50 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmbmw-00FcAf-5i
 for linux-nvme@lists.infradead.org; Mon, 15 Nov 2021 13:12:48 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 p3-20020a05600c1d8300b003334fab53afso12859558wms.3
 for <linux-nvme@lists.infradead.org>; Mon, 15 Nov 2021 05:12:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lcU07j4Rod4Dd+9mHoihuNORYaJb9sSw0tUuWGbvdHc=;
 b=kw2Gowk/7gKCTlQXsMVl7FwSpyivWC+6X9SokcnWXhDATkK4BHBz5FQTkD2Dk00g/2
 ZtG7Q71Nq56Aw3fwbkqstW+AgL/n3QcYHKAIThAih3k9k5px9+VjxrO0swBzItpJ2hvG
 NeLnkXtCkncZ6jMntUxAIl6V6xCS4V/Xwv2O9L+rNV42qWEnITAOPkQooXNjz8ZYqwKs
 u4sc6uIxZPUBbQKR11dmFs67ZeOvjA1af5ifXKAhF0TeBcpjTZ+RMztF9VMIUAQRzz21
 FOpF6isNSX66TwtP/IVB2LmFIoKaSD3fsnMRWCJ3WuhOvIbKC4KDXC/02XXMqDqdAaT+
 kUvg==
X-Gm-Message-State: AOAM5310EEp2ENnZjS2rVfsV/fGC6put0+yqJj8OOqHLi8/Qb8b3nH8V
 c4RNxxrGJquWARl6XkYTD1Y=
X-Google-Smtp-Source: ABdhPJxWEOzowTyGDkPW/PGQrInqOFpiov6Y+oGjOhsvkOG6c5uETXzMombZJ5l5AmbsGEYn6zBWSA==
X-Received: by 2002:a1c:8015:: with SMTP id b21mr58314163wmd.161.1636981963539; 
 Mon, 15 Nov 2021 05:12:43 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id f7sm22811555wmg.6.2021.11.15.05.12.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Nov 2021 05:12:42 -0800 (PST)
Subject: Re: [PATCHv5 00/12] nvme: In-band authentication support
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>,
 David Miller <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20211112125928.97318-1-hare@suse.de>
 <74db7c77-7cbf-4bc9-1c80-e7c42acaea64@grimberg.me>
 <f67ca46e-f421-33f7-da8b-ff6e47acf8c2@suse.de>
 <8553266f-005c-f947-4737-2108cb7062d1@grimberg.me>
 <a7363853-05af-9d7f-4d6f-b02ec756ce6b@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e24778c6-2ff1-ab14-95b0-354368cbfb35@grimberg.me>
Date: Mon, 15 Nov 2021 15:12:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <a7363853-05af-9d7f-4d6f-b02ec756ce6b@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211115_051246_253932_0DA85B87 
X-CRM114-Status: GOOD (  14.83  )
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


> BTW, I've created a pull request for nvme-cli
> (https://github.com/linux-nvme/nvme-cli/pull/1237)
> to add a new command-line option 'dump-config'; can you check if that's
> what you had in mind or whether it needs to be improved further?

The dump is nice, thanks. I gave a couple of comments on the PR.
I do suspect that people will want to populate this file outside
of dump-config, hence we need a markdown documentation for it
or in this case a json schema...

