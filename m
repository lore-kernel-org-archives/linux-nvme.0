Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBC1C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 11:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RuFHOgyzqcPbc3Qwrt9wENv5qThGkhtjex02TUhCVDg=; b=C7Z7wCkBJYU2iC4GmVsWHBiPiE
	uhQ0f8c1utSX9bpe0LE0sF7mhiZo6cRLZqWqjGxIKQjllX42TCRa33za3NJA+BMITTWXfrHFhjShs
	ykzNk5bcAckstID/lzgKXKa5p+OsMitA8ULQ81Se2J2FRVPd5C6iE1JYzDHS+mqKU/w0F8OeiVPhZ
	OwQFSuelmONuAnMtfYkjL3VHRTs3fGT1TSxelr56PaZcBEE7ww1jewHmTyWgIoevGFhZ3ZekicM4K
	zSEnltIdiPWzVceXTSHqIT4ACdiGTEEB/8Q99BEHbsz3xz5seJBCIvl31rkq6yIjk7vBVgIBTLXFt
	wIgSbqzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouuaK-00Alzd-K1; Tue, 15 Nov 2022 11:58:36 +0000
Received: from mta-02.yadro.com ([89.207.88.252] helo=mta-01.yadro.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouuaF-00AlsD-9b
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 11:58:33 +0000
Received: from localhost (unknown [127.0.0.1])
	by mta-01.yadro.com (Postfix) with ESMTP id 03E57403CB;
	Tue, 15 Nov 2022 11:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
	content-type:content-type:content-transfer-encoding:mime-version
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received:received:received; s=mta-01; t=1668513502; x=
	1670327903; bh=Zbv029xlAV98nG4y48/TUkdb2Iwpk/eG1VWgttFTEBQ=; b=U
	3nhutCGmdTTRbE/6Z9ULrJSYc50uT+GTnN05scHz/Y2HRa19mTsYvFBSw8suRNFx
	lsnJA9Y2c2JGbKGvH9/2j9X9D+VFBnKKO6FveH02mVXLNco0qVxF6tQ9j+T/8qqa
	Orf1eBt/XIDe+ph5lYSGwGmrwxknMZ1WaW7l2E644I=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
	by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RHtNi5ZaN8wL; Tue, 15 Nov 2022 14:58:22 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (T-EXCH-02.corp.yadro.com [172.17.10.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by mta-01.yadro.com (Postfix) with ESMTPS id 0EF4040354;
	Tue, 15 Nov 2022 14:58:22 +0300 (MSK)
Received: from T-Exch-05.corp.yadro.com (172.17.10.109) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Tue, 15 Nov 2022 14:58:22 +0300
Received: from yadro.com (10.199.22.87) by T-Exch-05.corp.yadro.com
 (172.17.10.109) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Tue, 15 Nov
 2022 14:58:19 +0300
From: Aleksandr Miloserdov <a.miloserdov@yadro.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
CC: <linux-nvme@lists.infradead.org>, <linux@yadro.com>, Aleksandr Miloserdov
	<a.miloserdov@yadro.com>
Subject: [PATCH v2 0/2] Allow user to set nvmet firmware revision and IEEE OUI
Date: Tue, 15 Nov 2022 14:58:08 +0300
Message-ID: <20221115115810.75848-1-a.miloserdov@yadro.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.22.87]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-Exch-05.corp.yadro.com (172.17.10.109)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_035831_899426_C2A3E1C5 
X-CRM114-Status: UNSURE (   9.31  )
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

This patch series introduces changes that allow user to set nvmet
firmware revision and IEEE OUI via configFS.

Signed-off-by: Aleksandr Miloserdov <a.miloserdov@yadro.com>

Aleksandr Miloserdov (2):
  nvmet: expose IEEE OUI to configfs
  nvmet: expose firmware revision to configfs

 drivers/nvme/target/admin-cmd.c |   9 +--
 drivers/nvme/target/configfs.c  | 112 ++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c      |  17 ++++-
 drivers/nvme/target/nvmet.h     |   3 +
 4 files changed, 133 insertions(+), 8 deletions(-)

-- 
2.38.1


