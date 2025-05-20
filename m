Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3D3C54E90
	for <linux-nvme@archiver.kernel.org>; Wed, 21 May 2025 04:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7P7k8gutjP8wk9Jbfv5pLHYgNfWP20/s0ynYFVASyHQ=; b=qFm/jAHZj7Epn/CRdb/v5ckelp
	HcPVA87186FvdpWH2ZUhcM3S8XJJ+kjsJVaXKCMxRgm2UCf1VYbEy3v6+XqUdqGGhgjKIcoOylLOK
	8R1DleiDYyZ3Xue45QMqZP+qEUtWnTGBfDb26/ktJa76YwHosXb+k+EvV6T/9BlcwgYpNl7vLI313
	j8ZpB0Dxci7O/aCCjyfxPLxUM7mg83oGv0nM+COaRzb2nmV9sizseKfanjCbKjUhp44wV4FiaooXh
	brBw9qZN7Q794qfAGCmLcOdwV0EdzIgYSw2cVyQlx5RhwWKC1FeI3OfSHJItdz32yYxyWA9GGp2N8
	EOPW1x4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHbR1-0000000Emdo-1G00;
	Wed, 21 May 2025 04:52:07 +0000
Received: from omta034.useast.a.cloudfilter.net ([44.202.169.33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHYwE-0000000EYy6-3Sgj
	for linux-nvme@lists.infradead.org;
	Wed, 21 May 2025 02:12:12 +0000
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTPS
	id HLdduLyPVXshwHYwDus27f; Wed, 21 May 2025 02:12:09 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id HYwCu1BTdc6KWHYwDuy72R; Wed, 21 May 2025 02:12:09 +0000
X-Authority-Analysis: v=2.4 cv=L/QbQfT8 c=1 sm=1 tr=0 ts=682d3679
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=efVMuJ2jJG67FGuSm7J3ww==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=sEkq5x4IAAAA:8 a=P-IC7800AAAA:8 a=J1Y8HTJGAAAA:8
 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=gngr1YUT0vIlzbvq1ooA:9 a=QEXdDO2ut3YA:10
 a=llby-PD1hR8gYtG5ERSV:22 a=d3PnA9EDa4IxuAV0gXij:22 a=y1Q9-5lHfBjTkpIzbSAN:22
 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7P7k8gutjP8wk9Jbfv5pLHYgNfWP20/s0ynYFVASyHQ=; b=VSV6PJzYxmzLKICGhF42m8Vi2R
	OaT63JSAPdu+cq8rEXrP4DtdJBB20u5rEkBzK3Ff8VnoSTWNRCOBHDQ6LmxlDC0l4MZKiCt7zeFI3
	fjX2bnEH9qeumhXPOsOuLxAb7ZARIsGyPSGvWXRr5bFW95dQBfjqKxEVkdw4vFK7rdxK10h7quROX
	1ZXwJf6nIZUWxB7ef0Hf1m2CXne63iEscWFv8Jk0DN1QI+Jl8W3CtWTnQlGzC7OxvXLmMXvDYt7zj
	3sYsgqQrg5wUqYmgbf5u2GzGGm9xZHvjeSfu6yTgZdbyeb4tjuUacLvfbcmmtnglDrD1zPdczfUMu
	8DzK67iQ==;
Received: from [177.238.17.151] (port=37062 helo=[192.168.0.27])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1uHVmK-000000014bO-0QiZ;
	Tue, 20 May 2025 17:49:44 -0500
Message-ID: <96e156aa-0882-46e6-bd8b-8285e76481e7@embeddedor.com>
Date: Tue, 20 May 2025 16:49:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] ieee802154: Use struct sockaddr_storage with
 dev_set_mac_address()
To: Kees Cook <kees@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Alexander Aring <alex.aring@gmail.com>,
 Stefan Schmidt <stefan@datenfreihafen.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Mike Christie <michael.christie@oracle.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>, Maurizio Lombardi
 <mlombard@redhat.com>, Dmitry Bogdanov <d.bogdanov@yadro.com>,
 Mingzhe Zou <mingzhe.zou@easystack.cn>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Stanislav Fomichev <sdf@fomichev.me>,
 Cosmin Ratiu <cratiu@nvidia.com>, Lei Yang <leiyang@redhat.com>,
 Ido Schimmel <idosch@nvidia.com>, Samuel Mendoza-Jonas
 <sam@mendozajonas.com>, Paul Fertser <fercerpav@gmail.com>,
 Hayes Wang <hayeswang@realtek.com>, Douglas Anderson
 <dianders@chromium.org>, Grant Grundler <grundler@chromium.org>,
 Jay Vosburgh <jv@jvosburgh.net>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Jiri Pirko <jiri@resnulli.us>,
 Eric Biggers <ebiggers@google.com>, Milan Broz <gmazyland@gmail.com>,
 Philipp Hahn <phahn-oss@avm.de>, Ard Biesheuvel <ardb@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xiao Liang <shaw.leon@gmail.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250520222452.work.063-kees@kernel.org>
 <20250520223108.2672023-4-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20250520223108.2672023-4-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.17.151
X-Source-L: No
X-Exim-ID: 1uHVmK-000000014bO-0QiZ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.27]) [177.238.17.151]:37062
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMqwwnJ0Yy+Ye0t1AvJYwLp1giDmvcfeR2Rf4u/2LwDqUlogJb0NGmmuaxPbD07Yw9uN6Z+ZVVSUuJrxLKDLplxvNyBKvW5LtTZt3gW5FFA7ud91X5Pj
 QYouq8nfRvf2h2bfPspYQRq7ZL8iTAot5d8y0d3aG5j9hWK4hUqaN1oxa2usBydKfIhH7mZzpYar7/wI0uDWJxSwu6kfQEZEMqEyjDwX3NGsy8L5ytHShMaq
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_191210_949556_F8E5706B 
X-CRM114-Status: GOOD (  12.55  )
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



