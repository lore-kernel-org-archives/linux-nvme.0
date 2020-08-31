Return-Path: <SRS0=W+Vz=CJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27454C433E6
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 11:33:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3A9F207DA
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 11:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tyxb/wt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A9F207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	MIME-Version:Date:Message-ID:Subject:From:To:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=cwAb3PIr4f8z6Yqoh4vV08NfT2wMX5WWx4n3EgkDoEg=; b=tyx
	b/wt3RmIhOfYJzO0zVEwc8xcE4fPij8aiCtJz7evJCZRjZH5GVmCFx6HNjA+XXllHeVxXxgXrQ3TN
	vUBAPpiNbj1sOXmAFWkn2ljdI3+bHxp+WImjI1DBQ49rkncmNnCpY1VrEcpvN5RNt0QMaLXAq5DW8
	gGiJfTPyRrQv3Y0zQefdJ8hVbSL3wyutZMpc2lwZbgrXZ3A0GvNoQSEkuy4OhL1z5AoMRtmKZifli
	nrwxaNYt0/ox6tgT+BSCrw1DXRnAKQOyyJKxKSZqbFuC6s9KfBd/t0Q2kYLPAHqujTImc7G9OHfv3
	Cc5VCtPQFJIUVEp4RyLHQV4DmGz7aQw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kCi48-0008FO-KQ; Mon, 31 Aug 2020 11:33:36 +0000
Received: from a.mx.secunet.com ([62.96.220.36])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCi3z-0008Be-90
 for linux-nvme@lists.infradead.org; Mon, 31 Aug 2020 11:33:33 +0000
Received: from localhost (localhost [127.0.0.1])
 by a.mx.secunet.com (Postfix) with ESMTP id EC08B201E5;
 Mon, 31 Aug 2020 13:33:14 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
 by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DmVF_F4H6lim; Mon, 31 Aug 2020 13:33:09 +0200 (CEST)
Received: from cas-essen-01.secunet.de (201.40.53.10.in-addr.arpa
 [10.53.40.201])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by a.mx.secunet.com (Postfix) with ESMTPS id 3A29820491;
 Mon, 31 Aug 2020 13:33:09 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 31 Aug 2020 13:33:09 +0200
Received: from [172.18.16.185] (172.18.16.185) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 31 Aug
 2020 13:33:08 +0200
To: Sagi Grimberg <sagi@grimberg.me>
From: Torsten Hilbrich <torsten.hilbrich@secunet.com>
Autocrypt: addr=torsten.hilbrich@secunet.com; prefer-encrypt=mutual; keydata=
 mQENBFs5uIIBCAD4qbEieyT7sBmcro1VrCE1sSnV29a9ub8c0Xj0yw0Cz2N7LalBn4a+YeJN
 OMfL1MQvEiTxZNIzb1I0bRYcfhkhjN4+vAoPJ3q1OpSY+WUgphUbzseUk/Bq3gwvfa6/U+Hm
 o2lvEfN2dewBGptQ+DrWz+SPM1TQiwShKjowY/avaVgrABBGen3LgB0XZXEH8Q720kjP7htK
 tCGRt1T+qNIj3tZDZfPkqEVb8lTRcyn1hI3/FbDTysletRrCmkHSVbnxNzO6lw2G1H61wQhw
 YVbIVNohY61ieSJFhNLL6/UTGHtUE2IAicnsUAUKR8GiI1+3cTf233O5HaWYeOjBmTCLABEB
 AAG0L1RvcnN0ZW4gSGlsYnJpY2ggPHRvcnN0ZW4uaGlsYnJpY2hAc2VjdW5ldC5jb20+iQE3
 BBMBCAAhBQJbObiCAhsDBQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEJ7rXZh78/h8+tIH
 +QFYRQH4qh3WagcmjbG/zCe2RmZZePO8bmut2fAxY04aqJZGYUBxb5lfaWaHkstqM5sFD8Jo
 k1j5E7f1cnfwB21azdUO8fzYL889kdVOzatdT/uTjR7OjR59gpJMd4lx7fwFuZUg8z6rfWJ3
 ImjxxBgaJRL6pqaZ9lOst82O0qJKEFBR+HDUVvgh4n8TTOfKNv/dGPQhaed+2or98asdYRWo
 S/zc4ltTh4SxZjLd98pDxjlUyOJoMJeWdlMmLgWV3h1qjy4DxgQzvgATEaKjOuwtkCOcwHn7
 Unf0F2V9p4O7NFOuoVyqTBRX+5xKgzSM7VP1RlTT4FA9/7wkhhG+FEK5AQ0EWzm4ggEIAL9F
 IIPQYMx5x+zMjm8lDsmh12zoqCtMfn9QWrERd2gDS3GsORbe/i6DhYvzsulH8vsviPle4ocU
 +PaTwadfnEqm0FS7xCONYookDGfAiPS4cHWX7WrTNBP7mK3Gl1KaAOJJsMbCVAA9q4d8WL+A
 e+XrfOAetZq5gxLxDMYySNI1pIMJVrGECiboLa/LPPh2yw4jieAedW96CPuZs7rUY/5uIVt0
 Dn4/aSzV+Ixr52Z2McvNmH/VxDt59Z6jBztZIJBXpX3BC/UyH7rJOJTaqEF+EVWEpOmSoZ6u
 i1DWyqOBKnQrbUa0fpNd3aaOl2KnlgTH9upm70XZGpeJik/pQGcAEQEAAYkBHwQYAQgACQUC
 Wzm4ggIbDAAKCRCe612Ye/P4fEzqB/9gcM/bODO8o9YR86BLp0S8bF73lwIJyDHg5brjqAnz
 CtCdb4I+evI4iyU9zuN1x4V+Te5ej+mUu5CbIte8gQbo4cc9sbe/AEDoOh0lGoXKZiwtHqoh
 RZ4jOFrZJsEjOSUCLE8E8VR1afPf0SkFXLXWZfZDU28K80JWeV1BCtxutZ39bz6ybMbcCvMS
 UfwCTY0IJOiDga1K4H2HzHAqlvfzCurqe616S4S1ax+erg3KTEXylxmzcFjJU8AUZURy/lQt
 VElzs4Km1p3v6GUciCAb+Uhd12sQG2mL05jmEems9uRe3Wfke/RKp8A+Yq+p6E0A0ZOP+Okm
 LXB2q+ckPvZG
Subject: [Regression] [PATCH] nvme/core: Access to NULL pointer in sysfs
Message-ID: <b3723cbd-45cb-1e71-479b-9d11b0670a93@secunet.com>
Date: Mon, 31 Aug 2020 13:33:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------3FC3523ABCC1C9B271AFEAA8"
Content-Language: en-US
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--------------3FC3523ABCC1C9B271AFEAA8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello,

when updating my kernel to a v5.9-rc2-based build I noticed some kernel
crashes when accessing the reconnect_delay and ctrl_loss_tmo sysfs
properties.

The kernel logs are attached in:

- panic-2.log: For ctrl_loss_tmo
- panic-2.log: For reconnect_delay

It seems that for my NVME-based SSD the ctrl->opts member is NULL.

