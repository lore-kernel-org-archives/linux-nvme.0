Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B548C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Apr 2022 21:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GIkmPRn6aXIFTLXMDEzU8Z7cPf9kdXdPCyaOczwE6x0=; b=yiCsgfWSatm//sa5CvbeQo8LQ3
	WaUXDmD0MWLFR1eOxiwOqGNUg5LG3DsLLuXBWcZz1WIo3ApvWzY0k0nZLppbxx8Isl/ja4RJcLDwd
	7uBoL60LsNRODz5IFHpMy9dJDOk1jz1y3jd9wRO1pEp4jTm2iA+dFzSkvdxZdbBA0X4N82LT20zI4
	Py8VPZ3WTO7nxl19eFsbGQ/P8CkGVC0zz1F/ms9G32uc74u7VSKebVEBY8E0+sM06CE7o0D+HKSmn
	96bLrXKP0ss/RrtbMKgxjkCEat1QznlXEXnbF51EyCRJTNXk5Rqr5tvcLLuFT+r2C5araOTmoZgV3
	uznMBBYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nhebZ-00F5vE-Tz; Thu, 21 Apr 2022 21:44:49 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nhebW-00F5uj-Lz
 for linux-nvme@lists.infradead.org; Thu, 21 Apr 2022 21:44:47 +0000
Received: by mail-pl1-x62e.google.com with SMTP id n8so6643761plh.1
 for <linux-nvme@lists.infradead.org>; Thu, 21 Apr 2022 14:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=GIkmPRn6aXIFTLXMDEzU8Z7cPf9kdXdPCyaOczwE6x0=;
 b=Y+ot/N7E3NqtwNRkxxSQvG8RLexpxttLfKY4X2H753dGZgDytqswn3fJSKyb3cJFbH
 li+mL9j7bJx2hlPee+M4Olu2UZNUV2GxkQAjVde+z8e/75fQjDwi9Fnvqbrk3yHU/RBZ
 9NE7UFSIwy6xkhNy7ODaqcifxQ58kzt+nyKjzpBJ2xVhIXHf8KY3VVOt4PiYl+cSzeKY
 Nu0bQZioVPXHgcvVihXVQDPHhnx9ZdX1+d0UPvh5V2OMKUv0qIIc9T9OoQcyq78QovKw
 z43U2HpqbNvSPKATYbDIhMdIrOfXUdMI4W5mQynu/1WEcGaLs4vVOgTTz5l8xUcx1a32
 Vrtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=GIkmPRn6aXIFTLXMDEzU8Z7cPf9kdXdPCyaOczwE6x0=;
 b=fqfCwMyHqDuALWv+H0kVmNZjNCVp+i8i9AiR9tvB7UbZX8h7LAGgaI2lnqKX1HLQD+
 YYSjY0vyY368S26Swfep8n24LTbP3hRfj2g0NxJaYf36+RLIbuXvm65kfyyhbZ9wdqPT
 IRhD0x04pZ8qWxEW0d60vAlgiLM7P4p0hvMZDPkr4xfmt6xGhsucNAmpM/WJl0rRi69F
 5Og5u/hCjx16t93VY0CzrRpQ3x1jCDoxdZWXh+b866MuS50w+QodLULoBiLDp4icGrEB
 oueGiqfEV++iyHESN5+07hvPxSOlvOm1GWO7Rx8aXIRYRrIZGa/Ff+12CNy1l/f7UX15
 2hug==
X-Gm-Message-State: AOAM530XbqSwxLilC1nIiQOqOvwy18sHcymBtU67IV6RGQ3+w9YnoZqY
 iigX9lgPCJ8biSxxBPll9Xk=
X-Google-Smtp-Source: ABdhPJxHcJDy80tcA6sx3LqqnfHByJ4eX9ilg9ZOtqESXPl+xJmI1z5M+822VXfcwS0QGTJePQ/7fw==
X-Received: by 2002:a17:90a:6445:b0:1d6:a69e:406c with SMTP id
 y5-20020a17090a644500b001d6a69e406cmr4662624pjm.49.1650577485382; 
 Thu, 21 Apr 2022 14:44:45 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:15fa])
 by smtp.gmail.com with ESMTPSA id
 y4-20020a056a00190400b004fac0896e35sm80878pfi.42.2022.04.21.14.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Apr 2022 14:44:44 -0700 (PDT)
Date: Thu, 21 Apr 2022 11:44:43 -1000
From: Tejun Heo <tj@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Valente <paolo.valente@linaro.org>,
 James Smart <james.smart@broadcom.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>,
 linux-block@vger.kernel.org, cgroups@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: Re: make the blkcg and blkcg structures private
Message-ID: <YmHQS1pyIglK+gfS@slm.duckdns.org>
References: <20220420042723.1010598-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420042723.1010598-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220421_144446_755265_76D55501 
X-CRM114-Status: GOOD (  15.87  )
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

On Wed, Apr 20, 2022 at 06:27:08AM +0200, Christoph Hellwig wrote:
> this series cleans up various lose end in the blk-cgroup code to make it
> easier to follow in preparation of reworking the blkcg assignment for
> bios.  The biggest change is that most of <linux/blk-cgroup.h> is now
> taken private into block/.

The patches look all good to me and I'm not against making things more
private but can you elaborate on the rationale a bit more? By and large, we
have never been shy about putting things in the headers if there's *any*
(perceived) gain to be made from doing so, or even just as a way to pick the
locations for different things - type defs go on header and so on. Most of
the inlines and [un]likely's that we have are rather silly with modern
compilers with global optimizations, so it does make sense to get tidier,
but if that's the rationale, mentioning that in the commit message, even
briefly, would be great - ie. it should explain the benefits of adding these
few accessors to keep the definition private.

Thanks.

-- 
tejun

