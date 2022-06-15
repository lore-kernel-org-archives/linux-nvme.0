Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B761C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jun 2022 08:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FDuFY3XQoq0gMX1b2gxgT7Py2p4Sxl0PJZYZ4NVaPho=; b=PFwXY1hdFbk2Jh7gyc9rXU72zD
	tgDux8SGuZVldHV1w/rf8cuI06nKF1ldyT30HnU4K70oSfJXTvUaev3n5CN+SIVd9j0Oy/yO9dsRG
	N8ueRraSJkgiiSypODuLsii1AXjY2YzNuhW8deir2q1Q0SjYrz71TEQJFjebeHaqIoE21UHfT1+uy
	ejcQtB6t+sRLTHYcmBPUiPlVbnUv/s8D5hG5yIJM8x+sesbbJvYjWGM9WibcxB8R5OKTAZ2pbFtOi
	pVY8SpyqqJQst/QuE6ZkXyWuTCHCDQJ80lnRDOtHEduEQFT2zliEB1+A9Psj/nYkDqAmSKsvGsvj5
	ZlDQvJHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1Nzi-00D9NJ-Hd; Wed, 15 Jun 2022 08:03:18 +0000
Received: from mail.olerise.pl ([46.183.184.59])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1Nzd-00D9LD-Pt
	for linux-nvme@lists.infradead.org; Wed, 15 Jun 2022 08:03:15 +0000
Received: by mail.olerise.pl (Postfix, from userid 1001)
	id BEAD025B69; Wed, 15 Jun 2022 10:00:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=olerise.pl; s=mail;
	t=1655280080; bh=FDuFY3XQoq0gMX1b2gxgT7Py2p4Sxl0PJZYZ4NVaPho=;
	h=Date:From:To:Subject:From;
	b=ETveYSXciYWCVaOjee+XRZpYj3sAXN9H7l/yg2q5sSMW+1/Ei9DSTO13mkFiBF0TP
	 lEkNq3YRcX9JmPtEEj6NYrcNa7OnelfvFAW2TnlWmH1JPuGSZ9CaD9xTHOBJACIn0E
	 rbmIL1NlteDU5jCDc8sRYRc3YbWfJMnhDbL+1RKxZUAaU1ip5LZd7N++O17oKzn+PK
	 dd/jw0rFDQKCJHCeYXQQFIPkLWiLgm0JeUTDLG2ToG4m0gUvC39OjAfzsEF03sK0qI
	 sawO+W6OpdSTfrvMZQpT1iLlunJubaY/aP6bVnOjAdzanBR/jRemxqohJO0edLcV3R
	 G9OXoR608mY4w==
Received: by mail.olerise.pl for <linux-nvme@lists.infradead.org>; Wed, 15 Jun 2022 08:00:27 GMT
Message-ID: <20220615084500-0.1.f.82qj.0.rnm4obkesz@olerise.pl>
Date: Wed, 15 Jun 2022 08:00:27 GMT
From: =?UTF-8?Q?"Przemys=C5=82aw_Wr=C3=B3blewski"?= <przemyslaw.wroblewski@olerise.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Wycena paneli fotowoltaicznych
X-Mailer: mail.olerise.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_010314_022757_3F75B581 
X-CRM114-Status: UNSURE (   1.64  )
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

