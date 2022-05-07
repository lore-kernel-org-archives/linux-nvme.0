Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F8CC433EF
	for <linux-nvme@archiver.kernel.org>; Sat,  7 May 2022 06:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=62kD9X+wL8139kA2shJKwkd5nwt7B2MfA24KVxjQ6GE=; b=Qgze/TutoyWdQ+LjEKhdzRMa6w
	h4xCmrAFdwPJ5+fpnzchz+uMlvnNlpSkb0jV1M5VI8lC5/JOJawcN8iWRMnom63WXhHRCARsK08yX
	Wv2TbPio+TdP/5HZyGxIj+e962u8uezSJiRpEFEMvRSPC81xBdJUnNbGo1k0YfCY9mkSAvpqpR60v
	wz9QD3xbZS7WJ3Mf4DFtSel53ZLYmTZR5IoIx9MFFaCNB1VKYY1T+qZjt8gZWa56zSnO45TilNGhS
	/FjGn0WMaHQdMYpKC1B/FXNtq2MFUMLn13yYdy3Ek+AALclK0zfPQNTY/Q+Eg32nEo/A9bUizhjKf
	BERwmteQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nnEKh-006IOX-JJ; Sat, 07 May 2022 06:54:27 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nnEKd-006ILw-Kz
 for linux-nvme@lists.infradead.org; Sat, 07 May 2022 06:54:25 +0000
Received: by mail-pf1-x434.google.com with SMTP id g8so7998839pfh.5
 for <linux-nvme@lists.infradead.org>; Fri, 06 May 2022 23:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=62kD9X+wL8139kA2shJKwkd5nwt7B2MfA24KVxjQ6GE=;
 b=yYwSN/rBCBxYKUC5+BZW3ZdX1BdUO30eoUNLLvr1vyYb6mRvrlQJAmafcQAS9Zjc3w
 Ptu95yc/4Ss3KvmfvUOAsR5GaWQlmUpy8OnHpD+cfGea6BYeWT5t355syowJA4D4YApt
 imvb449UbIs1MITdPVwjzGCsjJmBoWZbFSms8cuADs8W+D+t+aIVbH/8KGtOW8IKkGXj
 9ZZnlcNL8yLaEg9H2E6AdGJI/BUAardM2g+IIIBIMJf7axZ7AaMvoDtFAGrIOBfeRVtM
 EryRcpk1/fh/UpJGWV1F5v5RjT8OKlN1F+LWF0zghXG0B/QT8V2VwS27q+BZkanHLYaP
 K5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=62kD9X+wL8139kA2shJKwkd5nwt7B2MfA24KVxjQ6GE=;
 b=T2CtYccemE+4QID3dAD7NXxge5goer6qALAh5ny2Q7794F0of6YDeaA3glxO3EhRa0
 mrKwygoI5eLhnqeKqoP70Mfna7kpvH2H0F5ElAMS4ASOWldKu79gYECvzLrAz/f3GVO8
 56xeQ4GmGFrak0xI5/6nEAMzX7AUiH7Ys4lV0mgrRyWq28nvzysVWNhU7VSxh6GW5scm
 U81G19LbBmMXSAv+dPbNgw84h7USRllqIQKkY95+b6RUp0bKRk51FrBb/MnN4Z6fA8+q
 YlQ68fhINouv6qPBOPy5dV3Ld4QAdrFTEA1HOCcX4DeBmMmcy4tb4XKtJo/nYsAwyS4J
 BhrA==
X-Gm-Message-State: AOAM5321wyJfEByBMzQ0Phyy0KTv8hykAMau7OqNCEPwWo+pjtiKqL1k
 6+Bz0WAU/HdlACxWQjaZz5dC4w==
X-Google-Smtp-Source: ABdhPJyYgBXudzKFPcNA5z1FRe7VgLannZcSb2m+r5ktk2pWyLDxleafB+myINFBbbzr4LelJU39XQ==
X-Received: by 2002:a63:e108:0:b0:3c6:6833:9192 with SMTP id
 z8-20020a63e108000000b003c668339192mr2868252pgh.616.1651906461486; 
 Fri, 06 May 2022 23:54:21 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.239])
 by smtp.gmail.com with ESMTPSA id
 y20-20020a1709027c9400b0015e8d4eb1ebsm2905162pll.53.2022.05.06.23.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 May 2022 23:54:20 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: kbusch@kernel.org,
	hch@lst.de
Cc: sagi@grimberg.me, axboe@fb.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 0/3] nvme: enable smart AEN
Date: Sat,  7 May 2022 14:50:23 +0800
Message-Id: <20220507065026.260306-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220506_235423_954470_022EC5F2 
X-CRM114-Status: UNSURE (   5.78  )
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

There are several changes in this series:
- Add missing NVME_SMART_CRIT_PMR_UNRELIABLE enum type.
- Add missing NVME_AEN_CFG_SMART_CRIT_* enum types.
- Enable smart AEN.

zhenwei pi (3):
  nvme: introduce bit 5 of smart critical warning
  nvme: introduce smart bits of aen cfg
  nvme: enable smart AEN

 drivers/nvme/host/core.c |  6 +++++-
 include/linux/nvme.h     | 20 ++++++++++++++++----
 2 files changed, 21 insertions(+), 5 deletions(-)

-- 
2.20.1


