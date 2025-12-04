Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617FDD24469
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Dec 2025 18:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RILiBFUrCEeMeEKSv6N5kdn++qwTP3SRlW2lK7kc7WA=; b=j6zfVT48t/NmNZuJgUYQTY9+B6
	dzr1s0XlBUcNkXXJ4jQOjX5csquoBtf8kamAlKGKKhYni1VJArUufuH1k+r50WaHZstkn7GhrMYji
	9WR7BuLnsL/5fyPA7YGELkxiD/4uJVXH+qXAqquKLhGEGqmdGubRmL29qe4MGTXTfcGOx+PjAUGRi
	tx/OKDad4yUy+6Quctd79rcZxw9MdmO/RMkmpSCQHspxXYUJlCnCGE059SUA6jy/Ja3hRiTlBgEZM
	XwQxsCBSJvx1HXFLjKa2ZT1hjQOgNGiiIO3DoioeTf92JnJJJidE/FHyw9tmDrYwo+xCerAkWqff4
	zbuOR5Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRDos-00000008QG4-0rRM;
	Thu, 04 Dec 2025 18:12:46 +0000
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRDom-00000008QFD-3opc
	for linux-nvme@lists.infradead.org;
	Thu, 04 Dec 2025 18:12:44 +0000
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-bde0f62464cso1046974a12.2
        for <linux-nvme@lists.infradead.org>; Thu, 04 Dec 2025 10:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764871959; x=1765476759; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RILiBFUrCEeMeEKSv6N5kdn++qwTP3SRlW2lK7kc7WA=;
        b=ABKm4NSqT6WR5T3/KSajuf3Hsm+X1RTBtENX3udVVTLmzS2hll4bbyplXWaqQlGIZl
         UOsa4CmuDCPey//5GDwbmhL85Bu7ke4hl9tfhiJemjfVBHJcNVbE6JEkR7EaCqN9RHWV
         06LsMCbSu5tgb4dXk27MpuEDDB9FUncsFdtxdYRA8uaxKtMNAdCXzPC/p4Bh/LERSRsh
         U81SEieiBLj0IauBX0R84uILN1xjs3h7ji7lK3o317/vbkZMIh7CG0bq6zEKtSPog0Ev
         8b8rXSV4oCLc2qNx6R1folKG/S/+KRaAz5EBvaMnPLxIVh1psz9Va2v4as3lxunMaAoj
         SK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764871959; x=1765476759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RILiBFUrCEeMeEKSv6N5kdn++qwTP3SRlW2lK7kc7WA=;
        b=UzJ7WbWxpwfyBrU2MJsCLTtd4D3NR4dFPKm3eXOS//9s0oTTH7ixJod6HDCFZ36ns8
         mR8hO+5sWBmn1L/Xu3G/bjO/lGhev7lwlnz7A5ZoqNogUoJT1MMK/zbEvtMqBXJvdQ6/
         lCckrpIOQJ+HYQKiGt//IJH74k5/iCwkO2ARrPgbU63yssBJBcH9R/wPWgzB+2dqEHwn
         O1AR2XIJf0vJEsLPswyo0sIXszbdmKPDzGYkUb1Wltim7a+xfjOeQNLd1A2AeBTyENuL
         cWALfH5PSmfs9E7CIOLgvazBfCn+HMwIojdLubcS1eQX0NbYRFQG3yovdL0MrBNZ6+ps
         Y1OA==
X-Forwarded-Encrypted: i=1; AJvYcCUC/it0RemlWYaQHfNTZNj5UIU63Lz/IUMKEnOZknRMzpTTBijp7HJOfJuQkwL7t/CNy9Q7rq34bUZe@lists.infradead.org
X-Gm-Message-State: AOJu0Yw7tiCgzsczF5Puz67iAcKcf+UMIDwQHwcS1ADJLkO6hc8aMCB6
	iNlgeQG1pf4i1ZCNDlS83p6F/VD66+dakjGBQoaJGXRZMb5JX1EWYdoe5wtoBbYa8I4=
X-Gm-Gg: ASbGncva0aBm/boNPoN488YeN0Y7GxkJfAa6AIq+lP/tdgDF5Z1ne2FccjGKwmtfG4H
	D8Fd0Bf1d7amTgRJtCY9HhbXOO1dYeM0EUu7X/WCR/bln/QjWoDV1hMkKZyXebO1g1rjwiFN2pf
	y5F1+2LAA/nrEk9l1WEo8+eszTRi0e9OfQ7K6vhimA7IKfR2pWf4zwbnIGX1S0WTFKL8W8KuEiR
	lHZyC9JsjU7/KgJPkw2otDMHqqfm6lcn8oHzrFstWqrqSZsWmyddnrUtZgO/chtENLwjQJw46Xx
	iwbpnyF7/C9YggI3Mn821d3uJn489cZVzM1irHq+gxCJPssahRDbIAQFt8eTeU+BU035hxmRXE1
	XGKZWxdBViCFAMyYq7CJqWgPVUrDmWWIBiUkpKfwFJCZaEJBPJfGhKzwabkX5QX5ivNTB5TiyQY
	Zsz5Pay6Oq6X6i3AXiwNL2FDGjXfE6VoTSDQ==
X-Google-Smtp-Source: AGHT+IEgEDoTOTXQKy2j948cOKAQ7GqxE72wljdD/dWwVb6TtYiLJMON+G8ZC/6ycK5Ggb6q5/+34w==
X-Received: by 2002:a05:7301:da8b:b0:2a4:3594:d548 with SMTP id 5a478bee46e88-2ab92e3b053mr3781119eec.21.1764871959232;
        Thu, 04 Dec 2025 10:12:39 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-2aba8816ae9sm6998935eec.5.2025.12.04.10.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:12:38 -0800 (PST)
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
Subject: [PATCH 0/1] Use RCU in blk_mq_[un]quiesce_tagset() instead of set->tag_list_lock
Date: Thu,  4 Dec 2025 10:11:52 -0800
Message-ID: <20251204181212.1484066-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251204_101241_100017_490AF8F1 
X-CRM114-Status: UNSURE (   9.02  )
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

The patch in v2 converted set->tag_list_lock to a rwsemaphore. It was
pointed out this could result in a different kind of deadlock. This
patch uses RCU to protect set->tag_list when accessed from [un]quiesce
code.

v2 - https://lore.kernel.org/all/20251117202414.4071380-1-mkhalfella@purestorage.com/

Mohamed Khalfella (1):
  block: Use RCU in blk_mq_[un]quiesce_tagset() instead of
    set->tag_list_lock

 block/blk-mq.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

-- 
2.51.2