The attached patch nvme-core.patch adds the accordings checks:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 154942fc64eb..4fa5cc317cf3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3586,7 +3586,7 @@ static ssize_t nvme_ctrl_loss_tmo_show(struct
device *dev,
        struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
        struct nvmf_ctrl_options *opts = ctrl->opts;

-       if (ctrl->opts->max_reconnects == -1)
+       if (! opts || opts->max_reconnects == -1)
                return sprintf(buf, "off\n");
        return sprintf(buf, "%d\n",
                        opts->max_reconnects * opts->reconnect_delay);
@@ -3618,7 +3618,7 @@ static ssize_t
nvme_ctrl_reconnect_delay_show(struct device *dev,
 {
        struct nvme_ctrl *ctrl = dev_get_drvdata(dev);

-       if (ctrl->opts->reconnect_delay == -1)
+       if (! ctrl->opts || ctrl->opts->reconnect_delay == -1)
                return sprintf(buf, "off\n");
        return sprintf(buf, "%d\n", ctrl->opts->reconnect_delay);
 }

With regards,

	Torsten Hilbrich

-- 
Dipl.-Inform.
Torsten Hilbrich
Teamleiter Bereich Entwicklung
Abteilung Network & Client Security
Divison Public Authorities
secunet Security Networks AG
Konrad-Zuse-Platz 2-4
81829 München

Tel: +49-201-5454-3522
Fax: +49-201-5454-1327
torsten.hilbrich@secunet.com
www.secunet.com

______________________________________________________________________

secunet Security Networks AG
Sitz: Kurfürstenstraße 58, 45138 Essen, Deutschland
Amtsgericht Essen HRB 13615
Vorstand: Axel Deininger (Vors.), Torsten Henn, Dr. Kai Martius, Thomas
          Pleines
Aufsichtsratsvorsitzender: Ralf Wintergerst
______________________________________________________________________


--------------3FC3523ABCC1C9B271AFEAA8
Content-Type: text/x-log; charset="UTF-8"; name="panic-3.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="panic-3.log"

Oops#1 Part1
<6>[    0.000000] microcode: microcode updated early to revision 0xd6, da=
te =3D 2020-04-27
<5>[    0.000000] Linux version 5.9.0-devel+ (thilbrich@ts-6) (gcc (Debia=
n 8.3.0-6) 8.3.0, GNU ld (GNU Binutils for Debian) 2.31.1) #9 SMP Mon Aug=
 31 11:54:04 CEST 2020
<6>[    0.000000] Command line: BOOT_IMAGE=3D/isolinux/bzImage console=3D=
tty1 intel_iommu=3Don,igfx_off
<6>[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating =
point registers'
<6>[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers=
'
<6>[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers=
'
<6>[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds re=
gisters'
<6>[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
<6>[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
<6>[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
<6>[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
<6>[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is =
960 bytes, using 'compacted' format.
<6>[    0.000000] BIOS-provided physical RAM map:
<6>[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] =
usable
<6>[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] =
reserved
<6>[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009cfff] =
usable
<6>[    0.000000] BIOS-e820: [mem 0x000000000009d000-0x00000000000fffff] =
reserved
<6>[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000090b6cfff] =
usable
<6>[    0.000000] BIOS-e820: [mem 0x0000000090b6d000-0x0000000090b6dfff] =
ACPI NVS
<6>[    0.000000] BIOS-e820: [mem 0x0000000090b6e000-0x0000000090b6efff] =
reserved
<6>[    0.000000] BIOS-e820: [mem 0x0000000090b6f000-0x000000009a4abfff] =
usable
<6>[    0.000000] BIOS-e820: [mem 0x000000009a4ac000-0x000000009a573fff] =
type 20
<6>[    0.000000] BIOS-e820: [mem 0x000000009a574000-0x000000009b52bfff] =
reserved
<6>[    0.000000] BIOS-e820: [mem 0x000000009b52c000-0x000000009b54cfff] =
ACPI NVS
<6>[    0.000000] BIOS-e820: [mem 0x000000009b54d000-0x000000009b54dfff] =
reserved
<6>[    0.000000] BIOS-e820: [mem 0x000000009b54e000-0x000000009b599fff] =
ACPI NVS
<6>[    0.000000] BIOS-e820: [mem 0x000000009b59a000-0x000000009b5fefff] =
ACPI data
<6>[    0.000000] BIOS-e820: [mem 0x000000009b5ff000-0x000000009b5fffff] =
usable
<6>[    0.000000] BIOS-e820: [mem 0x000000009b600000-0x000000009f7fffff] =
reserved
<6>[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] =
reserved
<6>[    0.000000] BIOS-e820: [mem 0x00000000fe010000-0x00000000fe010fff] =
reserved
<6>[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000065f7fffff] =
usable
<6>[    0.000000] SMT: disabled
<6>[    0.000000] NX (Execute Disable) protection: active
<6>[    0.000000] user-defined physical RAM map:
<6>[    0.000000] user: [mem 0x0000000000000000-0x0000000000057fff] usabl=
e
<6>[    0.000000] user: [mem 0x0000000000058000-0x0000000000058fff] reser=
ved
<6>[    0.000000] user: [mem 0x0000000000059000-0x000000000009cfff] usabl=
e
<6>[    0.000000] user: [mem 0x000000000009d000-0x00000000000fffff] reser=
ved
<6>[    0.000000] user: [mem 0x0000000000100000-0x000000003fffffff] usabl=
e
<6>[    0.000000] user: [mem 0x0000000040000000-0x0000000041ffffff] reser=
ved
<6>[    0.000000] user: [mem 0x0000000042000000-0x0000000090b6cfff] usabl=
e
<6>[    0.000000] user: [mem 0x0000000090b6d000-0x0000000090b6dfff] ACPI =
NVS
<6>[    0.000000] user: [mem 0x0000000090b6e000-0x0000000090b6efff] reser=
ved
<6>[    0.000000] user: [mem 0x0000000090b6f000-0x000000009a4abfff] usabl=
e
<6>[    0.000000] user: [mem 0x000000009a4ac000-0x000000009a573fff] type =
20
<6>[    0.000000] user: [mem 0x000000009a574000-0x000000009b52bfff] reser=
ved
<6>[    0.000000] user: [mem 0x000000009b52c000-0x000000009b54cfff] ACPI =
NVS
<6>[    0.000000] user: [mem 0x000000009b54d000-0x000000009b54dfff] reser=
ved
<6>[    0.000000] user: [mem 0x000000009b54e000-0x000000009b599fff] ACPI =
NVS
<6>[    0.000000] user: [mem 0x000000009b59a000-0x000000009b5fefff] ACPI =
data
<6>[    0.000000] user: [mem 0x000000009b5ff000-0x000000009b5fffff] usabl=
e
<6>[    0.000000] user: [mem 0x000000009b600000-0x000000009f7fffff] reser=
ved
<6>[    0.000000] user: [mem 0x00000000f8000000-0x00000000fbffffff] reser=
ved
<6>[    0.000000] user: [mem 0x00000000fe010000-0x00000000fe010fff] reser=
ved
<6>[    0.000000] user: [mem 0x0000000100000000-0x000000065f7fffff] usabl=
e
<6>[    0.000000] efi: EFI v2.50 by Lenovo
<6>[    0.000000] efi: TPMFinalLog=3D0x9b592000 SMBIOS=3D0x9a6d8000 SMBIO=
S 3.0=3D0x9a6d5000 ACPI=3D0x9b5fe000 ACPI 2.0=3D0x9b5fe014 ESRT=3D0x9a5a2=
000 MEMATTR=3D0x953ec018=20
<6>[    0.000000] SMBIOS 3.0.0 present.
<6>[    0.000000] DMI: LENOVO 20HGS0TW00/20HGS0TW00, BIOS N1WET46S (1.25s=
 ) 03/30/2018
<6>[    0.000000] tsc: Detected 2900.000 MHz processor
<6>[    0.001180] tsc: Detected 2899.886 MHz TSC
<7>[    0.001180] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D>=
 reserved
<7>[    0.001184] e820: remove [mem 0x000a0000-0x000fffff] usable
<6>[    0.001197] last_pfn =3D 0x65f800 max_arch_pfn =3D 0x400000000
<7>[    0.001204] MTRR default type: write-back
<7>[    0.001205] MTRR fixed ranges enabled:
<7>[    0.001207]   00000-9FFFF write-back
<7>[    0.001209]   A0000-BFFFF uncachable
<7>[    0.001211]   C0000-FFFFF write-protect
<7>[    0.001212] MTRR variable ranges enabled:
<7>[    0.001215]   0 base 00C0000000 mask 7FC0000000 uncachable
<7>[    0.001216]   1 base 00A0000000 mask 7FE0000000 uncachable
<7>[    0.001218]   2 base 009E000000 mask 7FFE000000 uncachable
<7>[    0.001219]   3 base 009D000000 mask 7FFF000000 uncachable
<7>[    0.001220]   4 disabled
<7>[    0.001221]   5 disabled
<7>[    0.001222]   6 disabled
<7>[    0.001223]   7 disabled
<7>[    0.001224]   8 disabled
<7>[    0.001224]   9 disabled
<6>[    0.002101] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  U=
C- WT =20
<6>[    0.003191] last_pfn =3D 0x9b600 max_arch_pfn =3D 0x400000000
<6>[    0.025185] esrt: Reserving ESRT space from 0x000000009a5a2000 to 0=
x000000009a5a2088.
<6>[    0.025201] check: Scanning 1 areas for low memory corruption
<6>[    0.025210] Using GB pages for direct mapping
<6>[    0.025695] Secure boot could not be determined
<6>[    0.025697] RAMDISK: [mem 0x34215000-0x36101fff]
<6>[    0.025712] ACPI: Early table checksum verification disabled
<6>[    0.025716] ACPI: RSDP 0x000000009B5FE014 000024 (v02 LENOVO)
<6>[    0.025722] ACPI: XSDT 0x000000009B5C2188 000104 (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.025732] ACPI: FACP 0x000000009B5F5000 0000F4 (v05 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.025740] ACPI: DSDT 0x000000009B5D0000 020CF2 (v02 LENOVO SKL   =
   00000000 INTL 20160527)
<6>[    0.025745] ACPI: FACS 0x000000009B53C000 000040
<6>[    0.025750] ACPI: SSDT 0x000000009B5FC000 0003CC (v02 LENOVO Tpm2Ta=
bl 00001000 INTL 20160527)
<6>[    0.025754] ACPI: TPM2 0x000000009B5FB000 000034 (v03 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.025759] ACPI: UEFI 0x000000009B553000 000042 (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.025764] ACPI: SSDT 0x000000009B5F7000 003246 (v02 LENOVO SaSsdt=
   00003000 INTL 20160527)
<6>[    0.025769] ACPI: SSDT 0x000000009B5F6000 0005B6 (v02 LENOVO PerfTu=
ne 00001000 INTL 20160527)
<6>[    0.025773] ACPI: HPET 0x000000009B5F4000 000038 (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.025778] ACPI: APIC 0x000000009B5F3000 0000BC (v03 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.025782] ACPI: MCFG 0x000000009B5F2000 00003C (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.025787] ACPI: ECDT 0x000000009B5F1000 000053 (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.025791] ACPI: SSDT 0x000000009B5CE000 0016F3 (v02 LENOVO ProjSs=
dt 00000010 INTL 20160527)
<6>[    0.025796] ACPI: BOOT 0x000000009B5CD000 000028 (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.025800] ACPI: BATB 0x000000009B5CC000 00004A (v02 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.025805] ACPI: SLIC 0x000000009B5CB000 000176 (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.025810] ACPI: SSDT 0x000000009B5C9000 0017AE (v02 LENOVO CpuSsd=
t  00003000 INTL 20160527)
<6>[    0.025814] ACPI: SSDT 0x000000009B5C8000 00056D (v02 LENOVO CtdpB =
   00001000 INTL 20160527)
<6>[    0.025819] ACPI: SSDT 0x000000009B5C7000 000634 (v02 LENOVO UsbCTa=
bl 00001000 INTL 20160527)
<6>[    0.025823] ACPI: WSMT 0x000000009B5C6000 000028 (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.025828] ACPI: SSDT 0x000000009B5C5000 000141 (v02 LENOVO HdaDsp=
   00000000 INTL 20160527)
<6>[    0.025833] ACPI: SSDT 0x000000009B5C4000 0004C5 (v02 LENOVO TbtTyp=
eC 00000000 INTL 20160527)
<6>[    0.025837] ACPI: DBGP 0x000000009B5C3000 000034 (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.025842] ACPI: DBG2 0x000000009B5FD000 000054 (v00 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.025846] ACPI: MSDM 0x000000009B5C1000 000055 (v03 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.025851] ACPI: DMAR 0x000000009B5C0000 0000A8 (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.025855] ACPI: ASF! 0x000000009B5BF000 0000A0 (v32 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.025860] ACPI: FPDT 0x000000009B5BE000 000044 (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.025864] ACPI: BGRT 0x000000009B5BD000 000038 (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.025869] ACPI: UEFI 0x000000009B539000 00013E (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<7>[    0.025880] ACPI: Local APIC address 0xfee00000
<6>[    0.026140] No NUMA configuration found
<6>[    0.026142] Faking a node at [mem 0x0000000000000000-0x000000065f7f=
ffff]
<6>[    0.026149] NODE_DATA(0) allocated [mem 0x65f7fc000-0x65f7fffff]
<6>[    0.026192] Zone ranges:
<6>[    0.026193]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
<6>[    0.026196]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
<6>[    0.026198]   Normal   [mem 0x0000000100000000-0x000000065f7fffff]
<6>[    0.026200] Movable zone start for each node
<6>[    0.026202] Early memory node ranges
<6>[    0.026204]   node   0: [mem 0x0000000000001000-0x0000000000057fff]=

<6>[    0.026206]   node   0: [mem 0x0000000000059000-0x000000000009cfff]=

<6>[    0.026207]   node   0: [mem 0x0000000000100000-0x000000003fffffff]=

<6>[    0.026209]   node   0: [mem 0x0000000042000000-0x0000000090b6cfff]=

<6>[    0.026211]   node   0: [mem 0x0000000090b6f000-0x000000009a4abfff]=

<6>[    0.026213]   node   0: [mem 0x000000009b5ff000-0x000000009b5fffff]=

<6>[    0.026214]   node   0: [mem 0x0000000100000000-0x000000065f7fffff]=

<6>[    0.026798] Zeroed struct page in unavailable ranges: 33722 pages
<6>[    0.026800] Initmem setup node 0 [mem 0x0000000000001000-0x00000006=
5f7fffff]
<7>[    0.026804] On node 0 totalpages: 6257734
<7>[    0.026805]   DMA zone: 64 pages used for memmap
<7>[    0.026806]   DMA zone: 22 pages reserved
<7>[    0.026808]   DMA zone: 3995 pages, LIFO batch:0
<7>[    0.026847]   DMA32 zone: 9683 pages used for memmap
<7>[    0.026849]   DMA32 zone: 619691 pages, LIFO batch:63
<7>[    0.032966]   Normal zone: 88032 pages used for memmap
<7>[    0.032967]   Normal zone: 5634048 pages, LIFO batch:63
<6>[    0.088502] Reserving Intel graphics memory at [mem 0x9d800000-0x9f=
7fffff]
<6>[    0.088914] ACPI: PM-Timer IO Port: 0x1808
<7>[    0.088917] ACPI: Local APIC address 0xfee00000
<6>[    0.088926] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
<6>[    0.088927] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
<6>[    0.088929] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
<6>[    0.088930] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
<6>[    0.088932] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
<6>[    0.088933] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
<6>[    0.088934] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
<6>[    0.088936] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
<6>[    0.088969] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, G=
SI 0-119
<6>[    0.088972] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl=
)
<6>[    0.088975] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high le=
vel)
<7>[    0.088977] ACPI: IRQ0 used by override.
<7>[    0.088979] ACPI: IRQ9 used by override.
<6>[    0.088982] Using ACPI (MADT) for SMP configuration information
<6>[    0.088985] ACPI: HPET id: 0x8086a201 base: 0xfed00000
<7>[    0.088995] e820: update [mem 0x94dcc000-0x94f0bfff] usable =3D=3D>=
 reserved
<6>[    0.089009] TSC deadline timer available
<6>[    0.089011] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
<6>[    0.089043] [mem 0x9f800000-0xf7ffffff] available for PCI devices
<6>[    0.089048] clocksource: refined-jiffies: mask: 0xffffffff max_cycl=
es: 0xffffffff, max_idle_ns: 1910969940391419 ns
<6>[    0.100614] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:4 =
nr_node_ids:1
<6>[    0.100864] percpu: Embedded 53 pages/cpu s176728 r8192 d32168 u524=
288
<7>[    0.100874] pcpu-alloc: s176728 r8192 d32168 u524288 alloc=3D1*2097=
152
<7>[    0.100875] pcpu-alloc: [0] 0 1 2 3=20
<6>[    0.100906] Built 1 zonelists, mobility grouping on.  Total pages: =
6159933
<6>[    0.100907] Policy zone: Normal
<5>[    0.100910] Kernel command line: memmap=3D0x2000000$0x40000000 ramo=
ops.mem_address=3D0x40000000 ramoops.mem_size=3D0x2000000 ramoops.ecc=3D1=
 ramoops.record_size=3D0x200000 ramoops.console_size=3D0 ramoops.ftrace_s=
ize=3D0 ramoops.pmsg_size=3D0 mem_sleep_default=3Ddeep l1tf=3Dfull mds=3D=
full nosmt BOOT_IMAGE=3D/isolinux/bzImage console=3Dtty1 intel_iommu=3Don=
,igfx_off
<6>[    0.101188] DMAR: IOMMU enabled
<6>[    0.101190] DMAR: Disable GFX device mapping
<6>[    0.104247] Dentry cache hash table entries: 4194304 (order: 13, 33=
554432 bytes, linear)
<6>[    0.105784] Inode-cache hash table entries: 2097152 (order: 12, 167=
77216 bytes, linear)
<6>[    0.105857] mem auto-init: stack:off, heap alloc:off, heap free:off=

<6>[    0.194716] Memory: 24382024K/25030936K available (16387K kernel co=
de, 1782K rwdata, 5580K rodata, 1556K init, 4176K bss, 648652K reserved, =
0K cma-reserved)
<6>[    0.194788] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D=
4, Nodes=3D1
<6>[    0.194796] Kernel/User page tables isolation: enabled
<6>[    0.194824] ftrace: allocating 47289 entries in 185 pages
<6>[    0.230887] ftrace: allocated 185 pages with 5 groups
<6>[    0.231008] rcu: Hierarchical RCU implementation.
<6>[    0.231010] rcu: 	RCU event tracing is enabled.
<6>[    0.231012] rcu: 	RCU restricting CPUs from NR_CPUS=3D8 to nr_cpu_i=
ds=3D4.
<6>[    0.231014] 	Rude variant of Tasks RCU enabled.
<6>[    0.231016] rcu: RCU calculated value of scheduler-enlistment delay=
 is 100 jiffies.
<6>[    0.231017] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cp=
u_ids=3D4
<6>[    0.236641] NR_IRQS: 4352, nr_irqs: 1024, preallocated irqs: 16
<5>[    0.237582] random: get_random_bytes called from start_kernel+0x369=
/0x52c with crng_init=3D0
<6>[    0.237618] Console: colour dummy device 80x25
<6>[    0.238036] printk: console [tty1] enabled
<6>[    0.238060] ACPI: Core revision 20200717
<6>[    0.238566] clocksource: hpet: mask: 0xffffffff max_cycles: 0xfffff=
fff, max_idle_ns: 79635855245 ns
<6>[    0.238659] APIC: Switch to symmetric I/O mode setup
<6>[    0.242837] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pi=
n2=3D-1
<6>[    0.247638] clocksource: tsc-early: mask: 0xffffffffffffffff max_cy=
cles: 0x29ccd767b87, max_idle_ns: 440795223720 ns
<6>[    0.247650] Calibrating delay loop (skipped), value calculated usin=
g timer frequency.. 5799.77 BogoMIPS (lpj=3D2899886)
<6>[    0.247657] pid_max: default: 32768 minimum: 301
<6>[    0.252678] LSM: Security Framework initializing
<6>[    0.252771] Mount-cache hash table entries: 65536 (order: 7, 524288=
 bytes, linear)
<6>[    0.252852] Mountpoint-cache hash table entries: 65536 (order: 7, 5=
24288 bytes, linear)
<6>[    0.253252] mce: CPU0: Thermal monitoring enabled (TM1)
<6>[    0.253289] process: using mwait in idle threads
<6>[    0.253296] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
<6>[    0.253299] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
<6>[    0.253306] Spectre V1 : Mitigation: usercopy/swapgs barriers and _=
_user pointer sanitization
<6>[    0.253313] Spectre V2 : Mitigation: Full generic retpoline
<6>[    0.253316] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Fillin=
g RSB on context switch
<6>[    0.253321] Spectre V2 : Enabling Restricted Speculation for firmwa=
re calls
<6>[    0.253326] Spectre V2 : mitigation: Enabling conditional Indirect =
Branch Prediction Barrier
<6>[    0.253331] Spectre V2 : User space: Mitigation: STIBP via seccomp =
and prctl
<6>[    0.253337] Speculative Store Bypass: Mitigation: Speculative Store=
 Bypass disabled via prctl and seccomp
<6>[    0.253341] SMT: disabled
<6>[    0.253353] SRBDS: Mitigation: Microcode
<6>[    0.253356] MDS: Mitigation: Clear CPU buffers
<6>[    0.253983] Freeing SMP alternatives memory: 40K
<6>[    0.254764] smpboot: CPU0: Intel(R) Core(TM) i7-7500U CPU @ 2.70GHz=
 (family: 0x6, model: 0x8e, stepping: 0x9)
<6>[    0.254906] Performance Events: PEBS fmt3+, Skylake events, 32-deep=
 LBR, full-width counters, Intel PMU driver.
<6>[    0.254925] ... version:                4
<6>[    0.254928] ... bit width:              48
<6>[    0.254931] ... generic registers:      4
<6>[    0.254934] ... value mask:             0000ffffffffffff
<6>[    0.254937] ... max period:             00007fffffffffff
<6>[    0.254940] ... fixed-purpose events:   3
<6>[    0.254943] ... event mask:             000000070000000f
<6>[    0.255017] rcu: Hierarchical SRCU implementation.
<6>[    0.255658] NMI watchdog: Enabled. Permanently consumes one hw-PMU =
counter.
<6>[    0.255736] smp: Bringing up secondary CPUs ...
<6>[    0.255852] x86: Booting SMP configuration:
<6>[    0.255856] .... node  #0, CPUs:      #1 #2 #3
<6>[    0.266390] smp: Brought up 1 node, 2 CPUs
<6>[    0.266401] smpboot: Max logical packages: 2
<6>[    0.266405] smpboot: Total of 2 processors activated (11599.54 Bogo=
MIPS)
<6>[    0.267129] devtmpfs: initialized
<6>[    0.267129] PM: Registering ACPI NVS region [mem 0x90b6d000-0x90b6d=
fff] (4096 bytes)
<6>[    0.267129] PM: Registering ACPI NVS region [mem 0x9b52c000-0x9b54c=
fff] (135168 bytes)
<6>[    0.267129] PM: Registering ACPI NVS region [mem 0x9b54e000-0x9b599=
fff] (311296 bytes)
<6>[    0.267666] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xff=
ffffff, max_idle_ns: 1911260446275000 ns
<6>[    0.267666] futex hash table entries: 1024 (order: 4, 65536 bytes, =
linear)
<6>[    0.267796] pinctrl core: initialized pinctrl subsystem
<6>[    0.267941] PM: RTC time: 10:37:47, date: 2020-08-31
<6>[    0.268080] NET: Registered protocol family 16
<6>[    0.268336] ramoops: using module parameters
<6>[    0.268673] ramoops: uncorrectable error in header
<6>[    0.268760] ramoops: uncorrectable error in header
<6>[    0.268825] ramoops: uncorrectable error in header
<6>[    0.268889] ramoops: uncorrectable error in header
<6>[    0.268953] ramoops: uncorrectable error in header
<6>[    0.269015] ramoops: uncorrectable error in header
<6>[    0.269072] ramoops: uncorrectable error in header
<6>[    0.269134] ramoops: uncorrectable error in header
<6>[    0.269207] ramoops: uncorrectable error in header
<6>[    0.269266] ramoops: uncorrectable error in header
<6>[    0.269329] ramoops: uncorrectable error in header
<6>[    0.269386] ramoops: uncorrectable error in header
<6>[    0.269442] ramoops: uncorrectable error in header
<6>[    0.269499] ramoops: uncorrectable error in header
<6>[    0.269556] ramoops: uncorrectable error in header
<6>[    0.269614] ramoops: uncorrectable error in header
<6>[    0.269864] pstore: Registered ramoops as persistent store backend
<6>[    0.269868] ramoops: using 0x2000000@0x40000000, ecc: 16
<6>[    0.269992] thermal_sys: Registered thermal governor 'step_wise'
<6>[    0.269993] thermal_sys: Registered thermal governor 'user_space'
<6>[    0.270012] cpuidle: using governor menu
<6>[    0.270161] Simple Boot Flag at 0x47 set to 0x1
<6>[    0.270161] ACPI FADT declares the system doesn't support PCIe ASPM=
, so disable it
<6>[    0.270161] ACPI: bus type PCI registered
<6>[    0.270161] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0=
=2E5
<6>[    0.270161] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf80=
00000-0xfbffffff] (base 0xf8000000)
<6>[    0.270161] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved i=
n E820
<6>[    0.270161] PCI: Using configuration type 1 for base access
<4>[    0.270834] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
<6>[    0.274891] cryptomgr_test (36) used greatest stack depth: 15728 by=
tes left
<6>[    0.275672] cryptomgr_test (64) used greatest stack depth: 15680 by=
tes left
<6>[    0.275677] cryptomgr_test (66) used greatest stack depth: 15368 by=
tes left
<6>[    0.275724] ACPI: Added _OSI(Module Device)
<6>[    0.275728] ACPI: Added _OSI(Processor Device)
<6>[    0.275731] ACPI: Added _OSI(3.0 _SCP Extensions)
<6>[    0.275735] ACPI: Added _OSI(Processor Aggregator Device)
<6>[    0.275739] ACPI: Added _OSI(Linux-Dell-Video)
<6>[    0.275743] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
<6>[    0.275746] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
<6>[    0.354160] ACPI: 10 ACPI AML tables successfully acquired and load=
ed
<6>[    0.356472] ACPI: EC: EC started
<6>[    0.356475] ACPI: EC: interrupt blocked
<6>[    0.360158] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
<6>[    0.360162] ACPI: EC: Boot ECDT EC used to handle transactions
<5>[    0.363086] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
<6>[    0.375059] ACPI: Dynamic OEM Table Load:
<6>[    0.375084] ACPI: SSDT 0xFFFF9AFA43925800 0006F6 (v02 PmRef  Cpu0Is=
t  00003000 INTL 20160527)
<6>[    0.377669] ACPI: \_PR_.PR00: _OSC native thermal LVT Acked
<6>[    0.379398] ACPI: Dynamic OEM Table Load:
<6>[    0.379414] ACPI: SSDT 0xFFFF9AFA4396BC00 0003FF (v02 PmRef  Cpu0Cs=
t  00003001 INTL 20160527)
<6>[    0.381954] ACPI: Dynamic OEM Table Load:
<6>[    0.381968] ACPI: SSDT 0xFFFF9AFA43476540 0000BA (v02 PmRef  Cpu0Hw=
p  00003000 INTL 20160527)
<6>[    0.384356] ACPI: Dynamic OEM Table Load:
<6>[    0.384370] ACPI: SSDT 0xFFFF9AFA43926000 000628 (v02 PmRef  HwpLvt=
   00003000 INTL 20160527)
<6>[    0.387357] ACPI: Dynamic OEM Table Load:
<6>[    0.387377] ACPI: SSDT 0xFFFF9AFA434A8000 000D14 (v02 PmRef  ApIst =
   00003000 INTL 20160527)
<6>[    0.390853] ACPI: Dynamic OEM Table Load:
<6>[    0.390868] ACPI: SSDT 0xFFFF9AFA434B0000 000317 (v02 PmRef  ApHwp =
   00003000 INTL 20160527)
<6>[    0.393468] ACPI: Dynamic OEM Table Load:
<6>[    0.393481] ACPI: SSDT 0xFFFF9AFA434B0400 00030A (v02 PmRef  ApCst =
   00003000 INTL 20160527)
<6>[    0.397973] ACPI: Interpreter enabled
<6>[    0.398047] ACPI: (supports S0 S3 S5)
<6>[    0.398051] ACPI: Using IOAPIC for interrupt routing
<6>[    0.398117] PCI: Using host bridge windows from ACPI; if necessary,=
 use "pci=3Dnocrs" and report a bug
<6>[    0.399185] ACPI: Enabled 7 GPEs in block 00 to 7F
<6>[    0.405011] ACPI: Power Resource [PUBS] (on)
<6>[    0.423621] ACPI: Power Resource [WRST] (on)
<6>[    0.425302] ACPI: Power Resource [WRST] (on)
<6>[    0.444989] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
<6>[    0.445002] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM=
 ClockPM Segments MSI HPX-Type3]
<6>[    0.445216] acpi PNP0A08:00: _OSC: platform does not support [PCIeH=
otplug SHPCHotplug PME PCIeCapability]
<6>[    0.445316] acpi PNP0A08:00: _OSC: not requesting control; platform=
 does not support [PCIeCapability]
<6>[    0.445322] acpi PNP0A08:00: _OSC: OS requested [PCIeHotplug SHPCHo=
tplug PME PCIeCapability LTR]
<6>[    0.445327] acpi PNP0A08:00: _OSC: platform willing to grant [LTR]
<6>[    0.445331] acpi PNP0A08:00: _OSC failed (AE_SUPPORT); disabling AS=
PM
<6>[    0.447384] PCI host bridge to bus 0000:00
<6>[    0.447390] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 w=
indow]
<6>[    0.447395] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff w=
indow]
<6>[    0.447399] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x00=
0bffff window]
<6>[    0.447404] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x00=
0c3fff window]
<6>[    0.447408] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x00=
0c7fff window]
<6>[    0.447412] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x00=
0cbfff window]
<6>[    0.447417] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x00=
0cffff window]
<6>[    0.447421] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x00=
0d3fff window]
<6>[    0.447425] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x00=
0d7fff window]
<6>[    0.447429] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x00=
0dbfff window]
<6>[    0.447434] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x00=
0dffff window]
<6>[    0.447438] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x00=
0e3fff window]
<6>[    0.447442] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x00=
0e7fff window]
<6>[    0.447446] pci_bus 0000:00: root bus resource [mem 0x000e8000-0x00=
0ebfff window]
<6>[    0.447451] pci_bus 0000:00: root bus resource [mem 0x000ec000-0x00=
0effff window]
<6>[    0.447455] pci_bus 0000:00: root bus resource [mem 0x000f0000-0x00=
0fffff window]
<6>[    0.447459] pci_bus 0000:00: root bus resource [mem 0x9f800000-0xf7=
ffffff window]
<6>[    0.447463] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe=
7fffff window]
<6>[    0.447468] pci_bus 0000:00: root bus resource [bus 00-3e]
<6>[    0.447496] pci 0000:00:00.0: [8086:5904] type 00 class 0x060000
<6>[    0.448859] pci 0000:00:02.0: [8086:5916] type 00 class 0x030000
<6>[    0.448879] pci 0000:00:02.0: reg 0x10: [mem 0xeb000000-0xebffffff =
64bit]
<6>[    0.448892] pci 0000:00:02.0: reg 0x18: [mem 0xa0000000-0xafffffff =
64bit pref]
<6>[    0.448903] pci 0000:00:02.0: reg 0x20: [io  0xe000-0xe03f]
<6>[    0.448934] pci 0000:00:02.0: BAR 2: assigned to efifb
<6>[    0.450377] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330
<6>[    0.450408] pci 0000:00:14.0: reg 0x10: [mem 0xec220000-0xec22ffff =
64bit]
<6>[    0.450504] pci 0000:00:14.0: PME# supported from D3hot D3cold
<6>[    0.452017] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000
<6>[    0.452044] pci 0000:00:14.2: reg 0x10: [mem 0xec248000-0xec248fff =
64bit]
<6>[    0.453468] pci 0000:00:16.0: [8086:9d3a] type 00 class 0x078000
<6>[    0.453492] pci 0000:00:16.0: reg 0x10: [mem 0xec249000-0xec249fff =
64bit]
<6>[    0.453596] pci 0000:00:16.0: PME# supported from D3hot
<6>[    0.455055] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400
<6>[    0.455169] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
<6>[    0.455195] pci 0000:00:1c.0: Intel SPT PCH root port ACS workaroun=
d enabled
<6>[    0.456639] pci 0000:00:1c.2: [8086:9d12] type 01 class 0x060400
<6>[    0.456766] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
<6>[    0.456794] pci 0000:00:1c.2: Intel SPT PCH root port ACS workaroun=
d enabled
<6>[    0.458248] pci 0000:00:1d.0: [8086:9d18] type 01 class 0x060400
<6>[    0.458369] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
<6>[    0.458407] pci 0000:00:1d.0: Intel SPT PCH root port ACS workaroun=
d enabled
<6>[    0.459875] pci 0000:00:1f.0: [8086:9d58] type 00 class 0x060100
<6>[    0.461430] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000
<6>[    0.461452] pci 0000:00:1f.2: reg 0x10: [mem 0xec244000-0xec247fff]=

<6>[    0.462927] pci 0000:00:1f.3: [8086:9d71] type 00 class 0x040300
<6>[    0.462962] pci 0000:00:1f.3: reg 0x10: [mem 0xec240000-0xec243fff =
64bit]
<6>[    0.463008] pci 0000:00:1f.3: reg 0x20: [mem 0xec230000-0xec23ffff =
64bit]
<6>[    0.463084] pci 0000:00:1f.3: PME# supported from D3hot D3cold
<6>[    0.464538] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500
<6>[    0.464596] pci 0000:00:1f.4: reg 0x10: [mem 0xec24a000-0xec24a0ff =
64bit]
<6>[    0.464654] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
<6>[    0.466146] pci 0000:00:1f.6: [8086:15d8] type 00 class 0x020000
<6>[    0.466176] pci 0000:00:1f.6: reg 0x10: [mem 0xec200000-0xec21ffff]=

<6>[    0.466312] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
<6>[    0.467804] pci 0000:00:1c.0: PCI bridge to [bus 01-39]
<6>[    0.467816] pci 0000:00:1c.0:   bridge window [mem 0xd4000000-0xea0=
fffff]
<6>[    0.467827] pci 0000:00:1c.0:   bridge window [mem 0xb0000000-0xd1f=
fffff 64bit pref]
<6>[    0.468334] pci 0000:3a:00.0: [8086:24fd] type 00 class 0x028000
<6>[    0.468425] pci 0000:3a:00.0: reg 0x10: [mem 0xec100000-0xec101fff =
64bit]
<6>[    0.468802] pci 0000:3a:00.0: PME# supported from D0 D3hot D3cold
<6>[    0.469614] pci 0000:00:1c.2: PCI bridge to [bus 3a]
<6>[    0.469625] pci 0000:00:1c.2:   bridge window [mem 0xec100000-0xec1=
fffff]
<6>[    0.469929] pci 0000:3c:00.0: [144d:a804] type 00 class 0x010802
<6>[    0.469957] pci 0000:3c:00.0: reg 0x10: [mem 0xec000000-0xec003fff =
64bit]
<6>[    0.470458] pci 0000:00:1d.0: PCI bridge to [bus 3c]
<6>[    0.470467] pci 0000:00:1d.0:   bridge window [mem 0xec000000-0xec0=
fffff]
<6>[    0.473369] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12=
 14 15)
<6>[    0.473464] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12=
 14 15)
<6>[    0.473552] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12=
 14 15)
<6>[    0.473639] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12=
 14 15)
<6>[    0.473726] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 12=
 14 15)
<6>[    0.473813] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11 12=
 14 15)
<6>[    0.473898] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12=
 14 15)
<6>[    0.473985] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11 12=
 14 15)
<6>[    0.474842] ACPI: EC: interrupt unblocked
<6>[    0.474846] ACPI: EC: event unblocked
<6>[    0.474865] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
<6>[    0.474868] ACPI: EC: GPE=3D0x16
<6>[    0.474873] ACPI: \_SB_.PCI0.LPCB.EC__: Boot ECDT EC initialization=
 complete
