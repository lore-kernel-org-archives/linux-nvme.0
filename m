Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2820AC36002
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Mar 2025 17:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ctadz2xKQCpKUc3wGqIJ+O5JBzWadtIRZJlRi1iw3R0=; b=oz5/f62CuZcrA6F8Dkmb5nw71a
	SVWTe/WR8s1vPz8Kmgvc3a7p3xsk4XvCquisJx/nGHOSBZ1+lptr4c6a2SMaO1/f+eCoh35WPS67O
	QIt7GQzXMzBwImp3Gel0BBUhH9knHm+LZ/vcErCa5UURMHnQ7+7Q8TiVy5C7QiEwR8BYVlqYxwlnP
	q+GTbDml4zdaM19H83R4LBxWzmsq+XuE9GQmoG+nrVzD7gmKA7RJVAyx0hTrXdydrpKZi9rXkvU+n
	udqHeUHwhVPmA270TXQ0ocvHYkKaRBSRBGEWcsXjGtI08ja6RmJ3BRRlmDVbCO8oyhDDTRT3qWpZH
	oqiFxpPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1twlva-00000003rFz-1XIe;
	Mon, 24 Mar 2025 17:49:34 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1twlvY-00000003rDi-0ZAh
	for linux-nvme@lists.infradead.org;
	Mon, 24 Mar 2025 17:49:33 +0000
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-3014ae35534so7276350a91.0
        for <linux-nvme@lists.infradead.org>; Mon, 24 Mar 2025 10:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742838571; x=1743443371; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ctadz2xKQCpKUc3wGqIJ+O5JBzWadtIRZJlRi1iw3R0=;
        b=gxJCVFmZXDKtyH/grOhKLRMMl7vj8VNn7kSGsYS98Fju+7n6ATr+G8ZJyBjVwQV2IY
         FYwx3gjsaTsCu/ztC1T0J13A/bFuVV+cAPhrbnVBaWh8Bgv5KiJwcCL+gXBA9l4fkqKy
         ooWWjbNLva3Ilh8mm7rleU2Q/qUXVM6WjjR+aff4Ecd5LOWMC3aVNf1EGC3YiOagFo32
         /52GbKiQ2fXYUQOZDqAZyS0jcdTmPxZeP1iWeu86dnrA+tfktpsx/q8KHz3GZu4qkwET
         kzCcqQRE4pML/gXQxCwrfk5U3raw+IHybobW86KW2n7s7wDBa/mKzeALbRrqwGB6CPwL
         NFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742838571; x=1743443371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctadz2xKQCpKUc3wGqIJ+O5JBzWadtIRZJlRi1iw3R0=;
        b=qYMA4kCK/ZkNJrqx+FrJH+YzmUfCLMLo/plWqU7bIjy/KEd445SoZNwbzlomaCnuVE
         HF4dAgP534WL+gdvbRH1Bbl6tXFBuFdk3fijd10uUoU4Y+h137hISGZcdFp/7Oyw8rEe
         9+ll+vHO9YXey1Oazu1JWcud43jy0GdC7BcTjVgsCFGI9aBF5vWlRUHx4LOQ3o6Tco5N
         ELJr20dhtRwki6FHgLJHw5atnj5RVsfAyld73/Wt+eXJz4CHs8fvX+hJHQK9/FZtrd//
         0Hi7uFL2J0nam7UMXatNnh0dD5P6YX30YXwQvGiiJ06MFcHK690W4y+mcLzeJX75uo1S
         Sm0w==
X-Forwarded-Encrypted: i=1; AJvYcCWWPjT9kvkxtNykRzV/RakuicYQShTdOiriFGq3wiTwl5VmHRT0R0GNgHw6pHDc2+oOhJGYWitY8D0A@lists.infradead.org
X-Gm-Message-State: AOJu0YzHfmSUMt/ZvUbVGT/5TdmRrg4bdXI0eM2+hgpy+xGQmEMCTejz
	1SZ4Jaq6Y04/aREBQpQmyhoyUlFq8wVI2WIu5KbKNtzqXHEfQtMz7sWB3ri2VL0=
