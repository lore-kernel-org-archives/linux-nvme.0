Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8545AC021BE
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2025 16:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Er8L/RidarTahqR7VycrG4OSXqfTiHAybWHQ6rol/5o=; b=ll++GDU6TrbQLEugNxNZng5mLv
	lVSq29+hpap5957MpMb+ZwfPd5x3R2neVRcfdFt3wow05o7auSQOTk+bYKaOILumkHauZJy00V/H0
	qboMgXTVdgexJYvNxdUZxrLikM1hPCgWZrvU+TXnPBv0DNQNZ8Rut0AzUDM1b3HVvoZhcBfU2q7YW
	Hds59JSJkqQ55VRB6JpeIDhDJQFpq0YFvLSTA9wfvwsWqVWfFrnvIi7qRNMS15W7V3xaVDP9uXEth
	PhdVNBZlzEh4LvjRPL4YhmxeqcSkVrYicHCWmiv/ujNIqf8VBZqHLPsbuHSFtHLLl/xOdElu/L18T
	RVeMOXbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmxx8-00000000Fkm-2rrB;
	Tue, 25 Feb 2025 16:38:38 +0000
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmv9A-0000000HP0Q-1Adb
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 13:38:53 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1740490723; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PwggEEaZ9CQ2GimeIZGS1fmbi59boeo/kXePKMhJ2kcELz5F+pwwS7V5Gu0bqr+m09VOmQJInMo6L7Ra37jdBaT4j329+JwMt4vA4F9CnP23E6AKt72MFpaeRkCzjOgj3kV7e05+kWOHM17hEAMRIYvNgD54PhBdy2rxaS/gYWc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740490723; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Er8L/RidarTahqR7VycrG4OSXqfTiHAybWHQ6rol/5o=; 
	b=OvE8JLmbyupMizpcVZwkCvMFhKetCZ7THftrTcirYcLzMS9HHjrXKLexpCvDKLhTF5dvnlYf3CH05Yzf9eOkUMKYSEU5/aK1aVUVeFFFd5JGTheaPw3An4828MFQyGj04SSMQTinsqjmb8xPwzmUmnJgkhd3JWah+DuhiR3QEVA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=gus@collabora.com;
	dmarc=pass header.from=<gus@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740490723;
	s=zohomail; d=collabora.com; i=gus@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=Er8L/RidarTahqR7VycrG4OSXqfTiHAybWHQ6rol/5o=;
	b=AZfPrdW1ROB8wr0BspoOIaDwRjipKL5LrmmAC/s40lMo9SX7OcCnCQmAVzZeP7V0
	gIgHDNk2LoBapnJtGyWO21kHBVDWDSZl3iGCOGjQ2NpzF9z4XaPHR1cFw6gkXx22Qlz
	jaZI3whC9H5swCMAfAlga/Pzk2dbPH/FaFu31tpo=
Received: by mx.zohomail.com with SMTPS id 1740490721679326.96450953391957;
	Tue, 25 Feb 2025 05:38:41 -0800 (PST)
Message-ID: <5e610cabe469732582afb752a0155ccf0e0d84fb.camel@collabora.com>
Subject: Re: [PATCH v26 00/20] nvme-tcp receive offloads
From: Gustavo Padovan <gus@collabora.com>
To: Paolo Abeni <pabeni@redhat.com>, Aurelien Aptel <aaptel@nvidia.com>, 
	linux-nvme@lists.infradead.org, netdev@vger.kernel.org, sagi@grimberg.me, 
	hch@lst.de, kbusch@kernel.org, axboe@fb.com, chaitanyak@nvidia.com, 
	davem@davemloft.net, kuba@kernel.org
Cc: aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com, 
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 galshalom@nvidia.com,  mgurtovoy@nvidia.com, edumazet@google.com
Date: Tue, 25 Feb 2025 10:38:35 -0300
In-Reply-To: <63ede1de-1ee3-4872-84b7-d65ec2f68856@redhat.com>
References: <20250221095225.2159-1-aaptel@nvidia.com>
	 <63ede1de-1ee3-4872-84b7-d65ec2f68856@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_053852_383547_AECD5C10 
X-CRM114-Status: GOOD (  16.02  )
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

Hello,


On Tue, 2025-02-25 at 11:12 +0100, Paolo Abeni wrote:
> On 2/21/25 10:52 AM, Aurelien Aptel wrote:
> > The next iteration of our nvme-tcp receive offload series, rebased
> > on top of yesterdays
> > net-next 671819852118 ("Merge branch 'selftests-drv-net-add-a-
> > simple-tso-test'")
> >=20
> > We are pleased to announce that -as requested by Jakub- we now have
> > continuous integration (via NIPA) testing running for this feature.
>=20
> I'm sorry for the dumb question, but can you please share more
> details
> on this point?
>=20
> I don't see any self-test included here, nor any test result feeded
> to
> the CI:
>=20
> https://netdev.bots.linux.dev/devices.html


The integration is final stages of deployment. It is happening using
KernelCI[1] as the hardware executor with the NICs hosted on a server
in our lab and then publishing the results for NIPA consumption. We are
currently working with Jakub on the integration of the results produced
by KernelCI.

Since last week, NIPA generates a special branch only for hw testing.
This is the latest one for example:=20
https://github.com/linux-netdev/testing/commits/net-next-2025-02-25--12-00/

However, it doesn't include Aurelien patches yet, as from what I
understood from Jakub, this new tree only includes patches that
passed the existing SW CI. Currently this series has some fails:

https://patchwork.kernel.org/project/netdevbpf/list/?series=3D936360

Once, we get the series to pass the SW CI, I believe the patches
will land in the hw testing branch and then be picked up by KernelCI
for testing.

For information purposes, here is the same test but being executed
against aaptel tree last week:
https://dashboard.kernelci.org/test/maestro:67b8d4ace3e60eeff606d9c7


Once things are finalized, I'll send an email to the list describing
the integration as I believe more folks might be interested in the
integration through KernelCI.


[1] https://kernelci.org/


Best,

- Gus



