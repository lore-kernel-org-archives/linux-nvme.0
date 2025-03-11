Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D33C282EC
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Mar 2025 10:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:From:
	Subject:Cc:To:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GehJoLnRmC+ShMTTX3BOeeGj93hyT0k5YeIvHqpVODc=; b=ULMrB9WyEDihxKRsoPVU9azG6w
	yXBpZ6yCESV5GFK/zubFR2uleZ++iNdDCWRFHP48DSeRSGwTIJ7JUWJ0xfqh5Gb0eQi23ug9br/Z0
	/6/NMBV/aNJgPO9GD8tGVIWGaJaRfY8Kj5oF7FPM0/AIAgFHB4SxFZaFWFSrfuZ5qPjstsuuUBpGY
	sQdrGrJMLl5qNBJZfxans7IEju44ChVrON7sCO+Us3LZPU+SXpNT4lpfjHPVzhskp/qdyzCWoOSyZ
	ih3xoPW65yimDdQW/dOVEFY+WXaEzwwOcMSnPudqhvBuSEF5knGQuMNcxON9wM5RbLpMFQSsQPqw/
	iPmOvz4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trxEj-00000005OKz-46H2;
	Tue, 11 Mar 2025 10:53:25 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trxDr-00000005ODO-1A3W
	for linux-nvme@lists.infradead.org;
	Tue, 11 Mar 2025 10:52:33 +0000
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id ccc6a89d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Mar 2025 11:52:26 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Mar 2025 11:52:24 +0100
Message-Id: <D8DDP6LIPOKB.2ACTHLE9FPI2A@bsdbackstore.eu>
To: "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>, "sagi"
 <sagi@grimberg.me>, "mgurtovoy" <mgurtovoy@nvidia.com>, "kbusch"
 <kbusch@kernel.org>, "sashal" <sashal@kernel.org>, "chunguang.xu"
 <chunguang.xu@shopee.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-nvme"
 <linux-nvme@lists.infradead.org>, "linux-block"
 <linux-block@vger.kernel.org>
Subject: =?utf-8?q?Re:_nvme-tcp:_fix_a_possible_UAF_when_failing_to_send_request?= =?utf-8?q?=E3=80=90=E8=AF=B7=E6=B3=A8=E6=84=8F=EF=BC=8C=E9=82=AE=E4=BB=B6?= =?utf-8?q?=E7=94=B1sagigrim@gmail.com=E4=BB=A3=E5=8F=91=E3=80=91?=
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
X-Mailer: aerc
References: <2025021015413817916143@cestc.cn>
 <aed9dde7-3271-4b97-9632-8380d37505d9@grimberg.me>
 <202503071810452687957@cestc.cn>
In-Reply-To: <202503071810452687957@cestc.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_035231_643979_9CF75F50 
X-CRM114-Status: UNSURE (   7.14  )
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

On Fri Mar 7, 2025 at 11:10 AM CET, zhang.guanghui@cestc.cn wrote:
>
> Hi=20
>
>         After testing this patch,   sending request failure occurred,   u=
nfortunately, the issue still persists.=20

Maybe I am completely wrong but I am still quite convinced that the problem=
 here
is that, despite the nvme_tcp_try_send() failure, the target sends a respon=
se capsule
for the command, leading to a double-completion in the host.

Sagi, what about taking this patch: https://lore.kernel.org/linux-nvme/2025=
0306160322.1370300-2-mlombard@redhat.com/T/#u
and do a step further by not completing the request, leaving the error
recovery handler the task of cleaning everything up?


diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 327f3f2f5399..72c1d7948386 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1328,8 +1328,8 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *q=
ueue)
 	} else if (ret < 0) {
 		dev_err(queue->ctrl->ctrl.device,
 			"failed to send request %d\n", ret);
-		nvme_tcp_fail_request(queue->request);
 		nvme_tcp_done_send_req(queue);
+		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
 	}
 out:
 	memalloc_noreclaim_restore(noreclaim_flag);


Maurizio

