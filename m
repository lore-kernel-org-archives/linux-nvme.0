Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1476BC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 19:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2Hk3B55ZqkeAB3AADrQYItrSmT5x8nVHCaq2sovky6w=; b=D9B7jupQ2p0A72jpq0T3F9eSe7
	zPkB+gSQxM7IoPOYGEf4zCTCPGlMpmO8FNTnjUKTYCHCcV7q/Z9VGrGO0CcvRBgdNoq3OQsHAmgb1
	IRVlJhnsccTJxU5t5ka3OIt3xJvB/3YXni1B1enJ1yAKPW3eyr5jdfRg2YC3OAt8hqoRgsdQAaMnx
	2eXr2HkkWm/2T+TlKY3r4gcgP0gZrnehpkiD4ZgIpXdaGxwFRUfOGC+M9rDwymahxDE8Utnhxqd1g
	HZs6+K2a6pAftT3J4gDseI2mpa8zdYhPtDsq+/NgzubNL/pXkmEze+v90u02fB78N53tiq7mNlCwm
	KIFiHtZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTqnO-006fWZ-5B; Mon, 14 Mar 2022 19:55:58 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTqnK-006fV2-V6
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 19:55:56 +0000
Received: by mail-wr1-x434.google.com with SMTP id p9so25730907wra.12
 for <linux-nvme@lists.infradead.org>; Mon, 14 Mar 2022 12:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=2Hk3B55ZqkeAB3AADrQYItrSmT5x8nVHCaq2sovky6w=;
 b=oqHAJyqH40KbnVUZYh8YWeQz2EHXN0lf9GsjikkHW0/PdLytLdNUbbiNmdaItLokoA
 iI9aXSLoO0EC3N8pYtgX9abm20lSDhFItHZo4FUBzezeNlUo+Day+DTQRrMI2Zb58r/4
 vNhV4dDfL3k4Y0tX9PZMYJiNocWIl9X7yjfafiefA4pEQaIaq0b0ZRfOh+dOIKKAWGgR
 drWVFzSukmhwDqsMtn5JhbY3HbL6hCeItNJW6W55VLXb/D8Py++wdR/whcpY9Z3BZk/+
 3ZH9IFCiD1BSyerxNntVE3yryw6fBAS2y4ygkPHB7bqw6tHFBGLevYCsV9I/aBsBaBwV
 wwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=2Hk3B55ZqkeAB3AADrQYItrSmT5x8nVHCaq2sovky6w=;
 b=jhWXPNV/9R2CysOGeM6rpMc21J5tNOTUeUGJTw8Z9zS1aQz5UZOU6aE7KUmz1YJgTI
 43KYorySdJpo9R2EOVYaCdNN2L84WZgiH0wr/3RZz3ySJSJTP0yAKmN16PF4/lbBQODu
 zU2wz27RZ4zaE15DBr+/19cPmlSxXVGUArAHzYQ95Ll3iXEQN4T6ENJbJ3qdOoEhOJ0q
 PgZqQ5imQ/eHAYPhiroSxBJzXCQMRo8EMM8ICuLi+b/6PgMdnQuSrCFDZEkWEA93NLmV
 mmQ/s+Kl1mR8PTF13xdw1HkBkZ6j0JW3cTu/YzS3UnUM88bNexp0BbhKudm4k/GUIPpl
 oo+w==
X-Gm-Message-State: AOAM532v+uCro4wAYiwNP2CRIozjzo3cVitNxhpLeJ60Ol3xd17vE0yv
 1Q4tXRT+qhBQx69/JmQrD15Q5w==
X-Google-Smtp-Source: ABdhPJw/dNd3SM6HQqoRh/j2Cu426pE5a5vSXgfYJsX3tJtfqwKBUg1b/9Wa6kRaNBQKA2hWYgdnVQ==
X-Received: by 2002:adf:e746:0:b0:1ef:8476:dab3 with SMTP id
 c6-20020adfe746000000b001ef8476dab3mr18077872wrn.449.1647287752873; 
 Mon, 14 Mar 2022 12:55:52 -0700 (PDT)
Received: from localhost (5.186.121.195.cgn.fibianet.dk. [5.186.121.195])
 by smtp.gmail.com with ESMTPSA id
 10-20020adf808a000000b001edd413a952sm14072789wrl.95.2022.03.14.12.55.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Mar 2022 12:55:52 -0700 (PDT)
Date: Mon, 14 Mar 2022 20:55:51 +0100
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
Message-ID: <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
References: <Yiuu2h38owO9ioIW@bombadil.infradead.org>
 <20220311205135.GA413653@dhcp-10-100-145-180.wdc.com>
 <Yiu5YzxU/PjxLiUL@bombadil.infradead.org>
 <20220311213102.GA2309@dhcp-10-100-145-180.wdc.com>
 <YivMBj7+j/EZcMVV@bombadil.infradead.org>
 <bc0e53a9-f623-c69f-002e-d62e697a43d1@opensource.wdc.com>
 <20220314073537.GA4204@lst.de>
 <05a1fde2-12bd-1059-6177-2291307dbd8d@opensource.wdc.com>
 <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
 <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_125555_105701_D9835303 
X-CRM114-Status: GOOD (  22.22  )
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

On 14.03.2022 14:16, Matias Bjørling wrote:
>> >> Agreed. Supporting non-power of two sizes in the block layer is
>> >> fairly easy as shown by some of the patches seens in this series.
>> >> Supporting them properly in the whole ecosystem is not trivial and
>> >> will create a long-term burden.  We could do that, but we'd rather
>> >> have a really good reason for it, and right now I don't see that.
>>
>> I think that Bo's use-case is an example of a major upstream Linux host that is
>> struggling with unmmapped LBAs. Can we focus on this use-case and the parts
>> that we are missing to support Bytedance?
>
>Any application that uses zoned storage devices would have to manage
>unmapped LBAs due to the potential of zones being/becoming offline (no
>reads/writes allowed). Eliminating the difference between zone cap and
>zone size will not remove this requirement, and holes will continue to
>exist. Furthermore, writing to LBAs across zones is not allowed by the
>specification and must also be managed.
>
>Given the above, applications have to be conscious of zones in general and work within their boundaries. I don't understand how applications can work without having per-zone knowledge. An application would have to know about zones and their writeable capacity. To decide where and how data is written, an application must manage writing across zones, specific offline zones, and (currently) its writeable capacity. I.e., knowledge about zones and holes is required for writing to zoned devices and isn't eliminated by removing the PO2 zone size requirement.

Supporting offlines zones is optional in the ZNS spec? We are not
considering supporting this in the host. This will be handled by the
device for exactly maintaining the SW stack simpler.
>
>For years, the PO2 requirement has been known in the Linux community and by the ZNS SSD vendors. Some SSD implementors have chosen not to support PO2 zone sizes, which is a perfectly valid decision. But its implementors knowingly did that while knowing that the Linux kernel didn't support it.
>
>I want to turn the argument around to see it from the kernel developer's point of view. They have communicated the PO2 requirement clearly, there's good precedence working with PO2 zone sizes, and at last, holes can't be avoided and are part of the overall design of zoned storage devices. So why should the kernel developer's take on the long-term maintenance burden of NPO2 zone sizes?

You have a good point, and that is the question we need to help answer.
As I see it, requirements evolve and the kernel changes with it as long
as there are active upstream users for it.

The main constraint for PO2 is removed in the block layer, we have Linux
hosts stating that unmapped LBAs are a problem, and we have HW
supporting size=capacity.

I would be happy to hear what else you would like to see for this to be
of use to the kernel community.


