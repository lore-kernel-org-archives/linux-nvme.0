Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BAAC10F1E
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Dec 2022 11:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-transfer-encoding:
	Content-type:In-reply-to:From:References:Cc:To:Subject:MIME-version:Date:
	Message-id:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LWl+dwuFvwHM/La+sthWt8IK+hkiLuNLi0fAV3LorRw=; b=aa4tof2vaEL6IpW05twG3e3AWS
	Zft485QC3WTsUjVNfLBpPXMFDpO7drdarA3lSBBUJ8AXAaz0W9+50oWO+/Tnvv87djVxLHRlIjxih
	Gn+rV7jtBjbA3pm+J8BH9qRt5vHZv4ViCA7iFpSRe9WMqdwRGAqcLcCZSNi6VSrcUkb9zXAuicWra
	0TxuvQyQVKBqx5OwAruGPCwW+YOfVcNn6HtjVP+ngP0djalpOdc7nUSbjTG+pH5Qelu5lexqE3Gtk
	PhgyywP4clm6TZBa5JqtTVFIwPnfx8GN2bzrqti6XaXYxvLwdbTCt7SJtg2XuRZ/jBoYfAa9sPSAw
	DVjq901Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7arZ-00Dtge-3a; Tue, 20 Dec 2022 11:32:49 +0000
Received: from abi149hd125.arn1.oracleemaildelivery.com ([129.149.84.125])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7apd-00DsAo-Qx
	for linux-nvme@lists.infradead.org; Tue, 20 Dec 2022 11:30:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-arn1-20220924;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=LWl+dwuFvwHM/La+sthWt8IK+hkiLuNLi0fAV3LorRw=;
 b=sMh80TyaViBU8f0N1VOTpbz/32r4zlEP2Jo54z0E4Qcj6yHglfzLPDMmgeNcBU2VcACkaKl/dOBD
   bVfQPMH8MwhVjaRU2uJqElJM/FqOKafUuYNb9WpPequEdZDGNkXiFrMUgKQXPNJhjdCDRqe9P4nh
   RJWNvb0CeEniJqXe/zkBw5PSBH24y4QzPy06E8gv9kww2Q/ld7ngL0Wo07aDHIxwSbqPoMK9GEgj
   R3soMwhcs2YT/Ijid7R59IDFwrBtA4X7HGTsycBL0uIEsx3zY2cpBx8/9eFZzHu7QdfRmzZzjf5I
   thdFkvY15i+cdZfA/94u5iDHOdlUp1fOnOJqzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-arn-20211201;
 d=arn1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=LWl+dwuFvwHM/La+sthWt8IK+hkiLuNLi0fAV3LorRw=;
 b=auIOpP+0iiXAAS9+7sJaG9ODk1UCeEVb6T7IKc1eVzwrRWOKmqu/quNxNFrZBqOWFW2Td/ciM/nU
   NuUoerXSUR6HIDVPShtkj0uWCfoZwhmPeBm51oTSTut0/KUr8uMrWDsbdYSRb4SU3neIBFLRlt9N
   WByy/Uhjp7cAIwjUI/W553dJkzVMUlqex1azTeUoqLrY3irtf96vF1XRkMQ5ixRRaBB1X3nmIF3X
   SwrxMNH9Az0iW/skZJ70RqLu7Zzw5U23OyqnP4rbyJWH1kYcolV5d7uuH0QJqHkk3PMw2TPvkbV0
   KwQBMQltdYSjGOIwt9NfoGjicyrC8+Hyg8aJsg==
Received: by omta-ad1-fd1-101-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20221212 64bit (built Dec 12
 2022))
 with ESMTPS id <0RN600LPQTB6XSB0@omta-ad1-fd1-101-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com>
 for linux-nvme@lists.infradead.org; Tue, 20 Dec 2022 11:30:42 +0000 (GMT)
Message-id: <a80857cb-e3a0-74b2-a7c4-a1afb34e5082@augustwikerfors.se>
Date: Tue, 20 Dec 2022 12:30:39 +0100
MIME-version: 1.0
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1 256G
 and 512G
Content-language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
References: <20221116171727.4083-1-git@augustwikerfors.se>
 <CGME20221116172324epcas5p3d9877249797ac741ead5785cba27e00e@epcas5p3.samsung.com>
 <20221116171935.GA24524@lst.de> <20221117031951.GB392@test-zns>
 <20221206055928.GB24451@test-zns>
From: August Wikerfors <git@augustwikerfors.se>
In-reply-to: <20221206055928.GB24451@test-zns>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
Reporting-Meta:  AAGILxLChfRQdNmOHagNzZxsBm++OdYCqjaY8vHGYk7FpcpdeqBieFG87sYLWtZE
 9KAz4qXu7D9U91Btd+Yglw6FxRtZl6XjVEJC7PBH9xotJhO9lfsidMZ5rRP3u1jW
 fX1UixeP7JSSSqE7s3Jh/AX4dIwjIJuFmXFEpsVHSMJWG3YWOitwvSLZ2lm5PbKA
 YrNK2W3MLVqmoA3DohMHhepdqgICVrD1jsn1JmyuEVJ6bFw6v2udLzJyJc6dDt06
 pF/9evQAS1oBFolH33qXOOGXIZF1N7i4G9uQCOngJO+P2e0mI947C2W3b5mp0dDp
 XdtpQB0/blpdXGKiTe6fl6UVOI86JcFxmRrCg+y7hsLgwWhXu//Rx0nhD16DubU7
 8IjIEBy0xkBolEXMBfimI4b54gjcUHKzOYjlTMEgApio0rcxi9oR28kB1X3FmFRX UifCQFnA
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221220_033050_869755_864BF545 
X-CRM114-Status: GOOD (  12.32  )
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

On 2022-12-06 06:59, Kanchan Joshi wrote:
> On Thu, Nov 17, 2022 at 08:49:51AM +0530, Kanchan Joshi wrote:
>> On Wed, Nov 16, 2022 at 06:19:35PM +0100, Christoph Hellwig wrote:
>>> On Wed, Nov 16, 2022 at 06:17:27PM +0100, August Wikerfors wrote:
>>>> The Samsung PM9B1 512G SSD found in some Lenovo Yoga 7 14ARB7 laptop 
>>>> units
>>>> reports eui as 0001000200030004 when resuming from s2idle, causing the
>>>> device to be removed with this error in dmesg:
>>>>
>>>> nvme nvme0: identifiers changed for nsid 1
>>>
>>> What EUI did it report before? Is the identifier stable after
>>> multiple resume cycles?
>>>
>>> Can some of the Samsung folks here reach out to the relevant firmware
>>> team to see if they have any clues?
>>
>> I will check.
> 
> Took more time than I wanted. Firmware team mentioned that issue existed
> in this firmware. This is fixed in new firmware, but bit of travel time
> is involved when official release from OEM (Lenovo) comes out.
> 
> Hope the information is sufficient, and quirk can go in.
> 
> If required, Acked-by: Kanchan Joshi <joshi.k@samsung.com>

Ping, anything left for me to do before this can be merged?

Regards,
August Wikerfors

