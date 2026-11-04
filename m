Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C7D606A31B
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 04:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GPd9Y3Gp;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GhC/tWSf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=iepVCsYSPNl4UCCvBw+pBw5SWXsBUUPexi1mujRkRLk=; b=GPd9Y3GpnSXeTrMYT1GxLHs7VR
	C56BX9TLZ+RsTDnCyP8hH7scaNDJBorYkY4iuSD7ULF43mBIffP47/rbudOUKintFYt0291RXtFbK
	xsPW9TFsiEqyyBmRxsf9ebhnKidSjAsKxWnWEnxXa641Hsi1QVCgpg3Wvo3FYnY5UySIdwblSA5W6
	tpoEn3fAMahyuIa5KmsUGzxXT19zxaX3fIZOgMxgBVj8wXMLhJ/ci7pIzlIjcgchWG5tak0r6XBe9
	imby0FnPHo+gYtusir8ssjZUVdK0klofK0vAp8qtskdYWBc9Uy9FkSofDh6HMA2pz/ea9YEv07WGT
	ng/60KFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOSxj-00000004JrK-3WRh;
	Wed, 04 Nov 2026 04:51:03 +0000
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOSxd-00000004Jql-04km
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 04:50:58 +0000
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-3ab53a99771so2359101fa.3
        for <linux-nvme@lists.infradead.org>; Tue, 03 Nov 2026 20:50:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793767854; cv=none;
        d=google.com; s=arc-20260327;
        b=lrmWO6+MYjyhTgGvhMLQvrtcP276jR+isvSjf2iTEqwnnke17TsLIfK8VEVQN8Rw9T
         XV5dBOCSIo003Sy0ZkcIkw+yHEMXhJDojojBhqEztGr5JdBTLhArpI2rku9/vFQBEpTy
         sNjp+bdeD1nFx/G5F8Hu1Xm5a/BfGwvYAIPyudKGPb08PddzKl4VusDMvRSrRnb0HcwA
         Oj2vWiBjsisixl9syX+2KwnOQUai4td9i/5Zn6i0syPfDgSaUG6IQTHnkO1pBIN/0lOP
         NpO8D9AAkuy1beqbHcEMpDHTvv/tTmGzUr+cdVDzYbTR2UDxMVG25EzqIT5uFdgVgvCA
         jtQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=iepVCsYSPNl4UCCvBw+pBw5SWXsBUUPexi1mujRkRLk=;
        fh=7+KdSWkY42MGIqn2x+/v4ldGtolAQUF/Hoh09jRRR8g=;
        b=XHOwUx6MN7P6THBQ5Q0NNWU6NqoacLC7tuq8P/5V8TIiXkzO8o9qdg+i9ZpWANvze8
         ZRrZ5X9MhNzUGSu6abLAqD2vfTCkAV5ipNQI+xIag1Vt7rdBIkMCjjSVmdgMD700d2RO
         hjAU1WnP0ictrl1n1bhbaoccD/lkLntaBmILfX8ZFlxuGNN2AV8tV4DhWLYbwY/msWVk
         YExLkTgCvxhiHi3OM1Ri9ZDhYXBoidesINLchpCkyjGLcF+H9uqfmE2L8bQ2mhrAWnwq
         RzdOzFyEMXbDk9jo0opB87WaJTpByDUDTKwmUlX+Be/yQGdJrX3cjiO48hf4fL8cCw6h
         7PlQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793767854; x=1794372654; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iepVCsYSPNl4UCCvBw+pBw5SWXsBUUPexi1mujRkRLk=;
        b=GhC/tWSfdZs5lcwlMQ0V0Myje/6NEB2PWwSVlb90pcWxLyDPO9NnFouCIMTc71L8qH
         T5D9Xd52PRX4rPVKwv0aSurNHkT2Z+MvrJ/iV6/0D6d2ditcEEm/i1WkgNEf8vWvpdjS
         kidczu9j7gZMcV1qEi70k1eK9fYuhvYO68kyQqgnFVA0LZwl+BBqnDyXgdBAgiKaxf6Z
         ZUeNq/9ilHp+IHAuUmV74g+tSDTO1jdwZSmmVhsNGtpnQyfN2/0pAMl+7ck3UDwOzaCQ
         sa1Qs4znYoDIjh8oWRQLZXy3XHp5ttfTbyyjBpnfkk1chSSqB829aCOLzNGcpElY2q5B
         IHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793767854; x=1794372654;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iepVCsYSPNl4UCCvBw+pBw5SWXsBUUPexi1mujRkRLk=;
        b=IJXt/tfeeQTdzOCyi8sdqpvoyAoQ2IcewWmJAfiPnD9JRHByRq14cYPNFn2I8GxQJk
         1mKUHT7rgpoIyhbpnbg6yNji+CScWCsyNtFW1LPg0PNONoJAhewwzjk0j3veg2hlrssY
         7iSshqnNcHx+UkEMn1puYloAa1uRwJBKh8O7GE6jm5qCkO+N7UWU7L7LrZUSFnNEaGJg
         BxJEQC6CYHXj0nxmstNc64K5lPjgxGmBtuHiIxa+lPfKMClY0pH47qoWrAHqRcCtFiib
         quwsauMgNf948khS6Sa7jG25t6BaN2EKABaDMTW8dxhEhlrQ07uoIJPYbspdqsn0hnZ8
         w66g==
