Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06AFFC54E5D
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Mar 2024 17:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FctEd/2r8qhOJ/Yl4ALsrHJsjW9t84FR5kKKuBtTuoQ=; b=tg2XTiJ48vn4IEHbZkSJrgYlEJ
	FEeA7gIHwyU1+JUSqQBYjuR990KpzeEzVZ3itMvriRncIM/cmJIB4LJbxyck5O40q4j9/amoAljZE
	gMz0q39BKBO6Zft7PIa99g8tTOaJ7kTYw6zAY0yave8FARsVj28r4d6fQWvrijjTX5zzsSEM01nUd
	s536jOTe0B9/PePPbZBwY0pabqqYwJTihvu66zdM5DKZ3qOyzEhXirEg738WU+6gggtIBqyehi4SX
	kv9ZO4nxAKdDlKO4v9v6TGkT9NPxZyecip8XYlrktfHYrN4CU4JCGkTi5WR4qXDE+gzCxH2YEeuy3
	k08B4p3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk5V4-00000006hu5-22nV;
	Tue, 12 Mar 2024 17:01:14 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk4NR-00000006RXR-34Xi
	for linux-nvme@bombadil.infradead.org;
	Tue, 12 Mar 2024 15:49:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=FctEd/2r8qhOJ/Yl4ALsrHJsjW9t84FR5kKKuBtTuoQ=; b=f0JlFoNu+ARGz0mCOcPJymXmlJ
	klEgo5d0P1v3r9qpXgg++v6euC1fgQEhMQrRDi86YJ1n2QIcOXTDJ/YNT7QVERsJvir5X9MWibFDh
	g11RS67KPkXz+wR2WXJcZAjdd7HKIX0XwoDA4pRV4CgV3ubG0VEFCDGIypwM+Gh9AcnO13SrAKXOx
	TBqL5OWW+70jxMgkWK8m+1b8mvO1gBf4aCvhOR3tJyhaiPPqOVBFht5NUsH+LGSfSNdb3PxkTWEzJ
	qyjK6sCh7YEI8KPhxzX8zUtEgU8M+KfqqkUD1WtlkBWt9tdtiHZS1hfQ8oQfMtjyZTSgNef07wsH+
	6gVd7t4A==;
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk4NM-00000009Wzv-2B3y
	for linux-nvme@lists.infradead.org;
	Tue, 12 Mar 2024 15:49:16 +0000
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-33e17342ea7so2519870f8f.2
        for <linux-nvme@lists.infradead.org>; Tue, 12 Mar 2024 08:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shadow-tech.20230601.gappssmtp.com; s=20230601; t=1710258548; x=1710863348; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FctEd/2r8qhOJ/Yl4ALsrHJsjW9t84FR5kKKuBtTuoQ=;
        b=Vj0sySsr6ER+68V7aHjUaj2Twm1YMImTAsiv7eUww/WpAQoZjL1Rvg6jn0hLUzPZX4
         Vp0BHSDBL8+bg5KPXG04m/dNKxM5jD39I4HLgwgWn8NjXRkEDih6ctznsoOPnWsYRLaF
         VmHqv9bEM8Tkub2BEA72v9f5lIyBcotgms9paQa1BNqz5CbvxPAFsv2eSwKIxQkV0RON
         A0M/a0htoE7Q7sety9Ctfsmlb51Ji60ijgoHu9bqGfE+OKTzMcM3HgsXzaIWQlQ8Duxp
         mlyL3ytqt1neRcPXNIBKK1JSQqQrdJ6SQeGJf17l4OCGIztgNRNeGD3F5Q6qT/CtUBlF
         ATjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710258548; x=1710863348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FctEd/2r8qhOJ/Yl4ALsrHJsjW9t84FR5kKKuBtTuoQ=;
        b=MQ0/dDR6c1vLHAqQW3WReurVpGgD8NjNibkF4A5GsYc6uG8A7Xby97rROjCdhxDCeW
         SOKMyGOGm2/+9hMPlehTCRU47eIcoZaoJO4nOs1z8wRCwdNRDDQFsjoreErFIISxHlsI
         laCyA1TqB87OxVIzopQOd5oZDjOPDf5KmvDu4XYkzAvM/rqm458X7wtxhOb5b6c92A/3
         BmVa09usK1HUWRYRruO0HLQbwu3CQupQ1Rlgow0z4x7204tC5z1dhxAIrKyByoPCDORp
         JGbiJW0oFu/+51puOcMb/Du8yhrJ7f6/Y/MywikQjtkqVa09wtRYcsGgOa1ca/i2AIUL
         dAog==
