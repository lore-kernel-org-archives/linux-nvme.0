Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FAEC54E92
	for <linux-nvme@archiver.kernel.org>; Wed, 21 May 2025 04:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R8bUBxbfLPBwXJ+JkrMkShoBfyt0h/bJ2GrUyKjOTmQ=; b=OJ4koBffhes2uXXOnFD9f+SvEq
	wQfqVd4NXhqFhMaCliB6S2cRoJNmlWZBhiqS0FziRHr07KWJ0zitJPMlZNd5g85uJZNuJfpe16DUR
	tKZHcUGFf8JVjZofS5tnovkPuShzpOxJooyKi6rkPyBZ2sZDIO1UBcL55WA/T3lTKZJhCuUaUkukb
	cwkZxLBysaYcWvT/7n+LA28uxneB+WdY2QZ09NBq1SEO+5ONTD42qW09u+d34yG/Dhc3ysjxzYzJQ
	g6wUxD6s6TiFAmIRlUeJJWtoVRE73D1Ajh5Ikuchr16ZXELwZhajy4eguUESA2zoASt9IiCSUXAOl
	XH1GBXFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHbQv-0000000EmVi-3t92;
	Wed, 21 May 2025 04:52:01 +0000
Received: from omta040.useast.a.cloudfilter.net ([44.202.169.39])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHWZI-0000000ENxt-2mhc
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 23:40:21 +0000
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
	by cmsmtp with ESMTPS
	id HT88umk3RVkcRHWZHuWSZr; Tue, 20 May 2025 23:40:19 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id HWZGuOzKhZ6h1HWZGufumI; Tue, 20 May 2025 23:40:18 +0000
X-Authority-Analysis: v=2.4 cv=ergUzZpX c=1 sm=1 tr=0 ts=682d12e2
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=efVMuJ2jJG67FGuSm7J3ww==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=n9Sqmae0AAAA:8
 a=cm27Pg_UAAAA:8 a=Qgl8qZTgVK1AUjxnc7MA:9 a=QEXdDO2ut3YA:10
 a=y1Q9-5lHfBjTkpIzbSAN:22 a=UmAUUZEt6-oIqEbegvw9:22 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=R8bUBxbfLPBwXJ+JkrMkShoBfyt0h/bJ2GrUyKjOTmQ=; b=dPwddyOPfHAls/PSm85fnGvuo3
	qVD4xNbHvebzIhLndrd8gl7LN9baxSB72kgQP5yXK+VoHbS8yKQANP2FAsufZyeHQlgfEzQCowrOA
	npKcx5veLr5v4egqZ0/30CEHYctPXSTdGi8kGLvyxYNMeAKXscso1hHVtb7durDr0YulzAkOmJbhG
	8EyFXPB/1mUuYdSEby0yKvcvyQTQLBWzyZcI2N8qvjhs3D5RPcSVdRiVlBJ6wyuo+UZ7x7vRoXwEk
	3J1OLZULaMvp6A7A4ifYJPp2ETj0RFlRMqhNR3jYfEPXyAJCTNtiLkSx4W73cx3SZi+HXB39W7tKA
	QtgUJ9AQ==;
Received: from [177.238.17.151] (port=37062 helo=[192.168.0.27])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1uHVmk-000000014bO-1zvp;
	Tue, 20 May 2025 17:50:11 -0500
Message-ID: <5e54efbb-a7e5-43e3-b30a-0fdd920de016@embeddedor.com>
Date: Tue, 20 May 2025 16:49:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] net: usb: r8152: Convert to use struct
 sockaddr_storage internally
