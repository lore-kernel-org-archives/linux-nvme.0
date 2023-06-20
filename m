Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37919EB64D7
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jun 2023 17:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ckPTi9x4BcZ72b51PKbAVCYPDmDkR4aQ7nI20QxxriU=; b=qxhpXcR6hN+ApGyA69CF35FBcm
	E9k3L15Y0QqhPT02T71hbO0muzBNxucD2Z86nWYTQuOFZUrG05pAx/+Qzuof/v584aFo604BpxHo6
	Yr3bbisVGtUzXhPf9cJpBEKdxTDteAUmrqedldJXWgSiv0fDOGMzoJCLBxpo5fB3eHtFvotMrVVQy
	0oUGv500OttnGhcdDl+XxNcksq7O4Bz/SnLZ7wRlMAD/oWNzvrm0BxzSKp0qmccv5ZaJcTIl2Xf34
	B1citvBhsCLWhsaT0PBXBy8M/QB9onlTaxr6Ql2ldEpGvl+yR1vMKXqKW4m6k7spXPrhIz207L9d7
	H5G/y2lA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBeuQ-00BtwI-0Q;
	Tue, 20 Jun 2023 17:12:50 +0000
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBeuM-00Btuw-0L
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jun 2023 17:12:47 +0000
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-178-Izxe4cpJMDmCWSuzrGaxAg-1; Tue, 20 Jun 2023 13:12:35 -0400
X-MC-Unique: Izxe4cpJMDmCWSuzrGaxAg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83DC190A904;
	Tue, 20 Jun 2023 17:12:34 +0000 (UTC)
Received: from hog (unknown [10.39.195.41])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E3B714682F7;
	Tue, 20 Jun 2023 17:12:33 +0000 (UTC)
Date: Tue, 20 Jun 2023 19:12:31 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 2/4] net/tls: handle MSG_EOR for tls_device TX flow
Message-ID: <ZJHd_2g-3-e8TNQU@hog>
References: <20230620102856.56074-1-hare@suse.de>
 <20230620102856.56074-3-hare@suse.de>
MIME-Version: 1.0
In-Reply-To: <20230620102856.56074-3-hare@suse.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230620_101246_304094_4A85FF8C 
X-CRM114-Status: GOOD (  18.17  )
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

2023-06-20, 12:28:54 +0200, Hannes Reinecke wrote:
> tls_push_data() MSG_MORE / MSG_SENDPAGE_NOTLAST, but bails
> out on MSG_EOR.
> But seeing that MSG_EOR is basically the opposite of
> MSG_MORE / MSG_SENDPAGE_NOTLAST this patch adds handling
> MSG_EOR by treating it as the absence of MSG_MORE.
> Consequently we should return an error when both are set.
>=20
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  net/tls/tls_device.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>=20
> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> index b82770f68807..ebefd148ecf5 100644
> --- a/net/tls/tls_device.c
> +++ b/net/tls/tls_device.c
> @@ -440,11 +440,6 @@ static int tls_push_data(struct sock *sk,
>  =09int copy, rc =3D 0;
>  =09long timeo;
> =20
> -=09if (flags &
> -=09    ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_SENDPAGE_NOTLAST |
> -=09      MSG_SPLICE_PAGES))
> -=09=09return -EOPNOTSUPP;
> -
>  =09if (unlikely(sk->sk_err))
>  =09=09return -sk->sk_err;
> =20
> @@ -536,6 +531,10 @@ static int tls_push_data(struct sock *sk,
>  =09=09=09=09more =3D true;
>  =09=09=09=09break;
>  =09=09=09}
> +=09=09=09if (flags & MSG_EOR) {
> +=09=09=09=09more =3D false;
> +=09=09=09=09break;

Why the break here? We don't want to close and push the record in that
case? (the "if (done || ...)" block just below)


> +=09=09=09}
> =20
>  =09=09=09done =3D true;
>  =09=09}

Thanks,

--=20
Sabrina


