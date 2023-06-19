Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55EFEEB64D9
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jun 2023 08:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=isW3ro7VrnYReL/xeasva9RHi55m+3Ng9iiYsqlf/a8=; b=IwN+lNmB0w/wyDZMju/+InRIpU
	MAwlaaJfj5RkXKWxVeVyEbFtbZTYarON8pdWQ40Mf8Lv/T9NDID1wEpzfX8LGrjPCrKtnsorGSMxS
	TpgmnVGC7hOjGJYK+3gosaX01DroLhHRiWOU8EgRbNZYDmIkjW/2YfVzRLVDy9mRGxHwSPE9gqLAn
	NHrFweBzm572vqDC32h8xk7rMsjsLj8wq+8bYL2vcTv0Gn1KYdKztq2rbX+UqIJfd8rwlc/32RXxU
	h4Yp3F5E4k1R/DAevqs34UkZLULWDYODXyN7r5+2C2aelskNvlI7RTLkhOxqR2jEfSZ969+U0D5EI
	4vQs896g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBA4E-007nUS-1M;
	Mon, 19 Jun 2023 08:16:54 +0000
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBA4B-007nTM-39
	for linux-nvme@lists.infradead.org;
	Mon, 19 Jun 2023 08:16:53 +0000
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3113da5260dso652965f8f.2
        for <linux-nvme@lists.infradead.org>; Mon, 19 Jun 2023 01:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687162608; x=1689754608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=isW3ro7VrnYReL/xeasva9RHi55m+3Ng9iiYsqlf/a8=;
        b=KazX0yNwB3GD0qMpqNeT8B+fVx8dSsh+RVEMQxLTiOHuNIvFUyQeyxpRx3Yy0F/lDB
         iTsNhLrLZuuHpQchOMW4OtFPnuo015E457SqxkYiKNazt5XDygOCKUBJMn3RlRvE08AE
         kA2UXPdlcFOhNaYXt7qNJZFN+E+ABsXrUJq1nEGXadlWSDXOyIe57cVNyYRxn4lEV0UB
         kW/+kLw6v+mxDXcSRmYaPm4ZMd67OhVXu0A5xZq37PSh+L45hlgsHesiQqJvCRs5im5a
         j0k2wQq6y5oRty8BWTPO/UWFpybYgV0yBSc1R4Tvo/NdpcHmfEEeYRfom/LMRew+bTau
         nvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687162608; x=1689754608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isW3ro7VrnYReL/xeasva9RHi55m+3Ng9iiYsqlf/a8=;
        b=GX/lb/6//yQPtGd4ZS3OuyfoXBI5C+lGiSHcCArkEWh5usebm/kkQVEvgk1i2w+HEF
         dLICKUu4jghAW66tdH0fuz8XTCgl3xrVqk0hQeRpeAZ5AYEj3SnpGCODjABdPwqswGwz
         GqFZYmjCs4qR3YNDNzE5OuPKLGr60WqAQhu8I6bmsj5rbJBmiY/yRZXO1iLTc8RnEKTs
         HZJKn036VOAavWI3LntHP1g7sKKPv3OhzVm4SstffmZcubDKA1Bi0zztUDBOI+vt1ppJ
         /dE9gZf/TbNgxJZM1fM3FGIH52SD0L5IXIjMjYBwtRKuMMVCUsGajedHluSbSJnDvSah
         7cdQ==
X-Gm-Message-State: AC+VfDy+dmDDYdjQo9GnACcKd5ENWj46Hd++Bnh7MiYfOZNnOVPcBXvd
	MO/IYjPIJT6Y8ZpRvS9QLi29yQ==
X-Google-Smtp-Source: ACHHUZ7YdUPbrAC9vk9luum3Fiw2SRofBrawd9gnl7RQJA52PSeTUGT+mXUQecxLW0mDU/E7LRbnIA==
X-Received: by 2002:a5d:63c5:0:b0:30a:efd2:c170 with SMTP id c5-20020a5d63c5000000b0030aefd2c170mr5312318wrw.37.1687162607724;
        Mon, 19 Jun 2023 01:16:47 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id d6-20020adffd86000000b0030ae87bd3e3sm30749486wrr.18.2023.06.19.01.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 01:16:45 -0700 (PDT)
Date: Mon, 19 Jun 2023 11:16:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <simon.horman@corigine.com>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, Boris Pismenny <boris.pismenny@gmail.com>
Subject: Re: [PATCH 4/4] net/tls: implement ->read_sock()
Message-ID: <635399d3-552f-460d-8bf3-19c039d03df2@kadam.mountain>
References: <20230614062212.73288-1-hare@suse.de>
 <20230614062212.73288-5-hare@suse.de>
 <ZI2+SDzKwK7i8Nw6@corigine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZI2+SDzKwK7i8Nw6@corigine.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230619_011652_018526_33821435 
X-CRM114-Status: GOOD (  24.08  )
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

On Sat, Jun 17, 2023 at 04:08:08PM +0200, Simon Horman wrote:
> + Dan Carpenter
> 
> On Wed, Jun 14, 2023 at 08:22:12AM +0200, Hannes Reinecke wrote:
> 
> ...
> 
> > +
> > +read_sock_end:
> > +	return copied ? : err;
> 
> Hi Hannes,
> 
> I'm of two minds about raising this or not, but in any case here I am
> doing so.
> 
> Both gcc-12 [-Wmaybe-uninitialized] and Smatch warn that err may be
> used uninitialised on the line above.
> 
> My own analysis is that it cannot occur: I think it is always the case
> that either copied is non-zero or err is initialised.

Hm...  Yeah.  This is a bug in how Smatch handles:

	return copied ? : err;

Smatch wants every return to have a simple literal or variable.  So if
the return is complicated it gets changed into:

	fake_variable = copied ? : err;
	return fake_variable;

Smatch translates this to:

	if (!(fake_variable = copied))
		fake_variable = err;

[ Here fake_variable doesn't have side effects but under other
  circumstances this transformation could cause double evaluate side
  effects bugs.  So that's another bug in Smatch. ]

Then Smatch parses the fake_variable = copied condition as:

	fake_variable = copied;
	if (fake_variable) {

The problem is that the type of fake_variable is based on the type of
tls_sw_read_sock() so it is a 32bit while copied is a 64bit (of unknown
value).  So Smatch says, "Just because copied is non-zero doesn't mean
fake_variable is non-zero because the value might get truncated when
we cast away the high 32 bits."

This not a serious proposal but a just to demonstrate that this is
what happens there are two ways to silence this warning.  Changing the
type of tls_sw_read_sock() to long.  Or change the code to:

	if (copied)
		return copied;
	return err;

Probably the right thing is to create a second fake_copied variable
based on typeof(copied).

	fake_copied = copied;
	if (fake_copied)
		fake_return_variable = fake_copied;
	else
		fake_return_variable = err;

It's a doable thing.  Plus now there are no double evaluate side effects
bugs.  I have written this code and it silences the warning, but I'll
test it out tonight to see what breaks.

regards,
dan carpenter


