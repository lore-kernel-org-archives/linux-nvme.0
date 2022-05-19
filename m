Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8743EC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 19 May 2022 03:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RNmiGh36R9uSASjMgSxTjiOeFNbGdN7nw/rdBpVBqPs=; b=37M97VxU1r8civ3Diu3M1h9UQA
	NAaKpThnHKpV3ocGUK1foiahk/nnJZWJLCnedw/ZVCG5qQ6MaBVrpMVlZmrX/O0Y0wgqod6TxOeIs
	iQG7+HCHuYGpcqVppMZI09q76zFmLfNy7fIcJmzv6+II7g8Xx+flIswuVpnIwSTNERvR3ebgmkaKH
	9+u+uFgwNdoiGXqeQff32EiK5O3NN59lioal14OD/UvStEnsttWbohI0KUCe/wurLkbVmoUwVhkWy
	Q/x86jLM/+4XuVsXU16b1QEt65wjoZk9C1ujs2VBf5va089YPf6DkvVj3DtkvFzNthuVDKAslQr+8
	yFoU/uCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrWhK-004qik-MQ; Thu, 19 May 2022 03:19:34 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrWhG-004qYt-PZ
 for linux-nvme@lists.infradead.org; Thu, 19 May 2022 03:19:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1652930370; x=1684466370;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=/fjrsnNb+UMSk1eAp1vdCajfjX7evM0A7SUCPImugSk=;
 b=OtEWnPK4nYfigS2HIEw9ZFoTS20+CPlkNFxmF/JOfHTUYmLTn3VjNCHL
 +Ous0Ba0tg4ZViVwkZjUT5FKIck7gIf0Bf5gBeddvNjFuCCdSWqHqWMJB
 Mayp6Jcxik8Qg2J+wIE2AGRF7PAHAUhGE2ACqYKLrtWMfGUcGQ9MlWabT
 vI6yzsszKotESo5BDZt1l0M1rD0O8zciOf2IW3PG9OwSC8VTP8MGEVIFG
 XBW0Bi0hYrTnrHEw8el4flBzC5j5IAmjbZeHpUT2djR4aIPTrLXb6P5Rd
 VkbaRq5tJ+I5+BrlJVGZC4IEhBwo/Cr9aeQN5wCcA3pqqr1oUikZJ3bXf Q==;
X-IronPort-AV: E=Sophos;i="5.91,236,1647273600"; d="scan'208";a="199557605"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 19 May 2022 11:19:27 +0800
IronPort-SDR: Kqeq1i8xgNLYp9uzcmf2QnAuiijTbsWOwgJRduGxBWaWfLqSMU+d4X56pg1jGRfgT1IyBzclOU
 etLkE5wsbtPjG7Bs5SnC6qkwfaSaPgWBn2LK3hzmtkfgWWF5DmbewB4UntRll2e65rueA3bkDK
 4h7PyUFophXFpRv6Je+XRC1WMuczIo9G5Hq9vPMPFuG8lAloEJsWIyZIMTWj76m9TeeFeI2RxZ
 h1mrAqym1jpi9f0FxAAkQlceCBlJqjxUKIFbDx+koWUHJsaD7mEl4yr25nla7HrFtyHmSg9kJM
 O5ddCP1BJqRA8vOuJ49SGVtK
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 18 May 2022 19:44:55 -0700
IronPort-SDR: rsxTDJoGdokHp0B6eFk2Br/Tq0lBg6YmLLJOrR3KlLpxWgVRKfyam9zm+rZyVD6380NBP/7Dxk
 QZhcind307ghSkFS8wIl/xVgrOpurwV4d3wqEGKdx97tzVdFC7ut2f5x0uNtcgeu0LZJTgrMw2
 t+esyg+/uExvV7dmgNUIIIY4t6+WjcV4QE7RVdoxHqoVZJkDcTBRCN2qoOGspzZJtd4U0Yh6aw
 0DkQL/YKmsmtJ+z67/9UR7zCO6XjAsMeaBvF1BWPPRBZ8AwWtcdRZg6YzgZ9ob2qYNqueUUIwx
 7Cg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 18 May 2022 20:19:24 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L3ZpM5vwxz1SVp6
 for <linux-nvme@lists.infradead.org>; Wed, 18 May 2022 20:19:23 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1652930363; x=1655522364; bh=/fjrsnNb+UMSk1eAp1vdCajfjX7evM0A7SU
 CPImugSk=; b=thZR8YTGSc6pbhvaXC4nlTCJU1ty3CWx6okQPQztJ44SZdl940Q
 LGWu/R9+kaxBjYrFyXFneYPHrY4ppu9MI5+Ns0YFzgmtJ+jkyeorUZNmp14m8Np9
 MbftoZtJQLirdzTJuFq3wueDaL67ltG0xVqhlsJQj0ZRz+as1k4HMygglk2J8QAB
 w2DgyE4E1zbHFwS35UUIltBuBqkk7OnPUhXGjCqmz185y0NRc2EBF/g9IZCJqUf8
 XJr4hVXmasYJuf394HdctQCG1Y6yOJ7qSK+i8ThYn7+ds9NuTn6YC5Z6+lE3K2gW
 7f2A0WaHHv+Xxbb7saoGB8l6rsMknGQdf/w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id YbgHkZlydxaT for <linux-nvme@lists.infradead.org>;
 Wed, 18 May 2022 20:19:23 -0700 (PDT)
Received: from [10.225.163.43] (unknown [10.225.163.43])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L3ZpJ0qRQz1Rvlc;
 Wed, 18 May 2022 20:19:19 -0700 (PDT)
Message-ID: <69f06f90-d31b-620b-9009-188d1d641562@opensource.wdc.com>
Date: Thu, 19 May 2022 12:19:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [dm-devel] [PATCH v4 00/13] support non power of 2 zoned devices
Content-Language: en-US
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
 Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk, pankydev8@gmail.com,
 gost.dev@samsung.com, jiangbo.365@bytedance.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 dm-devel@redhat.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
References: <CGME20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef@eucas1p2.samsung.com>
 <20220516165416.171196-1-p.raghav@samsung.com>
 <20220517081048.GA13947@lst.de> <YoPAnj9ufkt5nh1G@mit.edu>
 <7f9cb19b-621b-75ea-7273-2d2769237851@opensource.wdc.com>
 <20220519031237.sw45lvzrydrm7fpb@garbanzo>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220519031237.sw45lvzrydrm7fpb@garbanzo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_201930_920925_88ADAEFA 
X-CRM114-Status: GOOD (  15.79  )
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

On 5/19/22 12:12, Luis Chamberlain wrote:
> On Thu, May 19, 2022 at 12:08:26PM +0900, Damien Le Moal wrote:
>> On 5/18/22 00:34, Theodore Ts'o wrote:
>>> On Tue, May 17, 2022 at 10:10:48AM +0200, Christoph Hellwig wrote:
>>>> I'm a little surprised about all this activity.
>>>>
>>>> I though the conclusion at LSF/MM was that for Linux itself there
>>>> is very little benefit in supporting this scheme.  It will massively
>>>> fragment the supported based of devices and applications, while only
>>>> having the benefit of supporting some Samsung legacy devices.
>>>
>>> FWIW,
>>>
>>> That wasn't my impression from that LSF/MM session, but once the
>>> videos become available, folks can decide for themselves.
>>
>> There was no real discussion about zone size constraint on the zone
>> storage BoF. Many discussions happened in the hallway track though.
> 
> Right so no direct clear blockers mentioned at all during the BoF.

Nor any clear OK.

> 
>   Luis


-- 
Damien Le Moal
Western Digital Research

