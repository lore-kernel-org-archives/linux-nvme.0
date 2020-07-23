Return-Path: <SRS0=ANVZ=BC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CB2C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2020 01:24:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 119B520737
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2020 01:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dmRZBDnK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="rmg6ToYK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 119B520737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:In-Reply-To:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	 bh=XHTmq/aeUOUDtafUsPq0PK8UMNGixnPmh2j4eFGpt30=; b=dmRZBDnKc8txWwn3KYk5fKsKR
	y/sWKdeP+Wn524FIsW5gOKSTljZjBWCBVV2zMrh1JXc8Nqj59zZyOiwzHvdy7qfpX6B7XA6egK6TJ
	Og4sIPH+NGC4EUgxK0IPju4kGiOWr8iUqblXArVqydCkbVX2a0qxGRbXSp+vRpsTOiryziKY2oho8
	SiKso38fQLJWkfgIq8wqFSF9frMZiVWoKTvYH0dI9TApjf4bETVeTMb1c7w8N+uxvHuuM4EcGISs8
	cvxN+QtIF4OVUxSF9iM3KQ2nb1d3dkqTfu08exR5bP51834RwvcIakYPAJrR6BXQawu30kqSV6vkV
	NSgy0E4Ug==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jyPxp-0000YZ-KS; Thu, 23 Jul 2020 01:24:01 +0000
Received: from mout.web.de ([212.227.17.11])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyPxn-0000Xm-1V
 for linux-nvme@lists.infradead.org; Thu, 23 Jul 2020 01:23:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1595467427;
 bh=SzSf2rkCmIInSphZgi2IWvhjAodJ/qv908hUQ0j10ws=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:In-Reply-To:Date;
 b=rmg6ToYKaUj/cbPpM5WDOBuEvBNWZhaEL0YqmBD/Owfm2w03S2gvHr74JyzH0sBEd
 HSSDmdBo3c/6DaX7hqFTIWxPCv0tmCplsCirg0wcF3t2ytlQbHH+YGRZhVcR6ixXaz
 Fw4S7iuEA2Tj4pOGeofVtJ44GCEMtZp2gpBHlQwM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from ingo ([84.143.241.7]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lh6QF-1kdmNw1N1b-00oYwV; Thu, 23
 Jul 2020 03:23:47 +0200
From: Ingo Brunberg <ingo_brunberg@web.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: Namepace identification descriptor list is optional
In-Reply-To: <c92f9d41-de84-ab54-c003-8649d20deb50@grimberg.me> (message
 from Sagi Grimberg on Wed, 22 Jul 2020 16:23:24 -0700)
Date: Thu, 23 Jul 2020 03:23:28 +0200
Message-ID: <m3sgdj10tr.fsf@web.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:+ybu8HeaTTmAfpLkwhfJr3vHgu1xVXMknIIlv1tNZCEfvXFFewg
 GRp6jsAmXhKMRB3Q7lwiXHoM6B/AKzhFAK6LOFRQtlxNTIHM9vhDs5grH4l3mgQyqtcF7Dl
 BVyrxtLh+x76UQKTWkD/O1Nwm7Anxtq8P4agCZ1bXWaIfJuTubTaCykBuj/mzMrxGTkIhH3
 teTrAlbxNSrOg+oJ8sJCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Rxh61qav6og=:EGy4cjqWKs3fZaSi4mW/Qu
 D1za4xicwYGGKLTDntXeuURkMgcQoP2dsqK/ODsjRvKsOLoAFPMBR2sWHU2bBn1nR9b5AJwFp
 DwQjwHWCby4qzW2QYV5StIOZfId3qcf0PZ/bsLaoH5Rn/JXzFtReavfa8ePhJ3cv+x6fFBxOO
 lAcACzyPQfnIiiY8IU0xpGr8QnsO/NKpbYAOlSlXQ10+XTvRDFqKa8nDXEp89oTV3LoZb2HD9
 lfjISWyzVowINiSzLkPQ/67pNn9llhEp0PCbfpe9SgMCCN9rej7LTPV/SiPI+oKjmOm7ni6kF
 xPg11hMbQ+EJ0Hq9qPxbkd/nBg1Qzif35sn1jEEVd9iplRH+xckGbs/nxkrr2RT9sXR9kW0a4
 4kyihan7cYzaS7wORoHNq0eomS5e7HT+uW48v72YhJew3mqQF2GIipfHiELlOwNazHjrgqJOk
 7gBFMrkoCseuKD8xbALixBxdS4NOo+LWqjg/MDWsfr7z1lX7/ABb49/tcckFYIT0tFfEO1fWp
 kPbL00VYns69ltRc7h33NFYVHjVWcKW7BqPJrYcsR37wCWFT584q+ItSO/ar6aisUWiL3/MYu
 9eNXgciREHDdGeRqwUuS4b8Sw84CAqXPZ0bNupydkTbvKcJx4EKgoPBIG8mPKkIhBySXpNucs
 OT1G1KsGnIHWBwj09TlI5hDvwsceF3gSt2fbhZ/b3l0x2EJ/T7mhUBn1C0d2/iJ9dky3D+RcN
 hV5s+hgo706dUl3Huqdb1/hgz42NTL6v7G3taYUhGhZaAwwhGIzuUySuSyabuQKez0ZThV8lY
 nPshpJglgrVorxQWr2ZuyDr0JJ6Tk+f+74qGBk8P+XOyoaYCLKFKnbx+RAh0O5JaJWWo9kheu
 yLmMu/TJ0VQnRR/nJcow95Xwj0tpTvWfczp3q5Y/G6HKW5OsiUG2EhMYxhPoIwbX+23hASwMt
 r9PaBGLpPUxQodMsMVhXLOojv1kaf8wg+jt6MjaFBBsFU1PDzvVR/dH0q5n3yb1g77rWeqFnE
 SoxSThczpiKqzqm+HlwDKdvhCcD0bzHrfY4RwDVA8kBmHVCSaoyP6B23aQlxQTEHLkMmcDYVa
 wNXImW1F32riQdOjOQSLydECsE1F/FNXop5rusvWk7mtDAHW8Edgh5qkGTLQZcm2iOxnv3C+i
 tT9Il8Kyp5B9OyvxKsJJk6G0fkQFXy/EnVPn35d0fQF5T7iXzCCtCJhCXN6iLAbV22rsE6kE8
 KlzP7XVSGC0qfiw/UwFeEmJtEJw4+3FAYz3jNvQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200722_212359_321959_A2BD3B60 
X-CRM114-Status: UNSURE (   6.49  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Sagi Grimberg <sagi@grimberg.me> writes:

>> With commit ea43d97, appearing now in kernel 5.7.8, you made my cheap
>> SSD disfunctional again. For reference, see bug 205679. Maybe you
>> remember the discussion.
>>
>> I do not know if this was intentional or not. Maybe you should introduce
>> a quirk for that particular controller.
>
> Either we quirk this controller, or we are back to test specific errors...
>
> What is the pci id of the device to test a quirk?

The PCI ID is 126f:2263

Related old and new bugs on bugzilla.kernel.org with some actual drives
listed are: 205679, 205645, 208583, 208585

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
