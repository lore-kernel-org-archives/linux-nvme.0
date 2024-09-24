Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71E0CF9C6F
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2024 11:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zJAhGfQMYvNPzIeoufgW5fDz4tAW2oyBAOHnbbMlmL0=; b=DqFiHfE12ZlWEczRXf2lxpFe/Z
	hmnNOiplc67crFbQ1+7mSfGUCEqsChhATRgzQQgpBwsP5Ml+b9PAUygcnWNujMwYSwufiN62ZO7Z0
	LNJYN/d7P5RyfDVpFSX4Y5d6ygRJLMOzr3guiWdLANj1RaINhxtYaWT2z3v79U3XIjTNfDDqerd7V
	pe59mrvTl/bYZcVglLcJMVuTFpvq8u62FuGvwNu8nrzk7NbNSUv0LqQeg/5Sgamulf5sE7bah0Za/
	ONJ/ibNpjYQ9SdUz+xviNLWdG4+Ie/mlbTx33rg0o2qzt1BHEN4iN/NbfCtYA4+ilsgdickXKHfm0
	YbdWc73Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1st43j-00000002EGt-0dWK;
	Tue, 24 Sep 2024 11:50:23 +0000
Received: from msk-mailedge.securitycode.ru ([195.133.217.143])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1st43e-00000002EF4-2DGp
	for linux-nvme@lists.infradead.org;
	Tue, 24 Sep 2024 11:50:20 +0000
From: George Rurikov <g.ryurikov@securitycode.ru>
To: Christoph Hellwig <hch@lst.de>
CC: George Rurikov <g.ryurikov@securitycode.ru>, Sagi Grimberg
	<sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch
	<kbusch@kernel.org>, Israel Rukshin <israelr@mellanox.com>, Max Gurtovoy
	<maxg@mellanox.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH] nvme: rdma: Add check for queue in nvmet_rdma_cm_handler()
Date: Tue, 24 Sep 2024 14:49:46 +0300
Message-ID: <20240924114946.1090615-1-g.ryurikov@securitycode.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: MSK-EX1.Securitycode.ru (172.17.8.91) To
 MSK-EX2.Securitycode.ru (172.17.8.92)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240924_045018_596572_E60806E0 
X-CRM114-Status: GOOD (  11.01  )
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

After having been assigned to a NULL value at rdma.c:1758, pointer 'queue'
is passed as 1st parameter in call to function
'nvmet_rdma_queue_established' at rdma.c:1773, as 1st parameter in call
to function 'nvmet_rdma_queue_disconnect' at rdma.c:1787 and as 2nd
parameter in call to function 'nvmet_rdma_queue_connect_fail' at
rdma.c:1800, where it is dereferenced.

I understand, that driver is confident that the
RDMA_CM_EVENT_CONNECT_REQUEST event will occur first and perform
initialization, but maliciously prepared hardware could send events in
violation of the protocol. Nothing guarantees that the sequence of events
will start with RDMA_CM_EVENT_CONNECT_REQUEST.

Found by Linux Verification Center (linuxtesting.org) with SVACE

