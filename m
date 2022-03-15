Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC096C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 08:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WjT/xBU7Jfr905EpqGcI41n9yUBAmerdU0vll5TSzS8=; b=3tP3sPp5adG5k319Mc1XlSYC8t
	A2MGT3v58o6zlHwJei9Rbk4Z1PkMko6jeeol+KqqRuaKpzxBLGxFQuHT9/PQLa9rCyd4nH+bgWB/d
	I5cBV3EX7xRbDYC3sdRMaO3xE762Zyk7P/PLg9Lk0wBHmQiTygIBu46Wkl9bj8YVCjNO3ygYp5afH
	u8Lq5NMcekcFS+3hlBr6VbxY1hGYxbCrSNVCQYdc32010EynIwqMTyo4R2SHWXvDYqKQFg6H8fZ1S
	35PFrW7b1VsXZVc8rVhUUnb6VuMz8juGp9abOxFS293qWYBCnqPe9JCfhQhGzlnVCsN87tLUhyjwG
	0OGsHEvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU2x1-008N9g-S1; Tue, 15 Mar 2022 08:54:43 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU2wy-008N8D-5V
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 08:54:41 +0000
Received: by mail-wr1-f48.google.com with SMTP id u10so27847434wra.9
 for <linux-nvme@lists.infradead.org>; Tue, 15 Mar 2022 01:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=WjT/xBU7Jfr905EpqGcI41n9yUBAmerdU0vll5TSzS8=;
 b=ADEV+Hx3TmS3QYO90J9ezzTUj09+LaPX8GqTgBcEXnd1mcaPDmyVuFBm7+RZy3Dnyz
 xECX0Ee0mQSkgTPC3JAwWxZqqNSwmmvRDnqomFFjbXzRSRSsZGp8BHe6ZBLFCtJ9ls/x
 iPAT7PhJ3O+65qV8FTh9ZLQ/eL+8o1jLT8i9cTxc/tX6N0qg80cmQNbohL7sOClHMx3e
 Q/BKCxJS7ZCKOgIfeVvjybHn3qp0shGz/VoG7nxJGuNUJFdNUScT0mPKhgVaQTI9mDTr
 yGzaG6wvHzA37Ui46M2op9H7OaEmXFilBhHnCk21XV/0D9XhYPQzkyR1UWnVN+dGYh2A
 YUDA==
X-Gm-Message-State: AOAM530TmhoA8C0awc8CCMXkXVIJFtH2znpyjqgxT3QpFgMmoIjY9U+G
 14KhMY1t8HREY/HCCYF6LtA=
X-Google-Smtp-Source: ABdhPJwQCW3S9eLVWohbpnF8eE4wiMojBQmCJs6SOjxhI7Rlta5L3+ZsqTKJ0wyYSNRTKsAozmZPNQ==
X-Received: by 2002:a5d:4892:0:b0:1ed:beaa:778a with SMTP id
 g18-20020a5d4892000000b001edbeaa778amr19040043wrq.35.1647334478252; 
 Tue, 15 Mar 2022 01:54:38 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 m3-20020a5d6243000000b001e33760776fsm15139021wrv.10.2022.03.15.01.54.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Mar 2022 01:54:37 -0700 (PDT)
Message-ID: <af6cdc21-761a-fa4d-a45c-a0eb6cc1efab@grimberg.me>
Date: Tue, 15 Mar 2022 10:54:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] driver/nvme/host: Support duplicated nsid for the
 private ns
Content-Language: en-US
To: "hch@lst.de" <hch@lst.de>
Cc: Sungup Moon <sungup.moon@samsung.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20220314110545epcms2p4a227eac7c4652445050e70ee2350635d@epcms2p4>
 <20220314110545epcms2p4a227eac7c4652445050e70ee2350635d@epcms2p4>
 <20220315071230.GA2069@lst.de> <20220315071926.GA2137@lst.de>
 <a3051d85-c08e-a273-c7cc-2eb3e21df717@grimberg.me>
 <20220315084035.GA3834@lst.de>
 <6ac83f8b-01e6-5394-0570-023ac6b1a71d@grimberg.me>
 <20220315084611.GA3961@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220315084611.GA3961@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_015440_252314_F1E0095C 
X-CRM114-Status: UNSURE (   8.57  )
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


> Well, it can't change to shared as the nsids are non-unique.  If we
> want to be paranoid we could add a sanity check for that, but then
> again there are a bunch of other things where we could be more paranoid.

*** paranoid person looking over his shoulder meme ***

