Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51B9C19776
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2025 12:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:Cc:To:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XS/kHt0Jzd2/r+Dt81keCnHWhP5OI706u2ZqfH4XrUs=; b=m+Tyg9d8V4NIB5Yyqr+LNh4NAG
	dJYdJ6YcInNwR0hNQdAuevQO6k5aVBUwnGCe/BFCeWWGB3XqeUkn6AB6Iu2xsq7CV6/xBcW8ZE/aI
	axRK6iMtllGUbegzUGADr0rplAYPClHV9hSZ0kw1C6TC8jR+0KBuo8c1UCCyikzPNP1ewZFF57dz6
	qmlkh3kgmkb+z9nLZx+MEh3F7V7xBIPqf2zkICXyxlwGKQynT3ykLhXSpocHlLDR1MtIcC6Vklb7L
	Ii/Q6C8LmS45rh/FKme8DYMZKJav/I+vPiha3nRo/P59Y+I5fPfn+7f7QWDBF6Q2dX8TRj+Z4ol0O
	Tyg2FNfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnzkH-0000000AyE0-0CES;
	Fri, 28 Feb 2025 12:45:37 +0000
Received: from mout.web.de ([212.227.17.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnzkE-0000000AyBe-0ZAB
	for linux-nvme@lists.infradead.org;
	Fri, 28 Feb 2025 12:45:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740746722; x=1741351522; i=markus.elfring@web.de;
	bh=XS/kHt0Jzd2/r+Dt81keCnHWhP5OI706u2ZqfH4XrUs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TcWhcU0HQG+S9SVlRqiA/vRsjsaCpAZGBLTFizh/p2oxAm+qbE17MbqtGW1Jrlrw
	 xJgrkJOxvRQpbGBUHlVPb67wqpRmf0z71pSiJhijLpRszenyzPznRQVuwlM6kGp++
	 DS6A+/c+ZnnoR5Y+z9ZSP05TlGpoQGCv7d0Vs1FW6hYPZUlzzo/h9Ty020vkj8jaQ
	 zoKM70PuOWFrkF8uRAhsA+nqEfLWxpYacjx6TCCPPNz7T/n3N+/fkw9C56jvreH18
	 eLZrIJn3hl27E+zjMW6p8uPEcixQLUm6p+n94IRYwQKCl/rdeiRiItxSLjbsoC9zT
	 92Mnc0dEhjremBdEPg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.27]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M6pUK-1twFLg1UZq-007I1m; Fri, 28
 Feb 2025 13:45:22 +0100
Message-ID: <6b6d7ad3-7d25-4cf2-ab96-ddeed341599a@web.de>
Date: Fri, 28 Feb 2025 13:45:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Qasim Ijaz <qasdev00@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] nvme-fc: Simplify minimum determination in two functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1JnjCFQUd0ttsIBWN281lO5nPMzTF+jyUeD2O/xAf3vIJ+adx7k
 cOdE3IDMpOUADsU0Ezq+bCzt4CYYDqWZI4Df2LgkrJaVT2o5yMdxVC6PgGRZIVvquEZC5XL
 fiJF/X0XuHknjvc4NlikDHSXTtwbIHSOI3D6fIPleypTR4u6fdtuhGdcFnu6FQrfO+9M7K6
 DqofhYYC7m9T1sYkKvN9g==