Fixes: e1a2ee249b19 ("nvmet-rdma: Fix use after free in nvmet_rdma_cm_handl=
er()")
Cc: stable@vger.kernel.org
Signed-off-by: George Rurikov <g.ryurikov@securitycode.ru>
---
 drivers/nvme/target/rdma.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 1b6264fa5803..becebc95f349 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1770,8 +1770,10 @@ static int nvmet_rdma_cm_handler(struct rdma_cm_id *=
cm_id,
                ret =3D nvmet_rdma_queue_connect(cm_id, event);
                break;
        case RDMA_CM_EVENT_ESTABLISHED:
-               nvmet_rdma_queue_established(queue);
-               break;
+               if (!queue) {
+                       nvmet_rdma_queue_established(queue);
+                       break;
+               }
        case RDMA_CM_EVENT_ADDR_CHANGE:
                if (!queue) {
                        struct nvmet_rdma_port *port =3D cm_id->context;
@@ -1782,8 +1784,10 @@ static int nvmet_rdma_cm_handler(struct rdma_cm_id *=
cm_id,
                fallthrough;
        case RDMA_CM_EVENT_DISCONNECTED:
        case RDMA_CM_EVENT_TIMEWAIT_EXIT:
-               nvmet_rdma_queue_disconnect(queue);
-               break;
+               if (!queue) {
+                       nvmet_rdma_queue_disconnect(queue);
+                       break;
+               }
        case RDMA_CM_EVENT_DEVICE_REMOVAL:
                ret =3D nvmet_rdma_device_removal(cm_id, queue);
                break;
@@ -1793,8 +1797,10 @@ static int nvmet_rdma_cm_handler(struct rdma_cm_id *=
cm_id,
                fallthrough;
        case RDMA_CM_EVENT_UNREACHABLE:
        case RDMA_CM_EVENT_CONNECT_ERROR:
-               nvmet_rdma_queue_connect_fail(cm_id, queue);
-               break;
+               if (!queue) {
+                       nvmet_rdma_queue_connect_fail(cm_id, queue);
+                       break;
+               }
        default:
                pr_err("received unrecognized RDMA CM event %d\n",
                        event->event);
--
2.34.1

=D0=97=D0=B0=D1=8F=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BE =D0=BA=D0=BE=
=D0=BD=D1=84=D0=B8=D0=B4=D0=B5=D0=BD=D1=86=D0=B8=D0=B0=D0=BB=D1=8C=D0=BD=D0=
=BE=D1=81=D1=82=D0=B8

=D0=94=D0=B0=D0=BD=D0=BD=D0=BE=D0=B5 =D1=8D=D0=BB=D0=B5=D0=BA=D1=82=D1=80=
=D0=BE=D0=BD=D0=BD=D0=BE=D0=B5 =D0=BF=D0=B8=D1=81=D1=8C=D0=BC=D0=BE =D0=B8 =
=D0=BB=D1=8E=D0=B1=D1=8B=D0=B5 =D0=BF=D1=80=D0=B8=D0=BB=D0=BE=D0=B6=D0=B5=
=D0=BD=D0=B8=D1=8F =D0=BA =D0=BD=D0=B5=D0=BC=D1=83 =D1=8F=D0=B2=D0=BB=D1=8F=
=D1=8E=D1=82=D1=81=D1=8F =D0=BA=D0=BE=D0=BD=D1=84=D0=B8=D0=B4=D0=B5=D0=BD=
=D1=86=D0=B8=D0=B0=D0=BB=D1=8C=D0=BD=D1=8B=D0=BC=D0=B8 =D0=B8 =D0=BF=D1=80=
=D0=B5=D0=B4=D0=BD=D0=B0=D0=B7=D0=BD=D0=B0=D1=87=D0=B5=D0=BD=D1=8B =D0=B8=
=D1=81=D0=BA=D0=BB=D1=8E=D1=87=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=BE =
=D0=B4=D0=BB=D1=8F =D0=B0=D0=B4=D1=80=D0=B5=D1=81=D0=B0=D1=82=D0=B0. =D0=95=
=D1=81=D0=BB=D0=B8 =D0=92=D1=8B =D0=BD=D0=B5 =D1=8F=D0=B2=D0=BB=D1=8F=D0=B5=
=D1=82=D0=B5=D1=81=D1=8C =D0=B0=D0=B4=D1=80=D0=B5=D1=81=D0=B0=D1=82=D0=BE=
=D0=BC =D0=B4=D0=B0=D0=BD=D0=BD=D0=BE=D0=B3=D0=BE =D0=BF=D0=B8=D1=81=D1=8C=
=D0=BC=D0=B0, =D0=BF=D0=BE=D0=B6=D0=B0=D0=BB=D1=83=D0=B9=D1=81=D1=82=D0=B0,=
 =D1=83=D0=B2=D0=B5=D0=B4=D0=BE=D0=BC=D0=B8=D1=82=D0=B5 =D0=BD=D0=B5=D0=BC=
=D0=B5=D0=B4=D0=BB=D0=B5=D0=BD=D0=BD=D0=BE =D0=BE=D1=82=D0=BF=D1=80=D0=B0=
=D0=B2=D0=B8=D1=82=D0=B5=D0=BB=D1=8F, =D0=BD=D0=B5 =D1=80=D0=B0=D1=81=D0=BA=
=D1=80=D1=8B=D0=B2=D0=B0=D0=B9=D1=82=D0=B5 =D1=81=D0=BE=D0=B4=D0=B5=D1=80=
=D0=B6=D0=B0=D0=BD=D0=B8=D0=B5 =D0=B4=D1=80=D1=83=D0=B3=D0=B8=D0=BC =D0=BB=
=D0=B8=D1=86=D0=B0=D0=BC, =D0=BD=D0=B5 =D0=B8=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=
=D0=B7=D1=83=D0=B9=D1=82=D0=B5 =D0=B5=D0=B3=D0=BE =D0=B2 =D0=BA=D0=B0=D0=BA=
=D0=B8=D1=85-=D0=BB=D0=B8=D0=B1=D0=BE =D1=86=D0=B5=D0=BB=D1=8F=D1=85, =D0=
=BD=D0=B5 =D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D0=B5 =D0=B8 =D0=BD=D0=B5 =
=D0=BA=D0=BE=D0=BF=D0=B8=D1=80=D1=83=D0=B9=D1=82=D0=B5 =D0=B8=D0=BD=D1=84=
=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8E =D0=BB=D1=8E=D0=B1=D1=8B=D0=BC =
=D1=81=D0=BF=D0=BE=D1=81=D0=BE=D0=B1=D0=BE=D0=BC.

