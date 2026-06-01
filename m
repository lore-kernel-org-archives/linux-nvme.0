Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E6FCD5BD1
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jun 2026 08:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:Cc:To
	:Subject:Message-ID:From:Content-Transfer-Encoding:Content-Type:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7i6dypURVTbR75PULfoiba2GsQ19C8ZDxeRT25Zix4A=; b=U8APS4hLlRBiw9zRxMAJMqmPEp
	FclJXWd2wIH1lB6/oA2r0kwugKaI4rZVgQmq33GhuCicLJBI2WIyj3BmLYy9wCKMx5R9SqOawxFbP
	IUvslWHI6w6EGvc01i/9Kockf/dScQtuXGrkMU0J/Bn3p3xFxIPIG7LG67ncmpRGvtNUhclotPX2z
	9TeId1xqGKZzde21QPd5WnkyN6x2NFZyGq1xYHIbSfjSa5BtCmjZII26IeYUBpZFwshvT732E9vsY
	R6A1TtuNnpVyMMzLIaz/u8NSWVMosanfJLoHakJ6uN4YCkZ/G6pV0STNH6k4L2m5F8RxGr4cBCQbt
	6DbcFT2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTyU5-0000000ARQ8-1mnY;
	Mon, 01 Jun 2026 08:58:57 +0000
Received: from mta1.migadu.com ([2001:41d0:203:375::] helo=out-177.mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTyU1-0000000ARO5-3B4J
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jun 2026 08:58:56 +0000
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780304303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7i6dypURVTbR75PULfoiba2GsQ19C8ZDxeRT25Zix4A=;
	b=oV+QQ9kmYKhdIeFtQd4Hyx1cdi9/omGzsPJC1YRRnv66k/f1higWDiK7mfAUe3flbDOZRZ
	yu803nLfezzWWIdLiOErlinsOmq5ZTBKCr16CqMsUxdRcASGtxcHI7YkUP4zMlPkGOcHWx
	8icJp2nSwV2Y6za2N8HJrBwbTsybkNw=
Date: Mon, 01 Jun 2026 08:58:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Tianchu Chen" <tianchu.chen@linux.dev>
Message-ID: <c023c72aa183dd31fc9a2d7e9781c5551d5cdb9f@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] nvmet-auth: validate reply message payload bounds
 against transfer length
To: "Christoph Hellwig" <hch@lst.de>
Cc: hare@suse.de, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
In-Reply-To: <20260601071921.GB7582@lst.de>
References: <f4aca9b14e74a7f7f8cd9620e13cc32a6a2b7746@linux.dev>
 <20260601071921.GB7582@lst.de>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_015854_939057_C4F352B5 
X-CRM114-Status: GOOD (  23.17  )
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

June 1, 2026 at 3:19 PM, "Christoph Hellwig" <hch@lst.de mailto:hch@lst.d=
e?to=3D%22Christoph%20Hellwig%22%20%3Chch%40lst.de%3E > wrote:


>=20
>=20On Fri, May 29, 2026 at 02:18:39PM +0000, Tianchu Chen wrote:
>=20
>=20>=20
>=20> From: Tianchu Chen <flynnnchen@tencent.com>
> >=20=20
>=20>  nvmet_auth_reply() accesses the variable-length rval[] array using
> >  attacker-controlled hl (hash length) and dhvlen (DH value length) fi=
elds
> >  without verifying they fit within the allocated buffer of tl bytes.
> >=20=20
>=20>  A malicious NVMe-oF initiator can craft a DHCHAP_REPLY message wit=
h a
> >  small transfer length but large hl/dhvlen values, causing out-of-bou=
nds
> >  heap reads when the target processes the DH public key (rval + 2*hl)=
 or
> >  performs the host response memcmp.
> >=20=20
>=20>  With DH authentication configured, the OOB pointer is passed direc=
tly to
> >  sg_init_one() and read by crypto_kpp_compute_shared_secret(), reachi=
ng
> >  up to 526 bytes past the buffer. This is exploitable pre-authenticat=
ion.
> >=20=20
>=20>  Add bounds validation ensuring sizeof(*data) + 2*hl + dhvlen <=3D =
tl before
> >  any access to the variable-length fields.
> >=20=20
>=20>  Discovered by Atuin - Automated Vulnerability Discovery Engine.
> >=20=20
>=20>  Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authenticatio=
n")
> >  Cc: stable@vger.kernel.org
> >  Signed-off-by: Tianchu Chen <flynnnchen@tencent.com>
> >  ---
> >  drivers/nvme/target/fabrics-cmd-auth.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >=20=20
>=20>  diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme=
/target/fabrics-cmd-auth.c
> >  index f1e613e7c..0a85acf1e 100644
> >  --- a/drivers/nvme/target/fabrics-cmd-auth.c
> >  +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> >  @@ -132,13 +132,22 @@ static u8 nvmet_auth_negotiate(struct nvmet_re=
q *req, void *d)
> >  return 0;
> >  }
> >=20=20
>=20>  -static u8 nvmet_auth_reply(struct nvmet_req *req, void *d)
> >  +static u8 nvmet_auth_reply(struct nvmet_req *req, void *d, u32 tl)
> >  {
> >  struct nvmet_ctrl *ctrl =3D req->sq->ctrl;
> >  struct nvmf_auth_dhchap_reply_data *data =3D d;
> >  - u16 dhvlen =3D le16_to_cpu(data->dhvlen);
> >  + u16 dhvlen;
> >  u8 *response;
> >=20=20
>=20>  + if (tl < sizeof(*data))
> >  + return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
> >  +
> >  + dhvlen =3D le16_to_cpu(data->dhvlen);
> >  +
> >  + /* Validate that hl and dhvlen fit within the transfer length */
> >  + if (sizeof(*data) + 2 * (size_t)data->hl + dhvlen > tl)
> >=20
>=20Can't still still overflow? This should probably use struct_size
> to get the size up to and including the rval array, then
> use use checked subtractions from tl.
>

Thanks for the review.

I think the current patch doesn't actually allows overflow.

hl is a __u8 and dhvlen is a __le16. So the maximum value of
sizeof(*data) + 2 * (size_t)data->hl + dhvlen
is 66061, which is far below SIZE_MAX. It can't wrap.

About rewritting using struct_size: we still need to check
tl >=3D struct_size(data, rval, 0) first, which is exactly the same
as just using sizeof(*data) in current patch. Because we have to
confirm the header is fully present before we can even read
hl / dhvlen, which are the values that determine the minimum
required rval[] length.

So I believe the current patch already achieves the intended
goal of validating the payload against the buffer size,
using struct_size won't change the behavior.

That said, I'm happy to send a v2 that uses struct_size(data, rval, 0)
as the header anchor and then peels off the variable parts=20
with=20checked subtractions, if you prefer that style:

size_t size =3D struct_size(data, rval, 0); /* check the header is fully =
present */
if (tl < size)
	return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
tl -=3D size;
/* rval[] carries: response (hl) + challenge (hl) + DH value (dhvlen) */
if (tl < 2 * (u32)data->hl)
	return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
tl -=3D 2 * (u32)data->hl;
dhvlen =3D le16_to_cpu(data->dhvlen);
if (tl < dhvlen)
	return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;

Which one do you prefer? Just let me know which you'd prefer and I can se=
nd=20
a=20v2 if needed.


Best regards,
Tianchu

