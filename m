Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2477CC54756
	for <linux-nvme@archiver.kernel.org>; Fri, 16 May 2025 16:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gZh28Edm2UJdgHOBmvNfC8bPZBc+tUwKEeZnZHHUt+s=; b=UIT7CZ8T40uZmthaQDqZ2A5/dU
	ow9D4hJaHywvUJKpiKYCsmceyJgjmo4v56cXPg+Z15yP2KsXZ4oL6aXh3ayeUzqlgR81eHRt2rib6
	3xMAHVYtWqMrgFQSxwEOU3q8Yr20anc/BZtHGxFezM/rXyMengfq+/mF1iB6gwGC3ldQv8eVF5SzS
	SOOzAAEESwOgFnMHmZF5AAwSvyqwQw9z8QGDaP7kkyxeO/J+14HaVMTAM9s6mpZFnNUWJR1jtIR3Z
	AnmMexJbSWAFznHGROsN2S3ORlNyIsQpx3Bp5AtMBjsbJefE/fX+RZ64NvoFVZu/0jBxlG1dPauBR
	qgUSZNqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFxi8-00000003zAf-1Hm3;
	Fri, 16 May 2025 16:15:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFxMD-00000003uiR-2GR0
	for linux-nvme@lists.infradead.org;
	Fri, 16 May 2025 15:52:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747410740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gZh28Edm2UJdgHOBmvNfC8bPZBc+tUwKEeZnZHHUt+s=;
	b=hIqrqUIyOad4NMBwDXwKVv/jj1hlgF7wNcxh3AH2hGC5pJdrw7qon5OewkjNUHG+RarMYr
	YNygL9dQWiJcZ6xIY0dNJH+yJfo3PSnuQ4a1yON+gjmdEVXf7KUKxAlNfMqDK2FTtShWGJ
	v9WYhIkPmBN6rncPLOj/mz/0oDHrHN8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-OI6KFQT7NwKiseR_oZpQEQ-1; Fri,
 16 May 2025 11:50:32 -0400
X-MC-Unique: OI6KFQT7NwKiseR_oZpQEQ-1
X-Mimecast-MFC-AGG-ID: OI6KFQT7NwKiseR_oZpQEQ_1747410631
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F24BE195608C;
	Fri, 16 May 2025 15:50:30 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.42.28.135])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C7C1930075D5;
	Fri, 16 May 2025 15:50:26 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	bgurney@redhat.com,
	mlombard@bsdbackstore.eu
Subject: [RFC PATCH 0/1] enable quirks via module parameter
Date: Fri, 16 May 2025 17:50:24 +0200
Message-ID: <20250516155025.44958-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: I3ZqGagPp3sXQZe5a-4PE_f94OhxdtX_rod3AqJfJD8_1747410631
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250516_085221_657874_6AEBC178 
X-CRM114-Status: UNSURE (   9.52  )
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

On some occasions, our customers have complained about misbehaving
NVMe devices. We had to compile and provide them
with a test kernel just to see if a quirk could resolve the issue.

What do you think about allowing users to enable or disable a
quirk via a module parameter, similar to how usbcore does it?

This patch has undergone limited testing, but you get the idea.
Let me know if there's any interest and eventually I can
prepare a formal patch.

Maurizio Lombardi (1):
  nvme: add support for dynamic quirk configuration via module parameter

 drivers/nvme/host/pci.c | 201 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 201 insertions(+)

-- 
2.43.5