To: Kees Cook <kees@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Hayes Wang <hayeswang@realtek.com>, Douglas Anderson
 <dianders@chromium.org>, Grant Grundler <grundler@chromium.org>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Mike Christie <michael.christie@oracle.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>, Maurizio Lombardi
 <mlombard@redhat.com>, Dmitry Bogdanov <d.bogdanov@yadro.com>,
 Mingzhe Zou <mingzhe.zou@easystack.cn>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Simon Horman <horms@kernel.org>, "Dr. David Alan Gilbert"
 <linux@treblig.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Cosmin Ratiu <cratiu@nvidia.com>, Lei Yang <leiyang@redhat.com>,
 Ido Schimmel <idosch@nvidia.com>, Samuel Mendoza-Jonas
 <sam@mendozajonas.com>, Paul Fertser <fercerpav@gmail.com>,
 Alexander Aring <alex.aring@gmail.com>,
 Stefan Schmidt <stefan@datenfreihafen.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Jay Vosburgh <jv@jvosburgh.net>,
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
 linux-hyperv@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250520222452.work.063-kees@kernel.org>
 <20250520223108.2672023-5-kees@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20250520223108.2672023-5-kees@kernel.org>
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
X-Exim-ID: 1uHVmk-000000014bO-1zvp
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.27]) [177.238.17.151]:37062
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKLeQAGNRmIj4+Me6v8DxtvSvpZRpprZ04Ixgip9s5IQx72TPTtMhOZ+82chi9/orGd8naYCoDU3sGvGB6RFzGHyWTD75RI6zA49LKVhiKvbqabpULjm
 zGNgDwzyaD6GRgtVchSBrueXQOU4vS2CjqsuYh16BL98tZ2HmHXZ3Ic1T5MucX1fg7lFwVaMtOsAzJAKGxJNgZQX2ooRZsWCyMPFenhguZlKL0YL3nCjDV7n
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_164020_794068_1BD4744B 
X-CRM114-Status: GOOD (  18.75  )
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
> To support coming API type changes, switch to sockaddr_storage usage
> internally.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-Gustavo

