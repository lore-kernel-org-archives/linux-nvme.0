Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93621606A31A
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2026 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XzMQbgNx;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qTBzY5u+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=A6WQ68hjWi8GGKbr/7ipB7b6//gVmCrXXLJs0RemD+8=; b=XzMQbgNxniKJs2
	hm4jXs2f5yjyzuOK/9LadNLTFSr0wUKEhr9ep/pmkKL/HMMOfihGJIlN9gEYLNIDOALA6BFKLzMb2
	LCHMOPP2tsfIbfQPC0jaeSjPIihTgpn3BiCebD1u59Za/7HOgPtx0+OH8h92JGxtEwTVIo4StHIyh
	331ziq5Um7FwoSqwAWcj0hNiK8heJyX8CKJUponf7aWesxNzr8+iW95i7MhMdp2GwaTuMp66HOJ6l
	MnU4rIvPBqLnFw6ny2JxF868x2+iYsC8E/W0/P9F9J6jI+i9wGpe81TZ5AbxOH0EP4jZwJqT4kWsY
	3zDUkpq87Q08OnwJecVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLIOA-00000002J4z-19DS;
	Mon, 26 Oct 2026 10:57:14 +0000
Received: from mail-yx2-x01.google.com ([2607:f8b0:4864:41::1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLIO7-00000002J4S-3p9F
	for linux-nvme@lists.infradead.org;
	Mon, 26 Oct 2026 10:57:13 +0000
Received: by mail-yx2-x01.google.com with SMTP id 00721157ae682-8b0dbcd4b6aso5258527b3.1
        for <linux-nvme@lists.infradead.org>; Mon, 26 Oct 2026 03:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793012230; x=1793617030; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A6WQ68hjWi8GGKbr/7ipB7b6//gVmCrXXLJs0RemD+8=;
        b=qTBzY5u+4dvN3BM4y/IaboaVJp+7WfYBmO0DX3lMTjUY3JlVbxluUgHj6BAwEG17Mh
         sYt1T7rYemf8u9s6w5xgpBkiXdH99eL0ccHoOxGOAa+nx8iU+GK1ttx2kk2/sHvXH/7/
         dwEIowQx5ixlkZd2k+mADOe/m8ASwgRiUgldkZl7U2yFqwsUYjkNGvLFlcporPPdLwz1
         0HJgtRFdf2mx8Y0YniB8SLBnoKYHeiqCFtO0w5YiCugozDvA4wG/Yi4UeDv4YyP4rbwA
         kigOj1e2NE1+IqkCIac9MrW+vojuzq/v3mxTblVO1Hrp8HhM2XdDlcRLYFCzXFoTn/V9
         a+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793012230; x=1793617030;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A6WQ68hjWi8GGKbr/7ipB7b6//gVmCrXXLJs0RemD+8=;
        b=ystmCf0BcjEocVErl09rv+WJbquGaHmqxISPg/8085fmNbhdkMhQFBspC8CcXH8tYC
         mnqulfMTVLEXuKRXmrYR06P0bDQ2r2UdFblilAyBKCKmIOh/0FJtUaKHAHh7mZBAp/fG
         6VxaBxIArPhbo5yTbKDOSxIAqYufPBdrZPwBcfZkrweGbBpzBheK/qcL1oRH97my/30M
         E3tsj1/7V4ZQXWJ386z34ONCke1wRNf2BWnfE5GXCooB82PhWCNMew31vVrvjj6uCAVd
         m0BTPULGIFV3BlZ7JVRdam1bnhhjchG07yFl0F0T4UDBYRUOi6Li5F82Vjv01T0FiQ3y
         Z/ww==
X-Gm-Message-State: AFq9FYJLMfsbKOV9QZM8oOKUqNn8G7UGiK6OV6D3NiRSLz94usw4vY3M
	+EmsaTNVA0jeXRMDqjiA7P65/zUbPgfykZgNOrZUKb0dMAg2rvyLRpL+
X-Gm-Gg: AYBFou1GjsMnkk+DVrAU3BjsM4Vc+Il1fE5dvu/dcLYI2GwfLnXzY+SQcOhRUoDmOzA
	7pUV3pOC8p2vHg5mxDU6HTtn68NfXLobTM3/0K3oiF6qmCf5oIjEF7X7qQap9pLJDHVGfLBYwA3
	zOdo2/iHmOXJ1ew/RiXAmQ88+PQ8GJkfl1VWaHMBu29p1LmRG6h/0/ncMQhzSrgVRa/LktD9DGi
	ECPXlF2r+g3xSM7LY4wvA/RSKywBf6+nDR0PYQJ2rUddXeNSFzwK2Lx5wSbm93jhN/zqWIXysEL
	CD+dFgA8p5JzD6a3fzcyIuuZQLLY37ocnaXm8fDV5wNzkA5l19LrBfzkoOfTEVDRtEgMCKmSx6F
	BH9eGDQ/o29s1GuX+ZBGsfdgK0tuWDQ33xCbC3nC4rdJiL4VEzRC+kafVMAP+G6Te4yLhjWDwJB
	PsHBse1YrbhQWxG/s2oUsYr1LMzUJssreGsg4xST5vCD1adg7uE6k7D/pjbenls0VRMXeDJe1JO
	Fp1EkmgvQqZMOx4ZS4xLsdVcJriCXSLlVgE4a8MDk5cws+7Y2Y/45hdTO6vB3g=
X-Received: by 2002:a05:690c:dd6:b0:873:5bb2:6c06 with SMTP id 00721157ae682-8b166c4a307mr54037207b3.48.1793012230048;
        Mon, 26 Oct 2026 03:57:10 -0700 (PDT)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b166eb116esm28902707b3.37.2026.10.26.03.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 03:57:09 -0700 (PDT)
Message-ID: <705f4452-3d07-4d91-9dcd-ea53b2cd75a5@gmail.com>
Date: Mon, 26 Oct 2026 06:57:07 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] nvme-tcp: parallelize I/O queue allocation and
 startup
To: Surabhi Gogte <sgogte@purestorage.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 mkhalfella@purestorage.com, randyj@purestorage.com, adailey@purestorage.com,
 Hannes Reinecke <hare@kernel.org>, wagi@kernel.org,
 shinichiro.kawasaki@wdc.com
References: <20260922200718.3941465-1-sgogte@purestorage.com>
 <20260922200718.3941465-4-sgogte@purestorage.com>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <20260922200718.3941465-4-sgogte@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_035711_958033_BA34C78E 
X-CRM114-Status: GOOD (  13.36  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 9/22/26 16:07, Surabhi Gogte wrote:
 > Similar to commit 2a8513091d2f ("nvme-rdma: parallelize I/O queue
 > allocation and startup"), refactor nvme tcp I/O queue setup to use async
 > API, combining allocation and startup into a single parallel operation
 > per queue. This reduces connection and reconnection setup time when
 > there are delays in establishing connections, which is especially
 > important for high-core-count hosts.
[...]

Hi Surabhi,

This patch breaks NVMe/TCP connects with TLS. This is a different bug
from the pf_cache_lock one that Shin'ichiro reported.

Test: one VM with 4 CPUs, nvmet-tcp on 127.0.0.1 with tsas tls1.3, a
connect with --tls and 4 I/O queues, and tlshd at upstream commit
a0bd51d.

- Linus master 6b4b543fa187: 14 of 20 connects fail.
- Same tree with this patch reverted: 20 of 20 connects pass.
- Same tree with Daniel's pf_cache_lock fix [1]: 22 of 40 and 17 of 40
   connects fail.

On each failed connect, one I/O queue logs:

   nvme nvme0: queue 4: TLS handshake complete, error -110

The tlshd that runs for the target logs:

   failed to search 'psk' key 'NVMe0R01 <hostnqn> <subnqn>'
   gnutls: Error in password/key file. (-31)

and closes the connection. The tlshd that runs for the host then gets
GNUTLS_E_PREMATURE_TERMINATION, which it reports to the kernel as
ETIMEDOUT. The other queues use the same PSK, and their handshakes
succeed. blktests nvme/062 and nvme/063 fail the same way.

I can share the reproducer script.

[1] 
https://lore.kernel.org/all/20261014-nvme-fabrics-isolcpu-v1-1-355156be27b2@kernel.org/

Martin

