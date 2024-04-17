Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C91C04FFF
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Apr 2024 14:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Cc:
	Date:In-Reply-To:From:Subject:Mime-Version:Content-Transfer-Encoding:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=evdBmvAot3uTZyDhJLrMxJ8vyf5vg1EagvAkhFU8oaM=; b=rbtLPssAPBs32Qrl8v09O1tQze
	J2LtICS8lWhGDvZc0a+Y8Jh3zg00VqT/QXD3/UEOXXkEtvT8K9f5vxeg08ca1lbDRjpmv89a3Z3hO
	qFOQ9kSrDoWW81FGIbiLI9mtuVr0aoi1Lf27HE+sWNOMLTD7IGIHO40e9BiTT9Zf32+sz4H8+t3F2
	Yl9B5qfJYFfBTpXQMqJZ37IgK41jGGzqMcK1YjQb+hfvafw8BAgsFioH7NFErRFXom4hlr0tR069c
	w0nHAGWMvimnTkcgpO3QcNYqknID3wXIzF+gXsdkZhaQ0lQIlLYALGtGM5AK/NIQ/GEhpuOVeM0Gp
	JiclwlAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx6Rm-0000000GNe0-3O7Z;
	Wed, 17 Apr 2024 14:39:38 +0000
Received: from mout.perfora.net ([74.208.4.196])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx6Rj-0000000GNd7-2HzB
	for linux-nvme@lists.infradead.org;
	Wed, 17 Apr 2024 14:39:37 +0000
Received: from smtpclient.apple ([75.198.210.167]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1Mi1in-1sRTF90Xjd-00e3m4;
 Wed, 17 Apr 2024 16:39:18 +0200
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Subject: Re: nvme-cli spdk plugin
From: Jim <jim@thebergstens.com>
In-Reply-To: <7a926cbb-51f9-4e03-b737-b4434b1270dd@kernel.dk>
Date: Wed, 17 Apr 2024 07:39:04 -0700
Cc: Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Tomasz Zawadzki <tomasz.zawadzki@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Message-Id: <7C454EEA-9E92-4794-B887-738884FCEEF0@thebergstens.com>
References: <7a926cbb-51f9-4e03-b737-b4434b1270dd@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
X-Mailer: iPhone Mail (21F5048f)
X-Provags-ID: V03:K1:lf/BseiW22hBzHi3Thm+rm5qFrfpE2LZq+CIERaSlOVd5IvyskE
 PJEodtE06MwwyJLoHtMXCyOpCoKZJ41cwnUugW29IIHV4knYcj355zyvHq7fr+qSMwZv9i8
 8yr7QWS29kpWP+vo2+FwhBkWZ7AVhNwt+n15lmTO5r930ibAYokvN0BKC5xplKhfY2WtWW6
 5do1bX5ngeU1qDcJC7Msw==
UI-OutboundReport: notjunk:1;M01:P0:Ys/u3nBvNpg=;F5Mnub/9sazKLehp/VE/3tzVrBN
 9OdZd8RJu3BL5WmQqGN8clvcolid7IcW8caoIlvfbvB+RBIQwJpDbGxeBfITwlWxjXHRyOwVd
 R1qlzTng3e4pSRYWRZ/Vk+3F+sO1MHHcsNI18TfTwjINCnsnvIMsvUOXZDrx/vXtLjEKRpmnm
 LwudryHiSZPTKbRuTYR2zRlBUSUo3+Su5n/BhEIjSLuBUFLZG+IGhstBtXIxhCSn+krfRYqnN
 CNfkIIHrtSVzau2omcnUGhSZUfmgbCaVBQdhNnbUx5abLaM46uhLsnSv9K010nuFLHjKNlrZA
 DG2OJxgspqA/ghT9vfr4vVirKPjKeSKnM+0zsVpTwFX9eBdz93pdwVBQZPBjYLjG77tWVtFpP
 Dllq/Osykvq2z0kuCeqbuPYQPSzYolauKmLqBJ10nH6dB/zyyDSlzSpTupPekR5b1Jsv2nTOk
 DGV/kEXlQpWudTcKWrozSwEoKhM6B8UWQTBNN0dnLn0b3WKUG6PP1zOqjb37/opNCJADi32K0
 0C9nLO4xYampvqDl6zW5hI9lt6iczRJiLFhPu4ZXpM2TiZI9lVCusmvDsvVXPtf02ECuOpn3L
 GRhXVPMcrWkKIzR6zXZS+YqOo+3AGScMADrcPwEQux129MMJVTXeBiTL93Zzxnx5hexeUWcxX
 40woQ/47lU6bAFHGQ/1Z9lG7lR797CJsmJ+7TtddrSSRa2oBD6JOWwZO4S8vXwnyW8ubkz047
 oh/7FzhiX7MHFuD1Jm1GeajjiDGpj1opllC211sU0lQY6ct8SaLyxI=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240417_073935_872507_EC3C35AF 
X-CRM114-Status: GOOD (  11.32  )
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

This, right here, folks is why I=E2=80=99m glad I=E2=80=99m retired.

> On Apr 17, 2024, at 7:31=E2=80=AFAM, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> =EF=BB=BFOn 4/17/24 8:26 AM, Christoph Hellwig wrote:
>>> On Wed, Apr 17, 2024 at 10:33:17AM +0200, Daniel Wagner wrote:
>>> There is a PR [1] pending, adding a spdk plugin for nvme-cli. The
>>> problem this new plugin tries to solve is, that with the recent change
>>> to use sysfs only for discovering the nvme subystem, nvme-cli
>>> lost support for spdk.
>>>=20
>>> My question is, should we have a special plugin for 'list' and
>>> 'list-subsystem' or should we try to get this somehow integrated into
>>> the existing code? So that 'list' just works?
>>=20
>> =D0=86 don't think nvme-cli should deal with anything that is not driven
>> by the kernel nvme driver.
>=20
> Exactly, why on earth would we care about spdk at all in the first
> place, nvme-cli or not.
>=20
> --
> Jens Axboe
>=20
>=20
>=20


