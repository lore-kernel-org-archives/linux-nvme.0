Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80231075274
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Mar 2026 07:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iW6CQUF3YxORaCorXro4akbsawM3+QA7ihq+f4V2ctY=; b=KJGMiWHfRnFD0n997/1dU1xXbL
	LEwBtwzyRI2O3FIte8YXVaRtugHTGPjI3ZyH0MDHYG+xxHhJDbxJe2ld5ufuG/WdxDfauekyH31u8
	ihl3h56OzWTO0C3ZnOcMHBKIP1xbKDitO8N0DCjDHHN+b3IXHPP7cmKY3rwe5ajCRuKNJJgUh7SOG
	QJm6Dx6N7KHbnHPj8UufVaK4InQ/VXO4A6BQ+P3n3LKMwld+Y98jC1MyCALIc/jF/MbMspAhCDoUp
	7cLweGSmiL6joNUdShsA2UAsBFPX7OD8MMxuNO2tRAStWW+Agb6apWhVESlzbtTrC9LQ32rIspxx2
	Kby8mftw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w38Hn-0000000AC90-20TS;
	Thu, 19 Mar 2026 07:59:19 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w38Hh-0000000AC8P-0oZ1
	for linux-nvme@lists.infradead.org;
	Thu, 19 Mar 2026 07:59:18 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 9672f45e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Mar 2026 08:59:07 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Mar 2026 08:59:06 +0100
Message-Id: <DH6LLP692EBM.4N82LTNB60WV@arkamax.eu>
Cc: <security@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
 <kch@nvidia.com>, <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet-tcp: bound sgl->length check in
 nvmet_tcp_map_data()
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Shivam Kumar" <kumar.shivam43666@gmail.com>,
 <gregkh@linuxfoundation.org>
X-Mailer: aerc 0.21.0
References: <2026031805-stretch-skid-ae5b@gregkh>
 <20260319012630.1802025-1-kumar.shivam43666@gmail.com>
In-Reply-To: <20260319012630.1802025-1-kumar.shivam43666@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260319_005913_566586_7DA1E515 
X-CRM114-Status: GOOD (  17.04  )
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

On Thu Mar 19, 2026 at 2:26 AM CET, Shivam Kumar wrote:
> nvmet_tcp_map_data() reads the SGL length from the incoming NVMe command
> and passes it to sgl_alloc() for scatter-gather allocation. The only
> existing size check (len > inline_data_size) is gated behind
> sgl->type =3D=3D NVME_SGL_FMT_DATA_DESC | NVME_SGL_FMT_OFFSET, meaning an=
y
> other SGL type bypasses the validation entirely. A remote attacker can
> send a CapsuleCmd with a non-offset SGL type and a large sgl->length
> (e.g. ~3 GB) to trigger an excessive kernel allocation, resulting in a
> page allocator WARNING and kernel panic when panic_on_warn is set.
>
> Add an upper-bound check against NVMET_TCP_MAXH2CDATA before calling
> sgl_alloc(). This value is already advertised to the host in the ICResp
> maxdata field as the maximum data transfer size.
>
> Signed-off-by: Shivam Kumar <kumar.shivam43666@gmail.com>
> ---
>  drivers/nvme/target/tcp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index a456dd2fd8bd..c7253221c342 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -431,6 +431,8 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *c=
md)
>  			return NVME_SC_SGL_INVALID_OFFSET | NVME_STATUS_DNR;
>  		cmd->pdu_len =3D len;
>  	}
> +	if (len > NVMET_TCP_MAXH2CDATA)
> +		return NVME_SC_SGL_INVALID_DATA | NVME_STATUS_DNR;
>  	cmd->req.transfer_len +=3D len;
> =20
>  	cmd->req.sg =3D sgl_alloc(len, GFP_KERNEL, &cmd->req.sg_cnt);


I am not sure this patch is correct, the intent is valid but you are confla=
ting
the total transfer size with the H2CData maximum PDU size.

In other words, if I understood the code correctly:

MAXH2CDATA is the limit of a single H2CData packet's size.
sgl->length is the total amount of data to transfer.

Also, will the request be completed with "NVME_SC_SGL_INVALID_DATA |
NVME_STATUS_DNR" code? If yes, this would be a violation of the spec
that states that an H2CDATA with a too large size should trigger a
fatal transport error.

Maybe the correct fix is to set a sane default for MDTS
(Maximum Data Transfer Size), at the moment it's left to zero (no limit).

Maurizio


