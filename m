Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C67FD374A3
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Dec 2025 21:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qLr78IWpZsH9cRJ6KPlqEXZYrcnfDvKEUz40bjS2UZY=; b=h9qjOVOlbiZ7mQtfEYAqmmtH7r
	FTnU9dy0jI5gM/aYSyJxGpeuWftrw+g6fCxaVJ6Uu/J+TvMdP0T0jT9jPaKbCiVsWLt35bT4C5Qid
	u/l56Xh3Hx5nxMx10m1Q7WSomgHfw+dRnhJWP2gXm2VYyq6uw13feupZr6cIgNHt7Z18SF8Jex+5/
	q5xVrUV/zfoAKvwGdyGrXUo7jPZ2DE/BLpdCV1xGhcxcSXsOYA8F8JCV1f6UTWk+EDWuhWsFXED3U
	01wQr8FYWDAX00Z6cDVQkGmaufXPueTv//NOPInNRO7+P/5XE5mqU8Vi1iAzY4P+V1sBWjtiTadUE
	vu5w/Nlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRdBm-0000000A3ci-24HL;
	Fri, 05 Dec 2025 21:18:06 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRdBj-0000000A3cG-19XN
	for linux-nvme@lists.infradead.org;
	Fri, 05 Dec 2025 21:18:04 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-29555b384acso26297345ad.1
        for <linux-nvme@lists.infradead.org>; Fri, 05 Dec 2025 13:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764969482; x=1765574282; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qLr78IWpZsH9cRJ6KPlqEXZYrcnfDvKEUz40bjS2UZY=;
        b=QO29OkaVwO2jCgnG+UOyTi1XES8Hd1l5B0ld3at9d3r1XyC61SsOCALLXKstL+KQER
         uknRgBm6rOGd9uLWuLJb44JwfXNOpY3emjnM9/5Kn3jTT9XPFfQvgYgVZsWgzl4H7YEj
         xxNKB+hlaKZl/5M9IzJlkxUoffMUaOnenBZfGrIxKbiEZkr5MsA2gZDDtrf/PTdKdIvB
         UyQtlp/A0h6FfKjS+wQ9k5yuk7d0vn408uzZEKs9jCzsy8xG2csRqXka82VetqpDqqgj
         9IQJ3deXZBEH5iPFIlliJboYDVEjfjQCsUIAodEOJDKEz8/H6n1WmVRtoCAJJdic/F+K
         gRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764969482; x=1765574282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLr78IWpZsH9cRJ6KPlqEXZYrcnfDvKEUz40bjS2UZY=;
        b=mC8p6eZcq2/CcK2fApnT9UoDEK8+YAMh2wuJOdHIWJgy2baaW4ZR6JQDHYsdM+iuaN
         kb6Hvh2BR3CZjTyP/fSuECyiQkZs0nm0ZjPEFfzzVJ2+4tC6Jdj3hzf2obTjpEqNmHv3
         ON2tSgWnqJ5dDZUw2sIxrdzJSLuwwYNxE43xcFBX6+dbNuPgmBBX2aeYo4ScltIpv8pe
         szitZeOcvPEfDWvpgBPR3SC9Apc/kZzO5joeBvBSLUe0WSXIzRrb0a2ZOODn89P88yyw
         mv7+RYnZ70pD0MxPdPSnumpUaBenAuRJYYEix1A5IJV2Ghbxt3uRV1FqTdTz4u4rlppW
         VzQg==
X-Forwarded-Encrypted: i=1; AJvYcCWsuN2oAVbb9xy0KL5OgP0T3XRJBPpT4+Ewxa40HpAZHxja15SDa18oZY+U1vG8ffSTPGwywmR1roOa@lists.infradead.org
X-Gm-Message-State: AOJu0YxWcI76yI8+KqID8O7z+lN5SCKnhUvXwFYk6VGEBvKViK5VYY97
	ED3KdQ43yFi1RA8kB0ymDXEoSiBCHV9tG8h2LVPULomGhnf1ykXANihACcTAEFovM38=
X-Gm-Gg: ASbGncvm6K5H3xI51EUFSuBbOjThJE4t54fheIn58p45+jTozZIKoNr/FWHWHW2Rx/q
	O8lZ9YHm9MTOyufLbbJyred4bVsIDoW6Q9cHHi/2eXWsDGBo6unsw7av6jPaRl2r/JqHBMgman1
	u2VDbhpB/T8rNsQ4ctc+mVJDNLM7VwlvfQKG6faQRCqtPWVCuOAEgMu/7I9U1odZyVNSYXuo0NL
	ELM4vKJvOkP33xwPe6rtEbabnuv65pponeFdGEwzuyuNySNheRxWNdEyhykdgPUQ+lar5PVbLNP
	VbGH/514cZ/fKa5KQY5PgMrSq0ftwsav6STU7yhYJn9vKNgYxR+SZ1H6wJ0yPrgjL7PL8cyhIy+
	caFw1SDoKwChrPOiKBDjhVdm3kXgNmJvsBaAQlXYpvq2ebFrshNfqOquR45iHmqVHNXBzTnjw9D
	f8fkHuqbkXQyvOC6T9BFcfb140ChjQ/2YsSg==
X-Google-Smtp-Source: AGHT+IHgbtRzljq2X9udI6Q97+gwmHZiZ3ufXgUMLj3UuDiJA4sZb94uuPtC80v9mSCYDgdTAcYmcg==
X-Received: by 2002:a05:7300:d0a1:b0:2a7:83e:7b17 with SMTP id 5a478bee46e88-2abc712d0a3mr394259eec.12.1764969481828;
        Fri, 05 Dec 2025 13:18:01 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-2aba8395d99sm25546318eec.1.2025.12.05.13.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 13:18:01 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Casey Chen <cachen@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Hannes Reinecke <hare@suse.de>,
	Ming Lei <ming.lei@redhat.com>,
	Waiman Long <llong@redhat.com>,
	Hillf Danton <hdanton@sina.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v4 0/1] block: Use RCU in blk_mq_[un]quiesce_tagset() instead of set->tag_list_lock
Date: Fri,  5 Dec 2025 13:17:01 -0800
Message-ID: <20251205211738.1872244-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251205_131803_464186_42DA3087 
X-CRM114-Status: UNSURE (   9.51  )
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

Changes from v3:
- Fixed typos in commit message.
- Updated stacktrace in commit message with one taken from recent kernel.
- Added Fixes: tag to commit message.
- Deleted synchronize_rcu() (added in v3) and pre-existing
  INIT_LIST_HEAD(&q->tag_set_list) call in blk_mq_del_queue_tag_set().
- Updated the commit message to mention why it is safe to delete
  INIT_LIST_HEAD(&q->tag_set_list) in blk_mq_del_queue_tag_set().

v3 - https://lore.kernel.org/all/20251204181212.1484066-1-mkhalfella@purestorage.com/

Mohamed Khalfella (1):
  block: Use RCU in blk_mq_[un]quiesce_tagset() instead of
    set->tag_list_lock

 block/blk-mq.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

-- 
2.51.2


