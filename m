Return-Path: <SRS0=DVYa=NY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BDFC432BE
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Sep 2021 10:01:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DCBC60F4B
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Sep 2021 10:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4DCBC60F4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MU85yjboOKszkwNrZ+kp10E5AHRwnzDFL4fhL9SQev4=; b=F1iYgiRjc2tyTK1Vuij4nSJQ5V
	xfCpv+HyCuDj3Pa04RV+egMvHoXGuN6CJ/X2+pu3MBu13ignAwLNMLHSPMyE3OACRWdxLk3WA43bU
	50sn35slqkQngtbfSEhaXLg33maNKGF5JffDPkFkF4KztdcCfXMHb/DakAKdDUDjzc6PhDj9tLZxa
	5btQZL51S6ox79Uy/DmznIWJ+Cx6qTjUO4HXBA6gnlonTbNDRf3DjOUeIzwAb1CcGcnQp+2lsAzBu
	5Si7nEf5DV5qKj8IrwT1YjnM+7kVwa2lhWP9K1ZqcIvEUBpKoGYOEGwtptbxUnpGMcwAVpJRdan1H
	bOCW2YJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mLjX5-009EtE-W2; Thu, 02 Sep 2021 10:01:20 +0000
Received: from wout2-smtp.messagingengine.com ([64.147.123.25])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLjWt-009ElJ-PE
 for linux-nvme@lists.infradead.org; Thu, 02 Sep 2021 10:01:12 +0000
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id 77A4232009A5;
 Thu,  2 Sep 2021 06:01:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Thu, 02 Sep 2021 06:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm3; bh=zWDvdTbrknpIy519oMSXzEm4rmg
 0e6vL94EeKrqmvIY=; b=RWLZDn7UtiyZm9Oa5232yAE+ZPhcbvfIrp6SA8N+5Fs
 SntUbqWMA4qyoWpEEUXG87xUtZCmF7S9p9OmOH4k+5eiwHC4Epl1/N5is0QCM9AN
 BOMkfC7axGcgC9A0KXxInOMcKlsQesU5siRet/zbkE6lgrW3NChWz4yfD003fhIt
 IFE0XJDx06rxWjdSRCCc3l1iapsSzoUl7K35mQgnntMn+/Lc7mrfz8Mo6RZzYUYl
 +WxfdvVcuCyqL0DJRtpBapLlOIu6aJV+U5VEa2kT1f07Tj4uez3MVdhub5EP8NNX
 huN5SQdju9Rdu1Bv807uUuU709VNwHdHoIVVuFn7oCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=zWDvdT
 brknpIy519oMSXzEm4rmg0e6vL94EeKrqmvIY=; b=USvDoudOuBYa8407vCPLzG
 RBbh20ADst1vg0DNjr4KDPDxpHNuxvYgr//xsogGqFUjEQpUHFrBexUNowZrZc5f
 F+FJgPzitaNc3IJLdADdqP0bejHPcXmd4SNZQhLHxfinRanzK/MfvhMng4PwwaX0
 SHJ4nQ9tdINlZeRRym5xLqS0m11gu1JIkOfcwnR/T4hk/zjqNOQMGAK8+r8ogjMm
 V7M8EzLhvTDssP5FTxzZphP7RqijbXyhqtfr+J7kHVpIRsPyxEZeXhBtw06tiepZ
 x/BbKOgW1Av68JzVt4eQ/mzvZcnHZUQexLOpCqzvtXaF5NtpK3xF0210v5+ye7Mw
 ==
X-ME-Sender: <xms:26AwYR4h8vQEJSwz7Y2Z1DPgIhRm5VQEVCg1oO56EDyENbmYw2S2Xw>
 <xme:26AwYe4pd6iHZP_1-tbs6T1IOUEojlrpN_x1Xe6mtFiYFKz54vd_ZwedZtM1XX8Iw
 uMMBd2LiGxkCnmREww>
X-ME-Received: <xmr:26AwYYcGMc2Ou63kn_j1hbVsgp7aWbYjUW4tkkbV_ob7puG41T_aG0aSeujbvvKzy-z78HHUbe1KphdwxZ0jFOieDWJBkh7oExWG_TTLX4lU6plA2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvhedgvddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
 ertddtjeenucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgv
 vhgrnhhtrdgukheqnecuggftrfgrthhtvghrnhepjeegudffueeiteekieelkedvueelte
 evjeduieeludfffeejgeffhfduvdduffeknecuvehluhhsthgvrhfuihiivgeptdenucfr
 rghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:26AwYaJ9FMUl-MUl1qmgFMpSWu26l-HoWf97F7bVnf_AnMlHciit8g>
 <xmx:26AwYVLONNx1ORF-fCnn6lSAVNM0_FIz_bJvL81Dm9RY9XiALRU3Zg>
 <xmx:26AwYTwhWAQqWgCtkCR8z2PrOdH4FhzrjALhK0AiZ6fgNmHywAJQLg>
 <xmx:3aAwYV3yVEMKvqgdaJvXHlUvUFNJJDCfc1Uq1IZMC7SOmyQWdSj9lw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Sep 2021 06:00:58 -0400 (EDT)
