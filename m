Return-Path: <SRS0=ND0+=JJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBEFC433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 11:59:25 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1D2E611C9
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 11:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D2E611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hjys+eYPL3sGvYnCEd6X3OYjrbPgywchcen+xpFNDU8=; b=Xz3Tv3O8H4wXmvpBe/drVbf8K
	CKo9uw5WcdepjTFLl+tgdrozAdM7oG7RorGPlm92lV0qZ21kEkBb5ej/4gDAH4sdGBycp8Vf2OIeN
	Sn4HDdz97I5mfvtIBqf4fMIRIXkkq2V0XXoykQuGjri4U7+p4g+Xm++zMLSHLqYUcocwb0d+Luf7X
	wSzXjxAUkCHYqq6UoaKiRAufXTPzHD9D26PIzlkXlCVIZN9SSEV8JSikiPPKlEdea2M2c8ft19uWx
	yeKs1pWdF5Dj1fabUBAQK7LNzM5pvxVx2BV4054YnxW4Wcl4Q69cdRI36h2tQzEedz1R/Ns2gyl5D
	ZlOxKJfCQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lVvDj-006d9X-GF; Mon, 12 Apr 2021 11:59:11 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVvDf-006d8t-Ck
 for linux-nvme@desiato.infradead.org; Mon, 12 Apr 2021 11:59:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=References:Content-Type:In-Reply-To:
 MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=5SowKObqMwgoy4lzaEN4KdpGdu56eL7LvV0w4EiQduI=; b=EfbwYUUQmmF/AVwJi2S7tFFe+9
 fKLmoH6a+s+Yo68ebV0pOODNE8JEgy/q5RIVoXm/7SrZFqXwywX5DdNfLk5wJWdYrxaFY6v8bb0G2
 pkxh/yxD6fMVWKtatYb8mOBEN0S5vqGXoqtRgdHDv1OFmDaqPLLYY76ldS8/112pbZAKMGAGwxlVY
 fvXOJa1pCJ/bH/oi1PvigIM1hpOS5LDJq8DhwQjFmIg2dCY+09/6Ew/HKBmLkjxPgLxCQOw0Ntze6
 1UwUm7K7EMcEdZqRo/ek+8jC4BnQn9ZAeSGQ3Lstzs9cmStf2rclqofGEsZRIASI/RKfE3n9QG+y8
 Fnl2JXQg==;
Received: from mailout1.samsung.com ([203.254.224.24])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVvDa-006CRW-8E
 for linux-nvme@lists.infradead.org; Mon, 12 Apr 2021 11:59:05 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20210412115855epoutp016e2f82533ce9d003be38b715a189eb70~1GnX5UDf_1075110751epoutp01v
 for <linux-nvme@lists.infradead.org>; Mon, 12 Apr 2021 11:58:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20210412115855epoutp016e2f82533ce9d003be38b715a189eb70~1GnX5UDf_1075110751epoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1618228735;
 bh=5SowKObqMwgoy4lzaEN4KdpGdu56eL7LvV0w4EiQduI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=m94e3N7wfuZco+1tRuksnSB2+UtoOQW/6Ll9amhur1ADGpk2CI1X9YfqdqgASQlsl
 xQF4J77F1eV6WN4E2JsV3jjQUyt/2ehYf4roCbU1/J+CbWONK6tduLKJdOvvYe4PNW
 ywwMaSONhYmDMcnkHLAnGwFYHonoVx1gX5WouEUA=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTP id
 20210412115854epcas5p3eeb1f12ee368832c66c45f3b5dd43bcd~1GnXDgrmq2830728307epcas5p33;
 Mon, 12 Apr 2021 11:58:54 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 4E.1A.41008.EF534706; Mon, 12 Apr 2021 20:58:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20210412114908epcas5p235776bd1ffe5f2eba1565b3278f1d506~1Ge1oBfvv0313203132epcas5p2Z;
 Mon, 12 Apr 2021 11:49:08 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20210412114908epsmtrp268307c7fdb25fb25ad210e442fcd438f~1Ge1nPThH3053830538epsmtrp2U;
 Mon, 12 Apr 2021 11:49:08 +0000 (GMT)
X-AuditID: b6c32a4b-661ff7000001a030-d5-607435fe7fa7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 65.B5.08745.4B334706; Mon, 12 Apr 2021 20:49:08 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20210412114906epsmtip2fe9b4b378be02e131af07960e257076b~1Gez6QnWG0402604026epsmtip2E;
 Mon, 12 Apr 2021 11:49:06 +0000 (GMT)
