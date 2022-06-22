Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50C1C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jun 2022 07:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FDuFY3XQoq0gMX1b2gxgT7Py2p4Sxl0PJZYZ4NVaPho=; b=W6Ym2y0w90ofOE1WpvG0GrP5lL
	upJCS3ZZ48uxLVdp3l6jQ41anS67ROhjZ9laDGc6Upg9vczajKI7zrKxexBCkXt4DwQUPWkSR6+77
	LWaN/B9Ye2g+1LpZbYHqbDx9TuE9BryVXkmrdVggBxlEoZVlzpgUnh1paeGY/o7dvsEaLxLS5AKl6
	gIJVPHv75MfUflSvkGV/BUBWcy9PgVuC4BAheqs4gv7KtUsB8GCp2+N6tIAZ0JaQAaIqqa/eEuVB0
	nQiMWjWk5uSU7WkMOhOsru7luVB6WPeolfxqUDEG7agUiHeNOT2gYOK9IA/+1PIqtDy4b0a6hNCU/
	iEMKYm4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3vE5-0098Yl-Re; Wed, 22 Jun 2022 07:56:37 +0000
Received: from mail.olerise.pl ([46.183.184.59])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3vE3-0098XU-7E
	for linux-nvme@lists.infradead.org; Wed, 22 Jun 2022 07:56:36 +0000
Received: by mail.olerise.pl (Postfix, from userid 1001)
	id BBB9E25E2D; Wed, 22 Jun 2022 09:51:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=olerise.pl; s=mail;
	t=1655884450; bh=FDuFY3XQoq0gMX1b2gxgT7Py2p4Sxl0PJZYZ4NVaPho=;
	h=Date:From:To:Subject:From;
	b=agjDivZTGNx/OpZf4m/QSwf8nFBsLoxPejo75JZ0Rw8pn7gsv9xYj8JVabeFKytBG
	 bTSy8+oe+BtGaUfEv1Hx/xCN34/xqeC5hDtR8EP/raw43CH1tZ1piaausNh/D/r9wv
	 zC3KpbKMdR91RubAkk1pqIdh7Y+4GYU/hOC41qxkdaJ1mLaxOyxsB3/Fc3+W0hQdYu
	 +W7DqO18+En/M5Ak5OWYfXa2L2Dol1OLgQMYbL3rpiGzOCDUqjcdtpbzPDsa/IpOtz
	 b/6T149+KMgz+n79Zhd62gBFMjn2ElrIGCwoiUZlAoBVMusCXmJYavDquVynXrk4LM
	 SdMyp9F7KZPzA==
Received: by mail.olerise.pl for <linux-nvme@lists.infradead.org>; Wed, 22 Jun 2022 07:50:21 GMT
Message-ID: <20220622084500-0.1.j.bcl2.0.8llf5arhg0@olerise.pl>
Date: Wed, 22 Jun 2022 07:50:21 GMT
From: =?UTF-8?Q?"Przemys=C5=82aw_Wr=C3=B3blewski"?= <przemyslaw.wroblewski@olerise.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Wycena paneli fotowoltaicznych
X-Mailer: mail.olerise.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_005635_446419_C2B32C75 
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

