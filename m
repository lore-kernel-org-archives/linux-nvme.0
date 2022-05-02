Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28785C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  2 May 2022 12:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Abxuc7AESfydZ1f5zQzxUG0nq76FAKyElBgmKIDs9LU=; b=A8Fm9/SQOr0ubNzDD6VB7Q7n5Q
	eCc8NItJpYMS7PMdRvzAYYzfv3tLSOtWjeWLy6BgW9ksajX4Q0butJIWFBfhazJHkoCA1WRPb+kPF
	e75iS+fI686eoxdxOCgDGBrwyadP+6dxkW7I7UC90q1wzttF7q19xfwUguvVpF7uWE+DiO1bILhyX
	GnRNfbM6ts0WCkwgsfT0ySMorHNWKWosQNLMl3dVDzbQ3R5wDOsKu3+/M7DvzO6+WzhW7BPiwVHm5
	4ufN/0F7+SYnhXa/zkPo9U5lTAjeiA63e3OYvcCzuDFcQb+9qEcb684Rheur/1+LdMNtpGg4ofn6V
	62HKKhnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nlUww-0015CJ-LA; Mon, 02 May 2022 12:14:46 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nlUwp-0015BD-Sj
 for linux-nvme@lists.infradead.org; Mon, 02 May 2022 12:14:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1651493678; x=1683029678;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=upcjxMBu+P7WwqT0zp8eXVNlC+8I1RqcfjsnBpDAUsk=;
 b=XUjugT7GvT4GHKWM04O5wXMZw8cU22iMd0sDTE+9tkIUY4JDRONghRug
 0Vomal8cH4zWgrWZ4ym3478/Xv81UclMchklxYASXM8I/3CcaG5r25zQG
 YsfUOJB8wnDtm1n/0Slejde5rXcP9Prz0EEmkbJr942Ei9GHUjaR0wpsb
 IxxuPXtYeeznGgtwMdZyD0jt1Bhz4VQkSaT1FWxvEG4GTjwydkj2obECB
 mShLyzM6uTP4xDIUJIhK9mNbEXI4b38mhBOQu/oMJbWVpa55VUky+0Xko
 4imM7u+wjrnSy8LyKbOtCtvgv3jNFthESvCu6lzlXciVB5Eyzdop4Y2D4 Q==;
X-IronPort-AV: E=Sophos;i="5.91,190,1647273600"; d="scan'208";a="303545439"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 02 May 2022 20:14:35 +0800
IronPort-SDR: JMYZAkdaTkrEe7GEyvkf6NagtLLQyl3bGMsYrmkslHoOYsoR9V0cVQxEnLT+/DGPolCRAeLFN+
 iUrcEZQnx4sKwyvCBI8mY2NQGsxlP/HNxabtQY/fLii8u654EZvzvKFDd8sbTFS6OyvF0EctUa
 Qsy2zUgkvP8yPMZYddldRLO7pUaKSJFn0vF/8+fPnemKyoVfNfQs93fGeCQYlvE5SuINyXWXo1
 oljrt+ha+Yww1xdyy3denkhN2mNTN8n94jKCTlgNq9LkCSJX3M3+VU/6Ei/sjnDmk8kkdRP6GJ
 7lzNRaZsRhkMLYRRbhP2szUw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 02 May 2022 04:45:21 -0700
IronPort-SDR: jlMok1665Kaa/gutQtGxTHdEIQCD5coAL07LUTcP/7rwTaHYAHstaYKpvJb90rVe2VEkT273uP
 Dhab97vZjIj/GCvGxSd17hPp9AyhTj7iAsRyTk0lLdWKLp5ILvOGGWt4c2653SkdhEl2rfXdBf
 o68KMjT6X8TCxIsUIGIsoRNM6uXpU5OFlCyko4aYjtRQmr7K1ZOXSoA4CruwnhhhIHVP2taLHH
 o+bcFt8GSRAaqbwWZFqg5Li3nh6DAmxMTuPwv5ZkugY/K2gueJriBBQHtycV3dFjugkKe8JhkW
 TyM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 02 May 2022 05:14:38 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KsMTm5dVjz1SVnx
 for <linux-nvme@lists.infradead.org>; Mon,  2 May 2022 05:14:36 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1651493676; x=1654085677; bh=upcjxMBu+P7WwqT0zp8eXVNlC+8I1Rqcfjs
 nBpDAUsk=; b=ciG1pDAWwoPGHqJ1HX4eF9v2xlPWggbWDb1uKGSNO/jkj8TEDpa
 ILi9HAbkAFNq5EiDhdSuVQosgo82rHtnp1u+5RraiVW1JKJnulP6lgEwewflYcZn
 SLU2nqSrCmvaBlOlhq/SwUz0aYIxD59HoZfzPFAJDB0k2U9prTJ30nuAfheIJUi6
 cxSGNnQB+pIT+qHg0gj218RXQsNIz7HUN6KLbDp7SK40cYGKfLGC+QPoZ1ef02fi
 CGm1HBmySTkuifTYQNn+nm3D/0IlH3vsNc4RSAOlTiP0Ce5dxFXvF9P5lhzKnytM
 U2jRb8KhbGXd9hS/QVpsB1BuBNTzztKOoGA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id U8fo34Fro9wm for <linux-nvme@lists.infradead.org>;
 Mon,  2 May 2022 05:14:36 -0700 (PDT)
Received: from [10.225.81.200] (hq6rw33.ad.shared [10.225.81.200])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KsMTl4knDz1Rvlc;
 Mon,  2 May 2022 05:14:35 -0700 (PDT)
Message-ID: <260b95e8-74bf-9460-cf0d-7e3df1b1a3c7@opensource.wdc.com>
Date: Mon, 2 May 2022 21:14:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [dm-devel] [PATCH v4 00/10] Add Copy offload support
Content-Language: en-US
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: linux-scsi@vger.kernel.org, nitheshshetty@gmail.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 linux-fsdevel@vger.kernel.org
References: <CGME20220426101804epcas5p4a0a325d3ce89e868e4924bbdeeba6d15@epcas5p4.samsung.com>
 <20220426101241.30100-1-nj.shetty@samsung.com>
 <6a85e8c8-d9d1-f192-f10d-09052703c99a@opensource.wdc.com>
 <20220427124951.GA9558@test-zns>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220427124951.GA9558@test-zns>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220502_051440_169048_621E88E4 
X-CRM114-Status: GOOD (  14.48  )
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

On 2022/04/27 21:49, Nitesh Shetty wrote:
> O Wed, Apr 27, 2022 at 11:19:48AM +0900, Damien Le Moal wrote:
>> On 4/26/22 19:12, Nitesh Shetty wrote:
>>> The patch series covers the points discussed in November 2021 virtual=
 call
>>> [LSF/MM/BFP TOPIC] Storage: Copy Offload[0].
>>> We have covered the Initial agreed requirements in this patchset.
>>> Patchset borrows Mikulas's token based approach for 2 bdev
>>> implementation.
>>>
>>> Overall series supports =E2=80=93
>>>
>>> 1. Driver
>>> - NVMe Copy command (single NS), including support in nvme-target (fo=
r
>>>     block and file backend)
>>
>> It would also be nice to have copy offload emulation in null_blk for t=
esting.
>>
>=20
> We can plan this in next phase of copy support, once this series settle=
s down.

Why ? How do you expect people to test simply without null_blk ? Sutre, y=
ou said
QEMU can be used. But if copy offload is not upstream for QEMU either, th=
ere is
no easy way to test.

Adding that support to null_blk would not be hard at all.



--=20
Damien Le Moal
Western Digital Research

