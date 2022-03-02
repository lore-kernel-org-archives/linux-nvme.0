Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFED9C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Mar 2022 23:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=27harkJvt3GbkEUzd97hE61qyRwT0mO4luQz+C9YIVY=; b=t6KK2XoVhzigIdWWML9knVtkGo
	Sp5Pij1O61jujHj0nnuqbL6seCMC5sOQoxeGAdH7ej/BDFjjkF6+W9gjYkxwNGJPyN5J9/Qa2LOXc
	vEl5tLLqCpy+n8nQnf0yXxrL2rxP+HRhJy8Ctjg2DhlrXnh/nXX/9cZcnFI6BI/LUfDPfggTbBERE
	OeNZKv+XhIqSIJUhoooKP8Q4743Qr17YmrJ4s5fSajzvREnlw5Yz0O0Y2XW8bOEeuwqeDPv9GX1wX
	egqOvh437pZPDo5RLyqQlEYN3sayHydOV5Daf19BvMj40JWl5uiFwJXcpwPUQKku7UcUqRgJGl4Cz
	cOctX6mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nPYdH-004koN-42; Wed, 02 Mar 2022 23:43:47 +0000
Received: from mail-pl1-f169.google.com ([209.85.214.169])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nPYaN-004jxM-Pw
 for linux-nvme@lists.infradead.org; Wed, 02 Mar 2022 23:40:49 +0000
Received: by mail-pl1-f169.google.com with SMTP id c9so2997174pll.0
 for <linux-nvme@lists.infradead.org>; Wed, 02 Mar 2022 15:40:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=27harkJvt3GbkEUzd97hE61qyRwT0mO4luQz+C9YIVY=;
 b=p1UGSlNtr5UtLWHd7B71j+px89i6R3FfQYGaGbl2fJXLetkCyNjLGmhR7Q215HzHR9
 vjtKN2JBFeX5S5u0ktIY2T5y+Jpq98uLOrrq2obEnI1Wovvp68FxEfAUicMQxkhMLYAj
 kFO/9ekuDl4iVRb8F27T90FsZGWR7YenzW4VSyQMOPxUPKYbT/Q+QfjCGf6iJADCNUYi
 g9kybty8o+swBAQ8F43xuWfYyUy1DsZwijWJgb0Dg/gtoD+vy73cJhfGn8a7hD+Zii5h
 CsuOw6MY/YVdYOcqckppaqLMN7+JXHErRctT8ypKYCvAkC9h3HlodfJvSCw98ZBAY9Kc
 ZLJw==
X-Gm-Message-State: AOAM530KSM9+KC7Sxh1HrcT5RLrR1MOCmOJgezl7bwSdXFEw5fYGt+37
 2esvugxlPt7Ud5CKL3FOuWeYL2cL9QY=
X-Google-Smtp-Source: ABdhPJxqr04ho8Sf+nOJf9uzDiSKIAwAy2mFLuUc3UFVCMr4d+Uzjzb7WW+wppBuBw6DqL0IfkWtMQ==
X-Received: by 2002:a17:902:ccc6:b0:14f:88e6:8040 with SMTP id
 z6-20020a170902ccc600b0014f88e68040mr33506847ple.13.1646264446627; 
 Wed, 02 Mar 2022 15:40:46 -0800 (PST)
Received: from garbanzo (136-24-173-63.cab.webpass.net. [136.24.173.63])
 by smtp.gmail.com with ESMTPSA id
 q194-20020a6275cb000000b004f396541cecsm253220pfc.155.2022.03.02.15.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Mar 2022 15:40:45 -0800 (PST)
Date: Wed, 2 Mar 2022 15:40:43 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>, Dave Jones <davej@codemonkey.org.uk>
Cc: lsf-pc@lists.linux-foundation.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Towards more useful nvme passthrough
Message-ID: <20220302234043.wlacvj223rcymc4b@garbanzo>
References: <CGME20220228093018epcas5p137f53cb05ce95fed2ac173b8fddf2eee@epcas5p1.samsung.com>
 <20220228092511.458285-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220228092511.458285-1-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220302_154047_916663_26D7F285 
X-CRM114-Status: GOOD (  34.16  )
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

On Mon, Feb 28, 2022 at 02:55:11PM +0530, Kanchan Joshi wrote:
> I'd like a propose a session to go over:
> 
> - What are the issues in having the above work (uring-cmd and new nvme
> passthru) merged?

It sounds like we just needed to settle on the formats. And a few more
eyeballs / reviewed-by's. No? And it sounds like Jens is about to punt
a new series :)

> - What would be other useful things to add in nvme-passthru. For
> example- lack of vectored-io for passthru was one such missing piece.
> That is covered from nvme 5.18 onwards [4]. But are there other things
> that user-space would need before it starts treating this path as a
> good alternative to kernel-bypass?

I think it would be good to split this into two parts:

 * io-uring cmd extensions
 * what can be extended for nvme

io-uring cmd is not even upstream yet, so I don't think folks widely really
realize the potential yet. So I think it's a bit too early to tell here,
and so we should go out and preach at things like Plumbers and other
conferences with a few nice demos of what can be done. nvme being one
use case, but I think it would help to get other users active and not
just vaporware.

The problem I'm seeing with this effort too is it relies too heavily
on the nvme passthrough being the only use case so far, and that's
a bit too involved. So I'd like to encourage other simple users
to consider helping here.

Granted this is like looking for a nail when you're hammer. And so
the only way to not have it be that way is to aim smaller, a simple
real demo of something useful. I don't know.. I'd think something like
trinity might have a field day with this.

> - Despite the numbers above, nvme passthru has more room for
> efficiency e.g. unlike regular io, we do copy_to_user to fetch
> command, and put_user to return the result. Eliminating some of this
> may require new ioctl. There may be other opinions on what else needs
> overhaul in this path.

I think we are being to hard on ourselves. Start small, and, get some
basic stuff up. And allow for flexibility for improvement. I think
at this point we have more than proof of concept no but something
tangible?

> - What would be a good way to upstream the tests? Nvme-cli may not be
> very useful. Should it be similar to fio’s sg ioengine. But
> unlike sg, here we are combining ng with io_uring, and one would want
> to retain all the tunables of io_uring (register/fixed buffers/sqpoll
> etc.)

If the goal was to help open the door for unsupported commands then
in so far as upstream is concerned shouldn't we only care about the
generic plumbing? ie, specific commands / which might not yet be
baked for general consumption (like zone append) are left to up to
implementors to figure out where they test. Let's use zone append
as an example. Without a raw block interface to it, we can use this
framework, ideally.. but yeah how do we test? Are vendors all going
to agree to use microbenches with io-uring cmd?

> - All the above is for 2.0 passthru which essentially forms a direct
> path between io_uring and nvme. And io_uring and nvme programming
> model share many similarities. For 3.0 passthru, would it be crazy to
> think of trimming the path further by eliminating the block-layer and
> doing stuff without “struct request”. There is some interest in
> developing user-space block device [5] and FS anyway.

I failed to capture where 2.0 and 3.0 are defined. Can you elaborate?

  Luis

