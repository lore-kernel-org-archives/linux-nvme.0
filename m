Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425A5C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Apr 2022 07:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FDuFY3XQoq0gMX1b2gxgT7Py2p4Sxl0PJZYZ4NVaPho=; b=jz3jXyr0gErNVXt87kdlLsJ3P/
	hmZCoqJoqnF+DZMPZipjuPdWoLWRUVJNOhaLigKBTXXp8aiM5KynSPvRx2SzisJnfqaScJRIQ9oeS
	GOgPPWhU5m5ROef9P04ZN2fVV3XHTMml1w1inhN+A+LvaHMKp0mXpDbxYLJbimPcPO9F8ZOQjaepz
	ZiO1tz9nWh9qbF0LwjNLrT2BEi6iHwFoV7rrJfDrDqlJhw6Ahmz2f6AvUuaoO6EjJTwEn5y1LjnSj
	i9Ppsry/6K7/BlNG3Zrqs1D3BOeS7B5dMK0SlASRe0s2hfeWlTb9y/0JYE6AUvar9+nrUot8vebx0
	zK03fnew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njc6E-000GSu-Tz; Wed, 27 Apr 2022 07:28:34 +0000
Received: from mail.fixingbiz.pl ([217.61.22.139])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njc67-000GPa-N8
 for linux-nvme@lists.infradead.org; Wed, 27 Apr 2022 07:28:29 +0000
Received: by mail.fixingbiz.pl (Postfix, from userid 1001)
 id 6B23DA4DBC; Wed, 27 Apr 2022 08:28:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fixingbiz.pl; s=mail;
 t=1651044505; bh=FDuFY3XQoq0gMX1b2gxgT7Py2p4Sxl0PJZYZ4NVaPho=;
 h=Date:From:To:Subject:From;
 b=HKYjF7qHdqGedrNQ+VQxwTA4lC88RU5B1vpi6k5mDAiktYmZ/SLrKflqnfqKHj3lG
 xqRTqJDVsPQ4gzkZEGM6WOl37FNk1npex5l6YPUoWKlfQbcuSTtsuoIk4uWYuWjvOU
 s/6y9Om/566UtOG4VfDv4BuWJ10OUCWqduxLDodHO9Jcj0rzm1XwvWfgGxRqSCD7IA
 3AwOrs+owAtZxaneD8clwoRf3OmMdD/kPtUwORY0AplR6GUro+JHG8MxzauNZ4ss1E
 RYIcfP3SuJpk17RBH5IHQXs0XhJU0UcGaf3s09chDoBG5Qi1iQ2H9mQ5H7vpkJBhga
 S0PR82ZI08udg==
Received: by mail.fixingbiz.pl for <linux-nvme@lists.infradead.org>;
 Wed, 27 Apr 2022 07:28:09 GMT
Message-ID: <20220427073002-0.1.22.ahyw.0.kpxjxnfd49@fixingbiz.pl>
Date: Wed, 27 Apr 2022 07:28:09 GMT
From: =?UTF-8?Q?"Przemys=C5=82aw_Wr=C3=B3blewski"?=
 <przemyslaw.wroblewski@fixingbiz.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Wycena paneli fotowoltaicznych
X-Mailer: mail.fixingbiz.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220427_002827_895383_44963C43 
X-CRM114-Status: UNSURE (   2.62  )
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

dostrzegam mo=C5=BCliwo=C5=9B=C4=87 wsp=C3=B3=C5=82pracy z Pa=C5=84stwa f=
irm=C4=85.

=C5=9Awiadczymy kompleksow=C4=85 obs=C5=82ug=C4=99 inwestycji w fotowolta=
ik=C4=99, kt=C3=B3ra obni=C5=BCa koszty energii elektrycznej nawet o 90%.

Czy s=C4=85 Pa=C5=84stwo zainteresowani weryfikacj=C4=85 wst=C4=99pnych p=
ropozycji?


Pozdrawiam,
Przemys=C5=82aw Wr=C3=B3blewski

