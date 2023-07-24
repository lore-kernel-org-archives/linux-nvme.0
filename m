Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06B9C001DE
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jul 2023 07:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=csHOlK60oFtyoKK55DCid0LNEQDIrrzyZU/pUX0ng1M=; b=101GVmnNoP7XtxlxBQNSAfm5IV
	PsRF4//aAuTmUg1qSQSXGru+c8dknWeyoJvZ23GPZtQVePw7zopIXIUQg8rhZ6+Hiuk30pDjyNZ1S
	ZnV5fvyMJWjMU88npix8JPvOO9H7dTTUphbDkTqKPg60YB5hPu+joH88PeqSGMIETXj2ucmv+TJuA
	HZxOIkzh9wUbk/Cj3gBySz2a/K/Q1QE5If9eQXw0zTckpyTRQmlMKP1C04THapnnuNr7hviZ/wShR
	NyoZ6NzX1xwCIDEZEIjmetzeiFgCpfueEQ2cWPyzGANfGiSV1sMj1riVBB7p8b0qLCEs410yBI5Er
	qBq1dc6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNptK-0035PY-1g;
	Mon, 24 Jul 2023 07:22:02 +0000
Received: from mail-lj1-f177.google.com ([209.85.208.177])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNptH-0035On-1T
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jul 2023 07:22:01 +0000
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2b83c673ab5so10946651fa.1
        for <linux-nvme@lists.infradead.org>; Mon, 24 Jul 2023 00:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690183316; x=1690788116;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=csHOlK60oFtyoKK55DCid0LNEQDIrrzyZU/pUX0ng1M=;
        b=I1sYl2n8yOloHa2FXHvQjHxhKIadc3TFYE7puHRy7n/9ll7yZ0wuxxpHHe/2IJ+t/i
         pjPsMhB8pjMqqHtZHSVuA1uonqjH8btBDX4N64FWIzKaQOuH8avn4A7HOq4xL7gp46Tg
         ghxx8ioQ2OGRZ1Y5/A0ozv8rMv92v6F3uSbhgW5TMtruU/dHqt9KY1SEJ8PlEx8RY3sZ
         ZIISEbJOlcIOCrdGlJ4dkHiIWrAbRQDizYtsawMOMgNFm2nla6JJibZocNDLlS3ZoKGD
         u4L7jmyXK1HtAg+C7GlaPdLp6OQN36BQqzk4X4vKBANh4dEF6CdhY1s6MKv+0H4/yy8g
         1AjA==
X-Gm-Message-State: ABy/qLbszaCCZPibUpHsVkMwoE3E4quVa9NhU41ciVohsr0beG7vB1Of
	0ZW3ozGYsHjb41fn+LgyBoHlwz6isnc=
X-Google-Smtp-Source: APBJJlGL3OVo/tghx+lWn9HITaXRKTzvnR6vR/lieEMtbY0b49/X5EaR0GjTv5+BSbsIXBNaE13nMg==
X-Received: by 2002:a2e:a98b:0:b0:2b6:99a7:2fb4 with SMTP id x11-20020a2ea98b000000b002b699a72fb4mr4787194ljq.0.1690183315690;
        Mon, 24 Jul 2023 00:21:55 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p3-20020a05600c204300b003fc3b03e41esm12385411wmg.1.2023.07.24.00.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 00:21:54 -0700 (PDT)
Message-ID: <9f37941c-b265-7f28-ebec-76c04804b684@grimberg.me>
Date: Mon, 24 Jul 2023 10:21:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCHv8 0/6] net/tls: fixes for NVMe-over-TLS
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Jakub Kicinski <kuba@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230721143523.56906-1-hare@suse.de>
 <20230721190026.25d2f0a5@kernel.org>
 <3e83c1dd-99bd-4dbd-2f83-4008e7059cfa@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <3e83c1dd-99bd-4dbd-2f83-4008e7059cfa@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_002159_514465_8FBF997B 
X-CRM114-Status: GOOD (  14.16  )
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


>>> here are some small fixes to get NVMe-over-TLS up and running.
>>> The first set are just minor modifications to have MSG_EOR handled
>>> for TLS, but the second set implements the ->read_sock() callback for 
>>> tls_sw
>>> which I guess could do with some reviews.
>>
>> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
>>
>> Sagi, I _think_ a stable branch with this should be doable,
>> would you like one, or no rush?
> 
> I guess a stable branch would not be too bad; I've got another
> set of patches for the NVMe side, too.
> Sagi?

I don't think there is a real need for this to go to stable, nothing
is using it. Perhaps the MSG_EOR patches can go to stable in case
there is some userspace code that wants to rely on it.

