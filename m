Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DDCC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Dec 2021 08:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=07NAgW1e0WiNB9zqagiM2BnwZfWBCpNa2E4+ccxBPgw=; b=v16+jv1I8xQ7WNwIGRKqyq7gnU
	E2WXAf2yo2iWnpsZg8jIMwiv20JZbRVnQN/dLCVK2FhSG1TKGvDsb+iLdB+SzgB2w8NXnJbphqvB6
	cQaxvgsYxiGq1YuLcEct/CwyyrpfKUvK95PtNvaVYm1BiZL2EQ8g13UQyzP9GQ72OnunxwWUBvJIf
	M9J63TFGjt+xUjdZ0g3PYZNK/C7a6RkGx3uOLowZioD7etrhziKQA22RBJ+3nUe006qMBGNe+K7Ue
	PBT/dIFPtvqiviXDhEsuV2A0J7kRLpv+/zYcayZBb6J8PxuAccMKGQKeDQinHxRD/IKrTK9EqZCpM
	n/HJWF5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n0J5q-00C6fv-4f; Thu, 23 Dec 2021 08:04:54 +0000
Received: from mail.betterbiz.pl ([45.86.209.138])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n0Ioi-00Bzpu-Pe
 for linux-nvme@lists.infradead.org; Thu, 23 Dec 2021 07:47:14 +0000
Received: by mail.betterbiz.pl (Postfix, from userid 1001)
 id 8354782809; Thu, 23 Dec 2021 02:45:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=betterbiz.pl; s=mail;
 t=1640245609; bh=07NAgW1e0WiNB9zqagiM2BnwZfWBCpNa2E4+ccxBPgw=;
 h=Date:From:To:Subject:From;
 b=qQfg2WUrLE3w2hkpPGGtNdn+W1VIVgtMTjMR65srooAtU9FA/SipMCR44hczrTt23
 4yFXPfzAhrhOOm63AvkJad5qBramqdwyx/T1sYOMxkfKN9XQ3ay3ZwPGyJFH2LWa95
 CjDNiuQ7KBZAr5PElnbTcwyYwN3kRdEDD8XSoRpu2/DhHh/JnP7zvRZktV+bBVfboK
 TwJb7p8YFdFpjTN2k09/ziKPDOqA7kYZuETCjt1kH5WM6EV0Qzp2cyGQHAeaVVb8Fr
 WqSr3syNdJaytcd3q6Xr2hArCk7gg5YWBwC5GiBjLmk/sdhxhMa0F8uFt9ZN5T6LDM
 Awm92ZsaUmPcA==
Received: by mail.betterbiz.pl for <linux-nvme@lists.infradead.org>;
 Thu, 23 Dec 2021 07:45:53 GMT
Message-ID: <20211223024500-0.1.f.10dy.0.hopmjl6qj8@betterbiz.pl>
Date: Thu, 23 Dec 2021 07:45:53 GMT
From: "Jakub Daroch" <jakub.daroch@betterbiz.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Wycena paneli fotowoltaicznych
X-Mailer: mail.betterbiz.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211222_234713_033481_6262D1CD 
X-CRM114-Status: UNSURE (   1.44  )
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
Jakub Daroch

