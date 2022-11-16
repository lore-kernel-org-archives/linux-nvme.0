Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F86C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Nov 2022 16:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hjl8VZiti6dvayeaoXGfq4DJXk0oWCxmsnSh+tmosOk=; b=R42iGFJM/bCexgM7xmi3iMT3kP
	jnxcbZ2XQAas9YjJPJyHesx0U3U0LyVHw2y6e5Y1V7d/QotKbBLZ2xLFk3V5pbQv4MZ6eZ50JOtX5
	O0pfAn01PnCvXEAEurFwFbkZTzuq7Vj8Ze/IL9wB5MkKQ45x5I15I6a3nIQk8amTfUAIjSzx7GJHk
	oiEb4lX+6Zj0FBiuMKdQ0dRznCkjZIY2aOXZ+tj246FIRtD0wko6UQkEbfji+E6TBEaUmQyw0zNPQ
	WE5uW8TanF0dEeXZxiOsNsZAxxVRez/KLXixxmJ0nBDt9gLHySkXD5A6HiLaPrBJfhwycYccnWTh2
	WrKyw3RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovLas-0063Ir-29; Wed, 16 Nov 2022 16:48:58 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovLap-0063I0-Dx
	for linux-nvme@lists.infradead.org; Wed, 16 Nov 2022 16:48:56 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 67A62B81D1B;
	Wed, 16 Nov 2022 16:48:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96F3C433C1;
	Wed, 16 Nov 2022 16:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668617331;
	bh=3Hkx6PB49o80L9Fc+XPqxoxI0uNzYE40vPwvJ4LDC70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ugDVPZykbdicb1vwb1J+XKZoXXmlJEKIipSr+wuWz7ENIr23qa0rD7AUM1AMc28mP
	 fIYePxmQYM5QYCbO+I29ETvR8QlP5wwtfGBnL7j6vzzvK3aMPG2MQlpmL9dl1z+xl0
	 I9Es6VkKm30kqrWLYugRdOSokrXuz1NJb8LQkZxFtC3rQ57RSloG3mQl8yg5z2+aMm
	 fLyIzzKh1STQ1FbpW+87mslHXxbLsMtBBOpEVgphxf1TIUVhDcwFy+zCsC+o4IQxpT
	 ymRpYIEGdWsdVWP08VYb+CIc8fsrhk/PBq6f+2sfR538E5GmUUoTZ5BKpfYXkzclMY
	 UzDr4ZaG3GOdA==
Date: Wed, 16 Nov 2022 09:48:47 -0700
From: Keith Busch <kbusch@kernel.org>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Alan Adamson <alan.adamson@oracle.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] tests/nvme: Remove test output for passthrough error
 logging
Message-ID: <Y3UUb9RvkmS2OuYp@kbusch-mbp.dhcp.thefacebook.com>
References: <20221116001234.581003-1-alan.adamson@oracle.com>
 <20221116041701.mu4osauvwqsbvjau@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116041701.mu4osauvwqsbvjau@shindev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_084855_659162_04943AF6 
X-CRM114-Status: GOOD (  18.20  )
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

On Wed, Nov 16, 2022 at 04:17:03AM +0000, Shinichiro Kawasaki wrote:
> On Nov 15, 2022 / 16:12, Alan Adamson wrote:
> > Commit d7ac8dca938c ("nvme: quiet user passthrough command errors")
> > disabled error logging for passthrough commands so the associated
> > error output in nvme/039.out should be removed.
> > 
> > When an error logging opt-in mechanism for passthrough commands is
> > provided, the error output can be added back.
> 
> Thanks for this quick action. This two-steps approach looks good for me.
> 
> I confirmed the fix avoids the failure with v6.1-rc5 kernel. Also, I observe
> this fix makes the test case fail with v6.0 kernel. I suggest to skip the test
> case with kernel v6.0 or older, applying the hunk below. Could you repost v2
> with this change? Or if you want, I can apply it together with v1. Please let
> me know your preference.

It sounds like some future case might allow these errors to log in some
circumstances, so I'm not sure the test case should be so dependent on
seeing or not seeing these messages. Is there a mechanism to say these
are optional messages that may or may not show up?

