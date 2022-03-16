Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9ADC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Mar 2022 00:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZxASyb9bYrPFfJum9O2StKDc//XX+bfAePMiOUGd5Os=; b=caIeWFOqxSgFOtNJwhqCNMhjDh
	Rz8KQA+zt1EMvmiIPlO9KDRpqxdSFZgXfMKLN2F3Ox6cjgQIPENGcVMmtjPfQAN6VC+bNHTGT4mTG
	WfD8R2/IvHppnRhcWS6DLdvIqjPuF3KVJ6Hg2dKKOX8hbl0z48guOV7jIbdi2gn3M7Spt9P/58FaV
	7nqFv4Qo4xOBjLBAD/mpfsGIuLfgr0GJzVIk8uf5VqA6McanqHeNz9B+ErkkgyOKU4nDF9D+r3Qy+
	OGImqT0MnBvYNC3ifm0Iw+6TbL0THFSrEdUhP3YlQYP+rj0mpPKzQfpAY3eTwgqIl+Se5sMkwqD46
	h5hgSfVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUHoU-00B1kw-3v; Wed, 16 Mar 2022 00:46:54 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUHoQ-00B1kZ-TA
 for linux-nvme@lists.infradead.org; Wed, 16 Mar 2022 00:46:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1647391609; x=1678927609;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ZxASyb9bYrPFfJum9O2StKDc//XX+bfAePMiOUGd5Os=;
 b=CaW+Afswh8thV9cc6jB3zVIwV3UklKEaZISjh6burqS5CTiL2uf4sO/u
 uauRLjUKvWLnqA3zg7eryMffflv7DAkUDa7cUTQqZTDo96TEiMEqU4aA3
 3U0UJkEIbWT4fDGjebjNEUJMrLunwu4pXc7ny3DVmaEZIbIy2NIWjONnu
 grgE4NMW9qw7FdSxqfL/ivBDjGKac2XGTPnIppCvvJFPZk5A4OTzQrPOZ
 cmHDRmhgLvyr9mJKwhtsxVCwCIrJpkcQD9C/YuQuNnDoyy38NLothrM4n
 2NR1M7uGCig/1Ao1ZaCR7ReYfIdQ8n6uZOVGa1WhhUHK8TW5n57oSIl5p g==;
X-IronPort-AV: E=Sophos;i="5.90,185,1643644800"; d="scan'208";a="195456645"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2022 08:46:48 +0800
IronPort-SDR: A1iRbIewmlyq+xsNtscD8zLI49PNjr3CQaNSCQNIVeu7mrUhTQ6cnfSwiRx3/vfZ6f5UBBxI7q
 2JNfolsWHrtqrY0uJPrh7Ifto18TPj6EmsnXPqYOvBQJGa8WhP/moq0s+c8ibohC7ay5uTxVzx
 YAEk6FDLXxwdByWmR5ctLLP7FJuTR9hR0Y6+Jl5MEEmYNZ7vpcD6X/+6oSSbz/VQJtDorIv58t
 AX/Axg2/eXBh/xDjTwKGAadyfSjh7Cv3p/A3VzMQkcAh7syR/WecmuqWpi6DGU8Qc6gchTo64T
 R59wCKOB45NkJkcXb7zOYHHH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2022 17:17:57 -0700
IronPort-SDR: UpZ160eDxOVEGFwWKHm2zerB2TFkvWUMYq2apZOsJh4LovTWVgRODd7pB377K0+J7fP/+dtqi9
 dJjp1S8xGAZtL0rIva+eE+ox/JVcpEDDaeqT443BL6nacEHFzTsbIcY5t7Yz1AOKag0joz+Y7E
 5qQlPOIRZff+8OrmpwIsOJaivm+5TkV0oRxXY1feJpkP4S76skS6t8qmvwLSvCfVtGqvkREP+7
 drOMI5fW+WV7nbf9nR4G19xY368lqSNT1vk2n5NFKMvfwgW7h+Ywk+k1hYRa+uV4lciKP7OI2b
 kxs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2022 17:46:51 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KJBRt0FR0z1Rwrw
 for <linux-nvme@lists.infradead.org>; Tue, 15 Mar 2022 17:46:49 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1647391609; x=1649983610; bh=ZxASyb9bYrPFfJum9O2StKDc//XX+bfAePM
 iOUGd5Os=; b=pvmLn4GaqueKkub9+bFZjCUiKXz0cpWUdWiWZZPFNi3dUGHrnW6
 vEgfNxoj1pPZPvSsHrOV8DMCiMu1kd/2qKXosQUkxChjTSjN81OfA2xDo1K/+S2N
 CBPIpW6Dh4jygqHtrDdCO5ILO6+qQJ32ERKCC6F9sUucvSRj3qY5MBR9XYon2q4l
 aDjQ2t6hii3VraPNvX3+gavlNMgRW24v46ZftF5NMbtqLW51iti68wK9xCAIWcrp
 EyEgEP3nnMr9QLDUKtTfvTTPXuuZmPHtjJTz9TVn3RrweOI6ywv7QFAOMV0R6YD0
 dFExmLXYvkDdTUuHpqIemtj3zB9yUHmRSGA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id IyL-eFN9SQLC for <linux-nvme@lists.infradead.org>;
 Tue, 15 Mar 2022 17:46:49 -0700 (PDT)
