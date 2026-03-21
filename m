Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F95108B8FF
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Mar 2026 07:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tYv8NSPDpZJ95g8FVV342Y3MV0/TZZYtvHbpGnN4m+w=; b=C5GrxQ9JtP/Kc13g7EIFJVaZ4a
	EgCutvMS/7J1lidUgHFeDZZ0cHsAs0s4oLl5xEiUCfV8mOBx6PUdHMYIKXrA+8GEr1Ddze3raIbY6
	KvNZz+ZAQAdmcOlzQl1HnYnKOz72OtNcbe+qKGkMFTQaBu9GmnJ2LnqwcnG3AbBx3mSxB5989eolT
	AQ76pQS8xd3WN+fEjuudKNcFUey9wc5Id9M3IMOyfaGvLep7Zutviv47rlMLWQ2dtjk43amwZGr+r
	M+aRj0FF4U8JCCZ/mDujKP/zEd98rJENey/XJVc5noQNoz5gSuAnQTJw98estEH65rU+6q5hDmDfO
	uVnjg6BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3qcF-0000000EBtK-2mqS;
	Sat, 21 Mar 2026 07:19:23 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3qcC-0000000EBrn-3tZp
	for linux-nvme@lists.infradead.org;
	Sat, 21 Mar 2026 07:19:22 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-48704db565eso1839835e9.1
        for <linux-nvme@lists.infradead.org>; Sat, 21 Mar 2026 00:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774077559; x=1774682359; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tYv8NSPDpZJ95g8FVV342Y3MV0/TZZYtvHbpGnN4m+w=;
        b=L0Kpk8VMS+CGOgnJM3UoqUIMzbHH+yZy+p5M6IngZoqliNR56IdyviHcaxS1p4vxOE
         I25WevZNLo9LFVpMadUg3rm+5RT/QVjQCMF/xcpsRuo6k0RIazzeHGZNJLUTBxqJaXgi
         yvh5Q8CPXsonXlrfkHq4SKKE7p6r3+ZLR4L1EA7Y1LDM2HQgGtW/+50XhLkF8oJXDSsZ
         cow+17bHS5eD5vUoF+ALm8lMbtBUbpjpGu7Nsll5droIsH9zJYhyKWGD14i4R7NEXIyx
         p713DT1ZjLzIJpU+C974jl077ncPoKgSt1U09/G9KlzLggLtE/+SkY1XGD3R9P/SWb74
         GOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774077559; x=1774682359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYv8NSPDpZJ95g8FVV342Y3MV0/TZZYtvHbpGnN4m+w=;
        b=i1iJve2UZ4vEIh4pZk4oXjuW1PlAJxEM1TvaGtUPM4rxaazhjzjCY48lAjQ3Lixw4w
         2L+vaVe2oX0xtEh/5sysZKvz3VB9G4Mf6y13kbkvRHXoOAL9QQmNFf8FLcoIY+UjnoJN
         fKu6+jViVYjTt7XNEHQ0EhR0ijOqX8rIgQr0rAIiwHgOXgOZ/AxAnURsLN8UotsNd+xB
         VawrXNTi+zgW5I6NPAtD1YPEOA0hzVkOgea7KYEj63Td+guaQ0zaqeBCt4q3uHYEaM8R
         NPhV2SfydgoCqpWyjpA5RBmFPqkJhm93sqO1ggrU7NBIgX1hW1AvatJrfNVSWDwDLT9p
         qVxw==
X-Forwarded-Encrypted: i=1; AJvYcCXDn8i9vdMkpyOPfaytE+4mqkk/JeKp4SKqDkeiROZcEQz/kHY3ZKHuym5J/aPuSfFt/UYWuci6C8cc@lists.infradead.org
X-Gm-Message-State: AOJu0Yx/ZmYXgvig54J6MgnLgcvkTLQXJzGKgoHbefWfh+zcGkuhoE9B
	asq3pBNU5PZ3mEjMaarB+AigzKpqAXWWCBZHdFFhr4n9tUZ3o+vdILyAhFDnsl3CEtc=
X-Gm-Gg: ATEYQzyt4irrUknu5pLWVhdTHu3eqpS8fzOmaQaGv8PW9+vJDpkKhYb2sAxlXhYx2Xq
	m3E49V7NO03dTY584eVSF8OKqvH6SHJYiAQ66fEL0d118+aevYtjvkhmjAP5/jNiqGKIuFJMqED
	og8Vdq0wGHOwkmuF6bgQflZFoTV+6CUEK7AynQAOvah0n843AnH8Seyk0D3aXmpb1fDyjfHYn+Z
	ZC5TTVsD5eeD54FpmJ1Qe9Q3Hj08wQEqGe+CtEshM9qLN5tyY7TVkLFVHBDTxaBUyr9dpoA0k7f
	1Wj/kugMum4SlquJPXo50ePzX81pS070gMG1jp/mIh2pZ9gnphD2M88Bx/PSsrmjeEwRKW9vlv4
	GEW4Acidr7LboIiwWxzRZqlQiOnjr4BF+fJ69aRCP8QzTpOiLKlG9Aa687dcbKsvHJAVHXM5mPu
	y/nvLRKkzahJ+PL+DDunNDSpWYx3ii
X-Received: by 2002:a05:600c:1f0e:b0:486:fe23:1707 with SMTP id 5b1f17b1804b1-486fee08a04mr74936475e9.20.1774077558381;
        Sat, 21 Mar 2026 00:19:18 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6471a297sm13050436f8f.37.2026.03.21.00.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 00:19:17 -0700 (PDT)
Date: Sat, 21 Mar 2026 10:19:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Mike Christie <michael.christie@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>, Chao Shi <cshi008@fiu.edu>,
	Weidong Zhu <weizhu@fiu.edu>, Dave Tian <daveti@purdue.edu>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH v2] nvme: fix memory allocation in nvme_pr_read_keys()
Message-ID: <ab5GcjyKnKnqQ7ob@stanley.mountain>
References: <20260228001927.382810-3-iam@sung-woo.kim>
 <ab0uNATxCVlnKi2p@stanley.mountain>
 <CAJNyHpJm8rwivxM2bSvRoqi_yCeFTyXVY+z0oub4Uc8stUN55A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJNyHpJm8rwivxM2bSvRoqi_yCeFTyXVY+z0oub4Uc8stUN55A@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260321_001920_976990_83DD0CB0 
X-CRM114-Status: UNSURE (   9.22  )
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

Ah, yes.  You're right.  It's the nonsense:

	if (rse_len > U32_MAX)
		return -EINVAL;

check which confused me.  Commit a58383fa45c7 ("block: add allocation
size check in blkdev_pr_read_keys()") caps num_keys at 65536 so the
rse_len can't be more than 4MB which is less than INT_MAX (2GB).  We
could remove that check.

I will send a patch to do that.

regards,
dan carpenter


