Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB88C43334
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Jul 2022 11:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dqB5hAuVWP/9QqwuPpDXGq1Hp4H2xZQxPFR+Q9W2D4E=; b=4zFc6IcEUCRx1Y/q3lMGsmEbuF
	RCPGeidDYax2UOLopJsQGheeke0m6ev59RGx+2WhI71mfs2/rglCjakpKYT8QBoIYO0zNI6Qr/gi6
	UsxesjCHjxYeEMouJlH84nSbmftSBAgkXdEEAhgAlHtquxL2Mzagsy8RsA5GdjIC9J2bXRqXyKJAt
	H7tr3hYGAVs14zf+EULzmC5Nqfri1TuiMq/XkYK5xyi0iur2Qw3r2sZwEw9fR07QCj2weZPnV95JA
	IaPHnbz3TOV0Hz1M12dP+D+y+tVbUa6Saxd7KAMJTR2kgrQO0eMsns5by0H3G8YVLnO82Q+h/SBYY
	/IXdgD5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAUkf-00BUib-Gj; Sun, 10 Jul 2022 11:05:25 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAUkc-00BUi8-Nt
	for linux-nvme@lists.infradead.org; Sun, 10 Jul 2022 11:05:24 +0000
Received: by mail-wr1-f47.google.com with SMTP id o4so3709043wrh.3
        for <linux-nvme@lists.infradead.org>; Sun, 10 Jul 2022 04:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dqB5hAuVWP/9QqwuPpDXGq1Hp4H2xZQxPFR+Q9W2D4E=;
        b=DLFARNOVqd4y82HStPhKxUkF0RFg2bJKfaX6zt3FoHALdXFpmezZ3hUcQ0HZHB2mc7
         gwUDQYeI5/i1CIT5EbC5mw3TJqdSW2legCd8S/hAnPQJBH+ItsqfW70H3w4UtCYJpwFg
         40393/XDFf6rsdTXh4hFTnxEyBi6Fbvtp5W6mX6nqdEed6q37ZBhw++XhxKl+NScE/8G
         HHEECjCewFWV0bLa2ehl67B90UJPBJsGBUewYgoTmeSjzYfM7t/dWHT15yXQ+PbcmjyP
         MChd3oLFc0JkgP+2bDE9nyVV2cRFVQ+lFaCZfPPdisKngkn2tI6O6v9nDvxi06i9dC+J
         Lnfg==
X-Gm-Message-State: AJIora+AI/NggSQspQlHOEG+o/3lRYQxSP3CmFcTNPENU2rIJDuotZQU
	YN6OQfNE8NAzL1X+IpbI8tsPrwhaIHo=
X-Google-Smtp-Source: AGRyM1t9v4uXLBjZEydPyu7B9Rm7MBBK8Zwa8MnvBdx+8eyDhlhG3DWmTumUgTJ/75Q9dzO75lAyOA==
X-Received: by 2002:a5d:6683:0:b0:21d:7643:dff3 with SMTP id l3-20020a5d6683000000b0021d7643dff3mr11886380wru.304.1657451120701;
        Sun, 10 Jul 2022 04:05:20 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c4ecc00b0039c99f61e5bsm7880333wmq.5.2022.07.10.04.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jul 2022 04:05:20 -0700 (PDT)
Message-ID: <e906e74a-3754-1db8-ed14-ebc3c78d0399@grimberg.me>
Date: Sun, 10 Jul 2022 14:05:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] nvme-tcp: use in-capsule data for I/O connect
Content-Language: en-US
To: Caleb Sander <csander@purestorage.com>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 linux-nvme@lists.infradead.org
References: <4cfe8116-bb6c-735d-0bb3-ce5e2612505b@grimberg.me>
 <20220707211245.3989107-1-csander@purestorage.com>
 <20220708050038.GA15655@lst.de>
 <CADUfDZp-oRUYoXxMwtA5qYux2-AKuimXk-hHWMwwv5tD1ZDUXg@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CADUfDZp-oRUYoXxMwtA5qYux2-AKuimXk-hHWMwwv5tD1ZDUXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220710_040522_811462_E76D3C6A 
X-CRM114-Status: GOOD (  15.68  )
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


>> While I'm fine with this change, can you please state here why this
>> is important?  Is there a use case where it really matters?  A controller
>> that is unhappy if this doesn't happen?
> 
> It's just an optimization. Without this change, we send the connect command
> capsule and data in separate PDUs (CapsuleCmd and H2CData), and must wait for
> the controller to respond with an R2T PDU before sending the H2CData.
> With the change, we send a single CapsuleCmd PDU that includes the data.
> This reduces the number of bytes (and likely packets) sent across the network,
> and simplifies the send state machine handling in the driver.
> 
> Using in-capsule data does not "really matter" for admin commands either,
> but we appear to have decided that the optimization is worth it.
> So I am just suggesting we extend the logic to the I/O connect command.

I think that the question was, does a controller that suffers from this
inefficiency exist? Up until now the controllers seen in the wild all
support ioccsz that accepts IO connect to go in-capsule.

