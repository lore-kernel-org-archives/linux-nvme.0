Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5AACDB483
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Oct 2023 11:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BQbYmJmwIs6r+Dbv/KSZdaRjCezMRBGYvovR08iAwH0=; b=JguiF/xxbad9y/CZtNQi+jtTJg
	NbJTzCNlvC6nvHAYokM0uoTzgRLA+f8ktfafL+zAn/dAEvfmmhEp/r5SGvm/t8DvXAQd0AUX3mk6S
	OWhR545/ps/alw4FW4rjkviAdPI4zBBcDALO2bf0OaRPfS736cG74l2lLFbWZFW2yU/fwTIH7c67v
	n1EGHrtOphh15qCz54zmv4PDsiZeRI88uW0b6FehQ8oMbaoqvXuIw0JvfigWwAXn3JyNpABh2lAnb
	wVbQdgABaLWs4druJEY3AUevlZE5oK6NZvUBIK+HrPqVR0BxZMs6La7XMoEncIy55g5KgOppVddtV
	SI9trfbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtROh-00HC56-12;
	Thu, 19 Oct 2023 11:41:03 +0000
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtROe-00HC0I-0F
	for linux-nvme@lists.infradead.org;
	Thu, 19 Oct 2023 11:41:01 +0000
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9c5b313b3ffso498381466b.0
        for <linux-nvme@lists.infradead.org>; Thu, 19 Oct 2023 04:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697715655; x=1698320455; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BQbYmJmwIs6r+Dbv/KSZdaRjCezMRBGYvovR08iAwH0=;
        b=j1l8cDWh7VAsEDRxNAZFv8wQAMi1fUwsddyiXU24o1pqI21xgVFCyIiUhl/RDaz8Fe
         TlMoj4v3l17ncc2wtIYRUGaDVRjKud/H8z/Uww/yE7oQ5ibvDC1JxDyc4ds40mMEm+Et
         bqOFfMwzktms1pPP24EJlLFhXcGOPLzkGjLl/oxug+y/yeyLVvSMYdzg/ju1fIxZnuFR
         wY+YVK0rQEhpVk7aGH72EzKvgYdJoCHakxuI4QNf7mCGv5wBix6JZBx6T/I2DF23mG6y
         9qoJUPaDvG4OKYGa3SbzVuFAj6DFxWqQxh8Lhw8e1AywLx61tpbz/om0pUL+YeziQJAd
         VE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697715655; x=1698320455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQbYmJmwIs6r+Dbv/KSZdaRjCezMRBGYvovR08iAwH0=;
        b=i38HQy2755/MMMTF9W/bPpaLY/xjU9vEvCGm0Jb5cFt6+PkEjgVHF0JYZiuVWMx7v7
         3YYJs3zj5N0L7UfkZExa71K9GABuc4tlsMt1t10VmqmzDGlpogxhrbaJO+3Ns1xbLKp0
         OPt3/GZEu54g1yP4gsHuVulaJ82rv6htVrcBLwIDot4KyV8q1omcZPKkkpnn1rmuqdYB
         8dQ3B/4ITC1mfJvAkPptCkx4HAMgotF8MmxNqCIrsVFETD6aHnZk4dDdm5bsgWCV0Sn0
         BA2VRXpQCimKbJ7c2PEgtv5xDIS9flP2IRtteouQh1UO9Brx+v2W5/cHkvM/E53aH3QR
         MQxA==
X-Gm-Message-State: AOJu0Yx+XDb9R3tucFMOtQ2h0FRuemzBfTKOmdhq/AGaJhrzeqMSzGde
	epNpAn6plFRPtwS/idtpIA==
X-Google-Smtp-Source: AGHT+IEeA1tO05DglDmd90NPT5dBRNdiwc7EdZy0bFNJpeP4Kun43dIdtjhTHzs4e3AkFQBwvevGfg==
X-Received: by 2002:a17:906:d552:b0:9c6:64be:a3c9 with SMTP id cr18-20020a170906d55200b009c664bea3c9mr1425251ejc.39.1697715654778;
        Thu, 19 Oct 2023 04:40:54 -0700 (PDT)
Received: from p183 ([46.53.252.19])
        by smtp.gmail.com with ESMTPSA id v15-20020a17090651cf00b009a168ab6ee2sm3362348ejk.164.2023.10.19.04.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 04:40:54 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:40:52 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Willy Tarreau <w@1wt.eu>
Cc: Kees Cook <keescook@chromium.org>, Christoph Hellwig <hch@lst.de>,
	Justin Stitt <justinstitt@google.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: the nul-terminated string helper desk chair rearrangement
Message-ID: <50ad206e-8a6a-4223-8050-0880e2b1581c@p183>
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
 <20231019054642.GF14346@lst.de>
 <202310182248.9E197FFD5@keescook>
 <ZTDUYSBS7AO9pAgm@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZTDUYSBS7AO9pAgm@1wt.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231019_044100_136280_8E2EF788 
