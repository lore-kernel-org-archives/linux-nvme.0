Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B667CCF2C9
	for <linux-nvme@archiver.kernel.org>; Sun, 18 Oct 2026 15:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iXU5ohTq56jh+XXBAIYFfSCpOkBLubZ8A3StYlMA9NU=; b=Nr15hPu4HhZEWtiopsCUD/8OyJ
	9cG+UFSO6mQmOhGyvtQw1Qe2hTyw2SbxBN56vXtH+NKssIEEVisnok/4wy219tSROlrzxggh2pmUx
	qd3emE+/MKHdxQDd+/NQhVnvwSu2y3XbF6Olwvp5TO7LAk0Peya5LrG/GTgrvhrurN8Ic35M10kc6
	ncu7Bc1EVUNIehTveYH9BNwoj2Z3R1aKEyiity0NfIqV2JNXkLC0L9yPZfFsd0jbbInxfYyXT9/aG
	v6nbJl+o769lSx2Nvxs+S4wdI+vA064q4BWTYhMoCTdOXIGxwVbSOLv189e63f3vnkQa6AcXilhag
	OOJx0mpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xITDW-0000000610L-1157;
	Sun, 18 Oct 2026 15:54:34 +0000
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xITDU-000000060zr-0vTw
	for linux-nvme@lists.infradead.org;
	Sun, 18 Oct 2026 15:54:33 +0000
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-49d05d51553so8650395e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 18 Oct 2026 08:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792338868; x=1792943668; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iXU5ohTq56jh+XXBAIYFfSCpOkBLubZ8A3StYlMA9NU=;
        b=nox/0CTgEwAAPrxfXkd9QKbTXsFOoXsdptyJkfSfxGicECfGXDjdh3+o1TVodvUcF0
         frjEUp5Wg35haK/kUt26sw1n5ptjk9IlpHI7KCrShFaKVl8WapGmoqBegPuXeS51QzW0
         g5uYxdGlBogZRFaEdRZjvLXEOxll9cb6IUI9yBd3W1JP3BgXs3DNCPjqf7hk4BVl99e+
         q1gzatq8Xs4dc1VK8lEM1qzJ3g9leuH2Ng6o0v+qS8N1uLE9Y6lk/4Uwqt5f5/UCqLOF
         OP+TI9Ed8RQudf0MjB+jhaMB+8qvWXsS0C+bX0fDkQfHSXJmeLae6qDgJ0bB/JPVEAs4
         E8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792338868; x=1792943668;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iXU5ohTq56jh+XXBAIYFfSCpOkBLubZ8A3StYlMA9NU=;
        b=NUXS6gaxmgZGsyNRvfPgaE6a73PcCRfvCrDVsHzjRMJ9R1v5YYSEy6mnejG3QlRm69
         m2n3PgA2ZYK89wv3rs3n8n85ciiv91VgBbZKlWXnCpT+uQ2o+UgXAjHtdXwE/m/02IMV
         ff1u70di0iq+myP94w9ZRz21VrI5PN5z3yPj4TJbZYhbCXmGe6HjEjmpAtuy8uZ7n2AX
         +wDJdZsxrm2UISaZLC2R2hNNgCwaZ9pX5lpsW3BlyHchsbcqYTXPTSr7akWajs5KfKGL
         HfEv7azAUZyRD9EKiMlWg9D+J1q2+alw6/vFLg5+Q3XycsCUI9KYYBjLyea0mRiM6/VK
         WW9g==
X-Gm-Message-State: AFq9FYL/LQQPKB80tcJPouOs5go1SxnaIjI2tdSwACic4FzCLkU1rQ9I
	7jeVrIZMDbFISLuT0yBvDw7wCs3hEkVE4bfvQniBRBIXGHfvdGYjU5hB
X-Gm-Gg: AYBFou2uMRDzrNZvnbnxgb/wkVF2XrEIFxP+KsH5n1L+jJjf+tmUekKjw2GFLfitH7c
	ANnrONchJATA4aik9o3n/6t1CN7cRnX1+jwxOhdvfwja57YdsHqTBxf/qQcZQNQY622Io6qcmzs
	vPiCw+t03OTeUFhFXh4+e4TWTIHNYcbQ54BR1jEBrcr8BEXXHgrSvtyePISSkku8tSUueQIQ41q
	H4rSsS2oS6EBFDS1J3kJdIw1hoCObGz9h/JGeEaTkWqLkXrmKpkbO3fr8/cRAdQVORH0PA5GDpA
	K6cAbbS5tXZ11Ji1FZYRO2/SuFK4sdTR4zpJDIMWDACbKsLhjfXGGMB/AutT36xQO5ELj2y2Zrk
	Qw4EE/6KjH4pPNlND2Wa3GhdJFpKsiuBuhoyc83A80QOFtOtsIxFgPVMh2H4j7/JOnSxwpcPbq/
	fI9K0itivKfGfKAHXTi/nPHMQ7WsSYk7Y1rFemBnRK0/ciVpOZMh112RHXhCIaRvAawRI7BHpeD
	rbyPX/lhaWD3KJJvakoB2zVE1mLvmF8GieYy/Z2T3QsGhyouybZsM9JAJhEzAoTRAGAfJ1iyPAP
	as+y6DCVUXM=
X-Received: by 2002:a05:600c:628e:b0:4a1:df70:b4a5 with SMTP id 5b1f17b1804b1-4a1df70b5c0mr79829815e9.7.1792338868189;
        Sun, 18 Oct 2026 08:54:28 -0700 (PDT)
Received: from hermes-agent.lan (228.red-80-29-82.staticip.rima-tde.net. [80.29.82.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9b8ebdsm335355615e9.10.2026.10.18.08.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 08:54:27 -0700 (PDT)
From: =?UTF-8?q?Ram=C3=B3n=20Jes=C3=BAs=20Miranda?= <ramonjesusmiranda@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: nvme-pci: nvme.quirks= on the kernel command line hangs early boot when nvme-pci is built in
Date: Sun, 18 Oct 2026 15:54:26 +0000
Message-ID: <20261018155426.1299676-1-ramonjesusmiranda@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261018_085432_290856_83F7490A 
X-CRM114-Status: UNSURE (   8.99  )
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

Passing nvme.quirks=VID:DID:QUIRKS on the kernel command line with
CONFIG_BLK_DEV_NVME=y hangs the kernel immediately, before any console
output, on arm64 (Microsoft Surface Pro 11, X1E80100, 7.2.8).

As far as I can tell, quirks_param_set() runs during parse_args() for
built-in modules, i.e. before memory management is initialised, and it
allocates there. As a module (nvme.quirks= handled at module load) it
works.

Removing the parameter boots normally. I have not checked other
architectures.

Ramón Jesús Miranda

