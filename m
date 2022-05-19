Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D60C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 19 May 2022 03:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hA5pH6NCtP0ZExkybfeDZVvmS+o/csJi6otE7/dTecM=; b=div+myE5oIH4Lm6JqzxXrW9gvk
	5RWHYOaaZwK93DU66ge6MSBQxq8Ypvhk3zfPBye4pREoIy+x5uStJ0hfi3LDVpZ+4ilPWUiLk7Qea
	sF1OxQZMz7D5HLztm5OKQDPv1qc46O4qQu4mB6nATd+7G/Ak57T2zn2cK4566JCe/w5oesRFOmFAa
	ZCrrxDKk1NBAJ8fgu8kJJkgBe1cogDcuBaPsPPpHGwjblotIBCpr1bSeDZHCeFtc4yASpO1SVA0og
	6AcRlYca3WiqQjeSYpFoDodWJazFf+SKbbSD2+5NWGIExngHs0aW6cDqXe2BYTGNp46zV63+xbf4P
	Mn1N4VAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrWWk-004lY3-6O; Thu, 19 May 2022 03:08:38 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrWWg-004lX4-Ad
 for linux-nvme@lists.infradead.org; Thu, 19 May 2022 03:08:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1652929713; x=1684465713;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=iKzAFiDLKJhL5lFQX7s/O0b9OAzuVRAgCLJSBsvKlJE=;
 b=TL0K2fnuYvkbL2ct4iET4g0HNYu2ZHwXU9uLCcnoYv4a/k+QUPg6+FDE
 JEWLgL4BtPXlQXbwqWlbgII0a4WCFLOHaBubjBXl8tvvZHYGLdvkN6lUH
 zjG9lol1cg99WsVb+2oWGjQTipT4l0KjJfrjX42tW8g0e10ZqPPl2plSN
 EOq7j1v9SX8XlILpUTalTQXgc1aPLlmwbZBAf8dHEn3Zz1QuHbE62kLEL
 dj2PCFDonxsJdG59aOUH3sc2PT8PhZgg7oFImFdukI1D9DA5p/mXr8a03
 W2BsQEwnO1tgvnzYz9UxurISpRDM9F1R6SGS7zYINm46S96Jq/fxzPIq0 g==;
X-IronPort-AV: E=Sophos;i="5.91,236,1647273600"; d="scan'208";a="205612429"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 19 May 2022 11:08:31 +0800
IronPort-SDR: mJOx2fxDF0i19xTIHAnT8xpY80I/URQDcEUs+DI0rBNWK6/l45mn4c68EAAjVc6GtKJeSvPJ2M
 klHweffDYd3h7X1B3ttw4xVBDhd2zr50fKeL/HKMb5b3WP8ZXh8mCJJ3Dm5DYdWrKujEvq88GQ
 j7eRtYW41+H1G58f53BSsyIh+yKFbF8U9rojsgfggh1+dBDRpYxW/yEMKEwiZWqhti/eaR4d39
 32lItMJQ/cjm6smbcrqbpUwRC3MN+AbKHHIxwVGXgQyjx67LzMWBBvluODHmyBpCeEICEUr1Jb
 ahsvQdEYYREuwLMQpWJdSRIU
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 18 May 2022 19:34:02 -0700
IronPort-SDR: QHdirPzk55ZO2DzLgik9Cp2VpH6ZnmYpwe55b52YJbRBJr7DZ0kreUKHpD53fChZ5mpU+20bTq
 kmN/WCylWmSz57OyARjKO6hLDAg3NU5muj1iu/DtqxqMQF/ohl1dxOOhU2FzEh2rkOAE/ihp0v
 zCU4ioy3+Ao6VHr2UiKm6J9Y9j4u7MNeVBbfsVVB8JBD2giSgdtL8+UQ2cbF+pAU+yqgJpQWkC
 gKaCugKFYNez0BHXw2XHrPDAz/gKSsT7bYVnQHkVJ/mNprB/ZON8qS/H+3rKJxv3PWWd18XNww
 mWc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 18 May 2022 20:08:33 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L3ZYq4nj1z1SVny
 for <linux-nvme@lists.infradead.org>; Wed, 18 May 2022 20:08:31 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1652929710; x=1655521711; bh=iKzAFiDLKJhL5lFQX7s/O0b9OAzuVRAgCLJ
 SBsvKlJE=; b=Wz9R8/72j7o0/HjkO54/uNZ7vziwLqXBQOx2WZe1qEsSDBmqYAY
 oMOjpxPnGBnz+q+koTOKO3drn7FOj/jhxR0PTW1FJ7YLYdFtlYLeLGGN3yqvtwdr
 uts4LUP4ysOxN9iynlkWmhdkEs1tc1G3KNFA528x+jtAzYhfzX3F8jTjGnXp//sA
 rsE8C3oCVAzXP+CvDtHdo8BS4Oa1/JBePKnEcjfmBeFehBxoE9CWKq1Q/U6ExkMw
 hH5S6Kmi+EQY3sVzRRp11jv54IT+de7lJq7eYYN/WT35dSgh82O8SztxjP5NqAI5
 lf5E1L/acuF281Lj4heVeUrWlZG2K+SHppA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id HNGT7wcMeY4f for <linux-nvme@lists.infradead.org>;
 Wed, 18 May 2022 20:08:30 -0700 (PDT)
Received: from [10.225.163.43] (unknown [10.225.163.43])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L3ZYm2BJDz1Rvlc;
 Wed, 18 May 2022 20:08:28 -0700 (PDT)
Message-ID: <7f9cb19b-621b-75ea-7273-2d2769237851@opensource.wdc.com>
Date: Thu, 19 May 2022 12:08:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [dm-devel] [PATCH v4 00/13] support non power of 2 zoned devices
Content-Language: en-US
To: Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Cc: Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk,
 pankydev8@gmail.com, gost.dev@samsung.com, jiangbo.365@bytedance.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 dm-devel@redhat.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
References: <CGME20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef@eucas1p2.samsung.com>
 <20220516165416.171196-1-p.raghav@samsung.com>
 <20220517081048.GA13947@lst.de> <YoPAnj9ufkt5nh1G@mit.edu>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YoPAnj9ufkt5nh1G@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_200834_493028_995D3CC3 
X-CRM114-Status: GOOD (  15.87  )
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

On 5/18/22 00:34, Theodore Ts'o wrote:
> On Tue, May 17, 2022 at 10:10:48AM +0200, Christoph Hellwig wrote:
>> I'm a little surprised about all this activity.
>>
>> I though the conclusion at LSF/MM was that for Linux itself there
>> is very little benefit in supporting this scheme.  It will massively
>> fragment the supported based of devices and applications, while only
>> having the benefit of supporting some Samsung legacy devices.
> 
> FWIW,
> 
> That wasn't my impression from that LSF/MM session, but once the
> videos become available, folks can decide for themselves.

There was no real discussion about zone size constraint on the zone
storage BoF. Many discussions happened in the hallway track though.

-- 
Damien Le Moal
Western Digital Research