<6>[    0.474877] ACPI: \_SB_.PCI0.LPCB.EC__: EC: Used to handle transact=
ions and events
<6>[    0.474985] iommu: Default domain type: Translated=20
<5>[    0.475091] SCSI subsystem initialized
<7>[    0.475149] libata version 3.00 loaded.
<6>[    0.475176] ACPI: bus type USB registered
<6>[    0.475202] usbcore: registered new interface driver usbfs
<6>[    0.475214] usbcore: registered new interface driver hub
<6>[    0.475242] usbcore: registered new device driver usb
<6>[    0.475274] pps_core: LinuxPPS API ver. 1 registered
<6>[    0.475277] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rod=
olfo Giometti <giometti@linux.it>
<6>[    0.475285] PTP clock support registered
<6>[    0.475336] Registered efivars operations
<6>[    0.475374] Advanced Linux Sound Architecture Driver Initialized.
<6>[    0.475578] PCI: Using ACPI for IRQ routing
<7>[    0.478390] PCI: pci_cache_line_size set to 64 bytes
<7>[    0.479408] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
<7>[    0.479410] e820: reserve RAM buffer [mem 0x0009d000-0x0009ffff]
<7>[    0.479412] e820: reserve RAM buffer [mem 0x90b6d000-0x93ffffff]
<7>[    0.479413] e820: reserve RAM buffer [mem 0x94dcc000-0x97ffffff]
<7>[    0.479414] e820: reserve RAM buffer [mem 0x9a4ac000-0x9bffffff]
<7>[    0.479417] e820: reserve RAM buffer [mem 0x9b600000-0x9bffffff]
<7>[    0.479418] e820: reserve RAM buffer [mem 0x65f800000-0x65fffffff]
<4>[    0.479782] acpi PNP0C14:02: duplicate WMI GUID 05901221-D566-11D1-=
B2F0-00A0C9062910 (first instance was on PNP0C14:01)
<4>[    0.479893] acpi PNP0C14:03: duplicate WMI GUID 05901221-D566-11D1-=
B2F0-00A0C9062910 (first instance was on PNP0C14:01)
<6>[    0.481064] clocksource: Switched to clocksource tsc-early
<6>[    0.502446] pnp: PnP ACPI init
<6>[    0.502685] system 00:00: [mem 0xfd000000-0xfdabffff] has been rese=
rved
<6>[    0.502691] system 00:00: [mem 0xfdad0000-0xfdadffff] has been rese=
rved
<6>[    0.502696] system 00:00: [mem 0xfdb00000-0xfdffffff] has been rese=
rved
<6>[    0.502700] system 00:00: [mem 0xfe000000-0xfe01ffff] could not be =
reserved
<6>[    0.502704] system 00:00: [mem 0xfe036000-0xfe03bfff] has been rese=
rved
<6>[    0.502709] system 00:00: [mem 0xfe03d000-0xfe3fffff] has been rese=
rved
<6>[    0.502713] system 00:00: [mem 0xfe410000-0xfe7fffff] has been rese=
rved
<7>[    0.502723] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (a=
ctive)
<6>[    0.503234] system 00:01: [io  0xff00-0xfffe] has been reserved
<7>[    0.503243] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (a=
ctive)
<6>[    0.504080] system 00:02: [io  0x0680-0x069f] has been reserved
<6>[    0.504086] system 00:02: [io  0xffff] has been reserved
<6>[    0.504090] system 00:02: [io  0xffff] has been reserved
<6>[    0.504093] system 00:02: [io  0xffff] has been reserved
<6>[    0.504097] system 00:02: [io  0x1800-0x18fe] has been reserved
<6>[    0.504101] system 00:02: [io  0x164e-0x164f] has been reserved
<7>[    0.504109] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (a=
ctive)
<7>[    0.504276] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (acti=
ve)
<6>[    0.504336] system 00:04: [io  0x1854-0x1857] has been reserved
<7>[    0.504345] system 00:04: Plug and Play ACPI device, IDs INT3f0d PN=
P0c02 (active)
<7>[    0.504374] pnp 00:05: Plug and Play ACPI device, IDs LEN0071 PNP03=
03 (active)
<7>[    0.504398] pnp 00:06: Plug and Play ACPI device, IDs LEN006c PNP0f=
13 (active)
<6>[    0.504555] system 00:07: [io  0x1800-0x189f] could not be reserved=

<6>[    0.504561] system 00:07: [io  0x0800-0x087f] has been reserved
<6>[    0.504565] system 00:07: [io  0x0880-0x08ff] has been reserved
<6>[    0.504569] system 00:07: [io  0x0900-0x097f] has been reserved
<6>[    0.504573] system 00:07: [io  0x0980-0x09ff] has been reserved
<6>[    0.504577] system 00:07: [io  0x0a00-0x0a7f] has been reserved
<6>[    0.504581] system 00:07: [io  0x0a80-0x0aff] has been reserved
<6>[    0.504585] system 00:07: [io  0x0b00-0x0b7f] has been reserved
<6>[    0.504589] system 00:07: [io  0x0b80-0x0bff] has been reserved
<6>[    0.504593] system 00:07: [io  0x15e0-0x15ef] has been reserved
<6>[    0.504598] system 00:07: [io  0x1600-0x167f] could not be reserved=

<6>[    0.504602] system 00:07: [io  0x1640-0x165f] could not be reserved=

<6>[    0.504607] system 00:07: [mem 0xf8000000-0xfbffffff] has been rese=
rved
<6>[    0.504611] system 00:07: [mem 0xfed10000-0xfed13fff] has been rese=
rved
<6>[    0.504618] system 00:07: [mem 0xfed18000-0xfed18fff] has been rese=
rved
<6>[    0.504622] system 00:07: [mem 0xfed19000-0xfed19fff] has been rese=
rved
<6>[    0.504627] system 00:07: [mem 0xfeb00000-0xfebfffff] has been rese=
rved
<6>[    0.504631] system 00:07: [mem 0xfed20000-0xfed3ffff] has been rese=
rved
<6>[    0.504635] system 00:07: [mem 0xfed90000-0xfed93fff] has been rese=
rved
<6>[    0.504640] system 00:07: [mem 0xf7fe0000-0xf7ffffff] has been rese=
rved
<7>[    0.504654] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (a=
ctive)
<6>[    0.506723] system 00:08: [mem 0xfdaf0000-0xfdafffff] has been rese=
rved
<6>[    0.506729] system 00:08: [mem 0xfdae0000-0xfdaeffff] has been rese=
rved
<6>[    0.506733] system 00:08: [mem 0xfdac0000-0xfdacffff] has been rese=
rved
<7>[    0.506741] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (a=
ctive)
<6>[    0.507629] system 00:09: [mem 0xfed10000-0xfed17fff] could not be =
reserved
<6>[    0.507634] system 00:09: [mem 0xfed18000-0xfed18fff] has been rese=
rved
<6>[    0.507638] system 00:09: [mem 0xfed19000-0xfed19fff] has been rese=
rved
<6>[    0.507643] system 00:09: [mem 0xf8000000-0xfbffffff] has been rese=
rved
<6>[    0.507653] system 00:09: [mem 0xfed20000-0xfed3ffff] has been rese=
rved
<6>[    0.507657] system 00:09: [mem 0xfed90000-0xfed93fff] has been rese=
rved
<6>[    0.507662] system 00:09: [mem 0xfed45000-0xfed8ffff] has been rese=
rved
<6>[    0.507666] system 00:09: [mem 0xff000000-0xffffffff] has been rese=
rved
<6>[    0.507670] system 00:09: [mem 0xfee00000-0xfeefffff] has been rese=
rved
<6>[    0.507675] system 00:09: [mem 0xf7fe0000-0xf7ffffff] has been rese=
rved
<7>[    0.507683] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (a=
ctive)
<6>[    0.508105] system 00:0a: [mem 0x00000000-0x0009ffff] could not be =
reserved
<6>[    0.508110] system 00:0a: [mem 0x000f0000-0x000fffff] could not be =
reserved
<6>[    0.508115] system 00:0a: [mem 0x00100000-0x9f7fffff] could not be =
reserved
<6>[    0.508120] system 00:0a: [mem 0xfec00000-0xfed3ffff] could not be =
reserved
<6>[    0.508124] system 00:0a: [mem 0xfed4c000-0xffffffff] could not be =
reserved
<7>[    0.508132] system 00:0a: Plug and Play ACPI device, IDs PNP0c01 (a=
ctive)
<6>[    0.508317] pnp: PnP ACPI: found 11 devices
<6>[    0.514749] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffff=
ff, max_idle_ns: 2085701024 ns
<6>[    0.514795] NET: Registered protocol family 2
<6>[    0.514976] tcp_listen_portaddr_hash hash table entries: 16384 (ord=
er: 6, 262144 bytes, linear)
<6>[    0.515038] TCP established hash table entries: 262144 (order: 9, 2=
097152 bytes, linear)
<6>[    0.515476] TCP bind hash table entries: 65536 (order: 8, 1048576 b=
ytes, linear)
<6>[    0.515644] TCP: Hash tables configured (established 262144 bind 65=
536)
<6>[    0.515684] UDP hash table entries: 16384 (order: 7, 524288 bytes, =
linear)
<6>[    0.515793] UDP-Lite hash table entries: 16384 (order: 7, 524288 by=
tes, linear)
<6>[    0.515958] NET: Registered protocol family 1
<6>[    0.516106] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to =
[bus 01-39] add_size 1000
<6>[    0.516121] pci 0000:00:1c.0: BAR 7: assigned [io  0x2000-0x2fff]
<6>[    0.516126] pci 0000:00:1c.0: PCI bridge to [bus 01-39]
<6>[    0.516135] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
<6>[    0.516146] pci 0000:00:1c.0:   bridge window [mem 0xd4000000-0xea0=
fffff]
<6>[    0.516154] pci 0000:00:1c.0:   bridge window [mem 0xb0000000-0xd1f=
fffff 64bit pref]
<6>[    0.516166] pci 0000:00:1c.2: PCI bridge to [bus 3a]
<6>[    0.516175] pci 0000:00:1c.2:   bridge window [mem 0xec100000-0xec1=
fffff]
<6>[    0.516188] pci 0000:00:1d.0: PCI bridge to [bus 3c]
<6>[    0.516205] pci 0000:00:1d.0:   bridge window [mem 0xec000000-0xec0=
fffff]
<6>[    0.516232] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
<6>[    0.516236] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
<6>[    0.516240] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff =
window]
<6>[    0.516244] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff =
window]
<6>[    0.516248] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff =
window]
<6>[    0.516252] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff =
window]
<6>[    0.516256] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff=
 window]
<6>[    0.516260] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff=
 window]
<6>[    0.516264] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff=
 window]
<6>[    0.516268] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff=
 window]
<6>[    0.516272] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff=
 window]
<6>[    0.516276] pci_bus 0000:00: resource 15 [mem 0x000e0000-0x000e3fff=
 window]
<6>[    0.516280] pci_bus 0000:00: resource 16 [mem 0x000e4000-0x000e7fff=
 window]
<6>[    0.516284] pci_bus 0000:00: resource 17 [mem 0x000e8000-0x000ebfff=
 window]
<6>[    0.516288] pci_bus 0000:00: resource 18 [mem 0x000ec000-0x000effff=
 window]
<6>[    0.516292] pci_bus 0000:00: resource 19 [mem 0x000f0000-0x000fffff=
 window]
<6>[    0.516296] pci_bus 0000:00: resource 20 [mem 0x9f800000-0xf7ffffff=
 window]
<6>[    0.516300] pci_bus 0000:00: resource 21 [mem 0xfd000000-0xfe7fffff=
 window]
<6>[    0.516304] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
<6>[    0.516308] pci_bus 0000:01: resource 1 [mem 0xd4000000-0xea0fffff]=

<6>[    0.516312] pci_bus 0000:01: resource 2 [mem 0xb0000000-0xd1ffffff =
64bit pref]
<6>[    0.516317] pci_bus 0000:3a: resource 1 [mem 0xec100000-0xec1fffff]=

<6>[    0.516321] pci_bus 0000:3c: resource 1 [mem 0xec000000-0xec0fffff]=

<6>[    0.516542] pci 0000:00:02.0: Video device with shadowed ROM at [me=
m 0x000c0000-0x000dffff]
<6>[    0.517552] PCI: CLS 0 bytes, default 64
<6>[    0.517602] Unpacking initramfs...
<6>[    6.390263] Freeing initrd memory: 31668K
<6>[    6.390301] DMAR: Host address width 39
<6>[    6.390306] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
<6>[    6.390332] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c=
40660462 ecap 19e2ff0505e
<6>[    6.390338] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
<6>[    6.390351] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c4=
0660462 ecap f050da
<6>[    6.390355] DMAR: RMRR base: 0x0000009aa9f000 end: 0x0000009aabefff=

<6>[    6.390360] DMAR: RMRR base: 0x0000009d000000 end: 0x0000009f7fffff=

<6>[    6.390376] DMAR: No ATSR found
<3>[    6.390422] pci 0000:00:02.0: DMAR: TH(1) Prevent segfault for iomm=
u access
<6>[    6.390433] DMAR: dmar1: Using Queued invalidation
<6>[    6.390543] pci 0000:00:00.0: Adding to iommu group 0
<6>[    6.390562] pci 0000:00:02.0: Adding to iommu group 1
<6>[    6.390588] pci 0000:00:14.0: Adding to iommu group 2
<6>[    6.390602] pci 0000:00:14.2: Adding to iommu group 2
<6>[    6.390622] pci 0000:00:16.0: Adding to iommu group 3
<6>[    6.390645] pci 0000:00:1c.0: Adding to iommu group 4
<6>[    6.390680] pci 0000:00:1c.2: Adding to iommu group 5
<6>[    6.390711] pci 0000:00:1d.0: Adding to iommu group 6
<6>[    6.390750] pci 0000:00:1f.0: Adding to iommu group 7
<6>[    6.390765] pci 0000:00:1f.2: Adding to iommu group 7
<6>[    6.390782] pci 0000:00:1f.3: Adding to iommu group 7
<6>[    6.390797] pci 0000:00:1f.4: Adding to iommu group 7
<6>[    6.390812] pci 0000:00:1f.6: Adding to iommu group 7
<6>[    6.390833] pci 0000:3a:00.0: Adding to iommu group 8
<6>[    6.390860] pci 0000:3c:00.0: Adding to iommu group 9
<6>[    6.394381] DMAR: Intel(R) Virtualization Technology for Directed I=
/O
<6>[    6.394386] PCI-DMA: Using software bounce buffering for IO (SWIOTL=
B)
<6>[    6.394391] software IO TLB: mapped [mem 0x95b13000-0x99b13000] (64=
MB)
<6>[    6.394551] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 6=
55360 ms ovfl timer
<6>[    6.394555] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
<6>[    6.394559] RAPL PMU: hw unit of domain package 2^-14 Joules
<6>[    6.394562] RAPL PMU: hw unit of domain dram 2^-14 Joules
<6>[    6.394565] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
<6>[    6.394568] RAPL PMU: hw unit of domain psys 2^-14 Joules
<4>[    6.394638] resource sanity check: requesting [mem 0xfed10000-0xfed=
15fff], which spans more than pnp 00:07 [mem 0xfed10000-0xfed13fff]
<4>[    6.394648] caller snb_uncore_imc_init_box+0x7a/0xc0 mapping multip=
le BARs
<6>[    6.394944] check: Scanning for low memory corruption every 60 seco=
nds
<5>[    6.395506] Initialise system trusted keyrings
<6>[    6.395579] workingset: timestamp_bits=3D56 max_order=3D23 bucket_o=
rder=3D0
<6>[    6.397453] squashfs: version 4.0 (2009/01/31) Phillip Lougher
<6>[    6.397530] 9p: Installing v9fs 9p2000 file system support
<5>[    6.414593] Key type asymmetric registered
<5>[    6.414597] Asymmetric key parser 'x509' registered
<6>[    6.414609] Block layer SCSI generic (bsg) driver version 0.4 loade=
d (major 249)
<6>[    6.414613] io scheduler mq-deadline registered
<6>[    6.414616] io scheduler kyber registered
<6>[    6.415676] shpchp: Standard Hot Plug PCI Controller Driver version=
: 0.4
<3>[    6.425245] acpiphp_ibm: ibm_acpiphp_init: acpi_walk_namespace fail=
ed
<6>[    6.425269] efifb: probing for efifb
<6>[    6.425289] efifb: framebuffer at 0xa0000000, using 8128k, total 81=
28k
<6>[    6.425293] efifb: mode is 1920x1080x32, linelength=3D7680, pages=3D=
1
<6>[    6.425295] efifb: scrolling: redraw
<6>[    6.425299] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
<6>[    6.432262] Console: switching to colour frame buffer device 240x67=

<6>[    6.439098] fb0: EFI VGA frame buffer device
<7>[    6.439157] intel_idle: MWAIT substates: 0x11142120
<7>[    6.439158] intel_idle: v0.5.1 model 0x8E
<7>[    6.439343] intel_idle: Local APIC timer is reliable in all C-state=
s
<6>[    6.439892] ACPI: AC Adapter [AC] (off-line)
<6>[    6.440085] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00=
/PNP0C0E:00/input/input0
<6>[    6.440181] ACPI: Sleep Button [SLPB]
<6>[    6.440254] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/P=
NP0C0D:00/input/input1
<6>[    6.440332] ACPI: Lid Switch [LID]
<6>[    6.440401] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00=
/input/input2
<6>[    6.440475] ACPI: Power Button [PWRF]
<6>[    6.445052] thermal LNXTHERM:00: registered as thermal_zone0
<6>[    6.445090] ACPI: Thermal Zone [THM0] (31 C)
<6>[    6.446814] Serial: 8250/16550 driver, 4 ports, IRQ sharing disable=
d
<6>[    6.447051] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D=
 115200) is a 16550A
<6>[    6.447693] Non-volatile memory driver v1.3
<6>[    6.447876] Linux agpgart interface v0.103
<6>[    6.448113] i915 0000:00:02.0: enabling device (0006 -> 0007)
<7>[    6.448955] checking generic (a0000000 7f0000) vs hw (eb000000 1000=
000)
<7>[    6.448956] checking generic (a0000000 7f0000) vs hw (a0000000 1000=
0000)
<6>[    6.448958] fb0: switching to inteldrmfb from EFI VGA
<6>[    6.449138] Console: switching to colour dummy device 80x25
<6>[    6.458482] i915 0000:00:02.0: [drm] Finished loading DMC firmware =
i915/kbl_dmc_ver1_04.bin (v1.4)
<6>[    6.469400] i915 0000:00:02.0: [drm] Panel advertises DPCD backligh=
t support, but VBT disagrees. If your backlight controls don't work try b=
ooting with i915.enable_dpcd_backlight=3D1. If your machine needs this, p=
lease file a _new_ bug report on drm/i915, see https://gitlab.freedesktop=
=2Eorg/drm/intel/-/wikis/How-to-file-i915-bugs for details.
<6>[    6.470158] battery: ACPI: Battery Slot [BAT0] (battery present)
<5>[    6.476700] random: fast init done
<6>[    6.488455] [drm] Initialized i915 1.6.0 20200715 for 0000:00:02.0 =
on minor 0
<6>[    6.493372] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  po=
st: no)
<6>[    6.493985] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PN=
P0A08:00/LNXVIDEO:00/input/input3
<6>[    6.494614] battery: ACPI: Battery Slot [BAT1] (battery present)
<6>[    6.496958] loop: module loaded
<6>[    6.497324] nvme nvme0: pci function 0000:3c:00.0
<6>[    6.497767] sky2: driver version 1.30
<6>[    6.497816] Intel(R) Wireless WiFi driver for Linux
<6>[    6.498787] iwlwifi 0000:3a:00.0: enabling device (0000 -> 0002)
<6>[    6.510495] iwlwifi 0000:3a:00.0: Found debug destination: EXTERNAL=
_DRAM
<6>[    6.510503] iwlwifi 0000:3a:00.0: Found debug configuration: 0
<6>[    6.511246] iwlwifi 0000:3a:00.0: loaded firmware version 36.79ff3c=
cf.0 8265-36.ucode op_mode iwlmvm
<6>[    6.511422] iwlwifi 0000:3a:00.0: Detected Intel(R) Dual Band Wirel=
ess AC 8265, REV=3D0x230
<6>[    6.513689] modprobe (92) used greatest stack depth: 14392 bytes le=
ft
<6>[    6.519411] iwlwifi 0000:3a:00.0: Applying debug destination EXTERN=
AL_DRAM
<6>[    6.519900] iwlwifi 0000:3a:00.0: Allocated 0x00400000 bytes for fi=
rmware monitor.
<6>[    6.522470] nvme nvme0: 4/0/0 default/read/poll queues
<6>[    6.530089]  nvme0n1: p3 p5
<6>[    6.576200] iwlwifi 0000:3a:00.0: base HW address: 00:28:f8:84:36:4=
0
<6>[    6.609234] fbcon: i915drmfb (fb0) is primary device
<6>[    6.643988] Console: switching to colour frame buffer device 240x67=

<7>[    6.657113] ieee80211 phy0: Selected rate control algorithm 'iwl-mv=
m-rs'
<4>[    6.657502] thermal thermal_zone1: failed to read out thermal zone =
(-61)
<6>[    6.657521] usbcore: registered new interface driver r8152
<6>[    6.657534] usbcore: registered new interface driver asix
<6>[    6.657545] usbcore: registered new interface driver ax88179_178a
<6>[    6.657553] usbcore: registered new interface driver cdc_ether
<6>[    6.657560] usbcore: registered new interface driver net1080
<6>[    6.657568] usbcore: registered new interface driver zaurus
<6>[    6.657586] usbcore: registered new interface driver cdc_ncm
<6>[    6.657594] usbcore: registered new interface driver qmi_wwan
<6>[    6.657603] usbcore: registered new interface driver cdc_mbim
<6>[    6.657710] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Dri=
ver
<6>[    6.657713] ehci-pci: EHCI PCI platform driver
<6>[    6.657729] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
<6>[    6.657731] ohci-pci: OHCI PCI platform driver
<6>[    6.657744] uhci_hcd: USB Universal Host Controller Interface drive=
r
<6>[    6.658095] xhci_hcd 0000:00:14.0: xHCI Host Controller
<6>[    6.658145] xhci_hcd 0000:00:14.0: new USB bus registered, assigned=
 bus number 1
