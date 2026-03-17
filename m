Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A603FD875E
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2026 13:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aQHFo2Em1iD+gjVVV+WCkPdNn1WHoJ9VfFWRHmi2yCU=; b=CfwHxWcHSG7gjl3OaPaytZtjhJ
	MnLX53iil0Tr24RjuhsarosJoUahSUXFwaaoXLtxqhCbnHylYEbiDs/tj+tN4YG1CO5YQFEaYHeuI
	HmFOP1LuZLXBWs1qwzmKBk4B5CSLgamPDCjZ95e+nm0r36nzXGimv5Ee3LWRi4/TTPoX+GGm3Fl4I
	bClTRWR9+8jajtKQwxihNjzMgMA0a0ihs+hbwgPfqo/k2jnIAKq8sSVYnSOtERfSOES5sbrwo4VHV
	5D919ODlrm5d0KOt9mEGjA0KiGhU4TolpGOdVFzLtAFklOWU2mAEH5UcJqH4b3NSglAPGr45fInRX
	bsTZYMzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2ULO-00000006PUe-2AAR;
	Tue, 17 Mar 2026 13:20:22 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2ULM-00000006PT3-0JiA
	for linux-nvme@lists.infradead.org;
	Tue, 17 Mar 2026 13:20:21 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 0612b97a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Mar 2026 14:20:18 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 14:20:17 +0100
Message-Id: <DH536IY4JYD6.JPEWTIJ6WS4E@arkamax.eu>
Cc: "Sagi Grimberg" <sagi@grimberg.me>, "Keith Busch" <kbusch@kernel.org>,
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCHv3 0/8] nvme-auth: switch to use the kernel keyring
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Hannes Reinecke" <hare@kernel.org>, "Christoph Hellwig" <hch@lst.de>
X-Mailer: aerc 0.21.0
References: <20260317130103.107360-1-hare@kernel.org>
In-Reply-To: <20260317130103.107360-1-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_062020_455395_1E5AB735 
X-CRM114-Status: GOOD (  25.88  )
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

On Tue Mar 17, 2026 at 2:00 PM CET, Hannes Reinecke wrote:
> Hey all,
>
> the current NVMe authentication code is using a hand-crafted key
> structure; idea was to have the initial implementation with a minimal
> set of dependencies.
> (And me not having a good grasp on how to use the kernel keyring :-)
> That had the drawback that keys always had to be specified on the
> nvme-cli commandline, which is far from ideal from a security standpoint.
>
> So this patchset switches the authentication code over to use the
> kernel keyring. User-facing interface (namely argument to 'nvme
> connect') remain the same, but the key data is converted into keys
> which are stored as a new key type 'dhchap' with a random UUID as
> description in the kernel keyring.
>
> With this I have updated the dhchap arguments to 'nvme connect' and
> the configfs interface to either be the keydata (ie the original
> interface) _or_ a key description referring to a pre-populated dhchap
> key in the kernel keyring. This allows for easier provisioning of keys
> and avoids the security risk from having to specify the key data on
> the kernel commandline.
>
> The entire patchset can be found at
> git://git.kernel.org/pub/scm/linux/kernel/git/hare/nvme.git
> branch dhchap-keyring.v3

Are you sure you pushed it? I can't see it

$ git branch -a | grep dhchap
  remotes/hare/dhchap-keyring.v1
  remotes/hare/dhchap-keyring.v2

Maurizio

>
> There is a pull request to blktests (PR#175) which adds a test
> to exercise the new interface.
>
> As usual, comments and reviews are welcome.
>
> Changes to v2:
> - Update to v7.1
> - Include reviews fromn Sagi
> - Clarify decoded PSK length
> - Add more function descriptions
>
> Changes to the original submission:
> - Dropped patches merged with upstream
> - Modified the interface to refer to keys via the description
>   and not the serial number
>
> Hannes Reinecke (8):
>   nvme-auth: modify nvme_auth_transform_key() to return status
>   nvme-keyring: add 'dhchap' key type
>   nvme-auth: switch to use 'struct key'
>   nvme: parse dhchap keys during option parsing
>   nvmet-auth: parse dhchap key from configfs attribute
>   nvme: allow to pass in key description as dhchap secret
>   nvme-auth: wait for authentication to finish when changing keys
>   nvme-fabrics: allow to pass in keyring by name
>
>  drivers/nvme/common/Kconfig    |   1 +
>  drivers/nvme/common/auth.c     | 211 ++++++++++------------
>  drivers/nvme/common/keyring.c  | 314 +++++++++++++++++++++++++++++++++
>  drivers/nvme/host/Kconfig      |   1 -
>  drivers/nvme/host/auth.c       | 171 ++++++++++++------
>  drivers/nvme/host/fabrics.c    | 119 +++++++++----
>  drivers/nvme/host/fabrics.h    |  12 +-
>  drivers/nvme/host/nvme.h       |   6 +-
>  drivers/nvme/host/sysfs.c      | 211 ++++++++++++++++------
>  drivers/nvme/target/Kconfig    |   1 -
>  drivers/nvme/target/auth.c     | 224 ++++++++++++++---------
>  drivers/nvme/target/configfs.c |  86 +++++++--
>  drivers/nvme/target/nvmet.h    |  13 +-
>  include/linux/nvme-auth.h      |  17 +-
>  include/linux/nvme-keyring.h   |  22 ++-
>  15 files changed, 1028 insertions(+), 381 deletions(-)


