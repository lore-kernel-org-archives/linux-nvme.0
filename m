Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883D2C6FD18
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 10:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:To:Subject:Message-ID:Date:From:MIME-Version:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/wimJP0LRr/2TBBU3YKCQUTeGRJszBRTzjxrnN+0x/0=; b=S80wR6W2aFR/88+eMa1abM5zPc
	gNN0KvPtxrR811iygXT6+yIKQDevKVuxIKIhJQbLzZkKRJqGq3WiqarDHsoh3WrA5HZMhkq6kkSbx
	YGQ3Qk67Q2YXPZI8dfCT4QvbqvBSWPRPcR+j0dnR2oIB6JJvn7BRMsHnHpHqQeW2BKyRZrMooDFHp
	GhUpN3pfgjx0Y2Klhic/VNpYDb430XKImTEIOcAGfF+uccoMb7MwfaPQ7iNd+Zuxu+GP5YbUsYEYH
	/JZBCj5RJtWqGYm4D0lHEA59aOv+Z4LGjSptCziua1TnkIsJpDzY/6ifJJQ8m2WGVqbHUhbDTiOD1
	Mc6GWUbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phTAW-00HUJY-2B;
	Wed, 29 Mar 2023 10:36:40 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phTAT-00HUIb-1L
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 10:36:38 +0000
Received: by mail-ed1-x52f.google.com with SMTP id h8so61235792ede.8
        for <linux-nvme@lists.infradead.org>; Wed, 29 Mar 2023 03:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=backupbay-com.20210112.gappssmtp.com; s=20210112; t=1680086194;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/wimJP0LRr/2TBBU3YKCQUTeGRJszBRTzjxrnN+0x/0=;
        b=kf6PUWrhiK+D5MuJJCQmoFRfKCsgeTJGAisKH26vSX+pchusNk3fZvm880QQx37p9i
         h4IfVNIOPTBygIJbnF6msN0mEkaqbcC1LlvFR9ZivT3ZvzsNWKut2l9PzmWeBbMYslkX
         +5gFIYP2R/M2GDFW4HqUH0Kn35CaNvcXcjckCsBjYBROlDNQPSTcVW5tvlYhGoofzIMB
         NKf9Y8H0GgJ/PJQX0xkUZQNAHzl+W6iRzE5I2Ht62c9LqfIKd2aLzUSysGNRc4PL08UX
         S/OddoudO//Ixq+MOuTYZf5r59s9DgxVh3sckkJfE9WolGp2Fitn3cmXtwHeKRGmgo2A
         vjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680086194;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/wimJP0LRr/2TBBU3YKCQUTeGRJszBRTzjxrnN+0x/0=;
        b=AgyPBTVLf2YnlLM/Bua0eispySuJpQrrQW3tVVRvb8BZcfzjv1pG41L7rTkLC4kYJ+
         xYZZ49HTMraqCw/7MdeoSMlvoVzDq++hlPB5x8RGxfnvQVGrR5ZbZ1ZRcRfsgQ7+LkRO
         8f1cVFKkR35bbWMEp+MjtZRXoMxLFpL3fbc70DTIN/1Lbpu5WwfltvAwrMG0Y4wPyIGn
         aNzeseC1nYohIchM7I2pQac+8MW2BR24giwrQRW6CbZhfVVRMWAldHGmLcme8azuJVJv
         kzn6/vpGc2/OKyIkm+QKP6dvCamOLxfJphLJlIin2EzT/1A5eePOcIR0sczhdwoyNJWT
         Av5Q==
X-Gm-Message-State: AAQBX9cN3FCjGKR5ijyenfK2ASmr+7U2RhOvKla+5x6qXGVK0m6YQo+Y
	wNpFxm30oAStLtFiayczdCiS02q7yVM4BlVianSUI6SwkAdGAVpb+hQ=
X-Google-Smtp-Source: AKy350YKkkYeMhL3M0fMdyGC9EHzxhX8h6U99dUArCbyMiFH1ZkObshny0VdVwNBWT4MOhR1tMqIWsX02pWv5O6e5zg=
X-Received: by 2002:a17:906:9c8f:b0:93f:64b:d647 with SMTP id
 fj15-20020a1709069c8f00b0093f064bd647mr7594227ejc.1.1680086194710; Wed, 29
 Mar 2023 03:36:34 -0700 (PDT)
MIME-Version: 1.0
From: Olav Gjerde <olav@backupbay.com>
Date: Wed, 29 Mar 2023 12:36:23 +0200
Message-ID: <CAJ7kQyGTc_+ajkTGKKsyvazWRFud3P71Nv2U_bcqAnhL9yS=ZA@mail.gmail.com>
Subject: Intel P4608 (Oracle f640) doesn't show both NVMe devices. globally
 duplicate IDs for nsid
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_033637_454254_675A85BD 
X-CRM114-Status: UNSURE (   8.72  )
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

Hi,

I just upgraded to debian-testing which runs Linux 6.1 on a machine
here and I have trouble with my NVME card which has two NVMe drives. I
find the following error message in
dmesg: nvme nvme2: globally duplicate IDs for nsid 1

I googled this error message and came over the explanation here:
https://bugzilla.kernel.org/show_bug.cgi?id=3D216049

lspci returns this,

87:00.0 Non-Volatile memory controller [0108]: Intel Corporation NVMe
Datacenter SSD [3DNAND, Beta Rock Controller] [8086:0a54]
88:00.0 Non-Volatile memory controller [0108]: Intel Corporation NVMe
Datacenter SSD [3DNAND, Beta Rock Controller] [8086:0a54]

I have checked the master source code, and I see no changes recently,
so my guess is that the fix is adding NVME_QUIRK_BOGUS_NID
to the following section:
{ PCI_VDEVICE(INTEL, 0x0a54), /* Intel P4500/P4600 */
     .driver_data =3D NVME_QUIRK_STRIPE_SIZE |
     NVME_QUIRK_DEALLOCATE_ZEROES |
      NVME_QUIRK_IGNORE_DEV_SUBNQN, },

in drivers/nvme/host/pci.c

--=20
Kind Regards / Med Vennlig Hilsen

Olav Gr=C3=B8n=C3=A5s Gjerde
Sommerbakken 3
4041 HAFRSFJORD
Norway
Phone: +47 918 000 59

