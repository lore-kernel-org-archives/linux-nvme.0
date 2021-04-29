Return-Path: <SRS0=qX5s=J2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C52C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 06:36:52 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FAE96143F
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 06:36:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FAE96143F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sg07zhT+Wkzc1F9rBYgwvBU9CXWbevy0qb68GRxgMZY=; b=rWbdI4aSZXl7Iu+q6QOGMDvSa
	7GkYTNNe3f6KC2wj+dFY4pc4pjYerZ+Xw1N0yH6pxffuDafyGdqxJ0XYBwwg2Tux685vrm4PyEq0S
	L2aNJrpGy4237g3Sh6vL9Rk7t7FJYTZZfQL2VqQAE9Rdp6+j6wlv69MhBVUiRvCiigYm006UbDy4I
	ca97PWFOGyBLTkp7m0/N6lMuYLi7q2WxFit7rzSn5zKM0vtAIK8cpc1UemQpf6wTEux0475R7uTyI
	sw9Sgb8paxd1GFpWeZRW1KN0a8QfmX1UpSqM2IcY4V45vRRSCRwT0/FGV0BVawACLXrBJOlOZf2Vf
	v8FTvYbDA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lc0I0-0055Wb-Na; Thu, 29 Apr 2021 06:36:44 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lc0Hx-0055WM-Q0
 for linux-nvme@desiato.infradead.org; Thu, 29 Apr 2021 06:36:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=yIM2dZExUFMd8vuuSkBRi0DgFW4KdCkMdR2UNZRxGh8=; b=0QF0COeVR5hWaT5yfS2QWIW2mL
 vewzcZa72EnKtLcqo2ZEjj89icGoHY5mcjfkGLWMfljh6VcLVLNWXCMcSHta/VXCvuwxXscZ2LV3W
 fWsIVH9ZnMZgU6FTSoRX4QnWi1M6aajE1BopWXH6rj6d+1tcYzg46i3xJx/E+rjzYiBi/jSXPeFle
 hjD2D63PjuPhMnAIhwc3r02iUlD9kHJ9nuu2Xlc0YZJxhCTgPMLOZk6hBktckmUNetwOzhdWl1Fwl
 ldJHQeNMwD9Mle2RGEd0F7oz27ADYWhfUscVQfD/0stjCtfIsKcGTcdlqRnBbEbqpucFnYOeyyi9c
 rbb0pIZQ==;
Received: from out4-smtp.messagingengine.com ([66.111.4.28])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lc0Hu-000PdN-RL
 for linux-nvme@lists.infradead.org; Thu, 29 Apr 2021 06:36:40 +0000
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id DD70E5C010F;
 Thu, 29 Apr 2021 02:36:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Thu, 29 Apr 2021 02:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm2; bh=yIM2dZExUFMd8vuuSkBRi0DgFW4
 KdCkMdR2UNZRxGh8=; b=o7g9d+Hn6uzK0jqa8Ln8sj2RSndmMfQWfjQFMxGsFXr
 N6cFmX2f8S/ohQU1+fRD2kQyLn+zo/8nwd9AONL3vgDHUp+fHPLkw+bf/3xZSS4u
 lfSFA8ZtEhYoRkSudibTq+HhIdNCIsm5KDJCCAki0K5417H8jvUMRw3ZCmWOCiTA
 34cpCCJLQfkforDYehp3VTZR1D48by+gXssrpxefzeEL5HvzKFPlZfa1ZFO5h94b
 48uHryDzI8gUPWPmMtlpumHvRCh7U5TC0o0IVHgwEuUYWn2dTxoHTD44M8ZJxWpy
 IGm3autin6eJ6upmbfbyAv14SoxW7sZ+efgsIFmgEcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=yIM2dZ
 ExUFMd8vuuSkBRi0DgFW4KdCkMdR2UNZRxGh8=; b=Niuq6PAprAMX4nQMe7hKg1
 lJ3hI6c7BhFYZX0PM4dk6/ALFxs799qFN7QWAHCybF8cSYYzRnuWLwPz83obt5lT
 KERiHY68SGRQa4ZoixZ+h7iRBr5O7FNHh1iKZZyQrFIjSivvf1yjnJic3uZrcX/r
 9UcMdV2tkfYXjWQrbf4xqOyHSb8pJ3swiWme35VQ9roukeOx7Ydl76BqqyXtxIu5
 gTFxrWpJAgfbopL0QE+AQSMfp0NBRUom/foegQpKo4yBhojLQSgtLXhXuqv+KLI8
 Qfs67NUPghMmr8mc++1CVnzc9X1Ob2coqf5/PAI6NKBeEJIvUnbzCZxPZWFzdhZw
 ==
