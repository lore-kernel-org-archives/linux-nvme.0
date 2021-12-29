Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F48C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Dec 2021 08:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RZjfFpT9KGSFHXuIOzTjcb+Gwkun4EXriv7y2I0PG0A=; b=cQQudojBCVqvJLBGXjRjRvlMyE
	mviFle3x9payZ0oLEWb1bwI4r+l/GTJBIPz+o4HA0hZ1Er82ReVfq9ys/ZXuN+flFFAwl2mqtG72n
	75ksC0mdP/BHF3HHmaJcH31ynGhkWDGFqaOkm8xPdIfiFQ+2yMrLjDOkaYrhza/Icfaz4vvC2fqm9
	J+x8udt7g7AYdmRNzsafyOcGf6fikPEiS5byGSolXHWqNC7r58iq0fiD9dk1QaEs7Ke2LH4rkSbff
	bDgKqxqUb5lzJPaCE1B1Lg6M899En5rNWBj5bOaCkkJKtiWQgljW9xAA/5F1Is6yxdu+Sra7mV1F3
	mtOzg/WQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n2Ufc-002Uv6-8D; Wed, 29 Dec 2021 08:50:52 +0000
Received: from mail.portyid.pl ([192.36.61.58])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n2UfW-002UuS-3d
 for linux-nvme@lists.infradead.org; Wed, 29 Dec 2021 08:50:47 +0000
Received: by mail.portyid.pl (Postfix, from userid 1001)
 id 8FF00411D7; Wed, 29 Dec 2021 09:50:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=portyid.pl; s=mail;
 t=1640767844; bh=RZjfFpT9KGSFHXuIOzTjcb+Gwkun4EXriv7y2I0PG0A=;
 h=Date:From:To:Subject:From;
 b=M65Z7rzc3GP1w0JRNmHeGhU2hZjlDzzPo2xaSNa/tZf07HeWuWIMRNH8gEZ1mVWcl
 +j2njN5gff5IYUMEHn0jZ9NSb/li0t95i8w4Xq9SLcj78qyQRZKArkf5bvitB54ELD
 R3gXGL51iDLhgrnfnm8DVjGdo3t0+iRbWYtdgqRbVzv1g6ZHqfsTxCOw9QiHsyUoj2
 9b1oOgRzdXWpKTP7OLocqm2Rkz8UDR7X2uD3e3TDeoa6d4N66kbrgFinWbvtxt4JDb
 rO4wj1bBimCDVab7/Q14d75Ept7Ftw1XirV+u89FyzxOeIICSno8ulgJNC4VN9qPBJ
 td/o8ZNp4xGng==
Received: by mail.portyid.pl for <linux-nvme@lists.infradead.org>;
 Wed, 29 Dec 2021 08:50:38 GMT
Message-ID: <20211229084500-0.1.w.2udx.0.3y9xblf0ly@portyid.pl>
Date: Wed, 29 Dec 2021 08:50:38 GMT
From: =?UTF-8?Q?"Pawe=C5=82_Jasi=C5=84ski"?= <pawel.jasinski@portyid.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Wycena paneli fotowoltaicznych
X-Mailer: mail.portyid.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211229_005046_331981_80B8A600 
X-CRM114-Status: UNSURE (   2.91  )
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


Pozdrawiam
Pawe=C5=82 Jasi=C5=84ski

