Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF3BCE79D3
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Sep 2023 14:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+JtjisYB0xAp+OgRCE1rW+1dvX+rDqcJ5WtO1SkYC8Q=; b=ht6407WP0KABIqALihLIjvGbwu
	NJf7WXu3UOvNojhGa81J83qQIsd+P/Gz5vPSvZPUIa1nP4LziIZkk4Qw5IMQ07szKLJPXYawmaZO7
	q7Z9bVhiSnt2eMpBRXWKmJ/gD07gIQmFDWf47hsKiL5/TB74ev4iwqGgEe7MZrUrVAo7igmNR9cK1
	i/fdLmI/976klsnCpJD7f8tsNKo6FRumsvAx3b2daNjGDS7VB77IO0aAksdZWsmEAT5/gqJSOzUot
	Cop1k9gqL4d9U6RXedm4PSemjhlMVUBbjBIxmfGva/c2z/53SxN+aBXmydmMH1g1H04G/kLIN3/ft
	ODaQIW2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qixwI-003HxM-1I;
	Wed, 20 Sep 2023 14:12:26 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qixwD-003Hvf-0f
	for linux-nvme@lists.infradead.org;
	Wed, 20 Sep 2023 14:12:23 +0000
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31fe2c8db0dso6108098f8f.3
        for <linux-nvme@lists.infradead.org>; Wed, 20 Sep 2023 07:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shadow-tech.20230601.gappssmtp.com; s=20230601; t=1695219138; x=1695823938; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+JtjisYB0xAp+OgRCE1rW+1dvX+rDqcJ5WtO1SkYC8Q=;
        b=rK0hGmi4pAVHzwp4qyVcCw5uUp2EbY8aGQSoTse3ByIlW72SJGwVDL69/KdIS4fr3d
         AVquhHoCRNs4V6lh9c+wyxQEIHIqUN7k/inzx3tCFFIiyRRVf1sssX66khxNs1fRiHT5
         YLCnFp/NXIaJpI0LwnPOntXIRjQhJPwf2Eb5kWSWEqvwco4owf67xk1iZDcuYVrY34Gs
         HACMDtM+29PIq8bD3akh1qjm7C+M0RWN1D+Re1vbBSHw2hlG5LcMvHAZRH8rZlCIF8sl
         5Zh2jAdRl/ZGJGDuyIVi0FC7FV/cBA853+X/KJpPLnlT1qa4TUVkM+l4ZlZsTjFOCA0W
         3bkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695219138; x=1695823938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+JtjisYB0xAp+OgRCE1rW+1dvX+rDqcJ5WtO1SkYC8Q=;
        b=o3Dq3RPgYAKKoOFSygUV2V/h8d/M0IhDI31H4uwbpLwxr2QtcGD4AgnMz8J5KfKkE0
         vAX1QI5a+u5EDju1beQ5cA55l2c4rcHmwie3G/q9XFA6iDhx9rZr/8d6o6OP3Rm9AqiY
         0hQhO19opnIjDNK9oHMO1CW9OX3cjwIFkNZ51yeFfoZ2wzpoGLFH34TAJAcWLV+2x5Co
         lWGfSHbe2ViHf34vVl9b84AFTlSUXhXge7BPhXZU06SOC9gfifJ13b6H8RDYyoHMcl5f
         HpitFk/pcYPvp0sfClmfeSQjaDYrsc/ld6SBbaJww3OPhGSAKhPqyMz+/Z7S7ocKWrCx
         1j+Q==
X-Gm-Message-State: AOJu0YxVQa/XqW9QNvZ+Hta3QDAjW6iX7Gigj/T9TyAe7AfGUveDM64T
	c44PdMtHOiiH1CDyEYQfvbo/55Ul+uGahRiZcFBZDnWU
X-Google-Smtp-Source: AGHT+IEhk3JxekOWfmFw0uEK6+Oxu6zZHQ2DVsxIfGj4m0zm0w76efNQRXMeHyKQDPPh4Gp0/u3xIA==
X-Received: by 2002:adf:fdc6:0:b0:31f:c1b5:d4c1 with SMTP id i6-20020adffdc6000000b0031fc1b5d4c1mr2603932wrs.35.1695219137934;
        Wed, 20 Sep 2023 07:12:17 -0700 (PDT)
Received: from localhost.localdomain ([185.123.26.202])
        by smtp.gmail.com with ESMTPSA id r8-20020a5d4e48000000b0031ad2f9269dsm18297263wrt.40.2023.09.20.07.12.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 Sep 2023 07:12:17 -0700 (PDT)
From: Redouane BOUFENGHOUR <redouane.boufenghour@shadow.tech>
To: linux-nvme@lists.infradead.org
Cc: kch@nvidia.com,
	hch@lst.de,
	sagi@grimberg.me,
	antoine.damhet@shadow.tech,
	valentin.brice@shadow.tech,
	Redouane BOUFENGHOUR <redouane.boufenghour@shadow.tech>
Subject: [PATCH 0/1] nvmet: View subsystem connections on nvmeof target
Date: Wed, 20 Sep 2023 16:12:04 +0200
Message-Id: <20230920141205.26637-1-redouane.boufenghour@shadow.tech>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230920_071221_442999_D2EF5853 
X-CRM114-Status: GOOD (  17.22  )
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
We’ve created a POC to retrieve the nqn and associated ip when a client is connected
to a subsystem.
We’ve tested this poc on a tcp and rdma connection and it’s OK.
For the POC we write to the attr_connected_ctrls file in the subsystems directory for
each subsystem.
We’re not sure this is the right implementation.
Either we create a ctrls directory which will be created on the userland side and
populated with information
from the ctrl connected when the ctrl number folder is created.
Or we use the host directory to add an entry when the machine is connected to write its
 IP address, but this folder is also used by ACLs.
Or we stick to a simple attribute listing all connected controllers nqn and addresses.
That being said, given the reduced size of a configfs page and the large size of some
addresses (ie IPv6 address), that would drastically limit the numbers of controllers
and addresses we could list in this attribute.
what do you think?

Redouane BOUFENGHOUR (1):
  nvmet: View subsystem connections on nvmeof target

 drivers/nvme/target/configfs.c | 30 ++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c     |  7 +++++++
 drivers/nvme/target/nvmet.h    |  2 ++
 drivers/nvme/target/rdma.c     | 10 ++++++++++
 drivers/nvme/target/tcp.c      | 13 +++++++++++++
 5 files changed, 62 insertions(+)

-- 
2.39.2 (Apple Git-143)


