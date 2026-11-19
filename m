Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2653B606A325
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2026 03:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=o+82ttlL;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=pwIcxiyu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:From:Cc:Content-Type:
	In-Reply-To:Subject:To:Mime-Version:Content-Transfer-Encoding:References:
	Message-Id:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=PJA8HI/26n09BDtdxwvrwKrlkq0uzVECslo8UM0vFOE=; b=o+82ttlLw+p3Cw
	994pvdi3kRpLASO5WS02sfXZRjNWlqwOGAv/SlVomma9XyJuJyPpHPFIgUzmfVPFk2dB1Y8NM4Jo9
	2Nqz/Xt8J5xTYGMp+R4ezBLyNFQ2WYaODbjW+v2/YkgX+3YtyDKjoPn/J8JBR5V66IHr0ZRJJr1Fw
	coJDEOMp8xyRUIDaNcA5rXDQNwi6UjqkUA0Tf6ZfLN66I/GRpS2lQsAlFQkt3g1qIumt2J7Gpo+XR
	Wy6ZLb115CppxIIm2+9mmwrP+x8MTg/b8Qgxv3ngASxpx1CgIBDGM2u9otFLE+5GwvgbbaoTR5J0E
	8yD+SocNWcs8PU1z7sBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTssk-0000000Am7n-23Vf;
	Thu, 19 Nov 2026 03:32:18 +0000
Received: from va-1-115.ptr.blmpb.com ([209.127.230.115])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTssh-0000000Am76-0GjA
	for linux-nvme@lists.infradead.org;
	Thu, 19 Nov 2026 03:32:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1795059126; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=PJA8HI/26n09BDtdxwvrwKrlkq0uzVECslo8UM0vFOE=;
 b=pwIcxiyu58O8mtEa60Kd5PHF/aqExu1gO+sMih2b3/WHi55PHH/m53gFeaokF/bfpcURpa
 ibYacbeG4ja6S9EGC0mGjsgT7ACKfZpa8+pomwMnuCGkoo3++m3AA6AGJllBxAzl/BPpFq
 gbtSzE7Pl/ecLr5WSZucAqIT83ivSJlSRHaKbUggMiOSyL6BuB4gw8rwx2Xq+Ax9x0/VgP
 PLBx4ijd90kkfZHPm61rDtcCeKjTzTEI8QVPtZ86spKTrb5M9ykd+U36g2fO/TdrOGS1LB
 8yahnIZSdGAaneXpkt+jVH8/iH6n2FlV+VhilUllr4FC4UFlFfE3PG2lmzG+gg==
Message-Id: <e5de8bb4-6605-47f0-98f0-d7246602e566@bytedance.com>
X-Original-From: Fengnan <changfengnan@bytedance.com>
References: <20261013223543.395054-1-kbusch@meta.com> <16e8bc03-42c2-4bc8-bce9-dab49aad66b8@bytedance.com> <20261028150712.GA16374@lst.de> <auIRf1QATQjVDtkH@kbusch-mbp> <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.9ea1a2e5.340e.41d7.bbaa.69129ddcead9@bytedance.com> <8d42a690-79f7-4431-bffb-73decfc97dad@bytedance.com>
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
To: "Keith Busch" <kbusch@kernel.org>, "Christoph Hellwig" <hch@lst.de>
Subject: Re: [RFC PATCH 0/3] nvme-pci: dynamic interrupt moderation
In-Reply-To: <8d42a690-79f7-4431-bffb-73decfc97dad@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Cc: "Keith Busch" <kbusch@meta.com>, <linux-nvme@lists.infradead.org>, 
	<linux-pci@vger.kernel.org>, <tglx@kernel.org>, 
	<namjain@linux.microsoft.com>
