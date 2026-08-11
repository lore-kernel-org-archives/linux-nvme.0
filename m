Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83EBC5CFC1
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 22:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F6t7g1L3FIZBc6jtDhdP0tDEykh3oBcFtDwQQAIP8ks=; b=NFilFPs2dwmAUnXK+Czm4UwjbS
	mAwgjb6hh0VMvqyk/+BykeAWMl204BHh5OdNHKmHBECgmEXiKQeFI/AhNxGBCo/6+7o67C1kbK/QL
	XZBQm/UJJDLTWK8LMirCmwl2p1E+aZXTD9xtztL9t3uKDk+vp1X11eaOI2EMOecJEbjdGnjONyowf
	O+tuWsTRfFNw/K8AitWlhibBxsO/ZzMQowlWCqa6uFbjsULw11Vpvmdo2LeLtFcFz5q5+gT1rsqxH
	ocy5xh/+QDjrFDPTi8cSh9d8A/ODDx5BReHqRygglc1y4tQxYevX3+Gwkm3pbwId/m26g3lBARGqt
	xItIrobw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtvAf-0000000F2tx-0xzQ;
	Tue, 11 Aug 2026 22:42:09 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtvAd-0000000F2tq-0XNi
	for linux-nvme@lists.infradead.org;
	Tue, 11 Aug 2026 22:42:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0F55E600AE;
	Tue, 11 Aug 2026 22:42:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD7D1F000E9;
	Tue, 11 Aug 2026 22:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786488125;
	bh=F6t7g1L3FIZBc6jtDhdP0tDEykh3oBcFtDwQQAIP8ks=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oNU2KuKOhygInH3rpV/vhEyIz7pxb87UogxiAqv9LdG+JthTPDcScl7S2o+Iy0vd8
	 6qJ/6jnqk22wsHVXZ0DOQ4DEX9L+XsTCKEp6kQDaKA298nEDmmOUv1MDH8BMv/y10w
	 c+gsii4pCd+idZcr6lxgpanP+KIsgIfK/J7PWlkKiuk175IrZ+C4skZXV6TQlsQaFT
	 V2r4zMwIXMu6v2TXGvkpAl+5V2l69WZJibwhGwWv6kcjjf8xMvcDi3TWm4V78/aB4Z
	 P1p4h7kxaqMYoS1K0kQlbcVwLVVL5oItuhk7swaFeXcGlhc0OR/6sAXsZEYklpsLms
	 0iP4IKghc6nwQ==
Message-ID: <078f34213dd05a3fe519eca68313379d9c038805.camel@kernel.org>
Subject: Re: [PATCH v2 2/3] nvme-tcp: support IPv6 traffic class
From: Geliang Tang <geliang@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>,  David Ahern <dsahern@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>, Hannes Reinecke
 <hare@suse.de>, Geliang Tang <tanggeliang@kylinos.cn>, 
	linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev
Date: Wed, 12 Aug 2026 06:41:59 +0800
In-Reply-To: <anptYps5IoeGDCnt@devvm7509.cco0.facebook.com>
References: <cover.1786171863.git.tanggeliang@kylinos.cn>
	 <3f5e4c84d3fe41601b29468fa4128d4639d56685.1786171863.git.tanggeliang@kylinos.cn>
	 <anptYps5IoeGDCnt@devvm7509.cco0.facebook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Stanislav,

On Mon, 2026-08-10 at 17:32 -0700, Stanislav Fomichev wrote:
> On 08/08, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > The NVMe/TCP transport needs to configure the IPv6 traffic class on
> > its
> > queue sockets, but the fabrics option parser currently has no
> > corresponding
> > option.
> > 
> > Add the tclass option to the fabrics parser and store the validated
> > value
> > in struct nvmf_ctrl_options. Negative values are rejected, while
> > values
> > greater than 255 are clamped to 255, matching the valid range of
> > the IPv6
> > traffic class field.
> > 
> > Keep -1 as the default value to let the transport use its default
> > traffic
> > class.
> > 
> > The fabrics layer now supports parsing the tclass option, but the
> > NVMe/TCP
> > transport does not currently advertise or apply it.
> > 
> > Allow NVMe/TCP to use NVMF_OPT_TCLASS and set IPV6_TCLASS on each
> > queue
> > socket via ip6_sock_set_tclass() when a traffic class is specified,
> > keeping
> > the existing IPv4 TOS handling unchanged.
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  drivers/nvme/host/fabrics.c | 18 ++++++++++++++++++
> >  drivers/nvme/host/fabrics.h |  3 +++
> >  drivers/nvme/host/tcp.c     |  8 +++++++-
> >  3 files changed, 28 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/host/fabrics.c
> > b/drivers/nvme/host/fabrics.c
> > index ac3d4f400601..643c03dc7bcb 100644
> > --- a/drivers/nvme/host/fabrics.c
> > +++ b/drivers/nvme/host/fabrics.c
> > @@ -695,6 +695,7 @@ static const match_table_t opt_tokens = {
> >  	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=%d"	},
> >  	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
> >  	{
> > NVMF_OPT_TOS,			"tos=%d"		},
> > +	{ NVMF_OPT_TCLASS,		"tclass=%d"		},
> 
> Do you really need new UAPI for v6? Any reason not to apply existing
> NVMF_OPT_TOS to ipv6 sockets?

Thanks for the feedback. I've given this careful consideration, and
you're absolutely right - there's no strong reason to introduce new
UAPI specifically for IPv6 when the existing NVMF_OPT_TOS can be
reused. I'll reuse it for IPv6 in v3 and drop this new "tclass" option.

Thanks,
-Geliang

