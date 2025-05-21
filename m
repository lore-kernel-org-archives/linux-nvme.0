Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBEBC54ED0
	for <linux-nvme@archiver.kernel.org>; Wed, 21 May 2025 04:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AjC+PxuyUMb05WxAtrT+CDSka3468z6AHpnQ9tN4+4Q=; b=mhducuEy/NzTkDSX+Di+MwFQl4
	s4PV6yANVxhHCgFo+IklRY/WsjnDxhWGWXx0fSZ8QQaU+8rQciE40Fy0i+xliBn7rVPgdG2mr4iJn
	eCON5WKBhXSe2t+Ybj81nd7UblcEG8k0OrHCEBkmgbdQTKWGGJ57nWM+jDFo2mBaiB2Jm6SdEE+dL
	/5KMxZjMqGaJHIMi0xrl5bRpb8C/uesxKQbazdCl8wD4grTAiLU1U9tqbLOvU1gPR9gkYRx4/hLvD
	qYDIn/92OtRB4K6zGCoz52J4KVSrGG2tCQICQhf6TS9CvYIsTkuSwOVmr2P6vgItimCVm08EA6WKY
	SvOkxWkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHbQw-0000000EmWK-2fK1;
	Wed, 21 May 2025 04:52:02 +0000
Received: from smtp-fw-2101.amazon.com ([72.21.196.25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHWxT-0000000EPt8-2uta
	for linux-nvme@lists.infradead.org;
	Wed, 21 May 2025 00:05:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747785919; x=1779321919;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AjC+PxuyUMb05WxAtrT+CDSka3468z6AHpnQ9tN4+4Q=;
  b=Vghe95anTWW28tTIuW8ktJudWIIV94zCEZN612pu/zoIf5ECUBlsAgbl
   RMg1RRSWz6G/VRyaZjiYnVGAGGS7LgE7EjDvm2XZYrOToLMjbUrQWGX/u
   CMTdIDqogk6wn5r3bGqo5pD464Uzb1skU0bKyr+0GkB3F3aJtsKj6ySfh
   z14EOSMzUDHGLLpruphJhyrl/6xotFjMBnWLKl73JXxR3Cuc2W969jH4L
   wOBiVBeVo6c64RZAIBCDXd108MbCoBVPgqa+UIRXH6JRXdMMTTZSvYVZ/
   PpLlwMAgmhc1PVBJ8NFXqb2lgoN+U2zZMfVPN/Ndq23tpyWC6pjb4Uaag
   g==;
X-IronPort-AV: E=Sophos;i="6.15,303,1739836800"; 
   d="scan'208";a="494410687"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 00:05:06 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:63604]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.53:2525] with esmtp (Farcaster)
 id 22b1456d-ef53-4eeb-baaf-b9aea32cf8a2; Wed, 21 May 2025 00:05:05 +0000 (UTC)
X-Farcaster-Flow-ID: 22b1456d-ef53-4eeb-baaf-b9aea32cf8a2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 00:05:05 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 00:04:57 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kees@kernel.org>
CC: <ahmed.zaki@intel.com>, <aleksander.lobakin@intel.com>,
	<alex.aring@gmail.com>, <andrew+netdev@lunn.ch>, <ardb@kernel.org>,
	<christophe.leroy@csgroup.eu>, <cratiu@nvidia.com>, <d.bogdanov@yadro.com>,
	<davem@davemloft.net>, <decui@microsoft.com>, <dianders@chromium.org>,
	<ebiggers@google.com>, <edumazet@google.com>, <fercerpav@gmail.com>,
	<gmazyland@gmail.com>, <grundler@chromium.org>, <gustavoars@kernel.org>,
	<haiyangz@microsoft.com>, <hayeswang@realtek.com>, <hch@lst.de>,
	<horms@kernel.org>, <idosch@nvidia.com>, <jiri@resnulli.us>,
	<jv@jvosburgh.net>, <kch@nvidia.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
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
Subject: Re: [PATCH 1/7] net: core: Convert inet_addr_is_any() to sockaddr_storage
Date: Tue, 20 May 2025 17:04:46 -0700
Message-ID: <20250521000449.6279-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520223108.2672023-1-kees@kernel.org>
References: <20250520223108.2672023-1-kees@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.41]
X-ClientProxiedBy: EX19D045UWC004.ant.amazon.com (10.13.139.203) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_170519_891786_D3218FDA 
X-CRM114-Status: UNSURE (   6.08  )
X-CRM114-Notice: Please train this message.
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
Date: Tue, 20 May 2025 15:31:00 -0700
> All the callers of inet_addr_is_any() have a sockaddr_storage-backed
> sockaddr. Avoid casts and switch prototype to the actual object being
> used.
> 
> Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

