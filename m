Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C0F7C43217
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Nov 2022 09:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-transfer-encoding:
	Content-type:In-reply-to:From:References:Cc:To:Subject:MIME-version:Date:
	Message-id:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VUXX+8jrmWkJCXer27nFIgtcX3F8p3BIA/+hpmKo4Dc=; b=qxvfggopQiIFJvgjgttWEEMZvQ
	j6aCuOsbmDO77OsskOL7g38kr7OHD7OdFZV1ixZNgx2qlx6pIvttXwatTFBy2sZ3SOKPe78It7WZT
	9BLa4eRSPjVU4Eof9O3818DAkWwB9UEe5BGk9AEKvh7EpqrBoK99rZUXyMPgmEeFwmOq/7a/mwypj
	JHv8qxhaR76kuCB+ShU3ncPM4VvdLg/XfyyIrJjOs5PQEpXCQuG/rMVJ+FMIzsHtbOkzMpIc7L/6i
	TTiJQYIxlepzLVOfJcLmSv5T4Am3BzrDSdRYfe+9KUR8r2cEW/RTiaE6gIhPht8uIlZ6B6BpTiWXv
	lyP9TQcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovazL-00C03j-RF; Thu, 17 Nov 2022 09:15:15 +0000
Received: from abi149hd126.arn1.oracleemaildelivery.com ([129.149.84.126])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovazI-00C01m-DC
	for linux-nvme@lists.infradead.org; Thu, 17 Nov 2022 09:15:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-arn1-20220924;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=VUXX+8jrmWkJCXer27nFIgtcX3F8p3BIA/+hpmKo4Dc=;
 b=YwchHuUaYjQ5lXInwdjgN3x/ttsYfOF2d5dVZxVwyIpf0XnPE7wo6Y6Qm3KTeEln4QqLF+hHew51
   KsmEbjPaiazjWyPMQISJw+LAafE7eNMxfgH1BHpgs64hxoGJTvOGevD/bnlVEAt05irLqfOmXSDh
   RCTnyDraQPUKeF9p42UrGPhGvx7dHkrH0HlHR4amDLwsI2YbGnatN8wnEIE2P8+6FZDhrlHQ4kr5
   m/65uTX4bLGepq5tQ+xo/sZMgZXFzn651YpIpFtrM/Rdp6C/k2jZ00U0eKIq1xR+/wnOajUppe/6
   WhZEgrJNS0jblai+0ZFATF8mdne+4DQejp43uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-arn-20211201;
 d=arn1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=VUXX+8jrmWkJCXer27nFIgtcX3F8p3BIA/+hpmKo4Dc=;
 b=Ck/by/2yLfp11KPDTLFCAKhq1sDrAkiRXb+haFfTac0H1c14vh/EDdBXp817ljDKxNV8ChgOqgSw
   wunKbKDbXac5gxRFGP9Lq77svAmDQ5k9Mga/3H/6u1B2Rz82cvfWLRlHSO4wySnvuB2FbiW7kZJ2
   vOskU7ryg4xGDOCNq0AhaZTEdTOHj0D69qyAyLkEuHQUf6LOqY3cIwHJLzSbDDpWCfBLnlKywzUa
   sy1Yihahso5QUWCMDqHtWcfNV++LzOUyfDU0OmXeRT31f4QIZqgGyB3NrUaMZh1cVbTqm/HFwtZf
   9U6BkXjEpjdUdDZ6awCt3EH7UWuKdnLra7GfeA==
Received: by omta-ad1-fd3-101-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20221104 64bit (built Nov  4
 2022))
 with ESMTPS id <0RLH00124ISP1H70@omta-ad1-fd3-101-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com>
 for linux-nvme@lists.infradead.org; Thu, 17 Nov 2022 09:10:01 +0000 (GMT)
Message-id: <8be4e657-53c3-45f5-eec9-c80379cf7ad8@augustwikerfors.se>
Date: Thu, 17 Nov 2022 10:09:54 +0100
MIME-version: 1.0
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1 256G
 and 512G
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221116171727.4083-1-git@augustwikerfors.se>
 <20221116171935.GA24524@lst.de>
 <CGME20221116175159epcas5p4093dd66e85ed287cf9bd9acaec766aa3@epcas5p4.samsung.com>
 <e775398c-97bc-fc1d-a785-6d3c80bce9c6@augustwikerfors.se>
 <20221117071337.GA29422@test-zns>
Content-language: en-US
From: August Wikerfors <git@augustwikerfors.se>
In-reply-to: <20221117071337.GA29422@test-zns>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
Reporting-Meta:  AAH8jGwJkqrsMJZiSWc4NmV1bdxGLCGJRGckZxBi2fZPBWdh/Mn5jedKotFSKG8H
 1EdfzDiHsF0JsQaOuFxlWwPM8TjZ2+Men/4/So6LVyRY/IpB7ReJKvTHsN3l7Qpx
 F5Nu21J9P7e2JYk3znjk92FvtZepq22h9CqWHUtS1I4Xcqg7upuU3qexFmiy4JYi
 GUWQb1nOC05wjsCT0Ysc25F7AQAxN9hF8MilP7FMw4XJYsnHDCnqShO3D2IVvDlM
 467A6W5+lhJG9veW9SZh74d427npXdbcPsoQv5RhChqqL5zbFFyZ3Se6SSdwKH5z
 J+Op6xfJHI1WF4whqsmCzQbVCR2L4P3Gno0U5LzKpHiE81wcJ5ojWmORbahv+i0Z
 vfA12Bt0Qpm+qpFRgGntIiBQygoTBAm2cnwHV9xeFUpYPLRSnQ78Of2gmJQQi07I 0EfsYK32mw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221117_011512_459177_BCFC2E56 
X-CRM114-Status: GOOD (  10.35  )
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

On 2022-11-17 08:13, Kanchan Joshi wrote:
> On Wed, Nov 16, 2022 at 06:42:43PM +0100, August Wikerfors wrote:
>> On 2022-11-16 18:19, Christoph Hellwig wrote:
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
>> The original EUI is "002538e621b440e5". Using the patches from [1] and 
>> [2] for debugging I consistently get this output on every resume:
>>> eui changed from 002538e621b440e5 to 0001000200030004
> 
> Can you please share the firmware version of this SSD?

The firmware version is 7L1QHXC7.