X-Gm-Message-State: APuU4Z/N+aToZlM1BmmnwyrCDjBtY9yw6u/EFT9+c5mB+gLz4aWnObeI
	4P/uHORgZCkBC1P6mSWddG+EPTH64Hkz6lhW/X7D1/NcPdLnhRv0UtuQgxlok4D5FGKsbwM90Gy
	g0wd+xDh6K0rHBHu0yr9/8txZzR8DOeI=
X-Gm-Gg: AYBFou27IjZ0ggIe/H4XlNwbr7yVVSQ5+Ke+SKlAPzyC0mmFgUBzKB3ZJacTXU6uUii
	Oemw5oUaAWvFzw1m6qfXSjBnEkYTCdtYSIO2jVYJAU+b2zJX/nOIlWgNTWn2k17RVGXDUI0EK25
	KyAPr6Uwt+BYKR/C/xxqWC0Edpc8ddQYUFknpWj8lXVRCZrzhEwmc5/l2U9qI/bgear97BiaN98
	l+/Tqkm3dpBKlhBIp+w0zi7qKsfegDj+i1zQXZSDcC1Dr4G7Tx/rZ9uiXtR7e1d8wQUUfV8345H
	rgIkMAdd7ZcbtyzChzRe8o3madJnIkxaHHL8CNVwdS1SDWMFvdalU+2878ewKchpaE7d4iohUmN
	q662l7bJYnp4//aLyGFaQOG5dtbVKSOZDSrk+UIEabQa7U6snHnZuAsCF/ebvFXI7Vyl5qkD7hS
	UxYiAvKz466P+UAQ==
X-Received: by 2002:a05:651c:1991:b0:3a8:380c:9fb6 with SMTP id
 38308e7fff4ca-3acb7b187d1mr36544201fa.28.1793767853281; Tue, 03 Nov 2026
 20:50:53 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: zhang san <shunsheng1218@gmail.com>
Date: Wed, 4 Nov 2026 12:50:42 +0800
X-Gm-Features: AclHuK_-DT1ck15JWWBlfanZnKdtx_qDE4sPMfANpjaMeQkMoVd8IZ_gjZ7rDaY
Message-ID: <CAGTEBTa9dGn8TjKxRPsfeCFiRYAt-cGMAp-XSLBS86SHB6FJ_A@mail.gmail.com>
Subject: Question: NVMe AER completion delivery during controller removal
To: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_205057_103584_27B31115 
X-CRM114-Status: UNSURE (   8.73  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.9 (-)
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
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

We are seeking clarification about asynchronous event request (AER)
completion behavior during NVMe controller removal, before treating an
observed test failure as a production-reachable driver bug.

Our source analysis suggests a possible lifetime race between the AEN
completion path, which can requeue nvme_async_event_work, and the
controller removal path. We observed KASAN use-after-free in an
emulated environment on Linux v7.4-rc1 (6628e7d4c6b2).

However, our test induced an ERROR AEN through an out-of-specification
MMIO doorbell write while the device was being removed. This
deliberately synthetic trigger does not establish that a compliant
controller would generate the same completion.

Our main question is: can a specification-compliant controller deliver
a completion for a previously submitted AER during the interval in
which the host is disabling the controller and tearing down the admin
queue, or must such completions be quiesced before disable completes?
We would also welcome guidance on the exact point after which the host
may safely assume that no further AER completions can be delivered.

If a compliant device can generate a completion in the relevant
window, we can follow up with the source-level race analysis, complete
KASAN traces, and test details. Otherwise, we will not characterize
the synthetic result as a production-reachable UAF.

If a standards-compliant trigger or fix is identified, please CC me on
the relevant patch. I can help validate the reproduction conditions
and test the exact proposed change, providing a Tested-by tag if
verification succeeds.

The investigation used AI-assisted source analysis and experiments
reviewed by us.

Best regards
Yanhan Li