<6>[    6.659334] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci versio=
n 0x100 quirks 0x0000000081109810
<6>[    6.659611] xhci_hcd 0000:00:14.0: cache line size of 64 is not sup=
ported
<6>[    6.659920] usb usb1: New USB device found, idVendor=3D1d6b, idProd=
uct=3D0002, bcdDevice=3D 5.09
<6>[    6.659923] usb usb1: New USB device strings: Mfr=3D3, Product=3D2,=
 SerialNumber=3D1
<6>[    6.659925] usb usb1: Product: xHCI Host Controller
<6>[    6.659928] usb usb1: Manufacturer: Linux 5.9.0-devel+ xhci-hcd
<6>[    6.659931] usb usb1: SerialNumber: 0000:00:14.0
<6>[    6.660105] hub 1-0:1.0: USB hub found
<6>[    6.660131] hub 1-0:1.0: 12 ports detected
<6>[    6.662328] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer de=
vice
<6>[    6.663114] xhci_hcd 0000:00:14.0: xHCI Host Controller
<6>[    6.663220] xhci_hcd 0000:00:14.0: new USB bus registered, assigned=
 bus number 2
<6>[    6.663280] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed=

<6>[    6.663411] usb usb2: New USB device found, idVendor=3D1d6b, idProd=
uct=3D0003, bcdDevice=3D 5.09
<6>[    6.663469] usb usb2: New USB device strings: Mfr=3D3, Product=3D2,=
 SerialNumber=3D1
<6>[    6.663535] usb usb2: Product: xHCI Host Controller
<6>[    6.663571] usb usb2: Manufacturer: Linux 5.9.0-devel+ xhci-hcd
<6>[    6.663613] usb usb2: SerialNumber: 0000:00:14.0
<6>[    6.663907] hub 2-0:1.0: USB hub found
<6>[    6.663970] hub 2-0:1.0: 6 ports detected
<4>[    6.665673] usb: port power management may be unreliable
<6>[    6.666082] usbcore: registered new interface driver usblp
<6>[    6.666143] usbcore: registered new interface driver cdc_wdm
<6>[    6.666286] usbcore: registered new interface driver uas
<6>[    6.668351] usbcore: registered new interface driver usb-storage
<6>[    6.670354] usbcore: registered new interface driver ums-datafab
<6>[    6.672343] usbcore: registered new interface driver ums-freecom
<6>[    6.674302] usbcore: registered new interface driver ums-isd200
<6>[    6.676069] usbcore: registered new interface driver ums-jumpshot
<6>[    6.677808] usbcore: registered new interface driver ums-sddr09
<6>[    6.679518] usbcore: registered new interface driver ums-sddr55
<6>[    6.681224] usbcore: registered new interface driver ums-usbat
<6>[    6.928092] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] a=
t 0x60,0x64 irq 1,12
<6>[    6.937920] serio: i8042 KBD port at 0x60,0x64 irq 1
<6>[    6.939877] serio: i8042 AUX port at 0x60,0x64 irq 12
<6>[    6.942006] mousedev: PS/2 mouse device common for all mice
<6>[    6.945744] rtc_cmos 00:03: RTC can wake from S4
<6>[    6.952072] rtc_cmos 00:03: registered as rtc0
<6>[    6.953998] rtc_cmos 00:03: alarms up to one month, y3k, 242 bytes =
nvram, hpet irqs
<6>[    6.955908] input: AT Translated Set 2 keyboard as /devices/platfor=
m/i8042/serio0/input/input4
<6>[    6.956782] i801_smbus 0000:00:1f.4: enabling device (0000 -> 0003)=

<6>[    6.959848] i801_smbus 0000:00:1f.4: SPD Write Disable is set
<6>[    6.961741] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
<6>[    6.966362] i2c i2c-6: 2/2 memory slots populated (from DMI)
<6>[    6.969053] i2c i2c-6: Successfully instantiated SPD at 0x51
<6>[    6.970951] intel_pstate: Intel P-state driver initializing
<6>[    6.972942] intel_pstate: HWP enabled
<6>[    6.973549] EFI Variables Facility v0.08 2004-May-17
<6>[    6.989866] usb 2-3: new SuperSpeed Gen 1 USB device number 2 using=
 xhci_hcd
<6>[    7.017824] hid: raw HID events driver (C) Jiri Kosina
<6>[    7.018478] usbcore: registered new interface driver usbhid
<6>[    7.019076] usbhid: USB HID core driver
<6>[    7.019850] fujitsu_laptop: driver 0.6.0 successfully loaded
<6>[    7.020481] thinkpad_acpi: ThinkPad ACPI Extras v0.26
<6>[    7.021105] thinkpad_acpi: http://ibm-acpi.sf.net/
<6>[    7.021733] thinkpad_acpi: ThinkPad BIOS N1WET46S (1.25s ), EC N1WH=
T37W
<6>[    7.022355] thinkpad_acpi: Lenovo ThinkPad T470s, model 20HGS0TW00
<6>[    7.023000] usb 2-3: New USB device found, idVendor=3D0bda, idProdu=
ct=3D0316, bcdDevice=3D 2.04
<6>[    7.023662] usb 2-3: New USB device strings: Mfr=3D1, Product=3D2, =
SerialNumber=3D3
<6>[    7.024321] usb 2-3: Product: USB3.0-CRW
<6>[    7.024968] usb 2-3: Manufacturer: Generic
<6>[    7.025616] usb 2-3: SerialNumber: 20120501030900000
<6>[    7.028671] thinkpad_acpi: radio switch found; radios are enabled
<6>[    7.029501] thinkpad_acpi: This ThinkPad has standard ACPI backligh=
t brightness control, supported by the ACPI video driver
<5>[    7.030247] thinkpad_acpi: Disabling thinkpad-acpi brightness event=
s by default...
<6>[    7.041370] usb-storage 2-3:1.0: USB Mass Storage device detected
<6>[    7.042267] scsi host0: usb-storage 2-3:1.0
<6>[    7.051064] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio=
 is unblocked
<6>[    7.053572] thinkpad_acpi: rfkill switch tpacpi_wwan_sw: radio is u=
nblocked
<6>[    7.081112] thinkpad_acpi: Standard ACPI backlight interface availa=
ble, not loading native one
<6>[    7.103904] thinkpad_acpi: battery 2 registered (start 0, stop 100)=

<6>[    7.112903] thinkpad_acpi: battery 1 registered (start 0, stop 100)=

<6>[    7.113550] battery: new extension: ThinkPad Battery Extension
<6>[    7.115944] input: ThinkPad Extra Buttons as /devices/platform/thin=
kpad_acpi/input/input7
<6>[    7.122693] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i91=
5_audio_component_bind_ops)
<6>[    7.123667] usbcore: registered new interface driver snd-usb-audio
<6>[    7.124579] IPv4 over IPsec tunneling driver
<6>[    7.125296] usb 1-5: new full-speed USB device number 2 using xhci_=
hcd
<6>[    7.129342] Initializing XFRM netlink socket
<6>[    7.130994] NET: Registered protocol family 10
<6>[    7.131946] Segment Routing with IPv6
<6>[    7.136574] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
<6>[    7.139512] NET: Registered protocol family 17
<6>[    7.140200] NET: Registered protocol family 15
<6>[    7.140866] 9pnet: Installing 9P2000 support
<6>[    7.141764] microcode: sig=3D0x806e9, pf=3D0x80, revision=3D0xd6
<6>[    7.142462] microcode: Microcode Update Driver: v2.2.
<6>[    7.142465] IPI shorthand broadcast: enabled
<6>[    7.143838] sched_clock: Marking stable (7139311782, 4495034)->(715=
0391132, -6584316)
<5>[    7.144580] Loading compiled-in X.509 certificates
<6>[    7.149353] modprobe (106) used greatest stack depth: 14344 bytes l=
eft
<6>[    7.150960] modprobe (107) used greatest stack depth: 14296 bytes l=
eft
<5>[    7.152945] Loaded X.509 cert 'Build time autogenerated kernel key:=
 bac5e2ce99b2c040187df412bfc96e6f4c647cac'
<6>[    7.153668] pstore: Using crash dump compression: deflate
<6>[    7.159492] PM:   Magic number: 0:982:629
<5>[    7.161346] cfg80211: Loading compiled-in X.509 certificates for re=
gulatory database
<6>[    7.173133] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC29=
8: line_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:speaker
<6>[    7.176830] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=3D0 =
(0x0/0x0/0x0/0x0/0x0)
<6>[    7.177693] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=3D2 (0x17=
/0x21/0x0/0x0/0x0)
<6>[    7.178548] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=3D=
0x0
<6>[    7.179420] snd_hda_codec_realtek hdaudioC0D0:    inputs:
<6>[    7.182284] snd_hda_codec_realtek hdaudioC0D0:      Mic=3D0x18
<6>[    7.183007] snd_hda_codec_realtek hdaudioC0D0:      Dock Mic=3D0x19=

<6>[    7.183730] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=3D=
0x12
<5>[    7.184581] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9ce=
a7'
<6>[    7.185344] ALSA device list:
<6>[    7.186061]   No soundcards found.
<6>[    7.187377] Freeing unused kernel image (initmem) memory: 1556K
<6>[    7.192328] Write protecting the kernel read-only data: 24576k
<6>[    7.195343] Freeing unused kernel image (text/rodata gap) memory: 2=
044K
<6>[    7.197225] Freeing unused kernel image (rodata/data gap) memory: 5=
64K
<6>[    7.198624] Run /init as init process
<7>[    7.199337]   with arguments:
<7>[    7.199338]     /init
<7>[    7.199338]   with environment:
<7>[    7.199339]     HOME=3D/
<7>[    7.199339]     TERM=3Dlinux
<7>[    7.199339]     BOOT_IMAGE=3D/isolinux/bzImage
<7>[    7.199340]     intel_iommu=3Don,igfx_off
<6>[    7.245752] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00=
:1f.3/sound/card0/input8
<6>[    7.245782] input: HDA Intel PCH Dock Mic as /devices/pci0000:00/00=
00:00:1f.3/sound/card0/input9
<6>[    7.245810] input: HDA Intel PCH Dock Headphone as /devices/pci0000=
:00/0000:00:1f.3/sound/card0/input10
<6>[    7.245837] input: HDA Intel PCH Headphone as /devices/pci0000:00/0=
000:00:1f.3/sound/card0/input11
<6>[    7.245862] input: HDA Intel PCH HDMI/DP,pcm=3D3 as /devices/pci000=
0:00/0000:00:1f.3/sound/card0/input12
<6>[    7.245887] input: HDA Intel PCH HDMI/DP,pcm=3D7 as /devices/pci000=
0:00/0000:00:1f.3/sound/card0/input13
<6>[    7.245914] input: HDA Intel PCH HDMI/DP,pcm=3D8 as /devices/pci000=
0:00/0000:00:1f.3/sound/card0/input14
<6>[    7.245942] input: HDA Intel PCH HDMI/DP,pcm=3D9 as /devices/pci000=
0:00/0000:00:1f.3/sound/card0/input15
<6>[    7.245968] input: HDA Intel PCH HDMI/DP,pcm=3D10 as /devices/pci00=
00:00/0000:00:1f.3/sound/card0/input16
<6>[    7.271341] usb 1-5: New USB device found, idVendor=3D058f, idProdu=
ct=3D9540, bcdDevice=3D 1.20
<6>[    7.271342] usb 1-5: New USB device strings: Mfr=3D1, Product=3D2, =
SerialNumber=3D0
<6>[    7.271343] usb 1-5: Product: EMV Smartcard Reader
<6>[    7.271344] usb 1-5: Manufacturer: Generic
<6>[    7.373758] usb 2-4: new SuperSpeed Gen 1 USB device number 3 using=
 xhci_hcd
<6>[    7.386595] usb 2-4: New USB device found, idVendor=3D0781, idProdu=
ct=3D5580, bcdDevice=3D 0.10
<6>[    7.387291] usb 2-4: New USB device strings: Mfr=3D1, Product=3D2, =
SerialNumber=3D3
<6>[    7.387993] usb 2-4: Product: Extreme
<6>[    7.388689] usb 2-4: Manufacturer: SanDisk
<6>[    7.389341] usb 2-4: SerialNumber: AA010121131224373982
<6>[    7.392089] usb-storage 2-4:1.0: USB Mass Storage device detected
<6>[    7.394532] scsi host1: usb-storage 2-4:1.0
<6>[    7.441827] tsc: Refined TSC clocksource calibration: 2903.993 MHz
<6>[    7.442525] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: =
0x29dbff0d19e, max_idle_ns: 440795220662 ns
<6>[    7.443266] clocksource: Switched to clocksource tsc
<6>[    7.499758] usb 1-6: new high-speed USB device number 3 using xhci_=
hcd
<4>[    7.628373] usb 1-6: config 1 has an invalid interface number: 12 b=
ut max is 1
<4>[    7.630591] usb 1-6: config 1 has an invalid interface number: 13 b=
ut max is 1
<4>[    7.632670] usb 1-6: config 1 has an invalid interface number: 13 b=
ut max is 1
<4>[    7.634706] usb 1-6: config 1 has no interface number 0
<4>[    7.636750] usb 1-6: config 1 has no interface number 1
<6>[    7.639711] usb 1-6: New USB device found, idVendor=3D1199, idProdu=
ct=3D9079, bcdDevice=3D 0.06
<6>[    7.641749] usb 1-6: New USB device strings: Mfr=3D1, Product=3D2, =
SerialNumber=3D3
<6>[    7.643782] usb 1-6: Product: Sierra Wireless EM7455 Qualcomm Snapd=
ragon X7 LTE-A
<6>[    7.645791] usb 1-6: Manufacturer: Sierra Wireless, Incorporated
<6>[    7.647841] usb 1-6: SerialNumber: LF71027892011020
<6>[    7.665369] cdc_mbim 1-6:1.12: cdc-wdm0: USB WDM device
<6>[    7.667662] cdc_mbim 1-6:1.12 wwan0: register 'cdc_mbim' at usb-000=
0:00:14.0-6, CDC MBIM, 22:6a:58:52:3b:76
<6>[    7.783691] usb 1-7: new full-speed USB device number 4 using xhci_=
hcd
<6>[    7.790476] psmouse serio1: synaptics: queried max coordinates: x [=
=2E.5676], y [..4762]
<6>[    7.823748] psmouse serio1: synaptics: queried min coordinates: x [=
1266..], y [1094..]
<6>[    7.824409] psmouse serio1: synaptics: Trying to set up SMBus acces=
s
<6>[    7.830163] rmi4_smbus 6-002c: registering SMbus-connected sensor
<6>[    7.893601] rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: =
Synaptics, product: TM3145-005, fw id: 2491761
<6>[    7.911055] usb 1-7: New USB device found, idVendor=3D8087, idProdu=
ct=3D0a2b, bcdDevice=3D 0.10
<6>[    7.913556] usb 1-7: New USB device strings: Mfr=3D0, Product=3D0, =
SerialNumber=3D0
<6>[    7.963939] input: Synaptics TM3145-005 as /devices/rmi4-00/input/i=
nput17
<6>[    7.974040] serio: RMI4 PS/2 pass-through port at rmi4-00.fn03
<6>[    8.031885] usb 1-8: new high-speed USB device number 5 using xhci_=
hcd
<5>[    8.084061] scsi 0:0:0:0: Direct-Access     Generic- SD/MMC        =
   1.00 PQ: 0 ANSI: 6
<5>[    8.096584] sd 0:0:0:0: [sda] Attached SCSI removable disk
<6>[    8.213926] usb 1-8: New USB device found, idVendor=3D5986, idProdu=
ct=3D111c, bcdDevice=3D37.27
<6>[    8.216501] usb 1-8: New USB device strings: Mfr=3D3, Product=3D1, =
SerialNumber=3D2
<6>[    8.218889] usb 1-8: Product: Integrated Camera
<6>[    8.221282] usb 1-8: Manufacturer: Bison
<6>[    8.223651] usb 1-8: SerialNumber: 200901010001
<5>[    8.269997] random: vgscan: uninitialized urandom read (4 bytes rea=
d)
<6>[    8.311166] vgscan (149) used greatest stack depth: 14040 bytes lef=
t
<5>[    8.317988] random: vgchange: uninitialized urandom read (4 bytes r=
ead)
<6>[    8.349813] device-mapper: ioctl: 4.42.0-ioctl (2020-02-27) initial=
ised: dm-devel@redhat.com
<6>[    8.351714] modprobe (151) used greatest stack depth: 13920 bytes l=
eft
<6>[    8.356738] psmouse serio2: trackpoint: IBM TrackPoint firmware: 0x=
0e, buttons: 3/3
<6>[    8.382181] vgchange (150) used greatest stack depth: 13672 bytes l=
eft
<6>[    8.401620] input: TPPS/2 IBM TrackPoint as /devices/rmi4-00/rmi4-0=
0.fn03/serio2/input/input18
<5>[    8.403964] scsi 1:0:0:0: Direct-Access     SanDisk  Extreme       =
   0001 PQ: 0 ANSI: 6
<7>[    8.418449] ISO 9660 Extensions: Microsoft Joliet Level 3
<7>[    8.418603] ISO 9660 Extensions: RRIP_1991A
<7>[    8.423081] ISO 9660 Extensions: Microsoft Joliet Level 3
<7>[    8.423232] ISO 9660 Extensions: RRIP_1991A
<7>[    8.425792] ISO 9660 Extensions: Microsoft Joliet Level 3
<7>[    8.425940] ISO 9660 Extensions: RRIP_1991A
<7>[    8.430728] ISO 9660 Extensions: Microsoft Joliet Level 3
<7>[    8.430882] ISO 9660 Extensions: RRIP_1991A
<5>[    8.669582] sd 1:0:0:0: [sdb] 31277232 512-byte logical blocks: (16=
=2E0 GB/14.9 GiB)
<5>[    8.670981] sd 1:0:0:0: [sdb] Write Protect is off
<7>[    8.672095] sd 1:0:0:0: [sdb] Mode Sense: 53 00 00 08
<5>[    8.672286] sd 1:0:0:0: [sdb] Write cache: disabled, read cache: en=
abled, doesn't support DPO or FUA
<6>[    8.678863]  sdb: sdb1
<5>[    8.683135] sd 1:0:0:0: [sdb] Attached SCSI removable disk
<5>[    9.393442] random: crng init done
<6>[   12.783759] udevd (138) used greatest stack depth: 13608 bytes left=

<27>[   17.727388] systemd[1]: Failed to find module 'autofs4'
<30>[   17.740532] systemd[1]: systemd 243-2-gd7bf1e3 running in system m=
ode. (-PAM -AUDIT -SELINUX -IMA -APPARMOR -SMACK -SYSVINIT -UTMP -LIBCRYP=
TSETUP -GCRYPT -GNUTLS -ACL -XZ -LZ4 +SECCOMP +BLKID -ELFUTILS +KMOD -IDN=
2 -IDN -PCRE2 default-hierarchy=3Dunified)
<30>[   17.753821] systemd[1]: Detected architecture x86-64.
<30>[   17.754844] systemd[1]: Running with unpopulated /etc.
<30>[   17.760095] systemd[1]: No hostname configured.
<30>[   17.760992] systemd[1]: Set hostname to <localhost>.
<29>[   17.809711] systemd[1]: Failed to populate /etc with preset unit s=
ettings, ignoring: File exists
<28>[   17.818286] systemd[1]: /etc/systemd/system/systemd-udevd.service.=
d/sina-lsm-label.conf:2: Unknown key name 'LSMProcessLabel' in section 'S=
ervice', ignoring.
<28>[   17.821034] systemd[1]: /etc/systemd/system/debugshell.service:16:=
 Unknown key name 'LSMProcessLabel' in section 'Service', ignoring.
<28>[   17.822478] systemd[1]: /etc/systemd/system/syslog.service:16: Unk=
nown key name 'LSMProcessLabel' in section 'Service', ignoring.
<28>[   17.826786] systemd[1]: /etc/systemd/system/wpa-supplicant.service=
:16: Unknown key name 'LSMProcessLabel' in section 'Service', ignoring.
<6>[   17.847948] modprobe (187) used greatest stack depth: 13568 bytes l=
eft
<5>[   17.954793] cryptoapi_plugger: Loading of module with unavailable k=
ey is rejected
<6>[   18.169554] gzip (206) used greatest stack depth: 13352 bytes left
<6>[   18.232423] loadkeys (202) used greatest stack depth: 13312 bytes l=
eft
<5>[   20.901812] dm_crypt_sina: Loading of module with unavailable key i=
s rejected
<5>[   20.914654] vtx: Loading of module with unavailable key is rejected=

