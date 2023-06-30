Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE4BEB64DA
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jun 2023 22:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:From:Subject:To:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HH4/y2LSJHZ45tBS8eyMfxFly0jF8FdgN1u/o33Nak8=; b=aNaemoa5bJ0ZdYIiINcVI3nbh7
	0ElQdhXg68BxdhtBW2Zm9YgwYNUXQi6VkDSlMWOobbr6odiZhnW/qu8zfeWJClcOwpvbik6pMBC0U
	7SizHs8OcfzA9VFGnVwd6y2rAmSOC/piPcqubTGXb6z5NTRkEFSSw6nzJcBW9i1zDMqoWmkLa3ZYm
	xktPMSlOpRZ7AVT2G3xM+WIgJhR3XDbR0ln0FlT2k88xiVYkxa3nSNnK/dYo33mCmIQtbGa6Udc+d
	pldVYMf4WRKhNhoY9DYIxV+X4YCS4ei04y2hNO/tzWEkRI/Q5MknEihil1BUj9Xbc9j9n6p6rtlIa
	FOmnKWJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qFMIG-004eHO-29;
	Fri, 30 Jun 2023 22:08:44 +0000
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qFMIE-004eGt-0b
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jun 2023 22:08:43 +0000
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1b0748bc78dso1486939fac.0
        for <linux-nvme@lists.infradead.org>; Fri, 30 Jun 2023 15:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688162919; x=1690754919;
        h=content-transfer-encoding:from:content-language:subject:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HH4/y2LSJHZ45tBS8eyMfxFly0jF8FdgN1u/o33Nak8=;
        b=Ewsnw6GxPTbxhtHLANdVhrBGI4owst1kCPxhBwkngrHCHSOqkq7yUZBYl5ozU1M6gp
         XKwrZq2Sm/2f8gxvF/NVPeAlOuw9usWeRJa4T1uRtVp3ezbgmQi8YdyxS8FdNqnyAHII
         JxeLKaKeXJ4w1yEnHsWkRo5Hp+pjZAiegV9XSRmq/VL24BcqkfgZ+4zp0W35hTONSSQo
         Qn+DTLm9EeHIw0yI2hmWMyXZEhi0aYWP+F2tNRPE1dkw+6Wt2qidnjEBphaRpwKMB+8A
         Foeuipjwnpc/+u61pUpWdK1hOLCleCwA+CIlkX3I1+7JHoX+kiRePHkkbiDxQajjwmDg
         oDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688162919; x=1690754919;
        h=content-transfer-encoding:from:content-language:subject:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HH4/y2LSJHZ45tBS8eyMfxFly0jF8FdgN1u/o33Nak8=;
        b=GyWp7eFrWj/1fR2ZJLjJtPizqWgqHfHMdGu/J6aJy0yNuVoUogLNm5xDDUGSj2PS/9
         lw+AHpIv6I4Sx7iYcdYyY+VzM1VUG/pdMSMAWvZoZTkyg2kmd4CSsWF+d8Mq03T5uhue
         IcTqcIEtB7HU60LUQnrH2FHj9kypfRsRN2WctlRufgIpcj71mOU2wdiToDeIX/6IE04u
         WI3wB+4Yo+Lyclrn0Y06JEbIM7KrCUXn2Z5sxR/bXCtzrxlMqnd4Z9bpRbiPSD1Xl2DA
         AlrLX4hSpcNFLJgxWeWSBXdNGZqAAFjqNLUsJVUnDX2jDIO2MyyeyIV9HeDHdrlj2oZO
         E9Tw==
X-Gm-Message-State: AC+VfDxTAUlsJ6A7/AdWwCfrgbCC2OmgFInsdjl3vzYdaBivGoTL0J0w
	QRrG4VuWEvPB1oTg+HE83sflRkojpv/Yeg==
X-Google-Smtp-Source: ACHHUZ4sGAwZj4LQUoSOdmwPTD8/o9U3njWSpb5/1+V5e80HcTndw4tq8Orltgyr5yNCXy+5Ikg8nQ==
X-Received: by 2002:a05:6870:440a:b0:184:2b9d:2b12 with SMTP id u10-20020a056870440a00b001842b9d2b12mr3966503oah.13.1688162918490;
        Fri, 30 Jun 2023 15:08:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:36d0:2460::1f? ([2600:1700:36d0:2460::1f])
        by smtp.gmail.com with ESMTPSA id i12-20020a056830010c00b006b72515e20bsm6921532otp.54.2023.06.30.15.08.36
        for <linux-nvme@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 15:08:37 -0700 (PDT)
Message-ID: <8635de3c-fdf1-a617-817f-2bc9e0f22d0f@gmail.com>
Date: Fri, 30 Jun 2023 18:08:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
To: linux-nvme@lists.infradead.org
Subject: [PATCH 1/1] Fix 2 Acer FA100 NVMe SSDs from interfering in one PC
Content-Language: en-US
From: Christopher Lentocha <christopherericlentocha@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230630_150842_231295_2F3BE444 
X-CRM114-Status: GOOD (  14.52  )
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


In order for 2 Acer FA100s to work in one PC (in the case of myself, a
Lenovo Legion T5 28IMB05), and not show one drive and not the other, and
sometimes mix up what drive shows up, these two lines of code need to be
added, and then both of the SSDs will show up and not conflict when
booting off of one of them, since if you boot off of one of the SSDs
without this patch, you may randomly get into a kernel panic or
initramfs if set up, else if you do merge this patch, there should
never be problems with booting or really anything at all.

Signed-off-by: Christopher Lentocha <christopherericlentocha@gmail.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 48c60f7fda0b..4bb521a6b68f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3427,6 +3427,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1cc1, 0x5350),   /* ADATA XPG GAMMIX S50 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1dbe, 0x5216),   /* Acer/INNOGRIT FA100/5216 NVMe SSD */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1dbe, 0x5236),   /* ADATA XPG GAMMIX S70 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e49, 0x0021),   /* ZHITAI TiPro5000 NVMe SSD */
-- 
2.38.1