Date: Mon, 12 Apr 2021 17:18:27 +0530
From: Padmakar Kalghatgi <p.kalghatgi@samsung.com>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "tasleson@redhat.com"
 <tasleson@redhat.com>, "tbzatek@redhat.com" <tbzatek@redhat.com>,
 "prakash.v@samsung.com" <prakash.v@samsung.com>, "d.palani@samsung.com"
 <d.palani@samsung.com>, "javier.gonz@samsung.com" <javier.gonz@samsung.com>,
 "k.jensen@samsung.com" <k.jensen@samsung.com>, "mohit.kap@samsung.com"
 <mohit.kap@samsung.com>, "krish.reddy@samsung.com" <krish.reddy@samsung.com>
Subject: Re: libnvme questions
Message-ID: <20210412114827.GA27283@test-zns>
MIME-Version: 1.0
In-Reply-To: <YG/qmMKsFIvGuQoX@apples.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIKsWRmVeSWpSXmKPExsWy7bCmpu4/05IEg/WLWC1m3X7NYvH26wM2
 i/0Hv7FaPL7zmd3iZOMeVotJh64xWizcuIzJYv6yp+wWa14oW1yZsojZ4uK9m+wW8/58ZHfg
 8Ti34zy7x6ZVnWwem5fUe7zfd5XNo2/LKkaP9gPdTAFsUVw2Kak5mWWpRfp2CVwZj+5+Yy3Y
 xFcx+fEKtgbGz9xdjJwcEgImEndnb2LuYuTiEBLYzSixeuMBRgjnE6NE85/NUJnPjBJzbyxh
 h2nZ3TadFSKxi1Fi67dt7BDOM0aJRSuXMoNUsQioStyesA4owcHBJmAk8b3VFiQsIqAi8fTf
 XhaQemaB9SwSFzZcZgJJCAvISdzdeIERxOYV0JVoujKfGcIWlDg58wkLiM0JNOfW2llgcVEB
 ZYkD244zgQySEFjJIXH8yB6o81wk/uyexwhhC0u8Or4FKi4l8fndXjaIhmZGiX1frrBAOBMY
 JabMf8cEUWUvcXHPXzCbWSBD4sX3Z6wQcVmJqafWQcX5JHp/P4Gq55XYMQ/GVpV4fOEgG4Qt
 LTF75SeouIfE5tbPbNAwZpaYu/QS4wRG+VlI3puFZB+EbSXR+aEJyOYAsqUllv/jgDA1Jdbv
 0l/AyLqKUTK1oDg3PbXYtMA4L7Vcrzgxt7g0L10vOT93EyM4lWl572B89OCD3iFGJg7GQ4wS
 HMxKIrxJlcUJQrwpiZVVqUX58UWlOanFhxilOViUxHl3GDyIFxJITyxJzU5NLUgtgskycXBK
 NTA1ltd2rildei750opJ04o3yrEn8vNfVnz0bfoEGTF9f5aJ/qrXZkyXrUqoYXsoof804vHD
 6cu4ZjIEzNuVLz+fT3yzpNLtznvZPTOTnt4/O83wXGFsz7cXTeaKr59Y8ou+M+20Tvh7exej
 xme2f8fam08eVVz57C7Tx6yLzfocMueXKHhwMwXm1Fw9PXvjevsDm/g/P6kXSXYQWqt85sMf
 IYFQ0xcMrKZMXj9X+sYvaI7KqeWqOvYjqGN5+qLLr/8EuWRJzC8Sn2XGa/urNqenaGpq9xJd
 my/a614fOTb38G0NSc83aY5y4rZvD9VX8y3eef8F38rFF7rfpXOHeZYIN/+7qPDhvzz3BzOm
 JWJKLMUZiYZazEXFiQBRRVop1AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsWy7bCSvO4W45IEgx/rpSxm3X7NYvH26wM2
 i/0Hv7FaPL7zmd3iZOMeVotJh64xWizcuIzJYv6yp+wWa14oW1yZsojZ4uK9m+wW8/58ZHfg
 8Ti34zy7x6ZVnWwem5fUe7zfd5XNo2/LKkaP9gPdTAFsUVw2Kak5mWWpRfp2CVwZd2dcZCt4
 wl3R0dfB1sC4n7OLkZNDQsBEYnfbdFYQW0hgB6PEl1M6EHFpiX0Pr7NA2MISK/89Z+9i5AKq
 ecIo8fLuArAGFgFVidsT1gElODjYBIwkvrfagoRFBFQknv7bywJSzyywlUViftsJNpCEsICc
 xN2NFxhBbF4BXYmmK/OZIYbuZpZY/LyXCSIhKHFy5hOwzcwCZhLzNj9kBlnADHTR8n8cIGFO
 oF231s5iBrFFBZQlDmw7zjSBUXAWku5ZSLpnIXQvYGRexSiZWlCcm55bbFhglJdarlecmFtc
 mpeul5yfu4kRHD1aWjsY96z6oHeIkYmD8RCjBAezkghvUmVxghBvSmJlVWpRfnxRaU5q8SFG
 aQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1M/urn1UQkbescL9u5Nto5u350iFd/Gfqk
 n0GDrVvoXvusiBWF/O4HcpLW7M368G9afKHhknnd0tcEJT2/XZyW/Wm7nP5s0Z0Ks79MeiiX
 JfRfviX2leE6FQ2DfefPf9TdXSNy8IPmbsOFujs3n7mz8YORz+mL6Z2fQ5g/dSzc+ktaWCfI
 o/3r2b9migWy27YKrip6+Fq+PXPbhSrGw19v7jVKVr3O/k0/YlWia8i6dUcbdfNZQpb0ZK6Y
 Xbmg0UfmY0vsqdMixQeXekTvXNYw3WfCy8nrVty9sf+lY6lQ94nA1jdbzv/f8W1et/Ul66dh
 LN9TtC/sFz0t+mRxvvxvFknNYzI7P9z98UmTf+K7aCWW4oxEQy3mouJEAKzMUp8NAwAA
