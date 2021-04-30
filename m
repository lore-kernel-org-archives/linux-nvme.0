Return-Path: <SRS0=VOor=J3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0E3C433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Apr 2021 01:07:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94FB861003
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Apr 2021 01:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94FB861003
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JSyfAZMkMxNeH3R8tDbC0ViAAdWDrF9zxjSN6wGlsrg=; b=DUgfB1O2cIrkAK7K+nnREvWTlc
	Zqk3pEwVIePKqDQuuJwWrcdUFeKet5+qfz70Y4Ae7PssGXtmyWsnNt0Brs/Dvyv7oqXPHEv3YMvye
	dRYJtZC29LcL3XsFC6ogo4j8B0DoIoGTndRRRJMWOIpfGQY1JkNTVA9l5mPgEeOaInRLtygQ4+X4r
	1EYCTirW70JS+Nco7sAq832hgUEtcJ6qHuxICnYdcYjIoTPrKrp9qV0t21GW//Pb8R3P7939l8Svz
	17u936NXjMe8xTO/ab9P/29gSffKlp8JMmVDHtv5iiQ+nhq9qUU6GV7JhBU549lKMztdOUvTVh6Fh
	QdGAp/NQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lcHcW-006rEq-Ck; Fri, 30 Apr 2021 01:07:04 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcHcT-006rEd-EH
 for linux-nvme@desiato.infradead.org; Fri, 30 Apr 2021 01:07:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=4KaxQVO0mfZM7m+I2PZlS4oNKyjCIJuBMfO/HAVtKCk=; b=PJ9UylvnRKEP7nARdcUh+Qdfa2
 t6/l650k9Vzct0HH18DHeshIb16cvsyEhZUwbSNw80gzuuP29zE2opK411klnfeM656HljE1W1P0J
 sBWCOgqxxj2J7q+O292FRCbfMV84rWr03tpWzYnrY85yKpgwGrpnBoSWMOIx/PedbyYJAfPCY3SvZ
 sa6q3BjtBdzw/4IIvAO/39xOuaWBBNDUs4ZHQYCDZ6+iUmxqmcwygAkdNYEiMNCRXxL3CeM26p42M
 x0dUc5yahR6r9lL3vZi6kuquYeEe0JOEg+AexJafdqU7pc7RF7yRH17ijVVvPuy/pfJmrSl6nqZoE
 BwkaLUdw==;
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcHcP-0013XU-Ff
 for linux-nvme@lists.infradead.org; Fri, 30 Apr 2021 01:06:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1619744817; x=1651280817;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=cPxFSiNFOhiGQyz/6s+cYse5wlGmqvnnFBtdWE8ZLYc=;
 b=fPeMOWN1hBVfzjqVq1SydgyXP6tzZO7H6+XI6hkSdmDDnP1eYJpsqyaD
 v3HQE9eXTek9+fo5KTGPux/VQFOyGagyMx0mRQ3+VrRkjXHkvNyjE6hku
 curgVwiU8aDn9jKco0zdHdpDpqo+fDT0vohnlnPiVgOCTbavAYe/WyAun
 8LxR8WjNtEkgBkoZekP6sYCmRXbb9VTphR7VgGzYGYfa5+6aun2J917Pp
 IyvfIclyTvuQsXXX0YqmHHHhGBIhadBbL9bWGVrJwNsauIQwKa7juhLnA
 mtocr6sRiOe2GTFMiLtPemBOrHGUPMQvDEfdLYEynDNOJj2AElcdU2WdX g==;
IronPort-SDR: a01YCILVJo3/gDe/dvHcs+obI2oXcJcxX2BCOER5ef3Al37H9bEo1yfE5WfzExd4O4osx+egh1
 BQpKNmQm4Hrd4kL7riceNlojDK679w8PY1rznP7iErTv2AnqHrnUoGZ4Fi2/uvASgRS2JVXLQQ
 W/rGAIxgdHcUTPx6jxj7PxiIVLsKZIjK8dhZyqQoxlW8Uyv+qxpj60s9dyhJVAZA+PsJlZAEcJ
 xTCHAZyppl9nEt6WNKd2P8MA+J9h7pMYY4unLgZ6u72gT+CnbveIiOdE4ugJGf+keE3+6W9C4C
 SL0=
X-IronPort-AV: E=Sophos;i="5.82,260,1613404800"; d="scan'208";a="277776914"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2021 09:06:54 +0800
IronPort-SDR: wi229Kb9jTwTV5o/XggbrnYKnVAojudlXzvsbq1lKHDxq0L1GEnYI1nz9sNQG3yBqM382LJd+i
 JAWPmhW17qokCEYxcgXQdp0oZZReqjfKAasQnslWr9k7bRln2kxBMW362IXJvvr8CzN7/RApAr
 J/RhlcmN4ME3A16sfqlpQgvTmJ3794y6zyQoazb4elWkMXjVQMx+25ErgUzWJaqO7/SIfSwHji
 TyXhrVxajRJhtlQ/RhMJt2DkWdy0cRXdmIsxjKFMnHuoBLCx1oiKjgRRSePDdoDyDEXZlmU0Cq
 iTwVwZEpgQZooufOP7/VAjpc
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2021 17:47:12 -0700
IronPort-SDR: aQtt6fdQZ+0GE+1oVhQZt9H2ajFIXGfNrnJ9XjxSOfEFq4IpWt6P7+Jr1t4+s5YJ7wqAQD5UwT
 6FTMCOGTjB24N0MVAVdFHgP4n4oyyR7tZI5xbgZmRFtgoFyo/gTTrWF5yzAnbkBJ9PzfvdnR5N
 /79lAGUvCJJm/IdPvJyXjnetzbrCh+vCTSNempwrGhWb4e/Vz0YWf8Ay6uDwnNKwVLGvAgI/wB
 T6lavZaHrBuV+Hw40E8swuP49mtnqsZEPDe3LkBS8ZscbGrAP494QK95uhQ9bF9enLLYuE3lY5
 cWE=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Apr 2021 18:06:54 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, kbusch@kernel.org,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 0/3] nvemt: demote high frequency err msg to debug
Date: Thu, 29 Apr 2021 18:06:48 -0700
Message-Id: <20210430010651.36736-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210429_180657_570350_D1E8B365 
X-CRM114-Status: GOOD (  10.55  )
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

This is on the top of earlier posted req->sg_cnt series :-

http://lists.infradead.org/pipermail/linux-nvme/2021-April/024762.html

-ck

Chaitanya Kulkarni (3):
  nvmet: demote discovery cmd parse err msg to debug
  nvmet: demote admin cmd parse err msg to debug
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
