Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32044606A31E
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2026 00:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=z/zxelwJ;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gdjFd6yl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=kiBFVYpJZV/z1Y7/aNci/WiL++vzCEQVBpC2tTo5b5c=; b=z/zxelwJw9RNUu
	KosvCkEHQ7NvxpV51yOYzfkFcs1/71jYuETL4ilNnumMudOnf80fo9pK/3SxSFZ3SHDRAecneR5Uv
	ej7aNbjfio9aKcaUPnW4Y7IeX94Bv7I+HB+6nGSWE3jNf2QFwUa9T9fr0N2Hsq59PrA9cD762TM4a
	CdYj/RRc37q3zG3ysCwDlviLygdUOSWQ5GoINkmUmbv+HqEha015v8YqlgAzss6Em74JA74T+ENXl
	YMR738LidZH98sAVWBJuV0F6v4RFP7vtDehHsQVbNQefkf8DrX9g+SNQc/2U/HfceN2RgudDzzbC5
	3oJ38v0FV3E3p+zDPp1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVeUv-00000005Gis-3FWH;
	Tue, 24 Nov 2026 00:35:01 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVeUu-00000005GiV-0OWj
	for linux-nvme@lists.infradead.org;
	Tue, 24 Nov 2026 00:35:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9C79040881;
	Tue, 24 Nov 2026 00:34:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D1E1F000C6;
	Tue, 24 Nov 2026 00:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795480499;
	bh=kiBFVYpJZV/z1Y7/aNci/WiL++vzCEQVBpC2tTo5b5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gdjFd6ylCYe3WifuWcTq7DnflOd7Jwq7O+OcWvLD36AlMDYuySmHI8EySL92MHbCr
	 OsJiA15ujNPK73U0NqMS57S9LcOg5nNHXOHRCe07btshprhyAFRyEuL30JIpau9n1Z
	 Bybni3PAips7Yfb3rWbATw3O+TQZaYapMJEqCrelsj+9wlder87puNluvBRuUYCN/k
	 WwOZUzN/4ZNwmaF7b59AIOXrTMWE5zPmC2pjxMpCPYCux7tHxXiA6eOghcZHVhUVRo
	 EIJmx+vsfGVELo1uYUxB8VBqnPIdyD3r9fVKagby+B/eVwgVjQS3q4sG1gM1pcNKXY
	 KET9Kc+RrEKhw==
Date: Mon, 23 Nov 2026 16:34:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Donald Hunter" <donald.hunter@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman"
 <horms@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>, "Sabrina
 Dubroca" <sd@queasysnail.net>, "Keith Busch" <kbusch@kernel.org>, "Jens
 Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg"
 <sagi@grimberg.me>, "Chaitanya Kulkarni" <kch@nvidia.com>, "Jeff Layton"
 <jlayton@kernel.org>, NeilBrown <neil@brown.name>, "Olga Kornievskaia"
 <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey"
 <tom@talpey.com>, "Eric Dumazet" <edumazet@kernel.org>,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, "Hannes
 Reinecke" <hare@kernel.org>
Subject: Re: [PATCH net-next v3 00/10] Deliver TLS session tags to
 upper-layer consumers (NFSD)
Message-ID: <20261123155242.49d87894@kernel.org>
In-Reply-To: <7a0695c2-bf7a-4394-8cfe-a92deeba51e3@app.fastmail.com>
References: <20261113-tls-session-tags-v3-0-91271964cdb0@kernel.org>
	<20261121161302.69f202c8@kernel.org>
	<7a0695c2-bf7a-4394-8cfe-a92deeba51e3@app.fastmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 22 Nov 2026 16:27:08 -0800 Chuck Lever wrote:
> On Sat, Nov 21, 2026, at 4:13 PM, Jakub Kicinski wrote:
> > Naively I'd think it creates unnecessarily wide API on both ends
> > (handshake and server). My knee jerk design would be to populate
> > the full policy in the server, and only carry some "policy ID"
> > thru the handshake. Number of policy IDs would equal to the number
> > of tag combinations (which result in different behavior). =20
>=20
> How is a tag much different than a policy ID?
>=20
> It wouldn=E2=80=99t be impossible to impose another layer here that makes
> a specific set of tags into a single policy, but I=E2=80=99m not seeing
> that doing such adds a lot of value.

My thinking was that we have two user space components (TLS handshake
handler and the storage server stack) which are required to render
their decision in the language of tags, and upload the result
to the kernel via independent APIs. The policy ID limits the kernel
to mechanical enforcement. The components resolve all decisions in user
space, and give the kernel full list of policy ID -> allowed resources.

Could be purely a subjective preference, I won't insist. Tho an ack
from someone experienced with building kernel (security?) policies
would be awesome.

BTW someone marked the patches as changes requested, so repost will be
needed.

