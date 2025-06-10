Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25505C5B552
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Jun 2025 15:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z/FCL69JVp+4ZhZ3gKaX6rxwxRG6WLoL1PCbrXwAZPI=; b=02uCeAXL+hBx4trS/CORinxweA
	v9JMRnr4/D0gfoBtgqLrpyIZ2/gXTnOppx/mAeqlJybNASoXo5O4m2gE0F8sC0cqdaSeWwPSt9Dmx
	wOs4Cp4PvVtHXZa/ZvSWAFD8hEZPkOy73M+kNrsfM17OxMz7h/1kmQpPlUe1Ii1sBAJDDVdXzUH7e
	LWkAf1K19IShX8M0Jr6BvyyDeKAkIGrMlAbExHmUsavCttrWf0ta9doBMJcij1cXSwNVuRXjXV4yI
	NY0mRtrAOxl87/578NE11A69GFXY1Gd1kVyyXRukxEGLyfIHE+MsAStZc0UYk6y36dLFpE32TYhXY
	88RVCnEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP0am-00000007Efw-0UFs;
	Tue, 10 Jun 2025 15:08:48 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOyR4-00000006q4Z-1VHT
	for linux-nvme@lists.infradead.org;
	Tue, 10 Jun 2025 12:50:40 +0000
Received: from localhost (nat-pool-brq-u.redhat.com [213.175.37.12])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 1a66c489 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Jun 2025 14:50:33 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Jun 2025 14:50:32 +0200
Message-Id: <DAIV77646KWY.3QL4ZL1IH2630@bsdbackstore.eu>
Cc: <hare@kernel.org>, <linux-nvme@lists.infradead.org>,
 <zhang.guanghui@cestc.cn>, <loberman@redhat.com>
Subject: Re: [PATCH V4 1/2] nvme-tcp: Prevent infinite loop if socket closes
 during CONNECTING state
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Sagi Grimberg" <sagi@grimberg.me>, "Maurizio Lombardi"
 <mlombard@redhat.com>, <kbusch@meta.com>
X-Mailer: aerc 0.20.1
References: <20250404082801.1614252-1-mlombard@redhat.com>
 <20250404082801.1614252-2-mlombard@redhat.com>
 <c4695327-0a0d-4b8c-a852-ee2ce4beb924@grimberg.me>
 <D966L87J0CQ2.2WV0U5JZEMZ9Q@bsdbackstore.eu>
 <fc197a49-32f9-44ff-be3c-4efa1d42d0b0@grimberg.me>
 <D98XO9X62V98.1OGPR20IUZ9EO@bsdbackstore.eu>
 <0c60225a-6a48-484e-9526-27e699da4f1a@grimberg.me>
In-Reply-To: <0c60225a-6a48-484e-9526-27e699da4f1a@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_055038_777551_0088577B 
X-CRM114-Status: GOOD (  13.00  )
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

On Fri Apr 18, 2025 at 1:14 PM CEST, Sagi Grimberg wrote:
>
>
> On 4/17/25 16:04, Maurizio Lombardi wrote:
>> On Mon Apr 14, 2025 at 11:35 PM CEST, Sagi Grimberg wrote:
>>> I see the issue, but we need to make sure that if the connection closes
>>> before
>>> the controller finished establishing, then it cleans up correctly.
>>> Because at some
>>> point in the past - it wasn't the case. Things have changed in that pat=
h
>>> so it might
>>> be ok now... Just need to check. I'd trigger the race while the admin
>>> queue is establishing, as well
>>> as in the middle of the sequence of IO queues are establishing.
>> I believe my earlier testing for this patch already covered this scenari=
o,
>> but I can rerun the tests to confirm and report back.
>
> So you indeed made sure that the failure starts sporadically in the=20
> controller establishment sequence
> and there is no use-after-free issue?

Sorry for the long wait; I am now back at it.
I repeated the tests using a debug kernel, and nothing has been detected.

>
>>
>> Either way, any fixes needed should be unrelated to this patch in my opi=
nion,
>> as this one covers the case where the controller
>> has already finished establishing the admin and I/O queues.
>
> Well, you are changing code that was added to prevent double free issues=
=20
> when the error recovery
> and the initial connect sequence ran together.

Note that even with this patch, the error recovery and the initial
connect sequence cannot run together. The reset is initiated when
a send operation fails, after the controller has switched to the LIVE state=
.

Maurizio

