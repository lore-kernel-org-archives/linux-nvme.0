Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936F6C3ABC9
	for <linux-nvme@archiver.kernel.org>; Wed, 21 May 2025 04:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g4V6i/dSpmw0tE1g0UBLPD3Iv8vOxNoAJyEnzSQUPN0=; b=HMd6aQ08sAwvv+iCG8yQ4Y6KEb
	YLegiyQ5449k8M2Se0BHv+14jGR5Lfd9AEThvibEAlgeaTQfnvWxkwBcuJDMakUrrn6R+xSkbs96I
	10/QcuIVNbiQxftWCYHHxJGFXOAYRArbJp5VGPZO30xPRvhi0X64GST+HvAKPGm49l7aYoMwb4IW1
	+5BD4dqTLAlnPgIb0lP1fM3G4klDa8xHe2Pjr4c4cO5/5LEiI6VDXMd5vaCsEPrEinUmN2mPD4D8s
	cOkyfD8ViDRqw6chYR1DAsUy2LlyjZ+wmGj5dLgNOnQ7aZcY1FguBQrWeVzdxKJe+OuLORgEiYooP
	Lo7cgshQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHbR2-0000000Emf9-0DUQ;
	Wed, 21 May 2025 04:52:08 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHZpm-0000000EeP9-0kWj
	for linux-nvme@lists.infradead.org;
	Wed, 21 May 2025 03:09:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 2B4EDA4EF52;
	Wed, 21 May 2025 03:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDD2C4CEE9;
	Wed, 21 May 2025 03:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747796972;
	bh=MzDBPdt+NOJuZUnRvn7D0hSDT7QUWWhCWPHDebkE6yM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WSp6blwNJ2IEI0zxxm4wg6b/R5V8dLrbx2SaV54oQnibx34rjyiLBnPqyvVGGo0/v
	 4a9VJ/1ZJBPKALlSZQ09HMCGg86MWHTm0TcJhRTmy98Z4Vxv+BmPKMgT4WrgEm9JsJ
	 O6+PissEq05oWwGcnqWiKCdGml+a0ZoNrUOOEjgxvqK/PQVItypF0uX3l8u7xeUr7k
	 QUy3Hk85t+zwEd35Q+iVL+qq1cs2To0at1zcaI2vpClgypEuiaeUhLs2bGeO/A2sta
	 RJOsU0YzaDSVVumW/jDtX8coTK0AAjbM5OTTeUHmk2EaH21WC5ZLwhCMSKK+ahHamw
	 AxMbSY2OTIELA==
Date: Tue, 20 May 2025 20:09:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, ahmed.zaki@intel.com,
 aleksander.lobakin@intel.com, alex.aring@gmail.com, andrew+netdev@lunn.ch,
 ardb@kernel.org, christophe.leroy@csgroup.eu, cratiu@nvidia.com,
 d.bogdanov@yadro.com, davem@davemloft.net, decui@microsoft.com,
 dianders@chromium.org, ebiggers@google.com, edumazet@google.com,
 fercerpav@gmail.com, gmazyland@gmail.com, grundler@chromium.org,
 haiyangz@microsoft.com, hayeswang@realtek.com, hch@lst.de,
 horms@kernel.org, idosch@nvidia.com, jiri@resnulli.us, jv@jvosburgh.net,
 kch@nvidia.com, kys@microsoft.com, leiyang@redhat.com,
 linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wpan@vger.kernel.org, linux@treblig.org, martin.petersen@oracle.com,
 mgurtovoy@nvidia.com, michael.christie@oracle.com,
 mingzhe.zou@easystack.cn, miquel.raynal@bootlin.com, mlombard@redhat.com,
 netdev@vger.kernel.org, pabeni@redhat.com, phahn-oss@avm.de,
 sagi@grimberg.me, sam@mendozajonas.com, sdf@fomichev.me,
 shaw.leon@gmail.com, stefan@datenfreihafen.org,
 target-devel@vger.kernel.org, viro@zeniv.linux.org.uk, wei.liu@kernel.org
Subject: Re: [PATCH 0/7] net: Convert dev_set_mac_address() to struct
 sockaddr_storage
Message-ID: <20250520200929.1b9ae5ec@kernel.org>
In-Reply-To: <202505201741.AFA146E7F6@keescook>
References: <20250520222452.work.063-kees@kernel.org>
	<20250521001931.7761-1-kuniyu@amazon.com>
	<202505201741.AFA146E7F6@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_200934_286608_9F6A884A 
X-CRM114-Status: UNSURE (   8.20  )
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

On Tue, 20 May 2025 17:42:32 -0700 Kees Cook wrote:
> Ah yes, I can include that in the next version if you want? I was trying
> to find a stopping point since everything kind of touches everything ...

Looks like the build considers -Wincompatible-pointer-types to always
imply -Werror or some such? We explicitly disable CONFIG_WERROR in our
CI, but we still get:

drivers/net/macvlan.c:1302:34: error: incompatible pointer types passing 'struct sockaddr *' to parameter of type 'struct __kernel_sockaddr_storage *' [-Werror,-Wincompatible-pointer-types]
 1302 |                 dev_set_mac_address(port->dev, &sa, NULL);
      |                                                ^~~

on this series :(
-- 
pw-bot: cr

