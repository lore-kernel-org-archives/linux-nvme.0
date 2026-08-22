Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADEEC5DF8C
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Aug 2026 01:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZvNPSn63dNk+c0MWwyzpuNrWmftezLJ2XLIn9JInkRI=; b=jS91FJ+pUX4bi24/7/hQEvMH6e
	bWfaI55ELW8nOLTcs30LJMvnWUia+mowO9xTo9pwb2iDM7m6P+FV8W9lRXk5LmZ2ONyx1rsnHKY99
	rfZ2OwJVgeIwPKqqqoEdKS6LxnDjvosUtDagsbmKveEvlE8+Ws5IrFOKJRbh14ywepN69AiXWY0JX
	GT2S/QEAnhDc/nd5WnHdpTTfmSe+ed7SH9bQMZpbdhxPKQYER1prWBw2/OsrQQq5x1yOHstf7Lmhk
	O+HAXHMuAyH92JLIasv1GT3i2gx6g4L9wI0WLbi+K4hnHD4/e+ulISNIU9lboWqRs6z3M3VpjQSdn
	6J6HqWIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxajS-0000000EE9X-3ns7;
	Sat, 22 Aug 2026 01:41:14 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxajP-0000000EE9A-0oIB
	for linux-nvme@lists.infradead.org;
	Sat, 22 Aug 2026 01:41:13 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-848761b5897so671686b3a.3
        for <linux-nvme@lists.infradead.org>; Fri, 21 Aug 2026 18:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1787362869; x=1787967669; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZvNPSn63dNk+c0MWwyzpuNrWmftezLJ2XLIn9JInkRI=;
        b=l7hzQAYQ0Jfiaddo6/E5tnLmau2NxOOR2n5YwCcD/l8YSKysufwXz/9Xxb/fZFZgJU
         lVBRS3WVgFOSPQO2sdxJvYDZ9IRIo1RVbqUmllzBrxrF6teEG0UAJsJ+Pmi6HdIWE/N+
         St+uQIptvyoPuwFQwjYd8A+7G+X0o5YDhTwtw7qFzQY7bEZrkbZ3wVMFqdryj+GN848d
         5t6KMmbu2NGw4I+E6+ObM28lKZgMe9AOsTJaYxrj+F+AMxZ4PppP5VIYUuQfpA9T4iOQ
         Olz6u15MnUvDdvTUAuwvSG+saSYVI0f1YKZ6zagGozD1YvVfHOL1X0n3QzzpYdCwxR+3
         ZhbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787362869; x=1787967669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZvNPSn63dNk+c0MWwyzpuNrWmftezLJ2XLIn9JInkRI=;
        b=TXXGPJdGD4C6JTXRDkUaPy9pSwSSlqrJviD/udcvKz+BbZe1OH0E6XSLhSKcB6KQ2x
         Rx55o5Ry+T6/JGpltsARhIfIoVy/+rURMHhnDTwZtafBafWgO9PptQ6hn3olZ/rASndy
         tF4e64zitnSy2W/UF9VWNG4uGMEEb2PJTmQQbx0M4l8/kUusNaeaytd8a9E0adcR6TsY
         fJ27DxIfzG4nfqucX7Zzmp11vKowc+kvyBOL5KKVl9MAN3PHvBBcc/rrL2B9McZ2v+pF
         lynOxhyeOUWgmCjGKchPLE8uk4dkKsgG7D8qgXRKw6gy2QpqGO3iTWAMlQZjRvpdmkuw
         7qYw==
X-Forwarded-Encrypted: i=1; AHgh+RqqvK6PQN1DMh9NJ0sDLhttlewVrisvdmVipdbyIh4sy1+6d36QkUnY4m1G9mTu2jI7SF6Uen0dP+i5@lists.infradead.org
X-Gm-Message-State: AFuF++ktWirSDAowblnF4AQS2YdAY51f+tlwa5FlxeWDYKaA3J1ZtLLa
	d38GZXPxCgMpOm6/pbhDYFslq6/KfarSHJkWNSQjyE1QtoDoQzSbXeyK4p/YrsqXznw=
X-Gm-Gg: AR+sD13SL4Gl9z/QoejbgALWjKtrghQTc6wY5z79lnvcyq6w5x19UctuEEHMYaj8mr8
	Yy8yb0LxPipQkTdLQ+jyDn5iblJem47I8IGyfGUWjDmR+FLtzMNMsqYcqGjjohgYZOUoKLemnb7
	lRhjViiemiYnI6Ew7t2RePmf35C39Ur2g+Opw++utvVxivSwL++vgYQcqMGhTMM2vhcmvevOySJ
	K+bysCngY/JCpIrHhCZzghnh7ecPl7R4+AOLdMg4cPGRHNzVgctTpesV1ljN1yK01qiyoJ12WYb
	kfigrmCE0gT39MDVZQ6b+xvpcEIR5Acpzg8PBn3CShNuwQbXAl0rMvmOQw+K7vhtIas0Q9q3mDJ
	Uu7MUzzTaaLnaIhP7IReBkh5tY9sSaLFintfoxaDqTySgeAIpVxzZ8Y0qy4R6sOWIYUIdqC5686
	RiwBWMZHquGKjT9aflYTAfQwPX0ChOmh10v/hnVGErVXFkyNjRFJ4jjh93vwh9a2PSnud0JS3VH
	lG8B1HGpHk=
X-Received: by 2002:a05:6a00:ab87:b0:845:ce5f:c926 with SMTP id d2e1a72fcca58-851f9a4a6a8mr18184601b3a.1.1787362869280;
        Fri, 21 Aug 2026 18:41:09 -0700 (PDT)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:a627:8da3:af81:18cc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520f03b014sm160373b3a.36.2026.08.21.18.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 18:41:09 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Chuyf26@linux.alibaba.com
Cc: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-tcp: reject C2HData for a non-read command
Date: Sat, 22 Aug 2026 10:40:37 +0900
Message-ID: <20260822014037.1978918-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178730451245.442148.11684394617763960186@linux.alibaba.com>
References: <178730451245.442148.11684394617763960186@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_184111_486780_A6372EC8 
X-CRM114-Status: UNSURE (   6.10  )
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

The same check was posted on 2026-08-18:

  https://lore.kernel.org/linux-nvme/20260818110405.590548-1-yhlee@isslab.korea.ac.kr/

It rejects the same PDU in the same place; the two differ only in the
return value and the message text.

Keith, please take only one of them.

Best regards,

Yehyeong Lee

