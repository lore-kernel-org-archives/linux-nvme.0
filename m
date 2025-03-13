Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23742C28B2E
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Mar 2025 09:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XUJmmUk/07zvVDebbkY7gqZx1aQN0BEIXNKF8zNXE08=; b=T8Lkp+HC2vtLZU68wBGNQmVRFp
	VHyoP/gRyVgCrGlBucknySdpxY9RDPux5CVu8xGQyPE5s29mLhmZkVrQUmsiNXoWVRp0nX2EkOlp3
	xxw6PiKO1z2SAirc4pf5Njv4rFa0x6sBgGvpMDUmIZlCILjATJZtoYyLRzLMJ+lywn5yy+Elkm2/y
	6NCh+3Y42IxyCDzd3HE0oO6JkldBtVp8JRWVTT3w+gilJIJxUsEn9eKdndwUopsmfpLdp20/XIgWx
	eHY7Rhmsnl312oqeG0jMdbTy7GmoEQU/ZE4bafqRoMUWOr0qwseDXmr/n1x9dXiZ3GLUbHtHQbVfy
	6Om7WQLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsf6i-0000000AlGQ-4BSQ;
	Thu, 13 Mar 2025 09:44:05 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsf6h-0000000AlFJ-22Pm
	for linux-nvme@lists.infradead.org;
	Thu, 13 Mar 2025 09:44:04 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso6123245e9.0
        for <linux-nvme@lists.infradead.org>; Thu, 13 Mar 2025 02:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741859042; x=1742463842; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUJmmUk/07zvVDebbkY7gqZx1aQN0BEIXNKF8zNXE08=;
        b=mD/uG29ADxu5An+DwcOCWm7u0g2Tku4CO3KksxlslG4LbkXTz/rR1pQwx9o7pL2XM2
         GKhA7KQzpafxcV33qPvatlSOHtDboVSrZyIJ1YT3FZFKkx20mm8x1TzIQRGpi9ChzV0E
         hAGeZDqtTKaWS6aV80e6xx9md1oA0EUIDzVO0wcRl2WF2HazNWrTgwuYdoKfFTc+j4wz
         170G4YlJ1emFgnAI5TZNldDC5Gt/4QD8o7WgoLYRdHzgnxDWBjYaQfL8ss6koaRK/w8S
         drp861DPjrUrH5cTvx0VAtnsWsMH2x2N4JIv9AlzmdiCt6dpCBXimM91jp0gvK2QXRk6
         vHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741859042; x=1742463842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XUJmmUk/07zvVDebbkY7gqZx1aQN0BEIXNKF8zNXE08=;
        b=jdXDJP+GRLbsYoxXWGN1c/J/8ebxlNGVKUyavII9Fpr6f9GYunXO+n+CvyWj1m58CR
         UEUBhkpRaGCEJlRZKj1DbthgF4CJNx5raAC3LjFZP23hSKMe6MCYrTuURfTNeTGDPQ2o
         RKFp09jPicpDxXzAQMOHdXQOCVfH2v0Xwh6Wcada+BFEebYTMMu7CQykEZ3Q2glT8Url
         /AZD5/Hc3D4yIP1B1HpySKMOhQ3382Yhl3yWByD9D6LLCTw2F9LgwEllHNqQ39Bm26Jx
         t+MtmfL6yMZm/AcA+SlGqa1G6wenvFeym+eHOugSAksGdd4zSIL6nCzZg1Nb5og1kuJh
         bvHw==
X-Forwarded-Encrypted: i=1; AJvYcCXknFnfRpLVrmp776yGNdeWQ8uVAHe4YHCKSPIjvu1x1pjkgaCYs4aV61hw12UYIAz3B6UHYajUnZNh@lists.infradead.org
X-Gm-Message-State: AOJu0Yz6KvVrIkHmD4XBlfkRz1DWUUcWJdNB9CyNiXJJpWZ6QAQse1eP
	lKSLe6bL/LXpf5uau4L3bc90wWpG9GxrEKOm1vAe+sdjyVvaoUfp
X-Gm-Gg: ASbGnct9Md1LQb0OeN77t7H3i1TnRiFL4rO2N50Vwa+VBSpMv9yVv7z2nRnB4E9n9w0
	4aMbyDnvNW12FiK65IO6YS2DNZVcJ33277okjPs9m4j37vPIr6yMcUbGJe8cS8EyK5MLn8B+/VU
	mGqC2H3DEtvGGGVSEeeCMD0VTiez/sY7X1hMavohluyegKs8YTEnIQ+KrU5wjNhz0oMVCRWPvUc
	qPQMzh9/AsQBeVnJOz7fbDoLkCOQvoh6ppnstK0shL23DMkbUhC3qz1+j4LvJ/bNK1hyXHzMpts
	WEl/IclckOqVsSJ4umB8XfuVyXh/fAlA5V5G+/pyE2kwUZ2duMFLGXld0i3MUbRTlOMhebcUqxv
	+yNFmg5U=
X-Google-Smtp-Source: AGHT+IEmmbcF0ODRKe4fmMsHDHsI7+wnGoFRrNeO5xpay+Qmm0MBcWmeFOZRVaD+g3RmvyNJTm7SgQ==
X-Received: by 2002:a05:600c:3791:b0:43c:ec28:d303 with SMTP id 5b1f17b1804b1-43cec28d49fmr174424815e9.5.1741859041417;
        Thu, 13 Mar 2025 02:44:01 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c4f9d59dsm1547427f8f.0.2025.03.13.02.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 02:44:00 -0700 (PDT)
Date: Thu, 13 Mar 2025 09:43:59 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Hannes Reinecke <hare@suse.de>, Vlastimil Babka <vbabka@suse.cz>, Hannes
 Reinecke <hare@suse.com>, Boris Pismenny <borisp@nvidia.com>, John
 Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, linux-mm@kvack.org, Harry Yoo
 <harry.yoo@oracle.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: Networking people smell funny and make poor life choices
Message-ID: <20250313094359.20756456@pumpkin>
In-Reply-To: <Z8iTzPRieLB7Ee-9@casper.infradead.org>
References: <db1a4681-1882-4e0a-b96f-a793e8fffb56@suse.cz>
	<Z8cm5bVJsbskj4kC@casper.infradead.org>
	<a4bbf5a7-c931-4e22-bb47-3783e4adcd23@suse.com>
	<Z8cv9VKka2KBnBKV@casper.infradead.org>
	<Z8dA8l1NR-xmFWyq@casper.infradead.org>
	<d9f4b78e-01d7-4d1d-8302-ed18d22754e4@suse.de>
	<27111897-0b36-4d8c-8be9-4f8bdbae88b7@suse.cz>
	<f53b1403-3afd-43ff-a784-bdd22e3d24f8@suse.com>
	<d6e65c4c-a575-4389-a801-2ba40e1d25e1@suse.cz>
	<7439cb2f-6a97-494b-aa10-e9bebb218b58@suse.de>
	<Z8iTzPRieLB7Ee-9@casper.infradead.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250313_024403_526934_ED9429F0 
X-CRM114-Status: UNSURE (   8.57  )
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

On Wed, 5 Mar 2025 18:11:24 +0000
Matthew Wilcox <willy@infradead.org> wrote:


> What worries me is that nobody in networking has replied to this thread
> yet.  Do they not care?  Let's see if a subject line change will help
> with that.
> 

I like being smelly :-(