X-Gm-Gg: ASbGncuR3fDSNr3We9H9KI560XG44iKwQp/kRaeohcqbjmyeKHU6LflQwIpUyFHywD0
	YzN6gqlP2oOi3zV8L2RAsJP7Velw4offCekoBkWnIsHzk0+Fu4IhyQLKoAVCNmYG1ZbkHD/fOp7
	ThpHjI2jPs+ytqTIrvB52ULFDQcWHI+ORB/W3G/VBrTwZmkIe18LVkmGDs184IxyOcloXtaHOvy
	N1UiMCjaDbsPJqpyhzthIgoBZM98LhhgP1/8TdaICr+VyhHzK5/rR76nbokm5G8x+6uhdiJ0ozD
	SRD0XKxJf7CC45/ilxGttBqvqz3EpmveN4TXMPL63pFCYEnb+uw=
X-Google-Smtp-Source: AGHT+IFsYJWHQ67P01kl6lLAwFTsDb+M9MXYDPIgyJtraJ+agvN8T8Lk8T9/5fBL+k8U7HiYay4VkA==
X-Received: by 2002:a17:90b:4a44:b0:2ee:693e:ed7a with SMTP id 98e67ed59e1d1-3031002c7b7mr21981226a91.35.1742838570730;
        Mon, 24 Mar 2025 10:49:30 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8900:32c0::e120])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-301bf576c7dsm12505821a91.3.2025.03.24.10.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 10:49:30 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <wagi@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	randyj@purestorage.com,
	adailey@purestorage.com,
	jrani@purestorage.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mkhalfella@purestorage.com
Subject: [RFC PATCH v1 0/7] nvme-tcp: Implement TP4129 (KATO Corrections and Clarifications)
Date: Mon, 24 Mar 2025 10:48:53 -0700
Message-ID: <20250324174909.3919131-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_104932_203596_57897F87 
X-CRM114-Status: GOOD (  15.02  )
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

Hello,

RFC patchset implementing TP4129 (KATO Corrections and Clarifications)
for nvme-tcp. nvme-tcp was choosen as an example to demonstrate the
approach taken in the patchset. Other fabric transports, nvme-rdma and
nvme-fc, will be added including the feedback received in this RFC.

TP4129 requires nvme controller to not immediately cancel inflight
requests when connection is lost between initiator and target.
Instead, inflight requests need to be held for a duration that is long
enough to allow target to learn about connection loss and quiesce
pending commands. Only then pending requests on the initiator side can
be canceled and possibly retried safely on another path. The main issue
TP4129 tries to address is ABA corruption that could happen if inflight
requests are tried immediately on another path.

Requests hold timeout has two components:

- KATO timeout is the time sufficient for target to learn about the
  connection loss. It depends on whether command based or traffic based
  keepalive is used. As per TP4129 the timeout is supposed to be 3 x KATO
  for traffic based keepalive and 2 * KATO for command based keepalive.

- CQT is the time needed by target controller to quiesce in flight nvme
  commands after the controller learns about connection loss.

On controller reset or delete cancel inflight requests if controller was
disabled correctly. Otherwise, hold the requests until it is safe to be
released.

Jyoti Rani (1):
  nvme-core: Read CQT wait from identify controller response

Mohamed Khalfella (6):
  nvmef: Add nvmef_req_hold_timeout_ms() to calculate kato request hold
    time
  nvme-tcp: Move freeing tagset out of nvme_tcp_teardown_io_queues()
  nvme-tcp: Move freeing admin tagset out of
    nvme_tcp_teardown_admin_queue()
  nvme-tcp: Split nvme_tcp_teardown_io_queues() into two functions
  nvme-core: Add support for holding inflight requests
  nvme-tcp: Do not immediately cancel inflight requests during recovery

 drivers/nvme/host/core.c    | 62 +++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/fabrics.h |  7 +++++
 drivers/nvme/host/nvme.h    |  5 +++
 drivers/nvme/host/tcp.c     | 56 +++++++++++++++++++++------------
 include/linux/nvme.h        |  4 ++-
 5 files changed, 114 insertions(+), 20 deletions(-)

-- 
2.48.1


