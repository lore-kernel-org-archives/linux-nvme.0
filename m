Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F26AC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 02:20:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4390D61247
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 02:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4390D61247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZTybK1IgcrSJgTMBbwPrO7tK3jeW+uBt0qlpcEelJf0=; b=Uc4vTegbDepPa9
	BkHeLO1YDxIcRf6POB07UMhLXwTYSMhKhBfutO5jfcqNSMgxaUPR9eDhcPtV11AnCDNTN8RXcfxYO
	/hELWhed1VY4M3tl2lOZnUBamyPRK1UBSOTKk0OPOYhcN0O6/iHnHcyZ4qqpMwTqc2I4Z0KChhgwP
	5F01X3NivOVUSgO8W5SnzPU9Apr8BiqdJQKAJSB8kQOtQ5+oCaMHTFWxf4gmge+TLTour3M+Zb0Jc
	SCXRt6lAUSaNMBHETwMM6Yeupn9jxg42r+i3sTfkZCpwfmIkjneN4wP7Dw203c1KvD4cviwgdIohI
	9PyQQGWJeHUTNY/vaoGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mV2ip-005FYl-KD; Tue, 28 Sep 2021 02:19:55 +0000
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mV2im-005FYJ-42
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 02:19:53 +0000
Received: by mail-oi1-x234.google.com with SMTP id s24so25585313oij.8
 for <linux-nvme@lists.infradead.org>; Mon, 27 Sep 2021 19:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=F8zzgYYLvP32Aq7gnXadnM6D6XOYxWArizYsyCzSnoQ=;
 b=bDj2DDjCm5ACE1pG9XgmBLX/YXFbyp9lj8ZhP5UcFcGgopLue/fl8WKJI3eaVJcOfJ
 99IQbVo6AdOM8unn8cCFM+PfhvbtETF9LNppvBDf+EhvsJZNTg4mb+JcWo/fh3S9qHdw
 3+i+jBJf2mPnKxJz6gnnfeY174hueOtHrf3JciZVQ/5LgA7aahwkRdBaY3yOvbb74tA9
 g668/PxJZfzen5G+44VahiYP0AFzaPMYhVWOIb35KB+B2u+vNL87ZhVZnW/Mmi95/yeo
 STXoTtR5oMLF+UPQtZIf7y/ePsnER/2GoqXtj0dLE6SZ8DLAC1nnAtqW31Z4Tnku/FiT
 F9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=F8zzgYYLvP32Aq7gnXadnM6D6XOYxWArizYsyCzSnoQ=;
 b=ZRLF6iOK9+BZ97xWNALUsyylYnFi+A13luPSst8Emvz2sGqOCt9PxZqn2tx6wF87Z/
 6kFLXKM6Z0OzlCbqgHVQbDv/Joshcmw1lry5pUhZROSeGWbHMWXLI8V3N9toMNkSsB3k
 1ZGaeDpIk3aJOLF/hZw3BHmQBaz06q/bpOePXLoV2tEta1Ru2Ful1A4Dxo2zXRqr92Go
 LB/E4NhvAa/W/5QMh2dnEEtzfF1+2dVULynuNKPVE31gzzROQ+dugAQCkbGqq8lHpZMk
 ECSp34B5I3S5UJqfIdy5ri5WYT79aYZdF3E3i/RYzhdI1GnW0ba0PG79XDiHLAocX+s4
 yo3Q==
X-Gm-Message-State: AOAM531sJByIE5mfFjS+5KF8ArzBjQCB4cJc6iK5i3XroEzHsDLrZ+1E
 zTNv/UV7SAPXSLVrU8ry/109PZSgr9i+3HZT2Rc=
X-Google-Smtp-Source: ABdhPJwoTLi3/i7Jr9Fehlp9VEIL1TjeYUZbNkhP+aB/6XN794O4NGauAmmb2uuRx/u1mBQJ1chTts1qZJSor/S3+Bs=
X-Received: by 2002:aca:4b4b:: with SMTP id y72mr1755399oia.79.1632795590666; 
 Mon, 27 Sep 2021 19:19:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAGrZSEyrdJaZkHX9fPse0bv3d1x-HU7vvPQeg5JyR++_hOs8bQ@mail.gmail.com>
 <20210927200357.GA387558@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20210927200357.GA387558@dhcp-10-100-145-180.wdc.com>
From: Steven Seungcheol Lee <sc108.lee@gmail.com>
Date: Tue, 28 Sep 2021 11:19:40 +0900
Message-ID: <CAGrZSEwC4zKuXf-kwZmPrb1o7iGD4mqF_8zJ8n1PQ0KcohFAzg@mail.gmail.com>
Subject: Re: [PATCH] nvme.h: expend lbaf on nvme_id_ns, lbafe on nvme_zns_id_ns
To: Keith Busch <kbusch@kernel.org>
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_191952_213106_B8487B2D 
X-CRM114-Status: GOOD (  13.09  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

@Keith Busch
As I mentioned on commit, Its already been used from kernel source.

@Niklas Cassel
Thanks for the chekcing details, I made mistake for the structure name
since I brought those changes from nvme-cli.

Added more details on commit message about both of you guy's question.


=========== modified commit below=============
modification for supporting more LBA format from the device
if the nvme device does support over 16 LBA format,
current nvme driver will occur error.

lbaf, lbafe currently used on nvme driver
lbaf:
    function nvme_configure_metadata
    function nvme_update_ns_info
    function nvmet_passthru_override_id_ns

lbafe:
    function nvme_update_zone_info

The structure chages based on spec:
    NVMe-NVM-Command-Set-Specification-1.0a-2021.07.26-Ratified
    NVMe-Zoned-Namespace-Command-Set-Specification-1.1a-2021.07.26-Ratified

Signed-off-by: Steven Seungcheol Lee <sc108.lee@gmail.com>
---
 include/linux/nvme.h | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b7c4c4130b65..2d03c7322ac9 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -368,7 +368,10 @@ struct nvme_id_ns {
  __le16 npdg;
  __le16 npda;
  __le16 nows;
- __u8 rsvd74[18];
+ __le16 mssrl;
+ __le32 mcl;
+ __u8 msrc;
+ __u8 rsvd81[11];
  __le32 anagrpid;
  __u8 rsvd96[3];
  __u8 nsattr;
@@ -376,8 +379,7 @@ struct nvme_id_ns {
  __le16 endgid;
  __u8 nguid[16];
  __u8 eui64[8];
- struct nvme_lbaf lbaf[16];
- __u8 rsvd192[192];
+ struct nvme_lbaf lbaf[64];
  __u8 vs[3712];
 };

@@ -394,9 +396,14 @@ struct nvme_id_ns_zns {
  __le32 mor;
  __le32 rrl;
  __le32 frl;
- __u8 rsvd20[2796];
- struct nvme_zns_lbafe lbafe[16];
- __u8 rsvd3072[768];
+ __le32 rrl1;
+ __le32 rrl2;
+ __le32 rrl3;
+ __le32 frl1;
+ __le32 frl2;
+ __le32 frl3;
+ __u8 rsvd44[2772];
+ struct nvme_zns_lbafe lbafe[64];
  __u8 vs[256];
 };

--
2.25.1

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