Received: from [10.225.163.101] (unknown [10.225.163.101])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KJBRp3g6sz1Rvlx;
 Tue, 15 Mar 2022 17:46:46 -0700 (PDT)
Message-ID: <c3d71cd7-cf95-c290-bfc6-29d307b7b4e8@opensource.wdc.com>
Date: Wed, 16 Mar 2022 09:46:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Content-Language: en-US
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, =?UTF-8?Q?Javier_Gonz=c3=a1lez?=
 <javier@javigon.com>, =?UTF-8?Q?Matias_Bj=c3=b8rling?=
 <Matias.Bjorling@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Pankaj Raghav <p.raghav@samsung.com>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
 kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, Pankaj Raghav <pankydev8@gmail.com>,
 Kanchan Joshi <joshiiitr@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
 <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
 <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
 <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315132611.g5ert4tzuxgi7qd5@unifi> <20220315133052.GA12593@lst.de>
 <YjDGS6ROx6tI5FBR@bombadil.infradead.org>
 <62ed2891-f4b2-d63c-553d-8cae49b586bc@opensource.wdc.com>
 <YjEuAv/RNpF4GvsJ@bombadil.infradead.org>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YjEuAv/RNpF4GvsJ@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_174651_025673_A18DD5C1 
X-CRM114-Status: GOOD (  28.82  )
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

On 3/16/22 09:23, Luis Chamberlain wrote:
> On Wed, Mar 16, 2022 at 09:07:18AM +0900, Damien Le Moal wrote:
>> On 3/16/22 02:00, Luis Chamberlain wrote:
>>> On Tue, Mar 15, 2022 at 02:30:52PM +0100, Christoph Hellwig wrote:
>>>> On Tue, Mar 15, 2022 at 02:26:11PM +0100, Javier Gonz=C3=A1lez wrote=
:
>>>>> but we do not see a usage for ZNS in F2FS, as it is a mobile
>>>>> file-system. As other interfaces arrive, this work will become natu=
ral.
>>>>>
>>>>> ZoneFS and butrfs are good targets for ZNS and these we can do. I w=
ould
>>>>> still do the work in phases to make sure we have enough early feedb=
ack
>>>>> from the community.
>>>>>
>>>>> Since this thread has been very active, I will wait some time for
>>>>> Christoph and others to catch up before we start sending code.
>>>>
>>>> Can someone summarize where we stand?
>>>
>>> RFCs should be posted to help review and evaluate direct NPO2 support
>>> (not emulation) given we have no vendor willing to take a position th=
at
>>> NPO2 will *never* be supported on ZNS, and its not clear yet how many
>>> vendors other than Samsung actually require NPO2 support. The other
>>> reason is existing NPO2 customers currently cake in hacks to Linux to
>>> supoport NPO2 support, and so a fragmentation already exists. To help
>>> address this it's best to evaluate what the world of NPO2 support wou=
ld
>>> look like and put the effort to do the work for that and review that.
>>
>> And again no mentions of all the applications supporting zones assumin=
g
>> a power of 2 zone size that will break.
>=20
> What applications? ZNS does not incur a PO2 requirement. So I really
> want to know what applications make this assumption and would break
> because all of a sudden say NPO2 is supported.

Exactly. What applications ? For ZNS, I cannot say as devices have not
been available for long. But neither can you.

> Why would that break those ZNS applications?

Please keep in mind that there are power of 2 zone sized ZNS devices out
there. Applications designed for these devices and optimized to do bit
shift arithmetic using the power of 2 size property will break. What the
plan for that case ? How will you address these users complaints ?

>> Allowing non power of 2 zone size may prevent applications running tod=
ay
>> to run properly on these non power of 2 zone size devices. *not* nice.
>=20
> Applications which want to support ZNS have to take into consideration
> that NPO2 is posisble and there existing users of that world today.

Which is really an ugly approach. The kernel zone user interface is
common to all zoned devices: SMR, ZNS, null_blk, DM (dm-crypt,
dm-linear). They all have one point in common: zone size is a power of
2. Zone capacity may differ, but hey, we also unified that by reporting
a zone capacity for *ALL* of them.

Applications correctly designed for SMR can thus also run on ZNS too.
With this in mind, the spectrum of applications that would break on non
power of 2 ZNS devices is suddenly much larger.

This has always been my concern from the start: allowing non power of 2
zone size fragments userspace support and has the potential to
complicate things for application developers.

>=20
> You cannot negate their existance.
>=20
>> I have yet to see any convincing argument proving that this is not an =
issue.
>=20
> You are just saying things can break but not clarifying exactly what.
> And you have not taken a position to say WD will not ever support NPO2
> on ZNS. And so, you can't negate the prospect of that implied path for
> support as a possibility, even if it means work towards the ecosystem
> today.

Please do not bring in corporate strategy aspects in this discussion.
This is a technical discussion and I am not talking as a representative
of my employer nor should we ever dicsuss business plans on a public
mailing list. I am a kernel developer and maintainer. Keep it technical
please.


--=20
Damien Le Moal
Western Digital Research

