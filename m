Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9C4C7EE2E
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jun 2023 16:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZLwQXcM7KrEQFWBQJ2/FK4P3db7LWlCxoLRI8M6uOGc=; b=RoPGqGBfYW+KQ5sj0m8f0wAhxR
	EwHkBot+5jSkbGia0AFxVd25iHzSZuqs6L9i2nkV3aCFYszvkflPoN7yX0TW576qaXs6zMQULtZ3N
	uYUlrhpG2t9i7Bh+HoBMQhQHlpNVDA+XasYgz83GqXwdDr6Sb/Sf6ElWKbg/Qpc7JQ2odcAElC2H9
	oTuVtrkR0rXV3DHtnWygMdn9sTQiSPccLZoxMoLxxb5xs9+wsjQ8WShN9JrKI4mXW+l2TOGhsW+xB
	CJfX+qvEnhsqqu789lrvSwVFiSi0EaUrf11Yk7/Hg7sFzGkpJHcrusgIhN9F1R3ToLpySaeonewOm
	1PWUkt0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7fA4-00Dd1I-29;
	Fri, 09 Jun 2023 16:40:28 +0000
Received: from [207.211.30.44] (helo=us-smtp-delivery-44.mimecast.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7f9q-00Dcu6-2u
	for linux-nvme@lists.infradead.org;
	Fri, 09 Jun 2023 16:40:26 +0000
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-o6MR5zBrNdeppXYYwN4WJQ-1; Fri, 09 Jun 2023 12:37:48 -0400
X-MC-Unique: o6MR5zBrNdeppXYYwN4WJQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDA923C13516;
	Fri,  9 Jun 2023 16:37:31 +0000 (UTC)
Received: from hog (unknown [10.45.224.200])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F31A40CFD00;
	Fri,  9 Jun 2023 16:37:29 +0000 (UTC)
Date: Fri, 9 Jun 2023 18:37:28 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH 1/4] net/tls: handle MSG_EOR for tls_sw TX flow
Message-ID: <ZINVSBkUyBMW_ZeB@hog>
References: <20230609125153.3919-1-hare@suse.de>
 <20230609125153.3919-2-hare@suse.de>
MIME-Version: 1.0
In-Reply-To: <20230609125153.3919-2-hare@suse.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230609_094015_404975_7B3C6BCA 
X-CRM114-Status: GOOD (  17.95  )
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

Hi Hannes,

2023-06-09, 14:51:50 +0200, Hannes Reinecke wrote:
> tls_sw_sendmsg() / tls_do_sw_sendpage() already handles
> MSG_MORE / MSG_SENDPAGE_NOTLAST, but bails out on MSG_EOR.
> But seeing that MSG_EOR is basically the opposite of
> MSG_MORE / MSG_SENDPAGE_NOTLAST this patch adds handling
> MSG_EOR by treating it as the negation of MSG_MORE.
>=20
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  net/tls/tls_sw.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 635b8bf6b937..be8e0459d403 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -953,9 +953,12 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *m=
sg, size_t size)
>  =09int pending;
> =20
>  =09if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
> -=09=09=09       MSG_CMSG_COMPAT))
> +=09=09=09       MSG_EOR | MSG_CMSG_COMPAT))
>  =09=09return -EOPNOTSUPP;
> =20
> +=09if (msg->msg_flags & MSG_EOR)
> +=09=09eor =3D true;

Is MSG_EOR supposed to be incompatible with MSG_MORE, or is it
supposed to cancel it? (ie: MSG_MORE | MSG_EOR is invalid, or
MSG_MORE | MSG_EOR behaves like MSG_EOR) The current code already
behaves as if _EOR was passed as long as MSG_MORE isn't passed, so
_EOR is only needed to cancel out _MORE (or in your case, because
NVMe-over-TLS sets it).

If _EOR and _MORE (or MSG_SENDPAGE_NOTLAST below) are supposed to be
incompatible, we should return an error when they're both set. If we
accept both flags being set at the same time, I think we should
document the expected behavior ("_EOR overrides _MORE/_NOTLAST") and
add specific selftests to avoid regressions.

--=20
Sabrina


