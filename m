Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2468DC30653
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 19:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z6Ve+nUcofYX1LmdQVWTtjSQW4Js4X9gX2B0JpDOk5U=; b=eazBgn36xQWxfJTqQP89wj0pQm
	Apl7LMSci4FUzyFXrX+f18AjW9wKhGdWFH+RcAOPMq7mDMK6lvuDiJXAAkHoFXyD6ax+vOd+E3E+E
	ewBBGVkeFNE8LtROtdGa1brnGkuVL4t5bCXUnDMUo6s0s8VFbNvPyUTItk4sskNOq1D0jT3pu5dJo
	i7dBVzoSAByvLhWV52g6YdP4uhWK9daaqj9YQ58WFhJVJlBNjBtVqDyMqeADSofFPnej0U16mOicA
	VsEh7zLUVgyIJPNx8+b9bA3AeK3tx91aMYKi5brY6JghWW1LypyLOZs0k8z2W3lozIgLfDcN1WQWS
	Njo+FXFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP5Tv-0000000BG2O-1Z6R;
	Wed, 03 Jul 2024 19:17:31 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP5Ts-0000000BG21-3im7
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 19:17:30 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1f9b52ef481so31551965ad.1
        for <linux-nvme@lists.infradead.org>; Wed, 03 Jul 2024 12:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720034247; x=1720639047; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z6Ve+nUcofYX1LmdQVWTtjSQW4Js4X9gX2B0JpDOk5U=;
        b=Qj007igAEOfnBs6yzzL7lmYAAqvYPweA6v7cr6935niWMAJgLmlaJGyBdt8OMM3wRO
         u/1Skn2vlmLcT3Vfd1UACbDtWzeGn+WAPSomy2Zc8tfYvYQqLT0KdZlN3LjjCin9ymFf
         HJaI2FZAet+rj1DFECJ89EDCjrfxZVBQJ1d1UVKbZx20qPzk2oihqoLOWlv0BHnTveB8
         +TeVz3iOB+c9dXszPwrKNIuZWpPb+eKMGLjWU+LAx1tQK2uBE/Km6Re/xqXSeeFW5+nb
         UO0W7zcqJusrc8nS3crWQEQwKP8ti7Z7K4KBAcyrxLlExl9FT54RbMax6t/33jSNmz13
         Y2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720034247; x=1720639047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6Ve+nUcofYX1LmdQVWTtjSQW4Js4X9gX2B0JpDOk5U=;
        b=czDymAoy0PwuurjaJaFzIejClqOAa1dJL21kE1vWt2W5jyOrVR1WflglJWnnhPiPKU
         7RpsKKzZk5QBspw8KkfgYcY+N381SiXymNnaQbxy18QC8JdXBfWYlIeIFkQ6tN5NLINn
         ba9glnm0Lg6hcrC4eh5laSPU1xCQXlzYwPXmG67oLhNCnRDft6VkAHW7pR1yGNtdFk3L
         VsGD2lRNsXj4+Hx8VCImGfLFwOguNhZLGW3uwPlZzTBnf75UsdXylR/+33NKADTRG1st
         dXt++olymtNbDAg67j0ndrlhRCb8ZZ7Z1bopVsA09q8gyAnOOFGwKIMQv7+LmYoKqFYh
         TIkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhbt+ic1fFdLf1Hl//2Us4zrPbquchfh7wDJFFYHcmXFKpmlyT4V17sLC3XocAXlAAY7xt/6DG9L7MVfUlYbPd6fBqqwJunZ5JBYGA/bg=
X-Gm-Message-State: AOJu0YzY/jGTqpSoMXIsD/ENRcrlOrrhuOWrLZ1/AkMSnV68ZsybiZUw
	RBayTa8dmNXRWrSZcUVZhIgsbJXFSkT/tDmJJWuaE8VA6BJTGkes
X-Google-Smtp-Source: AGHT+IFfQlHSDGpRedHQZOxNA80Txeon1IoDdL1OkIaeHs6fiCKpDLjz0nxEGKeLJFv/UYOWbcvlcA==
X-Received: by 2002:a17:903:1c4:b0:1f7:3763:5ffb with SMTP id d9443c01a7336-1fadbd0af90mr93033805ad.59.1720034247369;
        Wed, 03 Jul 2024 12:17:27 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1537373sm106683025ad.135.2024.07.03.12.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 12:17:27 -0700 (PDT)
Date: Wed, 3 Jul 2024 09:17:26 -1000
From: Tejun Heo <tj@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/4] nvme-tcp: per-controller I/O workqueues
Message-ID: <ZoWjxtyjHTC2r285@slm.duckdns.org>
References: <20240703135021.34143-1-hare@kernel.org>
 <20240703135021.34143-2-hare@kernel.org>
 <7e4444d0-f156-439e-9363-4beb86bb6248@grimberg.me>
 <c9f73300-9860-4965-88af-9a7b4d7b0e1b@suse.de>
 <ad15b94b-9414-4ec1-9acf-465a8b190fe5@grimberg.me>
 <ZoWFOnvgWEiKipW6@slm.duckdns.org>
 <aaa404b1-72ac-4b15-8c30-a62ef2216004@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaa404b1-72ac-4b15-8c30-a62ef2216004@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_121728_947077_82ED8638 
X-CRM114-Status: GOOD (  12.77  )
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

Hello,

On Wed, Jul 03, 2024 at 10:14:14PM +0300, Sagi Grimberg wrote:
...
> None of these reasons are the claimed reason to use separate workqueues in
> this patch. The claim is that it is more efficient, i.e. has less overhead.
> 
> The commit msg is the following:
> "Implement per-controller I/O workqueues to reduce workqueue contention
> during I/O."

Hmm... it's not impossible for the concurrency accounting in pool_workqueues
to show up if the issue rate is *really* high but I'd be surprised if that
actually matters given that the backend pool is shared. Maybe I'm missing
something but I don't see a reason why multiple workqueues would be more
efficient than a shared one.

Thanks.

-- 
tejun

