Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2150C5AE59
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Jun 2025 15:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RV5eQBsDJzGQT3nmAH1ecAGpLaKrMIzfOvCEOI6GjXQ=; b=p0SszwtMkKVdHXA96f8MW4ZBat
	d9iEUy3jbvnrs6GpeelC5DZQsOC0cDJt1VwhQRSdQUaJV+H2lu+LVqe7pPEZqCJrpKRug4pGMSAy8
	mEBte8j5a2S98bHQjbqvqdxWT5JmhXKWLRCuAWfyUEjuZgJX2NS017MByWPGDVCb9tWlHSOK2yapR
	/uUY71mj0y96BOa3lzeCyCn9lmue6sZkKXIp0+bmDwBh4+0VFmwYFRVmQophw75rHxkeLREHIO3b6
	nLSJM50zVmSZjotDxsA6mGGZMhqXhaRyg+IcualmCwhE22wf/WzHfM8XwYzatngmyl+Oo2wzonW9O
	8Lsl1xHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMTB2-0000000BECY-1r7l;
	Tue, 03 Jun 2025 15:03:44 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJzGb-0000000BMyT-0iq4
	for linux-nvme@lists.infradead.org;
	Tue, 27 May 2025 18:43:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 716655C4808;
	Tue, 27 May 2025 18:40:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151ECC4CEED;
	Tue, 27 May 2025 18:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748371392;
	bh=unrEi+Z8Vcid2frmRc00TpoL+pz62h5Wsf8KIjX1MAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SAJg/lTsHFPpMmZvVmP+0XJugy76N/WOctdJIssWWs7qNHSBbzmSYg8xkWQak4g5C
	 LfZgHKgxVCZb8p0qamVGEV/1YiZTk2afQEafhl37cp97dLgGRdjvi7trKjD2XXdMuP
	 LbrGzfua9UHyhqt54e4WAAnlTo1NpBqK2l+IKnh1JQUdMKF4EbO60uwu4lUOeBUiiD
	 wKIfF3Uo87tWndWoi9LDxjhMwmt61Lxnq3QWSMVbr06JAV1rHQ9XUs10fwb75pWBr3
	 anGW5bNZOirMCaMIcgBCgcjqJ5Vcm09HGhEIuw7KuVAzISErwpzi7uyi2a2hStymIg
	 Mw76bx9c3WLMA==
Date: Tue, 27 May 2025 11:43:08 -0700
From: Kees Cook <kees@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Maxim Georgiev <glipus@gmail.com>, netdev@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Mike Christie <michael.christie@oracle.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Maurizio Lombardi <mlombard@redhat.com>,
	Dmitry Bogdanov <d.bogdanov@yadro.com>,
	Mingzhe Zou <mingzhe.zou@easystack.cn>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Lei Yang <leiyang@redhat.com>, Ido Schimmel <idosch@nvidia.com>,
	Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Hayes Wang <hayeswang@realtek.com>,
	Douglas Anderson <dianders@chromium.org>,
	Grant Grundler <grundler@chromium.org>,
	Jay Vosburgh <jv@jvosburgh.net>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Philipp Hahn <phahn-oss@avm.de>, Eric Biggers <ebiggers@google.com>,
	Ard Biesheuvel <ardb@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xiao Liang <shaw.leon@gmail.com>, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org, linux-wpan@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v2 8/8] net: core: Convert
 dev_set_mac_address_user() to use struct sockaddr_storage
Message-ID: <202505271142.EA78EAB04@keescook>
References: <20250521204310.it.500-kees@kernel.org>
 <20250521204619.2301870-8-kees@kernel.org>
 <e1429351-3c9b-40e0-b50d-de6527d0a05b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1429351-3c9b-40e0-b50d-de6527d0a05b@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250527_114313_299389_0BFB6E16 
X-CRM114-Status: GOOD (  14.65  )
X-Mailman-Approved-At: Tue, 03 Jun 2025 08:03:41 -0700
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

On Tue, May 27, 2025 at 09:02:28AM +0200, Paolo Abeni wrote:
> On 5/21/25 10:46 PM, Kees Cook wrote:
> > diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
> > index fff13a8b48f1..616479e71466 100644
> > --- a/net/core/dev_ioctl.c
> > +++ b/net/core/dev_ioctl.c
> > @@ -572,9 +572,11 @@ static int dev_ifsioc(struct net *net, struct ifreq *ifr, void __user *data,
> >  		return dev_set_mtu(dev, ifr->ifr_mtu);
> >  
> >  	case SIOCSIFHWADDR:
> > -		if (dev->addr_len > sizeof(struct sockaddr))
> > +		if (dev->addr_len > sizeof(ifr->ifr_hwaddr))
> >  			return -EINVAL;
> > -		return dev_set_mac_address_user(dev, &ifr->ifr_hwaddr, NULL);
> > +		return dev_set_mac_address_user(dev,
> > +						(struct sockaddr_storage *)&ifr->ifr_hwaddr,
> > +						NULL);
> 
> Side note for a possible follow-up: the above pattern is repeated a
> couple of times: IMHO consolidating it into an helper would be nice.

Yeah, I will look at that.

> Also such helper could/should explicitly convert ifr->ifr_hwaddr to
> sockaddr_storage and avoid the cast.

It's UAPI, so it looked verrrry painful to change.

-- 
Kees Cook