On 20/05/25 16:31, Kees Cook wrote:
> Switch to struct sockaddr_storage for calling dev_set_mac_address(). Add
> a temporary cast to struct sockaddr, which will be removed in a
> subsequent patch.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-Gustavo

> ---
> Cc: Alexander Aring <alex.aring@gmail.com>
> Cc: Stefan Schmidt <stefan@datenfreihafen.org>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: <linux-wpan@vger.kernel.org>
> Cc: <netdev@vger.kernel.org>
> ---
>   net/ieee802154/nl-phy.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ieee802154/nl-phy.c b/net/ieee802154/nl-phy.c
> index 359249ab77bf..ee2b190e8e0d 100644
> --- a/net/ieee802154/nl-phy.c
> +++ b/net/ieee802154/nl-phy.c
> @@ -224,17 +224,17 @@ int ieee802154_add_iface(struct sk_buff *skb, struct genl_info *info)
>   	dev_hold(dev);
>   
>   	if (info->attrs[IEEE802154_ATTR_HW_ADDR]) {
> -		struct sockaddr addr;
> +		struct sockaddr_storage addr;
>   
> -		addr.sa_family = ARPHRD_IEEE802154;
> -		nla_memcpy(&addr.sa_data, info->attrs[IEEE802154_ATTR_HW_ADDR],
> +		addr.ss_family = ARPHRD_IEEE802154;
> +		nla_memcpy(&addr.__data, info->attrs[IEEE802154_ATTR_HW_ADDR],
>   			   IEEE802154_ADDR_LEN);
>   
>   		/* strangely enough, some callbacks (inetdev_event) from
>   		 * dev_set_mac_address require RTNL_LOCK
>   		 */
>   		rtnl_lock();
> -		rc = dev_set_mac_address(dev, &addr, NULL);
> +		rc = dev_set_mac_address(dev, (struct sockaddr *)&addr, NULL);
>   		rtnl_unlock();
>   		if (rc)
>   			goto dev_unregister;


