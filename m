Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C47ECAAA3
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Aug 2022 09:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jOCx6WaHUkCpSW3qSoGPqbW9PT9A7ovvnlg0/bkC9do=; b=YofV2QiLyWDLkwRHabGkrBjGO+
	+kNv7wiiTRDXLnv0rp2cNxOq26By1OIRcP5QBO32AWMDYx4RjPA0/2XccFBiv4biKi9+6p0/ogqsY
	5rTkmPMkWea5JrwD2hbhmMAhEzSQmRSp5mN7OK+nQNQbXwd3yG/0V4oDv6Jy5GBGeF0v/9dHfmtPB
	rMY/NGV8cFr4t0TrmI0IfPYsa7O8S9ZmtUp8n5pkUUIi99Cyqp3JShwawbpF/7oLUsBIpFi5Sf3Ch
	O/lCEjCLcSQe6LE33J2XN+1v6MJ26UcSXqoLs9VZJJYwnPVR7WwCpPT/EypKHilgDpBUMMbXn8Vir
	x/6pEytQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRW7J-0016A9-G0; Fri, 26 Aug 2022 09:59:09 +0000
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRW7G-001622-2u
	for linux-nvme@lists.infradead.org; Fri, 26 Aug 2022 09:59:07 +0000
Received: by mail-lf1-x132.google.com with SMTP id s6so1319989lfo.11
        for <linux-nvme@lists.infradead.org>; Fri, 26 Aug 2022 02:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shyamin.com; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=jOCx6WaHUkCpSW3qSoGPqbW9PT9A7ovvnlg0/bkC9do=;
        b=a28pDSdNPCuF4jqYh886jdnzT/DpYvZB/Oy4CM8uCXLry71fUoyomK+fdFMX8H6I6G
         l5e/9C2DfqWn1nGGQmJLfrSnD2MIY+b7up27U1sqNxzs9R/T2VuM5K4sLtUtqPM1IBOP
         zw+T1RmrXk3bWxtX1HD0jhHZmIXhWDQ4FMSQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=jOCx6WaHUkCpSW3qSoGPqbW9PT9A7ovvnlg0/bkC9do=;
        b=f//5VimK97+BB2vW7mGuQAb+CJneSQfvya025xOiYzfTk3ZFj90apTrQ5NTvxAs3uQ
         50AQM3z6BAWmW0bV9V9dVDJxawyFC1eL3Em/hknRoVsoWxCgmIlNvdkHB00X5lM3q7Gf
         MX/tdqydofSiWF0EFV8Dpflr7Z1c7ItUzKyy/p3Z8wbOObIh3Wwmg+5uSFsl3tyuSxGF
         1zhU8KZf7iQNFL14urjyxPA1i7vtGa8lJlF0PCHRpdu9N6tfxdg43y7TEBPxxmMV9hdK
         CMMQKgyLY0Ls3ohSpVlBtQgZ1SeMFx0QI3T51nvCSC7zOWDiETrz5ux3LFEYhhkZxikb
         xaKw==
X-Gm-Message-State: ACgBeo3Zn70YoN97GAdCpYKpctvVaMUj+4maA4li9MduX0POVGJhVuzc
	JT4JyEQ6o8a380ROLwQcW62iRc9BUdqrEjKGlWmUUgdnHhFSdmfq6pWCUg==
X-Google-Smtp-Source: AA6agR5IVpKoLcFomIo2IbEnPXtfzDTfHTVIIaZv9UwLDGYM/4XR3Cb+dyW6dQ6SJKIcsk4+8ate8qunMeLPQHkR8mw=
X-Received: by 2002:a05:6512:3b09:b0:48b:394e:6b3b with SMTP id
 f9-20020a0565123b0900b0048b394e6b3bmr2107660lfv.567.1661507938125; Fri, 26
 Aug 2022 02:58:58 -0700 (PDT)
MIME-Version: 1.0
From: Shyamin Ayesh <me@shyamin.com>
Date: Fri, 26 Aug 2022 15:28:45 +0530
Message-ID: <CAL1XK+MViKNnPJm=iiKNXBrNmNtourYsHR1n2oWpntjj6jxQnw@mail.gmail.com>
Subject: [PATCH]: NVME device not found with Linux 5.19.* - globally duplicate
 IDs for nsid 1
