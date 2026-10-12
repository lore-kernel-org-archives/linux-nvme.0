Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B834FCA9ED1
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2026 07:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Mime-Version:Message-Id:Date
	:Subject:From:Cc:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xk3hbaaEMQ+lW6c3+RYQ4qvYM/R/WfCEOwoYIh/ZUfc=; b=MkxHjUpoGOmnh2jJ3WlL2tFq1m
	77tCsgBdYmHUjnVaMnAyk3vXfaeTEMjFWI1aXjywKPsFTABH/Mqk2i2xD7vn+RTTFX6Fh9UnDKws6
	ts0Xgc6Wsf6bExxI/odULEywa7ZV/ybOf26v1HQWDHE65LjtmKJFrVsAm+Xn7wW8YowV5G+WqQRwc
	itVnYiOa7XbUiimwxWPhsbkFiRGxzJXdv+sjB+//PySv3IYot5blffKOFRwDkvgDOPSJ9URfItXcs
	7UCkm+OmJpIZPhlo9JXyerVpxY4qol/mIfPPDR0QDs3TIUaQrOfO7z6I7HxbWCcu6BN0rOtEBa6i1
	MsucRY8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGA2H-00000009nYR-1VUf;
	Mon, 12 Oct 2026 07:01:25 +0000
Received: from va-1-115.ptr.blmpb.com ([209.127.230.115])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGA2D-00000009nWU-0Wd9
	for linux-nvme@lists.infradead.org;
	Mon, 12 Oct 2026 07:01:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1791788473; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Xk3hbaaEMQ+lW6c3+RYQ4qvYM/R/WfCEOwoYIh/ZUfc=;
 b=PT3FIMlPUAD3g73PtBCnteGpPpRHOu0DR3mtChnzSUahphH3BtfCpapmJSdUvBQ7i1q6YX
 cGQRk7kSZGvptW3wOTHw6o3i0OKF92eMC4+CRAJjffxUIBpgbtjr+m8XArvLatdLzxiq1H
 Mf5hcK28lpBOLy7ojODsJ+XYOyB4cHLHG1NEVBbGhYa/qCko6QtedSayXMqJ44BfQlLJv+
 tQef9+KOtqvz/2wrptKqA5ZcQvstQhILG0NyA48vVz0hvoGNG1dmLsEOPqnpYQiiImaLyG
 XXp9clWKb3w/eHyaNDaFyL8Tjv+XMD2ffrodeA6/jN3WnO+cN4okqcguddqClw==
To: "Naman Jain" <namjain@linux.microsoft.com>, 
	"Michael Kelley" <mhklinux@outlook.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
In-Reply-To: <8bff7953-a9df-4ede-b3de-a4df558946a9@linux.microsoft.com>
X-Lms-Return-Path: <lba+26acc85b2+e5fee7+lists.infradead.org+changfengnan@bytedance.com>
References: <20261009050556.2817978-1-namjain@linux.microsoft.com> <MN2PR02MB6863FBC36CE4F1D6419F0E8BD4922@MN2PR02MB6863.namprd02.prod.outlook.com> <04d88297-1732-4761-ae82-d68c441a7156@linux.microsoft.com> <3f4a11ea-bbc0-4dc5-9720-3447346739cf@linux.microsoft.com> <1c7c7fd9-e2e6-41ac-ac97-9c4d71b1c2fc@bytedance.com> <8bff7953-a9df-4ede-b3de-a4df558946a9@linux.microsoft.com>
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: "Keith Busch" <kbusch@kernel.org>, "Jens Axboe" <axboe@kernel.dk>, 
	"Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"Luigi Rizzo" <lrizzo@google.com>
From: "Fengnan" <changfengnan@bytedance.com>
Subject: Re: [RFC PATCH 0/3] nvme-pci: yield completions under scheduler pressure
Date: Mon, 12 Oct 2026 15:00:49 +0800
Message-Id: <758e4c6b-1b1a-4191-baeb-3f9799783ee6@bytedance.com>
Mime-Version: 1.0
X-Original-From: Fengnan <changfengnan@bytedance.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261012_000121_260627_02AB04FA 
X-CRM114-Status: GOOD (  17.85  )
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

=E5=9C=A8 2026/10/12 14:48, Naman Jain =E5=86=99=E9=81=93:
>=20
>=20
> On 10/9/2026 5:06 PM, Fengnan wrote:
>> Hi Naman:
>>
>> This is an issue I hadn=E2=80=99t noticed before.
>> I'll take a closer look at this issue later.
>>
>> Regarding testing, there are a few points to note:
>> 1. My patch has been updated to V2, https://lore.kernel.org/linux-nvme/2=
0260826061546.56006-1-changfengnan@bytedance.com/
>> 2. In my experience, when do performance tests, it=E2=80=99s best to do =
precondition
>> first and then execute an ABBA test; this ensures reliable results.
>> 3. IIRC, disabling interrupts in the QEMU kernel does not actually disab=
le hardware
>> interrupts; QEMU still handles them, which has a significant impact on p=
erformance testing.
>> Perhaps you could test this on a physical machine.
>>
>> Also, I=E2=80=99d like to ask: does this softlockup issue only occur on =
QEMU+ARM?
>> or does it also occur on x86 physical machines?
>> Have you tried enabling the =E2=80=9CPosted Interrupt=E2=80=9D feature i=
n VM? Maybe this will solve
>> this problem in VM.
>>
>> Thanks.
>=20
> Hi Fengnan,
> Thanks for the suggestion.
>=20
> I was using QEMU just for sanity, all the test results are based on exper=
iments in an Azure ARM64 Hyper-V VM. I could not create enough load on my l=
ocal QEMU VM to cause a lockup, so I am relying only on the Azure VM I have=
. I would not rule out x86 for this issue, as we have seen spurious lockups=
 in the fleet, which are more common on certain SKUs, but my current experi=
ments are limited to arm64. The proposed solution should solve it for both.

I set up a test environment on my own this morning.
Although I wasn't able to reproduce the soft lockup issue, I did observe
I/O latency of several hundred milliseconds.

>=20
> The guest exposes a GICv3 CPU interface and Hyper-V vPCI maps the NVMe MS=
I-X vectors as guest GIC SPIs. I do not see an ITS, LPIs/vLPIs, GICv4 VPEs,=
 or another direct virtual interrupt injection interface exposed to the gue=
st. Also, posted/direct interrupts would reduce host-to-guest interrupt inj=
ection overhead, but the lockup here occurs after delivery, while nvme_irq(=
) repeatedly drains completion queues in guest hardirq context. So I would =
not expect posted interrupts alone to provide the missing scheduling bounda=
ry.

I'm thinking that adding a scheduling check to my patch should also resolve
this issue.
That would be simpler and more acceptable, we can work together to refine i=
t.

Thanks.


>=20
> Thanks,
> Naman

