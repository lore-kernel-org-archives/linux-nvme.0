Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298ECC54EE9
	for <linux-nvme@archiver.kernel.org>; Sun, 18 Sep 2022 14:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bZnMUV6EF7Jbt2PC9BgNu63JVRVPMLc0poDkd2j39CE=; b=SFzH9p9NPGvPOSYGWVSGDnESc1
	J0o4D01W3WrzauMSxVn2dmqIV9ddYgVUZDhfCx0Ymi5imqflAKMuU8v8OH/IfcY8VgkpcvfdrMyFD
	fFr18zlTv82+qCUt2kVw60GLXPaBdW1eCCG2ZkfKmF2sI5B8TetH/YOueaa8ThUHwHspJWAs4Hi7O
	nHFHAE9sJfLKSK03muIKo8pm3vvFZ74YMkVRJ+q7fb64o+5usDBjpkYUkQN7ODk17Nu8JhepSbr3L
	5tBw93Eya21gFmD3eWzOM82SsNNiaOqYysTJNp9QKatX3KW0m8lJhmcsR1TDQQo/6Z1Xr9Dn5UkyX
	bkk1+7ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oZv2V-00GtQa-FF; Sun, 18 Sep 2022 14:12:55 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oZv2R-00GtLY-Jh
	for linux-nvme@lists.infradead.org; Sun, 18 Sep 2022 14:12:53 +0000
Received: by mail-wr1-f42.google.com with SMTP id n10so12666002wrw.12
        for <linux-nvme@lists.infradead.org>; Sun, 18 Sep 2022 07:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=bZnMUV6EF7Jbt2PC9BgNu63JVRVPMLc0poDkd2j39CE=;
        b=fGtlQu0tDmd7gi8IDl6KGc3uXcv+e/QMW/KpwwwFHIhnAbW1KLjzkVs0znQYeMmgzj
         C0PNdkqSRP0bOEsAi7WkkfjcCt23dF8MtSw+M0AZxMildoZ/XPmbAGrBOo0Zd3brofbM
         YOyA8oqTnMwzj8L3Dkn9whzO1iN8j6r8PAz4ajF1T87HuwIPcUpJhaeNiNrW+c55HBD8
         SHM5Ft3c+9IVCB0HgEqf+7jW1AaiiDMyfGeIAVEeKkfY6H9BevMX0ga8JHcvrj99vd2p
         MmEYvzNuvnubFhKVTkk3tyRtTgYML6uk8aFiqWRZxUFwhtzqi+P6rsXtWekQsu1g9lhu
         4Pow==
X-Gm-Message-State: ACrzQf0865p81YLGJoojXgmiIpvD540lYh57C7oenJoYr/2wkCzHRNEH
	flSR37rAOBzKl04WjKODRms=
X-Google-Smtp-Source: AMsMyM6cHQj8Quyp5bi0CPt6kmBw3oQOHpgv5KiFE1YxXjYUUtsSqIt5J1eofsjbXRuTVtJKlaqsiQ==
X-Received: by 2002:a5d:6852:0:b0:228:c94b:a5b0 with SMTP id o18-20020a5d6852000000b00228c94ba5b0mr7822721wrw.540.1663510368855;
        Sun, 18 Sep 2022 07:12:48 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c2-20020a1c3502000000b003b4935f04a4sm11846820wma.5.2022.09.18.07.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 07:12:47 -0700 (PDT)
Message-ID: <6d1ac60b-a4f3-5886-8653-35c66900f7e8@grimberg.me>
Date: Sun, 18 Sep 2022 17:12:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH rfc 0/1] Fix missing AENs when discovery controllers are
 disconnected
Content-Language: en-US
To: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Martin Belanger <nitram_67@hotmail.com>, Hannes Reinecke <hare@suse.de>
References: <20220907142411.101950-1-sagi@grimberg.me>
 <9eb798de-149d-a56d-ac00-dd6b7ae79a81@gmail.com>
 <403e19c8-fec9-2d5c-157c-cdcb4fc2fbf0@grimberg.me>
 <27194422-3759-928e-c88e-c5d10feeba5b@gmail.com>
 <bf83b747-e6b5-57fb-0de7-e2fb646633aa@grimberg.me>
 <73b6631a-1ec5-5a46-8f2a-f816acdeb97d@gmail.com>
 <0d34d7e9-b5e1-149c-aefd-aa3bf182ad94@grimberg.me>
 <917848e1-5650-bf1e-7dce-3a994c453c38@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <917848e1-5650-bf1e-7dce-3a994c453c38@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220918_071251_663172_2AE9E103 
X-CRM114-Status: GOOD (  13.33  )
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


>> The fact that the event is called rediscover semantically means that
>> this is the discovery controller. It would be weird coming on any other
>> controller, even if userspace happened to ask for it. If at all, I'd
>> prefer to fail the parameter for controllers that are not discovery
>> controller, which is strict, but at least not resulting in a weird
>> event...
> 
> yeah... I guess I fell into is "rediscover" because the controller was 
> "rediscovered" on the link ?   vs "please rediscover on a discovery 
> controller"
> 
> either way - based on other people's input is fine with me.

Didn't hear from anyone, guess it doesn't really matter.
I'll lose the user parameter, make the event fire for
any discovery controller that reconnects.