To: linux-nvme@lists.infradead.org
Content-Type: multipart/mixed; boundary="00000000000071e12505e721f62d"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220826_025906_146273_ADBCB6FD 
X-CRM114-Status: GOOD (  11.21  )
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

--00000000000071e12505e721f62d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

After upgrading to linux-5.19.2 a second identical NVME device is no
longer found/visible. Only one of the 2 devices is visible in the /dev
tree. Also can reproduce the same bug in 5.18.* versions and
downgrading to 5.17.* fixes the issue atm.

The 5.18* / 5.19* kernel throws the error: "globally duplicate IDs for nsid=
 1"

=E2=9E=9C  ~ sudo dmesg| grep nvme
[    1.145069] nvme nvme0: pci function 0000:02:00.0
[    1.145201] nvme nvme1: pci function 0000:05:00.0
[    1.148053] nvme nvme1: missing or invalid SUBNQN field.
[    1.149823] nvme nvme0: missing or invalid SUBNQN field.
[    1.157321] nvme nvme1: allocated 64 MiB host memory buffer.
[    1.157960] nvme nvme1: 4/0/0 default/read/poll queues
[    1.159831]  nvme1n1: p1 p2 p3 p4
[    1.159932] nvme nvme0: allocated 64 MiB host memory buffer.
[    1.160277] nvme nvme0: 4/0/0 default/read/poll queues
[    1.160530] nvme nvme0: globally duplicate IDs for nsid 1
[    1.160532] nvme nvme0: VID:DID 1d97:2263 model:Lexar 250GB SSD
firmware:V2.18.0
=E2=9E=9C  ~

=E2=9E=9C  ~ lspci -nnk | grep "Non-Volatile memory controller"
02:00.0 Non-Volatile memory controller [0108]: Shenzhen Longsys
Electronics Co., Ltd. SM2263EN/SM2263XT-based OEM SSD [1d97:2263] (rev
03)
05:00.0 Non-Volatile memory controller [0108]: Shenzhen Longsys
Electronics Co., Ltd. SM2263EN/SM2263XT-based OEM SSD [1d97:2263] (rev
03)
=E2=9E=9C  ~

Ref: https://bugzilla.kernel.org/show_bug.cgi?id=3D216394

Please take a look at the attached test patch and hope someone can
help me to merge it to the upcoming kernel updates.

Regards,
Shyamin Ayesh

--00000000000071e12505e721f62d
Content-Type: application/octet-stream; 
	name="lexar-nm610-duplicate-ids.patch"
Content-Disposition: attachment; filename="lexar-nm610-duplicate-ids.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l7aawusj0>
X-Attachment-Id: f_l7aawusj0

ZGlmZiAtLWdpdCBhL3BjaS5jIGIvcGNpLmMKaW5kZXggM2ExYzM3Zi4uOTg4NjRiOCAxMDA2NDQK
LS0tIGEvcGNpLmMKKysrIGIvcGNpLmMKQEAgLTM1MTcsNiArMzUxNyw4IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgcGNpX2RldmljZV9pZCBudm1lX2lkX3RhYmxlW10gPSB7CiAJCS5kcml2ZXJfZGF0
YSA9IE5WTUVfUVVJUktfTk9fREVFUEVTVF9QUywgfSwKIAl7IFBDSV9ERVZJQ0UoMHhjMGE5LCAw
eDU0MGEpLCAgIC8qIENydWNpYWwgUDIgKi8KIAkJLmRyaXZlcl9kYXRhID0gTlZNRV9RVUlSS19C
T0dVU19OSUQsIH0sCisJeyBQQ0lfREVWSUNFKDB4MWQ5NywgMHgyMjYzKSwgLyogTGV4YXIgTk02
MTAgKi8KKwkJLmRyaXZlcl9kYXRhID0gTlZNRV9RVUlSS19CT0dVU19OSUQsIH0sCiAJeyBQQ0lf
REVWSUNFKFBDSV9WRU5ET1JfSURfQU1BWk9OLCAweDAwNjEpLAogCQkuZHJpdmVyX2RhdGEgPSBO
Vk1FX1FVSVJLX0RNQV9BRERSRVNTX0JJVFNfNDgsIH0sCiAJeyBQQ0lfREVWSUNFKFBDSV9WRU5E
T1JfSURfQU1BWk9OLCAweDAwNjUpLAo=
--00000000000071e12505e721f62d--