UI-OutboundReport: notjunk:1;M01:P0:T4P2JyVtn/I=;EqnSxa/PTVxsm/cBG5ow83DBN8i
 Dac87drCN06rmX+CMq0Um0gjexdwyVaCJWB55gTaE7u17FIoIZXyxVGOt78LaKZUwcx76oaCB
 mEbNcfMnpe923u/cPtkuze9+OTDKAmfmgTeGRWyKyna+slNxO2BwJc3xFXAEtlEP5SqweW6K2
 d20HdZFGEP8gGRKjZFnps0N4SBSIdjcUVSjfk9CHL4We9B3pOn0WV0q2SGATVqXobsC5G2SYE
 V92XQFymttWJUVJLpukvmkjAlxE8R9ZyPlsoNvEK9Iwdc0kYPeDri1lLFe/V/sCjuCZWL8STQ
 ny2vneUJd8+z32ujrPjSE0P5IdCGuu76VQEm+Fl/CzZXAPFr4xH3wQLdc3Wee7dEGcB/EwiDs
 355kFZTFOsr30+A3ClJPKjKeceuySivGEznva4SXliJRd1uf+nDdTKfa3ZYJ/aIL1BmwuF2KT
 +zdYTavyynkkKI9VSPFotx8UgAqI68fMxIwJtuyGuxcNzjRtz9UBDOTvysW/i/IB4bVwnrvOT
 44VdqlIdm9bDzea9n0lLDSYojt+Ey/rdz8p3U+VYD/ok+BbvH9Wy73We1ceWbj8eA20iA0mAW
 2Jj/FFzHTDG21RsCtNYSmJhpz06BIViNZQ79RvvVEHqsrFO8DYliX1pWuAfrqJzt//cVxl4l7
 i8qSEwRg9Na14PJidt4PGRyfLxKw/2bhZvPiLAE1/n9jBrbbAcUCoUZLppGQ5ZCc0GAtAzgui
 Ih0wkN43h9wnwD1hLm6IuOcZ38ESi2JtmwDsDMku56s4c9wOl/nqUGSBlYXwxfEB+hRkKKcK2
 xq8V86RZYdtFp3bfyc9IfjeocB5M8i1rW6wuOQYAqS7dNKC8cElix+f6Wxd62BJSHBdOmkfRi
 N7YwB46cVOze1RAKm1PEtjHxF4/TQwTBd0otnSEsZks9jVKZ3HjUuDHXPYLPr7rN+aOd0G3xo
 oyXAij6HouBhnz36flLfCxV0jgcqbedXpSoc8IRz1UsKtdnkhLrG5e6u2PGKZKR3R+AR18VrB
 sBM/NRO1aPveldW4+PNyXfP5BEKw+VE5cEbyWY4EbyM4/zP/4ylBN/NpzS24jqXOs/VRVpd33
 LrKaZjwK4lrOreTt5FF0qJoWcbVvHOo8A2uLvVtPQg0zQcQeryxO9WmRAK4k3oux5fANZOXf0
 MMjSFgIR3z/8brwiDhzZaEBMwY3sjMCiw3ZgiXlwHO8Ts5NAAC3gCaNartl6XT5+3+t6Y/2iQ
 I/LnO9BHHePy0ikMp+DavDiqZ5Onib9H2ru2D4U8bnzW1qnpClL/5ovndZpq9MDmky+fLDM+W
 28amjEu7Tx+Nd5V1xqvTWiVjfC31zW2RVOvEUlV+9g33MHdGZBjH0S4u1NOtJS3d1rLpByuN/
 xvMRmjaTfo0wsYCgnlAEbfSx78WzZgbI5emsA/GvN31ISEYrrKuwcNiaGZYFthI/9XqcgCvoq
 FluLISw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250228_044534_548216_EF3780D5 
X-CRM114-Status: UNSURE (   7.62  )
X-CRM114-Notice: Please train this message.
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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 28 Feb 2025 13:38:38 +0100

Replace nested min() calls by single min3() call in two
function implementations.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/nvme/host/fc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b9929a5a7f4e..6eed3ecdbaf6 100644
=2D-- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2858,8 +2858,7 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 	unsigned int nr_io_queues;
 	int ret;

-	nr_io_queues =3D min(min(opts->nr_io_queues, num_online_cpus()),
-				ctrl->lport->ops->max_hw_queues);
+	nr_io_queues =3D min3(opts->nr_io_queues, num_online_cpus(), ctrl->lport=
->ops->max_hw_queues);
 	ret =3D nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
 	if (ret) {
 		dev_info(ctrl->ctrl.device,
@@ -2912,8 +2911,7 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl=
)
 	unsigned int nr_io_queues;
 	int ret;

-	nr_io_queues =3D min(min(opts->nr_io_queues, num_online_cpus()),
-				ctrl->lport->ops->max_hw_queues);
+	nr_io_queues =3D min3(opts->nr_io_queues, num_online_cpus(), ctrl->lport=
->ops->max_hw_queues);
 	ret =3D nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
 	if (ret) {
 		dev_info(ctrl->ctrl.device,
=2D-
2.48.1


