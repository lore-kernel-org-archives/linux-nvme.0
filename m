Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155FDC6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 13:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:From:To:MIME-Version
	:Date:Message-ID:Content-Type:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TPGifTeernsey1wfZHjbF4oNbc8ybPDDVddHevSUOTM=; b=34LoQMOr8ql7t5IyqKujTrBE6t
	b6rrzLuziTwQYvXYJ/hytXU3J7hlMoQvSX6pAtXnxhSdX08Iu31ezXnPD6TCQkhe/NkClitRcCPoG
	ZXsaGP8/D/PbqNSNlu1xwLdLI+od0Mt1LnKonWkbHgt4UoEB+ONlNfh9SJq8EZFWV/RFXF/SH6rJC
	ZW5/k7O5otJ1mg05Rdg+X00NtfrFQeIkNK0j+9CsMUWDLdLKNe2gBJxeyL762rS3YT4oBqBE5Yw3k
	sx85lefvG/k+jP3psE8UdlNVc37TPaHUAUivU4lnIiEBppl/sV0cQYg+M0CdFpYE43t156LajYrB4
	fVQaU3Bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp777-00000004k5q-0SNJ;
	Tue, 26 Mar 2024 13:45:17 +0000
Received: from mail.send.com.pl ([89.31.64.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp771-00000004jue-1w3d
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 13:45:14 +0000
Received: from localhost (localhost [127.0.0.1])
	by zmail.send.com.pl (Postfix) with ESMTP id 1E8F54BE2
	for <linux-nvme@lists.infradead.org>; Tue, 26 Mar 2024 14:44:43 +0100 (CET)
Received: from zmail.send.com.pl ([127.0.0.1])
 by localhost (zmail.send.com.pl [127.0.0.1]) (amavis, port 10032) with ESMTP
 id Lroft0ymQ6T4 for <linux-nvme@lists.infradead.org>;
 Tue, 26 Mar 2024 14:44:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zmail.send.com.pl (Postfix) with ESMTP id CC4985434
	for <linux-nvme@lists.infradead.org>; Tue, 26 Mar 2024 14:44:41 +0100 (CET)
X-Virus-Scanned: amavis at send.com.pl
Received: from zmail.send.com.pl ([127.0.0.1])
 by localhost (zmail.send.com.pl [127.0.0.1]) (amavis, port 10026) with ESMTP
 id PZa4nQcjH03w for <linux-nvme@lists.infradead.org>;
 Tue, 26 Mar 2024 14:44:41 +0100 (CET)
Received: from [172.16.10.4] (unknown [89.31.64.4])
	by zmail.send.com.pl (Postfix) with ESMTPSA id BE5AA4BE2
	for <linux-nvme@lists.infradead.org>; Tue, 26 Mar 2024 14:44:41 +0100 (CET)
Content-Type: multipart/mixed; boundary="------------LhKQNlVA8ie3J2hV0d0cXlz1"
Message-ID: <e7be9608-7e1d-4da3-985b-644b66443dec@sibersoft.pl>
Date: Tue, 26 Mar 2024 14:44:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: pl
To: linux-nvme@lists.infradead.org
From: =?UTF-8?B?xYF1a2FzeiBLb2rFgm8=?= <l.kojlo@sibersoft.pl>
Subject: nvmetcli FC transport problem
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_064511_997961_8215DB56 
X-CRM114-Status: UNSURE (   6.44  )
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

This is a multi-part message in MIME format.
--------------LhKQNlVA8ie3J2hV0d0cXlz1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hello

I'm using nvmetcli version 0.7 on OpenSUSE=C2=A0 LEAP 15.5

I have problem with FC transport. When i'm trying to add subsystem in fc=20
port configuration I get error

Could not symlink testnqn in configFS: [Errno 6] No such device or=20
address: '/sys/kernel/config/nvmet/subsystems/testnqn' ->=20
'/sys/kernel/config/nvmet/ports/2/subsystems/testnqn'

In attachment there is json with my configuration.

Can you please help me ?

--=20

Pozdrawiam / Best regards

*=C5=81ukasz Koj=C5=82o *
Administrator System=C3=B3w i Sieci

=09
Logo SiberSoft =09

*SiberSoft Sp. j.*
Praw Kobiet 4,
15-535 Bia=C5=82ystok,
Poland

*website:* https://sibersoft.pl
*e-mail office:* poczta@sibersoft.pl
*personal e-mail:* l.kojlo@sibersoft.pl <mailto:kn@sibersoft.pl>
*mobile phone:* +48 791 320 220

=09

*NIP:* 9662125863
*REGON:* 381937585
*KRS:* 0000760681

SiberSoft =09

Nie drukuj tego e-maila, chyba =C5=BCe naprawd=C4=99 potrzebujesz.
Please don=E2=80=99t print this e-mail unless you really need to.

SiberSoft =09

Chro=C5=84 w=C5=82asno=C5=9B=C4=87 intelektualn=C4=85 za pomoc=C4=85 lega=
lnego oprogramowania.
Protect intellectual property by using legal software.

SiberSoft =09

*UWAGA*
Chronimy twoje dane osobowe i informacje poufne - przechowuj=C4=85c je w=20
bezpiecznych bazach i stosuj=C4=85c szyfrowanie danych.
/Prosz=C4=99, sprawd=C5=BA wi=C4=99cej informacji...=20
<https://sibersoft.pl/klauzula-informacyjna/>/

*ATTENTION*
We protect your personal data and confidential information - by storing=20
it in secure bases and using data encryption.
/Please, check more information...=20
<https://sibersoft.pl/klauzula-informacyjna/>/

*OCHRONA PRYWATNO=C5=9ACI I POUFNO=C5=9ACI:*
Poufne informacje zawarte w tej wiadomo=C5=9Bci s=C4=85 przeznaczone tylk=
o do=20
u=C5=BCytku przez adresat=C3=B3w wskazanych przez oryginalnego autora tej=
=20
wiadomo=C5=9Bci e-mail. Je=C5=9Bli nie jeste=C5=9B adresatem wskazanym w =
tej wiadomo=C5=9Bci=20
lub nie jeste=C5=9B odpowiedzialny za dostarczanie tej wiadomo=C5=9Bci e-=
mail do=20
tej osoby, prosz=C4=99 poinformowa=C4=87 o tym nadawc=C4=99 i natychmiast=
 usun=C4=85=C4=87=20
wszystkie kopie tej wiadomo=C5=9Bci=C2=A0 z serwera komputerowego i sieci=
owego.=20
Dzi=C4=99kujemy za wsp=C3=B3=C5=82prac=C4=99. Informujemy, =C5=BCe jakiek=
olwiek nieautoryzowane=20
wykorzystanie poufnych informacji przekazanych przez /*SiberSoft Sp.=20
j.*/ jest surowo zabronione.

*PRIVACY AND CONFIDENTIALITY NOTICE*
The privileged confidential information contained in this email is=20
intended for use only by the addressees as indicated by the original=20
author of this email. If you are not the addressee indicated in this=20
email or are not responsible for delivery of the email to such person,=20
please kindly reply the sender indicating accordingly and delete all=20
copies of it from your computer and network server immediately. We thank=20
you for your cooperation. It is advisable that any unauthorized use of=20
confidential information of /*SiberSoft Sp.j.*/. is strictly prohibited=20
and any information in this email that does not relate to the official=20
business of/*SiberSoft Sp. j.*/ shall be deemed as neither given nor=20
endorsed by /*SiberSoft Sp. j.*/

--------------LhKQNlVA8ie3J2hV0d0cXlz1
Content-Type: application/json; name="test.json"
Content-Disposition: attachment; filename="test.json"
Content-Transfer-Encoding: base64

ew0KICAiaG9zdHMiOiBbXSwNCiAgInBvcnRzIjogWw0KICAgIHsNCiAgICAgICJhZGRyIjog
ew0KICAgICAgICAiYWRyZmFtIjogImZjIiwNCiAgICAgICAgInRyYWRkciI6ICJubi0weDIw
MDAwMDI0ZmYxNDkxYWI6cG4tMHgyMTAwMDAyNGZmMTQ5MWFiIiwNCiAgICAgICAgInRyZXEi
OiAibm90IHNwZWNpZmllZCIsDQogICAgICAgICJ0cnN2Y2lkIjogIm5vbmUiLA0KICAgICAg
ICAidHJ0eXBlIjogImZjIg0KICAgICAgfSwNCiAgICAgICJhbmFfZ3JvdXBzIjogWw0KICAg
ICAgICB7DQogICAgICAgICAgImFuYSI6IHsNCiAgICAgICAgICAgICJzdGF0ZSI6ICJvcHRp
bWl6ZWQiDQogICAgICAgICAgfSwNCiAgICAgICAgICAiZ3JwaWQiOiAxDQogICAgICAgIH0N
CiAgICAgIF0sDQogICAgICAicGFyYW0iOiB7DQogICAgICAgICJpbmxpbmVfZGF0YV9zaXpl
IjogIi0xIiwNCiAgICAgICAgInBpX2VuYWJsZSI6ICIwIg0KICAgICAgfSwNCiAgICAgICJw
b3J0aWQiOiAyLA0KICAgICAgInJlZmVycmFscyI6IFtdLA0KICAgICAgInN1YnN5c3RlbXMi
OiBbXQ0KICAgIH0NCiAgXSwNCiAgInN1YnN5c3RlbXMiOiBbDQogICAgew0KICAgICAgImFs
bG93ZWRfaG9zdHMiOiBbXSwNCiAgICAgICJhdHRyIjogew0KICAgICAgICAiYWxsb3dfYW55
X2hvc3QiOiAiMSIsDQogICAgICAgICJjbnRsaWRfbWF4IjogIjY1NTE5IiwNCiAgICAgICAg
ImNudGxpZF9taW4iOiAiMSIsDQogICAgICAgICJtb2RlbCI6ICJMaW51eCIsDQogICAgICAg
ICJwaV9lbmFibGUiOiAiMCIsDQogICAgICAgICJxaWRfbWF4IjogIjEyOCIsDQogICAgICAg
ICJzZXJpYWwiOiAiZTliOWMzZDBmZTZhYjViN2I1NGUiLA0KICAgICAgICAidmVyc2lvbiI6
ICIxLjMiDQogICAgICB9LA0KICAgICAgIm5hbWVzcGFjZXMiOiBbXSwNCiAgICAgICJucW4i
OiAidGVzdCINCiAgICB9LA0KICAgIHsNCiAgICAgICJhbGxvd2VkX2hvc3RzIjogW10sDQog
ICAgICAiYXR0ciI6IHsNCiAgICAgICAgImFsbG93X2FueV9ob3N0IjogIjEiLA0KICAgICAg
ICAiY250bGlkX21heCI6ICI2NTUxOSIsDQogICAgICAgICJjbnRsaWRfbWluIjogIjEiLA0K
ICAgICAgICAibW9kZWwiOiAiTGludXgiLA0KICAgICAgICAicGlfZW5hYmxlIjogIjAiLA0K
ICAgICAgICAicWlkX21heCI6ICIxMjgiLA0KICAgICAgICAic2VyaWFsIjogIjJlNzdjNGY5
ZWFkMGI5ZDg1YzU1IiwNCiAgICAgICAgInZlcnNpb24iOiAiMS4zIg0KICAgICAgfSwNCiAg
ICAgICJuYW1lc3BhY2VzIjogWw0KICAgICAgICB7DQogICAgICAgICAgImFuYV9ncnBpZCI6
IDEsDQogICAgICAgICAgImRldmljZSI6IHsNCiAgICAgICAgICAgICJuZ3VpZCI6ICJlZjkw
Njg5Yy02YzQ2LWQ0NGMtODljMS00MDY3ODAxMzA5YTgiLA0KICAgICAgICAgICAgInBhdGgi
OiAiL2Rldi9udm1lMTBuMSIsDQogICAgICAgICAgICAidXVpZCI6ICJlZmY0N2UwMS0wNmE0
LTRmYjEtODJiZS1iZmYzMDNiNmRiZjciDQogICAgICAgICAgfSwNCiAgICAgICAgICAiZW5h
YmxlIjogMSwNCiAgICAgICAgICAibnNpZCI6IDENCiAgICAgICAgfQ0KICAgICAgXSwNCiAg
ICAgICJucW4iOiAidGVzdG5xbiINCiAgICB9DQogIF0NCn0NCg==

--------------LhKQNlVA8ie3J2hV0d0cXlz1--

