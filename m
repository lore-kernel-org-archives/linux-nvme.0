Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9318EC3DA59
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jul 2024 22:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gRJ2uTLG4AE1W2r135WxVjYfrIn0tz9jHJj9trzpqw0=; b=2Q6t4nfbkDlW5YjEaz+YTVTSd8
	s4KCSrUVuuagWM4MAIfkeT1YsMeB06GOmnvBkVb7rbUI36EtT/nr55HvGKIu3GhTJ93geav0pBBOg
	nzbsYHuwPgUIF6MN3DExWbVk5SyWIpVMCS/FIojGnAKKxlaxBZxmoGH/IHZD+vpKGfc1DWnTilBuo
	AW5P3l0E/9scj3NGfjdIU65vfL3zRT7V5xAqGgAtgXo3h6+pWotkOpKwVSjyNkgBJs32roRV49iUg
	ODwAjKe2A6oLQQ3DJ6PNe+hzqeUwLjPOpA8JfoEByM2T6faSlQwZdB/e1KROpOVirZq5baI6rdARx
	tW4sdKHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sW1Pc-0000000Ak4Q-22fE;
	Mon, 22 Jul 2024 22:21:44 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sW1PZ-0000000Ak3h-1tCB
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jul 2024 22:21:42 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-70d19bfdabbso52209b3a.2
        for <linux-nvme@lists.infradead.org>; Mon, 22 Jul 2024 15:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721686900; x=1722291700; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gRJ2uTLG4AE1W2r135WxVjYfrIn0tz9jHJj9trzpqw0=;
        b=tLq5Tock/pnt3/xQ+e/iyA05tdZ/zz587V55ugtRfxmQGlCES1xpOf7Wbpq5JlcZDl
         Qt7ug1QNb4U/bKdKhC1d1PVauzhA+VtALoh/2hAYiMFTgFQ3+MEi3Jt7qRHS9EUACuzE
         8IzKXwY5a9tsVApCdYVP6SZiMjTrmnr8gAT2wqfmSSJX21v3SlyQ4x5xZekzjmSX31Fr
         TpzzE34C88wHy7QKeXf9zEBIuGWYGyQ7iml/XD+voAzaHmMXFvNoS0NdOE2IwnYvWqbG
         PJMzeKDAsD52jQ7uN/exrJh5NX19yN/C82ECNCJj3Vg8UC+X48nW1fSTNbPgOiAZlyt5
         hKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721686900; x=1722291700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gRJ2uTLG4AE1W2r135WxVjYfrIn0tz9jHJj9trzpqw0=;
        b=NgCf4Hhw++pzuPddUm5xEXE6KYfS/kAP9pHMjtps/0qygts6WIZFAMiVogmcRAGbj9
         W6sa5JxEptJaDeAyEFrlpCN7GME6VpY1RhGk2GgMX+mVgfB2JqBEaa76Rh1BZd7k2N0o
         MFCQrWGuQiT+xl0mlVHWAJ9b85LNMZQAXaVLY6Ljcy8GDHu6eHmeZ3GBXsnqOnKHnUmA
         U612P2EwJTwDn3XhBvtOqtq16uHHETjZi3vdtKTEBBpot4OP5wYH2rkrQn6z7riZEDj/
         M4CwMQqK35RgEksrucwkOGNj/gUiQ0pu9gqcQlMC4yokaTs8UbriPBaR3w3P2zxxmTyZ
         5qnw==
X-Forwarded-Encrypted: i=1; AJvYcCU+i5L8fsAK8QK/sIAW7nc0Pwl3P8225xyzorVurkc7/xDLnWmpW75cBIhwG+XRgyPpxP5lcJogxx1/69UA8mU7PUSYeiVnxmwXJPRDuPk=
X-Gm-Message-State: AOJu0YyRhjQMejPE0hvoKvGuFrS0UdshQPICHD2dHTsh2V0KeutNuwUM
	KvF7c6BxvwviscST+rU6fB6/vwT59iVaHFgasgjudiB3mj60NnNn6uvUoNeWuiM=
X-Google-Smtp-Source: AGHT+IGScHD6XHoPrstmVFPw+Xo8947sWS5UFvpK8ufwAvqfdOvxadY9ZmmXoO25QdpiwaLvvRLgSA==
X-Received: by 2002:a05:6a00:6006:b0:70d:2cf6:598 with SMTP id d2e1a72fcca58-70d2cf6127amr2260050b3a.5.1721686899902;
        Mon, 22 Jul 2024 15:21:39 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d1fc869cdsm2974888b3a.170.2024.07.22.15.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 15:21:39 -0700 (PDT)
Message-ID: <0cc50a53-fd8f-433d-bb69-c9d3f73ceace@kernel.dk>
Date: Mon, 22 Jul 2024 16:21:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] bugfix: Introduce sendpages_ok() to check
 sendpage_ok() on contiguous pages
To: Ofir Gal <ofir.gal@volumez.com>, davem@davemloft.net,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, ceph-devel@vger.kernel.org
Cc: dhowells@redhat.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
 christoph.boehmwalder@linbit.com, idryomov@gmail.com, xiubli@redhat.com
References: <20240718084515.3833733-1-ofir.gal@volumez.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240718084515.3833733-1-ofir.gal@volumez.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240722_152141_522942_06D38AE2 
X-CRM114-Status: UNSURE (   7.09  )
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

Hi,

Who's queuing up these patches? I can certainly do it, but would be nice
with an ack on the networking patch if so.

-- 
Jens Axboe


