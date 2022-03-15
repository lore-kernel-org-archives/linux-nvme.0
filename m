Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCA1C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 13:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BhTnxrKXxwIzOivMLyYyiocB380XwPrJVwK0V4KaKJ0=; b=bOxApafj5TwdThzl57THcnzxWZ
	xlEN7muXC+u54OofanGk4+P8rX1bTPAWEwlxuYiWmFlJHvOpfoTQlxNFbXseMMWls5TNIW0/WLBXS
	Lpbtyvlu269SkXs7OXuGXVF3byP7UoaPCqi+ZYkVONTAMigmJW+8rjtn7L6o4NW/oi8DoSorHKnD8
	uaOUY8f3WPpINhrYFQXCtIuepo7QeNJsiXZjursKgrynNQEubWjxTxBZtwts3QstSuo2OcfS/SMfr
	OHTLfJPv2DNCG+jfevIGPYuIyskxK+CtYUYGb0E1oObN7xCVFWgo1UwkoKIMu7UkjceANlec4isch
	i/gIcWBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU7Da-009C82-Lh; Tue, 15 Mar 2022 13:28:06 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU7Bo-009BOA-Ow
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 13:26:18 +0000
Received: by mail-wm1-x32c.google.com with SMTP id r133so585624wma.5
 for <linux-nvme@lists.infradead.org>; Tue, 15 Mar 2022 06:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=BhTnxrKXxwIzOivMLyYyiocB380XwPrJVwK0V4KaKJ0=;
 b=QV/gWOCYoWrMoBJcYfpBGe54prDHlxa+0euMtD4N2+cwzyMStwoQERhwvRiXCjNdou
 BDQNGEi2IpIJos2ESa8fc3KhrAt6SbnCgfJbJbBPFotcTTDAISxVz82TwImC9DoA28rO
 gUmWlVVTs1P0cS0k/gFxhT9DfcJPG3BJJd2+fnnkDJRdQs4rm+xdXEtSF/C5vdfVhuI9
 teLUItw3WbRqgY9GSo6eRfqyfsw1QW5FgdjC7OCbN6AjR3tbdSyOIdqlgrX9ta2KVuYD
 YXFJIYuarUGv4f321aqyB5sr0Cdsq3tA5WZrC++oYVVRv5d17vv10cCpG4uB200nRzGN
 wSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=BhTnxrKXxwIzOivMLyYyiocB380XwPrJVwK0V4KaKJ0=;
 b=Wg8PFxwaBujUd7dbA0efBz8dRWDQwY+BcxasFm3UKW5rIRWBAZcE0QblwxoyJ8ZDVS
 CpavUlZ9w4PmEGHI4GlPd/MGKnke3NFf1eDvLRRMdwcKAkRRyakAsWuk7Ys57PwTFIum
 fwpZjJx55nVk/3LiHe4tTTXJzuGDD015utkpwh7BfVgU3C2XjCZ+ty4yi1A6FvA765r3
 39sYOUsBdUz6VHZAq/3B+pWTuTRWIsSDMHTTS0RKMgP/kOxEHnN9ob17/W9mUrse6tX9
 F48izQ1tVshi4k1GVV1J2g7pgHrjGirxvD+I3lwYLhq+13CJSwIbU9nBkvCkxUq92IkR
 DhVw==
X-Gm-Message-State: AOAM532y1IAljjRjb+c2fT/TlreizdK+Gj9+n0OaWobQHYwjb7/7yCJ9
 Wt9k1IQTK432zDoQMgarFK3gJA==
X-Google-Smtp-Source: ABdhPJyLlpiR2j3yUnnI7OzHMusJ9BT0By1PChmGXclvdmPTMhcxI1XppgjAZoQTI6LfgCyQcP08fg==
X-Received: by 2002:a1c:4e15:0:b0:387:3661:e857 with SMTP id
 g21-20020a1c4e15000000b003873661e857mr3314789wmh.94.1647350772502; 
 Tue, 15 Mar 2022 06:26:12 -0700 (PDT)
Received: from localhost (5.186.121.195.cgn.fibianet.dk. [5.186.121.195])
 by smtp.gmail.com with ESMTPSA id
 j17-20020a05600c191100b00389a1a68b95sm4801873wmq.27.2022.03.15.06.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Mar 2022 06:26:11 -0700 (PDT)
Date: Tue, 15 Mar 2022 14:26:11 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Matias =?utf-8?B?QmrDuHJsaW5n?= <Matias.Bjorling@wdc.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Keith Busch <kbusch@kernel.org>, Pankaj Raghav <p.raghav@samsung.com>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
 kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, Pankaj Raghav <pankydev8@gmail.com>,
 Kanchan Joshi <joshiiitr@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <20220315132611.g5ert4tzuxgi7qd5@unifi>
References: <YivMBj7+j/EZcMVV@bombadil.infradead.org>
 <bc0e53a9-f623-c69f-002e-d62e697a43d1@opensource.wdc.com>
 <20220314073537.GA4204@lst.de>
 <05a1fde2-12bd-1059-6177-2291307dbd8d@opensource.wdc.com>
 <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
 <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
 <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
 <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_062616_859631_5A861E8A 
X-CRM114-Status: GOOD (  24.81  )
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

On 15.03.2022 13:14, Matias Bjørling wrote:
>> >
>> >All that said - if there are people willing to do the work and it doesn't have a
>> negative impact on performance, code quality, maintenance complexity, etc.
>> then there isn't anything saying support can't be added - but it does seem like
>> it’s a lot of work, for little overall benefits to applications and the host users.
>>
>> Exactly.
>>
>> Patches in the block layer are trivial. This is running in production loads without
>> issues. I have tried to highlight the benefits in previous benefits and I believe
>> you understand them.
>>
>> Support for ZoneFS seems easy too. We have an early POC for btrfs and it
>> seems it can be done. We sign up for these 2.
>>
>> As for F2FS and dm-zoned, I do not think these are targets at the moment. If
>> this is the path we follow, these will bail out at mkfs time.
>>
>> If we can agree on the above, I believe we can start with the code that enables
>> the existing customers and build support for butrfs and ZoneFS in the next few
>> months.
>>
>> What do you think?
>
>I would suggest to do it in a single shot, i.e., a single patchset, which enables all the internal users in the kernel (including f2fs and others). That way end-users do not have to worry about the difference of PO2/NPO2 zones and it'll help reduce the burden on long-term maintenance.

Thanks for the suggestion Matias. Happy to see that you are open to
support this. I understand why a patchseries fixing all is attracgive,
but we do not see a usage for ZNS in F2FS, as it is a mobile
file-system. As other interfaces arrive, this work will become natural.

ZoneFS and butrfs are good targets for ZNS and these we can do. I would
still do the work in phases to make sure we have enough early feedback
from the community.

Since this thread has been very active, I will wait some time for
Christoph and others to catch up before we start sending code.


