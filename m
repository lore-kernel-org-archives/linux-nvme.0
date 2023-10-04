Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF968E8FDDA
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Oct 2023 07:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mMhfBvhM53FtUQl1P3lyeSY5aDBQYiR8qQBy6YFQHi0=; b=dpaFpmPW3qm+KhO6Rp4VpYDXX4
	AEhPwnZ+T1pXGO+j5EZnczhyt+cIBWFyw6tvBPgHDntRCVgRXhEtFd5BNw+UAM6Y3/qwqKedKVqDs
	WtgcVeKO71Ic1NxfBh9Hs8c96r6+ivDPXzvP888dAGoaJ6Szyz9ebtFkl8x5e+ZiphyioYFw5LCOD
	AwzX1sFittMhlDivs/z1nQ4lIRzJ5zxrtUNHq9J9plv0suzM7i4Rw9Z4D3OE7qc1zoExklaeIStbW
	ISEYmvdYDNYuYOgvp4uYSvGLqAQQyI/fQTRR2Xxl8uTFAdNeaO2jM7y0XOWI3XskfaeioL9w0wBVG
	ZbiqEwKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qnwa3-00GfNZ-1D;
	Wed, 04 Oct 2023 07:46:03 +0000
Received: from mail.citycodes.pl ([158.255.215.195])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qnwZx-00GfL5-35
	for linux-nvme@lists.infradead.org;
	Wed, 04 Oct 2023 07:46:02 +0000
Received: by mail.citycodes.pl (Postfix, from userid 1001)
	id A76831F58B; Wed,  4 Oct 2023 09:45:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=citycodes.pl; s=mail;
	t=1696405556; bh=mMhfBvhM53FtUQl1P3lyeSY5aDBQYiR8qQBy6YFQHi0=;
	h=Date:From:To:Subject:From;
	b=iaINmTBC20d2NWubgk32bO0SKZgsUjYvW/0a2pXTm5iHNLpJotwGQDsIfyNmH3tHL
	 ICHIP6o8WAk8M0hz4gj1Pf9pVmCC9YygVV3zEFyYZ43tDoDD88Rk2sfuSV7jaDBnPs
	 J+GvTYFf/04EjZ6t37IrLOeL7vmdqmm+pEO37n/dDSJQSaEHv+CX8Uh5t7YM5HjOn7
	 BwJDtokoQ0ZFDyn88v+ReErlmYRt6fFOYUfMBfM11ALop4ncEMJ3ZGkNeUumJFbLRf
	 Vq8CDgDKmgENXh4lnf9kN6R9W/4EtnTwVFhj4JNd5KBtVwv1rj5Dsp0TsUqzLUbYDS
	 cgQ/huHIBpLIw==
Received: by mail.citycodes.pl for <linux-nvme@lists.infradead.org>; Wed,  4 Oct 2023 07:45:38 GMT
Message-ID: <20231004084500-0.1.7v.j15s.0.pdj3k2avau@citycodes.pl>
Date: Wed,  4 Oct 2023 07:45:38 GMT
From: "Kamil Lasek" <kamil.lasek@citycodes.pl>
To: <linux-nvme@lists.infradead.org>
Subject: =?UTF-8?Q?Rozszerzenie_Programu_M=C3=B3j_Pr=C4=85d_5.0?=
X-Mailer: mail.citycodes.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231004_004558_124773_CC2947FB 
X-CRM114-Status: UNSURE (   2.03  )
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

Szanowni Pa=C5=84stwo!

W ramach nowej edycji programu M=C3=B3j Pr=C4=85d mog=C4=85 otrzyma=C4=87=
 Pa=C5=84stwo dofinansowanie na zakup i monta=C5=BC fotowoltaiki i/lub ma=
gazynu energii. Maksymalna kwota dofinansowania wynosi 58 tys. z=C5=82.=20

Jako firma wyspecjalizowana w tym zakresie zajmiemy si=C4=99 Pa=C5=84stwa=
 wnioskiem o dofinansowanie oraz instalacj=C4=85 i serwisem dopasowanych =
do Pa=C5=84stwa budynku paneli s=C5=82onecznych.

B=C4=99d=C4=99 wdzi=C4=99czny za informacj=C4=99 czy s=C4=85 Pa=C5=84stwo=
 zainteresowani.


Pozdrawiam,
Kamil Lasek

