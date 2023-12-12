Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1CBC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Dec 2023 18:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4DvNWg8xxVpBf3eNii3gmW2LZW9Z8Ffh/DHKXZIoFOM=; b=JCXNqtGQSt7SPjrkrakYgFfjhC
	44cVYcmv5Mw1DAsqnU1mQqnVbbB0RZwYXm+0EtXq6fUqkicY7LqDnA+Wv+JOh9zUULWp/FHzrfcOh
	LQMeWx47IM9okIujUG5H3kGzOzuyouH6kq0njdBBDaQOJwvSQrKDLZrY9xVA6eKOUBbmZOSEgYzVX
	8AWtfKVhjN3bLwaZvZ+WAdcflNEmVHJLHVYAnsICYJXdIwvP6bq6DvmGYG3Au/kVTEF7TFyDj1zy3
	nTPWSgUZb5nawTCabjFnetEFdsfvtiMOdkPHCXrVD+v3yv/D2N4Ov/nFe7QP1sY1+FrdPtGmvrT10
	V/DDarWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rD7CW-00CSgN-2q;
	Tue, 12 Dec 2023 18:09:48 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rD7CT-00CSfd-1s
	for linux-nvme@lists.infradead.org;
	Tue, 12 Dec 2023 18:09:46 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6ce76f0748fso3787192b3a.2
        for <linux-nvme@lists.infradead.org>; Tue, 12 Dec 2023 10:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1702404583; x=1703009383; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4DvNWg8xxVpBf3eNii3gmW2LZW9Z8Ffh/DHKXZIoFOM=;
        b=NqcJ5OM1s2PeR0tIVFb0RAW6b1rtxCFuZrBygTQdP0YZOLgQAnyZS51qjSRY2puM1Z
         vvo7KfkR8peHrZrfI9ob1G1HU0IEMtBRCLYbncDkg6rVjqqPc03jT22ON90LnwUtXklV
         RIZmtb56+q3r3xhvVpZqXcP53Vy0sawMJT0euUzXcbzQcR5ZSmPe7wAiQ1A9ORrMsPVr
         ry5bZYTK7TWip0W1DOhBiHedag3cKB8ZKU36CZe0GskT/h2KYtxmBNHBeyaHgLSFnScR
         zsfCdLQk5PsVKOvR8kmtYkHfGLCXjnbIqPg84UGpgWnsiN3ajn1ohWrjQ7sZK58VU5jo
         HyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702404583; x=1703009383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4DvNWg8xxVpBf3eNii3gmW2LZW9Z8Ffh/DHKXZIoFOM=;
        b=BKUiozWVhVXvrW7jfvnFBzzds4ODGWDhs+zHeJMC6PuIqDYUtO3uQPERB0sV62TXEE
         pPYZlzCYck9unQwADamkV0nKdpBGAA85J0QRiXjH6YXwSa5t7eBqH3eoMnoFWOr11z+1
         0kF/27wmHIwgv3Rw1OpwTiH5t6ASrLCriC+8eJgA6IY+No3FckjXFre97N/2GSzZLI4U
         eOQpEVnfsOfMZvs++rP/fMvTDcTFhs24bjfVkxV8Nzpsiorq0za3eZFLCJMHKU5RKe63
         4SqdvjOtIzF5nfyYpI3auBZNKqLAF2CSSJGmuc+Q7dDvAAtJxewF+kiVTLRBcwY5u4qG
         uYkw==
X-Gm-Message-State: AOJu0YyuZsC4Pm42BRQyjvDAvFp30b9qc0XdW9kBqNox2N3yZTdUJmYS
	GDFr561gUQHpy5m1isQAUHHL4g==
X-Google-Smtp-Source: AGHT+IFmTPY4Y8G0VXdpaaGQryBm/BRf9k6z7UIP8JSnlcfVUkpx66o1BEIyiixqhSCU+H04zRNOfg==
X-Received: by 2002:a05:6a20:3d26:b0:18a:fbd1:8e1b with SMTP id y38-20020a056a203d2600b0018afbd18e1bmr3811875pzi.26.1702404583385;
        Tue, 12 Dec 2023 10:09:43 -0800 (PST)
Received: from localhost.localdomain (50-76-39-125-ip-static.hfc.comcastbusiness.net. [50.76.39.125])
        by smtp.gmail.com with ESMTPSA id x3-20020a636303000000b005a9b20408a7sm8419861pgb.23.2023.12.12.10.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 10:09:43 -0800 (PST)
From: Jeremy Allison <jallison@ciq.com>
To: jallison@ciq.com,
	jra@samba.org,
	tansuresh@google.com,
	hch@lst.de
Cc: linux-nvme@lists.infradead.org
Subject: Make NVME shutdown async
Date: Tue, 12 Dec 2023 10:09:35 -0800
Message-Id: <20231212180938.397403-1-jallison@ciq.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231212_100945_625051_55E07168 
X-CRM114-Status: UNSURE (   6.92  )
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

This is a rebased update and resend of a patchset originally
written by Tanjore Suresh <tansuresh@google.com> to make
shutdown of nvme devices asynchronous. Minor changes
made to use an enum shutdown_type instead of an
integer flag.

Currently the Linux nvme driver shutdown code steps
through each connected drive, sets the NVME_CC_SHN_NORMAL
(normal shutdown) flag and then polls the given drive
waiting for the response NVME_CSTS_SHST_CMPLT flag
(shutdown complete).

Each drive is taking around 13 seconds to respond to this.

The customer has 20+ drives on the box so this time adds
up on shutdown when the nvme driver is being shut down.

This patchset changes shutdown to proceed in parallel,
so the NVME_CC_SHN_NORMAL (normal shutdown) flag is
sent to all drives first, and then it polls waiting
for the NVME_CSTS_SHST_CMPLT flag (shutdown complete)
for all drives.

In the specific customer case it reduces the NVME
shutdown time from over 300 seconds to around 15
seconds.

Thanks for your consideration,

Jeremy Allison.
CIQ / Samba Team.



