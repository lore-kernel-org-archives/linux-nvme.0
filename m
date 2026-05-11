Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE04CCD37B5
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 07:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9omUeZuixFYsT7uXtVHKnBpa/xIQEYGW4lN08Cwb4hE=; b=JkYMk8cQ4SCuDg1H/6vg2UIexm
	65ODJV7/2Ai9kYAltbJjTmhF5bqqFx5s2zR8l1OBdNx1TLkI8izqBDZBdscn8c8woHlmYrdgbt4h9
	2NRR0T3BAOmPlcQKweBLS8cEN35M95St0ePdNfki6jzQ1W+deIAzDnBRUcO4HJcbEc5pVFXIgUxug
	dmaTq0E+fO5g++zzYmEP1SCt/bHsI3opmQ8PuEMGA9TEi/vmZWVb0X7ndP3nTTB8SKEhTIC6T521F
	wqm5w7GDMaYAuAXJyz14/bxRDKeNAqWpUDE259UqM+8r/KzDdMacVADcp5gEJvfAw67ZNgyMncIc1
	jx19DrQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMLYF-0000000CgFT-10G5;
	Mon, 11 May 2026 07:59:43 +0000
Received: from out28-61.mail.aliyun.com ([115.124.28.61])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMLYB-0000000CgCk-3p5j
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 07:59:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=alancui.cc; s=default;
	t=1778486372; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=9omUeZuixFYsT7uXtVHKnBpa/xIQEYGW4lN08Cwb4hE=;
	b=bzp5MKP358aQIiidI8HUtY+dtuJk7gGjyg+p4LJGsnl2OrbWxZeno5ej11m8ff4nrmbY4TiRSkVoxU1u88CWR2Qvxow/w9wsPc56gBopQnkzUyxkk9vwucc/dCiqHAHE7XOHPDf13tAtSMRw2ntfRMkQifB8HdlCU6KJ/kpi1Y6lgQZEyAJnSEdQ+oTcxQtxt5njdbso7WQw7klxEyvim6XGrrr9+Jk0cugK8JyuYiNtORwVzcFiCPxtJ/XiZVI+05F/4vYG56gKKuayYVgca1MIPloNc334hXb4ln63pB8VZfCIyQVml2oStStrJY5sbZV34PGAJg5oozBn+tUNZg==
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07521747|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00332975-0.000293396-0.996377;FP=15945236355861753154|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083013073;MF=me@alancui.cc;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.hUQJTUZ_1778486368;
Received: from alanarchdesktop.localnet(mailfrom:me@alancui.cc fp:SMTPD_---.hUQJTUZ_1778486368 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 11 May 2026 15:59:29 +0800
From: AlanCui4080 <me@alancui.cc>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: make providing NGUID as UUID usage less scary
Date: Mon, 11 May 2026 15:59:28 +0800
Message-ID: <3lJTQSoXQt6w2XGXP0Zqlg@alancui.cc>
In-Reply-To: <73735bc1-9821-42d8-9594-1e9cdb03e15a@grimberg.me>
References: <UPNVP7_KTI2VieaAyBtUMA@alancui.cc>
 <73735bc1-9821-42d8-9594-1e9cdb03e15a@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_005940_149041_B54690BE 
X-CRM114-Status: GOOD (  18.25  )
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

Hi,

On Monday, 11 May 2026 06:19=EF=BC=8Cyou wrote=EF=BC=9A

> TBH, I'm not sure why should this be a warning or an info log. This=20
> looks like a debug print to me.
>=20
> Keith WDYT?

By the way, current way how kernel generate UUID by NGUID is
not compliant with RFC 4122 and NVMe spec.

[alan@AlanArchDesktop ~]$ cat /sys/block/nvme0n1/uuid=20
00000000-0000-0000-a428-xxxxxxxxxxxx
[alan@AlanArchDesktop ~]$ cat /sys/block/nvme0n1/nguid=20
00000000-0000-0000-a428-xxxxxxxxxxxx

And according to NVMe 1.4 spec 7.10.6 UUID
   The Universally Unique Identifier is defined in RFC4122 and con-
   tained in the Namespace Identification Descriptor

So,
According to RFC 4122 4.3 Algorithm for Creating a Name-Based UUID:

> The version 3 or 5 UUID is meant for generating UUIDs from "names"
> that are drawn from, and unique within, some "name space".  The
> concept of name and name space should be broadly construed, and not
> limited to textual names.  For example, some name spaces are the
> domain name system, URLs, ISO Object IDs (OIDs), X.500 Distinguished
> Names (DNs), and reserved words in a programming language.  The
> mechanisms or conventions used for allocating names and ensuring
> their uniqueness within their name spaces are beyond the scope of
> this specification.
=2E..
> The algorithm for generating a UUID from a name and a name space are
> as follows:
>  o  Allocate a UUID to use as a "name space ID" for all UUIDs
>     generated from names in that name space; see Appendix C for some
>     pre-defined values.
>  o  Choose either MD5 [4] or SHA-1 [8] as the hash algorithm; If
>     backward compatibility is not an issue, SHA-1 is preferred.
>  o  Convert the name to a canonical sequence of octets (as defined by
>     the standards or conventions of its name space); put the name
>     space ID in network byte order.
>  o  Compute the hash of the name space ID concatenated with the name.
>  o  Set octts zero through 3 of the time_low field to octets zero
>     through 3 of the hash.
>  o  Set octets zero and one of the time_mid field to octets 4 and 5 of
>     the hash.
>  o  Set octets zero and one of the time_hi_and_version field to octets
>     6 and 7 of the hash.
>  o  Set the four most significant bits (bits 12 through 15) of the
>     time_hi_and_version field to the appropriate 4-bit version number
>     from Section 4.1.3.
>  o  Set the clock_seq_hi_and_reserved field to octet 8 of the hash.
>  o  Set the two most significant bits (bits 6 and 7) of the
>     clock_seq_hi_and_reserved to zero and one, respectively.
>  o  Set the clock_seq_low field to octet 9 of the hash.
>  o  Set octets zero through five of the node field to octets 10
>     through 15 of the hash.
>  o  Convert the resulting UUID to local byte order.

However, the NVMe spec does not specified a namespace ID, so,
I selected a stirng "nqn.2014-08.org.nvmexpress:nguid",
then do SHA1 on it, get 4dead072-6b40-f992-9447-40f235d55fee,
then replace the version to '5' and variant to '1' to follow RFC 4122, get =
4dead072-6b40-1992-8447-40f235d55fee

So for the NGUID A42812345678ABCD, a way to generate a canonnical
UUID is:
```
import uuid
namespace =3D uuid.UUID('4dead072-6b40-1992-8447-40f235d55fee')
nguid_bytes =3D bytes.fromhex('A42812345678ABCD')
result_uuid =3D uuid.uuid5(namespace, nguid_bytes)
print(result_uuid)
```
Resulting 9f4344db-6bf0-5782-b8a9-a08b6aa55169.

It's too complicated, right? RFC9562 provides us UUIDv8,=20

> UUIDv8 provides a format for experimental or vendor-specific
>  use cases. The only requirement is that the variant and version
>  bits MUST be set as defined in Sections 4.1 and 4.2.

Let's set the first 6 avalible custom bytes to "NGUID:",
move the first 4bits of NGUID before the variant 4bits .

So for the NGUID A42812345678ABCD, it's 78718573-6858-800A-8428-12345678abc=
d.

Alan.