From: "Fengnan" <changfengnan@bytedance.com>
Date: Thu, 19 Nov 2026 11:31:50 +0800
X-Lms-Return-Path: <lba+26afe6db4+9cd80c+lists.infradead.org+changfengnan@bytedance.com>
User-Agent: Mozilla Thunderbird
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_193215_171927_7B0F894D 
X-CRM114-Status: GOOD (  21.41  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=E5=9C=A8 02/11/26 20:22, Fengnan =E5=86=99=E9=81=93:

Hi Keith:

Any comments?

>=20
>=20
> =E5=9C=A8 29/10/26 10:14, changfengnan =E5=86=99=E9=81=93:
>>
>>> From: "Keith Busch"<kbusch@kernel.org>
>>> Date:=C2=A0 Wed, Oct 28, 2026, 23:15
>>> Subject:=C2=A0 Re: [RFC PATCH 0/3] nvme-pci: dynamic interrupt moderati=
on
>>> To: "Christoph Hellwig"<hch@lst.de>
>>> Cc: "Fengnan"<changfengnan@bytedance.com>, "Keith Busch"<kbusch@meta.co=
m>, <linux-nvme@lists.infradead.org>, <linux-pci@vger.kernel.org>, <tglx@ke=
rnel.org>, <namjain@linux.microsoft.com>
>>> On Wed, Oct 28, 2026 at 04:07:12PM +0100, Christoph Hellwig wrote:
>>>> On Thu, Oct 22, 2026 at 05:43:54PM +0800, Fengnan wrote:
>>>>> Hi Keith:
>>>>> =C2=A0
>>>>> I made some modifications to DIM and then implemented a solution
>>>>> using the DIM framework.=C2=A0
>>>>> Based on current testing, the results are now comparable to those of
>>>>> the previous patch.
>>>>> Here are the preliminary test results:
>>>>> https://docs.google.com/spreadsheets/d/1e8LQPnaDhmv50XlAM3XxI0TMQkhbk=
0bTZwlJP1Hzzdk/edit?gid=3D188992110#gid=3D188992110
>>>>> =C2=A0
>>>>> If you agree with this approach, I=E2=80=99ll continue testing and op=
timizing.
>>>> =C2=A0
>>>> =D0=86 can't speak for Keith, but I'd really love to see this going fo=
rward!
>>> =C2=A0
>>> Same! This is a great problem to solve, but I'm just sorry I don't have
>>> more cycles to work on the cause. I can quickly respin the msix noflush
>>> pre-patches to address the naming issues tglx mentioned, and we can tak=
e
>>> nvme in whichever direction has the best performance.
>>> =C2=A0
>>
>> That sounds good.
>> I'm currently working on continuously optimizing and testing both
>> approaches (using DIM and not using DIM).=C2=A0
>> I plan to update the code and add new data again next Monday.
>>
>> Thanks.
>=20
>=20
> Hi Keith and Christoph,
>=20
> I've prepared two implementations of adaptive IRQ polling: one reusing
> the DIM tuning state machine and one using an NVMe-specific policy.
>=20
> I tested both with a 158-case fio matrix and additional latency and
> CPU-contention tests. The results show broadly similar throughput gains
> over their respective OFF baselines in the tested workloads.
>=20
> Test data:
> [1] Non-DIM version:
> https://docs.google.com/spreadsheets/d/17kmXH9Zkr2jrN-19BwaInSx53HwOdRPJF=
rZ-Hjlk0_Y/edit?gid=3D300100#gid=3D300100
>=20
> [2] DIM version:
> https://docs.google.com/spreadsheets/d/18JADnBXWAGkffY_3LsPJ6ftA9DGH6qpNb=
KvP-lQWLnE/edit?gid=3D300200#gid=3D300200
>=20
> Both implementations are opt-in and choose between IRQ completion and
> timer-driven polling per I/O queue. They evaluate samples of at least
> 32,768 completions and use a target polling interval of 10 us. A polling
> trial must improve the completion rate by more than 1%. Once successful,
> polling can continue while its rate stays within roughly 1% of the saved
> IRQ baseline, subject to a completion-progress guard.
>=20
> Neither implementation uses I/O latency as a tuning metric.
>=20
> The non-DIM implementation uses explicit rules inside the NVMe driver.
> It admits polling trials at an IRQ completion rate of about 100k
> completions/s per queue and applies a fixed completion-count backoff
> after three consecutive failures.
>=20
> The DIM implementation uses IRQ and POLL as two profiles. It explores
> polling without that fixed admission threshold and requires a trial
> to gain more than both 1% and one completion/ms. While parked on IRQ,
> it increases the wait between trials from 1 to 2, 4, 8 and then 16 valid
> IRQ samples. It also discards stale samples and stops the polling timer
> when the queue drains.
>=20
> During development, I felt that the version with `dim` required more
> rules to achieve a similar effect. So, I still prefer the version
> without `dim` because it=E2=80=99s simpler, easier to understand, and eas=
ier
> to maintain.
>=20
> Which approach would you prefer?
>=20
>=20
> All the patches are in the attachment.

