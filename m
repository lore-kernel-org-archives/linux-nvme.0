Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981E0C43458
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Jun 2026 04:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:
	Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g33rmq9Rlq2iClwAL+H3RfpWb9p57xOuPZbPDUcvWTo=; b=yvp4Ln8+pGHpOWOgVL9DWRdGPs
	WjA49ZQLS+7tsMQBwd44ndiFdcS3GPdjXsiZasChkzDMmmVH4UaC0KqZ4ZQ+VXjH/X2H7dnaPlg+G
	mjtvBXvVCN+O/uFLrRCHa+CGrttuFjxNbswlsQfFSnw/eh3QsKSAzcVi/5i1vVWb6Nr243NLQbQNk
	rWmb+kvYh4FEE0PrAumj+s7oOfIvQT2Iq9vtE8fOaX1vG3MW83vygwwXuuKMSWYUQ6L4py85N550Z
	Xqi6eY216F/lf64FIlwBu49rQ5QhnCW/Qp/dX1KchMq+dNFUAb+R2sTP6L44CkF6+TDFAAp8SV8iO
	dijNEVNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdgiw-0000000Cu7r-0XKa;
	Sun, 28 Jun 2026 04:02:26 +0000
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdgio-0000000Cu7M-2cXk
	for linux-nvme@lists.infradead.org;
	Sun, 28 Jun 2026 04:02:20 +0000
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-01 (Coremail) with SMTP id qwCowAD3j8h4nEBq+V6qAw--.55335S7;
	Sun, 28 Jun 2026 12:02:15 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: nvmet: nvmet_sq_create: fix ctrl reference leak on
 nvmet_check_sqid   failure
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626154043.53241-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 12:02:05 +0800
Cc: Keith Busch <kbusch@kernel.org>,
 stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E4DA546F-94F7-4B5C-975C-1BC3BE622F7F@iscas.ac.cn>
References: <20260626154043.53241-1-vulab@iscas.ac.cn>
To: Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID: qwCowAD3j8h4nEBq+V6qAw--.55335S7
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1rZF4DGF17JryfWFy3Arb_yoW8GFWrpF
	s8Kr4jyrZxGFZ7ta1xAw4Y9FyF9w45KryUCwn5Kw1xZrn0q3y3Ar4DW3Wjvr15GrWrGry3
	JF4jyFy0ga45ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBEb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
	jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2
	z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
	IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIx
	AIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jedgAUUUUU
	=
X-Originating-IP: [117.182.74.7]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwIMA2pAixEc0gAAs0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260627_210219_197800_4C57E3A4 
X-CRM114-Status: GOOD (  13.14  )
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



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 23:40=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> After kref_get_unless_zero successfully acquires a ctrl reference, the
>  nvmet_check_sqid failure path returns the status directly without =
calling
>  nvmet_ctrl_put, leaving the ctrl reference permanently leaked.
>=20
> Add nvmet_ctrl_put before returning on the nvmet_check_sqid error path =
to
>  properly release the acquired reference.
>=20
> Cc: stable@vger.kernel.org
> Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/nvme/target/core.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 62dd59b9aa4f..52fc2dade4ea 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -943,8 +943,10 @@ u16 nvmet_sq_create(struct nvmet_ctrl *ctrl, =
struct nvmet_sq *sq,
> 		return NVME_SC_INTERNAL | NVME_STATUS_DNR;
>=20
> 	status =3D nvmet_check_sqid(ctrl, sqid, true);
> -	if (status !=3D NVME_SC_SUCCESS)
> +	if (status !=3D NVME_SC_SUCCESS) {
> +		nvmet_ctrl_put(ctrl);
> 		return status;
> +	}
>=20
> 	ret =3D nvmet_sq_init(sq, cq);
> 	if (ret) {
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang=


