Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32112C5AD5A
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2026 02:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Mime-Version:Cc
	:To:Date:References:In-Reply-To:From:Subject:Message-Id:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4kXCEfbHDVuicHoPrUxoAHISkQg4/onDqr6VHeLv72Y=; b=Q49JYfY37A8ZOKid2SE4AhgnDJ
	MH3qdb2Y+Ny2dcisBHxUwUtrtv074fCBDJ8o7YO+pE5JmgAL/KmGGQPH2InoQouaPalxxBEHPRYFN
	MSTtY7y0YqVDz53Hk/V5czGX3WJhEZs6ncCK7Z8DcEcyhGUweAzyGS0KM3fzMpCrcYHzKI/15AlqN
	AWN1YU7on828h2t+JoKsjQKk7ilx8PlhVSjlukTyeE5oHQObXPcqyW2Sz5tvzDqXFrTlVEEy5RfP/
	41C34ordwFYh5xT4WY0wOEunsHXCErOaLkeR59S8xiNGgCQ+JBU0PkEhK7M1kwjka/jX5Xwo3SvSf
	L9uNUSdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuKqw-0000000HG3K-40tw;
	Thu, 13 Aug 2026 02:07:30 +0000
Received: from va-1-114.ptr.blmpb.com ([209.127.230.114])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuKoZ-0000000HFyQ-0bGC
	for linux-nvme@lists.infradead.org;
	Thu, 13 Aug 2026 02:07:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1786586688; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=4kXCEfbHDVuicHoPrUxoAHISkQg4/onDqr6VHeLv72Y=;
 b=gHkf/sAtnRzaSXp6UIKA9lXcL6Q5X7wE68RytkC0Y7W3x9bdjh0J00hUFuoHwqi0h2GkuN
 Aoe+yLWa9yVuqYvnPTpFdnjPJ1xxLoY/qBMc8prYXFFSoPFUvk2nidNN0fId6Ml+8Ju0ps
 N33YX+AaXD/ttSuhNbJXhtYlNsp/3+gRWyaKtBPaYsvV0YKu3Y/6FrqKuUl8nFjHnjnHv4
 pGXfqApBNB94oL4WaxffTSUQGPT7ztBKytgTROdwQpgWafyBv4lO6i7ljnK24nfKrtv5xT
 6O5Adi0j5ZWKqMvPKCxSDxGqoPVoEXQWUuq12wMq7Q6HD9EsVRRuhNQtCC2PIg==
Message-Id: <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.e37ea0e4.7c8f.4611.9a59.a1a2f12c24fb@bytedance.com>
Subject: Re: [RESEND RFC PATCH v2] nvme-pci: add adaptive interrupt polling
From: "changfengnan" <changfengnan@bytedance.com>
In-Reply-To: <zn4sxqomlnqkegok3lg4zut5xvgbydkmg57xc66y4shyup25jo@t246msdeokl5>
X-Lms-Return-Path: <lba+16a7d263b+caa9ef+lists.infradead.org+changfengnan@bytedance.com>
References: <20260806031058.40176-1-changfengnan@bytedance.com>
	<zn4sxqomlnqkegok3lg4zut5xvgbydkmg57xc66y4shyup25jo@t246msdeokl5>
Date: Thu, 13 Aug 2026 10:04:39 +0800
To: "Anuj Gupta" <anuj1072538@gmail.com>
Cc: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>, 
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	"Guzebing" <guzebing@bytedance.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary=e177775af9a104a4b71ca470470481648a9dd8bea3e7d64532a5d86f6ae6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_190728_110438_165CF8AC 
X-CRM114-Status: GOOD (  47.25  )
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

--e177775af9a104a4b71ca470470481648a9dd8bea3e7d64532a5d86f6ae6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8


> From: "Anuj Gupta"<anuj1072538@gmail.com>
> Date:=C2=A0 Thu, Aug 13, 2026, 01:50
> Subject:=C2=A0 Re: [RESEND RFC PATCH v2] nvme-pci: add adaptive interrupt=
 polling
> To: "Fengnan Chang"<changfengnan@bytedance.com>
> Cc: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.=
me>, <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>, "Guz=
ebing"<guzebing@bytedance.com>
> On Thu, Aug 06, 2026 at 11:10:58AM +0800, Fengnan Chang wrote:
> > Each Solidigm SB5PH27X038T device used for testing can deliver about 3.=
2M
> > 4 KiB random-read IOPS. =C2=A0Four of them should be good for about 12.=
8M IOPS,
> > but interrupt-driven completion tops out at 5.59M, only about 44% of th=
at.
> >=C2=A0
> > Polling gets rid of that cost, but polling every queue all the time bur=
ns
> > CPU and hurts the sparse or bursty queues that interrupts handle just f=
ine.
> > So instead of a global switch, let each queue make the call on its own,
> > from how fast it has been completing lately, and re-check often enough =
that
> > the decision tracks the workload rather than a fixed tunable.
> >=C2=A0
> > Each queue runs a small loop with three stages. =C2=A0First it samples =
its
> > completion rate while still on interrupts. =C2=A0Only if that rate is h=
igh
> > enough to fill a small batch inside a bounded latency window does it ma=
sk
> > its own IRQ and start draining the CQ from a high-resolution timer, wit=
h
> > each wait sized to collect roughly one batch. =C2=A0It keeps polling as=
 long as
> > it keeps up with that rate; the moment it stalls or slows down it turns=
 the
> > IRQ back on and backs off, waiting longer the further behind it fell.
> > A queue that doesn't benefit drops back quickly and only gets retried o=
nce
> > in a while, so polling stays on the queues that are actually
> > interrupt-bound and everything else keeps running on the untouched IRQ
> > path.
> >=C2=A0
> > Measured with 4 KiB random reads on Solidigm SB5PH27X038T, adaptive on
> > versus off:
> >=C2=A0
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QD32 =C2=A0 =C2=A0 =
=C2=A0QD64 =C2=A0 =C2=A0 =C2=A0QD128
> > =C2=A0 one device, one job =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +1=
8.44% =C2=A0 +24.35% =C2=A0 +26.38%
> > =C2=A0 four devices, eight jobs =C2=A0 =C2=A0 =C2=A0 =C2=A0+83.76% =C2=
=A0 +99.02% =C2=A0 +96.26%
> >
>=C2=A0
> Did a quick test on single NVMe with QD64, one job, 4K random reads via
> io_uring, I see ~23% improvement: 569K -> 701K IOPS.
>=C2=A0
> Do you expect the fixed batch size, sample size, maximum delay, episode
> length, and backoff multiplier to work across devices with different
> latency profiles and across different workloads, or should these values
> somehow adapt to observed queue behavior?

Thank you for sharing the data. My goal is for these parameters to be
applicable to all disk and workload scenarios, but more testing is needed
in practice.
I=E2=80=99ve made some adjustments to the parameters and logic in the versi=
on
I=E2=80=99m currently developing, and it looks pretty good so far.

Attached is the version I'm currently developing. If you have time to take
a look or test it and offer some feedback, I'd really appreciate it.

>=C2=A0
> > +/*
> > + * Stop polling and turn the queue's IRQ back on. =C2=A0@elapsed is ho=
w long the
> > + * episode ran after it started falling behind, or 0 if it ended clean=
ly.
> > + * The bigger @elapsed is, the more completions we missed, and the lon=
ger we
> > + * wait before sampling this queue again, so a queue that polling does=
n't
> > + * help is left alone most of the time.
> > + */
>=C2=A0
> @elapsed is the total polling-episode duration, not the time since the
> queue fell behind. It is then used with the total completion count to
> estimate cumulative deficit. Could the comment be reworded accordingly?

Sorry, there are some issues with the comments in this version. I'll fix th=
em
in the next version.

>=C2=A0
> > +/*
> > + * Called from the IRQ handler after a reap that found something. =C2=
=A0If we're
> > + * still in backoff, just count it down. =C2=A0Otherwise time how long
> > + * NVME_ADAPTIVE_SAMPLE_CQES completions take to get the average gap b=
etween
> > + * them. =C2=A0If that looks worth polling (see the filter below) mask=
 the IRQ and
> > + * switch to poll mode; if not, leave the queue on interrupts.
> > + */
> > +static void nvme_adaptive_sample(struct nvme_queue *nvmeq,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int completions)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct nvme_adaptive_poll *adaptive =3D nv=
meq->adaptive;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int sample;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 delta, interval, now;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adaptive->retry_completions) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adaptive->=
retry_completions !=3D U64_MAX)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0adaptive->retry_completions -=3D min_t(u64, completions,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adaptive->retry_comple=
tions);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!adaptive->start_ns) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adaptive->star=
t_ns =3D ktime_get_ns();
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0adaptive->completions +=3D completions;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adaptive->completions < NVME_ADAPTIVE_=
SAMPLE_CQES)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0now =3D ktime_get_ns();
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0delta =3D now - adaptive->start_ns;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0sample =3D adaptive->completions;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0adaptive->start_ns =3D now;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0adaptive->completions =3D 0;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!delta || delta > (u64)NVME_ADAPTIVE_S=
AMPLE_CQES *
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NVME_ADAPTIVE_MAX_DELAY_NS)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Is this rate worth polling? =C2=A0The 1=
00/99 factor trims 1% off the gap so
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * a queue sitting right on the threshold =
isn't pulled in. =C2=A0Skip it if
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * it's too slow to fill a batch within MA=
X_DELAY, and also skip it if
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * it's already fast enough to batch by it=
self. =C2=A0The hardware's own
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * coalescing already handles that case, s=
o leave it on interrupts.
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0interval =3D div64_u64(delta * 100, sample=
 * 99);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!interval || interval > NVME_ADAPTIVE_=
MAX_DELAY_NS ||
>=C2=A0
> The comment says this rejects queues that cannot fill a target batch
> within MAX_DELAY, but this condition only checks whether one completion
> interval exceeds MAX_DELAY. Should this instead account for TARGET_BATCH
> or this comment is describing a different policy?

TARGET_BATCH will no longer be used in the next version.

>=C2=A0
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(delta > NSEC_PER_MSEC &&
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interval <=3D NVME_ADAPTIVE=
_MAX_DELAY_NS /
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 NVME_ADAPTIVE_TARGET_BATCH))
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> > +
>=C2=A0
> For a normal 256-CQE sample with an interval of 2us or less, delta will
> be about 512us or less, so the 1ms condition prevents this exclusion
> from firing. Is this intended to detect only samples that substantially
> overshoot 256 CQEs? If so, could the comment make that narrower intent
> explicit?

I did it that way before because I thought that if the interrupt mode could
process a CQE in 2 =CE=BCs, that would mean the interrupt mode was already =
very fast.
=C2=A0I=E2=80=99ve removed that check from the version I=E2=80=99m currentl=
y developing.
>=C2=A0

--e177775af9a104a4b71ca470470481648a9dd8bea3e7d64532a5d86f6ae6
Content-Disposition: attachment; filename="0001-nvme-pci-add-adaptive-interrupt-polling.patch"
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream; name="0001-nvme-pci-add-adaptive-interrupt-polling.patch"