Date: Thu, 2 Sep 2021 12:00:54 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: amit.engel@dell.com
Cc: sagi@grimberg.me, hch@infradead.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: return Invalid Log Page status code for
 unsupported lid
Message-ID: <YTCg1pXB83YsEDvD@apples.localdomain>
References: <20210902085333.32107-1-amit.engel@dell.com>
MIME-Version: 1.0
In-Reply-To: <20210902085333.32107-1-amit.engel@dell.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210902_030108_085624_C32CE7F7 
X-CRM114-Status: GOOD (  19.78  )
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
Content-Type: multipart/mixed; boundary="===============5048356314713215643=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


--===============5048356314713215643==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HilfHLcMXyqe6fpM"
Content-Disposition: inline


--HilfHLcMXyqe6fpM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep  2 11:53, amit.engel@dell.com wrote:
> From: Amit Engel <amit.engel@dell.com>
>=20
> In case of an invalid or not supported log page
> return NVME_SC_INVALID_LOG_PAGE
>=20
> Signed-off-by: Amit Engel <amit.engel@dell.com>
> ---
>  drivers/nvme/target/admin-cmd.c | 2 +-
>  drivers/nvme/target/discovery.c | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c
> index aa6d84d8848e..5dcda2c87fdd 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -339,7 +339,7 @@ static void nvmet_execute_get_log_page(struct nvmet_r=
eq *req)
>  	pr_debug("unhandled lid %d on qid %d\n",
>  	       req->cmd->get_log_page.lid, req->sq->qid);
>  	req->error_loc =3D offsetof(struct nvme_get_log_page_command, lid);
> -	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
> +	nvmet_req_complete(req, NVME_SC_INVALID_LOG_PAGE | NVME_SC_DNR);
>  }
> =20
>  static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
> diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discov=
ery.c
> index 7aa62bc6ae84..fdd52dbdd00f 100644
> --- a/drivers/nvme/target/discovery.c
> +++ b/drivers/nvme/target/discovery.c
> @@ -176,9 +176,11 @@ static void nvmet_execute_disc_get_log_page(struct n=
vmet_req *req)
>  		return;
> =20
>  	if (req->cmd->get_log_page.lid !=3D NVME_LOG_DISC) {
> +		pr_err("unhandled get log page cmd with lid %#x from ctrlid %d\n"
> +			req->cmd->get_log_page.lid, ctrl->cntlid);
>  		req->error_loc =3D
>  			offsetof(struct nvme_get_log_page_command, lid);
> -		status =3D NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +		status =3D NVME_SC_INVALID_LOG_PAGE | NVME_SC_DNR;
>  		goto out;
>  	}
> =20

This should only be done if the target is reporting v1.4 or above.

But honestly I'm not sure if there is any benefit to potentially
breaking hosts here. It is perfectly ok for a v1.4 compliant controller
to continue using Invalid Field in Command in this case.

The spec actually says that the controller *should* abort the command
with a status code of Invalid Field in Command. But I acknowledge that
v1.4+ specs are a bit contradictory here.

--HilfHLcMXyqe6fpM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmEwoNQACgkQTeGvMW1P
Den7dwgAlGzZHW4dyRzEA72yPvoAsbC8H88D8VXHgPaJgeA9KJEnNyfrmD5OE3RY
esvOWBaXetPg/5G0BP7V1rIAt9bodJ77b9FQ8qbiaRNgzNDoyY+GmzHGTz/XFWpB
EtYL9SF1q3OFSRh7SrARtxh72ish3BNH2AmSEfErjdJ6pvL68j273MbetEIJnFtY
wL7JLo1pn84sY5gfB+uLpyEtDTgTcpNtzyjoD7QmerPn8B7UCyxvTxD/8+fP346F
/cijUl1/Yapp3kK5I58cII5EIRJTtkbW5rZNfuz5uMYgjgE/2Cg93qgWHd9TgSxP
V2sFaBPt9kSCUj+U5ryf2LhZs7WWug==
=gmw/
-----END PGP SIGNATURE-----

--HilfHLcMXyqe6fpM--


--===============5048356314713215643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============5048356314713215643==--

