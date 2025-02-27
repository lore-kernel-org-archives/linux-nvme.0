Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D95C1B087
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Feb 2025 10:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LUd+h9JockvaSlU/KJxkSCYk4btE+Pu12kQj+oECITU=; b=jD8YfAI9SRY3QWtjA+hK2XQ2Z6
	6iOT+xi+CCjwhrGWKFC1XLX3wFri7lNs1oq5tjF9UdmDUzhnH/7BPgOCBWmNLTZeanu/WXdFfY1dk
	JWIDPShX8Yq0DoRzXgu7pGWN4NNZ3vYETqVNcykPHk+/hOFU8Q2/eDZkjVuhRi1x3w2L+/tSJ4nfb
	n1uw6MVYcTawc/LZifE4hqss0/GnVgzIHF2p0K/L/TUFVInAWf6NlVF9wQT0q92HqIH/EfCnx0/zo
	I7QE5CJGqkNGCCmJ5ojQP5t+62leRrkmWEstykS7BXvpbcKPdso3PqvndtiWkiaAnpCppJVhuJHQC
	Br82BOhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnbBY-000000070Ed-0R3Q;
	Thu, 27 Feb 2025 10:32:08 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnbAT-0000000709L-3XTq
	for linux-nvme@lists.infradead.org;
	Thu, 27 Feb 2025 10:31:03 +0000
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 0fb4f6d6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Feb 2025 11:30:56 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Feb 2025 11:30:54 +0100
Message-Id: <D835Q6NQGCWV.34NWJQSK6IA2N@bsdbackstore.eu>
Cc: <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>, <hare@kernel.org>
Subject: Re: [PATCH] nvme-tcp: Fix a C2HTermReq error message
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Maurizio Lombardi" <mlombard@redhat.com>, <kbusch@kernel.org>
X-Mailer: aerc
References: <20250224144058.693927-1-mlombard@redhat.com>
In-Reply-To: <20250224144058.693927-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250227_023102_219684_7E0C184D 
X-CRM114-Status: GOOD (  13.45  )
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

Ping.

Sagi, can you review this? It's just a trivial fix.

Thanks!
Maurizio

On Mon Feb 24, 2025 at 3:40 PM CET, Maurizio Lombardi wrote:
> In H2CTermReq, a FES with value 0x05 means "R2T Limit Exceeded"; but
> in C2HTermReq the same value has a different meaning (Data Transfer Limit
> Exceeded).
>
> Fixes: 84e009042d0f ("nvme-tcp: add basic support for the C2HTermReq PDU"=
)
>
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>  drivers/nvme/host/tcp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 8a9131c95a3d..183cc58ecded 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -775,7 +775,7 @@ static void nvme_tcp_handle_c2h_term(struct nvme_tcp_=
queue *queue,
>  		[NVME_TCP_FES_PDU_SEQ_ERR] =3D "PDU Sequence Error",
>  		[NVME_TCP_FES_HDR_DIGEST_ERR] =3D "Header Digest Error",
>  		[NVME_TCP_FES_DATA_OUT_OF_RANGE] =3D "Data Transfer Out Of Range",
> -		[NVME_TCP_FES_R2T_LIMIT_EXCEEDED] =3D "R2T Limit Exceeded",
> +		[NVME_TCP_FES_DATA_LIMIT_EXCEEDED] =3D "Data Transfer Limit Exceeded",
>  		[NVME_TCP_FES_UNSUPPORTED_PARAM] =3D "Unsupported Parameter",
>  	};
> =20


