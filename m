Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C8F0C3ABC9
	for <linux-nvme@archiver.kernel.org>; Wed, 21 May 2025 04:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ENYzE0iyN6Oj3z26C7hTDDo8lnRX1/LKeP13unTNolw=; b=mAq+feWUaYlO47F0cbzhqWkOQp
	A9zkcZFMtYh4+/ZEr66eRW8j2P9CRdXlK19SzjLr8IkLohRAtJzZlwQb3xFMIzeBRAWSFdn4sC3kq
	GC+GHKu6D+byEozj9YJyCQIWL7gP9oMUzyxMKMrub8qsENFtLhpR+vdmCEC1wMOIHT2qFZQLmTf7D
	YEpo1lSxWson9D25QUaLuF5eYxpdnkOJX0R0mAbEM05Y1aV50WCPdrs8I2Mnktv4mB4QpltO6sw1u
	nI/Fd5igP0t0ZnnzlUNo+lwoMlXbHRySodxpQitDjU67DR0LqjuFx0atrU6nMAIVKX8dPkXCNR817
	Ihu/VX3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHbQy-0000000EmY5-0CFk;
	Wed, 21 May 2025 04:52:04 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHXXY-0000000ERIu-3xHj
	for linux-nvme@lists.infradead.org;
	Wed, 21 May 2025 00:42:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id AFB53A4EC0B;
	Wed, 21 May 2025 00:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49812C4CEEA;
	Wed, 21 May 2025 00:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747788155;
	bh=/RrFroAnx4HggKLHMMSIYYEaz83wGtiW3hYlxlEWXWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PAT9lG8LPkxAwkRVnnhNYAd60AAeYfGIAO9KTdifgfX1guOO6r/bZruvcFf+ZgGeK
	 e06AbBhuFWam87cQ3brvBfJnjJ4FY7zJmv4K2XAuwaA/yFYmzhhj6r0NDIpmZvFU+y
	 wpRvnlt6ifBX1N2Mx7kcy4ma021PfVMTh5iOMpOtm4AhHfRogi3QGhnOBCbZ36pgqI
	 xPS0M84CixKHPB+rQn/Kjn0RuyrcD3sXwAluk3g7XEoMyD2IaQIzCuqS8NIiNA6jYc
	 r5xaeYB4j4q0Lbx3epkEl6n0pdfwMZTK8h15UIC+s8VYG5jf0b1LSwWnolulVZ2TGo
	 jdvs6R+aniuSg==
Date: Tue, 20 May 2025 17:42:32 -0700
From: Kees Cook <kees@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: ahmed.zaki@intel.com, aleksander.lobakin@intel.com,
	alex.aring@gmail.com, andrew+netdev@lunn.ch, ardb@kernel.org,
	christophe.leroy@csgroup.eu, cratiu@nvidia.com,
	d.bogdanov@yadro.com, davem@davemloft.net, decui@microsoft.com,
	dianders@chromium.org, ebiggers@google.com, edumazet@google.com,
	fercerpav@gmail.com, gmazyland@gmail.com, grundler@chromium.org,
	haiyangz@microsoft.com, hayeswang@realtek.com, hch@lst.de,
	horms@kernel.org, idosch@nvidia.com, jiri@resnulli.us,
	jv@jvosburgh.net, kch@nvidia.com, kuba@kernel.org,
	kys@microsoft.com, leiyang@redhat.com,
	linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wpan@vger.kernel.org, linux@treblig.org,
	martin.petersen@oracle.com, mgurtovoy@nvidia.com,
	michael.christie@oracle.com, mingzhe.zou@easystack.cn,
	miquel.raynal@bootlin.com, mlombard@redhat.com,
	netdev@vger.kernel.org, pabeni@redhat.com, phahn-oss@avm.de,
	sagi@grimberg.me, sam@mendozajonas.com, sdf@fomichev.me,
	shaw.leon@gmail.com, stefan@datenfreihafen.org,
	target-devel@vger.kernel.org, viro@zeniv.linux.org.uk,
	wei.liu@kernel.org
Subject: Re: [PATCH 0/7] net: Convert dev_set_mac_address() to struct
 sockaddr_storage
Message-ID: <202505201741.AFA146E7F6@keescook>
References: <20250520222452.work.063-kees@kernel.org>
 <20250521001931.7761-1-kuniyu@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521001931.7761-1-kuniyu@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_174237_049303_FA9FCA26 
X-CRM114-Status: GOOD (  16.63  )
X-Mailman-Approved-At: Tue, 20 May 2025 21:51:54 -0700
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

On Tue, May 20, 2025 at 05:19:20PM -0700, Kuniyuki Iwashima wrote:
> From: Kees Cook <kees@kernel.org>
> Date: Tue, 20 May 2025 15:30:59 -0700
> > Hi,
> > 
> > As part of the effort to allow the compiler to reason about object sizes,
> > we need to deal with the problematic variably sized struct sockaddr,
> > which has no internal runtime size tracking. In much of the network
> > stack the use of struct sockaddr_storage has been adopted. Continue the
> > transition toward this for more of the internal APIs. Specifically:
> > 
> > - inet_addr_is_any()
> > - netif_set_mac_address()
> > - dev_set_mac_address()
> > 
> > Only 3 callers of dev_set_mac_address() needed adjustment; all others
> > were already using struct sockaddr_storage internally.
> 
> I guess dev_set_mac_address_user() was missed on the way ?
> 
> For example, tap_ioctl() still uses sockaddr and calls
> dev_set_mac_address_user(), which cast it to _storage.

Ah yes, I can include that in the next version if you want? I was trying
to find a stopping point since everything kind of touches everything ...
:P

-- 
Kees Cook