<5>[   21.039401] vboxdrv: Loading of module with unavailable key is reje=
cted
<5>[   21.042304] vboxdrv: Loading of module with unavailable key is reje=
cted
<6>[   23.115654] gpt-reserve (194) used greatest stack depth: 13200 byte=
s left
<4>[   23.767686] ext2 filesystem being mounted at /media/persistent supp=
orts timestamps until 2038 (0x7fffffff)
<6>[   24.055668] name-net-ns (446) used greatest stack depth: 13016 byte=
s left
<6>[   28.561963] floppy0: no floppy controllers found
<6>[   30.541498] ip (738) used greatest stack depth: 12040 bytes left
<6>[   30.576281] IPv6: ADDRCONF(NETDEV_CHANGE): veth2: link becomes read=
y
<6>[   30.576298] IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes read=
y
<6>[   30.585408] bri: port 1(veth1) entered blocking state
<6>[   30.585410] bri: port 1(veth1) entered disabled state
<6>[   30.585440] device veth1 entered promiscuous mode
<6>[   30.592340] bri: port 1(veth1) entered blocking state
<6>[   30.592342] bri: port 1(veth1) entered forwarding state
<3>[   31.514718] nvme nvme0: TH(2): No opts for device
<1>[   31.514777] BUG: kernel NULL pointer dereference, address: 00000000=
0000003c
<1>[   31.515356] #PF: supervisor read access in kernel mode
<1>[   31.515967] #PF: error_code(0x0000) - not-present page
<6>[   31.516594] PGD 0 P4D 0=20
<4>[   31.517223] Oops: 0000 [#1] SMP PTI
<4>[   31.517856] CPU: 1 PID: 779 Comm: udevdata-dump Not tainted 5.9.0-d=
evel+ #9
<4>[   31.518503] Hardware name: LENOVO 20HGS0TW00/20HGS0TW00, BIOS N1WET=
46S (1.25s ) 03/30/2018
<4>[   31.519162] RIP: 0010:nvme_ctrl_reconnect_delay_show+0x13/0x40
<4>[   31.519827] Code: 5b 4c 89 e7 5d 41 5c e9 6b d3 9f ff e8 16 37 cc f=
f eb d0 0f 1f 40 00 0f 1f 44 00 00 48 89 d0 48 8b 57 78 48 8b 92 40 0a 00=
 00 <8b> 52 3c 83 fa ff 74 12 48 89 c7 48 c7 c6 01 62 a3 b3 e8 e6 07 d2
<4>[   31.520521] RSP: 0018:ffffb6b3c3a7fe48 EFLAGS: 00010286
<4>[   31.521222] RAX: ffff9afa39b82000 RBX: ffffffffb3cdbd20 RCX: ffff9a=
fa427c9600
<4>[   31.521929] RDX: 0000000000000000 RSI: ffffffffb3cdbd20 RDI: ffff9a=
fa4388c2a8
<4>[   31.522596] RBP: ffffffffb36afb90 R08: ffff9afa4388c2a8 R09: ffff9a=
fa3ffeaf00
<4>[   31.523262] R10: ffff9afa39b82000 R11: 0000000000000000 R12: 000000=
00ffffffff
<4>[   31.523917] R13: ffffb6b3c3a7ff10 R14: 0000000000000001 R15: ffff9a=
fa3a5f41e0
<4>[   31.524580] FS:  00007f9fd28d8c00(0000) GS:ffff9afa47480000(0000) k=
nlGS:0000000000000000
<4>[   31.525253] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[   31.525931] CR2: 000000000000003c CR3: 0000000602da2003 CR4: 000000=
00003706e0
<4>[   31.526619] Call Trace:
<4>[   31.527303]  dev_attr_show+0x18/0x40
<4>[   31.528019]  sysfs_kf_seq_show+0xa2/0xf0
<4>[   31.528738]  seq_read+0x132/0x3e0
<4>[   31.529458]  vfs_read+0x9e/0x160
<4>[   31.530173]  ksys_read+0x59/0xd0
<4>[   31.530905]  do_syscall_64+0x33/0x40
<4>[   31.531632]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
<4>[   31.532399] RIP: 0033:0x7f9fd29cab91
<4>[   31.533149] Code: fe ff ff 50 48 8d 3d 6e 88 09 00 e8 c9 f1 01 00 6=
6 0f 1f 84 00 00 00 00 00 48 8d 05 69 2b 0d 00 8b 00 85 c0 75 13 31 c0 0f=
 05 <48> 3d 00 f0 ff ff 77 57 c3 66 0f 1f 44 00 00 41 54 49 89 d4 55 48
<4>[   31.533944] RSP: 002b:00007fffff272238 EFLAGS: 00000246 ORIG_RAX: 0=
000000000000000
<4>[   31.534750] RAX: ffffffffffffffda RBX: 000055ba592d5390 RCX: 00007f=
9fd29cab91
<4>[   31.535566] RDX: 0000000000001000 RSI: 000055ba592e5390 RDI: 000000=
0000000003
<4>[   31.536384] RBP: 00007f9fd2a952a0 R08: 0000000000000003 R09: 000000=
0000000077
<4>[   31.537203] R10: 000055ba59183010 R11: 0000000000000246 R12: 000000=
0000001001
<4>[   31.538014] R13: 000055ba592e5390 R14: 0000000000000d68 R15: 00007f=
9fd2a94760
<4>[   31.538820] Modules linked in: wacom dm_mod
<4>[   31.539624] CR2: 000000000000003c
<4>[   31.540420] ---[ end trace c23728d469f199ad ]---

No errors detected

--------------3FC3523ABCC1C9B271AFEAA8
Content-Type: text/x-log; charset="UTF-8"; name="panic-2.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="panic-2.log"

Oops#1 Part1
<6>[    0.000000] microcode: microcode updated early to revision 0xd6, da=
te =3D 2020-04-27
<5>[    0.000000] Linux version 5.9.0-devel+ (thilbrich@ts-6) (gcc (Debia=
n 8.3.0-6) 8.3.0, GNU ld (GNU Binutils for Debian) 2.31.1) #7 SMP Mon Aug=
 31 11:33:24 CEST 2020
<6>[    0.000000] Command line: BOOT_IMAGE=3D/isolinux/bzImage console=3D=
tty1 intel_iommu=3Don,igfx_off
<6>[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating =
point registers'
<6>[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers=
'
<6>[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers=
'
<6>[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds re=
gisters'
<6>[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
<6>[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
<6>[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
<6>[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
<6>[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is =
960 bytes, using 'compacted' format.
<6>[    0.000000] BIOS-provided physical RAM map:
<6>[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] =
usable
<6>[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] =
reserved
<6>[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009cfff] =
usable
<6>[    0.000000] BIOS-e820: [mem 0x000000000009d000-0x00000000000fffff] =
reserved
<6>[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000090b6cfff] =
usable
<6>[    0.000000] BIOS-e820: [mem 0x0000000090b6d000-0x0000000090b6dfff] =
ACPI NVS
<6>[    0.000000] BIOS-e820: [mem 0x0000000090b6e000-0x0000000090b6efff] =
reserved
<6>[    0.000000] BIOS-e820: [mem 0x0000000090b6f000-0x000000009a4abfff] =
usable
<6>[    0.000000] BIOS-e820: [mem 0x000000009a4ac000-0x000000009a573fff] =
type 20
<6>[    0.000000] BIOS-e820: [mem 0x000000009a574000-0x000000009b52bfff] =
reserved
<6>[    0.000000] BIOS-e820: [mem 0x000000009b52c000-0x000000009b54cfff] =
ACPI NVS
<6>[    0.000000] BIOS-e820: [mem 0x000000009b54d000-0x000000009b54dfff] =
reserved
<6>[    0.000000] BIOS-e820: [mem 0x000000009b54e000-0x000000009b599fff] =
ACPI NVS
<6>[    0.000000] BIOS-e820: [mem 0x000000009b59a000-0x000000009b5fefff] =
ACPI data
<6>[    0.000000] BIOS-e820: [mem 0x000000009b5ff000-0x000000009b5fffff] =
usable
<6>[    0.000000] BIOS-e820: [mem 0x000000009b600000-0x000000009f7fffff] =
reserved
<6>[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] =
reserved
<6>[    0.000000] BIOS-e820: [mem 0x00000000fe010000-0x00000000fe010fff] =
reserved
<6>[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000065f7fffff] =
usable
<6>[    0.000000] SMT: disabled
<6>[    0.000000] NX (Execute Disable) protection: active
<6>[    0.000000] user-defined physical RAM map:
<6>[    0.000000] user: [mem 0x0000000000000000-0x0000000000057fff] usabl=
e
<6>[    0.000000] user: [mem 0x0000000000058000-0x0000000000058fff] reser=
ved
<6>[    0.000000] user: [mem 0x0000000000059000-0x000000000009cfff] usabl=
e
<6>[    0.000000] user: [mem 0x000000000009d000-0x00000000000fffff] reser=
ved
<6>[    0.000000] user: [mem 0x0000000000100000-0x000000003fffffff] usabl=
e
<6>[    0.000000] user: [mem 0x0000000040000000-0x0000000041ffffff] reser=
ved
<6>[    0.000000] user: [mem 0x0000000042000000-0x0000000090b6cfff] usabl=
e
<6>[    0.000000] user: [mem 0x0000000090b6d000-0x0000000090b6dfff] ACPI =
NVS
<6>[    0.000000] user: [mem 0x0000000090b6e000-0x0000000090b6efff] reser=
ved
<6>[    0.000000] user: [mem 0x0000000090b6f000-0x000000009a4abfff] usabl=
e
<6>[    0.000000] user: [mem 0x000000009a4ac000-0x000000009a573fff] type =
20
<6>[    0.000000] user: [mem 0x000000009a574000-0x000000009b52bfff] reser=
ved
<6>[    0.000000] user: [mem 0x000000009b52c000-0x000000009b54cfff] ACPI =
NVS
<6>[    0.000000] user: [mem 0x000000009b54d000-0x000000009b54dfff] reser=
ved
<6>[    0.000000] user: [mem 0x000000009b54e000-0x000000009b599fff] ACPI =
NVS
<6>[    0.000000] user: [mem 0x000000009b59a000-0x000000009b5fefff] ACPI =
data
<6>[    0.000000] user: [mem 0x000000009b5ff000-0x000000009b5fffff] usabl=
e
<6>[    0.000000] user: [mem 0x000000009b600000-0x000000009f7fffff] reser=
ved
<6>[    0.000000] user: [mem 0x00000000f8000000-0x00000000fbffffff] reser=
ved
<6>[    0.000000] user: [mem 0x00000000fe010000-0x00000000fe010fff] reser=
ved
<6>[    0.000000] user: [mem 0x0000000100000000-0x000000065f7fffff] usabl=
e
<6>[    0.000000] efi: EFI v2.50 by Lenovo
<6>[    0.000000] efi: TPMFinalLog=3D0x9b592000 SMBIOS=3D0x9a6d8000 SMBIO=
S 3.0=3D0x9a6d5000 ACPI=3D0x9b5fe000 ACPI 2.0=3D0x9b5fe014 ESRT=3D0x9a5a2=
000 MEMATTR=3D0x953ed018=20
<6>[    0.000000] SMBIOS 3.0.0 present.
<6>[    0.000000] DMI: LENOVO 20HGS0TW00/20HGS0TW00, BIOS N1WET46S (1.25s=
 ) 03/30/2018
<6>[    0.000000] tsc: Detected 2900.000 MHz processor
<6>[    0.001127] tsc: Detected 2899.886 MHz TSC
<7>[    0.001127] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D>=
 reserved
<7>[    0.001131] e820: remove [mem 0x000a0000-0x000fffff] usable
<6>[    0.001143] last_pfn =3D 0x65f800 max_arch_pfn =3D 0x400000000
<7>[    0.001150] MTRR default type: write-back
<7>[    0.001152] MTRR fixed ranges enabled:
<7>[    0.001154]   00000-9FFFF write-back
<7>[    0.001155]   A0000-BFFFF uncachable
<7>[    0.001157]   C0000-FFFFF write-protect
<7>[    0.001158] MTRR variable ranges enabled:
<7>[    0.001161]   0 base 00C0000000 mask 7FC0000000 uncachable
<7>[    0.001162]   1 base 00A0000000 mask 7FE0000000 uncachable
<7>[    0.001164]   2 base 009E000000 mask 7FFE000000 uncachable
<7>[    0.001165]   3 base 009D000000 mask 7FFF000000 uncachable
<7>[    0.001166]   4 disabled
<7>[    0.001167]   5 disabled
<7>[    0.001168]   6 disabled
<7>[    0.001169]   7 disabled
<7>[    0.001170]   8 disabled
<7>[    0.001170]   9 disabled
<6>[    0.002051] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  U=
C- WT =20
<6>[    0.003157] last_pfn =3D 0x9b600 max_arch_pfn =3D 0x400000000
<6>[    0.025233] esrt: Reserving ESRT space from 0x000000009a5a2000 to 0=
x000000009a5a2088.
<6>[    0.025250] check: Scanning 1 areas for low memory corruption
<6>[    0.025259] Using GB pages for direct mapping
<6>[    0.026106] Secure boot could not be determined
<6>[    0.026109] RAMDISK: [mem 0x34215000-0x36101fff]
<6>[    0.026124] ACPI: Early table checksum verification disabled
<6>[    0.026128] ACPI: RSDP 0x000000009B5FE014 000024 (v02 LENOVO)
<6>[    0.026134] ACPI: XSDT 0x000000009B5C2188 000104 (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026143] ACPI: FACP 0x000000009B5F5000 0000F4 (v05 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026151] ACPI: DSDT 0x000000009B5D0000 020CF2 (v02 LENOVO SKL   =
   00000000 INTL 20160527)
<6>[    0.026156] ACPI: FACS 0x000000009B53C000 000040
<6>[    0.026161] ACPI: SSDT 0x000000009B5FC000 0003CC (v02 LENOVO Tpm2Ta=
bl 00001000 INTL 20160527)
<6>[    0.026165] ACPI: TPM2 0x000000009B5FB000 000034 (v03 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026170] ACPI: UEFI 0x000000009B553000 000042 (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026175] ACPI: SSDT 0x000000009B5F7000 003246 (v02 LENOVO SaSsdt=
   00003000 INTL 20160527)
<6>[    0.026179] ACPI: SSDT 0x000000009B5F6000 0005B6 (v02 LENOVO PerfTu=
ne 00001000 INTL 20160527)
<6>[    0.026184] ACPI: HPET 0x000000009B5F4000 000038 (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026189] ACPI: APIC 0x000000009B5F3000 0000BC (v03 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026193] ACPI: MCFG 0x000000009B5F2000 00003C (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026197] ACPI: ECDT 0x000000009B5F1000 000053 (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026202] ACPI: SSDT 0x000000009B5CE000 0016F3 (v02 LENOVO ProjSs=
dt 00000010 INTL 20160527)
<6>[    0.026207] ACPI: BOOT 0x000000009B5CD000 000028 (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026211] ACPI: BATB 0x000000009B5CC000 00004A (v02 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026216] ACPI: SLIC 0x000000009B5CB000 000176 (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026220] ACPI: SSDT 0x000000009B5C9000 0017AE (v02 LENOVO CpuSsd=
t  00003000 INTL 20160527)
<6>[    0.026225] ACPI: SSDT 0x000000009B5C8000 00056D (v02 LENOVO CtdpB =
   00001000 INTL 20160527)
<6>[    0.026230] ACPI: SSDT 0x000000009B5C7000 000634 (v02 LENOVO UsbCTa=
bl 00001000 INTL 20160527)
<6>[    0.026234] ACPI: WSMT 0x000000009B5C6000 000028 (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026239] ACPI: SSDT 0x000000009B5C5000 000141 (v02 LENOVO HdaDsp=
   00000000 INTL 20160527)
<6>[    0.026243] ACPI: SSDT 0x000000009B5C4000 0004C5 (v02 LENOVO TbtTyp=
eC 00000000 INTL 20160527)
<6>[    0.026248] ACPI: DBGP 0x000000009B5C3000 000034 (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026252] ACPI: DBG2 0x000000009B5FD000 000054 (v00 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026257] ACPI: MSDM 0x000000009B5C1000 000055 (v03 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026261] ACPI: DMAR 0x000000009B5C0000 0000A8 (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026266] ACPI: ASF! 0x000000009B5BF000 0000A0 (v32 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026271] ACPI: FPDT 0x000000009B5BE000 000044 (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026275] ACPI: BGRT 0x000000009B5BD000 000038 (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<6>[    0.026279] ACPI: UEFI 0x000000009B539000 00013E (v01 LENOVO TP-N1W=
   00001250 PTEC 00000002)
<7>[    0.026291] ACPI: Local APIC address 0xfee00000
<6>[    0.026554] No NUMA configuration found
<6>[    0.026556] Faking a node at [mem 0x0000000000000000-0x000000065f7f=
ffff]
<6>[    0.026562] NODE_DATA(0) allocated [mem 0x65f7fc000-0x65f7fffff]
<6>[    0.026605] Zone ranges:
<6>[    0.026607]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
<6>[    0.026609]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
<6>[    0.026612]   Normal   [mem 0x0000000100000000-0x000000065f7fffff]
<6>[    0.026614] Movable zone start for each node
<6>[    0.026615] Early memory node ranges
<6>[    0.026617]   node   0: [mem 0x0000000000001000-0x0000000000057fff]=

<6>[    0.026619]   node   0: [mem 0x0000000000059000-0x000000000009cfff]=

<6>[    0.026621]   node   0: [mem 0x0000000000100000-0x000000003fffffff]=

<6>[    0.026622]   node   0: [mem 0x0000000042000000-0x0000000090b6cfff]=

<6>[    0.026624]   node   0: [mem 0x0000000090b6f000-0x000000009a4abfff]=

<6>[    0.026626]   node   0: [mem 0x000000009b5ff000-0x000000009b5fffff]=

<6>[    0.026627]   node   0: [mem 0x0000000100000000-0x000000065f7fffff]=

<6>[    0.027215] Zeroed struct page in unavailable ranges: 33722 pages
<6>[    0.027217] Initmem setup node 0 [mem 0x0000000000001000-0x00000006=
5f7fffff]
<7>[    0.027220] On node 0 totalpages: 6257734
<7>[    0.027222]   DMA zone: 64 pages used for memmap
<7>[    0.027223]   DMA zone: 22 pages reserved
<7>[    0.027225]   DMA zone: 3995 pages, LIFO batch:0
<7>[    0.027280]   DMA32 zone: 9683 pages used for memmap
<7>[    0.027281]   DMA32 zone: 619691 pages, LIFO batch:63
<7>[    0.033374]   Normal zone: 88032 pages used for memmap
<7>[    0.033375]   Normal zone: 5634048 pages, LIFO batch:63
<6>[    0.088946] Reserving Intel graphics memory at [mem 0x9d800000-0x9f=
7fffff]
<6>[    0.089358] ACPI: PM-Timer IO Port: 0x1808
<7>[    0.089361] ACPI: Local APIC address 0xfee00000
<6>[    0.089370] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
<6>[    0.089372] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
<6>[    0.089373] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
<6>[    0.089375] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
<6>[    0.089376] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
<6>[    0.089378] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
<6>[    0.089379] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
<6>[    0.089380] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
<6>[    0.089413] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, G=
SI 0-119
<6>[    0.089417] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl=
)
<6>[    0.089419] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high le=
vel)
<7>[    0.089422] ACPI: IRQ0 used by override.
<7>[    0.089424] ACPI: IRQ9 used by override.
<6>[    0.089427] Using ACPI (MADT) for SMP configuration information
<6>[    0.089429] ACPI: HPET id: 0x8086a201 base: 0xfed00000
<7>[    0.089439] e820: update [mem 0x94dcc000-0x94f0bfff] usable =3D=3D>=
 reserved
<6>[    0.089453] TSC deadline timer available
<6>[    0.089455] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
<6>[    0.089487] [mem 0x9f800000-0xf7ffffff] available for PCI devices
<6>[    0.089492] clocksource: refined-jiffies: mask: 0xffffffff max_cycl=
es: 0xffffffff, max_idle_ns: 1910969940391419 ns
<6>[    0.101035] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:4 =
nr_node_ids:1
<6>[    0.101302] percpu: Embedded 53 pages/cpu s176728 r8192 d32168 u524=
288
<7>[    0.101312] pcpu-alloc: s176728 r8192 d32168 u524288 alloc=3D1*2097=
152
<7>[    0.101313] pcpu-alloc: [0] 0 1 2 3=20
<6>[    0.101344] Built 1 zonelists, mobility grouping on.  Total pages: =
6159933
<6>[    0.101345] Policy zone: Normal
<5>[    0.101348] Kernel command line: memmap=3D0x2000000$0x40000000 ramo=
ops.mem_address=3D0x40000000 ramoops.mem_size=3D0x2000000 ramoops.ecc=3D1=
 ramoops.record_size=3D0x200000 ramoops.console_size=3D0 ramoops.ftrace_s=
ize=3D0 ramoops.pmsg_size=3D0 mem_sleep_default=3Ddeep l1tf=3Dfull mds=3D=
full nosmt BOOT_IMAGE=3D/isolinux/bzImage console=3Dtty1 intel_iommu=3Don=
,igfx_off
<6>[    0.101626] DMAR: IOMMU enabled
<6>[    0.101628] DMAR: Disable GFX device mapping
<6>[    0.104708] Dentry cache hash table entries: 4194304 (order: 13, 33=
554432 bytes, linear)
<6>[    0.106248] Inode-cache hash table entries: 2097152 (order: 12, 167=
77216 bytes, linear)
<6>[    0.106321] mem auto-init: stack:off, heap alloc:off, heap free:off=

<6>[    0.195145] Memory: 24382024K/25030936K available (16387K kernel co=
de, 1782K rwdata, 5580K rodata, 1556K init, 4176K bss, 648652K reserved, =
0K cma-reserved)
<6>[    0.195218] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D=
4, Nodes=3D1
<6>[    0.195226] Kernel/User page tables isolation: enabled
<6>[    0.195253] ftrace: allocating 47289 entries in 185 pages
<6>[    0.231332] ftrace: allocated 185 pages with 5 groups
<6>[    0.231445] rcu: Hierarchical RCU implementation.
<6>[    0.231446] rcu: 	RCU event tracing is enabled.
<6>[    0.231448] rcu: 	RCU restricting CPUs from NR_CPUS=3D8 to nr_cpu_i=
ds=3D4.
<6>[    0.231450] 	Rude variant of Tasks RCU enabled.
<6>[    0.231452] rcu: RCU calculated value of scheduler-enlistment delay=
 is 100 jiffies.
<6>[    0.231454] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cp=
u_ids=3D4
<6>[    0.237088] NR_IRQS: 4352, nr_irqs: 1024, preallocated irqs: 16
<5>[    0.238026] random: get_random_bytes called from start_kernel+0x369=
/0x52c with crng_init=3D0
<6>[    0.238062] Console: colour dummy device 80x25
<6>[    0.238479] printk: console [tty1] enabled
<6>[    0.238503] ACPI: Core revision 20200717
<6>[    0.239007] clocksource: hpet: mask: 0xffffffff max_cycles: 0xfffff=
fff, max_idle_ns: 79635855245 ns
<6>[    0.239101] APIC: Switch to symmetric I/O mode setup
<6>[    0.243292] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pi=
n2=3D-1
<6>[    0.248079] clocksource: tsc-early: mask: 0xffffffffffffffff max_cy=
cles: 0x29ccd767b87, max_idle_ns: 440795223720 ns
<6>[    0.248091] Calibrating delay loop (skipped), value calculated usin=
g timer frequency.. 5799.77 BogoMIPS (lpj=3D2899886)
<6>[    0.248098] pid_max: default: 32768 minimum: 301
<6>[    0.253112] LSM: Security Framework initializing
<6>[    0.253205] Mount-cache hash table entries: 65536 (order: 7, 524288=
 bytes, linear)
<6>[    0.253286] Mountpoint-cache hash table entries: 65536 (order: 7, 5=
24288 bytes, linear)
<6>[    0.253692] mce: CPU0: Thermal monitoring enabled (TM1)
<6>[    0.253730] process: using mwait in idle threads
<6>[    0.253736] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
<6>[    0.253740] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
<6>[    0.253747] Spectre V1 : Mitigation: usercopy/swapgs barriers and _=
_user pointer sanitization
<6>[    0.253754] Spectre V2 : Mitigation: Full generic retpoline
<6>[    0.253758] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Fillin=
g RSB on context switch
<6>[    0.253762] Spectre V2 : Enabling Restricted Speculation for firmwa=
re calls
<6>[    0.253770] Spectre V2 : mitigation: Enabling conditional Indirect =
Branch Prediction Barrier
<6>[    0.253775] Spectre V2 : User space: Mitigation: STIBP via seccomp =
and prctl
<6>[    0.253781] Speculative Store Bypass: Mitigation: Speculative Store=
 Bypass disabled via prctl and seccomp
<6>[    0.253786] SMT: disabled
<6>[    0.253797] SRBDS: Mitigation: Microcode
<6>[    0.253800] MDS: Mitigation: Clear CPU buffers
<6>[    0.254442] Freeing SMP alternatives memory: 40K
<6>[    0.255203] smpboot: CPU0: Intel(R) Core(TM) i7-7500U CPU @ 2.70GHz=
 (family: 0x6, model: 0x8e, stepping: 0x9)
<6>[    0.255339] Performance Events: PEBS fmt3+, Skylake events, 32-deep=
 LBR, full-width counters, Intel PMU driver.
<6>[    0.255358] ... version:                4
<6>[    0.255361] ... bit width:              48
<6>[    0.255364] ... generic registers:      4
<6>[    0.255367] ... value mask:             0000ffffffffffff
<6>[    0.255370] ... max period:             00007fffffffffff
<6>[    0.255373] ... fixed-purpose events:   3
<6>[    0.255376] ... event mask:             000000070000000f
<6>[    0.255450] rcu: Hierarchical SRCU implementation.
<6>[    0.256087] NMI watchdog: Enabled. Permanently consumes one hw-PMU =
counter.
<6>[    0.256167] smp: Bringing up secondary CPUs ...
<6>[    0.256289] x86: Booting SMP configuration:
<6>[    0.256294] .... node  #0, CPUs:      #1 #2 #3
<6>[    0.266824] smp: Brought up 1 node, 2 CPUs
<6>[    0.266846] smpboot: Max logical packages: 2
<6>[    0.266850] smpboot: Total of 2 processors activated (11599.54 Bogo=
MIPS)
<6>[    0.267588] devtmpfs: initialized
<6>[    0.267588] PM: Registering ACPI NVS region [mem 0x90b6d000-0x90b6d=
fff] (4096 bytes)
<6>[    0.267588] PM: Registering ACPI NVS region [mem 0x9b52c000-0x9b54c=
fff] (135168 bytes)
<6>[    0.267588] PM: Registering ACPI NVS region [mem 0x9b54e000-0x9b599=
fff] (311296 bytes)
<6>[    0.268107] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xff=
ffffff, max_idle_ns: 1911260446275000 ns
<6>[    0.268107] futex hash table entries: 1024 (order: 4, 65536 bytes, =
linear)
<6>[    0.268258] pinctrl core: initialized pinctrl subsystem
<6>[    0.268411] PM: RTC time: 09:42:55, date: 2020-08-31
<6>[    0.268554] NET: Registered protocol family 16
<6>[    0.269105] ramoops: using module parameters
<6>[    0.269218] ramoops: uncorrectable error in header
<6>[    0.269288] ramoops: uncorrectable error in header
<6>[    0.269350] ramoops: uncorrectable error in header
<6>[    0.269414] ramoops: uncorrectable error in header
<6>[    0.269502] ramoops: uncorrectable error in header
<6>[    0.269567] ramoops: uncorrectable error in header
<6>[    0.269623] ramoops: uncorrectable error in header
<6>[    0.269686] ramoops: uncorrectable error in header
<6>[    0.269750] ramoops: uncorrectable error in header
<6>[    0.269813] ramoops: uncorrectable error in header
<6>[    0.269873] ramoops: uncorrectable error in header
<6>[    0.269946] ramoops: uncorrectable error in header
<6>[    0.270005] ramoops: uncorrectable error in header
<6>[    0.270063] ramoops: uncorrectable error in header
<6>[    0.270121] ramoops: uncorrectable error in header
<6>[    0.270182] ramoops: uncorrectable error in header
<6>[    0.270426] pstore: Registered ramoops as persistent store backend
<6>[    0.270430] ramoops: using 0x2000000@0x40000000, ecc: 16
<6>[    0.270556] thermal_sys: Registered thermal governor 'step_wise'
<6>[    0.270558] thermal_sys: Registered thermal governor 'user_space'
<6>[    0.270576] cpuidle: using governor menu
<6>[    0.270724] Simple Boot Flag at 0x47 set to 0x1
<6>[    0.270724] ACPI FADT declares the system doesn't support PCIe ASPM=
, so disable it
<6>[    0.270724] ACPI: bus type PCI registered
<6>[    0.270724] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0=
=2E5
<6>[    0.270724] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf80=
00000-0xfbffffff] (base 0xf8000000)
<6>[    0.270724] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved i=
n E820
<6>[    0.270724] PCI: Using configuration type 1 for base access
<4>[    0.271418] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
<6>[    0.275493] cryptomgr_test (36) used greatest stack depth: 15728 by=
tes left
<6>[    0.276098] cryptomgr_test (48) used greatest stack depth: 15368 by=
tes left
<6>[    0.276178] ACPI: Added _OSI(Module Device)
<6>[    0.276183] ACPI: Added _OSI(Processor Device)
<6>[    0.276187] ACPI: Added _OSI(3.0 _SCP Extensions)
<6>[    0.276190] ACPI: Added _OSI(Processor Aggregator Device)
<6>[    0.276194] ACPI: Added _OSI(Linux-Dell-Video)
<6>[    0.276198] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
<6>[    0.276202] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
<6>[    0.354815] ACPI: 10 ACPI AML tables successfully acquired and load=
ed
<6>[    0.357111] ACPI: EC: EC started
<6>[    0.357115] ACPI: EC: interrupt blocked
<6>[    0.360769] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
<6>[    0.360773] ACPI: EC: Boot ECDT EC used to handle transactions
<5>[    0.363680] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
<6>[    0.376476] ACPI: Dynamic OEM Table Load:
<6>[    0.376502] ACPI: SSDT 0xFFFF9C3BC3925800 0006F6 (v02 PmRef  Cpu0Is=
t  00003000 INTL 20160527)
<6>[    0.379081] ACPI: \_PR_.PR00: _OSC native thermal LVT Acked
<6>[    0.380813] ACPI: Dynamic OEM Table Load:
<6>[    0.380830] ACPI: SSDT 0xFFFF9C3BC396B800 0003FF (v02 PmRef  Cpu0Cs=
t  00003001 INTL 20160527)
<6>[    0.383362] ACPI: Dynamic OEM Table Load:
<6>[    0.383377] ACPI: SSDT 0xFFFF9C3BC3460600 0000BA (v02 PmRef  Cpu0Hw=
p  00003000 INTL 20160527)
<6>[    0.385745] ACPI: Dynamic OEM Table Load:
<6>[    0.385759] ACPI: SSDT 0xFFFF9C3BC3926000 000628 (v02 PmRef  HwpLvt=
   00003000 INTL 20160527)
<6>[    0.388738] ACPI: Dynamic OEM Table Load:
<6>[    0.388759] ACPI: SSDT 0xFFFF9C3BC34A8000 000D14 (v02 PmRef  ApIst =
   00003000 INTL 20160527)
<6>[    0.392215] ACPI: Dynamic OEM Table Load:
<6>[    0.392230] ACPI: SSDT 0xFFFF9C3BC396BC00 000317 (v02 PmRef  ApHwp =
   00003000 INTL 20160527)
<6>[    0.394818] ACPI: Dynamic OEM Table Load:
<6>[    0.394832] ACPI: SSDT 0xFFFF9C3BC34B0000 00030A (v02 PmRef  ApCst =
   00003000 INTL 20160527)
<6>[    0.399315] ACPI: Interpreter enabled
<6>[    0.399389] ACPI: (supports S0 S3 S5)
<6>[    0.399393] ACPI: Using IOAPIC for interrupt routing
<6>[    0.399460] PCI: Using host bridge windows from ACPI; if necessary,=
 use "pci=3Dnocrs" and report a bug
<6>[    0.400528] ACPI: Enabled 7 GPEs in block 00 to 7F
<6>[    0.406334] ACPI: Power Resource [PUBS] (on)
<6>[    0.425058] ACPI: Power Resource [WRST] (on)
<6>[    0.426737] ACPI: Power Resource [WRST] (on)
<6>[    0.446374] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
<6>[    0.446387] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM=
 ClockPM Segments MSI HPX-Type3]
<6>[    0.446600] acpi PNP0A08:00: _OSC: platform does not support [PCIeH=
otplug SHPCHotplug PME PCIeCapability]
<6>[    0.446700] acpi PNP0A08:00: _OSC: not requesting control; platform=
 does not support [PCIeCapability]
<6>[    0.446707] acpi PNP0A08:00: _OSC: OS requested [PCIeHotplug SHPCHo=
tplug PME PCIeCapability LTR]
<6>[    0.446712] acpi PNP0A08:00: _OSC: platform willing to grant [LTR]
<6>[    0.446716] acpi PNP0A08:00: _OSC failed (AE_SUPPORT); disabling AS=
PM
<6>[    0.448758] PCI host bridge to bus 0000:00
<6>[    0.448766] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 w=
indow]
<6>[    0.448770] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff w=
indow]
<6>[    0.448774] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x00=
0bffff window]
<6>[    0.448779] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x00=
0c3fff window]
<6>[    0.448783] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x00=
0c7fff window]
<6>[    0.448787] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x00=
0cbfff window]
<6>[    0.448792] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x00=
0cffff window]
<6>[    0.448796] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x00=
0d3fff window]
<6>[    0.448800] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x00=
0d7fff window]
<6>[    0.448804] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x00=
0dbfff window]
<6>[    0.448808] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x00=
0dffff window]
<6>[    0.448813] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x00=
0e3fff window]
<6>[    0.448817] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x00=
0e7fff window]
<6>[    0.448821] pci_bus 0000:00: root bus resource [mem 0x000e8000-0x00=
0ebfff window]
<6>[    0.448826] pci_bus 0000:00: root bus resource [mem 0x000ec000-0x00=
0effff window]
<6>[    0.448830] pci_bus 0000:00: root bus resource [mem 0x000f0000-0x00=
0fffff window]
<6>[    0.448834] pci_bus 0000:00: root bus resource [mem 0x9f800000-0xf7=
ffffff window]
<6>[    0.448839] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe=
7fffff window]
<6>[    0.448844] pci_bus 0000:00: root bus resource [bus 00-3e]
<6>[    0.448870] pci 0000:00:00.0: [8086:5904] type 00 class 0x060000
<6>[    0.450225] pci 0000:00:02.0: [8086:5916] type 00 class 0x030000
<6>[    0.450245] pci 0000:00:02.0: reg 0x10: [mem 0xeb000000-0xebffffff =
64bit]
<6>[    0.450259] pci 0000:00:02.0: reg 0x18: [mem 0xa0000000-0xafffffff =
64bit pref]
<6>[    0.450269] pci 0000:00:02.0: reg 0x20: [io  0xe000-0xe03f]
<6>[    0.450300] pci 0000:00:02.0: BAR 2: assigned to efifb
<6>[    0.451735] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330
<6>[    0.451762] pci 0000:00:14.0: reg 0x10: [mem 0xec220000-0xec22ffff =
64bit]
<6>[    0.451857] pci 0000:00:14.0: PME# supported from D3hot D3cold
<6>[    0.453369] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000
<6>[    0.453401] pci 0000:00:14.2: reg 0x10: [mem 0xec248000-0xec248fff =
64bit]
<6>[    0.454816] pci 0000:00:16.0: [8086:9d3a] type 00 class 0x078000
<6>[    0.454849] pci 0000:00:16.0: reg 0x10: [mem 0xec249000-0xec249fff =
64bit]
<6>[    0.454947] pci 0000:00:16.0: PME# supported from D3hot
<6>[    0.456402] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400
<6>[    0.456521] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
<6>[    0.456547] pci 0000:00:1c.0: Intel SPT PCH root port ACS workaroun=
d enabled
<6>[    0.457978] pci 0000:00:1c.2: [8086:9d12] type 01 class 0x060400
<6>[    0.458106] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
<6>[    0.458134] pci 0000:00:1c.2: Intel SPT PCH root port ACS workaroun=
d enabled
<6>[    0.459583] pci 0000:00:1d.0: [8086:9d18] type 01 class 0x060400
<6>[    0.459704] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
<6>[    0.459730] pci 0000:00:1d.0: Intel SPT PCH root port ACS workaroun=
d enabled
<6>[    0.461190] pci 0000:00:1f.0: [8086:9d58] type 00 class 0x060100
<6>[    0.462731] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000
<6>[    0.462754] pci 0000:00:1f.2: reg 0x10: [mem 0xec244000-0xec247fff]=