X-Gm-Message-State: AOJu0YwVqoDmFoojyHlOY7IJUv89yWr/e6HgBh9nnDQNJY92CRAhnXUd
	U9bkXmDD+y/Jpo+hRZoEEpGAF8MyyeWnhWx/AYpBY8er+TYb67QgfQQlKGQPW/q4k9BXAOuyw99
	PiXk=
X-Google-Smtp-Source: AGHT+IGhmr4YkiC7MT60OT+XlblykljAR3Ad7/rhe1ebQejNzKmaVPTNqYQMbrSRcFfms7KbbRIONQ==
X-Received: by 2002:adf:e5cf:0:b0:33e:9dd5:97cb with SMTP id a15-20020adfe5cf000000b0033e9dd597cbmr3100401wrn.57.1710258548300;
        Tue, 12 Mar 2024 08:49:08 -0700 (PDT)
Received: from localhost.localdomain ([185.123.26.202])
        by smtp.gmail.com with ESMTPSA id c17-20020a5d5291000000b0033d2ae84fafsm9284607wrv.52.2024.03.12.08.49.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 12 Mar 2024 08:49:07 -0700 (PDT)
From: Redouane BOUFENGHOUR <redouane.boufenghour@shadow.tech>
To: linux-nvme@lists.infradead.org
Cc: kch@nvidia.com,
	hch@lst.de,
	sagi@grimberg.me,
	antoine.damhet@shadow.tech,
	valentin.brice@shadow.tech,
	pierre.marsais@shadow.tech,
	Redouane BOUFENGHOUR <redouane.boufenghour@shadow.tech>
Subject: [PATCH 0/1] nvmet: View subsystem connections on nvmeof target
Date: Tue, 12 Mar 2024 16:48:45 +0100
Message-Id: <20240312154846.45099-1-redouane.boufenghour@shadow.tech>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240312_154912_758120_64875056 
X-CRM114-Status: GOOD (  15.34  )
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

HI,
We need to list the nqn and their IP connected to our target nvmeof server.
In fact we can have several dozen connections on a machine and we need to know
which server is connected to which subsystem.
Currently there is no way to find out which machine is connected to which subsystem
except through the nqn.
The nqn can be modified by the initiator , so for us it’s not necessarily a source
we can trust.
We previously sent a first POC that implemented the feature in configfs ,
 this new POC introduces debugfs for the nvmet driver , this one displays the ctrls
connected on the host in the /sys/kernel/debug/nvmet/ctrls folder , each controller
displays the following information :
 - hostnqn
 - associated subsystem
 - IP address for tcp and rdma modules

the first patch sent is here :

https://lore.kernel.org/linux-nvme/20230920141205.26637-1-redouane.boufenghour@shadow.tech/


Redouane Boufengour (1):
  nvmet: adds support for viewing which server is connected to which
    subsystem on nvmeof target

 drivers/nvme/target/Kconfig       |   9 +++
 drivers/nvme/target/Makefile      |   1 +
 drivers/nvme/target/core.c        |  18 ++++-
 drivers/nvme/target/debugfs.c     | 118 ++++++++++++++++++++++++++++++
 drivers/nvme/target/debugfs.h     |  41 +++++++++++
 drivers/nvme/target/fabrics-cmd.c |   2 +
 drivers/nvme/target/nvmet.h       |   4 +
 drivers/nvme/target/rdma.c        |  11 +++
 drivers/nvme/target/tcp.c         |  13 ++++
 9 files changed, 216 insertions(+), 1 deletion(-)
 create mode 100644 drivers/nvme/target/debugfs.c
 create mode 100644 drivers/nvme/target/debugfs.h

-- 
2.39.3 (Apple Git-145)


