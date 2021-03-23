Return-Path: <SRS0=jrCY=IV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44B4C433C1
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 08:38:14 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 581A4619B1
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 08:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581A4619B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:Message-ID:
	Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mUfbwOIjspAfdKTvRHOkdEY7WFziQtdfdCRZZpzZbjk=; b=VoNHXHg/UPSPK2E7W+94hFAC8
	hyTCcjguSHvnx6HXNAhHVPqO9jAJ4A/tEIZroL1jlPWo8i7FSYlh68p3g+vMEmdDfBJaFG9kw2ruc
	I7A8g5x74s8TNyUX4mEmqsBOmerBvNNBIpMVpyYRnQ+GCsJKzJ1F2LfzkUvBHooMttIHB30hVlDVv
	YknUKzQZ8l1H+t0TrP2IFXwHTxK+15RR69yMSouiE1CcF6TTY2B+tGvBLBNfgjx8pfA1uI+7ZQ2ZA
	1UBbUlXqgKc68i9mFAp7Gt0i0laf1x6upjO7Ir2wVJIaR3CxskOmt5hMHZg96VUjfYCWEZAL+3tiJ
	xRKdLIPHw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lOcY4-00EKzg-QY; Tue, 23 Mar 2021 08:38:01 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOcXx-00EKyA-0t
 for linux-nvme@lists.infradead.org; Tue, 23 Mar 2021 08:37:57 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20210323083751euoutp01ccb5f151b058d59dadcd84e3273f569b~u6_HNofZp1809318093euoutp01y
 for <linux-nvme@lists.infradead.org>; Tue, 23 Mar 2021 08:37:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20210323083751euoutp01ccb5f151b058d59dadcd84e3273f569b~u6_HNofZp1809318093euoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1616488671;
 bh=RAJW6KXGMCgfP+KxJg+mnX3RSzCjtZMNvC5Qa4T70Iw=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=qg1dprvamhRUbo3/AcgKd5LrBampkc+ntGEJRbbx2vAn52YSRxaZ73+CwQloQ2XD+
 0FeGRBH/AhrlZcNrj3rYNrMTdB2IOMMH6pwQ+/6GJtAyphStjytwyE8GR4GBGlydkI
 /Gzxo6HEh+UWeenvW515+bs1MU85C1b/uazGpWnQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20210323083751eucas1p1bfc19447901aa1737df2b8fee83a7e5f~u6_HDsipM1368513685eucas1p1e;
 Tue, 23 Mar 2021 08:37:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id C5.DB.09439.FD8A9506; Tue, 23
 Mar 2021 08:37:51 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20210323083750eucas1p14d21230ac758194d854ca336caf7f3f2~u6_GyfjrA2514925149eucas1p1P;
 Tue, 23 Mar 2021 08:37:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20210323083750eusmtrp15c88d878c40a90e53b03a356af76352c~u6_Gxh9_T0377003770eusmtrp15;
 Tue, 23 Mar 2021 08:37:50 +0000 (GMT)
X-AuditID: cbfec7f5-c03ff700000024df-ed-6059a8df690a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id DF.B3.08696.ED8A9506; Tue, 23
 Mar 2021 08:37:50 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20210323083750eusmtip27e021e64b28aa1631915825ba88f0a01~u6_GpMQNb0860508605eusmtip2e;
 Tue, 23 Mar 2021 08:37:50 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 23 Mar 2021 08:37:50 +0000
Received: from localhost (106.110.32.47) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend
 Transport; Tue, 23 Mar 2021 08:37:49 +0000
Date: Tue, 23 Mar 2021 09:37:49 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To: Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Dmitry Monakhov
 <dmtrmonakhov@yandex-team.ru>, <linux-kernel@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>, <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 1/1] nvme-pci: add the DISABLE_WRITE_ZEROES quirk for a
 Samsung PM1725a
