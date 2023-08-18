Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9286BC001DE
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Aug 2023 08:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=elHzctRz/z3PfTIhGYJKd0TeBTmca98Y+JNgX4gfsPI=; b=c4IEY1pavyilnm3EyS16/o34Iz
	vbULemGFltLDS667SbnduhVXtln7O/Mk/fd8dyF8nPHVVC54YfUHqyagzYdKuqcKRhRPWfgq54VOv
	saMswdOz+Ijek+V7MrJBWrnX0JMSvJXZeIwLYisXZCi8XbH1RP/zDyBNl+xaGgswy9sZeHUKCwfsb
	a/Nc9yRYo2tobzb4bBRu5+O0a096EUlK86BWBvI+7M5ogVvz1LrXZkzcuTz5RAC3CWkUXstVKgXbG
	+UmMrWodIoP2uitUIxUcz8xVMzrAHS+kuXuM7Iq8a+gLJSb13fjQr7xRX/kj5c+lGqPIR8kG8iAa7
	2fi/uzww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWugQ-007yks-0j;
	Fri, 18 Aug 2023 08:18:14 +0000
Received: from mail.leachkin.pl ([217.61.97.203])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWugM-007yjz-2V
	for linux-nvme@lists.infradead.org;
	Fri, 18 Aug 2023 08:18:13 +0000
Received: by mail.leachkin.pl (Postfix, from userid 1001)
	id 4203B83EC2; Fri, 18 Aug 2023 09:16:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leachkin.pl; s=mail;
	t=1692346571; bh=elHzctRz/z3PfTIhGYJKd0TeBTmca98Y+JNgX4gfsPI=;
	h=Date:From:To:Subject:From;
	b=iMF9mR/nhyN89ENKl6+W7zyZd7Ur1ccFhuZXt/Nflxuf0fCqwgC5sydus+pCoghea
	 bmagFwpU6xD2nUZBK70115R/IbQCJigEIkMkGLAcDjkE3DV7FW4nY4gGos/qXerKa3
	 CBTWLX1HEGkryDjZ6J55HOvmfKzXEnTZXaUMbyrgp1I6/SdxSIvF1zqgWt+Bw4sJtT
	 20LqRmgiSvNWT/UEQp7t0n8UmH2U5/OzQQo5nHgzK02xcwy4Rq69QBo5Y0KZnadeAD
	 8WAYDH0EsEq6OZ/8fGV5natjeWvKeEp4/GqdZIoDn+nE6Lj7v8/7DUkkDFiFZn4hLn
	 b6adnrcaxXOJg==
Received: by mail.leachkin.pl for <linux-nvme@lists.infradead.org>; Fri, 18 Aug 2023 08:15:51 GMT
Message-ID: <20230818074501-0.1.4u.cttn.0.98qlix7lyp@leachkin.pl>
Date: Fri, 18 Aug 2023 08:15:51 GMT
From: "Jakub Lemczak" <jakub.lemczak@leachkin.pl>
To: <linux-nvme@lists.infradead.org>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d?=
X-Mailer: mail.leachkin.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230818_011810_951463_D4F16831 
X-CRM114-Status: UNSURE (   2.48  )
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

Dzie=C5=84 dobry,

Czy interesuje Pa=C5=84stwa rozwi=C4=85zanie umo=C5=BCliwiaj=C4=85ce moni=
torowanie samochod=C3=B3w firmowych oraz optymalizacj=C4=99 koszt=C3=B3w =
ich utrzymania?=20


Pozdrawiam,
Jakub Lemczak

