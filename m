Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A4DC2D0CD
	for <linux-nvme@archiver.kernel.org>; Wed, 21 May 2025 04:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m0Sgv2xQObBfrVQ5o4f/G36TLeQWyWSFMFj3tSm1xxo=; b=CyjLrdWc5UNyqRcsY0kCvZj7x5
	knJrqPUyYQkkbdphRoCR84b7z646948uFk6kJJ2FqWjRPCnATdya5vAX8/SDaVERkhbi8LODY5UtZ
	3dpF5YdHI6lakVTdH3o8k00tWP1cOTk/tY/B6AEZwqRQopkucDkzLs7iAQ+89zFac20YnQe0wIVyB
	/7nMQemNfLbwxWAMYL8THHxNJrESXiwD45fLJ6hPvA29tUIpgSm+9p90fTuSs3tbH7F3dgUeJQcRC
	8/x5nVxDma0h4uZS4yJbS/QEEJ6Tu/RQksgQOMIEtA19LGJI1b1BAxV4sj0pglyjADo84tc0PFDG8
	hSBqYfyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHbQz-0000000Emaq-34et;
	Wed, 21 May 2025 04:52:05 +0000
Received: from omta036.useast.a.cloudfilter.net ([44.202.169.35])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHYey-0000000EXcS-1e71
	for linux-nvme@lists.infradead.org;
	Wed, 21 May 2025 01:54:21 +0000
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTPS
	id HU4CulIZezZPaHYewuWmLu; Wed, 21 May 2025 01:54:18 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id HYevu0qJzc6KWHYevuxm97; Wed, 21 May 2025 01:54:17 +0000
X-Authority-Analysis: v=2.4 cv=L/QbQfT8 c=1 sm=1 tr=0 ts=682d3249
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=efVMuJ2jJG67FGuSm7J3ww==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=jT_9lS9cAAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8
 a=20KFwNOVAAAA:8 a=jAoKAhDiyLNNFIt04WcA:9 a=QEXdDO2ut3YA:10
 a=Ec8Bv2-zM_L_lWdDgjzK:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=m0Sgv2xQObBfrVQ5o4f/G36TLeQWyWSFMFj3tSm1xxo=; b=p/QC0DeZWBoMfFQmEYO8zYmywp
	gUvDU/K3IwDn8tTqJo55ZHGzxFxuJROBdMK9HOfEDm4KuUdAL3fKX9WJ1Noque7KlutJ2VjZHe0Ra
	Ff3KfWQjbx8/nndfcLIBULP8MQeA6ebPdBOKgArsYtJZ4C/cmghkHbrRzdWdrNu6mRd+BnJWtA1b2
	sCUIcIwFpmNuP7TNaEcF0AgBSKbIG/KpYOV37upwXUJdo7Z4qOTDgs1MCk4+bHspuC6gu1LPlzHz6
	9HKuSL2pU20c4fCDAN3ELqTlFDLFNibvvrYejrntX+nAgwUPRw1day3awBaDB8IqsJ7S1TYpA/2S9
	98thY1HA==;
Received: from [177.238.17.151] (port=48738 helo=[192.168.0.27])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1uHVlQ-000000011s1-1d7y;
	Tue, 20 May 2025 17:48:49 -0500
Message-ID: <b5ead7f5-1bc1-442f-9d17-34564571b3ce@embeddedor.com>
Date: Tue, 20 May 2025 16:48:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] net/ncsi: Use struct sockaddr_storage for pending_mac
To: Kees Cook <kees@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 Paul Fertser <fercerpav@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
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
 Ido Schimmel <idosch@nvidia.com>, Alexander Aring <alex.aring@gmail.com>,
 Stefan Schmidt <stefan@datenfreihafen.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Hayes Wang
 <hayeswang@realtek.com>, Douglas Anderson <dianders@chromium.org>,
 Grant Grundler <grundler@chromium.org>, Jay Vosburgh <jv@jvosburgh.net>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Jiri Pirko <jiri@resnulli.us>,
 Eric Biggers <ebiggers@google.com>, Milan Broz <gmazyland@gmail.com>,
 Philipp Hahn <phahn-oss@avm.de>, Ard Biesheuvel <ardb@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xiao Liang <shaw.leon@gmail.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-wpan@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250520222452.work.063-kees@kernel.org>
 <20250520223108.2672023-3-kees@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20250520223108.2672023-3-kees@kernel.org>
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
X-Exim-ID: 1uHVlQ-000000011s1-1d7y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.27]) [177.238.17.151]:48738
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCZtPq68S170AEIpScaX1t8vzRE+oFtoTrggxUbNBZ0UgegRS4uE3/qcx+cwAS8p3hNUq2P5LvaoJyupw/LBeqfWlRm/L0O3LUmaZcjErejaEBSSNIB7
 uzhP17jnfHku3V1dDq63G1nzRWgFhxh3NILWyIqL9Rl85BDBXZJPV+fIQeUAMlKmkXSIZ8L1XQx+Qr9Sf+3suKkjqExyuXhvWFdE4Leo2CfcQXcj3QDAN8zQ
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_185420_505855_3435AF69 
X-CRM114-Status: GOOD (  20.35  )
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
> To avoid future casting with coming API type changes, switch struct
> ncsi_dev_priv::pending_mac to a full struct sockaddr_storage.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-Gustavo

