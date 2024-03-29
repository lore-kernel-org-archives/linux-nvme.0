Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2267FCD11DD
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Mar 2024 09:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gcltwoo8S6ISUY/CBYRisxQN0djDSDd2jK4mVxeoNts=; b=kvsrdeV0z7xihjwrU4WfXcZTRI
	9W+/zmsnkrSMbagvzIFd3MhF5cx6FmUoAuKIl3uRZqM9fV9LphYl6hQVPlC8N0Sqyvm9BVyV9nbOD
	iqEeXwVRuKUa/mzW6GuNU6Wq2UMwFnRZm+ev5ZNgdn22AWQa1ktBjog1W/BPp1cQZHXbsVXM8IWs3
	f1EqtfoXiuxnrjS5RCUtN95yJQKPMOMb+iEogv4og1FbU3yoqXm4JKy+7AZmfnGsT+kXZxSCbqZUD
	DIa+u1B5vEMXgvTjAGakNi51s3e6SmnoAOhctWyOgZGGAxfcdAxCpevJ/wEijOFivYCbd/kTy+89J
	wMhSuWmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rq8Sp-0000000HTD9-0Ip1;
	Fri, 29 Mar 2024 09:23:55 +0000
Received: from mail.send.com.pl ([89.31.64.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rq8Sm-0000000HTCR-06ct
	for linux-nvme@lists.infradead.org;
	Fri, 29 Mar 2024 09:23:53 +0000
Received: from localhost (localhost [127.0.0.1])
	by zmail.send.com.pl (Postfix) with ESMTP id 795AC4C69;
	Fri, 29 Mar 2024 10:23:50 +0100 (CET)
Received: from zmail.send.com.pl ([127.0.0.1])
 by localhost (zmail.send.com.pl [127.0.0.1]) (amavis, port 10032) with ESMTP
 id aaivpmJ9Kmdu; Fri, 29 Mar 2024 10:23:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zmail.send.com.pl (Postfix) with ESMTP id 116375090;
	Fri, 29 Mar 2024 10:23:49 +0100 (CET)
X-Virus-Scanned: amavis at send.com.pl
Received: from zmail.send.com.pl ([127.0.0.1])
 by localhost (zmail.send.com.pl [127.0.0.1]) (amavis, port 10026) with ESMTP
 id i_NR8xJUaCbM; Fri, 29 Mar 2024 10:23:49 +0100 (CET)
Received: from [172.16.10.4] (unknown [89.31.64.4])
	by zmail.send.com.pl (Postfix) with ESMTPSA id 003994C69;
	Fri, 29 Mar 2024 10:23:48 +0100 (CET)
Message-ID: <3dae318d-517b-446e-a44e-61a101c7ae7e@sibersoft.pl>
Date: Fri, 29 Mar 2024 10:23:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nvmetcli FC transport problem
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <e7be9608-7e1d-4da3-985b-644b66443dec@sibersoft.pl>
 <ak47crahgtdwhb2ecc22eseidltasw2sppbrq2ik57r6raal5f@n67q7wbbl7jr>
Content-Language: pl
From: =?UTF-8?B?xYF1a2FzeiBLb2rFgm8=?= <l.kojlo@sibersoft.pl>
In-Reply-To: <ak47crahgtdwhb2ecc22eseidltasw2sppbrq2ik57r6raal5f@n67q7wbbl7jr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240329_022352_301503_30D3F948 
X-CRM114-Status: GOOD (  14.49  )
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

Hello

I'v tried nvmetcli v0.8 with ubuntu kernel 6.8.0 but still have same prob=
lem

*/ports/1/subsystems> create test
Could not symlink test in configFS: [Errno 6] No such device or address:=20
'/sys/kernel/config/nvmet/subsystems/test' ->=20
'/sys/kernel/config/nvmet/ports/1/subsystems/test'*

Nothing in dmesg

FC card I'm using it's QLogic QLE2740

 =C2=A0Class Device path =3D=20
"/sys/devices/pci0000:00/0000:00:03.0/0000:04:00.0/host11/fc_host/host11"
 =C2=A0=C2=A0=C2=A0 dev_loss_tmo=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =3D "30"
 =C2=A0=C2=A0=C2=A0 fabric_name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D "0xffffffffffffffff"
 =C2=A0=C2=A0=C2=A0 issue_lip=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 =3D <store method only>
 =C2=A0=C2=A0=C2=A0 max_npiv_vports=C2=A0=C2=A0=C2=A0=C2=A0 =3D "254"
 =C2=A0=C2=A0=C2=A0 node_name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 =3D "0x20000024ff1491be"
 =C2=A0=C2=A0=C2=A0 npiv_vports_inuse=C2=A0=C2=A0 =3D "0"
 =C2=A0=C2=A0=C2=A0 port_id=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 =3D "0x000001"
 =C2=A0=C2=A0=C2=A0 port_name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 =3D "0x21000024ff1491be"
 =C2=A0=C2=A0=C2=A0 port_state=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D "Online"
 =C2=A0=C2=A0=C2=A0 port_type=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 =3D "Point-To-Point (direct nport connection)"
 =C2=A0=C2=A0=C2=A0 speed=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "32 Gbit"
 =C2=A0=C2=A0=C2=A0 supported_classes=C2=A0=C2=A0 =3D "Class 3"
 =C2=A0=C2=A0=C2=A0 supported_speeds=C2=A0=C2=A0=C2=A0 =3D "8 Gbit, 16 Gb=
it, 32 Gbit"
 =C2=A0=C2=A0=C2=A0 symbolic_name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
 "QLE2740 FW:v9.08.02 DVR:v10.02.07.900-k"
 =C2=A0=C2=A0=C2=A0 system_hostname=C2=A0=C2=A0=C2=A0=C2=A0 =3D ""
 =C2=A0=C2=A0=C2=A0 tgtid_bind_type=C2=A0=C2=A0=C2=A0=C2=A0 =3D "wwpn (Wo=
rld Wide Port Name)"
 =C2=A0=C2=A0=C2=A0 uevent=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D
 =C2=A0=C2=A0=C2=A0 vport_create=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =3D <store method only>
 =C2=A0=C2=A0=C2=A0 vport_delete=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =3D <store method only>/
/

NVME modules I have loaded in kernel

    lsmod | grep nvme
    nvmet_fc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 45056=C2=A0 0
    nvmet=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 196608=C2=A0 7 nvmet_fc
    nvme_keyring=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 20480=C2=A0 1 nvmet
    nvme_fc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 57344=C2=A0 1 qla2xxx
    nvme=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 61440=C2=A0 8
    nvme_fabrics=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 36864=C2=A0 1 nvme_fc
    nvme_core=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 212992=C2=A0 12 nvmet,nvme,nvme_fc,nvme_fabrics
    nvme_auth=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 28672=C2=A0 2 nvmet,nvme_core

Configuration file in attachment.

What am I missing ?

W dniu 28.03.2024 o=C2=A009:51, Daniel Wagner pisze:
> Hi,
>
> On Tue, Mar 26, 2024 at 02:44:41PM +0100, =C5=81ukasz Koj=C5=82o wrote:
>> I'm using nvmetcli version 0.7 on OpenSUSE=C2=A0 LEAP 15.5
> [...]
>> Can you please help me ?
> You are using downstream version of nvmetcli and the kernel, maintained
> by your distro vendor. In this case you should report the problem there
> (bugzilla.opensuse.org).
>
> Here on this mailing list, we ask you to try with current upstream
> version to reproduce the problem, e.g. nvmetcli 0.8 and the latest
> release upstream kernel v6.8.x. If you still observe your problem, feel
> free to post your results.
>
> Thanks,
> Daniel
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


