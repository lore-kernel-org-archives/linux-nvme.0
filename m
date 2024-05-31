Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C9FC25B75
	for <linux-nvme@archiver.kernel.org>; Fri, 31 May 2024 20:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S1p76AS0cf6kXj0arrO4uHwvtCrK3sOZAIQUxCLQYjw=; b=t/MgA9+R3QyMpWQAEl9P0w7SGw
	B5IyO8Yh2o+vs6URjI5+fTTXnc8cdVSAnmh4eJigGn34FbdktjTVTVs8TU1vpsrmDOQEFxCkBkNgh
	FOqazglCULAsv+oN9oSfOtWxsD20xftbLtKA7gFPfZxTF+jrwUIn3Y4GoyrEOIjf1rlmh1knv3qMI
	FAxibkCJUycz1P8pcdzIgHn36skI7TQhK6R3F8PVeHzzxnyCbLCwDiiCYIILygJlt4XTRkKPJzAUD
	iDzGuV5pApdOWmS6/v2T+0W8iaZUk22wlpRW4XR340JajkuFWZxNy4G6M+Ze+P0uJMO/2HCZQFuWP
	GB/CK5+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD98t-0000000BPqA-3Zez;
	Fri, 31 May 2024 20:46:27 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD98m-0000000BPpc-2pwZ
	for linux-nvme@lists.infradead.org;
	Fri, 31 May 2024 20:46:25 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VrZsS1DQGzlgMVh;
	Fri, 31 May 2024 20:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717188377; x=1719780378; bh=S1p76AS0cf6kXj0arrO4uHwv
	tCrK3sOZAIQUxCLQYjw=; b=aIjFOs59T8LcAZQap6j+YsIwrvOvf60UO4e7TfiN
	pFEQB2abUGrZfcrYKKrkKrB2647WdjDFKB6QJPBEGUU1FyrrFvMdVnauviSoI0hA
	8Ka1eYWrrnBndgRXrYQjQUBJFhciyTRMhERfTmZPCsXskrnwnZCGQwt1XnP7/BtZ
	07W9IhNa8k41tcYhKdlOBfPLYBvEupFBPNKEFRz046N7z2cgZzPv6Uww0mHjz2hf
	XOHvIDbeIENN+oDsEjNrWgbW4T3ZdS+EbpXu6pZaAsIbozHinVgWm+RrA5r3sWC4
	jWpcpgKCAvcAjIM1NOQJZdB/ncuDWQDEbA7hhY+viPi9zQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 3oVgloOHcuuQ; Fri, 31 May 2024 20:46:17 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VrZsP1vz8zlgMVf;
	Fri, 31 May 2024 20:46:17 +0000 (UTC)
Message-ID: <81a63f38-fab0-4536-bbc2-3f06752a7f9e@acm.org>
Date: Fri, 31 May 2024 13:46:16 -0700
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
 <0a82785a-a417-4f53-8f3a-2a9ad3ab3bf7@acm.org>
 <CAD=hENdgS40CmZs2o5M_O71k07Q7txg9-2XnaHP97_+eC9xT3w@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAD=hENdgS40CmZs2o5M_O71k07Q7txg9-2XnaHP97_+eC9xT3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_134620_750296_27DC2EB6 
X-CRM114-Status: GOOD (  13.07  )
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

On 5/31/24 13:35, Zhu Yanjun wrote:
> On Fri, May 31, 2024 at 10:08=E2=80=AFPM Bart Van Assche <bvanassche@ac=
m.org> wrote:
>>
>> On 5/31/24 13:06, Zhu Yanjun wrote:
>>> On Fri, May 31, 2024 at 10:01=E2=80=AFPM Bart Van Assche <bvanassche@=
acm.org> wrote:
>>>>
>>>> On 5/31/24 07:35, Zhu Yanjun wrote:
>>>>> IIRC, the problem with srp/002, 011 also occurs with siw driver, do=
 you make
>>>>> tests with siw driver to verify whether the problem with srp/002, 0=
11 is also > fixed or not?
>>>>
>>>> I have not yet seen any failures of any of the SRP tests when using =
the siw driver.
>>>> What am I missing?
>>   >
>>   > (left out a bunch of forwarded emails)
>>
>> Forwarding emails is not useful, especially if these emails do not ans=
wer the question
>> that I asked.
>=20
> Bob had made tests with siw. From his mail, it seems that the similar
> problem also occurs with SIW.

I'm not aware of anyone other than Bob having reported failures of the SR=
P tests
in combination with the siw driver.

Thanks,

Bart.


