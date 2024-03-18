Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1ACEC54E5D
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Mar 2024 08:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:
	Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yNVmnw5toWb8ERcsPGfVr3oGNxB/ZS9svnfOKz1b0WI=; b=2XcCnzb9Uyh1Iwuvh8FZ/Y2e/A
	alhmRQJqlyunhKNJOiF5i1L1fqaLoaL7IWHVjIRMXPTqlP2dDUfATH4XSxLqaX8HzVLatK0LI5Hnm
	Om/Db/WJt5VUZCAHvxHPNcVmdRB5ep3FJCcf95bSxnL+HUzrlBTynm0vf5pR+epKOya5Ae2NOG7QL
	rFlZxIKfyys9AXPMkgULD2iYzc1fJljQqcXmiG4sj+Gtb+mbWWYTx/gAO+0Bw2DwhJarnxOtw0Fu0
	igsD9cXZ0XcsB/2kzgDF1StNXncfCzvwNqsOGsvQ1+rz2ADXD8OaWkdzb1J/i9csE4Pm3U3KxwANU
	OE13iGWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm8nP-00000007pNZ-2RRk;
	Mon, 18 Mar 2024 08:56:39 +0000
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm8nJ-00000007pMo-0hYw
	for linux-nvme@lists.infradead.org;
	Mon, 18 Mar 2024 08:56:35 +0000
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6e682dbd84bso994536a34.0
        for <linux-nvme@lists.infradead.org>; Mon, 18 Mar 2024 01:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1710752190; x=1711356990; darn=lists.infradead.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNVmnw5toWb8ERcsPGfVr3oGNxB/ZS9svnfOKz1b0WI=;
        b=wETw0vRfryD9HHbf/dacrEruMsyMal3BsJvwFNhoWSBblWov2e9uC34OR+YnM4BvZK
         wNNoNXgUEdD9p8xH5C3S6+Irs9e03jNGCASb6igLVifQYX/0aAlCZNRxI23XVGQLeVwd
         No1J97URMY1n48xjaM8iMFI5mee9jC8tSxGUMY9V0F/fBf5VcdF8pACHieizXEwOWIM9
         MMCoe4Xuc3KKZLkD9OmBQgslENTDimp3AQ50200vpDuce1uyvRCql1G1voVtviAe5724
         xpfVCZumiSilRFS5hlrztxWjuHz5MKzvBJRtxGaJHRD7MoOpISxHmPPQWOeLu2c7v4A5
         9xpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710752190; x=1711356990;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNVmnw5toWb8ERcsPGfVr3oGNxB/ZS9svnfOKz1b0WI=;
        b=FWLGQIKSGHAQeeyVPZZqxbyoTNs9ArPveRXs916KuCSkQh/OchzIQY6RQRJ8XGLcBQ
         PiNix3A19zbQd67idFmyFB7WvlZdKWjn3nUT/9IklSZW3U7/ap+NHVAZ7b80LriWte12
         LjmhvJP2gYH+iG4Ey8Mf8oEyblyC2wfZZDfsSdgFooECQVHrOBzFIy2zhQBqeyNVbDVt
         k/gTM+P+Ld+otqXkYiWR0mPg339TyE0qeMnHEkhBUabg7aj77hRY2H9HcYQ8dNaqZlCQ
         KBBZSXoBlUdZFUfbPumjeYqWpk1ZQkyqz7hmoKIzSkS2gv/tJEAH4lh8i3e1ZWRJgt33
         VttA==
X-Forwarded-Encrypted: i=1; AJvYcCUzzTTOT2bp/VqdpPfOLTstFC9IQodj3H98/P+Kc9Kuf90CrrXKkhu6HhZqn/JeM4aDFq0LuJaGIdOkDFv9qkzN69SuzVXhKuVmaEwMVek=
X-Gm-Message-State: AOJu0YwdvHDJWU94UQ/fM6txQo2gdp3Fm+tNttFuwapnSoXuIS7rZt7l
	0t1ci6ZRAYSBdh+c1buo2EQNuWqrwOdAojFsx/5s+XA9CxgcqbJTEP2H8bmoUgh9QvOKKbdugDd
	U/2BnfA==
X-Google-Smtp-Source: AGHT+IEdO/tHuBAkjt3y9oKQtxXQsLM0K+r5V5CdjrWyRPB3aidDD7XCyC+3s4Gpea/J8A7N65zmIQ==
X-Received: by 2002:a05:6830:168d:b0:6e5:390:5b44 with SMTP id k13-20020a056830168d00b006e503905b44mr13391333otr.30.1710752189570;
        Mon, 18 Mar 2024 01:56:29 -0700 (PDT)
Received: from smtpclient.apple ([8.210.91.195])
        by smtp.gmail.com with ESMTPSA id d15-20020a631d0f000000b005e4666261besm6667101pgd.50.2024.03.18.01.56.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2024 01:56:29 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH v2 2/2] nvme/tcp: Add wq_unbound modparam for nvme_tcp_wq
From: Li Feng <fengli@smartx.com>
In-Reply-To: <096362ad-174e-4939-8296-e0d11f83a120@grimberg.me>
Date: Mon, 18 Mar 2024 16:56:35 +0800
Cc: Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Anton Gavriliuk <Anton.Gavriliuk@hpe.ua>
Content-Transfer-Encoding: 7bit
Message-Id: <9E577C75-AEF2-4C22-8B85-4BCE8E2B65A5@smartx.com>
References: <20240313123816.625115-1-fengli@smartx.com>
 <20240313123816.625115-2-fengli@smartx.com>
 <096362ad-174e-4939-8296-e0d11f83a120@grimberg.me>
To: Sagi Grimberg <sagi@grimberg.me>
X-Mailer: Apple Mail (2.3774.100.2.1.4)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_015633_369371_BFEA5311 
X-CRM114-Status: GOOD (  10.88  )
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



> On Mar 17, 2024, at 15:31, Sagi Grimberg <sagi@grimberg.me> wrote:
> 
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> 
> Does this get you the functionality you want Li?

Yes, it meets my performance needs.