RnJvbSBjM2Q5OTg5ZDk5YzkwMWFiZGUxMzk3NjUxODAxMzA5ZGYzZTExMzQ3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBGZW5nbmFuIENoYW5nIDxjaGFuZ2ZlbmduYW5AYnl0ZWRhbmNl
LmNvbT4KRGF0ZTogVHVlLCAxMSBBdWcgMjAyNiAyMDoyMjoyNyArMDgwMApTdWJqZWN0OiBbUEFU
Q0hdIG52bWUtcGNpOiBhZGQgYWRhcHRpdmUgaW50ZXJydXB0IHBvbGxpbmcKCkFkZCBvcHQtaW4g
YWRhcHRpdmUgcG9sbGluZyBmb3IgbnZtZSwgbWVhc3VyZSBhbiBJUlEKY29tcGxldGlvbi1yYXRl
IGJhc2VsaW5lIG92ZXIgODE5MiBDUUVzLCB0aGVuIGFkbWl0IGEgYm91bmRlZApwb2xsaW5nIHRy
aWFsIG9ubHkgd2hlbiB0aGUgb2JzZXJ2ZWQgcmF0ZSBjYW4gc3VzdGFpbiB0aGUgZml4ZWQKMTAg
dXMgcG9sbGluZyBwZXJpb2QuCgpTaWduZWQtb2ZmLWJ5OiBGZW5nbmFuIENoYW5nIDxjaGFuZ2Zl
bmduYW5AYnl0ZWRhbmNlLmNvbT4KLS0tCiBEb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2Zz
LW52bWUgfCAgMTUgKwogZHJpdmVycy9udm1lL2hvc3QvS2NvbmZpZyAgICAgICAgICAgIHwgICAx
ICsKIGRyaXZlcnMvbnZtZS9ob3N0L3BjaS5jICAgICAgICAgICAgICB8IDU2NCArKysrKysrKysr
KysrKysrKysrKysrKysrLS0KIDMgZmlsZXMgY2hhbmdlZCwgNTU0IGluc2VydGlvbnMoKyksIDI2
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lz
ZnMtbnZtZSBiL0RvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtbnZtZQppbmRleCA0OTlk
NWY4NDNjZDQzLi4zMDlkNTlkYzZiODcyIDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9uL0FCSS90
ZXN0aW5nL3N5c2ZzLW52bWUKKysrIGIvRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1u
dm1lCkBAIC0xMSwzICsxMSwxOCBAQCBEZXNjcmlwdGlvbjoKIAkJKFJFUExBQ0VUTFNQU0spIHdp
dGggdGhlIHRhcmdldC4gQWZ0ZXIgYSByZWF1dGhlbnRpY2F0aW9uCiAJCXRoZSB2YWx1ZSByZXR1
cm5lZCBieSB0bHNfY29uZmlndXJlZF9rZXkgd2lsbCBiZSB0aGUgbmV3CiAJCXNlcmlhbC4KKwor
V2hhdDoJCS9zeXMvY2xhc3MvbnZtZS9udm1lWC9hZGFwdGl2ZV9pcnFfcG9sbGluZworRGF0ZToJ
CUF1Z3VzdCAyMDI2CitLZXJuZWxWZXJzaW9uOgk3LjIKK0NvbnRhY3Q6CUxpbnV4IE5WTWUgbWFp
bGluZyBsaXN0IDxsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmc+CitEZXNjcmlwdGlvbjoK
KwkJRW5hYmxlICgxKSBvciBkaXNhYmxlICgwKSBhZGFwdGl2ZSBJUlEgcG9sbGluZyBvbiBlbGln
aWJsZSBJL08KKwkJcXVldWVzIG9mIG9uZSBQQ0kgTlZNZSBjb250cm9sbGVyLiAgQ2hhbmdpbmcg
dGhlIG1vZGUgZnJlZXplcyBpdHMKKwkJbmFtZXNwYWNlIHJlcXVlc3QgcXVldWVzIGFuZCB3YWl0
cyBmb3IgYWxsIG91dHN0YW5kaW5nIG5hbWVzcGFjZSBJL08KKwkJdG8gY29tcGxldGUgYmVmb3Jl
IHVwZGF0aW5nIHRoZSBxdWV1ZSBJUlEgc3RhdGUuICBXcml0ZXMgZmFpbCB3aXRoCisJCUVCVVNZ
IHVubGVzcyB0aGUgY29udHJvbGxlciBpcyBsaXZlLgorCisJCVRoZSBhdHRyaWJ1dGUgaXMgbm90
IGF2YWlsYWJsZSB3aXRoIHRocmVhZGVkIE5WTWUgaW50ZXJydXB0cy4gIFRoZQorCQl1c2VfYWRh
cHRpdmVfaXJxX3BvbGxpbmcgbW9kdWxlIHBhcmFtZXRlciBzdXBwbGllcyBvbmx5IHRoZSBpbml0
aWFsCisJCXZhbHVlIGZvciBuZXdseSBwcm9iZWQgY29udHJvbGxlcnMuCmRpZmYgLS1naXQgYS9k
cml2ZXJzL252bWUvaG9zdC9LY29uZmlnIGIvZHJpdmVycy9udm1lL2hvc3QvS2NvbmZpZwppbmRl
eCAzMTk3NGM3ZGQyMGM5Li4yMjE2NGI5MDFkYTg1IDEwMDY0NAotLS0gYS9kcml2ZXJzL252bWUv
aG9zdC9LY29uZmlnCisrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L0tjb25maWcKQEAgLTUsNiArNSw3
IEBAIGNvbmZpZyBOVk1FX0NPUkUKIGNvbmZpZyBCTEtfREVWX05WTUUKIAl0cmlzdGF0ZSAiTlZN
IEV4cHJlc3MgYmxvY2sgZGV2aWNlIgogCWRlcGVuZHMgb24gUENJICYmIEJMT0NLCisJc2VsZWN0
IElSUV9QT0xMCiAJc2VsZWN0IE5WTUVfQ09SRQogCWhlbHAKIAkgIFRoZSBOVk0gRXhwcmVzcyBk
cml2ZXIgaXMgZm9yIHNvbGlkIHN0YXRlIGRyaXZlcyBkaXJlY3RseQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9udm1lL2hvc3QvcGNpLmMgYi9kcml2ZXJzL252bWUvaG9zdC9wY2kuYwppbmRleCA2OTkz
MmQ2NDBiNTM3Li5iNTYwMjc4MjQ3ZDFhIDEwMDY0NAotLS0gYS9kcml2ZXJzL252bWUvaG9zdC9w
Y2kuYworKysgYi9kcml2ZXJzL252bWUvaG9zdC9wY2kuYwpAQCAtMTAsOSArMTAsMTIgQEAKICNp
bmNsdWRlIDxsaW51eC9ibGstbXEtZG1hLmg+CiAjaW5jbHVkZSA8bGludXgvYmxrLWludGVncml0
eS5oPgogI2luY2x1ZGUgPGxpbnV4L2RtaS5oPgorI2luY2x1ZGUgPGxpbnV4L2hydGltZXIuaD4K
ICNpbmNsdWRlIDxsaW51eC9pbml0Lmg+CiAjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+CiAj
aW5jbHVkZSA8bGludXgvaW8uaD4KKyNpbmNsdWRlIDxsaW51eC9pcnFfcG9sbC5oPgorI2luY2x1
ZGUgPGxpbnV4L2t0aW1lLmg+CiAjaW5jbHVkZSA8bGludXgva3N0cnRveC5oPgogI2luY2x1ZGUg
PGxpbnV4L21lbXJlbWFwLmg+CiAjaW5jbHVkZSA8bGludXgvbW0uaD4KQEAgLTgyLDYgKzg1LDQy
IEBAIHN0cnVjdCBxdWlya19lbnRyeSB7CiBzdGF0aWMgaW50IHVzZV90aHJlYWRlZF9pbnRlcnJ1
cHRzOwogbW9kdWxlX3BhcmFtKHVzZV90aHJlYWRlZF9pbnRlcnJ1cHRzLCBpbnQsIDA0NDQpOwog
CitzdGF0aWMgYm9vbCB1c2VfYWRhcHRpdmVfaXJxX3BvbGxpbmc7Cittb2R1bGVfcGFyYW0odXNl
X2FkYXB0aXZlX2lycV9wb2xsaW5nLCBib29sLCAwNDQ0KTsKK01PRFVMRV9QQVJNX0RFU0ModXNl
X2FkYXB0aXZlX2lycV9wb2xsaW5nLAorCQkgImRlZmF1bHQgYWRhcHRpdmUgcG9sbGluZyBtb2Rl
IGZvciBub24tdGhyZWFkZWQgTVNJLVggSS9PIHF1ZXVlcyIpOworCisvKgorICogQWRhcHRpdmUg
SVJRIHBvbGxpbmcgbW92ZXMgYW4gZWxpZ2libGUgaW50ZXJydXB0LWRyaXZlbiBxdWV1ZSB0byBh
CisgKiB0aW1lci1iYXNlZCBwb2xsIHBhdGggYWNjb3JkaW5nIHRvIGl0cyBvYnNlcnZlZCBjb21w
bGV0aW9uIHJhdGUuICBFYWNoCisgKiBxdWV1ZSBnb2VzIHRocm91Z2ggdGhyZWUgc3RhZ2VzOgor
ICoKKyAqICAxLiBCYXNlbGluZSAoc3RpbGwgaW4gSVJRIG1vZGUpOiBtZWFzdXJlIGNvbXBsZXRp
b24gdGhyb3VnaHB1dCBvdmVyIG9uZQorICogICAgIE5WTUVfQURBUFRJVkVfRVBJU09ERV9DUUVT
IHdpbmRvdy4gIFRyaWFsIHBvbGxpbmcgb25seSB3aGlsZSB0aGUgYXZlcmFnZQorICogICAgIGNv
bXBsZXRpb24gZ2FwIGlzIHNob3J0IGVub3VnaCB0aGF0IGEgcG9sbCBmaXJlZCBvbmNlIHBlcgor
ICogICAgIE5WTUVfQURBUFRJVkVfUE9MTF9QRVJJT0RfTlMgd291bGQgc3RpbGwgZmluZCBhIGNv
bXBsZXRpb24uCisgKiAgMi4gVHJpYWw6IG1hc2sgdGhlIHF1ZXVlJ3MgSVJRIGFuZCBkcmFpbiB0
aGUgQ1EgZnJvbSBhbiBocnRpbWVyIGV2ZXJ5CisgKiAgICAgTlZNRV9BREFQVElWRV9QT0xMX1BF
UklPRF9OUy4gIFJlamVjdCB0aGUgdHJpYWwgaW1tZWRpYXRlbHkgaWYgaXRzCisgKiAgICAgY3Vt
dWxhdGl2ZSBjb21wbGV0aW9uIHJhdGUgZmFsbHMgYmVoaW5kIHRoZSBJUlEgYmFzZWxpbmUuICBB
dCB0aGUgZW5kCisgKiAgICAgb2YgYSBmdWxsIGNvbXBsZXRpb24gd2luZG93LCBhY2NlcHQgcG9s
bGluZyBvbmx5IGlmIGl0cyB0aHJvdWdocHV0IGlzCisgKiAgICAgc3RyaWN0bHkgaGlnaGVyIHRo
YW4gdGhlIElSUSBiYXNlbGluZS4KKyAqICAzLiBQYXJrIG9yIGJhY2sgb2ZmOiBrZWVwIGFuIGFj
Y2VwdGVkIHF1ZXVlIGluIHBvbGxpbmcgbW9kZSwgcmVjaGVjayBlYWNoCisgKiAgICAgY29tcGxl
dGlvbiB3aW5kb3csIGFuZCBwZXJpb2RpY2FsbHkgcmV0dXJuIHRvIElSUSBtb2RlIGZvciBhIGZy
ZXNoCisgKiAgICAgYmFzZWxpbmUuICBBIHJlamVjdGVkIG9yIHNsb3dpbmcgcXVldWUgbWF5IHJl
dHJ5IHR3aWNlOyB0aHJlZSBjb25zZWN1dGl2ZQorICogICAgIGZhaWx1cmVzIHRyaWdnZXIgYSBs
b25nLCBjb21wbGV0aW9uLWNvdW50ZWQgYmFja29mZi4gIFRoaXMgbGV0cyBhCisgKiAgICAgcHJv
Zml0YWJsZSBxdWV1ZSBnZXQgcGFzdCBhIG5vaXN5IGZpcnN0IHRyaWFsIHdpdGhvdXQgbWFraW5n
IGZhaWxlZAorICogICAgIHRyaWFscyBhIG1lYXN1cmFibGUgcGFydCBvZiB3b3JrbG9hZHMgd2hl
cmUgSVJRcyBhcmUgZmFzdGVyLgorICoKKyAqIFRoZSBwb2xsIHBlcmlvZCBib3VuZHMgdGhlIGV4
dHJhIGNvbXBsZXRpb24gbGF0ZW5jeSBwb2xsaW5nIG1heSBhZGQgYW5kCisgKiBkZWZpbmVzIHRo
ZSBhZG1pc3Npb24gcmF0ZSBhYm92ZS4gIFRoZSBjb21wbGV0aW9uLWNvdW50ZWQgd2luZG93cyBt
YWtlIHRoZQorICogY29tcGFyaXNvbiBhbmQgcmV0cnkgZHV0eSBjeWNsZSBpbmRlcGVuZGVudCBv
ZiB3YWxsLWNsb2NrIGxvYWQgY2hhbmdlcy4KKyAqLworI2RlZmluZSBOVk1FX0FEQVBUSVZFX1RB
UkdFVF9CQVRDSAk1VQorI2RlZmluZSBOVk1FX0FEQVBUSVZFX1BPTExfUEVSSU9EX05TCSgxMFUg
KiBOU0VDX1BFUl9VU0VDKQorI2RlZmluZSBOVk1FX0FEQVBUSVZFX0VQSVNPREVfQ1FFUwk4MTky
VQorI2RlZmluZSBOVk1FX0FEQVBUSVZFX1JFRVZBTF9DUUVTCSg2NFUgKiBOVk1FX0FEQVBUSVZF
X0VQSVNPREVfQ1FFUykKKyNkZWZpbmUgTlZNRV9BREFQVElWRV9QT0xMX1JFVFJJRVMJMlUKKwog
c3RhdGljIGJvb2wgdXNlX2NtYl9zcWVzID0gdHJ1ZTsKIG1vZHVsZV9wYXJhbSh1c2VfY21iX3Nx
ZXMsIGJvb2wsIDA0NDQpOwogTU9EVUxFX1BBUk1fREVTQyh1c2VfY21iX3NxZXMsICJ1c2UgY29u
dHJvbGxlcidzIG1lbW9yeSBidWZmZXIgZm9yIEkvTyBTUWVzIik7CkBAIC0zMDcsNiArMzQ2LDcg
QEAgc3RydWN0IG52bWVfZGV2IHsKIAl2b2lkIF9faW9tZW0gKmJhcjsKIAl1bnNpZ25lZCBsb25n
IGJhcl9tYXBwZWRfc2l6ZTsKIAlzdHJ1Y3QgbXV0ZXggc2h1dGRvd25fbG9jazsKKwlib29sIGFk
YXB0aXZlX2lycV9wb2xsaW5nOwogCWJvb2wgc3Vic3lzdGVtOwogCXU2NCBjbWJfc2l6ZTsKIAli
b29sIGNtYl91c2Vfc3FlczsKQEAgLTM1OCw2ICszOTgsMjIgQEAgc3RhdGljIGlubGluZSBzdHJ1
Y3QgbnZtZV9kZXYgKnRvX252bWVfZGV2KHN0cnVjdCBudm1lX2N0cmwgKmN0cmwpCiAJcmV0dXJu
IGNvbnRhaW5lcl9vZihjdHJsLCBzdHJ1Y3QgbnZtZV9kZXYsIGN0cmwpOwogfQogCisvKgorICog
QWxsb2NhdGVkIG9ubHkgZm9yIGludGVycnVwdCBxdWV1ZXMgdGhhdCBjYW4gcG9sbCBhZGFwdGl2
ZWx5LiAgY3FfcG9sbF9sb2NrCisgKiBzZXJpYWxpemVzIHRoaXMgc3RhdGUgYW5kIENRIGFjY2Vz
cyBiZXR3ZWVuIHRoZSBJUlEgYW5kIHRpbWVyIHBvbGwgcGF0aHMuCisgKi8KK3N0cnVjdCBudm1l
X2FkYXB0aXZlX3BvbGwgeworCXN0cnVjdCBocnRpbWVyIHRpbWVyOwkJLyogZmlyZXMgdGhlIG5l
eHQgcG9sbCBkcmFpbiAqLworCXN0cnVjdCBpcnFfcG9sbCBpb3BvbGw7CQkvKiBzb2Z0aXJxIGNv
bnRleHQgZm9yIHRoZSBkcmFpbiAqLworCXN0cnVjdCBudm1lX3F1ZXVlICpudm1lcTsKKwl1NjQg
c3RhcnRfbnM7CQkJLyogd2hlbiB0aGUgY3VycmVudCBzYW1wbGUvZXBpc29kZSBzdGFydGVkICov
CisJdTMyIHJldHJ5X2NvbXBsZXRpb25zOwkJLyogY29tcGxldGlvbnMgdW50aWwgcmV0cnkgb3Ig
SVJRIHJlYmFzZWxpbmUgKi8KKwl1MzIgaW50ZXJ2YWxfbnM7CQkvKiBzYW1wbGVkIGF2ZXJhZ2Ug
Z2FwIGJldHdlZW4gY29tcGxldGlvbnMgKi8KKwl1MzIgY29tcGxldGlvbnM7CQkvKiBjb21wbGV0
aW9ucyBzZWVuIHNvIGZhciB0aGlzIHNhbXBsZS9lcGlzb2RlICovCisJaW50IGlycTsKKwl1OCBw
b2xsX2ZhaWx1cmVzOwkJLyogY29uc2VjdXRpdmUgcmVqZWN0ZWQgcG9sbGluZyB0cmlhbHMgKi8K
K307CisKIC8qCiAgKiBBbiBOVk0gRXhwcmVzcyBxdWV1ZS4gIEVhY2ggZGV2aWNlIGhhcyBhdCBs
ZWFzdCB0d28gKG9uZSBmb3IgYWRtaW4KICAqIGNvbW1hbmRzIGFuZCBvbmUgZm9yIEkvTyBjb21t
YW5kcykuCkBAIC0zNjcsNyArNDIzLDggQEAgc3RydWN0IG52bWVfcXVldWUgewogCXN0cnVjdCBu
dm1lX2Rlc2NyaXB0b3JfcG9vbHMgZGVzY3JpcHRvcl9wb29sczsKIAlzcGlubG9ja190IHNxX2xv
Y2s7CiAJdm9pZCAqc3FfY21kczsKLQkgLyogb25seSB1c2VkIGZvciBwb2xsIHF1ZXVlczogKi8K
KwlzdHJ1Y3QgbnZtZV9hZGFwdGl2ZV9wb2xsICphZGFwdGl2ZTsKKwkvKiBVc2VkIGZvciBib3Ro
IHBvbGwgcXVldWVzIGFuZCBhZGFwdGl2ZSBpbnRlcnJ1cHQgcG9sbGluZy4gKi8KIAlzcGlubG9j
a190IGNxX3BvbGxfbG9jayBfX19fY2FjaGVsaW5lX2FsaWduZWRfaW5fc21wOwogCXN0cnVjdCBu
dm1lX2NvbXBsZXRpb24gKmNxZXM7CiAJZG1hX2FkZHJfdCBzcV9kbWFfYWRkcjsKQEAgLTM4Niw2
ICs0NDMsOSBAQCBzdHJ1Y3QgbnZtZV9xdWV1ZSB7CiAjZGVmaW5lIE5WTUVRX1NRX0NNQgkJMQog
I2RlZmluZSBOVk1FUV9ERUxFVEVfRVJST1IJMgogI2RlZmluZSBOVk1FUV9QT0xMRUQJCTMKKyNk
ZWZpbmUgTlZNRVFfQURBUFRJVkVfUE9MTElORwk0CisjZGVmaW5lIE5WTUVRX0FEQVBUSVZFX0VO
QUJMRUQJNQorI2RlZmluZSBOVk1FUV9BREFQVElWRV9TVEFMRV9JUlEJNgogCV9fbGUzMiAqZGJi
dWZfc3FfZGI7CiAJX19sZTMyICpkYmJ1Zl9jcV9kYjsKIAlfX2xlMzIgKmRiYnVmX3NxX2VpOwpA
QCAtMTYwNiwxMyArMTY2NiwxMiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgbnZtZV91cGRhdGVfY3Ff
aGVhZChzdHJ1Y3QgbnZtZV9xdWV1ZSAqbnZtZXEpCiAJfQogfQogCi1zdGF0aWMgaW5saW5lIGJv
b2wgbnZtZV9wb2xsX2NxKHN0cnVjdCBudm1lX3F1ZXVlICpudm1lcSwKLQkJCSAgICAgICAgc3Ry
dWN0IGlvX2NvbXBfYmF0Y2ggKmlvYikKK3N0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IG52bWVf
cG9sbF9jcShzdHJ1Y3QgbnZtZV9xdWV1ZSAqbnZtZXEsCisJCQkJCXN0cnVjdCBpb19jb21wX2Jh
dGNoICppb2IpCiB7Ci0JYm9vbCBmb3VuZCA9IGZhbHNlOworCXVuc2lnbmVkIGludCBmb3VuZCA9
IDA7CiAKIAl3aGlsZSAobnZtZV9jcWVfcGVuZGluZyhudm1lcSkpIHsKLQkJZm91bmQgPSB0cnVl
OwogCQkvKgogCQkgKiBsb2FkLWxvYWQgY29udHJvbCBkZXBlbmRlbmN5IGJldHdlZW4gcGhhc2Ug
YW5kIHRoZSByZXN0IG9mCiAJCSAqIHRoZSBjcWUgcmVxdWlyZXMgYSBmdWxsIHJlYWQgbWVtb3J5
IGJhcnJpZXIKQEAgLTE2MjAsNiArMTY3OSw3IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBudm1lX3Bv
bGxfY3Eoc3RydWN0IG52bWVfcXVldWUgKm52bWVxLAogCQlkbWFfcm1iKCk7CiAJCW52bWVfaGFu
ZGxlX2NxZShudm1lcSwgaW9iLCBudm1lcS0+Y3FfaGVhZCk7CiAJCW52bWVfdXBkYXRlX2NxX2hl
YWQobnZtZXEpOworCQlmb3VuZCsrOwogCX0KIAogCWlmIChmb3VuZCkKQEAgLTE2MjcsMTcgKzE2
ODcsMjIgQEAgc3RhdGljIGlubGluZSBib29sIG52bWVfcG9sbF9jcShzdHJ1Y3QgbnZtZV9xdWV1
ZSAqbnZtZXEsCiAJcmV0dXJuIGZvdW5kOwogfQogCi1zdGF0aWMgaXJxcmV0dXJuX3QgbnZtZV9p
cnEoaW50IGlycSwgdm9pZCAqZGF0YSkKKy8qIEtlZXAgdGhlIG5vcm1hbCBjb21wbGV0aW9uIGxv
b3AgYnJhbmNoLWZyZWUuICovCitzdGF0aWMgdW5zaWduZWQgaW50IG52bWVfcG9sbF9jcV9ib3Vu
ZGVkKHN0cnVjdCBudm1lX3F1ZXVlICpudm1lcSwKKwkJCQkJIHN0cnVjdCBpb19jb21wX2JhdGNo
ICppb2IsCisJCQkJCSB1bnNpZ25lZCBpbnQgbGltaXQpCiB7Ci0Jc3RydWN0IG52bWVfcXVldWUg
Km52bWVxID0gZGF0YTsKLQlERUZJTkVfSU9fQ09NUF9CQVRDSChpb2IpOworCXVuc2lnbmVkIGlu
dCBmb3VuZCA9IDA7CiAKLQlpZiAobnZtZV9wb2xsX2NxKG52bWVxLCAmaW9iKSkgewotCQlpZiAo
IXJxX2xpc3RfZW1wdHkoJmlvYi5yZXFfbGlzdCkpCi0JCQludm1lX3BjaV9jb21wbGV0ZV9iYXRj
aCgmaW9iKTsKLQkJcmV0dXJuIElSUV9IQU5ETEVEOworCXdoaWxlIChmb3VuZCA8IGxpbWl0ICYm
IG52bWVfY3FlX3BlbmRpbmcobnZtZXEpKSB7CisJCWRtYV9ybWIoKTsKKwkJbnZtZV9oYW5kbGVf
Y3FlKG52bWVxLCBpb2IsIG52bWVxLT5jcV9oZWFkKTsKKwkJbnZtZV91cGRhdGVfY3FfaGVhZChu
dm1lcSk7CisJCWZvdW5kKys7CiAJfQotCXJldHVybiBJUlFfTk9ORTsKKwlpZiAoZm91bmQpCisJ
CW52bWVfcmluZ19jcV9kb29yYmVsbChudm1lcSk7CisJcmV0dXJuIGZvdW5kOwogfQogCiBzdGF0
aWMgaXJxcmV0dXJuX3QgbnZtZV9pcnFfY2hlY2soaW50IGlycSwgdm9pZCAqZGF0YSkKQEAgLTE2
NDksNiArMTcxNCwyNjIgQEAgc3RhdGljIGlycXJldHVybl90IG52bWVfaXJxX2NoZWNrKGludCBp
cnEsIHZvaWQgKmRhdGEpCiAJcmV0dXJuIElSUV9OT05FOwogfQogCitzdGF0aWMgdm9pZCBudm1l
X2FkYXB0aXZlX3N0YXRlX3Jlc2V0KHN0cnVjdCBudm1lX2FkYXB0aXZlX3BvbGwgKmFkYXB0aXZl
KQoreworCWFkYXB0aXZlLT5zdGFydF9ucyA9IDA7CisJYWRhcHRpdmUtPnJldHJ5X2NvbXBsZXRp
b25zID0gMDsKKwlhZGFwdGl2ZS0+aW50ZXJ2YWxfbnMgPSAwOworCWFkYXB0aXZlLT5jb21wbGV0
aW9ucyA9IDA7CisJYWRhcHRpdmUtPnBvbGxfZmFpbHVyZXMgPSAwOworfQorCisvKgorICogU3Rv
cCBwb2xsaW5nIGFuZCB0dXJuIHRoZSBxdWV1ZSdzIElSUSBiYWNrIG9uLiAgUmV0cnkgdHdvIHJl
amVjdGVkIHRyaWFscworICogcHJvbXB0bHkgc28gYSBub2lzeSB0cmFuc2l0aW9uIGRvZXMgbm90
IGhpZGUgYSBwcm9maXRhYmxlIHN0YXRlOyB0aHJlZQorICogY29uc2VjdXRpdmUgZmFpbHVyZXMg
dXNlIGEgbG9uZyBJUlEgYmFja29mZiBiZWZvcmUgYW5vdGhlciBiYXNlbGluZS4gIFRoZQorICog
cmVzdWx0aW5nIGxvdyByZXRyeSBkdXR5IGN5Y2xlIHByZXZlbnRzIGZhaWxlZCB0cmlhbHMgZnJv
bSByZWR1Y2luZworICogc3RlYWR5LXN0YXRlIElSUSB0aHJvdWdocHV0LiAgQ2FsbGVkIHdpdGgg
Y3FfcG9sbF9sb2NrIGhlbGQuCisgKi8KK3N0YXRpYyB2b2lkIG52bWVfYWRhcHRpdmVfcG9sbF9l
bmQoc3RydWN0IG52bWVfcXVldWUgKm52bWVxLCBib29sIGJhY2tvZmYpCit7CisJc3RydWN0IG52
bWVfYWRhcHRpdmVfcG9sbCAqYWRhcHRpdmUgPSBudm1lcS0+YWRhcHRpdmU7CisJdTggcG9sbF9m
YWlsdXJlcyA9IGFkYXB0aXZlLT5wb2xsX2ZhaWx1cmVzOworCisJbnZtZV9hZGFwdGl2ZV9zdGF0
ZV9yZXNldChhZGFwdGl2ZSk7CisJaWYgKGJhY2tvZmYpIHsKKwkJaWYgKHBvbGxfZmFpbHVyZXMg
PCBOVk1FX0FEQVBUSVZFX1BPTExfUkVUUklFUykKKwkJCWFkYXB0aXZlLT5wb2xsX2ZhaWx1cmVz
ID0gcG9sbF9mYWlsdXJlcyArIDE7CisJCWVsc2UKKwkJCWFkYXB0aXZlLT5yZXRyeV9jb21wbGV0
aW9ucyA9CisJCQkJTlZNRV9BREFQVElWRV9SRUVWQUxfQ1FFUzsKKwl9CisJY2xlYXJfYml0KE5W
TUVRX0FEQVBUSVZFX1BPTExJTkcsICZudm1lcS0+ZmxhZ3MpOworCXNldF9iaXQoTlZNRVFfQURB
UFRJVkVfU1RBTEVfSVJRLCAmbnZtZXEtPmZsYWdzKTsKKwllbmFibGVfaXJxKGFkYXB0aXZlLT5p
cnEpOworfQorCitzdGF0aWMgdm9pZCBudm1lX2FkYXB0aXZlX3BvbGxfd2luZG93X3N0YXJ0KHN0
cnVjdCBudm1lX2FkYXB0aXZlX3BvbGwgKmFkYXB0aXZlLAorCQkJCQkgICAgdTY0IG5vdykKK3sK
KwlhZGFwdGl2ZS0+c3RhcnRfbnMgPSBub3c7CisJYWRhcHRpdmUtPmNvbXBsZXRpb25zID0gMDsK
K30KKworLyoKKyAqIEZpcmUgdGhlIG5leHQgcG9sbCBvbmUgZml4ZWQgcGVyaW9kIGZyb20gbm93
LiAgQSBwZXItcXVldWUgY2FkZW5jZSBpcyBub3QKKyAqIG5lZWRlZDogdGhlIGN1bXVsYXRpdmUt
cmF0ZSBjaGVjayBiZWxvdyBrZWVwcyBhIHF1ZXVlIGluIHBvbGwgbW9kZSBvbmx5CisgKiB3aGls
ZSBpdCBzdGF5cyBmYXN0ZXIgdGhhbiBpdHMgc2FtcGxlZCBJUlEgcmF0ZSwgYW5kIGEgZml4ZWQg
cGVyaW9kIGJvdW5kcworICogdGhlIGNvbXBsZXRpb24gbGF0ZW5jeSBwb2xsaW5nIG1heSBhZGQu
ICBBbmNob3IgdGhlIHRpbWVyIHRvIHRoZSBjYWxsZXIncworICogIm5vdyIgc28gcGVyLXBvbGwg
cHJvY2Vzc2luZyB0aW1lIGRvZXMgbm90IHN0cmV0Y2ggdGhlIGVmZmVjdGl2ZSBwZXJpb2QuCisg
Ki8KK3N0YXRpYyB2b2lkIG52bWVfYWRhcHRpdmVfYXJtKHN0cnVjdCBudm1lX2FkYXB0aXZlX3Bv
bGwgKmFkYXB0aXZlLCB1NjQgbm93KQoreworCWhydGltZXJfc3RhcnQoJmFkYXB0aXZlLT50aW1l
ciwKKwkJICAgICAgbnNfdG9fa3RpbWUobm93ICsgTlZNRV9BREFQVElWRV9QT0xMX1BFUklPRF9O
UyksCisJCSAgICAgIEhSVElNRVJfTU9ERV9BQlNfUElOTkVEX0hBUkQpOworfQorCitzdGF0aWMg
ZW51bSBocnRpbWVyX3Jlc3RhcnQgbnZtZV9hZGFwdGl2ZV9wb2xsX3RpbWVyKHN0cnVjdCBocnRp
bWVyICp0aW1lcikKK3sKKwlzdHJ1Y3QgbnZtZV9hZGFwdGl2ZV9wb2xsICphZGFwdGl2ZSA9IGNv
bnRhaW5lcl9vZih0aW1lciwKKwkJCQkJc3RydWN0IG52bWVfYWRhcHRpdmVfcG9sbCwgdGltZXIp
OworCXN0cnVjdCBudm1lX3F1ZXVlICpudm1lcSA9IGFkYXB0aXZlLT5udm1lcTsKKworCWlmICh0
ZXN0X2JpdChOVk1FUV9BREFQVElWRV9QT0xMSU5HLCAmbnZtZXEtPmZsYWdzKSkKKwkJaXJxX3Bv
bGxfc2NoZWQoJmFkYXB0aXZlLT5pb3BvbGwpOworCXJldHVybiBIUlRJTUVSX05PUkVTVEFSVDsK
K30KKworLyoKKyAqIFRoZSBwb2xsIGRyYWluLCBydW4gZnJvbSBzb2Z0aXJxIHdoZW4gdGhlIHRp
bWVyIGZpcmVzLiAgUmVhcCBzb21lIENRRXMsIHRoZW4KKyAqIHBpY2sgb25lIG9mIHRocmVlIHRo
aW5nczogc3RvcCBpZiB3ZSBoaXQgdGhlIGVwaXNvZGUgY2FwLCB3YWl0IGFnYWluIGlmIHRoZQor
ICogcXVldWUgaXMga2VlcGluZyB1cCwgb3IgZ28gYmFjayB0byBJUlEgbW9kZSBpZiBpdCB3ZW50
IGlkbGUgb3Igc2xvd2VkIGRvd24uCisgKi8KK3N0YXRpYyBpbnQgbnZtZV9hZGFwdGl2ZV9pcnFf
cG9sbChzdHJ1Y3QgaXJxX3BvbGwgKmlvcCwgaW50IGJ1ZGdldCkKK3sKKwlzdHJ1Y3QgbnZtZV9h
ZGFwdGl2ZV9wb2xsICphZGFwdGl2ZSA9IGNvbnRhaW5lcl9vZihpb3AsCisJCQkJCXN0cnVjdCBu
dm1lX2FkYXB0aXZlX3BvbGwsIGlvcG9sbCk7CisJc3RydWN0IG52bWVfcXVldWUgKm52bWVxID0g
YWRhcHRpdmUtPm52bWVxOworCXVuc2lnbmVkIGludCBjb21wbGV0aW9ucywgbGltaXQ7CisJdW5z
aWduZWQgbG9uZyBmbGFnczsKKwl1NjQgZGVhZGxpbmUsIGVsYXBzZWQsIG5vdzsKKwlERUZJTkVf
SU9fQ09NUF9CQVRDSChpb2IpOworCisJc3Bpbl9sb2NrX2lycXNhdmUoJm52bWVxLT5jcV9wb2xs
X2xvY2ssIGZsYWdzKTsKKwlpZiAodW5saWtlbHkoIXRlc3RfYml0KE5WTUVRX0FEQVBUSVZFX1BP
TExJTkcsICZudm1lcS0+ZmxhZ3MpKSkgeworCQljb21wbGV0aW9ucyA9IDA7CisJCWlycV9wb2xs
X2NvbXBsZXRlKGlvcCk7CisJCWdvdG8gb3V0OworCX0KKwlpZiAoIXRlc3RfYml0KE5WTUVRX0VO
QUJMRUQsICZudm1lcS0+ZmxhZ3MpKSB7CisJCWNvbXBsZXRpb25zID0gMDsKKwkJaXJxX3BvbGxf
Y29tcGxldGUoaW9wKTsKKwkJbnZtZV9hZGFwdGl2ZV9wb2xsX2VuZChudm1lcSwgZmFsc2UpOwor
CQlnb3RvIG91dDsKKwl9CisKKwlsaW1pdCA9IG1pbl90KHVuc2lnbmVkIGludCwKKwkJICAgICAg
YnVkZ2V0LAorCQkgICAgICBOVk1FX0FEQVBUSVZFX0VQSVNPREVfQ1FFUyAtIGFkYXB0aXZlLT5j
b21wbGV0aW9ucyk7CisJY29tcGxldGlvbnMgPSBudm1lX3BvbGxfY3FfYm91bmRlZChudm1lcSwg
JmlvYiwgbGltaXQpOworCWFkYXB0aXZlLT5jb21wbGV0aW9ucyArPSBjb21wbGV0aW9uczsKKwor
CWlmIChjb21wbGV0aW9ucyA+PSBidWRnZXQgJiYKKwkgICAgYWRhcHRpdmUtPmNvbXBsZXRpb25z
IDwgTlZNRV9BREFQVElWRV9FUElTT0RFX0NRRVMpCisJCWdvdG8gb3V0OworCWlycV9wb2xsX2Nv
bXBsZXRlKGlvcCk7CisKKwkvKgorCSAqIEJlZm9yZSB0aGUgd2luZG93IGZpbGxzLCB0b2xlcmF0
ZSB0d28gcG9sbCBwZXJpb2RzIG9mIGN1bXVsYXRpdmUgbGFnCisJICogdG8gYWJzb3JiIHRpbWVy
IGppdHRlciBhbmQgYnVyc3R5IGNvbXBsZXRpb25zLiAgQXQgdGhlIHdpbmRvdyBib3VuZGFyeSwK
KwkgKiByZW1vdmUgdGhhdCBzbGFjayBhbmQgcmVxdWlyZSBhIHN0cmljdGx5IHNob3J0ZXIgZWxh
cHNlZCB0aW1lIHRoYW4gdGhlCisJICogc2FtcGxlZCBJUlEgaW50ZXJ2YWwuICBpbnRlcnZhbF9u
cyBpcyByb3VuZGVkIGRvd24sIHNvIHRoaXMgZmluYWwgdGVzdAorCSAqIGNhbm5vdCBhY2NlcHQg
cG9sbGluZyB0aGF0IGlzIGVxdWFsIHRvIG9yIHNsb3dlciB0aGFuIHRoZSBJUlEgYmFzZWxpbmUu
CisJICovCisJbm93ID0ga3RpbWVfZ2V0X25zKCk7CisJZWxhcHNlZCA9IG5vdyAtIGFkYXB0aXZl
LT5zdGFydF9uczsKKwlkZWFkbGluZSA9ICh1NjQpYWRhcHRpdmUtPmNvbXBsZXRpb25zICogYWRh
cHRpdmUtPmludGVydmFsX25zOworCWlmIChhZGFwdGl2ZS0+Y29tcGxldGlvbnMgPCBOVk1FX0FE
QVBUSVZFX0VQSVNPREVfQ1FFUykgeworCQlpZiAoZWxhcHNlZCA+IGRlYWRsaW5lICsKKwkJICAg
IDJVICogTlZNRV9BREFQVElWRV9QT0xMX1BFUklPRF9OUykKKwkJCW52bWVfYWRhcHRpdmVfcG9s
bF9lbmQobnZtZXEsIHRydWUpOworCQllbHNlCisJCQludm1lX2FkYXB0aXZlX2FybShhZGFwdGl2
ZSwgbm93KTsKKwkJZ290byBvdXQ7CisJfQorCWlmIChlbGFwc2VkID49IGRlYWRsaW5lKSB7CisJ
CW52bWVfYWRhcHRpdmVfcG9sbF9lbmQobnZtZXEsIHRydWUpOworCQlnb3RvIG91dDsKKwl9CisK
KwlhZGFwdGl2ZS0+cG9sbF9mYWlsdXJlcyA9IDA7CisJLyogUmV1c2UgdGhlIHJldHJ5IGNvdW50
ZXIsIHVwZGF0aW5nIGl0IG9uY2UgcGVyIHdpbmRvdy4gKi8KKwlhZGFwdGl2ZS0+cmV0cnlfY29t
cGxldGlvbnMgLT0gTlZNRV9BREFQVElWRV9FUElTT0RFX0NRRVM7CisJaWYgKCFhZGFwdGl2ZS0+
cmV0cnlfY29tcGxldGlvbnMpIHsKKwkJbnZtZV9hZGFwdGl2ZV9wb2xsX2VuZChudm1lcSwgZmFs
c2UpOworCQlnb3RvIG91dDsKKwl9CisJbnZtZV9hZGFwdGl2ZV9wb2xsX3dpbmRvd19zdGFydChh
ZGFwdGl2ZSwgbm93KTsKKwludm1lX2FkYXB0aXZlX2FybShhZGFwdGl2ZSwgbm93KTsKK291dDoK
KwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZudm1lcS0+Y3FfcG9sbF9sb2NrLCBmbGFncyk7CisJ
aWYgKCFycV9saXN0X2VtcHR5KCZpb2IucmVxX2xpc3QpKQorCQludm1lX3BjaV9jb21wbGV0ZV9i
YXRjaCgmaW9iKTsKKwlyZXR1cm4gY29tcGxldGlvbnM7Cit9CisKKy8qCisgKiBDYWxsZWQgZnJv
bSB0aGUgSVJRIGhhbmRsZXIgYWZ0ZXIgYSByZWFwIHRoYXQgZm91bmQgc29tZXRoaW5nLiAgSWYg
d2UncmUKKyAqIHN0aWxsIGluIGJhY2tvZmYsIGp1c3QgY291bnQgaXQgZG93bi4gIE90aGVyd2lz
ZSBlc3RhYmxpc2ggYW4gSVJRIGNvbXBsZXRpb24KKyAqIHJhdGUgb3ZlciBvbmUgZXBpc29kZS4g
IElmIHRoYXQgcmF0ZSBpcyBoaWdoIGVub3VnaCB0aGF0IGEgcG9sbCBldmVyeQorICogTlZNRV9B
REFQVElWRV9QT0xMX1BFUklPRF9OUyB3b3VsZCBzdGlsbCBmaW5kIHdvcmssIG1hc2sgdGhlIElS
USBhbmQgc3dpdGNoCisgKiB0byBhIHNhbWUtc2l6ZWQgcG9sbGluZyB0cmlhbDsgaWYgbm90LCBs
ZWF2ZSB0aGUgcXVldWUgb24gaW50ZXJydXB0cy4KKyAqCisgKiBDYWxsZWQgd2l0aCBudm1lcS0+
Y3FfcG9sbF9sb2NrIGhlbGQuCisgKi8KK3N0YXRpYyB2b2lkIG52bWVfYWRhcHRpdmVfc2FtcGxl
KHN0cnVjdCBudm1lX3F1ZXVlICpudm1lcSwKKwkJCQkgdW5zaWduZWQgaW50IGNvbXBsZXRpb25z
KQoreworCXN0cnVjdCBudm1lX2FkYXB0aXZlX3BvbGwgKmFkYXB0aXZlID0gbnZtZXEtPmFkYXB0
aXZlOworCXU2NCBkZWx0YSwgaW50ZXJ2YWwsIG5vdzsKKworCWlmIChhZGFwdGl2ZS0+cmV0cnlf
Y29tcGxldGlvbnMpIHsKKwkJYWRhcHRpdmUtPnJldHJ5X2NvbXBsZXRpb25zIC09IG1pbihjb21w
bGV0aW9ucywKKwkJCQkJCSAgIGFkYXB0aXZlLT5yZXRyeV9jb21wbGV0aW9ucyk7CisJCXJldHVy
bjsKKwl9CisJaWYgKCFhZGFwdGl2ZS0+c3RhcnRfbnMpIHsKKwkJYWRhcHRpdmUtPnN0YXJ0X25z
ID0ga3RpbWVfZ2V0X25zKCk7CisJCXJldHVybjsKKwl9CisJYWRhcHRpdmUtPmNvbXBsZXRpb25z
ICs9IGNvbXBsZXRpb25zOworCWlmIChhZGFwdGl2ZS0+Y29tcGxldGlvbnMgPCBOVk1FX0FEQVBU
SVZFX0VQSVNPREVfQ1FFUykKKwkJcmV0dXJuOworCisJbm93ID0ga3RpbWVfZ2V0X25zKCk7CisJ
ZGVsdGEgPSBub3cgLSBhZGFwdGl2ZS0+c3RhcnRfbnM7CisJLyoKKwkgKiBUaGUgY29tcGxldGlv
bi1yYXRlIHRlc3QgaXMgYW4gYWRtaXNzaW9uIGdhdGUsIG5vdCB0aGUgdHJpYWwgcmVzdWx0Lgor
CSAqIENvbXBhcmluZyBhIGZ1bGwgSVJRIHdpbmRvdyBhZ2FpbnN0IGEgZnVsbCBwb2xsIHdpbmRv
dyBiZWxvdyBkZWNpZGVzCisJICogd2hldGhlciBwb2xsaW5nIGFjdHVhbGx5IHBheXMgZm9yIGl0
c2VsZiBvbiB0aGlzIHF1ZXVlLgorCSAqLworCWludGVydmFsID0gZGl2NjRfdTY0KGRlbHRhLCBh
ZGFwdGl2ZS0+Y29tcGxldGlvbnMpOworCWlmICghaW50ZXJ2YWwgfHwgaW50ZXJ2YWwgPiBOVk1F
X0FEQVBUSVZFX1BPTExfUEVSSU9EX05TIHx8CisJICAgICF0ZXN0X2JpdChOVk1FUV9FTkFCTEVE
LCAmbnZtZXEtPmZsYWdzKSkgeworCQludm1lX2FkYXB0aXZlX3BvbGxfd2luZG93X3N0YXJ0KGFk
YXB0aXZlLCBub3cpOworCQlyZXR1cm47CisJfQorCisJYWRhcHRpdmUtPmludGVydmFsX25zID0g
aW50ZXJ2YWw7CisJYWRhcHRpdmUtPnJldHJ5X2NvbXBsZXRpb25zID0gTlZNRV9BREFQVElWRV9S
RUVWQUxfQ1FFUzsKKwludm1lX2FkYXB0aXZlX3BvbGxfd2luZG93X3N0YXJ0KGFkYXB0aXZlLCBu
b3cpOworCXNldF9iaXQoTlZNRVFfQURBUFRJVkVfUE9MTElORywgJm52bWVxLT5mbGFncyk7CisJ
ZGlzYWJsZV9pcnFfbm9zeW5jKGFkYXB0aXZlLT5pcnEpOworCW52bWVfYWRhcHRpdmVfYXJtKGFk
YXB0aXZlLCBub3cpOworfQorCitzdGF0aWMgaXJxcmV0dXJuX3QgbnZtZV9pcnEoaW50IGlycSwg
dm9pZCAqZGF0YSk7CisKKy8qCisgKiBJUlEgaGFuZGxlciBmb3IgcXVldWVzIHRoYXQgbWF5IHN3
aXRjaCB0byBhZGFwdGl2ZSBwb2xsaW5nLiAgSXQgcmVhcHMgdGhlIENRCisgKiBsaWtlIHRoZSBu
b3JtYWwgaGFuZGxlciwgdGhlbiBmZWVkcyB0aGUgY291bnQgdG8gdGhlIHNhbXBsZXIsIHdoaWNo
IG1heSBmbGlwCisgKiB0aGUgcXVldWUgaW50byBwb2xsIG1vZGUuICBUaGUgQ1EgbG9jayBtYWtl
cyBhbiBJUlEgcmFjaW5nIHdpdGggdGhlIHRpbWVyCisgKiBoYXJtbGVzczogaXQgZWl0aGVyIGRy
YWlucyB0aGUgQ1EgYmVmb3JlIHRoZSBzd2l0Y2ggb3Igb2JzZXJ2ZXMgcG9sbCBtb2RlCisgKiBh
bmQgbGVhdmVzIHRoZSBDUSB0byB0aGUgdGltZXIuICBBbiBlbXB0eSBJUlEgYWZ0ZXIgcG9sbGlu
ZyBpcyB0aGUgaW50ZXJydXB0CisgKiB0aGF0IHdhcyBwZW5kaW5nIHdoZW4gdGhlIHZlY3RvciB3
YXMgbWFza2VkLCBzbyBjb25zdW1lIGl0IGFzIGhhbmRsZWQuCisgKi8KK3N0YXRpYyBub2lubGlu
ZSBpcnFyZXR1cm5fdCBudm1lX2lycV9hZGFwdGl2ZV9lbmFibGVkKGludCBpcnEsIHZvaWQgKmRh
dGEpCit7CisJc3RydWN0IG52bWVfcXVldWUgKm52bWVxID0gZGF0YTsKKwl1bnNpZ25lZCBpbnQg
Y29tcGxldGlvbnM7CisJdW5zaWduZWQgbG9uZyBmbGFnczsKKwlERUZJTkVfSU9fQ09NUF9CQVRD
SChpb2IpOworCisJc3Bpbl9sb2NrX2lycXNhdmUoJm52bWVxLT5jcV9wb2xsX2xvY2ssIGZsYWdz
KTsKKwlpZiAodW5saWtlbHkodGVzdF9iaXQoTlZNRVFfQURBUFRJVkVfUE9MTElORywgJm52bWVx
LT5mbGFncykpKSB7CisJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJm52bWVxLT5jcV9wb2xsX2xv
Y2ssIGZsYWdzKTsKKwkJcmV0dXJuIElSUV9IQU5ETEVEOworCX0KKwljb21wbGV0aW9ucyA9IG52
bWVfcG9sbF9jcShudm1lcSwgJmlvYik7CisJaWYgKGNvbXBsZXRpb25zKQorCQludm1lX2FkYXB0
aXZlX3NhbXBsZShudm1lcSwgY29tcGxldGlvbnMpOworCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUo
Jm52bWVxLT5jcV9wb2xsX2xvY2ssIGZsYWdzKTsKKwlpZiAoIWNvbXBsZXRpb25zKQorCQlyZXR1
cm4gdGVzdF9hbmRfY2xlYXJfYml0KE5WTUVRX0FEQVBUSVZFX1NUQUxFX0lSUSwKKwkJCQkJICAm
bnZtZXEtPmZsYWdzKSA/IElSUV9IQU5ETEVEIDogSVJRX05PTkU7CisJaWYgKCFycV9saXN0X2Vt
cHR5KCZpb2IucmVxX2xpc3QpKQorCQludm1lX3BjaV9jb21wbGV0ZV9iYXRjaCgmaW9iKTsKKwly
ZXR1cm4gSVJRX0hBTkRMRUQ7Cit9CisKK3N0YXRpYyBpcnFyZXR1cm5fdCBudm1lX2lycV9hZGFw
dGl2ZShpbnQgaXJxLCB2b2lkICpkYXRhKQoreworCXN0cnVjdCBudm1lX3F1ZXVlICpudm1lcSA9
IGRhdGE7CisJaXJxcmV0dXJuX3QgcmV0OworCisJaWYgKCF0ZXN0X2JpdChOVk1FUV9BREFQVElW
RV9FTkFCTEVELCAmbnZtZXEtPmZsYWdzKSkgeworCQlyZXQgPSBudm1lX2lycShpcnEsIGRhdGEp
OworCQlpZiAocmV0ID09IElSUV9OT05FICYmCisJCSAgICB0ZXN0X2FuZF9jbGVhcl9iaXQoTlZN
RVFfQURBUFRJVkVfU1RBTEVfSVJRLCAmbnZtZXEtPmZsYWdzKSkKKwkJCXJldHVybiBJUlFfSEFO
RExFRDsKKwkJcmV0dXJuIHJldDsKKwl9CisJcmV0dXJuIG52bWVfaXJxX2FkYXB0aXZlX2VuYWJs
ZWQoaXJxLCBkYXRhKTsKK30KKworc3RhdGljIGlycXJldHVybl90IG52bWVfaXJxKGludCBpcnEs
IHZvaWQgKmRhdGEpCit7CisJc3RydWN0IG52bWVfcXVldWUgKm52bWVxID0gZGF0YTsKKwlERUZJ
TkVfSU9fQ09NUF9CQVRDSChpb2IpOworCisJaWYgKG52bWVfcG9sbF9jcShudm1lcSwgJmlvYikp
IHsKKwkJaWYgKCFycV9saXN0X2VtcHR5KCZpb2IucmVxX2xpc3QpKQorCQkJbnZtZV9wY2lfY29t
cGxldGVfYmF0Y2goJmlvYik7CisJCXJldHVybiBJUlFfSEFORExFRDsKKwl9CisJcmV0dXJuIElS
UV9OT05FOworfQorCiAvKgogICogUG9sbCBmb3IgY29tcGxldGlvbnMgZm9yIGFueSBpbnRlcnJ1
cHQgZHJpdmVuIHF1ZXVlCiAgKiBDYW4gYmUgY2FsbGVkIGZyb20gYW55IGNvbnRleHQuCkBAIC0x
NjU2LDMwICsxOTc3LDM4IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBudm1lX2lycV9jaGVjayhpbnQg
aXJxLCB2b2lkICpkYXRhKQogc3RhdGljIHZvaWQgbnZtZV9wb2xsX2lycWRpc2FibGUoc3RydWN0
IG52bWVfcXVldWUgKm52bWVxKQogewogCXN0cnVjdCBwY2lfZGV2ICpwZGV2ID0gdG9fcGNpX2Rl
dihudm1lcS0+ZGV2LT5kZXYpOworCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CiAJaW50IGlycTsKIAog
CVdBUk5fT05fT05DRSh0ZXN0X2JpdChOVk1FUV9QT0xMRUQsICZudm1lcS0+ZmxhZ3MpKTsKIAog
CWlycSA9IHBjaV9pcnFfdmVjdG9yKHBkZXYsIG52bWVxLT5jcV92ZWN0b3IpOwogCWRpc2FibGVf
aXJxKGlycSk7Ci0Jc3Bpbl9sb2NrKCZudm1lcS0+Y3FfcG9sbF9sb2NrKTsKKwlzcGluX2xvY2tf
aXJxc2F2ZSgmbnZtZXEtPmNxX3BvbGxfbG9jaywgZmxhZ3MpOwogCW52bWVfcG9sbF9jcShudm1l
cSwgTlVMTCk7Ci0Jc3Bpbl91bmxvY2soJm52bWVxLT5jcV9wb2xsX2xvY2spOworCXNwaW5fdW5s
b2NrX2lycXJlc3RvcmUoJm52bWVxLT5jcV9wb2xsX2xvY2ssIGZsYWdzKTsKIAllbmFibGVfaXJx
KGlycSk7CiB9CiAKIHN0YXRpYyBpbnQgbnZtZV9wb2xsKHN0cnVjdCBibGtfbXFfaHdfY3R4ICpo
Y3R4LCBzdHJ1Y3QgaW9fY29tcF9iYXRjaCAqaW9iKQogewogCXN0cnVjdCBudm1lX3F1ZXVlICpu
dm1lcSA9IGhjdHgtPmRyaXZlcl9kYXRhOworCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CiAJYm9vbCBm
b3VuZDsKIAogCWlmICghdGVzdF9iaXQoTlZNRVFfUE9MTEVELCAmbnZtZXEtPmZsYWdzKSB8fAog
CSAgICAhbnZtZV9jcWVfcGVuZGluZyhudm1lcSkpCiAJCXJldHVybiAwOwogCi0Jc3Bpbl9sb2Nr
KCZudm1lcS0+Y3FfcG9sbF9sb2NrKTsKKwkvKgorCSAqIGNxX3BvbGxfbG9jayBpcyBhbHNvIGFj
cXVpcmVkIGZyb20gaGFyZGlycSBjb250ZXh0IGJ5IGFkYXB0aXZlIElSUQorCSAqIHBvbGxpbmcg
b24gaW50ZXJydXB0LWRyaXZlbiBxdWV1ZXMuICBEaXNhYmxlIElSUXMgaGVyZSBzbyBhbGwKKwkg
KiBhY3F1aXJlcnMgc2hhcmUgYSBjb25zaXN0ZW50IGNvbnRleHQgYW5kIGxvY2tkZXAgY2Fubm90
IHNlZSBhbgorCSAqIElSUS1zYWZlIGNsYXNzIHRha2VuIHdpdGggSVJRcyBlbmFibGVkLgorCSAq
LworCXNwaW5fbG9ja19pcnFzYXZlKCZudm1lcS0+Y3FfcG9sbF9sb2NrLCBmbGFncyk7CiAJZm91
bmQgPSBudm1lX3BvbGxfY3EobnZtZXEsIGlvYik7Ci0Jc3Bpbl91bmxvY2soJm52bWVxLT5jcV9w
b2xsX2xvY2spOworCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJm52bWVxLT5jcV9wb2xsX2xvY2ss
IGZsYWdzKTsKIAogCXJldHVybiBmb3VuZDsKIH0KQEAgLTIwMTcsOCArMjM0Niw3IEBAIHN0YXRp
YyB2b2lkIG52bWVfZnJlZV9xdWV1ZShzdHJ1Y3QgbnZtZV9xdWV1ZSAqbnZtZXEpCiAJZG1hX2Zy
ZWVfY29oZXJlbnQobnZtZXEtPmRldi0+ZGV2LCBDUV9TSVpFKG52bWVxKSwKIAkJCQkodm9pZCAq
KW52bWVxLT5jcWVzLCBudm1lcS0+Y3FfZG1hX2FkZHIpOwogCWlmICghbnZtZXEtPnNxX2NtZHMp
Ci0JCXJldHVybjsKLQorCQlnb3RvIGZyZWVfYWRhcHRpdmU7CiAJaWYgKHRlc3RfYW5kX2NsZWFy
X2JpdChOVk1FUV9TUV9DTUIsICZudm1lcS0+ZmxhZ3MpKSB7CiAJCXBjaV9mcmVlX3AycG1lbSh0
b19wY2lfZGV2KG52bWVxLT5kZXYtPmRldiksCiAJCQkJbnZtZXEtPnNxX2NtZHMsIFNRX1NJWkUo
bnZtZXEpKTsKQEAgLTIwMjYsNiArMjM1NCw5IEBAIHN0YXRpYyB2b2lkIG52bWVfZnJlZV9xdWV1
ZShzdHJ1Y3QgbnZtZV9xdWV1ZSAqbnZtZXEpCiAJCWRtYV9mcmVlX2NvaGVyZW50KG52bWVxLT5k
ZXYtPmRldiwgU1FfU0laRShudm1lcSksCiAJCQkJbnZtZXEtPnNxX2NtZHMsIG52bWVxLT5zcV9k
bWFfYWRkcik7CiAJfQorZnJlZV9hZGFwdGl2ZToKKwlrZnJlZShudm1lcS0+YWRhcHRpdmUpOwor
CW52bWVxLT5hZGFwdGl2ZSA9IE5VTEw7CiB9CiAKIHN0YXRpYyB2b2lkIG52bWVfZnJlZV9xdWV1
ZXMoc3RydWN0IG52bWVfZGV2ICpkZXYsIGludCBsb3dlc3QpCkBAIC0yMDM4LDkgKzIzNjksOTcg
QEAgc3RhdGljIHZvaWQgbnZtZV9mcmVlX3F1ZXVlcyhzdHJ1Y3QgbnZtZV9kZXYgKmRldiwgaW50
IGxvd2VzdCkKIAl9CiB9CiAKK3N0YXRpYyBpbnQgbnZtZV9hZGFwdGl2ZV9zdXNwZW5kKHN0cnVj
dCBudm1lX3F1ZXVlICpudm1lcSkKK3sKKwlzdHJ1Y3QgbnZtZV9hZGFwdGl2ZV9wb2xsICphZGFw
dGl2ZSA9IG52bWVxLT5hZGFwdGl2ZTsKKwl1bnNpZ25lZCBsb25nIGZsYWdzOworCWludCBpcnE7
CisKKwlpZiAoIWFkYXB0aXZlIHx8IGFkYXB0aXZlLT5pcnEgPCAwKQorCQlyZXR1cm4gLTE7CisJ
aXJxID0gYWRhcHRpdmUtPmlycTsKKwlzeW5jaHJvbml6ZV9pcnEoaXJxKTsKKwlpcnFfcG9sbF9k
aXNhYmxlKCZhZGFwdGl2ZS0+aW9wb2xsKTsKKwkvKiBpcnFfcG9sbF9jb21wbGV0ZSgpIGNhbiBy
dW4gYmVmb3JlIHRoZSBwb2xsIGNhbGxiYWNrIHJldHVybnMuICovCisJc3Bpbl9sb2NrX2lycXNh
dmUoJm52bWVxLT5jcV9wb2xsX2xvY2ssIGZsYWdzKTsKKwlpZiAodGVzdF9hbmRfY2xlYXJfYml0
KE5WTUVRX0FEQVBUSVZFX1BPTExJTkcsICZudm1lcS0+ZmxhZ3MpKSB7CisJCXNldF9iaXQoTlZN
RVFfQURBUFRJVkVfU1RBTEVfSVJRLCAmbnZtZXEtPmZsYWdzKTsKKwkJZW5hYmxlX2lycShpcnEp
OworCX0KKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZudm1lcS0+Y3FfcG9sbF9sb2NrLCBmbGFn
cyk7CisJaHJ0aW1lcl9jYW5jZWwoJmFkYXB0aXZlLT50aW1lcik7CisJcmV0dXJuIGlycTsKK30K
Kworc3RhdGljIHZvaWQgbnZtZV9hZGFwdGl2ZV9zZXRfcXVldWUoc3RydWN0IG52bWVfcXVldWUg
Km52bWVxLCBib29sIGVuYWJsZSkKK3sKKwlzdHJ1Y3QgbnZtZV9hZGFwdGl2ZV9wb2xsICphZGFw
dGl2ZSA9IG52bWVxLT5hZGFwdGl2ZTsKKwl1bnNpZ25lZCBsb25nIGZsYWdzOworCisJaWYgKG52
bWVfYWRhcHRpdmVfc3VzcGVuZChudm1lcSkgPCAwKSB7CisJCWNsZWFyX2JpdChOVk1FUV9BREFQ
VElWRV9FTkFCTEVELCAmbnZtZXEtPmZsYWdzKTsKKwkJcmV0dXJuOworCX0KKworCXNwaW5fbG9j
a19pcnFzYXZlKCZudm1lcS0+Y3FfcG9sbF9sb2NrLCBmbGFncyk7CisJbnZtZV9hZGFwdGl2ZV9z
dGF0ZV9yZXNldChhZGFwdGl2ZSk7CisJaWYgKGVuYWJsZSkKKwkJc2V0X2JpdChOVk1FUV9BREFQ
VElWRV9FTkFCTEVELCAmbnZtZXEtPmZsYWdzKTsKKwllbHNlCisJCWNsZWFyX2JpdChOVk1FUV9B
REFQVElWRV9FTkFCTEVELCAmbnZtZXEtPmZsYWdzKTsKKwlzcGluX3VubG9ja19pcnFyZXN0b3Jl
KCZudm1lcS0+Y3FfcG9sbF9sb2NrLCBmbGFncyk7CisJaXJxX3BvbGxfZW5hYmxlKCZhZGFwdGl2
ZS0+aW9wb2xsKTsKK30KKworLyoKKyAqIEZyZWV6ZSBhbmQgZHJhaW4gbmFtZXNwYWNlIEkvTyBi
ZWZvcmUgY2hhbmdpbmcgdGhlIGNvbXBsZXRpb24gbW9kZS4gIFRoZQorICogbG9ja3Mga2VlcCBu
YW1lc3BhY2UgYW5kIGNvbnRyb2xsZXIgdGVhcmRvd24gcGF0aHMgZnJvbSBjaGFuZ2luZyB0aGUg
cXVldWUKKyAqIHNldCB3aGlsZSBpdHMgSVJRIHN0YXRlIGlzIHVwZGF0ZWQuCisgKi8KK3N0YXRp
YyBpbnQgbnZtZV9hZGFwdGl2ZV9zd2l0Y2goc3RydWN0IG52bWVfZGV2ICpkZXYsIGJvb2wgZW5h
YmxlKQoreworCWludCBxaWQsIHJldCA9IDA7CisKKwltdXRleF9sb2NrKCZkZXYtPmN0cmwuc2Nh
bl9sb2NrKTsKKwlpZiAobnZtZV9jdHJsX3N0YXRlKCZkZXYtPmN0cmwpICE9IE5WTUVfQ1RSTF9M
SVZFKSB7CisJCXJldCA9IC1FQlVTWTsKKwkJZ290byBvdXRfdW5sb2NrOworCX0KKwlpZiAoZW5h
YmxlID09IFJFQURfT05DRShkZXYtPmFkYXB0aXZlX2lycV9wb2xsaW5nKSkKKwkJZ290byBvdXRf
dW5sb2NrOworCisJbnZtZV9zdGFydF9mcmVlemUoJmRldi0+Y3RybCk7CisJbnZtZV93YWl0X2Zy
ZWV6ZSgmZGV2LT5jdHJsKTsKKworCW11dGV4X2xvY2soJmRldi0+c2h1dGRvd25fbG9jayk7CisJ
aWYgKG52bWVfY3RybF9zdGF0ZSgmZGV2LT5jdHJsKSAhPSBOVk1FX0NUUkxfTElWRSkgeworCQly
ZXQgPSAtRUJVU1k7CisJfSBlbHNlIHsKKwkJZm9yIChxaWQgPSAxOyBxaWQgPCBkZXYtPmN0cmwu
cXVldWVfY291bnQ7IHFpZCsrKQorCQkJbnZtZV9hZGFwdGl2ZV9zZXRfcXVldWUoJmRldi0+cXVl
dWVzW3FpZF0sIGVuYWJsZSk7CisJCVdSSVRFX09OQ0UoZGV2LT5hZGFwdGl2ZV9pcnFfcG9sbGlu
ZywgZW5hYmxlKTsKKwl9CisJbXV0ZXhfdW5sb2NrKCZkZXYtPnNodXRkb3duX2xvY2spOworCisJ
bnZtZV91bmZyZWV6ZSgmZGV2LT5jdHJsKTsKK291dF91bmxvY2s6CisJbXV0ZXhfdW5sb2NrKCZk
ZXYtPmN0cmwuc2Nhbl9sb2NrKTsKKwlyZXR1cm4gcmV0OworfQorCitzdGF0aWMgdm9pZCBudm1l
X2FkYXB0aXZlX3N1c3BlbmRfZG9uZShzdHJ1Y3QgbnZtZV9xdWV1ZSAqbnZtZXEsIGludCBpcnEp
Cit7CisJaWYgKGlycSA8IDApCisJCXJldHVybjsKKwludm1lcS0+YWRhcHRpdmUtPmlycSA9IC0x
OworCWlycV9wb2xsX2VuYWJsZSgmbnZtZXEtPmFkYXB0aXZlLT5pb3BvbGwpOworfQorCiBzdGF0
aWMgdm9pZCBudm1lX3N1c3BlbmRfcXVldWUoc3RydWN0IG52bWVfZGV2ICpkZXYsIHVuc2lnbmVk
IGludCBxaWQpCiB7CiAJc3RydWN0IG52bWVfcXVldWUgKm52bWVxID0gJmRldi0+cXVldWVzW3Fp
ZF07CisJc3RydWN0IHBjaV9kZXYgKnBkZXYgPSB0b19wY2lfZGV2KGRldi0+ZGV2KTsKKwlpbnQg
aXJxOwogCiAJaWYgKCF0ZXN0X2FuZF9jbGVhcl9iaXQoTlZNRVFfRU5BQkxFRCwgJm52bWVxLT5m
bGFncykpCiAJCXJldHVybjsKQEAgLTIwNTEsOCArMjQ3MCwxMSBAQCBzdGF0aWMgdm9pZCBudm1l
X3N1c3BlbmRfcXVldWUoc3RydWN0IG52bWVfZGV2ICpkZXYsIHVuc2lnbmVkIGludCBxaWQpCiAJ
bnZtZXEtPmRldi0+b25saW5lX3F1ZXVlcy0tOwogCWlmICghbnZtZXEtPnFpZCAmJiBudm1lcS0+
ZGV2LT5jdHJsLmFkbWluX3EpCiAJCW52bWVfcXVpZXNjZV9hZG1pbl9xdWV1ZSgmbnZtZXEtPmRl
di0+Y3RybCk7Ci0JaWYgKCF0ZXN0X2FuZF9jbGVhcl9iaXQoTlZNRVFfUE9MTEVELCAmbnZtZXEt
PmZsYWdzKSkKLQkJcGNpX2ZyZWVfaXJxKHRvX3BjaV9kZXYoZGV2LT5kZXYpLCBudm1lcS0+Y3Ff
dmVjdG9yLCBudm1lcSk7CisJaWYgKCF0ZXN0X2FuZF9jbGVhcl9iaXQoTlZNRVFfUE9MTEVELCAm
bnZtZXEtPmZsYWdzKSkgeworCQlpcnEgPSBudm1lX2FkYXB0aXZlX3N1c3BlbmQobnZtZXEpOwor
CQlwY2lfZnJlZV9pcnEocGRldiwgbnZtZXEtPmNxX3ZlY3RvciwgbnZtZXEpOworCQludm1lX2Fk
YXB0aXZlX3N1c3BlbmRfZG9uZShudm1lcSwgaXJxKTsKKwl9CiB9CiAKIHN0YXRpYyB2b2lkIG52
bWVfc3VzcGVuZF9pb19xdWV1ZXMoc3RydWN0IG52bWVfZGV2ICpkZXYpCkBAIC0yMDcxLDEyICsy
NDkzLDEzIEBAIHN0YXRpYyB2b2lkIG52bWVfc3VzcGVuZF9pb19xdWV1ZXMoc3RydWN0IG52bWVf
ZGV2ICpkZXYpCiAgKi8KIHN0YXRpYyB2b2lkIG52bWVfcmVhcF9wZW5kaW5nX2NxZXMoc3RydWN0
IG52bWVfZGV2ICpkZXYpCiB7CisJdW5zaWduZWQgbG9uZyBmbGFnczsKIAlpbnQgaTsKIAogCWZv
ciAoaSA9IGRldi0+Y3RybC5xdWV1ZV9jb3VudCAtIDE7IGkgPiAwOyBpLS0pIHsKLQkJc3Bpbl9s
b2NrKCZkZXYtPnF1ZXVlc1tpXS5jcV9wb2xsX2xvY2spOworCQlzcGluX2xvY2tfaXJxc2F2ZSgm
ZGV2LT5xdWV1ZXNbaV0uY3FfcG9sbF9sb2NrLCBmbGFncyk7CiAJCW52bWVfcG9sbF9jcSgmZGV2
LT5xdWV1ZXNbaV0sIE5VTEwpOwotCQlzcGluX3VubG9jaygmZGV2LT5xdWV1ZXNbaV0uY3FfcG9s
bF9sb2NrKTsKKwkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZGV2LT5xdWV1ZXNbaV0uY3FfcG9s
bF9sb2NrLCBmbGFncyk7CiAJfQogfQogCkBAIC0yMTY2LDE4ICsyNTg5LDc1IEBAIHN0YXRpYyBp
bnQgbnZtZV9hbGxvY19xdWV1ZShzdHJ1Y3QgbnZtZV9kZXYgKmRldiwgaW50IHFpZCwgaW50IGRl
cHRoKQogCXJldHVybiAtRU5PTUVNOwogfQogCitzdGF0aWMgYm9vbCBudm1lX2FkYXB0aXZlX2lu
aXQoc3RydWN0IG52bWVfcXVldWUgKm52bWVxKQoreworCXN0cnVjdCBudm1lX2FkYXB0aXZlX3Bv
bGwgKmFkYXB0aXZlID0gbnZtZXEtPmFkYXB0aXZlOworCWludCBpcnEgPSBwY2lfaXJxX3ZlY3Rv
cih0b19wY2lfZGV2KG52bWVxLT5kZXYtPmRldiksCisJCQkJIG52bWVxLT5jcV92ZWN0b3IpOwor
CisJaWYgKGlycSA8IDApCisJCXJldHVybiBmYWxzZTsKKwlpZiAoIWFkYXB0aXZlKSB7CisJCWFk
YXB0aXZlID0ga3phbGxvY19ub2RlKHNpemVvZigqYWRhcHRpdmUpLCBHRlBfS0VSTkVMLAorCQkJ
CQlkZXZfdG9fbm9kZShudm1lcS0+ZGV2LT5kZXYpKTsKKwkJaWYgKCFhZGFwdGl2ZSkKKwkJCXJl
dHVybiBmYWxzZTsKKwkJYWRhcHRpdmUtPm52bWVxID0gbnZtZXE7CisJCWhydGltZXJfc2V0dXAo
JmFkYXB0aXZlLT50aW1lciwgbnZtZV9hZGFwdGl2ZV9wb2xsX3RpbWVyLAorCQkJICAgICAgQ0xP
Q0tfTU9OT1RPTklDLCBIUlRJTUVSX01PREVfQUJTX1BJTk5FRF9IQVJEKTsKKwkJaXJxX3BvbGxf
aW5pdCgmYWRhcHRpdmUtPmlvcG9sbCwgNjQsIG52bWVfYWRhcHRpdmVfaXJxX3BvbGwpOworCQlh
ZGFwdGl2ZS0+aXJxID0gaXJxOworCQlXUklURV9PTkNFKG52bWVxLT5hZGFwdGl2ZSwgYWRhcHRp
dmUpOworCQlyZXR1cm4gdHJ1ZTsKKwl9CisJYWRhcHRpdmUtPmlycSA9IGlycTsKKwlyZXR1cm4g
dHJ1ZTsKK30KKwogc3RhdGljIGludCBxdWV1ZV9yZXF1ZXN0X2lycShzdHJ1Y3QgbnZtZV9xdWV1
ZSAqbnZtZXEpCiB7CiAJc3RydWN0IHBjaV9kZXYgKnBkZXYgPSB0b19wY2lfZGV2KG52bWVxLT5k
ZXYtPmRldik7CiAJaW50IG5yID0gbnZtZXEtPmRldi0+Y3RybC5pbnN0YW5jZTsKKwlib29sIGFk
YXB0aXZlX3F1ZXVlOworCWludCByZXQ7CiAKIAlpZiAodXNlX3RocmVhZGVkX2ludGVycnVwdHMp
IHsKKwkJY2xlYXJfYml0KE5WTUVRX0FEQVBUSVZFX0VOQUJMRUQsICZudm1lcS0+ZmxhZ3MpOwog
CQlyZXR1cm4gcGNpX3JlcXVlc3RfaXJxKHBkZXYsIG52bWVxLT5jcV92ZWN0b3IsIG52bWVfaXJx
X2NoZWNrLAogCQkJCW52bWVfaXJxLCBudm1lcSwgIm52bWUlZHElZCIsIG5yLCBudm1lcS0+cWlk
KTsKLQl9IGVsc2UgewotCQlyZXR1cm4gcGNpX3JlcXVlc3RfaXJxKHBkZXYsIG52bWVxLT5jcV92
ZWN0b3IsIG52bWVfaXJxLAotCQkJCU5VTEwsIG52bWVxLCAibnZtZSVkcSVkIiwgbnIsIG52bWVx
LT5xaWQpOwogCX0KKwkvKiBEZWNpZGUgc3RhdGljIGVsaWdpYmlsaXR5IG9uY2UsIGJlZm9yZSBp
bnN0YWxsaW5nIHRoZSBJUlEgaGFuZGxlci4gKi8KKwlhZGFwdGl2ZV9xdWV1ZSA9IG52bWVxLT5x
aWQgJiYgbnZtZXEtPmRldi0+bnVtX3ZlY3MgPiAxICYmCisJCXBkZXYtPm1zaXhfZW5hYmxlZCAm
JgorCQludm1lcS0+cV9kZXB0aCA+PSBOVk1FX0FEQVBUSVZFX1RBUkdFVF9CQVRDSDsKKwlpZiAo
YWRhcHRpdmVfcXVldWUpCisJCWFkYXB0aXZlX3F1ZXVlID0gbnZtZV9hZGFwdGl2ZV9pbml0KG52
bWVxKTsKKwlpZiAoYWRhcHRpdmVfcXVldWUgJiYgUkVBRF9PTkNFKG52bWVxLT5kZXYtPmFkYXB0
aXZlX2lycV9wb2xsaW5nKSkKKwkJc2V0X2JpdChOVk1FUV9BREFQVElWRV9FTkFCTEVELCAmbnZt
ZXEtPmZsYWdzKTsKKwllbHNlCisJCWNsZWFyX2JpdChOVk1FUV9BREFQVElWRV9FTkFCTEVELCAm
bnZtZXEtPmZsYWdzKTsKKwlyZXQgPSBwY2lfcmVxdWVzdF9pcnEocGRldiwgbnZtZXEtPmNxX3Zl
Y3RvciwKKwkJCSAgICAgIGFkYXB0aXZlX3F1ZXVlID8gbnZtZV9pcnFfYWRhcHRpdmUgOiBudm1l
X2lycSwKKwkJCSAgICAgIE5VTEwsIG52bWVxLCAibnZtZSVkcSVkIiwgbnIsIG52bWVxLT5xaWQp
OworCWlmICghYWRhcHRpdmVfcXVldWUgfHwgcmV0KSB7CisJCWNsZWFyX2JpdChOVk1FUV9BREFQ
VElWRV9FTkFCTEVELCAmbnZtZXEtPmZsYWdzKTsKKwkJaWYgKHJldCAmJiBudm1lcS0+YWRhcHRp
dmUpCisJCQludm1lcS0+YWRhcHRpdmUtPmlycSA9IC0xOworCX0KKwlyZXR1cm4gcmV0OworfQor
CitzdGF0aWMgdm9pZCBudm1lX2FkYXB0aXZlX3Jlc2V0KHN0cnVjdCBudm1lX3F1ZXVlICpudm1l
cSkKK3sKKwlzdHJ1Y3QgbnZtZV9hZGFwdGl2ZV9wb2xsICphZGFwdGl2ZSA9IG52bWVxLT5hZGFw
dGl2ZTsKKworCWNsZWFyX2JpdChOVk1FUV9BREFQVElWRV9QT0xMSU5HLCAmbnZtZXEtPmZsYWdz
KTsKKwljbGVhcl9iaXQoTlZNRVFfQURBUFRJVkVfRU5BQkxFRCwgJm52bWVxLT5mbGFncyk7CisJ
Y2xlYXJfYml0KE5WTUVRX0FEQVBUSVZFX1NUQUxFX0lSUSwgJm52bWVxLT5mbGFncyk7CisJaWYg
KCFhZGFwdGl2ZSkKKwkJcmV0dXJuOworCW52bWVfYWRhcHRpdmVfc3RhdGVfcmVzZXQoYWRhcHRp
dmUpOworCWFkYXB0aXZlLT5pcnEgPSAtMTsKIH0KIAogc3RhdGljIHZvaWQgbnZtZV9pbml0X3F1
ZXVlKHN0cnVjdCBudm1lX3F1ZXVlICpudm1lcSwgdTE2IHFpZCkKQEAgLTIxODgsNiArMjY2OCw3
IEBAIHN0YXRpYyB2b2lkIG52bWVfaW5pdF9xdWV1ZShzdHJ1Y3QgbnZtZV9xdWV1ZSAqbnZtZXEs
IHUxNiBxaWQpCiAJbnZtZXEtPmxhc3Rfc3FfdGFpbCA9IDA7CiAJbnZtZXEtPmNxX2hlYWQgPSAw
OwogCW52bWVxLT5jcV9waGFzZSA9IDE7CisJbnZtZV9hZGFwdGl2ZV9yZXNldChudm1lcSk7CiAJ
bnZtZXEtPnFfZGIgPSAmZGV2LT5kYnNbcWlkICogMiAqIGRldi0+ZGJfc3RyaWRlXTsKIAltZW1z
ZXQoKHZvaWQgKiludm1lcS0+Y3FlcywgMCwgQ1FfU0laRShudm1lcSkpOwogCW52bWVfZGJidWZf
aW5pdChkZXYsIG52bWVxLCBxaWQpOwpAQCAtMjgwOCw2ICszMjg5LDMzIEBAIHN0YXRpYyBzc2l6
ZV90IGhtYl9zdG9yZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRl
ICphdHRyLAogfQogc3RhdGljIERFVklDRV9BVFRSX1JXKGhtYik7CiAKK3N0YXRpYyBzc2l6ZV90
IGFkYXB0aXZlX2lycV9wb2xsaW5nX3Nob3coc3RydWN0IGRldmljZSAqZGV2LAorCQkJCQkgc3Ry
dWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsCisJCQkJCSBjaGFyICpidWYpCit7CisJc3RydWN0
IG52bWVfZGV2ICpuZGV2ID0gdG9fbnZtZV9kZXYoZGV2X2dldF9kcnZkYXRhKGRldikpOworCisJ
cmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAiJWRcbiIsIFJFQURfT05DRShuZGV2LT5hZGFwdGl2ZV9p
cnFfcG9sbGluZykpOworfQorCitzdGF0aWMgc3NpemVfdCBhZGFwdGl2ZV9pcnFfcG9sbGluZ19z
dG9yZShzdHJ1Y3QgZGV2aWNlICpkZXYsCisJCQkJCSAgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUg
KmF0dHIsCisJCQkJCSAgY29uc3QgY2hhciAqYnVmLCBzaXplX3QgY291bnQpCit7CisJc3RydWN0
IG52bWVfZGV2ICpuZGV2ID0gdG9fbnZtZV9kZXYoZGV2X2dldF9kcnZkYXRhKGRldikpOworCWJv
b2wgZW5hYmxlOworCWludCByZXQ7CisKKwlyZXQgPSBrc3RydG9ib29sKGJ1ZiwgJmVuYWJsZSk7
CisJaWYgKHJldCkKKwkJcmV0dXJuIHJldDsKKwlyZXQgPSBudm1lX2FkYXB0aXZlX3N3aXRjaChu
ZGV2LCBlbmFibGUpOworCWlmIChyZXQpCisJCXJldHVybiByZXQ7CisJcmV0dXJuIGNvdW50Owor
fQorc3RhdGljIERFVklDRV9BVFRSX1JXKGFkYXB0aXZlX2lycV9wb2xsaW5nKTsKKwogc3RhdGlj
IHVtb2RlX3QgbnZtZV9wY2lfYXR0cnNfYXJlX3Zpc2libGUoc3RydWN0IGtvYmplY3QgKmtvYmos
CiAJCXN0cnVjdCBhdHRyaWJ1dGUgKmEsIGludCBuKQogewpAQCAtMjgyMyw2ICszMzMxLDggQEAg
c3RhdGljIHVtb2RlX3QgbnZtZV9wY2lfYXR0cnNfYXJlX3Zpc2libGUoc3RydWN0IGtvYmplY3Qg
KmtvYmosCiAJfQogCWlmIChhID09ICZkZXZfYXR0cl9obWIuYXR0ciAmJiAhY3RybC0+aG1wcmUp
CiAJCXJldHVybiAwOworCWlmIChhID09ICZkZXZfYXR0cl9hZGFwdGl2ZV9pcnFfcG9sbGluZy5h
dHRyICYmIHVzZV90aHJlYWRlZF9pbnRlcnJ1cHRzKQorCQlyZXR1cm4gMDsKIAogCXJldHVybiBh
LT5tb2RlOwogfQpAQCAtMjgzMiw2ICszMzQyLDcgQEAgc3RhdGljIHN0cnVjdCBhdHRyaWJ1dGUg
Km52bWVfcGNpX2F0dHJzW10gPSB7CiAJJmRldl9hdHRyX2NtYmxvYy5hdHRyLAogCSZkZXZfYXR0
cl9jbWJzei5hdHRyLAogCSZkZXZfYXR0cl9obWIuYXR0ciwKKwkmZGV2X2F0dHJfYWRhcHRpdmVf
aXJxX3BvbGxpbmcuYXR0ciwKIAlOVUxMLAogfTsKIApAQCAtMzY4NSw2ICs0MTk2LDcgQEAgc3Rh
dGljIHN0cnVjdCBudm1lX2RldiAqbnZtZV9wY2lfYWxsb2NfZGV2KHN0cnVjdCBwY2lfZGV2ICpw
ZGV2LAogCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsKIAlJTklUX1dPUksoJmRldi0+Y3RybC5y
ZXNldF93b3JrLCBudm1lX3Jlc2V0X3dvcmspOwogCW11dGV4X2luaXQoJmRldi0+c2h1dGRvd25f
bG9jayk7CisJZGV2LT5hZGFwdGl2ZV9pcnFfcG9sbGluZyA9IHVzZV9hZGFwdGl2ZV9pcnFfcG9s
bGluZzsKIAogCWRldi0+bnJfd3JpdGVfcXVldWVzID0gd3JpdGVfcXVldWVzOwogCWRldi0+bnJf
cG9sbF9xdWV1ZXMgPSBwb2xsX3F1ZXVlczsKLS0gCjIuMzkuNSAoQXBwbGUgR2l0LTE1NCkKCg==

--e177775af9a104a4b71ca470470481648a9dd8bea3e7d64532a5d86f6ae6--

