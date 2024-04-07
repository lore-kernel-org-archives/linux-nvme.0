Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5FCCD128A
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Apr 2024 21:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=gpcZPENADvS7ARjoS/h74ExVV+
	aeRB4JPj9J4hz++APkbmL7Ode3Z+DBXX0C0tyQQ2wCwJSXEWMvDbPuf+0my9gOC1b8/vRhwGWtWHW
	KBPozWWvMuw0aZdUz3AWRiTS3rz1jf5mgANLGd/yWZDdW3VupGpHXUAdbMgnN5wcWmJfTdTX/3ka2
	XZuW4Wln0ThgTDz0I6wFU3eIbEXBNxvEVekMBacRRAwQ9QCt+gH7nBSvANLhdWW+ZLcT1vS7Bnnw+
	UiqIKQtUod5aPDK2sNRJgS6m6k0agy/7vpEqEZm+9FXoBC4uK/GTBlN3RwwLvUDtXNVINRN8t11QK
	CDug/17Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtaSR-0000000Daf6-3ZBC;
	Sun, 07 Apr 2024 21:53:47 +0000
Received: from mail-oi1-f171.google.com ([209.85.167.171])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtaSO-0000000DadT-30wS
	for linux-nvme@lists.infradead.org;
	Sun, 07 Apr 2024 21:53:45 +0000
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c5f468a2faso186298b6e.1
        for <linux-nvme@lists.infradead.org>; Sun, 07 Apr 2024 14:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712526812; x=1713131612;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=WxgsAT+4lDViE7mf3lyUS706vnV4vM5+qyOdjJzLhObgBGNH8beSYu+01yzNgXjkg6
         T1IrLlWIH9leyW4egIUy76LugzIwxXPkXKW5BcZNM1I1nNJdV77A+4CsFTC8o1xUdJc5
         TWjAlkNWAsgySoGnX3+nUg7ExV3q8EX4+U3C/oj5ZMf7KElB81hIwY1GPY7A3OSZ5UEF
         eRS3o5Uy0HWnh/AgLfDWlCwvgCaM4ePyNFbJ5FJHSGbAyCbLUSuKnkPk77yRfxo2+DCi
         8C1IDn7sxtxbk8MIekZJo/rg+WoO0uuy/8+NRUNnv5i3caB6LSbs1sSpGSP8Y0c91Igf
         z/ww==
X-Forwarded-Encrypted: i=1; AJvYcCW59u/Viv+1IHuBpF0O/bLFIuXUFlMVGsF7tADsGwGaD6fPlj/f+IyrSi5XkTReDjhI8Zghgey3YRFNATfGNgy/2bBKNKUgXYLYqmavFMk=
X-Gm-Message-State: AOJu0YwYhkXo9wn2pm3PuA9EApuL57Oz3rHW89CXAcnAw6pKEhfTBuIO
	5wTcN96CH/49uPFwWs6j6RKPZmhZpyaimPZHinLeoeL4gD/UvIFkTbmIcKgO
X-Google-Smtp-Source: AGHT+IEaopc19qvMtP8rkXyUI7wBDTyWjQ7ZDPIepqZOhIS3Fn1fDLLksT3Ci6XPmQWwRNKreAVhig==
X-Received: by 2002:a05:6870:6120:b0:22e:c52e:e7a1 with SMTP id s32-20020a056870612000b0022ec52ee7a1mr8135149oae.1.1712526812343;
        Sun, 07 Apr 2024 14:53:32 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id bs21-20020a056638451500b0047ec6162f25sm2072480jab.38.2024.04.07.14.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 14:53:31 -0700 (PDT)
Message-ID: <a0b524cf-c4d5-4ff4-813b-3c84643c9142@grimberg.me>
Date: Mon, 8 Apr 2024 00:53:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/17] nvme-target: do not check authentication status for
 admin commands twice
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240318150316.138501-1-hare@kernel.org>
 <20240318150316.138501-16-hare@kernel.org>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240318150316.138501-16-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_145344_788443_6E107F0B 
X-CRM114-Status: UNSURE (   4.97  )
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