X-ME-Sender: <xms:71OKYK051YKwl7Ud7DXbrCKCUP0kjzUwTMh-YBT9Isb5-Z8TUU4jDw>
 <xme:71OKYNEYDcDQDCIOZY4ffbvtay6clrhD1oOu4tD6a_f1XMBnzK0l4paF3u94Z8GAf
 vf7YiHtcIqXxWaVHDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddvfedguddtkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvddu
 ffeknecukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:71OKYC6v65_xIv4yvpm8KtgYZVm896bCu0rZxTRzCcW3hjIQewW24g>
 <xmx:71OKYL1WCH6oKqidNAXbpVXvZCCtEDqmvnnldwMZjSfZA0ZONB7WFA>
 <xmx:71OKYNGA-j_BT-vvq5DN2PrdN5ERUJCUrubClnDlSc15X7QGax8i4w>
 <xmx:8VOKYBhXhFRpp6R4zySw_TWShKgxU5XRcH-7HDYtVGj5IeQl0OM7Sw>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190]) by mail.messagingengine.com (Postfix) with ESMTPA;
 Thu, 29 Apr 2021 02:36:30 -0400 (EDT)
Date: Thu, 29 Apr 2021 08:36:28 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 chaitanya.kulkarni@wdc.com, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] nvmet: remove unsupported command noise
Message-ID: <YIpT7NFmkNc8EWfp@apples.localdomain>
References: <20210429042558.905404-1-kbusch@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210429042558.905404-1-kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210428_233639_165127_BE667B00 
X-CRM114-Status: GOOD (  10.03  )
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
Content-Type: multipart/mixed; boundary="===============8638843614113821647=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


--===============8638843614113821647==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sptXqTlgLVp13EFr"
Content-Disposition: inline


--sptXqTlgLVp13EFr
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr 28 21:25, Keith Busch wrote:
>Nothing can stop a host from submitting invalid commands. The target
>just needs to respond with an appropriate status, but that's not a
>target error. Demote invalid command messages to the debug level so
>these events don't spam the kernel logs.
>
>Reported-by: Yi Zhang <yi.zhang@redhat.com>
>Signed-off-by: Keith Busch <kbusch@kernel.org>
>---
> drivers/nvme/target/admin-cmd.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-c=
md.c
>index d2a26ff3f7b3..8175b61ae0a3 100644
>--- a/drivers/nvme/target/admin-cmd.c
>+++ b/drivers/nvme/target/admin-cmd.c
>@@ -307,7 +307,7 @@ static void nvmet_execute_get_log_page(struct nvmet_re=
q *req)
> 	case NVME_LOG_ANA:
> 		return nvmet_execute_get_log_page_ana(req);
> 	}
>-	pr_err("unhandled lid %d on qid %d\n",
>+	pr_debug("unhandled lid %d on qid %d\n",
> 	       req->cmd->get_log_page.lid, req->sq->qid);
> 	req->error_loc =3D offsetof(struct nvme_get_log_page_command, lid);
> 	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
>@@ -659,7 +659,7 @@ static void nvmet_execute_identify(struct nvmet_req *r=
eq)
> 		return nvmet_execute_identify_desclist(req);
> 	}
>
>-	pr_err("unhandled identify cns %d on qid %d\n",
>+	pr_debug("unhandled identify cns %d on qid %d\n",
> 	       req->cmd->identify.cns, req->sq->qid);
> 	req->error_loc =3D offsetof(struct nvme_identify, cns);
> 	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
>@@ -977,7 +977,7 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
> 		return 0;
> 	}
>
>-	pr_err("unhandled cmd %d on qid %d\n", cmd->common.opcode,
>+	pr_debug("unhandled cmd %d on qid %d\n", cmd->common.opcode,
> 	       req->sq->qid);
> 	req->error_loc =3D offsetof(struct nvme_common_command, opcode);
> 	return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
>--=20
>2.25.4
>

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

--sptXqTlgLVp13EFr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmCKU+oACgkQTeGvMW1P
DenpGQf/Xr7oqqIzXELAv7aDx5M0JUkSHe0/SlHkt3QZgfy516us688+mK11shkj
nK4EyWhfQry5IaGRaEOfvz54vekagis7vhKesWEbW26OWGX3jvcNQiBczuTVuPo5
rrAIAJT0x4dTNQSkZT22Wz18qf7yoz84QwWVgeemL2Aw2VP0dG+jcqtAh6VQLuCW
+GnUhBsDKGryGw2VIU6il52jaB0f69s4F2Y/aZF4DauW0/0DGqihHoIx6LnMDa5F
xpZbPvD1FsuDv4MdqK4lqTFvfXgs3DEIP7WZWjeY/nxkt4DTIvXV9uDjdDriAXVW
IdzGauZcXJ8zJ2FUjGxhO4QsWtMwJQ==
=XEfR
-----END PGP SIGNATURE-----

--sptXqTlgLVp13EFr--


--===============8638843614113821647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============8638843614113821647==--

