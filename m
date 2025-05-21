Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E02C54E65
	for <linux-nvme@archiver.kernel.org>; Thu, 22 May 2025 16:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EqESSBwGlzyXjiul59OjN72Bpb38tds7T0cNGQrQAI8=; b=bnRBMySasQ/fDvS2C1aGAE1bGl
	PwcD+fvzyoMN2y4CZa+AxKKHXYrnqGinsHRVKvnyrsBXQnF2/E2Xf3cUhGu2cGxaghJen/NpOrL/t
	TGK3zHMOmZfEwxI2hxu76FSLEVmuXE91JAxe04XIHXdp86evWrYzKlG8UVpwVODNg5Z6fyuUjb7Q7
	tC5kvrNhGHEfuYW783YQVz+EZFCHbdbkbIlKXSOXA0HfAVumviJ463BxZm2esZW2BpaM09Ew3PeOa
	pj+Fkx6ZjBcDiWSq7asb7tN98NaUg7OvLTBGOeld5Spmuvd++2xXmk4PMYpQGNF7EFlb09cXujmrS
	9M201qMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI8vz-00000001bzH-0wd8;
	Thu, 22 May 2025 16:38:19 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHbqL-0000000EpjF-0zxI
	for linux-nvme@lists.infradead.org;
	Wed, 21 May 2025 05:18:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CBD2B5C4B9A;
	Wed, 21 May 2025 05:15:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85763C4CEE4;
	Wed, 21 May 2025 05:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747804695;
	bh=u7/3KY1Kz6KkAfhTKudlFFJOir6E8UHZ7GaPRxnGVG0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=EgLmllFK8fwvA9p9id9HO7R4iI6aKQsfDw/X/h2+hfPmpkQ4DxvO881/tl+XpcCJC
	 5oQFMAy3BrZh7rbm2O7tXqo70WumhO6wz3lSF/pIcmWHDahcv04G7RVxIAqRu6ZRzy
	 BpDwShIP2aI5p40uo2K/YjKCMk4xjVe051SnhFz58o6blPfFVcx8jNTp8Y9LLln2nO
	 SD/q1UOiIcM8zkEg6kY9MJBgaBL/tbj9Y6SdzEe3Mi8iGLrVxlnVueP7SM/LQXqAsn
	 fw5T9KMJ7HjPfWWxACu/HIAdhc/hnY4EyLwE2uXwdONaICh7Iq84FBAhHkuR7NljEV
	 uupqc0PXuoqjw==
Date: Tue, 20 May 2025 22:18:10 -0700
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, ahmed.zaki@intel.com,
 aleksander.lobakin@intel.com, alex.aring@gmail.com, andrew+netdev@lunn.ch,
 ardb@kernel.org, christophe.leroy@csgroup.eu, cratiu@nvidia.com,
 d.bogdanov@yadro.com, davem@davemloft.net, decui@microsoft.com,
 dianders@chromium.org, ebiggers@google.com, edumazet@google.com,
 fercerpav@gmail.com, gmazyland@gmail.com, grundler@chromium.org,
 haiyangz@microsoft.com, hayeswang@realtek.com, hch@lst.de, horms@kernel.org,
 idosch@nvidia.com, jiri@resnulli.us, jv@jvosburgh.net, kch@nvidia.com,
 kys@microsoft.com, leiyang@redhat.com, linux-hardening@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-wpan@vger.kernel.org, linux@treblig.org,
 martin.petersen@oracle.com, mgurtovoy@nvidia.com,
 michael.christie@oracle.com, mingzhe.zou@easystack.cn,
 miquel.raynal@bootlin.com, mlombard@redhat.com, netdev@vger.kernel.org,
 pabeni@redhat.com, phahn-oss@avm.de, sagi@grimberg.me, sam@mendozajonas.com,
 sdf@fomichev.me, shaw.leon@gmail.com, stefan@datenfreihafen.org,
 target-devel@vger.kernel.org, viro@zeniv.linux.org.uk, wei.liu@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/7=5D_net=3A_Convert_dev=5Fset=5Fm?=
 =?US-ASCII?Q?ac=5Faddress=28=29_to_struct_sockaddr=5Fstorage?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250520200929.1b9ae5ec@kernel.org>
References: <20250520222452.work.063-kees@kernel.org> <20250521001931.7761-1-kuniyu@amazon.com> <202505201741.AFA146E7F6@keescook> <20250520200929.1b9ae5ec@kernel.org>
Message-ID: <935B5950-190B-47D8-BF45-1CBAE904DB71@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_221817_317463_E9B7C4F8 
X-CRM114-Status: UNSURE (   7.78  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Thu, 22 May 2025 09:38:03 -0700
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



On May 20, 2025 8:09:29 PM PDT, Jakub Kicinski <kuba@kernel=2Eorg> wrote:
>On Tue, 20 May 2025 17:42:32 -0700 Kees Cook wrote:
>> Ah yes, I can include that in the next version if you want? I was tryin=
g
>> to find a stopping point since everything kind of touches everything =
=2E=2E=2E
>
>Looks like the build considers -Wincompatible-pointer-types to always
>imply -Werror or some such? We explicitly disable CONFIG_WERROR in our
>CI, but we still get:
>
>drivers/net/macvlan=2Ec:1302:34: error: incompatible pointer types passin=
g 'struct sockaddr *' to parameter of type 'struct __kernel_sockaddr_storag=
e *' [-Werror,-Wincompatible-pointer-types]
> 1302 |                 dev_set_mac_address(port->dev, &sa, NULL);
>      |                                                ^~~
>
>on this series :(

I'll get this fixed and add dev_set_mac_address_user() for v3=2E=2E=2E


--=20
Kees Cook