Message-ID: <20210323083749.r272grolxozf3w2f@mpHalley.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210311104712.GA16218@lst.de>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7djPc7r3V0QmGHxex2ox6/ZrFou7b96z
 WKxcfZTJYtKha4wWl3fNYbOYv+wpuwObx6ZVnWwem5fUe+y+2cDm8XmTnEf7gW4mj1cX17MH
 sEVx2aSk5mSWpRbp2yVwZXw4tISxYC9HxYHe9SwNjN/Zuhg5OSQETCQedyxn72Lk4hASWMEo
 sXRDKxOE84VRYseB2awgVUICnxklbkxghek4cPM9C0TRckaJj18WQ3UAFR2+DFIF4pxhlHg8
 cTNU2V6gWX9b2EH6WQRUJdpaLzCC2GwC9hKXlt1iBrFFBJQknr46ywjSwCywjVHiyYG3YA3C
 ArESP6aeAFvOK2AjcXPTHRYIW1Di5MwnYDazgJVE54cmoBoOIFtaYvk/DpAwp4COxMGdT5lB
 ZkoI3OCQ6N55hQniCReJ+Yv6WSBsYYlXx7ewQ9gyEqcn97BANDQzSpxZcwWqu4dR4s+kFYwg
 GyQErCX6zuRANDhKbD0zjw0izCdx460gxD18EpO2TWeGCPNKdLQJQVSrSexo2go1REbi6RqF
 CYxKs5A8MwvJM7MQnlnAyLyKUTy1tDg3PbXYOC+1XK84Mbe4NC9dLzk/dxMjMNmc/nf86w7G
 Fa8+6h1iZOJgPMQowcGsJMLbEh6RIMSbklhZlVqUH19UmpNafIhRmoNFSZx319Y18UIC6Ykl
 qdmpqQWpRTBZJg5OqQYmnxr/Mrbey7XrDXIj59z259PJvyS0l8XYqm+by1zHpdvVDbNz5byE
 neY3VLbukqvr1Lv7YPrF5IPLQiKdH19K07rwKIh1s8HUl1q9+bqiyhoSMrnLShgT5lluqN3U
 IVb5e0v4tfbtBdP+2pz6pWMmxZu1K1/q7I5d1du9moXveXkpKtUeTQx/+tTnknLQN4vef1bP
 7//b0bmnYc+rIDP/ROvbzy+UK73z27tbs5y571RUrod2doPwInYrg66tv6u/nbiqymr8XbBH
 sWf65qDI7ndz7vS86d4+adlC9c8F95n+qIjKhPVny5xkiZ36b0nRbAOv3arbbv94/OJs/reZ
 GbVHv9qs+bLp8Tv9gPlKLMUZiYZazEXFiQAVSPHApQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xe7r3VkQmGLy8a2Ax6/ZrFou7b96z
 WKxcfZTJYtKha4wWl3fNYbOYv+wpuwObx6ZVnWwem5fUe+y+2cDm8XmTnEf7gW4mj1cX17MH
 sEXp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZXw4
 tISxYC9HxYHe9SwNjN/Zuhg5OSQETCQO3HzP0sXIxSEksJRRYuqHbqiEjMSnKx/ZIWxhiT/X
 utggij4ySty5u5ARwjnDKLFoZTszhLOXUWLJ/SPMIC0sAqoSba0XGEFsNgF7iUvLboHFRQSU
 JJ6+OgvWzSywjVHiyYG3YDuEBWIlfkw9wQpi8wrYSNzcdAfqqOeMEjvu3GWCSAhKnJz5hAXE
 ZhawkJg5/zzQJA4gW1pi+T8OkDCngI7EwZ1PmScwCs1C0jELSccshI4FjMyrGEVSS4tz03OL
 jfSKE3OLS/PS9ZLzczcxAuNr27GfW3Ywrnz1Ue8QIxMH4yFGCQ5mJRHelvCIBCHelMTKqtSi
 /Pii0pzU4kOMpkA/T2SWEk3OB0Z4Xkm8oZmBqaGJmaWBqaWZsZI4r8mRNfFCAumJJanZqakF
 qUUwfUwcnFINTPoOr5d1pS7j84sSlY1sPywTeu3KzglbLQ9NbedM5X6j08nM807S6NPDDTHv
 JmYWmDe67g4/UXEseDV/14QmfxPDORKzj31yaSjTeT0zpGLC83NuqpW1AmFGRZwX8412y8l1
 PY6Na7qc/Ynz9BmJHfuYyhRbZ2jLnhP4bMld+snEwHXh5VUrrLaqzJ/h3OlRkCquzqo4U8rk
 8qTk7Mb3l66UmBgcOnLzSqyVGmPao4YnUgFz5jx/knjfdf4f4eX6p/6cuJ1gdapZqe/j2Q23
 zTKS6nos/4vbMTJsun5jTfjsCNnYN1/mX0k3mPphkvEhg/Qnna/XHJD0jLmx9cGSWU87v6jn
 /8x+zLXsZ+2ZIiWW4oxEQy3mouJEACMwrck4AwAA
X-CMS-MailID: 20210323083750eucas1p14d21230ac758194d854ca336caf7f3f2
X-Msg-Generator: CA
X-RootMTR: 20210323083750eucas1p14d21230ac758194d854ca336caf7f3f2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210323083750eucas1p14d21230ac758194d854ca336caf7f3f2
References: <1615377076-3251-1-git-send-email-dmtrmonakhov@yandex-team.ru>
 <20210310132156.GA12145@lst.de> <20210310134110.GA13063@lst.de>
 <20210310200030.GA3377333@dhcp-10-100-145-180.wdc.com>
 <20210311104712.GA16218@lst.de>
 <CGME20210323083750eucas1p14d21230ac758194d854ca336caf7f3f2@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210323_083753_429557_3D4CB901 
X-CRM114-Status: GOOD (  17.55  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11.03.2021 11:47, Christoph Hellwig wrote:
>On Wed, Mar 10, 2021 at 12:00:30PM -0800, Keith Busch wrote:
>> On Wed, Mar 10, 2021 at 02:41:10PM +0100, Christoph Hellwig wrote:
>> > On Wed, Mar 10, 2021 at 02:21:56PM +0100, Christoph Hellwig wrote:
>> > > Can you try this patch instead?
>> > >
>> > > http://lists.infradead.org/pipermail/linux-nvme/2021-February/023183.html
>> >
>> > Actually, please try the patch below instead, it looks like our existing
>> > logic messes up the units:
>>
>> This seems like a good opportunity to incorporate TP4040 for non-MDTS
>> command limits. I sent a proposal here
>>
>>   http://lists.infradead.org/pipermail/linux-nvme/2021-March/023522.html
>>
>> And it defaults to your suggestion if the controller doesn't implement
>> the capability.
>
>I think TP4040 is good and useful, but I defintively want the pure
>fix get in first.

Quick question. It seems like the current quirk simply disables
write-zeroes. Would you be open for a quirk that aligns with MDTS for
models that implemented it this way before TP4040?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
