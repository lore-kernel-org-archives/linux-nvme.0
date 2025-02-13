Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57490C0219D
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 08:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jxb0oDMobd7GaIcoqojTSF8ZoNcoVg4kM8ohJkoHKb8=; b=MppmdWSyqEHCJ73AV2MDUK1COE
	F4De1nQyzejrTxH4aSK/tdUUhNgnhSHCZHUacbvWjwiPxC8aNwEFkeUFRUoeVcu2dyImMIxWs+qVi
	1jzXXSme75q+dD7BoGcwU1do3lrzP/lUcgNe/e3zrmNj3TebM8BgsB0/cbLVEBfhORnfgbvRbkHTT
	d1GqTi6XGH2+zKohkIeO8SGzxKWIpajsMx3S7BtCjgQrB2Nzbif6/IXM6yTQyTjZ1GNYCOoEH4juu
	usdvg3Kf0qLzlFUf7j0u/y0oCFYCwkNngFLmp8OeKl1Reav4aGbTDXAH5DtJxD4K663S3wrPzOIjP
	9h4G+3jQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiUo9-0000000AJVf-08rx;
	Thu, 13 Feb 2025 08:42:53 +0000
Received: from mail.novaplan.pl ([51.195.118.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiUiM-0000000AIW5-29Nt
	for linux-nvme@lists.infradead.org;
	Thu, 13 Feb 2025 08:36:56 +0000
Received: by mail.novaplan.pl (Postfix, from userid 1002)
	id 2FEB3A39FF; Thu, 13 Feb 2025 09:36:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=novaplan.pl; s=mail;
	t=1739435809; bh=jxb0oDMobd7GaIcoqojTSF8ZoNcoVg4kM8ohJkoHKb8=;
	h=Date:From:To:Subject:From;
	b=rrvcoM7kmCy7pMVnX2oDF/tQzNOCoAdduV0btjaV8Ej4VfPV+zDMUyglDdlt3NtiB
	 /grFB7ZhS6j9uIb+u5QrVdfENK63MkdcDmrmwilaRcKXWMBXbZXCZ6MRq3YQhqKkl6
	 D9RF9u12MyLrQx+cgOGXTdU871V/PV50roiJ3q89vzTXccg6rq33wxmOB0M32E7Xc9
	 aJPLF1c+10Kocn4eYxr1HZb+NhyiyBt5ljWWui74HTfky/yX3rXAC2IohpOvLUGiva
	 7X3NMbHdXZUhPTrbhO+EmDFaozSqtiboGlEL4zERHxLQCRpRMTJLZLoHCXcXdGSp4s
	 4luAZseFmiauA==
Received: by mail.novaplan.pl for <linux-nvme@lists.infradead.org>; Thu, 13 Feb 2025 08:35:47 GMT
Message-ID: <20250213084500-0.1.ju.18n0g.0.ej3xjz11m0@novaplan.pl>
Date: Thu, 13 Feb 2025 08:35:47 GMT
From: "Adrian Liszka" <adrian.liszka@novaplan.pl>
To: <linux-nvme@lists.infradead.org>
Subject: =?UTF-8?Q?Prosz=C4=99_o_kontakt?=
X-Mailer: mail.novaplan.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250213_003655_246712_B5B525EF 
X-CRM114-Status: UNSURE (   1.85  )
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