<6>[    0.464219] pci 0000:00:1f.3: [8086:9d71] type 00 class 0x040300
<6>[    0.464255] pci 0000:00:1f.3: reg 0x10: [mem 0xec240000-0xec243fff =
64bit]
<6>[    0.464301] pci 0000:00:1f.3: reg 0x20: [mem 0xec230000-0xec23ffff =
64bit]
<6>[    0.464376] pci 0000:00:1f.3: PME# supported from D3hot D3cold
<6>[    0.465820] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500
<6>[    0.465878] pci 0000:00:1f.4: reg 0x10: [mem 0xec24a000-0xec24a0ff =
64bit]
<6>[    0.465934] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
<6>[    0.467415] pci 0000:00:1f.6: [8086:15d8] type 00 class 0x020000
<6>[    0.467445] pci 0000:00:1f.6: reg 0x10: [mem 0xec200000-0xec21ffff]=

<6>[    0.467581] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
<6>[    0.469060] pci 0000:00:1c.0: PCI bridge to [bus 01-39]
<6>[    0.469072] pci 0000:00:1c.0:   bridge window [mem 0xd4000000-0xea0=
fffff]
<6>[    0.469083] pci 0000:00:1c.0:   bridge window [mem 0xb0000000-0xd1f=
fffff 64bit pref]
<6>[    0.469591] pci 0000:3a:00.0: [8086:24fd] type 00 class 0x028000
<6>[    0.469681] pci 0000:3a:00.0: reg 0x10: [mem 0xec100000-0xec101fff =
64bit]
<6>[    0.470243] pci 0000:3a:00.0: PME# supported from D0 D3hot D3cold
<6>[    0.471052] pci 0000:00:1c.2: PCI bridge to [bus 3a]
<6>[    0.471063] pci 0000:00:1c.2:   bridge window [mem 0xec100000-0xec1=
fffff]
<6>[    0.471380] pci 0000:3c:00.0: [144d:a804] type 00 class 0x010802
<6>[    0.471408] pci 0000:3c:00.0: reg 0x10: [mem 0xec000000-0xec003fff =
64bit]
<6>[    0.471907] pci 0000:00:1d.0: PCI bridge to [bus 3c]
<6>[    0.471915] pci 0000:00:1d.0:   bridge window [mem 0xec000000-0xec0=
fffff]
<6>[    0.474781] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12=
 14 15)
<6>[    0.474875] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12=
 14 15)
<6>[    0.474964] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12=
 14 15)
<6>[    0.475051] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12=
 14 15)
<6>[    0.475136] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 12=
 14 15)
<6>[    0.475222] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11 12=
 14 15)
<6>[    0.475308] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12=
 14 15)
<6>[    0.475395] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11 12=
 14 15)
<6>[    0.476251] ACPI: EC: interrupt unblocked
<6>[    0.476256] ACPI: EC: event unblocked
<6>[    0.476275] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
<6>[    0.476278] ACPI: EC: GPE=3D0x16
<6>[    0.476283] ACPI: \_SB_.PCI0.LPCB.EC__: Boot ECDT EC initialization=
 complete
<6>[    0.476287] ACPI: \_SB_.PCI0.LPCB.EC__: EC: Used to handle transact=
ions and events
<6>[    0.476394] iommu: Default domain type: Translated=20
<5>[    0.476510] SCSI subsystem initialized
<7>[    0.476569] libata version 3.00 loaded.
<6>[    0.476594] ACPI: bus type USB registered
<6>[    0.476618] usbcore: registered new interface driver usbfs
<6>[    0.476629] usbcore: registered new interface driver hub
<6>[    0.476658] usbcore: registered new device driver usb
<6>[    0.476689] pps_core: LinuxPPS API ver. 1 registered
<6>[    0.476692] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rod=
olfo Giometti <giometti@linux.it>
<6>[    0.476699] PTP clock support registered
<6>[    0.476751] Registered efivars operations
<6>[    0.476787] Advanced Linux Sound Architecture Driver Initialized.
<6>[    0.476982] PCI: Using ACPI for IRQ routing
<7>[    0.479803] PCI: pci_cache_line_size set to 64 bytes
<7>[    0.480851] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
<7>[    0.480853] e820: reserve RAM buffer [mem 0x0009d000-0x0009ffff]
<7>[    0.480854] e820: reserve RAM buffer [mem 0x90b6d000-0x93ffffff]
<7>[    0.480856] e820: reserve RAM buffer [mem 0x94dcc000-0x97ffffff]
<7>[    0.480857] e820: reserve RAM buffer [mem 0x9a4ac000-0x9bffffff]
<7>[    0.480860] e820: reserve RAM buffer [mem 0x9b600000-0x9bffffff]
<7>[    0.480861] e820: reserve RAM buffer [mem 0x65f800000-0x65fffffff]
<4>[    0.481221] acpi PNP0C14:02: duplicate WMI GUID 05901221-D566-11D1-=
B2F0-00A0C9062910 (first instance was on PNP0C14:01)
<4>[    0.481335] acpi PNP0C14:03: duplicate WMI GUID 05901221-D566-11D1-=
B2F0-00A0C9062910 (first instance was on PNP0C14:01)
<6>[    0.482500] clocksource: Switched to clocksource tsc-early
<6>[    0.503931] pnp: PnP ACPI init
<6>[    0.504188] system 00:00: [mem 0xfd000000-0xfdabffff] has been rese=
rved
<6>[    0.504194] system 00:00: [mem 0xfdad0000-0xfdadffff] has been rese=
rved
<6>[    0.504198] system 00:00: [mem 0xfdb00000-0xfdffffff] has been rese=
rved
<6>[    0.504204] system 00:00: [mem 0xfe000000-0xfe01ffff] could not be =
reserved
<6>[    0.504209] system 00:00: [mem 0xfe036000-0xfe03bfff] has been rese=
rved
<6>[    0.504213] system 00:00: [mem 0xfe03d000-0xfe3fffff] has been rese=
rved
<6>[    0.504217] system 00:00: [mem 0xfe410000-0xfe7fffff] has been rese=
rved
<7>[    0.504227] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (a=
ctive)
<6>[    0.504737] system 00:01: [io  0xff00-0xfffe] has been reserved
<7>[    0.504746] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (a=
ctive)
<6>[    0.505576] system 00:02: [io  0x0680-0x069f] has been reserved
<6>[    0.505582] system 00:02: [io  0xffff] has been reserved
<6>[    0.505586] system 00:02: [io  0xffff] has been reserved
<6>[    0.505589] system 00:02: [io  0xffff] has been reserved
<6>[    0.505593] system 00:02: [io  0x1800-0x18fe] has been reserved
<6>[    0.505597] system 00:02: [io  0x164e-0x164f] has been reserved
<7>[    0.505605] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (a=
ctive)
<7>[    0.505771] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (acti=
ve)
<6>[    0.505832] system 00:04: [io  0x1854-0x1857] has been reserved
<7>[    0.505840] system 00:04: Plug and Play ACPI device, IDs INT3f0d PN=
P0c02 (active)
<7>[    0.505870] pnp 00:05: Plug and Play ACPI device, IDs LEN0071 PNP03=
03 (active)
<7>[    0.505898] pnp 00:06: Plug and Play ACPI device, IDs LEN006c PNP0f=
13 (active)
<6>[    0.506056] system 00:07: [io  0x1800-0x189f] could not be reserved=

<6>[    0.506062] system 00:07: [io  0x0800-0x087f] has been reserved
<6>[    0.506066] system 00:07: [io  0x0880-0x08ff] has been reserved
<6>[    0.506070] system 00:07: [io  0x0900-0x097f] has been reserved
<6>[    0.506074] system 00:07: [io  0x0980-0x09ff] has been reserved
<6>[    0.506078] system 00:07: [io  0x0a00-0x0a7f] has been reserved
<6>[    0.506082] system 00:07: [io  0x0a80-0x0aff] has been reserved
<6>[    0.506086] system 00:07: [io  0x0b00-0x0b7f] has been reserved
<6>[    0.506097] system 00:07: [io  0x0b80-0x0bff] has been reserved
<6>[    0.506101] system 00:07: [io  0x15e0-0x15ef] has been reserved
<6>[    0.506105] system 00:07: [io  0x1600-0x167f] could not be reserved=

<6>[    0.506109] system 00:07: [io  0x1640-0x165f] could not be reserved=

