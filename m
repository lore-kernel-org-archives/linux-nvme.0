Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5EAC2D0CD
	for <linux-nvme@archiver.kernel.org>; Wed, 21 May 2025 04:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M8x9xVJbTJ6ZOrCEE1Hl8YcOSI9042SY+wnYiiCHovQ=; b=wTz4O1qY6QvnB38sgAzVbUTjSk
	yfald7SKK2VSTKU0ccjjELJMl4MeWFZ/lR16visf7AhRzbNV3rYfVZLpXC/cHv4coAL+JCOu63PEt
	J4kbocgwMpZh2w8QScq3y6/qD7SUs8F2gWULEkOXLRlYBKWQAryx53AZK/tiRwe4J5jWyU1DiwS+1
	4p9Q97Emu8I99DOVm75NiFXFCfKoilGeghqLi7ZWGzRWHantehqgSi3e8vQY9tgGt3KNpH660shhm
	ZZNzlPxuzCsF496ViXPdGz7EZpUD9q/vvkxmVKS3B2BJbnPoNVUzgG56DXaMFLCgQi1rKIBhEdcDU
	gyljvisQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHbQx-0000000EmX8-1RhT;
	Wed, 21 May 2025 04:52:03 +0000
Received: from smtp-fw-52003.amazon.com ([52.119.213.152])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHXBc-0000000EQPt-1Tgt
	for linux-nvme@lists.infradead.org;
	Wed, 21 May 2025 00:19:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747786796; x=1779322796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M8x9xVJbTJ6ZOrCEE1Hl8YcOSI9042SY+wnYiiCHovQ=;
  b=To3jBKwfBhY9uSbKxMF7/RJdtmCTvdv98vcSFkJOaQiYDSBNBv/5C64+
   eGobvFQMz07FjU+YE1tvEbXXidnEWBog1G17+ktLFYZaBmWoNluxnh3q0
   l0UI5feNY+KqW9satC6yZPNrb/UZeC6MtV21V9RJN70tk82KJNEsIamGb
   GARYAnOaY8uWyPe6pmQF7twq4a4w+DOVgqKpLZ/QcL8wyMBgnR9A3w5SW
   vbcNkApvvQj5F9Nlo9hwEoFjjIGyQpdRINJH4PVqP1bxK8HlhltFKypDq
   UIB2R2z+vGlRmSSOiZEPgFqU42jwFMybNrLSNpwFeGKMia8a4YvMo29UN
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,303,1739836800"; 
   d="scan'208";a="95451227"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 00:19:49 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:8022]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.241:2525] with esmtp (Farcaster)
 id a87e7087-986a-42c5-9bfb-1c06732e239e; Wed, 21 May 2025 00:19:48 +0000 (UTC)
X-Farcaster-Flow-ID: a87e7087-986a-42c5-9bfb-1c06732e239e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 00:19:47 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 00:19:39 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kees@kernel.org>
CC: <ahmed.zaki@intel.com>, <aleksander.lobakin@intel.com>,
	<alex.aring@gmail.com>, <andrew+netdev@lunn.ch>, <ardb@kernel.org>,
	<christophe.leroy@csgroup.eu>, <cratiu@nvidia.com>, <d.bogdanov@yadro.com>,
	<davem@davemloft.net>, <decui@microsoft.com>, <dianders@chromium.org>,
	<ebiggers@google.com>, <edumazet@google.com>, <fercerpav@gmail.com>,
	<gmazyland@gmail.com>, <grundler@chromium.org>, <haiyangz@microsoft.com>,
	<hayeswang@realtek.com>, <hch@lst.de>, <horms@kernel.org>,
	<idosch@nvidia.com>, <jiri@resnulli.us>, <jv@jvosburgh.net>,
	<kch@nvidia.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<kys@microsoft.com>, <leiyang@redhat.com>, <linux-hardening@vger.kernel.org>,
	<linux-hyperv@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-scsi@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, <linux-wpan@vger.kernel.org>,
	<linux@treblig.org>, <martin.petersen@oracle.com>, <mgurtovoy@nvidia.com>,
	<michael.christie@oracle.com>, <mingzhe.zou@easystack.cn>,
	<miquel.raynal@bootlin.com>, <mlombard@redhat.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <phahn-oss@avm.de>, <sagi@grimberg.me>,
	<sam@mendozajonas.com>, <sdf@fomichev.me>, <shaw.leon@gmail.com>,
	<stefan@datenfreihafen.org>, <target-devel@vger.kernel.org>,
	<viro@zeniv.linux.org.uk>, <wei.liu@kernel.org>
Subject: Re: [PATCH 0/7] net: Convert dev_set_mac_address() to struct sockaddr_storage
Date: Tue, 20 May 2025 17:19:20 -0700
Message-ID: <20250521001931.7761-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520222452.work.063-kees@kernel.org>
References: <20250520222452.work.063-kees@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.41]
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_171956_546313_FD525C9A 
X-CRM114-Status: GOOD (  11.19  )
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

From: Kees Cook <kees@kernel.org>
Date: Tue, 20 May 2025 15:30:59 -0700
> Hi,
> 
> As part of the effort to allow the compiler to reason about object sizes,
> we need to deal with the problematic variably sized struct sockaddr,
> which has no internal runtime size tracking. In much of the network
> stack the use of struct sockaddr_storage has been adopted. Continue the
> transition toward this for more of the internal APIs. Specifically:
> 
> - inet_addr_is_any()
> - netif_set_mac_address()
> - dev_set_mac_address()
> 
> Only 3 callers of dev_set_mac_address() needed adjustment; all others
> were already using struct sockaddr_storage internally.

I guess dev_set_mac_address_user() was missed on the way ?

For example, tap_ioctl() still uses sockaddr and calls
dev_set_mac_address_user(), which cast it to _storage.