X-CMS-MailID: 20210412114908epcas5p235776bd1ffe5f2eba1565b3278f1d506
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----rJxxaR0GuCM_dHQxpWiIChs6D.UommiO4QigGiW7XG79mXGL=_73dfe_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210407123854epcas5p48217db953741a57d651a8a8bf240ee23
References: <20210312161824.GA3953@redsun51.ssa.fujisawa.hgst.com>
 <CGME20210407123854epcas5p48217db953741a57d651a8a8bf240ee23@epcas5p4.samsung.com>
 <20210407123806.23253-1-p.kalghatgi@samsung.com>
 <BYAPR04MB4965314610B9338D1D6D32E986759@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210408074826.GA12847@test-zns>
 <BYAPR04MB49656C8E6D8157608DCF73A686739@BYAPR04MB4965.namprd04.prod.outlook.com>
 <YG/qmMKsFIvGuQoX@apples.localdomain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210412_045902_824447_94D3AECD 
X-CRM114-Status: GOOD (  20.10  )
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

------rJxxaR0GuCM_dHQxpWiIChs6D.UommiO4QigGiW7XG79mXGL=_73dfe_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Fri, Apr 09, 2021 at 07:48:08AM +0200, Klaus Jensen wrote:
>On Apr  9 03:58, Chaitanya Kulkarni wrote:
>>On 4/8/21 00:52, Padmakar Kalghatgi wrote:
>>>On Wed, Apr 07, 2021 at 11:16:02PM +0000, Chaitanya Kulkarni wrote:
>>>>On 4/7/21 05:46, Padmakar Kalghatgi wrote:
>>>>>Along with this, we planned to implement the sideband MI command handling in QEMU.
>>>>why ?
>>>>
>>>>
>>>>
>>>Add MI command emulation and avoid HW dependency for development and
>>>testing.
>>>
>>
>>Absolutely not. With this logic we have to implement entire NVMe command
>>set.Current QEMU implementation is lean, I'd like to keep that way and not
>>bloat it just for the sake of testing unless there is a kernel component
>>that is consuming MI interface and I don't think so we will have it
>>anytime soon.
>>
>
>I don't see why this would bloat the nvme device. The out-of-band 
>mechanism would necessarily be implemented by a separate qdev device 
>that would "listen in" on relevant QEMU busses (PCI, nvme-bus). I 
>expect this to look something along the lines of ipmi_sim.
>
>The QEMU nvme device is a PCI device, I don't see that changing. It 
>can implement the in-band tunneling mechanism through the NVMe-MI 
>Send/Receive commands, but the real work would be handed off to the 
>nvme-mi qdev device.
>
>At least I think that's how I would do it.

Yes, I agree with Klaus. The plan is to implement the NVMe-MI command
set and not to implement anything new in the NVMe module of QEMU.

------rJxxaR0GuCM_dHQxpWiIChs6D.UommiO4QigGiW7XG79mXGL=_73dfe_
Content-Type: text/plain; charset="utf-8"


------rJxxaR0GuCM_dHQxpWiIChs6D.UommiO4QigGiW7XG79mXGL=_73dfe_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

------rJxxaR0GuCM_dHQxpWiIChs6D.UommiO4QigGiW7XG79mXGL=_73dfe_--

