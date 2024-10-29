Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51C1D3A696
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 19:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YwdkWAcBJwlxAKbA05SRlwv/dPGr3OtaiRfzTM29qRg=; b=kNHnuo5Gie7d/Pon7ZdAvSOUiN
	caUBT2/wSqa69H9rTWJ2D4d+RthVWLhc2qRhBBvXLFPlUV10q4cmSqsMf7fXWk0pigw52dvPE0eou
	12qYW/dyuj0WWMbfgPZnE2oaGwuue66LPrC1HpTysVpbNbH0tmv8EwjmJQ1+zM1BPxJWpD5Utczgq
	FtBfCHjxRfcvs0CIgfKAq79Vc5e7JoeHi8dpa6GfIsT4lWFlcVO4WWo8EfKF2EKoJ9q/uRLMMtsTx
	QxkvQQEH/+myaQa1kH3FnNe17TPrSGehxr+4QPQf34xfFqjX9xSaBg1mZ1OyDXJLDKUsokjXDi7wO
	h2RVwLnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5rmo-0000000FeRf-0JuJ;
	Tue, 29 Oct 2024 19:21:50 +0000
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5rkP-0000000Fe0d-02Hr
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 19:19:22 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1730229558; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Auyo/uWi6s4GZdbeNnj1xTZ9Ffhlcw2sk410Cj5sFcCylTRI0EG998I/wfbqhIpKQJ9luWmcg8Xr+0A73ZsqH2Sf8ep/F31kzmdd8uxuxVY4PfDKpv4y/mqiQd6Hv5yfEJrHfz34MzztbM0r4/pyf/ibPvuDh9zpIaziSzs8ouw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730229558; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YwdkWAcBJwlxAKbA05SRlwv/dPGr3OtaiRfzTM29qRg=; 
	b=hsNLFgIuccHNowJ06klDQRnqhlQzW3c1XMiQO3ikTdEVrHhuJlKxMExVMA8U9xL1iVtOWJXvSRo6OLnbWi5ZD71wsvIZXtBCaZtB3qhlO72LHIMifRhe7CQnSduelsMYFfWiIgxxTgl7wOBZlaWmECcMFXtXdLK+iEmKdF3dyFM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=bob.beckett@collabora.com;
	dmarc=pass header.from=<bob.beckett@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730229558;
	s=zohomail; d=collabora.com; i=bob.beckett@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=YwdkWAcBJwlxAKbA05SRlwv/dPGr3OtaiRfzTM29qRg=;
	b=j6bLhyUroDPlVVtn5HHg5SI6rBQ4qjyZwDhZk/FUP1AW4pC+B8Zc/Lk9GAjg6QWB
	dleegWV3kFMsGL8+oMGrpx1Lcn63bIFAtZNKTbyp33AkUGkNPhpXOtgk9raFVIWtMYZ
	kBrpMobnbYCVVzZteRbS525kSRetyWcpSc7+wrgw=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1730229526423594.4339206078162; Tue, 29 Oct 2024 12:18:46 -0700 (PDT)
Date: Tue, 29 Oct 2024 19:18:46 +0000
From: Robert Beckett <bob.beckett@collabora.com>
To: "Gwendal Grignou" <gwendal@chromium.org>
Cc: "Christoph Hellwig" <hch@lst.de>, "kbusch" <kbusch@kernel.org>,
	"kbusch" <kbusch@meta.com>,
	"linux-nvme" <linux-nvme@lists.infradead.org>,
	"sagi" <sagi@grimberg.me>, "stable" <stable@vger.kernel.org>
Message-ID: <192d9b75f76.106d874861279652.1491635971113271140@collabora.com>
In-Reply-To: <CAPUE2uvUs5dGGmovvHVPdsthKT37tJCK5jDXPMgP18VKhm5qTA@mail.gmail.com>
References: <191e7126880.114951a532011899.3321332904343010318@collabora.com>
 <20241029024236.2702721-1-gwendal@chromium.org> <20241029074117.GB22316@lst.de> <CAPUE2uvUs5dGGmovvHVPdsthKT37tJCK5jDXPMgP18VKhm5qTA@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Remove O2 Queue Depth quirk
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_121921_181929_B185A8AD 
X-CRM114-Status: GOOD (  22.43  )
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






 ---- On Tue, 29 Oct 2024 18:58:40 +0000  Gwendal Grignou  wrote ---=20
 > On Tue, Oct 29, 2024 at 12:41=E2=80=AFAM Christoph Hellwig hch@lst.de> w=
rote:
 > >
 > > On Mon, Oct 28, 2024 at 07:42:36PM -0700, Gwendal Grignou wrote:
 > > > PCI_DEVICE(0x1217, 0x8760) (O2 Micro, Inc. FORESEE E2M2 NVMe SSD)
 > > > is a NMVe to eMMC bridge, that can be used with different eMMC
 > > > memory devices.
 > >
 > > Holy f**k, what an awful idea..
 > >
 > > > The NVMe device name contains the eMMC device name, for instance:
 > > > `BAYHUB SanDisk-DA4128-91904055-128GB`
 > > >
 > > > The bridge is known to work with many eMMC devices, we need to limit
 > > > the queue depth once we know which eMMC device is behind the bridge.
 > >
 > > Please work with Tobert to quirk based on the identify data for "his"
 > > device to keep it quirked instead of regressing it.
 >=20
 > The issue is we would need to base the quirk on the model name
 > (subsys->model) that is not available in `nvme_id_table`. Beside,
 > `q_depth` is set in `nvme_pci_enable`, called at probe time before
 > calling `nvme_init_ctrl_finish` that will indirectly populate
 > `subsys`.
 >=20
 > Bob, to address the data corruption problem from user space, adding a
 > udev rule to set `queue/nr_requests` to 1 when `device/model` matches
 > the device used in the Steam Deck would most likely be too late in the
 > boot process, wouldn't it?

I've never seen the corruption outside of severe stress testing.
In the field, people reported it during and after os image updates (more st=
ress testing).
However, as this concerns data integrity, it seems risky to me to rely on a=
 fix
after bootup.

 >=20
 > Gwendal.
 >=20


