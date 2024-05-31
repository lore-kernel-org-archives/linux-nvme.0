Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CAEC25B75
	for <linux-nvme@archiver.kernel.org>; Fri, 31 May 2024 20:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qJ3xjAYeIM5dfikpUZr//uQG9kmt6nHbhiUKNJJlmYs=; b=WIdoXJV/nMkN6OKhjaiY6EFzDD
	mEvvxAYPRpvRbR4oupueWnuQ5IsTbzlEx1y9B+qTBf0qJecROYMhrfQt/oe1zMZB977kD9sHbXDrf
	A9yptP+QUQsU/mQRAELtqgXSZESdITQhVOrgagxP5SNlRBON2aj1SzHLkCmVLXW1m8dpctI2LVUXK
	4xYDcwUqashSIbfAPDEWspov/1RrSHgfrg4DcK6uAlSGVVpBGDleR7ufrhRk1YpFu+fiCa9jGKEeX
	/Cmu9kEEiyNV1uOfCRvsEFw0CWjq9RLZbUfWGi2XwZ1CUspg5Kxd7xRd0GStXdoZiM3uWmkv6Q7aL
	XLCl7BRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD8Ye-0000000BLCi-3b30;
	Fri, 31 May 2024 20:09:00 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD8Yb-0000000BLBd-1MIr
	for linux-nvme@lists.infradead.org;
	Fri, 31 May 2024 20:08:58 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VrZ2J2D3lz6CmR43;
	Fri, 31 May 2024 20:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717186133; x=1719778134; bh=qJ3xjAYeIM5dfikpUZr//uQG
	9kmt6nHbhiUKNJJlmYs=; b=3IRa5vKiVTmcMmP2dIBQ+jae48HT3Ok31/z98R+a
	LHchjQhDyXzYbjUiwRpFHJzxnyQBMM9gvR/0SUxyxpzcUJkkc9repE8a3NjphYpO
	txMI6Fu6kJhgvXugIai+67m2Zpth3Ll42mTVo0fu1GEx0bAtdeQt3ytJZf5So+g+
	MAWAelgAZZ+K32B6020UtQEOgJ/X+wTPx+hRfim7GJSVNT2ZH9oXzcC3b+jl/SZx
	gGrPYSY7jedbvrN1H9nmTVL88nK25fDPaN9dQKyOmFgi1Joekk0MC+cKfHPjebv5
	PVt/IdxV1PEFSaOtSf5usvUUduo2uPGGLoNKHFVKsUTKjw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id xwebMED3Mh0l; Fri, 31 May 2024 20:08:53 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VrZ2F0RsNz6CmSMs;
	Fri, 31 May 2024 20:08:52 +0000 (UTC)
Message-ID: <0a82785a-a417-4f53-8f3a-2a9ad3ab3bf7@acm.org>
Date: Fri, 31 May 2024 13:08:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blktests failures with v6.10-rc1 kernel
To: Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <wnucs5oboi4flje5yvtea7puvn6zzztcnlrfz3lpzlwgblrxgw@7wvqdzioejgl>
 <6cd21274-50b3-44c5-af48-179cbd08b1ba@linux.dev>
 <b29f3a7a-3d58-44e1-b4ab-dbb4420c04a9@acm.org>
 <CAD=hENdBGcBSzcaniH+En6gecpay7S-fm1foEg5vmuXiVYxhpQ@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAD=hENdBGcBSzcaniH+En6gecpay7S-fm1foEg5vmuXiVYxhpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_130857_419148_AA26547E 
X-CRM114-Status: GOOD (  10.92  )
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

On 5/31/24 13:06, Zhu Yanjun wrote:
> On Fri, May 31, 2024 at 10:01=E2=80=AFPM Bart Van Assche <bvanassche@ac=
m.org> wrote:
>>
>> On 5/31/24 07:35, Zhu Yanjun wrote:
>>> IIRC, the problem with srp/002, 011 also occurs with siw driver, do y=
ou make
>>> tests with siw driver to verify whether the problem with srp/002, 011=
 is also > fixed or not?
>>
>> I have not yet seen any failures of any of the SRP tests when using th=
e siw driver.
>> What am I missing?
 >
 > (left out a bunch of forwarded emails)

Forwarding emails is not useful, especially if these emails do not answer=
 the question
that I asked.

Thanks,

Bart.