> ---
> Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>
> Cc: Paul Fertser <fercerpav@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: <netdev@vger.kernel.org>
> ---
>   net/ncsi/internal.h    |  2 +-
>   net/ncsi/ncsi-manage.c |  2 +-
>   net/ncsi/ncsi-rsp.c    | 18 +++++++++---------
>   3 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
> index 2c260f33b55c..e76c6de0c784 100644
> --- a/net/ncsi/internal.h
> +++ b/net/ncsi/internal.h
> @@ -322,7 +322,7 @@ struct ncsi_dev_priv {
>   #define NCSI_DEV_RESHUFFLE	4
>   #define NCSI_DEV_RESET		8            /* Reset state of NC          */
>   	unsigned int        gma_flag;        /* OEM GMA flag               */
> -	struct sockaddr     pending_mac;     /* MAC address received from GMA */
> +	struct sockaddr_storage pending_mac; /* MAC address received from GMA */
>   	spinlock_t          lock;            /* Protect the NCSI device    */
>   	unsigned int        package_probe_id;/* Current ID during probe    */
>   	unsigned int        package_num;     /* Number of packages         */
> diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
> index b36947063783..0202db2aea3e 100644
> --- a/net/ncsi/ncsi-manage.c
> +++ b/net/ncsi/ncsi-manage.c
> @@ -1058,7 +1058,7 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
>   		break;
>   	case ncsi_dev_state_config_apply_mac:
>   		rtnl_lock();
> -		ret = dev_set_mac_address(dev, &ndp->pending_mac, NULL);
> +		ret = dev_set_mac_address(dev, (struct sockaddr *)&ndp->pending_mac, NULL);
>   		rtnl_unlock();
>   		if (ret < 0)
>   			netdev_warn(dev, "NCSI: 'Writing MAC address to device failed\n");
> diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
> index 8668888c5a2f..472cc68ad86f 100644
> --- a/net/ncsi/ncsi-rsp.c
> +++ b/net/ncsi/ncsi-rsp.c
> @@ -628,7 +628,7 @@ static int ncsi_rsp_handler_snfc(struct ncsi_request *nr)
>   static int ncsi_rsp_handler_oem_gma(struct ncsi_request *nr, int mfr_id)
>   {
>   	struct ncsi_dev_priv *ndp = nr->ndp;
> -	struct sockaddr *saddr = &ndp->pending_mac;
> +	struct sockaddr_storage *saddr = &ndp->pending_mac;
>   	struct net_device *ndev = ndp->ndev.dev;
>   	struct ncsi_rsp_oem_pkt *rsp;
>   	u32 mac_addr_off = 0;
> @@ -644,11 +644,11 @@ static int ncsi_rsp_handler_oem_gma(struct ncsi_request *nr, int mfr_id)
>   	else if (mfr_id == NCSI_OEM_MFR_INTEL_ID)
>   		mac_addr_off = INTEL_MAC_ADDR_OFFSET;
>   
> -	saddr->sa_family = ndev->type;
> -	memcpy(saddr->sa_data, &rsp->data[mac_addr_off], ETH_ALEN);
> +	saddr->ss_family = ndev->type;
> +	memcpy(saddr->__data, &rsp->data[mac_addr_off], ETH_ALEN);
>   	if (mfr_id == NCSI_OEM_MFR_BCM_ID || mfr_id == NCSI_OEM_MFR_INTEL_ID)
> -		eth_addr_inc((u8 *)saddr->sa_data);
> -	if (!is_valid_ether_addr((const u8 *)saddr->sa_data))
> +		eth_addr_inc(saddr->__data);
> +	if (!is_valid_ether_addr(saddr->__data))
>   		return -ENXIO;
>   
>   	/* Set the flag for GMA command which should only be called once */
> @@ -1088,7 +1088,7 @@ static int ncsi_rsp_handler_netlink(struct ncsi_request *nr)
>   static int ncsi_rsp_handler_gmcma(struct ncsi_request *nr)
>   {
>   	struct ncsi_dev_priv *ndp = nr->ndp;
> -	struct sockaddr *saddr = &ndp->pending_mac;
> +	struct sockaddr_storage *saddr = &ndp->pending_mac;
>   	struct net_device *ndev = ndp->ndev.dev;
>   	struct ncsi_rsp_gmcma_pkt *rsp;
>   	int i;
> @@ -1105,15 +1105,15 @@ static int ncsi_rsp_handler_gmcma(struct ncsi_request *nr)
>   			    rsp->addresses[i][4], rsp->addresses[i][5]);
>   	}
>   
> -	saddr->sa_family = ndev->type;
> +	saddr->ss_family = ndev->type;
>   	for (i = 0; i < rsp->address_count; i++) {
>   		if (!is_valid_ether_addr(rsp->addresses[i])) {
>   			netdev_warn(ndev, "NCSI: Unable to assign %pM to device\n",
>   				    rsp->addresses[i]);
>   			continue;
>   		}
> -		memcpy(saddr->sa_data, rsp->addresses[i], ETH_ALEN);
> -		netdev_warn(ndev, "NCSI: Will set MAC address to %pM\n", saddr->sa_data);
> +		memcpy(saddr->__data, rsp->addresses[i], ETH_ALEN);
> +		netdev_warn(ndev, "NCSI: Will set MAC address to %pM\n", saddr->__data);
>   		break;
>   	}
>   


