Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C58C433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Mar 2022 08:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rqcEvVJQSOmVvt10Vd77A7h4EQ3zL1XaGAodpexDxk8=; b=IMDnkGSElvQatfHcZ9RP6CVU33
	f43qD7atvrgAgrSrgS1iTUxBNcECiI/5PhLB2almNYIyLbPXcposeEf+pugSC0jrgDxPzVtCBM7n/
	2DRzNp/NQg9BqH5UJnxXsbhkq/Fn7AR71nxwGghiuCwTBMnkOhM2l3f49K+KsUxP+pR43GNwvH/KB
	GWUHYtTjwdLqW9bVCTjRcwyfbJmLMTpyC0C7t4b0/Q//ld7ipfTA+qi01ct+RQqRu2VeSYmV2n+in
	DUEgFmtRk7eNPPCm8tBSWuiIRd6mxpvz+zmQtlHD/49q1jB4b9btLQkbl86IyiLcHoxRmV6a8Yi8H
	T1hzsJjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRVET-003GZz-NL; Tue, 08 Mar 2022 08:30:13 +0000
Received: from mail.twelvesign.pl ([89.221.214.137])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRVEH-003GM7-OT
 for linux-nvme@lists.infradead.org; Tue, 08 Mar 2022 08:30:03 +0000
Received: by mail.twelvesign.pl (Postfix, from userid 1002)
 id AE1C8357B7; Tue,  8 Mar 2022 09:29:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=twelvesign.pl;
 s=mail; t=1646728175;
 bh=rqcEvVJQSOmVvt10Vd77A7h4EQ3zL1XaGAodpexDxk8=;
 h=Date:From:To:Subject:From;
 b=ZrsKA1qqyKe1ic03t1/Bi6lm5Hg8xHCwt/8SipWhaDaO/5ePswpO7V++djNna76fD
 +zbXJdoTrR+8hmozNvxRnJ7TeodtsfVDH96gp0o9Zu7Zi1ptBTNVo+8sriPezyCi4b
 ig9pBvUlBTvFSN3b2Vo7oJgysG2IRSBEMWWalL1Xx3FJKKzU4C2sSoHNaN5Pz9DHzx
 FAufMaD9I0P4hhuaJw3icA0kBy7jKiCXT1Kepe8y0QTJ0k5sDh0Vx4jvmcDJeKL4EE
 njFZ9AkrjHa3Lv9nZ1jqt9HEhbM4yOUqR+0xW+hTqtOoeqTsLA2+IHI8MYkKC6OPx2
 vEkSBirAQfCIw==
Received: by mail.twelvesign.pl for <linux-nvme@lists.infradead.org>;
 Tue,  8 Mar 2022 08:29:05 GMT
Message-ID: <20220308083000-0.1.w.1v5y.0.ronh4w6q70@twelvesign.pl>
Date: Tue,  8 Mar 2022 08:29:05 GMT
From: "Damian Kraska" <damian.kraska@twelvesign.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Wycena paneli fotowoltaicznych
X-Mailer: mail.twelvesign.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_003002_004111_2C5BB7D4 
X-CRM114-Status: UNSURE (   2.82  )
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
Damian Kraska

