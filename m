Return-Path: <SRS0=wlVn=QD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366BDC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 08:42:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAE8961055
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 08:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EAE8961055
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=bizjoindeal.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JZuQ1fK7zFtz2oeUB7Xfid9vb7kUywdmDd2OluR8ywA=; b=K9+VukUQb4l1SEoc2QY8JBgwMc
	bYOi+woHPVAjRNfRdMgoiM/APSd7Q3zUC/TNVoDnsOCxmusOC14J63EzT/DlD0fdQ/x0qgcs0eCUD
	rS8u+ss1IksRfWSaREwvjqGjm1MrY4FyVxqRQkCoK+DhcW+AgAgPCS974qmdD5G3jMGnIkCAvlEeV
	OljsdNORmPXFmQ8nGMQ8GigdPUEDLeyMmvJ4+p1oTpRysE0IEje5HkA3HxE8x7ry8v7zSehrc3/Sb
	fflyLwdzuQVudo0Fhye3QjWT8KwnVs9TdkajdOvOZwwFC2/RO9INv+edijYZAs/iqRU/f4Q0DGxdK
	cRjBwSgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmu2X-000mBB-VZ; Tue, 16 Nov 2021 08:42:06 +0000
Received: from mail.bizjoindeal.pl ([80.211.97.164])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmu2V-000mA6-H0
 for linux-nvme@lists.infradead.org; Tue, 16 Nov 2021 08:42:05 +0000
Received: by mail.bizjoindeal.pl (Postfix, from userid 1001)
 id B48FFA2687; Tue, 16 Nov 2021 08:41:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bizjoindeal.pl;
 s=mail; t=1637052106;
 bh=JZuQ1fK7zFtz2oeUB7Xfid9vb7kUywdmDd2OluR8ywA=;
 h=Date:From:To:Subject:From;
 b=lOsDpF6cFw/patID5KA0AUMHIKtGNW/q/6gBye3zJHJK8ePr+RDrY2wxk3YTtW4vQ
 o1EEiZ1Rm66P+pRast9OMoc2QqM0Y6hFUWA5WToms8sxzlV0g0DwDQjuTpTs5vsQRv
 uxHCN0V1sjLD89INg15m5oLRBa6miy+FsBFLtWYlo2XbQuW/6lYIa3D77zq8ePLTOI
 6iLac87/UPNPtLkTXw8JtgyVMJ/BaZdgOP3KlzJZEvsn++smQ+5PgCm6a8Nff+Q2Oe
 +/BCO21S00PjVbzPlDQBvNKvjl9P/OpHzLouaqgea/N/1EE9+QUDxXzMiAvoc6Z2bf
 I/VK4ee3GohWQ==
Received: by mail.bizjoindeal.pl for <linux-nvme@lists.infradead.org>;
 Tue, 16 Nov 2021 08:41:09 GMT
Message-ID: <20211116074500-0.1.60.ezpq.0.gajg38sn9o@bizjoindeal.pl>
Date: Tue, 16 Nov 2021 08:41:09 GMT
From: "Dorian Kwiatkowski" <dorian.kwiatkowski@bizjoindeal.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Fotowoltaika dla firm
X-Mailer: mail.bizjoindeal.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211116_004203_816210_B51CB0CD 
X-CRM114-Status: UNSURE (   2.54  )
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

kontaktuj=C4=99 si=C4=99 z Pa=C5=84stwem, poniewa=C5=BC dostrzegam mo=C5=BC=
liwo=C5=9B=C4=87 redukcji op=C5=82at za pr=C4=85d.

Odpowiednio dobrana instalacja fotowoltaiczna to rozwi=C4=85zanie, kt=C3=B3=
re pozwala wygenerowa=C4=87 spore oszcz=C4=99dno=C5=9Bci w skali roku.

Chcia=C5=82bym porozmawia=C4=87 z Pa=C5=84stwem o tego typu rozwi=C4=85za=
niu, a tak=C5=BCe przedstawi=C4=87 wst=C4=99pne kalkulacje.

Czy s=C4=85 Pa=C5=84stwo zainteresowani?

Pozdrawiam,
Dorian Kwiatkowski