X-CRM114-Status: GOOD (  39.57  )
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

On Thu, Oct 19, 2023 at 09:01:53AM +0200, Willy Tarreau wrote:
> On Wed, Oct 18, 2023 at 11:01:54PM -0700, Kees Cook wrote:
> > On Thu, Oct 19, 2023 at 07:46:42AM +0200, Christoph Hellwig wrote:
> > > On Wed, Oct 18, 2023 at 10:48:49PM +0000, Justin Stitt wrote:
> > > > strncpy() is deprecated for use on NUL-terminated destination strings
> > > > [1] and as such we should prefer more robust and less ambiguous string
> > > > interfaces.
> > > 
> > > If we want that we need to stop pretendening direct manipulation of
> > > nul-terminate strings is a good idea.  I suspect the churn of replacing
> > > one helper with another, maybe slightly better, one probably
> > > introduces more bugs than it fixes.
> > > 
> > > If we want to attack the issue for real we need to use something
> > > better.
> > > 
> > > lib/seq_buf.c is a good start for a lot of simple cases that just
> > > append to strings including creating complex ones.  Kent had a bunch
> > > of good ideas on how to improve it, but couldn't be convinced to
> > > contribute to it instead of duplicating the functionality which
> > > is a bit sad, but I think we need to switch to something like
> > > seq_buf that actually has a counted string instead of all this messing
> > > around with the null-terminated strings.
> > 
> > When doing more complex string creation, I agree. I spent some time
> > doing this while I was looking at removing strcat() and strlcat(); this
> > is where seq_buf shines. (And seq_buf is actually both: it maintains its
> > %NUL termination _and_ does the length counting.) The only thing clunky
> > about it was initialization, but all the conversions I experimented with
> > were way cleaner using seq_buf.
> (...)
> 
> I also agree. I'm using several other schemes based on pointer+length in
> other projects and despite not being complete in terms of API (due to the
> slow migration of old working code), over time it proves much easier to
> use and requires far less controls.
> 
> With NUL-teminated strings you need to perform checks for each and every
> operation. When the length is known and controlled, most often you can
> get rid of many tests on intermediate operations and perform a check at
> the end, thus you end up with less "if" and "goto fail" in the code,
> because the checks are no longer for "not crashing nor introducing
> vulnerabilities", but just "returning a correct result", which can often
> be detected more easily.
> 
> Another benefit I found by accident is that when you need to compare some
> tokens against multiple ones (say some keywords for example), it becomes
> much faster than strcmp()-based if/else series because in this case you
> start by comparing lengths instead of comparing contents. And when your
> macros allow you to constify string constants, the compiler will replace
> long "if" series with checks against constant values, and may even arrange
> them as a tree since all are constants, sometimes mixing with the first
> char as the discriminator. Typically on the test below I observe a 10x
> speedup at -O3 and ~5x at -O2 when I convert this:
> 
> 	if (!strcmp(name, "host") ||
> 	    !strcmp(name, "content-length") ||
> 	    !strcmp(name, "connection") ||
> 	    !strcmp(name, "proxy-connection") ||
> 	    !strcmp(name, "keep-alive") ||
> 	    !strcmp(name, "upgrade") ||
> 	    !strcmp(name, "te") ||
> 	    !strcmp(name, "transfer-encoding"))
> 		return 1;
> 
> to this:
> 
> 	if (isteq(name, ist("host")) ||
> 	    isteq(name, ist("content-length")) ||
> 	    isteq(name, ist("connection")) ||
> 	    isteq(name, ist("proxy-connection")) ||
> 	    isteq(name, ist("keep-alive")) ||
> 	    isteq(name, ist("upgrade")) ||
> 	    isteq(name, ist("te")) ||
> 	    isteq(name, ist("transfer-encoding")))
> 		return 1;
> 
> The code is larger but when compiled at -Os, it instead becomes smaller.
> 
> Another interesting property I'm using in the API above, that might or
> might not apply there is that for most archs we care about, functions
> can take a struct of two words passed as registers, and can return
> such a struct as a pair of registers as well. This allows to chain
> functions by passing one function's return as the argument to another
> one, which is what users often want to do to avoid intermediate
> variables.

Chaining should be nice cherry on top for very specific cases but certainly
not promoted or advertised. Deleting intermediate variables promotes
implementation-defined behaviour because of unspecified order of evaluation
of function arguments. Second, debuggers still operate with lines in mind,
so jumping to the next statement written like this

	f(g(), h())

can be problematic. Intermediate variables are much less of a problem now
that -Wdeclaration-after-statement has been finally abolished! They don't
consume LOC anymore.

> All this to say that length-based strings do offer quite a lot of
> benefits over the long term.

As long as they are named kstring :-) Or std_string, he-he.

