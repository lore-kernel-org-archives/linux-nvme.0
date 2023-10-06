Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CE3E81E1B
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Oct 2023 17:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UEjTiQOqZq/tiyoM37CeUZKubVviy0Hfhp5dRvbPE0c=; b=CR7LtXkk3yZQWMEP1gLO755DvL
	faiGjJZbXKdRNUHrlp8ykYKhfreQqURJ52rA2Vaon9zvt2YtS0IxVTj5PdgZTAKz3hfpNha6ASpSs
	oVuh8A+sRkGv5gCzNFQm6NBymL2Yv/OCtIntEhLSCFB/mcdeIO95jaUAOpwK+bV2U2XdUEHwxQaQH
	NHqdUD1qJlvzcgzuRZ9fZ28Mj6nk4V6eLLXxVkoxUOW777Y3SiIw0QPdloGZ2JmcYiDsbY40OYa9t
	oszovtguerEs6B28mR3oCAm5lL13Rih3ibKSCZoBcrERW9ldK5goQzhmVYL1yznw0EQ/aMVYDeYDY
	kx0VHdOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qooWm-006FDV-2t;
	Fri, 06 Oct 2023 17:22:16 +0000
Received: from mail-pf1-f181.google.com ([209.85.210.181])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qooWk-006FBm-01
	for linux-nvme@lists.infradead.org;
	Fri, 06 Oct 2023 17:22:15 +0000
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6910ea9cca1so2024840b3a.1
        for <linux-nvme@lists.infradead.org>; Fri, 06 Oct 2023 10:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696612932; x=1697217732;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UEjTiQOqZq/tiyoM37CeUZKubVviy0Hfhp5dRvbPE0c=;
        b=mPxabFWiN1SriW/Udojz+na2PVoew7qir0tD1L01G52JWeNOmp4yjudfpI7Sg126am
         Iwtg3UNKwRU8zVIScqfcoW+5MrwXOQ8a8l+55QVDs9y7P4A82R4g9laLEf1O/CmOEm2J
         hZtJefOt8m3ACmamZNb/z1iXYWGJlNshzxNxHE8hPeN0JY8ohEboxFsRpiACyaK8PyuZ
         tYWzygb/sD8ItS1844DvrdDE84/TjCnKzLu1vtSrWiX/xqeWxvwjcvwvDebeSK9Gbj/2
         7Tz/bJ9Wc6cFfZIpNAW2E8WPGgdv86bTVE4Qm/oCNCeruJ3wu7o68YizyLfcT0bYVTu9
         Ja0Q==
X-Gm-Message-State: AOJu0Ywcf55PUmAis9kuokT28kVLMh5Si7RgK4cmLhZ0L4EcUkLz5ymX
	hwWdTMm7DGOyU5bZPsh6VcI=
X-Google-Smtp-Source: AGHT+IERDatMvRwiT/bQ534S3NzSEl+A3niSuO3D+OTniQoBISPNSqc1StabEZo+erszyh/gqRzPcg==
X-Received: by 2002:a05:6a20:12d6:b0:153:4ea6:d127 with SMTP id v22-20020a056a2012d600b001534ea6d127mr10425406pzg.18.1696612931891;
        Fri, 06 Oct 2023 10:22:11 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ebdb:ae30:148c:2f33? ([2620:15c:211:201:ebdb:ae30:148c:2f33])
        by smtp.gmail.com with ESMTPSA id q17-20020a62e111000000b0069327d0b491sm1719291pfh.195.2023.10.06.10.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 10:22:10 -0700 (PDT)
Message-ID: <2bb2a4d0-4f1f-45f1-9196-f5d0d8ee1878@acm.org>
Date: Fri, 6 Oct 2023 10:22:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/21] block: Add fops atomic write support
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com, djwong@kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, chandan.babu@oracle.com,
 dchinner@redhat.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, tytso@mit.edu,
 jbongio@google.com, linux-api@vger.kernel.org
References: <5d26fa3b-ec34-bc39-ecfe-4616a04977ca@oracle.com>
 <b7a6f380-c6fa-45e0-b727-ba804c6684e4@acm.org>
 <yq1lecktuoo.fsf@ca-mkp.ca.oracle.com>
 <db6a950b-1308-4ca1-9f75-6275118bdcf5@acm.org>
 <yq1h6n7rume.fsf@ca-mkp.ca.oracle.com>
 <34c08488-a288-45f9-a28f-a514a408541d@acm.org>
 <yq1ttr6qoqp.fsf@ca-mkp.ca.oracle.com>
 <a2077ddf-9a8f-4101-aeb9-605d6dee3c6e@acm.org>
 <ZR86Z1OcO52a4BtH@dread.disaster.area>
 <d976868a-d32c-43d1-b5da-ebbc4c8de468@acm.org>
 <ZR+NiYIuKzEilkW3@dread.disaster.area>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZR+NiYIuKzEilkW3@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231006_102214_041456_4E0170A5 
X-CRM114-Status: GOOD (  13.01  )
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

On 10/5/23 21:31, Dave Chinner wrote:
> Then I don't see what your concern is.
> 
> Single sector writes are guaranteed atomic and have been for as long 
> as I've worked in this game. OTOH, multi-sector writes are not 
> guaranteed to be atomic - they can get torn on sector boundaries, but
> the individual sectors within that write are guaranteed to be 
> all-or-nothing.
> 
> Any hardware device that does not guarantee single sector write 
> atomicity (i.e. tears in the middle of a sector) is, by definition, 
> broken. And we all know that broken hardware means nothing in the 
> storage stack works as it should, so I just don't see what point you 
> are trying to make...

Do you agree that the above implies that it is not useful in patch 01/21
of this series to track atomic_write_unit_min_bytes in the block layer
nor to export this information to user space? The above implies that
this parameter will always be equal to the logical block size. Writes to
a single physical block happen atomically. If there are multiple logical
blocks per physical block, the block device must serialize 
read/modify/write cycles internally.

Thanks,

Bart.

