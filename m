Return-Path: <SRS0=GcL3=KF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A946EC433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 19:16:05 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 697D361139
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 19:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 697D361139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=18iHHLwnyGDuweD5+e/vqMW3Q8Hyn6ET76UO9MPtUwQ=; b=AUN4zswAU1mTik4/gM1eefUaPq
	bE1rvAG0ypZAaxLK/Y6RESw7nSo70Nqe9EHc28DQoDIHoZnPMsXwhnMuKn44JclIclZ0DhYnaaEWh
	FFDRoDNvyIEkTaBHwIZ04HxB5B5BTics4jPHMLwDcGjtv7VfE77spWNxuuAD+9YbCTq17dSrMeira
	xfV6B0Vg18sV0KA8bQvM/ILvPhFpeSa4expKx7N9VFFoAFgC8AMAFhVjjwGhXt4LiV2CtvT3eV2Ca
	AsPWPM8/G7TxYKneycYH0btZpEM243F1ATl4luL1arZDmgt8sKWTZ3P1w/gi+xQPbohcamTkRh1wc
	ukZSeOiw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgBNc-00FWTZ-VR; Mon, 10 May 2021 19:15:49 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgBNa-00FWSs-Au
 for linux-nvme@desiato.infradead.org; Mon, 10 May 2021 19:15:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=5eymwENYXG5B3zyVlGbFdWkDQw14LA82xe8Vwrlf12U=; b=sLF5JUXW/N4/GffVIyyrFckFGO
 jcv9SWcXt6/siGS3j17H+DirK2eoXXEIclYjgLQ6nQqH+P2mvbAwfeTFqOBc3YILui6iYYEb696RV
 kSnnJjjO0p0LC75ZYZZkJS2sTkIUUGaQTjy3na9FqkY7vKhYvimkp59QPryCXemEXZ4PI02uuCJu4
 dF8JDduF7Kth3bCdZonFls+bSARJCy/+CyJWBJEWpi/XVrB2med843lap76ZKC7HEcTSY2MVsihNp
 CZEFoDSlesKtP9BAqCq70nIzai3Fhp/+0iqmbmePYozZ0+dZxeix5GRZwt3Zn6jKQHOR5FZILjVfl
 h1FqYk3Q==;
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgBNX-0093sw-Ao
 for linux-nvme@lists.infradead.org; Mon, 10 May 2021 19:15:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1620674143; x=1652210143;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=P/LM7qia08/0THbdh0sYSZ23LjAPcO0x0AvkVMjaYf8=;
 b=RjPkV1Kb4R8qZmitnHUgf2o8YHJOjaL08+VO4DZJ7QLnuOUfn+uEOSFH
 78/yNnszmkN1+x/3Mld7lbU6229CxSNUGsYkilP8+MyRAsFOujtQoNqw4
 GiOILLYf3FEkVl5ex7ia20DIVkLQ+KrjBODkvQHM+ayOMG8u6FnOvzjfO
 AjXvGGr0kAPTVWbWVryCy6Om5ZkK8KSqmutt1GPHzZ9mbsyLA7IFemjv1
 o72D4iXiFXHs/rKWpefh5n3/LgvU1ardiWdx5bBDsD76goyit1xF3E3xx
 ZNs/DOsi2IcIc/mMprTTSq2XVsg5gn8vhIFWiHKALEdlNYWrtG1qYvH/O A==;
IronPort-SDR: AobQOOV4fXG9/INZTcWiL2kg4hCyP1gI1GVMqAqme1M+IgKv5IhDm0rjJtHuEuww8EbtplEyyx
 6kJxxdYtqlGWdMNaEqXNBzGIC9WG7Cb89UpzRsbAD1fVpDAP9UpY6tMpewL5WNrjytU6A1uhV5
 nHkzijjLyd9n1SmMpZOiPufTf79gkdyltM+U+KVg/FevNbq6BGTDysGr2Ya4F7pLxWjJ9xrTss
 sPB7hN1OrVaBmtqhP7xMxcMuhVc1GZigFJN3tXcu9g8bx7gHkXh6BAZo4JXC/p2R4mtx2bI1hs
 GC4=
X-IronPort-AV: E=Sophos;i="5.82,288,1613404800"; d="scan'208";a="168207424"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 May 2021 03:15:40 +0800
IronPort-SDR: RX2PtCwjOdlGZetmgkgkYkxhU+WkU27zS2k9r/3bYZQ54TiCQ5xfNFdq/ukQr1opBFF/YLt7YJ
 OuCiGCYSN3jTVHjgA1jWqCmtmiHEyydzpuvj0fs5skK3FaN0keqODu6gX9+eoHSyrAWWSdoLUA
 vOx61cABgdIGhiCMP2etFS9mSmsj3a8d5t24tnYzFvp4ZHoxFfsoxAN4E248tOW9b80Uulq7nC
 6CsYQcs+YL3rizhrYsrfoG5uayilUtK2r89p8MbzJgJeL1THNJ+SFpa0SkEqZh7MzKQGQnxry9
 zuAO89IUSkd7VUIECyZ16dp3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2021 11:55:39 -0700
IronPort-SDR: smpJOYtqfbgD9Btsj8k+NFCZVYFeSCd0+S2VEzaB7qkfLFn26I+db6ESJbP7eH8AB3hzvqURoS
 yPNf7NLYHzG7XGVDpQlN3N8wFwHZN0R8o4npiUXPVfezuGIbE1vbVfx2nxNg6GWzxwQi++Kt48
 Sj9nSpeX84OzOo54Zjsrof97gIodLccQwvkXiTe0hNnrV/nbpS/Z+Se0uDH8eynWg+V4y/pQDW
 opd/Gkj1IFtdo7U64D8xgQXPL3k2bjOUOAl2QqKUU0hG1RMX4scKhfA8sFWhdj08KFlmP8pJCn
 MwY=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 10 May 2021 12:15:40 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 0/3] nvemt: demote high frequency err msg to debug
Date: Mon, 10 May 2021 12:15:35 -0700
Message-Id: <20210510191538.38306-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_121543_924902_600F262F 
X-CRM114-Status: GOOD (  11.88  )
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

Hi,

Based on the earlier report for the unhandaled error messages for
command parsing, this is a small patch-series demotes the error messages
for various parse functions from pr_err() to pr_debug().

-ck

* Changes from V1 :-

1. Rebase on the top of :-

   commit 2869ad623d7df02dbc280744b879ca6e23ad1fe4 (origin/nvme-5.13)
   nvme-multipath: fix double initialization of ANA state


Chaitanya Kulkarni (3):
  nvmet: demote discovery cmd parse err msg to debug
  nvmet: use helper to remove the duplicate code
  nvmet: demote fabrics cmd parse err msg to debug

 drivers/nvme/target/admin-cmd.c   | 7 ++-----
 drivers/nvme/target/discovery.c   | 2 +-
 drivers/nvme/target/fabrics-cmd.c | 6 +++---
 3 files changed, 6 insertions(+), 9 deletions(-)

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
