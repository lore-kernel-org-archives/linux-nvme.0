Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BAAC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Mar 2022 00:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0mNhWJ03+5kX0soNftPP8OL+xRQ2Y6En+2LMiYWzBOI=; b=OCpnRV/FfHaMxkPHXgPyeqL6yP
	jvgtz4n8zIIaahrm8TfQ/T7IKvo/RAwKb7a47gltH1+JYSaml4L4YE4teQpQnJONKQgSjjW9Zq4KZ
	1wxEpH1d7uab1ZqZ7crhH/P8bDWdO8I7vl85Y/GSCjbewOpEsgwdiAP5cfmq0N8CuqRgdquUj3GdS
	nO3FDRZRaOBZg/Ud/0656SoVcGzaFt8030k3CnYVlB0UBdCFUJSqnxEisrMFgqvOQNq2eYBbCWc5g
	SQzJsBZ97C+3di+3R4STuifoxnZ4U+DpbgOJqgPJv2nC14pF0GfY7jScmgYX/zePmu/aPnjbYqWy1
	/iueEhOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUHCJ-00Axzy-5x; Wed, 16 Mar 2022 00:07:27 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUHCG-00Axz8-3w
 for linux-nvme@lists.infradead.org; Wed, 16 Mar 2022 00:07:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1647389244; x=1678925244;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=0mNhWJ03+5kX0soNftPP8OL+xRQ2Y6En+2LMiYWzBOI=;
 b=LhmfaaB7hYXPelwn5o4aV9HVK6mmW/RuiWtCeWZ9Jf5+ECJUe3EvzXZu
 GtXYvHKD3PVX/LzwmOM7EgYbI81Yzoqp3u+KKcYgdYLLOEPXUTf8SW/6i
 er5fcUiS6IXr0RcKz4wonKqQ8J7Cx5Xq9Sgw0A8dtS8KQNZovVEXPfmXz
 j+9bCMiXAeLqBPG79uZbmsl9Y648XqLLzQQnyY3EeobRsDFb/NkkepC4J
 kH3vYbpZX0Rb81PT0lGMAoEoRp8+BixJ1MqMfVklJRnTGXe9ve0Y3tZUh
 BVKJ6JObZY/WavuDSFp9BW6AJL7MV9Y+AP0vzB1UND1nOyhoY48oe5ZPh A==;
X-IronPort-AV: E=Sophos;i="5.90,185,1643644800"; d="scan'208";a="307405109"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2022 08:07:23 +0800
IronPort-SDR: h6vedlgn6Qo5vxo/LOB0dBG5NZi0SiS5cujeWbNuEtCNUQolxt8FTGjBMXxPyYyqpfit0F8gue
 wPxp8wWghSY2PA2Qp7DUejk6f49FYnxtTq7fLh9ziiS/1Njhi4DsGrEPITs3mk46LNMBnTT6Rc
 noYa8LL8JLKV5+sTRMRm5MPituk0G++6mBPoQiycENkHwCaUd0iswIEWoz8b+mQWisVaOu8gfo
 KZry9r8iph2EK7j+aqoVO3MVVybSNaHCY1bN0b4favmW2tg14TH1QZDQT6wLziCHKr6QTUdIcK
 XowSbGu5ejat1P3d4zR4cw94
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2022 16:38:29 -0700
IronPort-SDR: PTOr5KImDab0He8Gi/p4LqlO1H2FoWsSRwyvVJJD7QyddYGNilfmofU8OQ6yVJ2b+mkWT5eJ6O
 JzcixK3LG6mlkernpeGmcd06LSL8hyI3HnVrjmOsDhiP/r3nHoDDcPDUFKTTstNPKpLl+q2/ry
 52HFgTXKnjtcL2SQ1wd9/B62EetiWozpsL1pb0cti2ExIyPSoKkuX45eCkhZlkgnPAoLH4LYD1
 yRsQDUUK7F98cYqRX/eZYN++2UFLpvrC1DwjPqLLPpVXZhYnrQ3cT+pMUrqXz+on/WbIf9gQjK
 /z4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2022 17:07:23 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KJ9ZL41Dmz1SVp3
 for <linux-nvme@lists.infradead.org>; Tue, 15 Mar 2022 17:07:22 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1647389241; x=1649981242; bh=0mNhWJ03+5kX0soNftPP8OL+xRQ2Y6En+2L
 MiYWzBOI=; b=Py1BK1uwMGFG1c+ASHnh1ASoLrJKvw64tZE6y5q+e74n1dN2WI2
 zG5QeFjCDf598CpPKNNrU8JafIbwn/iyQBnpAGwGOaaF7uHiLHaSBVTxC68jUXl0
 kF+bclLgOHNCPo8G7NMuLZZdUbkZrgOwSpK6RLYH0Q4bVMInNsnvFyju6seKm3wm
 A8E7+orASHSQm5Vwa87H8yT9rIRQ4hKeTMeuP62RHCouLNFqV3NJ5qhcvE3YLNWf
 WWAPsJamThG8P5Og8CAJJ5DzD/zzgEF0lZS+j6j4NolJ4nyVZXIE9D2jy1Z16mNU
 iv488Cd8DPN8mLbhk4f8JAgzH4KsatfvV+g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id NmTS5KXB7q2S for <linux-nvme@lists.infradead.org>;
 Tue, 15 Mar 2022 17:07:21 -0700 (PDT)
