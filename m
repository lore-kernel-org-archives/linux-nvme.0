Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B68C43334
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jun 2022 13:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rk0p0hTM748OZonlzuCRhpMFWR+2pV3bjX+MvM+VDlY=; b=CPMv2HU+fXTm8sfN9zTbgudaCL
	e5kJ5UuvuqXEaNueaomT8djMaoVk/7dn4zVBKaIh68xj6FBH1twWQuWKhpfpNRjTnkYEwB/V75KB7
	pEySvxe1alq1iPHey01JnFZ+lDNg7IZKrVgazh+YkrCVu3bXnjedUBZhETcwiPhY///kepO7hDEW6
	UkWTfB76e365F9B9ojfcDtzIz+PPUmnd/LIzDJUg9WyHkBselVfSTMj9X1jUjcxztYhsh+8AKgvKT
	zV9BQHwgtoJl4u3jYDwRjeJLYHf3x7uggrbHpjFipv3/9K0jkhSuYlRpNlGRnOGCtCiwYhb8y/u+7
	qiUTjVNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5SXQ-00C0Og-41; Sun, 26 Jun 2022 13:42:56 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5SXN-00C0NI-Gh
	for linux-nvme@lists.infradead.org; Sun, 26 Jun 2022 13:42:54 +0000
Received: by mail-wr1-f46.google.com with SMTP id o16so9485282wra.4
        for <linux-nvme@lists.infradead.org>; Sun, 26 Jun 2022 06:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=Rk0p0hTM748OZonlzuCRhpMFWR+2pV3bjX+MvM+VDlY=;
        b=ayesw07YStiRks29Bd8pkSiLVrkOSie0bCKpNQwncfy2nX1N3Q+hip28vjLWWK4xum
         zr6SbZrS4CiRnMYAUY70G16qxtvD+p8utee2X8q/ix1pFVHGmUmx8Au8lrqTxzMx03TA
         +Woa+LouwUioATAu3LyVUSeCWX++SXwVyYFK4/ZWOlgqeqAz6wHTr1zM2kpoMPv1vWuM
         5oTRCVlF5YdZpeCrukuXey76dpOQPPYaSWUuF7xzEBAjAiwqbkbbNul6WyY5nD2SwzIp
         AsrC7rqjG5IRY8TUL9FlubROZQ7ms4qcbjVB1rbGAiclWLE9UzxLx1h/cgcSVMEVW1kE
         mvkw==
X-Gm-Message-State: AJIora8Dh/Z7IO7OW3+0a7qOUU4e9FLRes577nvZY3VA627m7m2IxQyH
	yC0SG673QZ+r4Wl4PyxWBbLTaddBb4g=
X-Google-Smtp-Source: AGRyM1vHBj+2MR7FZrrAbfby68iK5lK+gwyR52oNzd8OY6tvF8pJZjq6lrBjABZBoar62WkNWW3WsA==
X-Received: by 2002:a05:6000:1685:b0:218:45f0:5be6 with SMTP id y5-20020a056000168500b0021845f05be6mr7873199wrd.301.1656250971783;
        Sun, 26 Jun 2022 06:42:51 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id z22-20020a05600c221600b003a0499df21asm1101175wml.25.2022.06.26.06.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 06:42:51 -0700 (PDT)
Message-ID: <373139a7-069a-e5c7-d291-844a4620fb50@grimberg.me>
Date: Sun, 26 Jun 2022 16:42:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] Add new clear_ids attribute for passthru targets
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Alan Adamson <alan.adamson@oracle.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de
References: <20220622224724.19623-1-alan.adamson@oracle.com>
 <fc55e51a-7c08-4747-3bd2-857569831390@grimberg.me>
In-Reply-To: <fc55e51a-7c08-4747-3bd2-857569831390@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220626_064253_597457_3680F9A0 
X-CRM114-Status: UNSURE (   6.24  )
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


> I can't understand what this function does...

OK, just learned about it from a different thread. You can disregard.