<6>[    0.506114] system 00:07: [mem 0xf8000000-0xfbffffff] has been rese=
rved
<6>[    0.506119] system 00:07: [mem 0xfed10000-0xfed13fff] has been rese=
rved
<6>[    0.506123] system 00:07: [mem 0xfed18000-0xfed18fff] has been rese=
rved
<6>[    0.506128] system 00:07: [mem 0xfed19000-0xfed19fff] has been rese=
rved
<6>[    0.506134] system 00:07: [mem 0xfeb00000-0xfebfffff] has been rese=
rved
<6>[    0.506139] system 00:07: [mem 0xfed20000-0xfed3ffff] has been rese=
rved
<6>[    0.506143] system 00:07: [mem 0xfed90000-0xfed93fff] has been rese=
rved
<6>[    0.506148] system 00:07: [mem 0xf7fe0000-0xf7ffffff] has been rese=
rved
<7>[    0.506156] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (a=
ctive)
<6>[    0.508220] system 00:08: [mem 0xfdaf0000-0xfdafffff] has been rese=
rved
<6>[    0.508225] system 00:08: [mem 0xfdae0000-0xfdaeffff] has been rese=
rved
<6>[    0.508230] system 00:08: [mem 0xfdac0000-0xfdacffff] has been rese=
rved
<7>[    0.508238] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (a=
ctive)
<6>[    0.509130] system 00:09: [mem 0xfed10000-0xfed17fff] could not be =
reserved
<6>[    0.509136] system 00:09: [mem 0xfed18000-0xfed18fff] has been rese=
rved
<6>[    0.509141] system 00:09: [mem 0xfed19000-0xfed19fff] has been rese=
rved
<6>[    0.509145] system 00:09: [mem 0xf8000000-0xfbffffff] has been rese=
rved
<6>[    0.509149] system 00:09: [mem 0xfed20000-0xfed3ffff] has been rese=
rved
<6>[    0.509153] system 00:09: [mem 0xfed90000-0xfed93fff] has been rese=
rved
<6>[    0.509157] system 00:09: [mem 0xfed45000-0xfed8ffff] has been rese=
rved
<6>[    0.509162] system 00:09: [mem 0xff000000-0xffffffff] has been rese=
rved
<6>[    0.509166] system 00:09: [mem 0xfee00000-0xfeefffff] has been rese=
rved
<6>[    0.509170] system 00:09: [mem 0xf7fe0000-0xf7ffffff] has been rese=
rved
<7>[    0.509178] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (a=
ctive)
<6>[    0.509602] system 00:0a: [mem 0x00000000-0x0009ffff] could not be =
reserved
<6>[    0.509607] system 00:0a: [mem 0x000f0000-0x000fffff] could not be =
reserved
<6>[    0.509612] system 00:0a: [mem 0x00100000-0x9f7fffff] could not be =
reserved
<6>[    0.509616] system 00:0a: [mem 0xfec00000-0xfed3ffff] could not be =
reserved
<6>[    0.509621] system 00:0a: [mem 0xfed4c000-0xffffffff] could not be =
reserved
<7>[    0.509629] system 00:0a: Plug and Play ACPI device, IDs PNP0c01 (a=
ctive)
<6>[    0.509819] pnp: PnP ACPI: found 11 devices
<6>[    0.516234] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffff=
ff, max_idle_ns: 2085701024 ns
<6>[    0.516278] NET: Registered protocol family 2
<6>[    0.516454] tcp_listen_portaddr_hash hash table entries: 16384 (ord=
er: 6, 262144 bytes, linear)
<6>[    0.516516] TCP established hash table entries: 262144 (order: 9, 2=
097152 bytes, linear)
<6>[    0.516951] TCP bind hash table entries: 65536 (order: 8, 1048576 b=
ytes, linear)
<6>[    0.517122] TCP: Hash tables configured (established 262144 bind 65=
536)
<6>[    0.517173] UDP hash table entries: 16384 (order: 7, 524288 bytes, =
linear)
<6>[    0.517280] UDP-Lite hash table entries: 16384 (order: 7, 524288 by=
tes, linear)
<6>[    0.517439] NET: Registered protocol family 1
<6>[    0.517587] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to =
[bus 01-39] add_size 1000
<6>[    0.517602] pci 0000:00:1c.0: BAR 7: assigned [io  0x2000-0x2fff]
<6>[    0.517607] pci 0000:00:1c.0: PCI bridge to [bus 01-39]
<6>[    0.517616] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
<6>[    0.517626] pci 0000:00:1c.0:   bridge window [mem 0xd4000000-0xea0=
fffff]
<6>[    0.517635] pci 0000:00:1c.0:   bridge window [mem 0xb0000000-0xd1f=
fffff 64bit pref]
<6>[    0.517646] pci 0000:00:1c.2: PCI bridge to [bus 3a]
<6>[    0.517653] pci 0000:00:1c.2:   bridge window [mem 0xec100000-0xec1=
fffff]
<6>[    0.517664] pci 0000:00:1d.0: PCI bridge to [bus 3c]
<6>[    0.517681] pci 0000:00:1d.0:   bridge window [mem 0xec000000-0xec0=
fffff]
<6>[    0.517695] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
<6>[    0.517699] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
<6>[    0.517703] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff =
window]
<6>[    0.517707] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff =
window]
<6>[    0.517711] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff =
window]
<6>[    0.517715] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff =
window]
<6>[    0.517719] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff=
 window]
<6>[    0.517723] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff=
 window]
<6>[    0.517727] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff=
 window]
<6>[    0.517731] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff=
 window]
<6>[    0.517735] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff=
 window]
<6>[    0.517739] pci_bus 0000:00: resource 15 [mem 0x000e0000-0x000e3fff=
 window]
<6>[    0.517743] pci_bus 0000:00: resource 16 [mem 0x000e4000-0x000e7fff=
 window]
<6>[    0.517747] pci_bus 0000:00: resource 17 [mem 0x000e8000-0x000ebfff=
 window]
<6>[    0.517751] pci_bus 0000:00: resource 18 [mem 0x000ec000-0x000effff=
 window]
<6>[    0.517755] pci_bus 0000:00: resource 19 [mem 0x000f0000-0x000fffff=
 window]
<6>[    0.517759] pci_bus 0000:00: resource 20 [mem 0x9f800000-0xf7ffffff=
 window]
<6>[    0.517763] pci_bus 0000:00: resource 21 [mem 0xfd000000-0xfe7fffff=
 window]
<6>[    0.517768] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
<6>[    0.517771] pci_bus 0000:01: resource 1 [mem 0xd4000000-0xea0fffff]=

<6>[    0.517775] pci_bus 0000:01: resource 2 [mem 0xb0000000-0xd1ffffff =
64bit pref]
<6>[    0.517780] pci_bus 0000:3a: resource 1 [mem 0xec100000-0xec1fffff]=

<6>[    0.517784] pci_bus 0000:3c: resource 1 [mem 0xec000000-0xec0fffff]=

<6>[    0.518001] pci 0000:00:02.0: Video device with shadowed ROM at [me=
m 0x000c0000-0x000dffff]
<6>[    0.519005] PCI: CLS 0 bytes, default 64
<6>[    0.519055] Unpacking initramfs...
<6>[    6.391185] Freeing initrd memory: 31668K
<6>[    6.391239] DMAR: Host address width 39
<6>[    6.391244] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
<6>[    6.391270] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c=
40660462 ecap 19e2ff0505e
<6>[    6.391276] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
<6>[    6.391289] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c4=
0660462 ecap f050da
<6>[    6.391294] DMAR: RMRR base: 0x0000009aa9f000 end: 0x0000009aabefff=

<6>[    6.391298] DMAR: RMRR base: 0x0000009d000000 end: 0x0000009f7fffff=

<6>[    6.391314] DMAR: No ATSR found
<3>[    6.391359] pci 0000:00:02.0: DMAR: TH(1) Prevent segfault for iomm=
u access
<6>[    6.391370] DMAR: dmar1: Using Queued invalidation
<6>[    6.391478] pci 0000:00:00.0: Adding to iommu group 0
<6>[    6.391497] pci 0000:00:02.0: Adding to iommu group 1
<6>[    6.391523] pci 0000:00:14.0: Adding to iommu group 2
<6>[    6.391537] pci 0000:00:14.2: Adding to iommu group 2
<6>[    6.391557] pci 0000:00:16.0: Adding to iommu group 3
<6>[    6.391580] pci 0000:00:1c.0: Adding to iommu group 4
<6>[    6.391601] pci 0000:00:1c.2: Adding to iommu group 5
<6>[    6.391629] pci 0000:00:1d.0: Adding to iommu group 6
<6>[    6.391678] pci 0000:00:1f.0: Adding to iommu group 7
<6>[    6.391693] pci 0000:00:1f.2: Adding to iommu group 7
<6>[    6.391709] pci 0000:00:1f.3: Adding to iommu group 7
<6>[    6.391724] pci 0000:00:1f.4: Adding to iommu group 7
<6>[    6.391739] pci 0000:00:1f.6: Adding to iommu group 7
<6>[    6.391760] pci 0000:3a:00.0: Adding to iommu group 8
<6>[    6.391788] pci 0000:3c:00.0: Adding to iommu group 9
<6>[    6.395340] DMAR: Intel(R) Virtualization Technology for Directed I=
/O
<6>[    6.395345] PCI-DMA: Using software bounce buffering for IO (SWIOTL=
B)
<6>[    6.395349] software IO TLB: mapped [mem 0x95b13000-0x99b13000] (64=
MB)
<6>[    6.395515] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 6=
55360 ms ovfl timer
<6>[    6.395519] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
<6>[    6.395523] RAPL PMU: hw unit of domain package 2^-14 Joules
<6>[    6.395526] RAPL PMU: hw unit of domain dram 2^-14 Joules
<6>[    6.395529] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
<6>[    6.395532] RAPL PMU: hw unit of domain psys 2^-14 Joules
<4>[    6.395602] resource sanity check: requesting [mem 0xfed10000-0xfed=
15fff], which spans more than pnp 00:07 [mem 0xfed10000-0xfed13fff]
<4>[    6.395612] caller snb_uncore_imc_init_box+0x7a/0xc0 mapping multip=
le BARs
<6>[    6.395884] check: Scanning for low memory corruption every 60 seco=
nds
<5>[    6.396461] Initialise system trusted keyrings
<6>[    6.396526] workingset: timestamp_bits=3D56 max_order=3D23 bucket_o=
rder=3D0
<6>[    6.398412] squashfs: version 4.0 (2009/01/31) Phillip Lougher
<6>[    6.398488] 9p: Installing v9fs 9p2000 file system support
<5>[    6.416300] Key type asymmetric registered
<5>[    6.416304] Asymmetric key parser 'x509' registered
<6>[    6.416316] Block layer SCSI generic (bsg) driver version 0.4 loade=
d (major 249)
<6>[    6.416320] io scheduler mq-deadline registered
<6>[    6.416323] io scheduler kyber registered
<6>[    6.417396] shpchp: Standard Hot Plug PCI Controller Driver version=
: 0.4
<3>[    6.426975] acpiphp_ibm: ibm_acpiphp_init: acpi_walk_namespace fail=
ed
<6>[    6.427011] efifb: probing for efifb
<6>[    6.427030] efifb: framebuffer at 0xa0000000, using 8128k, total 81=
28k
<6>[    6.427034] efifb: mode is 1920x1080x32, linelength=3D7680, pages=3D=
1
<6>[    6.427037] efifb: scrolling: redraw
<6>[    6.427041] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
<6>[    6.434000] Console: switching to colour frame buffer device 240x67=

<6>[    6.440832] fb0: EFI VGA frame buffer device
<7>[    6.440871] intel_idle: MWAIT substates: 0x11142120
<7>[    6.440872] intel_idle: v0.5.1 model 0x8E
<7>[    6.441062] intel_idle: Local APIC timer is reliable in all C-state=
s
<6>[    6.441616] ACPI: AC Adapter [AC] (off-line)
<6>[    6.441801] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00=
/PNP0C0E:00/input/input0
<6>[    6.441899] ACPI: Sleep Button [SLPB]
<6>[    6.441971] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/P=
NP0C0D:00/input/input1
<6>[    6.442050] ACPI: Lid Switch [LID]
<6>[    6.442128] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00=
/input/input2
<6>[    6.442202] ACPI: Power Button [PWRF]
<6>[    6.446585] thermal LNXTHERM:00: registered as thermal_zone0
<6>[    6.446623] ACPI: Thermal Zone [THM0] (31 C)
<6>[    6.448337] Serial: 8250/16550 driver, 4 ports, IRQ sharing disable=
d
<6>[    6.448535] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D=
 115200) is a 16550A
<6>[    6.449425] Non-volatile memory driver v1.3
<6>[    6.449565] Linux agpgart interface v0.103
<6>[    6.449804] i915 0000:00:02.0: enabling device (0006 -> 0007)
<7>[    6.450467] checking generic (a0000000 7f0000) vs hw (eb000000 1000=
000)
<7>[    6.450468] checking generic (a0000000 7f0000) vs hw (a0000000 1000=
0000)
<6>[    6.450470] fb0: switching to inteldrmfb from EFI VGA
<6>[    6.450824] Console: switching to colour dummy device 80x25
<6>[    6.454690] i915 0000:00:02.0: [drm] Finished loading DMC firmware =
i915/kbl_dmc_ver1_04.bin (v1.4)
<6>[    6.470157] i915 0000:00:02.0: [drm] Panel advertises DPCD backligh=
t support, but VBT disagrees. If your backlight controls don't work try b=
ooting with i915.enable_dpcd_backlight=3D1. If your machine needs this, p=
lease file a _new_ bug report on drm/i915, see https://gitlab.freedesktop=
=2Eorg/drm/intel/-/wikis/How-to-file-i915-bugs for details.
<6>[    6.471283] battery: ACPI: Battery Slot [BAT0] (battery present)
<5>[    6.477744] random: fast init done
<6>[    6.481100] [drm] Initialized i915 1.6.0 20200715 for 0000:00:02.0 =
on minor 0
<6>[    6.486894] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  po=
st: no)
<6>[    6.487509] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PN=
P0A08:00/LNXVIDEO:00/input/input3
<6>[    6.495333] battery: ACPI: Battery Slot [BAT1] (battery present)
<6>[    6.496500] loop: module loaded
<6>[    6.497008] nvme nvme0: pci function 0000:3c:00.0
<6>[    6.497455] sky2: driver version 1.30
<6>[    6.497509] Intel(R) Wireless WiFi driver for Linux
<6>[    6.498485] iwlwifi 0000:3a:00.0: enabling device (0000 -> 0002)
<6>[    6.514870] iwlwifi 0000:3a:00.0: Found debug destination: EXTERNAL=
_DRAM
<6>[    6.514877] iwlwifi 0000:3a:00.0: Found debug configuration: 0
<6>[    6.515651] iwlwifi 0000:3a:00.0: loaded firmware version 36.79ff3c=
cf.0 8265-36.ucode op_mode iwlmvm
<6>[    6.515792] iwlwifi 0000:3a:00.0: Detected Intel(R) Dual Band Wirel=
ess AC 8265, REV=3D0x230
<6>[    6.518217] modprobe (90) used greatest stack depth: 14296 bytes le=
ft
<6>[    6.523860] iwlwifi 0000:3a:00.0: Applying debug destination EXTERN=
AL_DRAM
<6>[    6.524337] iwlwifi 0000:3a:00.0: Allocated 0x00400000 bytes for fi=
rmware monitor.
<6>[    6.527800] nvme nvme0: 4/0/0 default/read/poll queues
<6>[    6.535269]  nvme0n1: p3 p5
<6>[    6.580643] iwlwifi 0000:3a:00.0: base HW address: 00:28:f8:84:36:4=
0
<6>[    6.605794] fbcon: i915drmfb (fb0) is primary device
<6>[    6.637038] Console: switching to colour frame buffer device 240x67=

<6>[    6.653026] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer de=
vice
<7>[    6.656572] ieee80211 phy0: Selected rate control algorithm 'iwl-mv=
m-rs'
<4>[    6.656945] thermal thermal_zone1: failed to read out thermal zone =
(-61)
<6>[    6.657010] usbcore: registered new interface driver r8152
<6>[    6.657055] usbcore: registered new interface driver asix
<6>[    6.657132] usbcore: registered new interface driver ax88179_178a
<6>[    6.657179] usbcore: registered new interface driver cdc_ether
<6>[    6.657224] usbcore: registered new interface driver net1080
<6>[    6.657268] usbcore: registered new interface driver zaurus
<6>[    6.657319] usbcore: registered new interface driver cdc_ncm
<6>[    6.657362] usbcore: registered new interface driver qmi_wwan
<6>[    6.657407] usbcore: registered new interface driver cdc_mbim
<6>[    6.657619] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Dri=
ver
<6>[    6.657673] ehci-pci: EHCI PCI platform driver
<6>[    6.657726] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
<6>[    6.657767] ohci-pci: OHCI PCI platform driver
<6>[    6.657810] uhci_hcd: USB Universal Host Controller Interface drive=
r
<6>[    6.658208] xhci_hcd 0000:00:14.0: xHCI Host Controller
<6>[    6.658397] xhci_hcd 0000:00:14.0: new USB bus registered, assigned=
 bus number 1
<6>[    6.659640] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci versio=
n 0x100 quirks 0x0000000081109810
<6>[    6.659976] xhci_hcd 0000:00:14.0: cache line size of 64 is not sup=
ported
<6>[    6.660331] usb usb1: New USB device found, idVendor=3D1d6b, idProd=
uct=3D0002, bcdDevice=3D 5.09
<6>[    6.660385] usb usb1: New USB device strings: Mfr=3D3, Product=3D2,=
 SerialNumber=3D1
<6>[    6.660432] usb usb1: Product: xHCI Host Controller
<6>[    6.660465] usb usb1: Manufacturer: Linux 5.9.0-devel+ xhci-hcd
<6>[    6.660504] usb usb1: SerialNumber: 0000:00:14.0
<6>[    6.660822] hub 1-0:1.0: USB hub found
<6>[    6.660887] hub 1-0:1.0: 12 ports detected
<6>[    6.663520] xhci_hcd 0000:00:14.0: xHCI Host Controller
<6>[    6.663658] xhci_hcd 0000:00:14.0: new USB bus registered, assigned=
 bus number 2
<6>[    6.663714] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed=

<6>[    6.663821] usb usb2: New USB device found, idVendor=3D1d6b, idProd=
uct=3D0003, bcdDevice=3D 5.09
<6>[    6.663874] usb usb2: New USB device strings: Mfr=3D3, Product=3D2,=
 SerialNumber=3D1
<6>[    6.663920] usb usb2: Product: xHCI Host Controller
<6>[    6.663952] usb usb2: Manufacturer: Linux 5.9.0-devel+ xhci-hcd
<6>[    6.663991] usb usb2: SerialNumber: 0000:00:14.0
<6>[    6.664225] hub 2-0:1.0: USB hub found
<6>[    6.664294] hub 2-0:1.0: 6 ports detected
<4>[    6.665654] usb: port power management may be unreliable
<6>[    6.666018] usbcore: registered new interface driver usblp
<6>[    6.666074] usbcore: registered new interface driver cdc_wdm
<6>[    6.666205] usbcore: registered new interface driver uas
<6>[    6.668136] usbcore: registered new interface driver usb-storage
<6>[    6.669998] usbcore: registered new interface driver ums-datafab
<6>[    6.671847] usbcore: registered new interface driver ums-freecom
<6>[    6.673658] usbcore: registered new interface driver ums-isd200
<6>[    6.675436] usbcore: registered new interface driver ums-jumpshot
<6>[    6.677197] usbcore: registered new interface driver ums-sddr09
<6>[    6.678910] usbcore: registered new interface driver ums-sddr55
<6>[    6.680619] usbcore: registered new interface driver ums-usbat
<6>[    6.904062] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] a=
t 0x60,0x64 irq 1,12
<6>[    6.908042] serio: i8042 KBD port at 0x60,0x64 irq 1
<6>[    6.910118] serio: i8042 AUX port at 0x60,0x64 irq 12
<6>[    6.915555] mousedev: PS/2 mouse device common for all mice
<6>[    6.920434] rtc_cmos 00:03: RTC can wake from S4
<6>[    6.926449] rtc_cmos 00:03: registered as rtc0
<6>[    6.929364] input: AT Translated Set 2 keyboard as /devices/platfor=
m/i8042/serio0/input/input4
<6>[    6.930192] rtc_cmos 00:03: alarms up to one month, y3k, 242 bytes =
nvram, hpet irqs
<6>[    6.934507] i801_smbus 0000:00:1f.4: enabling device (0000 -> 0003)=

<6>[    6.936599] i801_smbus 0000:00:1f.4: SPD Write Disable is set
<6>[    6.938517] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
<6>[    6.942954] i2c i2c-6: 2/2 memory slots populated (from DMI)
<6>[    6.945720] i2c i2c-6: Successfully instantiated SPD at 0x51
<6>[    6.947587] intel_pstate: Intel P-state driver initializing
<6>[    6.949844] intel_pstate: HWP enabled
<6>[    6.950430] EFI Variables Facility v0.08 2004-May-17
<6>[    6.988460] usb 2-3: new SuperSpeed Gen 1 USB device number 2 using=
 xhci_hcd
<6>[    7.009331] hid: raw HID events driver (C) Jiri Kosina
<6>[    7.009983] usbcore: registered new interface driver usbhid
<6>[    7.010590] usbhid: USB HID core driver
<6>[    7.011284] fujitsu_laptop: driver 0.6.0 successfully loaded
<6>[    7.011961] thinkpad_acpi: ThinkPad ACPI Extras v0.26
<6>[    7.012537] thinkpad_acpi: http://ibm-acpi.sf.net/
<6>[    7.013114] thinkpad_acpi: ThinkPad BIOS N1WET46S (1.25s ), EC N1WH=
T37W
<6>[    7.013698] thinkpad_acpi: Lenovo ThinkPad T470s, model 20HGS0TW00
<6>[    7.018907] usb 2-3: New USB device found, idVendor=3D0bda, idProdu=
ct=3D0316, bcdDevice=3D 2.04
<6>[    7.020300] thinkpad_acpi: radio switch found; radios are enabled
<6>[    7.021548] usb 2-3: New USB device strings: Mfr=3D1, Product=3D2, =
SerialNumber=3D3
<6>[    7.023067] thinkpad_acpi: This ThinkPad has standard ACPI backligh=
t brightness control, supported by the ACPI video driver
<5>[    7.023068] thinkpad_acpi: Disabling thinkpad-acpi brightness event=
s by default...
<6>[    7.029877] usb 2-3: Product: USB3.0-CRW
<6>[    7.031132] usb 2-3: Manufacturer: Generic
<6>[    7.032912] usb 2-3: SerialNumber: 20120501030900000
<6>[    7.040292] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio=
 is unblocked
