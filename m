Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB210C35FFC
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Mar 2025 08:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jxb0oDMobd7GaIcoqojTSF8ZoNcoVg4kM8ohJkoHKb8=; b=S4xKrfWW1a+IpSmHRuRCfhGHP5
	sygVZKpjtF9wsNHooxCsWXtEhx1yHDmTQQo8/4/7CWwA7ka2u8e9XO2HWNC38PW4H9w7oItAuL/64
	GXahZjgPJu7xFPLyySlaBuySVoQ9AFlPFrgHS5nJon+7W+wTdukE5xOmecElJY0JXiBGesZKLpfSV
	pGpnnMfzeS30XHQjjpwkRSfyqMi7qtn9zEMXfdmnJ1tA3xnm32FIpHup1HwhR0TymmxqjiZk81BKR
	y9HFUqfiHHVX8mKt9+H71sI6dG+aZoQCsy08cfj3dQ69PlOybQMAGph1h6vHOxa9Wib9GtQTCjqRw
	gmE56KjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1twziN-00000005CfN-0P0Q;
	Tue, 25 Mar 2025 08:32:51 +0000
Received: from mail.novaplan.pl ([51.195.118.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1twziG-00000005CeP-2YD5
	for linux-nvme@lists.infradead.org;
	Tue, 25 Mar 2025 08:32:46 +0000
Received: by mail.novaplan.pl (Postfix, from userid 1002)
	id B8AE9A379F; Tue, 25 Mar 2025 09:31:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=novaplan.pl; s=mail;
	t=1742891558; bh=jxb0oDMobd7GaIcoqojTSF8ZoNcoVg4kM8ohJkoHKb8=;
	h=Date:From:To:Subject:From;
	b=FkiJN0seaME5P5ToQpohvWjwyBE83oB7/xuNMYCfUuNUTzm/eFaQBIRHyzwxuEsaH
	 qY5/HRGqJe4DDrfd/dXz+5oQVzKX2BbjwxC0egkfcPIz5qmLb3uEREpDRJKF/nq08B
	 jIVpYzJqDcwMWMjHTGpBZPIr9Uen2tqcg5Y59F/oxKV7fsdhT08hFzZzJ58CmPcn3k
	 qEMRgcG7iWu9mlV5flZDnx9telJUcIhGGVQz213yUXw0YLh8yKj2y/WcutXHhONggc
	 bNTdpZEAdzuir6JmU5xx6JRewhceXWXUHEpnm56JKEwJw10KuphaCXkOsyLNDI4I9a
	 HSWQGdi+0GiqA==
Received: by mail.novaplan.pl for <linux-nvme@lists.infradead.org>; Tue, 25 Mar 2025 08:31:12 GMT
Message-ID: <20250325084500-0.1.km.1iv5f.0.z839bhqzwm@novaplan.pl>
Date: Tue, 25 Mar 2025 08:31:12 GMT
From: "Adrian Liszka" <adrian.liszka@novaplan.pl>
To: <linux-nvme@lists.infradead.org>
Subject: =?UTF-8?Q?Prosz=C4=99_o_kontakt?=
X-Mailer: mail.novaplan.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250325_013245_332922_011F9323 
X-CRM114-Status: UNSURE (   2.72  )
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

Czy jest mo=C5=BCliwo=C5=9B=C4=87 nawi=C4=85zania wsp=C3=B3=C5=82pracy z =
Pa=C5=84stwem?

Z ch=C4=99ci=C4=85 porozmawiam z osob=C4=85 zajmuj=C4=85c=C4=85 si=C4=99 =
dzia=C5=82aniami zwi=C4=85zanymi ze sprzeda=C5=BC=C4=85.

Pomagamy skutecznie pozyskiwa=C4=87 nowych klient=C3=B3w.

Zapraszam do kontaktu.


Z pozdrowieniami
Adrian Liszka