Received: from [10.225.163.101] (unknown [10.225.163.101])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KJ9ZH2xf2z1Rvlx;
 Tue, 15 Mar 2022 17:07:19 -0700 (PDT)
Message-ID: <62ed2891-f4b2-d63c-553d-8cae49b586bc@opensource.wdc.com>
Date: Wed, 16 Mar 2022 09:07:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Content-Language: en-US
To: Luis Chamberlain <mcgrof@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
 =?UTF-8?Q?Matias_Bj=c3=b8rling?= <Matias.Bjorling@wdc.com>,
 Keith Busch <kbusch@kernel.org>, Pankaj Raghav <p.raghav@samsung.com>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
 kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, Pankaj Raghav <pankydev8@gmail.com>,
 Kanchan Joshi <joshiiitr@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20220314073537.GA4204@lst.de>
 <05a1fde2-12bd-1059-6177-2291307dbd8d@opensource.wdc.com>
 <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
 <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
 <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
 <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315132611.g5ert4tzuxgi7qd5@unifi> <20220315133052.GA12593@lst.de>
 <YjDGS6ROx6tI5FBR@bombadil.infradead.org>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YjDGS6ROx6tI5FBR@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_170724_191121_1C157403 
X-CRM114-Status: GOOD (  22.38  )
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

On 3/16/22 02:00, Luis Chamberlain wrote:
> On Tue, Mar 15, 2022 at 02:30:52PM +0100, Christoph Hellwig wrote:
>> On Tue, Mar 15, 2022 at 02:26:11PM +0100, Javier Gonz=C3=A1lez wrote:
>>> but we do not see a usage for ZNS in F2FS, as it is a mobile
>>> file-system. As other interfaces arrive, this work will become natura=
l.
>>>
>>> ZoneFS and butrfs are good targets for ZNS and these we can do. I wou=
ld
>>> still do the work in phases to make sure we have enough early feedbac=
k
>>> from the community.
>>>
>>> Since this thread has been very active, I will wait some time for
>>> Christoph and others to catch up before we start sending code.
>>
>> Can someone summarize where we stand?
>=20
> RFCs should be posted to help review and evaluate direct NPO2 support
> (not emulation) given we have no vendor willing to take a position that
> NPO2 will *never* be supported on ZNS, and its not clear yet how many
> vendors other than Samsung actually require NPO2 support. The other
> reason is existing NPO2 customers currently cake in hacks to Linux to
> supoport NPO2 support, and so a fragmentation already exists. To help
> address this it's best to evaluate what the world of NPO2 support would
> look like and put the effort to do the work for that and review that.

And again no mentions of all the applications supporting zones assuming
a power of 2 zone size that will break. Seriously. Please stop
considering the kernel only. If this were only about the kernel, we
would all be working on patches already.

Allowing non power of 2 zone size may prevent applications running today
to run properly on these non power of 2 zone size devices. *not* nice. I
have yet to see any convincing argument proving that this is not an issue=
.

--=20
Damien Le Moal
Western Digital Research

