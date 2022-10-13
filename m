Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4DAC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Oct 2022 05:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c2YwssGIaPysLPcR20mrskERCj5dzMDhD63/1J4p7RU=; b=xvLxpk5PgEqGyX52vukIO9VZ1d
	fs1STAAtXg6hva9NpUrcPhhZ0DMdCMjbLA8EqnmkWGsvwRZtIAWBpVwzZuPsasIH4jxy2E7+aabWv
	20J8yyIBifDFjGCZkJCgl9w+WjDZ2gzGzZ8GSz2ztARl6JxHnB4cjafCAAwzebxl8vm2yGZmTwyYJ
	Yp3k9YYqZ2pjwkDIKZBarGJdP9SwTEVYwoICrtQ0e1WzgvgOacKVaa7zBjjCVApS8TZf2wJQCIytf
	tIQsopHAeNmfjcva0nUVG/I/gJD3cXtzihWllJWT+4DjNhQg734tMUe/qcdvRN60AbLuqCiyJJUWV
	/VPb7CeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oirG7-00AmJm-Ku; Thu, 13 Oct 2022 05:59:55 +0000
Received: from smtprelay0017.hostedemail.com ([216.40.44.17] helo=relay.hostedemail.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oinAF-00AABl-BU; Thu, 13 Oct 2022 01:37:36 +0000
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 640C9120237;
	Thu, 13 Oct 2022 01:37:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id 56EDD20026;
	Thu, 13 Oct 2022 01:37:01 +0000 (UTC)
Message-ID: <3f527ec95a12135eb40f5f2d156a2954feb7fbfe.camel@perches.com>
Subject: Re: [PATCH v1 3/5] treewide: use get_random_u32() when possible
From: Joe Perches <joe@perches.com>
To: David Laight <David.Laight@ACULAB.COM>, "Jason A. Donenfeld"
 <Jason@zx2c4.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, 
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,  "linux-sctp@vger.kernel.org"
 <linux-sctp@vger.kernel.org>, "target-devel@vger.kernel.org"
 <target-devel@vger.kernel.org>, "linux-mtd@lists.infradead.org"
 <linux-mtd@lists.infradead.org>, "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>, "drbd-dev@lists.linbit.com"
 <drbd-dev@lists.linbit.com>, "dev@openvswitch.org" <dev@openvswitch.org>, 
 "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "dccp@vger.kernel.org" <dccp@vger.kernel.org>, 
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
 "lvs-devel@vger.kernel.org" <lvs-devel@vger.kernel.org>,
 "SHA-cyfmac-dev-list@infineon.com" <SHA-cyfmac-dev-list@infineon.com>,
 "coreteam@netfilter.org" <coreteam@netfilter.org>,
 "tipc-discussion@lists.sourceforge.net"
 <tipc-discussion@lists.sourceforge.net>, "linux-ext4@vger.kernel.org"
 <linux-ext4@vger.kernel.org>, "linux-media@vger.kernel.org"
 <linux-media@vger.kernel.org>, "linux-actions@lists.infradead.org"
 <linux-actions@lists.infradead.org>, "linux-nfs@vger.kernel.org"
 <linux-nfs@vger.kernel.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "dmaengine@vger.kernel.org"
 <dmaengine@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-hams@vger.kernel.org"
 <linux-hams@vger.kernel.org>, "ceph-devel@vger.kernel.org"
 <ceph-devel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "cake@lists.bufferbloat.net"
 <cake@lists.bufferbloat.net>, "brcm80211-dev-list.pdl@broadcom.com"
 <brcm80211-dev-list.pdl@broadcom.com>, "linux-raid@vger.kernel.org"
 <linux-raid@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>,  "linux-usb@vger.kernel.org"
 <linux-usb@vger.kernel.org>, "linux-mmc@vger.kernel.org"
 <linux-mmc@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>, "linux-xfs@vger.kernel.org"
 <linux-xfs@vger.kernel.org>, "netfilter-devel@vger.kernel.org"
 <netfilter-devel@vger.kernel.org>, "linux-crypto@vger.kernel.org"
 <linux-crypto@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 12 Oct 2022 18:37:11 -0700
In-Reply-To: <d45bd258e033453b85a137112e7694e1@AcuMS.aculab.com>
References: <20221005214844.2699-1-Jason@zx2c4.com>
	 <20221005214844.2699-4-Jason@zx2c4.com>
	 <f8ad3ba44d28dec1a5f7626b82c5e9c2aeefa729.camel@perches.com>
	 <d45bd258e033453b85a137112e7694e1@AcuMS.aculab.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Stat-Signature: jmxt1u5agdpi9w76hr4tp6uotie3p373
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 56EDD20026
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18KEIRmyyr9pSEavQqF5X0dTzAEITyiJq4=
X-HE-Tag: 1665625021-540494
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221012_183735_470686_58769CF7 
X-CRM114-Status: GOOD (  19.42  )
X-Mailman-Approved-At: Wed, 12 Oct 2022 22:59:28 -0700
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

On Wed, 2022-10-12 at 21:29 +0000, David Laight wrote:
> From: Joe Perches
> > Sent: 12 October 2022 20:17
> >=20
> > On Wed, 2022-10-05 at 23:48 +0200, Jason A. Donenfeld wrote:
> > > The prandom_u32() function has been a deprecated inline wrapper aroun=
d
> > > get_random_u32() for several releases now, and compiles down to the
> > > exact same code. Replace the deprecated wrapper with a direct call to
> > > the real function.
> > []
> > > diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw=
/cxgb4/cm.c
> > []
> > > @@ -734,7 +734,7 @@ static int send_connect(struct c4iw_ep *ep)
> > >  				   &ep->com.remote_addr;
> > >  	int ret;
> > >  	enum chip_type adapter_type =3D ep->com.dev->rdev.lldi.adapter_type=
;
> > > -	u32 isn =3D (prandom_u32() & ~7UL) - 1;
> > > +	u32 isn =3D (get_random_u32() & ~7UL) - 1;
> >=20
> > trivia:
> >=20
> > There are somewhat odd size mismatches here.
> >=20
> > I had to think a tiny bit if random() returned a value from 0 to 7
> > and was promoted to a 64 bit value then truncated to 32 bit.
> >=20
> > Perhaps these would be clearer as ~7U and not ~7UL
>=20
> That makes no difference - the compiler will generate the same code.

True, more or less.  It's more a question for the reader.

> The real question is WTF is the code doing?

True.

> The '& ~7u' clears the bottom 3 bits.
> The '- 1' then sets the bottom 3 bits and decrements the
> (random) high bits.

Right.

> So is the same as get_random_u32() | 7.

True, it's effectively the same as the upper 29 bits are random
anyway and the bottom 3 bits are always set.

> But I bet the coder had something else in mind.

Likely.

And it was also likely copy/pasted a few times.

