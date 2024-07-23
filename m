Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0A4C3DA49
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jul 2024 13:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bqlR1BIutPkgOwMCyULXWeyxag7BhJk90RFsq6PrQZo=; b=O3owkLzGt6h85t+WTuang6BIuc
	tWdMlYRr9yGQn5FBuAhFfTz6jaWy4oMpMjbjFsIttdiO9dnHL2UiZZ+nhWEt2P1upxdxndos4AS3/
	SOpxfLJfb9kw8OwG8+QCUNCD/uU2tZsQPY3YEF3mquthfOtELV5eaWXfen9Y2u7/NFVdB+nk8ziDX
	9IoL6x9HZy3auig32uTgXdytGWoIXdRG8IQ55d83cniZUFxc8GqfpRidiDN/Qa4ZMun8IE941wqIt
	FAv5Nc2N8ySU9EsU1uB0Wr0n0OJ9NtYC4XxSzh+BpHscfyLfT/dH01fGtpsYtlLoxxUau/w+uC2OB
	AoRvMZ6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWFcG-0000000CXh4-01Ow;
	Tue, 23 Jul 2024 13:31:44 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWFbP-0000000CXIs-1Dap
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jul 2024 13:30:53 +0000
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2cb77ecd7a2so585916a91.1
        for <linux-nvme@lists.infradead.org>; Tue, 23 Jul 2024 06:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721741450; x=1722346250; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqlR1BIutPkgOwMCyULXWeyxag7BhJk90RFsq6PrQZo=;
        b=x6aRhQUbxiMONUn0r5Td2WL/4Jt4dtRMDv985n9Pegc9FmUpEtbk4E+GuA4p53FrY5
         rlO8fq9GBVrcYV0X+SHS+Of9PPuhUUX0LIPteVzaBonDzBlPNbjo4JufKKIAbyKlfC5H
         uG13RmfHw5Ry6+rWua9MBqnNGtq9ErCp2WF0kJ8+tyEdpdkXXtIlwyoEb/HsQrJEQJ2o
         q1GMKiVrtpjphCQL4lRfb1C+lVDIFUVBNak8SVPy+6itpMQNRaj1GYcsdQCFgdqXzesV
         THRSQe9/kfbv2TAuaROu8GE3YRqXJuhW5/u/3Scsd5Eqypj2+pNdmlFH5sdSUQTtCElE
         HTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721741450; x=1722346250;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bqlR1BIutPkgOwMCyULXWeyxag7BhJk90RFsq6PrQZo=;
        b=VsK5QwxWofDUVh7RShYHnx6zbTMa0IwN3xC4tvwpkS9+K2Sv6RY2ajKNmx0oKv5piN
         BYAFbUpguv+FDHve0QYgLrNMy/4KaxPwqN0En79Lwtv9w6CMw+BliCm3lrVmrWCiWbwR
         QBk/n8RWI9wXX8GQOUgh3D01pdFhPjRzGu/MukVFXnwtT8GUmxNWEEfCidv1JhNBehk4
         V8zCTNaYX7/Mp02kEM0GZtB8Gg4Tpq7x9QahPZMH8dHrm7kKLDaMQOGosxdq6hU5hQR5
         /8+vgLV4vWEkxYbqak4ZSaUmqunDNtTiomFTSIYzwDXNfm7u6v5GKLhBW6T+Nvc1nz5w
         PAog==
X-Forwarded-Encrypted: i=1; AJvYcCUPYNMRrufBE5HB+T4zyuLhDkrLAZKJXWkclCz1XNYbJjHA0oYaS5TW7K5E6jCIv0dCiJ5X5hkihnpa@lists.infradead.org
X-Gm-Message-State: AOJu0Yz3dOVxCQ2IVR7GpKEQe6znUEE7uoS3rsAIsHIGTJa9GJZCOBCR
	DpL3fcrV5a3VZvRUCh3cFjxjGDXHXGsrGRaBUSXxad0hDUg5j+YAyn6SRfC7YRw=
X-Google-Smtp-Source: AGHT+IHDM+Qmjw2gX4WFG+25cSaQly4nclkewYqx2IYKX4yl9o3sdW7TdNziDSTE7eR/4EF9vuEw/A==
X-Received: by 2002:a17:90b:494:b0:2cd:1e0d:a4c8 with SMTP id 98e67ed59e1d1-2cd1e0da5ffmr7298722a91.3.1721741449707;
        Tue, 23 Jul 2024 06:30:49 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cd8cfb85c0sm1553157a91.0.2024.07.23.06.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 06:30:49 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: davem@davemloft.net, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org, 
 ceph-devel@vger.kernel.org, Ofir Gal <ofir.gal@volumez.com>
Cc: dhowells@redhat.com, edumazet@google.com, kuba@kernel.org, 
 pabeni@redhat.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, 
 philipp.reisner@linbit.com, lars.ellenberg@linbit.com, 
 christoph.boehmwalder@linbit.com, idryomov@gmail.com, xiubli@redhat.com
In-Reply-To: <20240718084515.3833733-1-ofir.gal@volumez.com>
References: <20240718084515.3833733-1-ofir.gal@volumez.com>
Subject: Re: [PATCH v5 0/3] bugfix: Introduce sendpages_ok() to check
 sendpage_ok() on contiguous pages
Message-Id: <172174144805.171126.5886411285955173900.b4-ty@kernel.dk>
Date: Tue, 23 Jul 2024 07:30:48 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240723_063051_673721_FA19AC92 
X-CRM114-Status: UNSURE (   9.18  )
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


On Thu, 18 Jul 2024 11:45:11 +0300, Ofir Gal wrote:
> skb_splice_from_iter() warns on !sendpage_ok() which results in nvme-tcp
> data transfer failure. This warning leads to hanging IO.
> 
> nvme-tcp using sendpage_ok() to check the first page of an iterator in
> order to disable MSG_SPLICE_PAGES. The iterator can represent a list of
> contiguous pages.
> 
> [...]

Applied, thanks!

[1/3] net: introduce helper sendpages_ok()
      commit: 80b272a6f50b2a76f7d2c71a5c097c56d103a9ed
[2/3] nvme-tcp: use sendpages_ok() instead of sendpage_ok()
      commit: 41669803e5001f674083c9c176a4749eb1abbe29
[3/3] drbd: use sendpages_ok() instead of sendpage_ok()
      commit: e601087934f178a9a9ae8f5a3938b4aa76379ea1

Best regards,
-- 
Jens Axboe