> ---
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Hayes Wang <hayeswang@realtek.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Grant Grundler <grundler@chromium.org>
> Cc: <linux-usb@vger.kernel.org>
> Cc: <netdev@vger.kernel.org>
> ---
>   drivers/net/usb/r8152.c | 52 +++++++++++++++++++++--------------------
>   1 file changed, 27 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 67f5d30ffcba..b18dee1b1bb3 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -1665,14 +1665,14 @@ static int
>   rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
>   		  u32 advertising);
>   
> -static int __rtl8152_set_mac_address(struct net_device *netdev, void *p,
> +static int __rtl8152_set_mac_address(struct net_device *netdev,
> +				     struct sockaddr_storage *addr,
>   				     bool in_resume)
>   {
>   	struct r8152 *tp = netdev_priv(netdev);
> -	struct sockaddr *addr = p;
>   	int ret = -EADDRNOTAVAIL;
>   
> -	if (!is_valid_ether_addr(addr->sa_data))
> +	if (!is_valid_ether_addr(addr->__data))
>   		goto out1;
>   
>   	if (!in_resume) {
> @@ -1683,10 +1683,10 @@ static int __rtl8152_set_mac_address(struct net_device *netdev, void *p,
>   
>   	mutex_lock(&tp->control);
>   
> -	eth_hw_addr_set(netdev, addr->sa_data);
> +	eth_hw_addr_set(netdev, addr->__data);
>   
>   	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CRWECR, CRWECR_CONFIG);
> -	pla_ocp_write(tp, PLA_IDR, BYTE_EN_SIX_BYTES, 8, addr->sa_data);
> +	pla_ocp_write(tp, PLA_IDR, BYTE_EN_SIX_BYTES, 8, addr->__data);
>   	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CRWECR, CRWECR_NORAML);
>   
>   	mutex_unlock(&tp->control);
> @@ -1706,7 +1706,8 @@ static int rtl8152_set_mac_address(struct net_device *netdev, void *p)
>    * host system provided MAC address.
>    * Examples of this are Dell TB15 and Dell WD15 docks
>    */
> -static int vendor_mac_passthru_addr_read(struct r8152 *tp, struct sockaddr *sa)
> +static int vendor_mac_passthru_addr_read(struct r8152 *tp,
> +					 struct sockaddr_storage *ss)
>   {
>   	acpi_status status;
>   	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> @@ -1774,47 +1775,48 @@ static int vendor_mac_passthru_addr_read(struct r8152 *tp, struct sockaddr *sa)
>   		ret = -EINVAL;
>   		goto amacout;
>   	}
> -	memcpy(sa->sa_data, buf, 6);
> +	memcpy(ss->__data, buf, 6);
>   	tp->netdev->addr_assign_type = NET_ADDR_STOLEN;
>   	netif_info(tp, probe, tp->netdev,
> -		   "Using pass-thru MAC addr %pM\n", sa->sa_data);
> +		   "Using pass-thru MAC addr %pM\n", ss->__data);
>   
>   amacout:
>   	kfree(obj);
>   	return ret;
>   }
>   
> -static int determine_ethernet_addr(struct r8152 *tp, struct sockaddr *sa)
> +static int determine_ethernet_addr(struct r8152 *tp,
> +				   struct sockaddr_storage *ss)
>   {
>   	struct net_device *dev = tp->netdev;
>   	int ret;
>   
> -	sa->sa_family = dev->type;
> +	ss->ss_family = dev->type;
>   
> -	ret = eth_platform_get_mac_address(&tp->udev->dev, sa->sa_data);
> +	ret = eth_platform_get_mac_address(&tp->udev->dev, ss->__data);
>   	if (ret < 0) {
>   		if (tp->version == RTL_VER_01) {
> -			ret = pla_ocp_read(tp, PLA_IDR, 8, sa->sa_data);
> +			ret = pla_ocp_read(tp, PLA_IDR, 8, ss->__data);
>   		} else {
>   			/* if device doesn't support MAC pass through this will
>   			 * be expected to be non-zero
>   			 */
> -			ret = vendor_mac_passthru_addr_read(tp, sa);
> +			ret = vendor_mac_passthru_addr_read(tp, ss);
>   			if (ret < 0)
>   				ret = pla_ocp_read(tp, PLA_BACKUP, 8,
> -						   sa->sa_data);
> +						   ss->__data);
>   		}
>   	}
>   
>   	if (ret < 0) {
>   		netif_err(tp, probe, dev, "Get ether addr fail\n");
> -	} else if (!is_valid_ether_addr(sa->sa_data)) {
> +	} else if (!is_valid_ether_addr(ss->__data)) {
>   		netif_err(tp, probe, dev, "Invalid ether addr %pM\n",
> -			  sa->sa_data);
> +			  ss->__data);
>   		eth_hw_addr_random(dev);
> -		ether_addr_copy(sa->sa_data, dev->dev_addr);
> +		ether_addr_copy(ss->__data, dev->dev_addr);
>   		netif_info(tp, probe, dev, "Random ether addr %pM\n",
> -			   sa->sa_data);
> +			   ss->__data);
>   		return 0;
>   	}
>   
> @@ -1824,17 +1826,17 @@ static int determine_ethernet_addr(struct r8152 *tp, struct sockaddr *sa)
>   static int set_ethernet_addr(struct r8152 *tp, bool in_resume)
>   {
>   	struct net_device *dev = tp->netdev;
> -	struct sockaddr sa;
> +	struct sockaddr_storage ss;
>   	int ret;
>   
> -	ret = determine_ethernet_addr(tp, &sa);
> +	ret = determine_ethernet_addr(tp, &ss);
>   	if (ret < 0)
>   		return ret;
>   
>   	if (tp->version == RTL_VER_01)
> -		eth_hw_addr_set(dev, sa.sa_data);
> +		eth_hw_addr_set(dev, ss.__data);
>   	else
> -		ret = __rtl8152_set_mac_address(dev, &sa, in_resume);
> +		ret = __rtl8152_set_mac_address(dev, &ss, in_resume);
>   
>   	return ret;
>   }
> @@ -8421,7 +8423,7 @@ static int rtl8152_post_reset(struct usb_interface *intf)
>   {
>   	struct r8152 *tp = usb_get_intfdata(intf);
>   	struct net_device *netdev;
> -	struct sockaddr sa;
> +	struct sockaddr_storage ss;
>   
>   	if (!tp || !test_bit(PROBED_WITH_NO_ERRORS, &tp->flags))
>   		goto exit;
> @@ -8429,8 +8431,8 @@ static int rtl8152_post_reset(struct usb_interface *intf)
>   	rtl_set_accessible(tp);
>   
>   	/* reset the MAC address in case of policy change */
> -	if (determine_ethernet_addr(tp, &sa) >= 0)
> -		dev_set_mac_address (tp->netdev, &sa, NULL);
> +	if (determine_ethernet_addr(tp, &ss) >= 0)
> +		dev_set_mac_address(tp->netdev, (struct sockaddr *)&ss, NULL);
>   
>   	netdev = tp->netdev;
>   	if (!netif_running(netdev))


