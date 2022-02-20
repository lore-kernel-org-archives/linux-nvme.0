Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9E0C433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Feb 2022 12:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e/Abmyu2LYrtWrbT9swdc1mujJPrnTmHdLRBCu31e6s=; b=Wl0CyIr05WvnX+byHTDMpfnqZJ
	TPtjKGRxnekfcRopYAZODo4Y6B0smdi98xrdYUJRo+UNOiihBo7YB8dyvaa4q/92VOpizXvvBrgUG
	/uYv8BrOMBA9Kr7fOhkv7aVgxplWS10tcaQ/HNjABKrpA7xje6vhyaN2vOQlH+yCTqK5URoCnqJgI
	vFO5fq3ISumvHsyaQ0UacjiL8Zp3m/5HaHXp1ELSqz/IMsyblnm3o+UwGVAHR7JXHjSvjpk46vmxe
	aPrNXbfBSLdbINJqwlWdAeHmLeHqOLcNgGrodwxoHPLZwVXRhrdKXhrIm2L21ytrYR98HY9XVI8QF
	PZ2LJfUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nLllP-001MLI-UK; Sun, 20 Feb 2022 12:56:31 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nLllN-001MKV-UX
 for linux-nvme@lists.infradead.org; Sun, 20 Feb 2022 12:56:31 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 az26-20020a05600c601a00b0037c078db59cso9511726wmb.4
 for <linux-nvme@lists.infradead.org>; Sun, 20 Feb 2022 04:56:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=e/Abmyu2LYrtWrbT9swdc1mujJPrnTmHdLRBCu31e6s=;
 b=hjf+9XvCKi2ROM/E+8mb+r9yuCzwQOvaP4RaZbFPdMBQImD1idu4X9eCd7Xfh58CeS
 tqPvTed3SuBAFxtP/w6wvW7vhcnJvjSty9r/y8c3dsvCCfwJq3cCg8KRki+g/mh5Qa49
 WlonmPFtmfvDKRTkolSpnwRhP6P9F4IMGFfO+omEJKaD5LS7F3LBbRSjpzLdvrCPXdrZ
 d++oQPzYQWJ5HwCkaG+0HZNfcHQO4QGcNVNx9D4l+o//gogUT0GCrNLn6aXv3Q+ZkFID
 d4DXwgoVa81wHYusG3p38h9fM3efT8d2P9x9F5N2/ZBeixKC8oabyI24kPoo110EYMTu
 ONug==
X-Gm-Message-State: AOAM531SHRxO/wSREuYhZxn6fm4vq1IPFPNGei4/71zuYDuggnZFhGv0
 aj1nLkbe1xQ9pEzCOIgudI8dH45rNbg=
X-Google-Smtp-Source: ABdhPJybD4q79WnPivVJ1xZepoiKTOJqqXA65+uRi11xMmAcHlW7Bbjy+8jaBNlHWyH+2cg1Ne7TzQ==
X-Received: by 2002:a1c:4b09:0:b0:37c:522:c736 with SMTP id
 y9-20020a1c4b09000000b0037c0522c736mr14317151wma.145.1645361788433; 
 Sun, 20 Feb 2022 04:56:28 -0800 (PST)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id p16sm4936056wmq.18.2022.02.20.04.56.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Feb 2022 04:56:27 -0800 (PST)
Message-ID: <ca894790-e4ed-76e8-1ce6-7b613bc0f5dc@grimberg.me>
Date: Sun, 20 Feb 2022 14:56:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [bug report] WARNING: possible circular locking dependency
 detected with blktests nvme-tcp nvme/013
Content-Language: en-US
To: Chris Leech <cleech@redhat.com>, Yi Zhang <yi.zhang@redhat.com>,
 linux-nvme@lists.infradead.org
References: <CAHj4cs9MDYLJ+q+2_GXUK9HxFizv2pxUryUR0toX974M040z7g@mail.gmail.com>
 <71d184e9-503a-1dea-2881-c38f59849209@grimberg.me>
 <e6062357-beb7-7150-1e88-1109babcb86a@redhat.com>
 <03b33f30-aff7-84e4-8415-782d204177fe@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <03b33f30-aff7-84e4-8415-782d204177fe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220220_045630_022430_661FF9E0 
X-CRM114-Status: GOOD (  10.62  )
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


>> Also, I might have a sleeping function called in atomic context report
>> with a similar enough call trace to take a closer look at the direct send.
> 
> That looks to be a backport run with device mapper multipath, and a
> repeat of the dm-rq BLK_MQ_F_BLOCKING discussion on linux-block.
> 
> I currently don't see a reason why the lockdep annotation wouldn't be
> enough for this.  I'll send a real patch if that's the way we want to go.

Hey Chris,

Are you sending a patch for this? You can add my review tag when you do.

