Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7967C83F17
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jul 2025 20:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5cPjSq9x4JfK6ES05iG56c2eRWJnFpbKNKAZhIdXJx4=; b=xwZ/K2GcSTYRBIu83rgwIWzZ0s
	oVihHbeM2WHiLwE0GjAmCdK6BDmx9f2cbF3XmufkEi6ZB0rkTSx6m4wIxph9knFMVSOhcGvGjJdeL
	uUKt5g9Wa4WHw1JWHQhrAScCylCdhiU1KS2g+Fh9XEBMqMOMTbzftqzTRg8u5+eB6dxTBI8/0wzxA
	KnMFlTKSke62BBzQm+lQ12UGv7oWfTrswUaIa5m/eOWl0v8qLoJ9LgR/2TCWx1knBaNHOWQ6uRZuZ
	Sn0w5IuVyZa+pN9nbos21vxWcUm89pMFjNuzfG2Pgb54x17RMWQl55Mt/EFKjubFx9TXu/2GZOO+w
	ehfFjOSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubQB7-00000003Fff-29CZ;
	Mon, 14 Jul 2025 20:53:37 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubQB4-00000003Fev-2psv
	for linux-nvme@lists.infradead.org;
	Mon, 14 Jul 2025 20:53:35 +0000
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-74b50c71b0aso2718056b3a.0
        for <linux-nvme@lists.infradead.org>; Mon, 14 Jul 2025 13:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1752526413; x=1753131213; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5cPjSq9x4JfK6ES05iG56c2eRWJnFpbKNKAZhIdXJx4=;
        b=DwiMuqQkHTzBDZit15M34gdaJqWPoRGpa5mLuEEE7w2P51yMn9psQEHMySFInu9EtI
         KUSP8AvZ5Ycq9WZg6XKuc6/cm9wQmktpVLreA9194szooPgZ9v0bU4SI/MZ2yP+0URfi
         uQFmO1J/0ClWc6sCMiku1JmNqHvMEKv+tlb5bVuTQjpoN5fi820c/7IdQD35plrmzDhV
         UrrNxMx80Nji0dmV/l7u+uqm6MMW5e9ro78oiA/r23192hmj96GNxthQiFT56XNEllAL
         fzxSFc7SHq1g/n7GZQOjfgSUKjZ+3uKiG1XSj+OyMZlP5ENVR9bQUFGGTdW+Z9wBnX2A
         DDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752526413; x=1753131213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cPjSq9x4JfK6ES05iG56c2eRWJnFpbKNKAZhIdXJx4=;
        b=MfSBJcGlne/JXD+4HtKh8ZsWq8ngzO+tR6efQTvFfprV/tsomXlRYfCMQlsJedEQCl
         hXdHg5eYnNTRhZ0zfCeInmdH2efupPt7cWKWYAMKIVtfiMN27u3KsVoCt05BwGynOjxK
         Qs/vSERNLWvLpIda+EnKqMhBfLQSRM37wBeHNTJfmeJF3YS4XMXm7F2eVaHck3mKrzYn
         PbI54Ql5oLI/V9ygsatGZYh8CpMIqaZJ9Gh6LkLJ4RRxUL375sa2m0NKutYjcLa/fOzo
         62KUDM0t7qLYt/0zRwBc2KbbZkCYTvL0Jotn2Soj2RGaeq3b81+4wgcGbrQDpSpOzLmD
         C+0g==
X-Forwarded-Encrypted: i=1; AJvYcCXq1MFlX2PyUAFDGA5Qb6DiTP2GV9c+qRbgFEd0KWMcyr6fLnUR/Su0vQbewKcavTVx+OPcppFn5jHA@lists.infradead.org
X-Gm-Message-State: AOJu0YzEoZeMa7Jb7o/XccfJs5Uu1nNX8IVdUJ48Vv3kiUsRIL4qRYZG
	+dV26Hxj4ldoCgeXlFfe3n/BVX/DwgW1Vgvqy2Gv+rdUcrwFGZ4vbvYMAqja0UtX3HQ=
X-Gm-Gg: ASbGncuWVFLzC9w6Y8a+/HIfYuoJ1bi2KGg4uKCkVAYToEL0KX5rGViN/E1bDpQDmcY
	4wnMDnhGHhmyyTgQeSxNfBOn0f+CToJgXQfSELtGTZ1lE3ubojMl2QtU/T6RgXYaCaGasUWiFce
	kPwTQOxFe992LkZ/+p1K5X/plqWftU/vghUTNUCkIFwGGpS/OSLQo955UksWs58dwJju9aDQoJC
	HRp+xSeunLmdsul0kPARemAfNNWQ20EwyFYAoOuNcXxNSEcU3eHU7k+FSAaszr5IujsWsEnbC/1
	mLT35Iou4LjZPS0RbmyxZZ5nhgmQYtoaJFj0kDom7Zs0iSUPvORg7xtnJ5tMt+Ct+IFdRF+u3oh
	3eANdCNxNRoF5CyXev1EYaE0ZAt9jsD8oRUz2N5nMJVSLyCVwcD70UnzZGMrOrOYR9Djgp45GfA
	==
X-Google-Smtp-Source: AGHT+IHnv77H5wfprCmfDWdElJKQH3XAqXLK31tfmThyrslKpxVkW1UVIPHA5IdRfKXL32HPE3IWSA==
X-Received: by 2002:a05:6300:40f:b0:232:1668:848d with SMTP id adf61e73a8af0-23216688519mr15759146637.27.1752526413510;
        Mon, 14 Jul 2025 13:53:33 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe7297bcsm10529816a12.73.2025.07.14.13.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 13:53:32 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1ubQAz-0000000B4D2-3tkT;
	Tue, 15 Jul 2025 06:53:29 +1000
Date: Tue, 15 Jul 2025 06:53:29 +1000
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <aHVuSU3TB4eNRq8V@dread.disaster.area>
References: <20250714131713.GA8742@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714131713.GA8742@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250714_135334_827901_36237A02 
X-CRM114-Status: GOOD (  18.70  )
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

On Mon, Jul 14, 2025 at 03:17:13PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> I'm currently trying to sort out the nvme atomics limits mess, and
> between that, the lack of a atomic write command in nvme, and the
> overall degrading quality of cheap consumer nvme devices I'm starting
> to free really uneasy about XFS using hardware atomics by default without
> an explicit opt-in, as broken atomics implementations will lead to
> really subtle data corruption.
> 
> Is is just me, or would it be a good idea to require an explicit
> opt-in to user hardware atomics?

This isn't a filesystem question - this is a question about what
features the block device should expose by default to the
user/filesystem by default.

Block device feature configuration is typically done at hotplug time
with udev rules.  Require the user to add a custom udev rule for the
block device to enable hardware atomics if you are concerned that
hardware atomic writes are problematic.

Once the user has opted in to having their bdev feature activated,
then the filesystem should be able to detect and use it
automatically.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