<6>[    7.046016] usb-storage 2-3:1.0: USB Mass Storage device detected
<6>[    7.047144] scsi host0: usb-storage 2-3:1.0
<6>[    7.048589] thinkpad_acpi: rfkill switch tpacpi_wwan_sw: radio is u=
nblocked
<6>[    7.073301] thinkpad_acpi: Standard ACPI backlight interface availa=
ble, not loading native one
<6>[    7.082692] thinkpad_acpi: battery 2 registered (start 0, stop 100)=

<6>[    7.089034] thinkpad_acpi: battery 1 registered (start 0, stop 100)=

<6>[    7.089808] battery: new extension: ThinkPad Battery Extension
<6>[    7.093910] input: ThinkPad Extra Buttons as /devices/platform/thin=
kpad_acpi/input/input7
<6>[    7.098331] usbcore: registered new interface driver snd-usb-audio
<6>[    7.099107] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i91=
5_audio_component_bind_ops)
<6>[    7.100017] IPv4 over IPsec tunneling driver
<6>[    7.101000] Initializing XFRM netlink socket
<6>[    7.104580] NET: Registered protocol family 10
<6>[    7.105647] Segment Routing with IPv6
<6>[    7.106598] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
<6>[    7.108249] NET: Registered protocol family 17
<6>[    7.108916] NET: Registered protocol family 15
<6>[    7.109586] 9pnet: Installing 9P2000 support
<6>[    7.113733] microcode: sig=3D0x806e9, pf=3D0x80, revision=3D0xd6
<6>[    7.114564] microcode: Microcode Update Driver: v2.2.
<6>[    7.114566] IPI shorthand broadcast: enabled
<6>[    7.118486] sched_clock: Marking stable (7113979679, 4489261)->(712=
3970615, -5501675)
<5>[    7.119233] Loading compiled-in X.509 certificates
<5>[    7.123730] Loaded X.509 cert 'Build time autogenerated kernel key:=
 bac5e2ce99b2c040187df412bfc96e6f4c647cac'
<6>[    7.124453] pstore: Using crash dump compression: deflate
<6>[    7.125669] usb 1-5: new full-speed USB device number 2 using xhci_=
hcd
<6>[    7.126141] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC29=
8: line_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:speaker
<6>[    7.129585] PM:   Magic number: 0:979:728
<6>[    7.129607] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=3D0 =
(0x0/0x0/0x0/0x0/0x0)
<6>[    7.129608] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=3D2 (0x17=
/0x21/0x0/0x0/0x0)
<6>[    7.129608] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=3D=
0x0
<6>[    7.129609] snd_hda_codec_realtek hdaudioC0D0:    inputs:
<6>[    7.129609] snd_hda_codec_realtek hdaudioC0D0:      Mic=3D0x18
<6>[    7.129610] snd_hda_codec_realtek hdaudioC0D0:      Dock Mic=3D0x19=

<6>[    7.129611] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=3D=
0x12
<5>[    7.135854] cfg80211: Loading compiled-in X.509 certificates for re=
gulatory database
<5>[    7.143063] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9ce=
a7'
<6>[    7.143824] ALSA device list:
<6>[    7.144579]   No soundcards found.
<6>[    7.145895] Freeing unused kernel image (initmem) memory: 1556K
<6>[    7.154293] Write protecting the kernel read-only data: 24576k
<6>[    7.155385] Freeing unused kernel image (text/rodata gap) memory: 2=
044K
<6>[    7.156193] Freeing unused kernel image (rodata/data gap) memory: 5=
64K
<6>[    7.156937] Run /init as init process
<7>[    7.157661]   with arguments:
<7>[    7.157661]     /init
<7>[    7.157662]   with environment:
<7>[    7.157662]     HOME=3D/
<7>[    7.157662]     TERM=3Dlinux
<7>[    7.157663]     BOOT_IMAGE=3D/isolinux/bzImage
<7>[    7.157663]     intel_iommu=3Don,igfx_off
<6>[    7.187943] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00=
:1f.3/sound/card0/input8
<6>[    7.188776] input: HDA Intel PCH Dock Mic as /devices/pci0000:00/00=
00:00:1f.3/sound/card0/input9
<6>[    7.189635] input: HDA Intel PCH Dock Headphone as /devices/pci0000=
:00/0000:00:1f.3/sound/card0/input10
<6>[    7.190520] input: HDA Intel PCH Headphone as /devices/pci0000:00/0=
000:00:1f.3/sound/card0/input11
<6>[    7.191397] input: HDA Intel PCH HDMI/DP,pcm=3D3 as /devices/pci000=
0:00/0000:00:1f.3/sound/card0/input12
<6>[    7.192276] input: HDA Intel PCH HDMI/DP,pcm=3D7 as /devices/pci000=
0:00/0000:00:1f.3/sound/card0/input13
<6>[    7.193146] input: HDA Intel PCH HDMI/DP,pcm=3D8 as /devices/pci000=
0:00/0000:00:1f.3/sound/card0/input14
<6>[    7.195116] input: HDA Intel PCH HDMI/DP,pcm=3D9 as /devices/pci000=
0:00/0000:00:1f.3/sound/card0/input15
<6>[    7.195144] input: HDA Intel PCH HDMI/DP,pcm=3D10 as /devices/pci00=
00:00/0000:00:1f.3/sound/card0/input16
<6>[    7.266761] usb 1-5: New USB device found, idVendor=3D058f, idProdu=
ct=3D9540, bcdDevice=3D 1.20
<6>[    7.269190] usb 1-5: New USB device strings: Mfr=3D1, Product=3D2, =
SerialNumber=3D0
<6>[    7.270698] usb 1-5: Product: EMV Smartcard Reader
<6>[    7.271323] usb 1-5: Manufacturer: Generic
<6>[    7.372119] usb 2-4: new SuperSpeed Gen 1 USB device number 3 using=
 xhci_hcd
<6>[    7.386998] usb 2-4: New USB device found, idVendor=3D0781, idProdu=
ct=3D5580, bcdDevice=3D 0.10
<6>[    7.387604] usb 2-4: New USB device strings: Mfr=3D1, Product=3D2, =
SerialNumber=3D3
<6>[    7.388214] usb 2-4: Product: Extreme
<6>[    7.388815] usb 2-4: Manufacturer: SanDisk
<6>[    7.389414] usb 2-4: SerialNumber: AA010121131224373982
<6>[    7.392107] usb-storage 2-4:1.0: USB Mass Storage device detected
<6>[    7.397265] scsi host1: usb-storage 2-4:1.0
<6>[    7.442101] tsc: Refined TSC clocksource calibration: 2904.006 MHz
<6>[    7.442738] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: =
0x29dc0b74fd3, max_idle_ns: 440795242287 ns
<6>[    7.443437] clocksource: Switched to clocksource tsc
<6>[    7.500210] usb 1-6: new high-speed USB device number 3 using xhci_=
hcd
<4>[    7.626658] usb 1-6: config 1 has an invalid interface number: 12 b=
ut max is 1
<4>[    7.627296] usb 1-6: config 1 has an invalid interface number: 13 b=
ut max is 1
<4>[    7.627910] usb 1-6: config 1 has an invalid interface number: 13 b=
ut max is 1
<4>[    7.628516] usb 1-6: config 1 has no interface number 0
<4>[    7.629124] usb 1-6: config 1 has no interface number 1
<6>[    7.630294] usb 1-6: New USB device found, idVendor=3D1199, idProdu=
ct=3D9079, bcdDevice=3D 0.06
<6>[    7.630918] usb 1-6: New USB device strings: Mfr=3D1, Product=3D2, =
SerialNumber=3D3
<6>[    7.631544] usb 1-6: Product: Sierra Wireless EM7455 Qualcomm Snapd=
ragon X7 LTE-A
<6>[    7.632177] usb 1-6: Manufacturer: Sierra Wireless, Incorporated
<6>[    7.632805] usb 1-6: SerialNumber: LF71027892011020
<6>[    7.656325] cdc_mbim 1-6:1.12: cdc-wdm0: USB WDM device
<6>[    7.657007] cdc_mbim 1-6:1.12 wwan0: register 'cdc_mbim' at usb-000=
0:00:14.0-6, CDC MBIM, 22:d0:a3:ab:67:27
<6>[    7.771190] usb 1-7: new full-speed USB device number 4 using xhci_=
hcd
<6>[    7.780914] psmouse serio1: synaptics: queried max coordinates: x [=
=2E.5676], y [..4762]
<6>[    7.816639] psmouse serio1: synaptics: queried min coordinates: x [=
1266..], y [1094..]
<6>[    7.818664] psmouse serio1: synaptics: Trying to set up SMBus acces=
s
<6>[    7.824724] rmi4_smbus 6-002c: registering SMbus-connected sensor
<6>[    7.888874] rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: =
Synaptics, product: TM3145-005, fw id: 2491761
<6>[    7.900732] usb 1-7: New USB device found, idVendor=3D8087, idProdu=
ct=3D0a2b, bcdDevice=3D 0.10
<6>[    7.902901] usb 1-7: New USB device strings: Mfr=3D0, Product=3D0, =
SerialNumber=3D0
<6>[    7.961024] input: Synaptics TM3145-005 as /devices/rmi4-00/input/i=
nput17
<6>[    7.970563] serio: RMI4 PS/2 pass-through port at rmi4-00.fn03
<6>[    8.022191] usb 1-8: new high-speed USB device number 5 using xhci_=
hcd
<5>[    8.084848] scsi 0:0:0:0: Direct-Access     Generic- SD/MMC        =
   1.00 PQ: 0 ANSI: 6
<5>[    8.094863] sd 0:0:0:0: [sda] Attached SCSI removable disk
<6>[    8.202190] usb 1-8: New USB device found, idVendor=3D5986, idProdu=
ct=3D111c, bcdDevice=3D37.27
<6>[    8.204439] usb 1-8: New USB device strings: Mfr=3D3, Product=3D1, =
SerialNumber=3D2
<6>[    8.206687] usb 1-8: Product: Integrated Camera
<6>[    8.208947] usb 1-8: Manufacturer: Bison
<6>[    8.210947] usb 1-8: SerialNumber: 200901010001
<5>[    8.251501] random: vgscan: uninitialized urandom read (4 bytes rea=
d)
<6>[    8.292798] vgscan (149) used greatest stack depth: 14040 bytes lef=
t
<5>[    8.299787] random: vgchange: uninitialized urandom read (4 bytes r=
ead)
<6>[    8.331974] device-mapper: ioctl: 4.42.0-ioctl (2020-02-27) initial=
ised: dm-devel@redhat.com
<6>[    8.333718] modprobe (151) used greatest stack depth: 13968 bytes l=
eft
<6>[    8.344813] psmouse serio2: trackpoint: IBM TrackPoint firmware: 0x=
0e, buttons: 3/3
<6>[    8.372605] vgchange (150) used greatest stack depth: 13816 bytes l=
eft
<6>[    8.382212] input: TPPS/2 IBM TrackPoint as /devices/rmi4-00/rmi4-0=
0.fn03/serio2/input/input18
<5>[    8.402405] scsi 1:0:0:0: Direct-Access     SanDisk  Extreme       =
   0001 PQ: 0 ANSI: 6
<7>[    8.415258] ISO 9660 Extensions: Microsoft Joliet Level 3
<7>[    8.415451] ISO 9660 Extensions: RRIP_1991A
<7>[    8.421909] ISO 9660 Extensions: Microsoft Joliet Level 3
<7>[    8.422123] ISO 9660 Extensions: RRIP_1991A
<7>[    8.426737] ISO 9660 Extensions: Microsoft Joliet Level 3
<7>[    8.426913] ISO 9660 Extensions: RRIP_1991A
<7>[    8.433037] ISO 9660 Extensions: Microsoft Joliet Level 3
<7>[    8.433219] ISO 9660 Extensions: RRIP_1991A
<5>[    8.581171] sd 1:0:0:0: [sdb] 31277232 512-byte logical blocks: (16=
=2E0 GB/14.9 GiB)
<5>[    8.583545] sd 1:0:0:0: [sdb] Write Protect is off
<7>[    8.585512] sd 1:0:0:0: [sdb] Mode Sense: 53 00 00 08
<5>[    8.585940] sd 1:0:0:0: [sdb] Write cache: disabled, read cache: en=
abled, doesn't support DPO or FUA
<6>[    8.594029]  sdb: sdb1
<5>[    8.598117] sd 1:0:0:0: [sdb] Attached SCSI removable disk
<5>[    9.347136] random: crng init done
<6>[   12.694178] udevd (130) used greatest stack depth: 13608 bytes left=

<27>[   16.794184] systemd[1]: Failed to find module 'autofs4'
<30>[   16.807304] systemd[1]: systemd 243-2-gd7bf1e3 running in system m=
ode. (-PAM -AUDIT -SELINUX -IMA -APPARMOR -SMACK -SYSVINIT -UTMP -LIBCRYP=
TSETUP -GCRYPT -GNUTLS -ACL -XZ -LZ4 +SECCOMP +BLKID -ELFUTILS +KMOD -IDN=
2 -IDN -PCRE2 default-hierarchy=3Dunified)
<30>[   16.821384] systemd[1]: Detected architecture x86-64.
<30>[   16.822442] systemd[1]: Running with unpopulated /etc.
<30>[   16.827731] systemd[1]: No hostname configured.
<30>[   16.828681] systemd[1]: Set hostname to <localhost>.
<29>[   16.877182] systemd[1]: Failed to populate /etc with preset unit s=
ettings, ignoring: File exists
<28>[   16.885687] systemd[1]: /etc/systemd/system/systemd-udevd.service.=
d/sina-lsm-label.conf:2: Unknown key name 'LSMProcessLabel' in section 'S=
ervice', ignoring.
<28>[   16.888361] systemd[1]: /etc/systemd/system/debugshell.service:16:=
 Unknown key name 'LSMProcessLabel' in section 'Service', ignoring.
<28>[   16.889779] systemd[1]: /etc/systemd/system/syslog.service:16: Unk=
nown key name 'LSMProcessLabel' in section 'Service', ignoring.
<28>[   16.894022] systemd[1]: /etc/systemd/system/wpa-supplicant.service=
:16: Unknown key name 'LSMProcessLabel' in section 'Service', ignoring.
<6>[   16.914203] modprobe (187) used greatest stack depth: 13568 bytes l=
eft
<5>[   16.989150] cryptoapi_plugger: Loading of module with unavailable k=
ey is rejected
<6>[   17.434557] udevadm (199) used greatest stack depth: 13456 bytes le=
ft
<6>[   17.577707] udevadm (205) used greatest stack depth: 13352 bytes le=
ft
<5>[   20.610102] dm_crypt_sina: Loading of module with unavailable key i=
s rejected
<5>[   20.618856] vtx: Loading of module with unavailable key is rejected=

<5>[   21.148129] vboxdrv: Loading of module with unavailable key is reje=
cted
<5>[   21.150927] vboxdrv: Loading of module with unavailable key is reje=
cted
<4>[   23.578599] ext2 filesystem being mounted at /media/persistent supp=
orts timestamps until 2038 (0x7fffffff)
<6>[   23.787209] name-net-ns (445) used greatest stack depth: 13248 byte=
s left
<6>[   23.798068] name-net-ns (448) used greatest stack depth: 13176 byte=
s left
<6>[   28.114393] floppy0: no floppy controllers found
<6>[   28.114433] work still pending
<6>[   30.089469] ip (738) used greatest stack depth: 12040 bytes left
<6>[   30.109932] IPv6: ADDRCONF(NETDEV_CHANGE): veth2: link becomes read=
y
<6>[   30.109952] IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes read=
y
<6>[   30.115400] bri: port 1(veth1) entered blocking state
<6>[   30.115401] bri: port 1(veth1) entered disabled state
<6>[   30.115429] device veth1 entered promiscuous mode
<6>[   30.121539] bri: port 1(veth1) entered blocking state
<6>[   30.121541] bri: port 1(veth1) entered forwarding state
<1>[   31.069825] BUG: kernel NULL pointer dereference, address: 00000000=
00000050
<1>[   31.070372] #PF: supervisor read access in kernel mode
<1>[   31.070903] #PF: error_code(0x0000) - not-present page
<6>[   31.071473] PGD 0 P4D 0=20
<4>[   31.072043] Oops: 0000 [#1] SMP PTI
<4>[   31.072581] CPU: 0 PID: 780 Comm: udevdata-dump Not tainted 5.9.0-d=
evel+ #7
<4>[   31.073125] Hardware name: LENOVO 20HGS0TW00/20HGS0TW00, BIOS N1WET=
46S (1.25s ) 03/30/2018
<4>[   31.073672] RIP: 0010:nvme_ctrl_loss_tmo_show+0x10/0x40
<4>[   31.074223] Code: eb 75 f0 5b 4c 89 e7 5d 41 5c e9 6b d3 9f ff e8 1=
6 37 cc ff eb d0 0f 1f 40 00 0f 1f 44 00 00 48 8b 47 78 48 8b 88 40 0a 00=
 00 <8b> 41 50 83 f8 ff 74 18 0f af 41 3c 48 89 d7 48 c7 c6 e1 61 43 87
<4>[   31.074808] RSP: 0018:ffffa69cc3aa7e48 EFLAGS: 00010286
<4>[   31.075423] RAX: ffff9c3bc3888200 RBX: ffffffff876dbd40 RCX: 000000=
0000000000
<4>[   31.076042] RDX: ffff9c3bbf135000 RSI: ffffffff876dbd40 RDI: ffff9c=
3bc38882a8
<4>[   31.076664] RBP: ffffffff870afb90 R08: ffff9c3bc38882a8 R09: ffff9c=
3bbf1b0f00
<4>[   31.077283] R10: ffff9c3bbf135000 R11: 0000000000000000 R12: 000000=
00ffffffff
<4>[   31.077904] R13: ffffa69cc3aa7f10 R14: 0000000000000001 R15: ffff9c=
3bb9ee22d0
<4>[   31.078526] FS:  00007f1be6076c00(0000) GS:ffff9c3bc7400000(0000) k=
nlGS:0000000000000000
<4>[   31.079152] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[   31.079778] CR2: 0000000000000050 CR3: 000000060212a003 CR4: 000000=
00003706f0
<4>[   31.080417] Call Trace:
<4>[   31.081052]  dev_attr_show+0x18/0x40
<4>[   31.081692]  sysfs_kf_seq_show+0xa2/0xf0
<4>[   31.082334]  seq_read+0x132/0x3e0
<4>[   31.082978]  vfs_read+0x9e/0x160
<4>[   31.083617]  ksys_read+0x59/0xd0
<4>[   31.084259]  do_syscall_64+0x33/0x40
<4>[   31.084904]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
<4>[   31.085556] RIP: 0033:0x7f1be6168b91
<4>[   31.086210] Code: fe ff ff 50 48 8d 3d 6e 88 09 00 e8 c9 f1 01 00 6=
6 0f 1f 84 00 00 00 00 00 48 8d 05 69 2b 0d 00 8b 00 85 c0 75 13 31 c0 0f=
 05 <48> 3d 00 f0 ff ff 77 57 c3 66 0f 1f 44 00 00 41 54 49 89 d4 55 48
<4>[   31.086933] RSP: 002b:00007fffad616a88 EFLAGS: 00000246 ORIG_RAX: 0=
000000000000000
<4>[   31.087673] RAX: ffffffffffffffda RBX: 000055ba8d104350 RCX: 00007f=
1be6168b91
<4>[   31.088420] RDX: 0000000000001000 RSI: 000055ba8d10e5e0 RDI: 000000=
0000000003
<4>[   31.089175] RBP: 00007f1be62332a0 R08: 0000000000000003 R09: 000000=
0000000077
<4>[   31.089933] R10: 000055ba8cfb2010 R11: 0000000000000246 R12: 000000=
0000001001
<4>[   31.090698] R13: 000055ba8d10e5e0 R14: 0000000000000d68 R15: 00007f=
1be6232760
<4>[   31.091465] Modules linked in: wacom dm_mod
<4>[   31.092232] CR2: 0000000000000050
<4>[   31.092995] ---[ end trace 9f5746dc1a99c131 ]---

No errors detected

--------------3FC3523ABCC1C9B271AFEAA8
Content-Type: text/x-patch; charset="UTF-8"; name="nvme-core.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="nvme-core.patch"

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 154942fc64eb..4fa5cc317cf3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3586,7 +3586,7 @@ static ssize_t nvme_ctrl_loss_tmo_show(struct devic=
e *dev,
 	struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
 	struct nvmf_ctrl_options *opts =3D ctrl->opts;
=20
-	if (ctrl->opts->max_reconnects =3D=3D -1)
+	if (! opts || opts->max_reconnects =3D=3D -1)
 		return sprintf(buf, "off\n");
 	return sprintf(buf, "%d\n",
 			opts->max_reconnects * opts->reconnect_delay);
@@ -3618,7 +3618,7 @@ static ssize_t nvme_ctrl_reconnect_delay_show(struc=
t device *dev,
 {
 	struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
=20
-	if (ctrl->opts->reconnect_delay =3D=3D -1)
+	if (! ctrl->opts || ctrl->opts->reconnect_delay =3D=3D -1)
 		return sprintf(buf, "off\n");
 	return sprintf(buf, "%d\n", ctrl->opts->reconnect_delay);
 }

--------------3FC3523ABCC1C9B271AFEAA8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--------------3FC3523ABCC1C9B271AFEAA8--


