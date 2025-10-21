Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFBFCCD184
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Oct 2025 06:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c9Ml6gkIVvkg6HhVcG1Dq4Mv+UVF2GDesSqlO+RtFMU=; b=F7anIg+3Yd3a4BbOCvKfPk7Pi5
	t4etaTMYTTI728awJBq0V7emsGi56iVDR2PXLG2KBoPG1HLQeW43pjWw7TnZ0I5JMH/jivXYQwTp4
	+UylWjwazXxlr6i3LQEZei7GH4vQjqmrFJsRY+v9PCg7w5qWjtFcIZJX94Gb2eon7HK6D7+TEISxV
	lLlsmhPWfOypZ9r7ay4iVpD0HSA9pSyMxDbUZEVx9BLXzo03LRxXkBgNdQxJyXq3wFtk/5cLVYhrW
	Xz4j/WFIgx4OFOP7rWCm540juaWQxiM8UrX4ypUJ9BfKgC83IEPkEwmez+zdvpYlfWgwPf1J9UWCV
	rSqCoyzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vB5e6-0000000FuYh-098S;
	Tue, 21 Oct 2025 06:14:58 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vB5e3-0000000FuYI-3ROf
	for linux-nvme@lists.infradead.org;
	Tue, 21 Oct 2025 06:14:57 +0000
Received: from localhost (<unknown> [192.168.3.39])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id c1b0b4ec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 Oct 2025 08:14:53 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Oct 2025 08:14:53 +0200
Message-Id: <DDNS2QC0RU49.ZBFYG5AGV3FE@bsdbackstore.eu>
Cc: "hare" <hare@kernel.org>, "linux-nvme" <linux-nvme@lists.infradead.org>,
 "loberman" <loberman@redhat.com>
Subject: =?utf-8?q?Re:_[PATCH_V4_1/2]_nvme-tcp:_Prevent_infinite_loop_if_socket_cl?= =?utf-8?q?oses=0D_during_CONNECTING_state=E3=80=90=E8=AF=B7=E6=B3=A8?= =?utf-8?q?=E6=84=8F=EF=BC=8C=E9=82=AE=E4=BB=B6=E7=94=B1sagigrim@gmail.com?= =?utf-8?q?=E4=BB=A3=E5=8F=91=E3=80=91?=
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>,
 "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>, "sagi"
 <sagi@grimberg.me>, "Maurizio Lombardi" <mlombard@redhat.com>, "kbusch"
 <kbusch@meta.com>
X-Mailer: aerc
References: <20250404082801.1614252-1-mlombard@redhat.com>
 <20250404082801.1614252-2-mlombard@redhat.com>
 <c4695327-0a0d-4b8c-a852-ee2ce4beb924@grimberg.me>
 <D966L87J0CQ2.2WV0U5JZEMZ9Q@bsdbackstore.eu>
 <fc197a49-32f9-44ff-be3c-4efa1d42d0b0@grimberg.me>
 <D98XO9X62V98.1OGPR20IUZ9EO@bsdbackstore.eu>
 <0c60225a-6a48-484e-9526-27e699da4f1a@grimberg.me>
 <DAIV77646KWY.3QL4ZL1IH2630@bsdbackstore.eu>
 <d2ca6b0e-6a76-455d-be90-9e7527e33062@grimberg.me>
 <202510211137214079503@cestc.cn>
 <DDNRV5MAVQCF.2SH49C0P5MKVF@bsdbackstore.eu>
In-Reply-To: <DDNRV5MAVQCF.2SH49C0P5MKVF@bsdbackstore.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_231456_214817_62BBC626 
X-CRM114-Status: UNSURE (   9.96  )
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

On Tue Oct 21, 2025 at 8:05 AM CEST, Maurizio Lombardi wrote:
> On Tue Oct 21, 2025 at 5:37 AM CEST, zhang.guanghui@cestc.cn wrote:
>> This patch has not been merged yet,
>> So far, no other issues were found after merging this patch.
>
> Wait, do not merge it.
>
> nvme_tcp_error_recovery() should only be called when an -ENOPIPE error
> is detected. Other errors may be temporary, like -ENOPERM, and we
> shouldn't reset the connection in that case.
>
> Merging this patch as-is will make the blktests md/001 fail.
>
> Let me re-post a new version.

Also, as Sagi pointed out, during the initial connect there is no
expectation of error recovery, so there is more work to do.

Going to see if I can come up with something more robust.

Maurizio

