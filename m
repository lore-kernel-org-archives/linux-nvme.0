Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709FFC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 00:11:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1525F22CE3
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 00:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1525F22CE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FWC8DlxBGysFudRKEogl4/GKmsmQUVvlPSfdCVNOjgE=; b=M0rOkRcYvTYafsn4TMAcPXJVue
	CQ96fS9mgj/w1XDSGUyQga0L6ojqX1ygJcTsWOfIDO75Rzbm6ShofmPe4f+ZnJs5zh/ncrh7n/mFF
	fVK7NtaZksobWy3sm5R1GJ3lZ42Bw3b3//9M208yjUac926bS8Z5eb0LHfzsq10ai9+PczYLjXxBW
	Kpoh5X+s7qjltSxYTbkatKQYgxL9QgCX1Jfoix1nhVmOurmMUk2CgBTsOKgE7+yr/nDI8MYz7WSXU
	YXfQcmfQurFWLkWE7m/e3Pt2Mk2v0fGe6vfaejM3z8Kaunyyr2s7EYuV52rWZuKH6raky7ONVHwgS
	WCZ6RY2g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzqDw-0005Us-CL; Thu, 14 Jan 2021 00:10:48 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzqDt-0005UN-AS
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 00:10:46 +0000
Received: by mail-wr1-f45.google.com with SMTP id a12so3945350wrv.8
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 16:10:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4UyFY1nM+5p0PY71ZTGURwVuIMdZLOa7Jbcumvhh8vQ=;
 b=ResY7ql2BYdOo8pD405cz3NBCzcrKGgLIl21+0kvJFWspRMdwJc/ng1kZEc48bpII7
 /bRpZx8mulCpGPtJ5rnhAwgefQIY9lNi50WVPumjvM73bXI8i51oH4+oRrvWOOKET65K
 p+t30Q2eRJP3TDteF/fkrz2V+fS1kMiwyaGUpOYetN3keHEBzpERk2KW3/jdQuFK7JFt
 apRy8IZoIqsDAsVe06cuRhFx4erYs7xLv7XR2pHezfrJ6Pfy312kGvvoBW3dbomX4hpN
 UM86fWWkROBZlmk6ReuowDPP80s1acIyUKa0u3u5Kgez3fZ6lcrmCe+xirt7ZEFfqYp2
 YxDA==
X-Gm-Message-State: AOAM531Gnmh4eJCH5aTkbMNI8YqnANh58gdaV1YVbaAhWoLJmYCj7jYi
 JSMnQYGFx1vpmMb3YQZI3Ag=
X-Google-Smtp-Source: ABdhPJzOwVrGz/HGdxOBcoxjYllZY6WALx6xzfPDDajlzGHviJGZn16//D8IaVPfVAOAqxXqt5ZpqA==
X-Received: by 2002:a5d:5146:: with SMTP id u6mr5025413wrt.46.1610583044287;
 Wed, 13 Jan 2021 16:10:44 -0800 (PST)
Received: from localhost.localdomain ([2601:647:4802:9070:e70c:620a:4d8a:b988])
 by smtp.gmail.com with ESMTPSA id n3sm5370874wrw.61.2021.01.13.16.10.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jan 2021 16:10:43 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/3] few simple cleanups for nvme-tcp host
Date: Wed, 13 Jan 2021 16:10:39 -0800
Message-Id: <20210114001039.1644461-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_191045_376700_0BA8F432 
X-CRM114-Status: UNSURE (   9.37  )
X-CRM114-Notice: Please train this message.
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
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

No real bug fix here, but some useful cleanups.

Sagi Grimberg (3):
  nvme-tcp: fix wrong setting of request iov_iter
  nvme-tcp: get rid of unused helper function
  nvme-tcp: pass multipage bvec to request iov_iter

 drivers/nvme/host/tcp.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
