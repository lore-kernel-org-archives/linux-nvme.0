Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AAC5C27C75
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jun 2024 15:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kFHJYmERSWdF9lYhPIwBg0UWtYgV80aZ30AkDO+o9JU=; b=GjdcBs0BaAoK3z+jMgPr+AFJtV
	iSyathZTzGSH595e/6QXZPX03VhRZwz8G4bNIDw+Bl1us09Ivf4Sx7HLPpwoOYM0yLc1IvS59Kqvv
	jDkb5qdw33dEb37/HjmStFeUQoerzJjPs9mpPm6gL7nF/oY0rH04gAhOzqrFDLEtRoznZWKGxU9V9
	d1ta7rC56167GFxKV6o9BIgDtA5rr53ZsFNVPD/Jkl3u9ambtoFlAf3VYgtUufRFvOXOg+QXzocT4
	+tlbKYNC8f5E0PexlfMbcdrnG6s8oQ+jXk6uc2VvEmSAHZcKCisYb7o3sevp3T1YyuZi3usP7tjt3
	Eq7PKlJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHmZC-0000000HCcw-204H;
	Thu, 13 Jun 2024 15:40:46 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHmZ9-0000000HCap-194P
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jun 2024 15:40:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 4DDDDCE262A;
	Thu, 13 Jun 2024 15:40:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2ACC2BBFC;
	Thu, 13 Jun 2024 15:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718293239;
	bh=PaVcqWpzvUVb5bqFarvjMoq1WONE9j8JGCxJ79pc1j8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D1Tc42C70PM77KeC0itgIgTLjOly/BlSkyGjkgHZHFYCKI/XleSPPMsbsc53JkgBc
	 gFVFVfIXHn6b0wnq7+Z6WNswwTGWLg05CFq5RxqmRNFA6jlk6WVJvOZMsIFrDokS2B
	 Qg1+G9RgdyV/Tvm0OpiQbPYVypQOlb0yis5h29aAh0fjEv4xuczCppnM/MSbXZPZ8K
	 BLlMNn94XsGg6Qn03ZwvuRyZpuhUY60N1THTSv/nS+EeYAS3TN9MTpiXneeQ+iV0/X
	 Dltc5nPohmh4VXUTkf+qFuKQl/D5cDzHd12SyfufnnHx56duXSF1g9q/y8GRAPKvAE
	 wKjzpbeL/F0lQ==
Date: Thu, 13 Jun 2024 09:40:36 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Nilay Shroff <nilay@linux.ibm.com>, l@kbusch-mbp.dhcp.thefacebook.com,
	Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	hch@lst.de, sagi@grimberg.me, davidgow@google.com,
	akpm@linux-foundation.org, venkat88@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] list: introduce a new cutting helper
Message-ID: <ZmsS9DZWl8TccvKz@kbusch-mbp.dhcp.thefacebook.com>
References: <20240612155135.3060667-1-kbusch@meta.com>
 <f0e4c51c-8227-4f5c-876f-38fbb4a0e1bf@linux.ibm.com>
 <ZmrscxG51gFRDVlM@kbusch-mbp>
 <c475f0d8-3bc9-4d65-8fce-586f4b75b4fc@linux.ibm.com>
 <ZmsD_HDLBQAqOOU3@kbusch-mbp.dhcp.thefacebook.com>
 <31eb40f9-d68d-4348-b1fd-3cf057939297@paulmck-laptop>
 <ZmsGfle1aZQauzRb@kbusch-mbp.dhcp.thefacebook.com>
 <73b994eb-c689-48e0-b09c-a414041a0525@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73b994eb-c689-48e0-b09c-a414041a0525@paulmck-laptop>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240613_084043_696190_FFA1F0DC 
X-CRM114-Status: GOOD (  17.44  )
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

On Thu, Jun 13, 2024 at 08:15:06AM -0700, Paul E. McKenney wrote:
> On Thu, Jun 13, 2024 at 08:47:26AM -0600, Keith Busch wrote:
> > > 
> > > Just make a helper function like this:
> > > 
> > > 	static void my_synchronize_srcu(void)
> > > 	{
> > > 		synchronize_srcu(&my_srcu_struct);
> > > 	}
> > > 
> > > Or am I missing something subtle here?
> > 
> > That would work if we had a global srcu, but the intended usage
> > dynamically allocates one per device the driver is attached to, so a
> > void callback doesn't know which one to sync.
> 
> Ah, good point!  I suppose that a further suggestion to just JIT the
> needed function would not be well-received?  ;-)
> 
> I cannot resist suggesting placing a pointer to the srcu_struct in
> the task structure.  /me runs...
> 
> Perhaps somewhat more constructively, my usual question:  Is it really
> necessary to have per-driver SRCU here?  What would break if there was
> a global srcu_struct that applied to all drivers?

There's not a strict need for srcu_struct to be per device that I know
of. It was just done this way to keep usage localized to the parts that
need to be protected. The fear being that one device's long running
reader could prevent another device from quickly tearing down.

