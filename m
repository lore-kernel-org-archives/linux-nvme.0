Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19224C54ED0
	for <linux-nvme@archiver.kernel.org>; Wed, 21 May 2025 04:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GCSOMPC5nSp6vXCJCOyw43TeCqRPw0aHopDjgStRrEo=; b=enxfwzh3ryZ+nKPWi/x+ROb284
	6gnzxlTRCjjNkf40SpUWXus5dtBdSgjTD2g8RHcSm6RgClzQA1NZpObCP3hppiaKGm3dRSzEW2S+z
	0dD71iXeYtLxCoGOuLRmfiPGfWBNXDCCgMCKeidhMYtEBbhkIEWP5rPlfphoeNF4vQ10W4LNr2low
	/8a2YxmaR6c6J/uEsQU22qCwy82vV8opILN0uzJ4ba/yLLBpPdmYOGyRpqdn1K5l+FVwdPEZJx5Wl
	F6ZC021e1y+/jJy1Fs3RppIFSzFTm9yrSTaGUw7BcUOu1uDBXv2zTkHJmPR8WKQ/r2AT6Ty8zv5+M
	u4YD5B9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHbR0-0000000EmcI-2DEQ;
	Wed, 21 May 2025 04:52:06 +0000
Received: from omta34.uswest2.a.cloudfilter.net ([35.89.44.33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHYmF-0000000EYId-2RIj
	for linux-nvme@lists.infradead.org;
	Wed, 21 May 2025 02:01:52 +0000
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTPS
	id HLdcuMT7HWuHKHYmEuCeVn; Wed, 21 May 2025 02:01:50 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id HYmDurnPyJ4PgHYmDuZwMu; Wed, 21 May 2025 02:01:49 +0000
X-Authority-Analysis: v=2.4 cv=ZaLWNdVA c=1 sm=1 tr=0 ts=682d340d
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=efVMuJ2jJG67FGuSm7J3ww==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=vggBfdFIAAAA:8 a=1XWaLZrsAAAA:8 a=J1Y8HTJGAAAA:8 a=20KFwNOVAAAA:8
 a=Ikd4Dj_1AAAA:8 a=80Ll13GqqWtdygCPsrQA:9 a=QEXdDO2ut3YA:10
 a=y1Q9-5lHfBjTkpIzbSAN:22 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GCSOMPC5nSp6vXCJCOyw43TeCqRPw0aHopDjgStRrEo=; b=RkOEIL8HdLqtSdBneGawhJ03KC
	V5lylhiwlA4tjpIzNUfTJZWG/JI7KZeu0R6u6RT1Wgrna+sdG1TDsjQp636L0eq6FZoYKWChuB7Fw
	OZ0G0KSPZ070n11fgREH1/0pK0bKpUB1DPc5b1W9aIcMOqclPtiHhEqQxW+bGAm7kgVZE2mo/dh/j
	6zJNBFSYvPNpVvAkrfTJ/WhewMnZXFW4+yGGQzgISc7mhKsZql+BSiIpOk5uDOG5GEinCO8EkqnBy
	s1A4m2PG6KKo5ero7hH8QxQugRIrdkWVBAN3yDhtTyq0bNE9UoLHmAnxwgN9oLTnhDbcmdEAAKCgY
	iZ1Mg+vw==;
Received: from [177.238.17.151] (port=45184 helo=[192.168.0.27])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1uHVnL-00000001711-3dD6;
	Tue, 20 May 2025 17:50:47 -0500
Message-ID: <2af2857c-d4b9-45c1-b241-dffa23ff4f32@embeddedor.com>
Date: Tue, 20 May 2025 16:50:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] rtnetlink: do_setlink: Use struct sockaddr_storage
To: Kees Cook <kees@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
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
 Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 Paul Fertser <fercerpav@gmail.com>, Alexander Aring <alex.aring@gmail.com>,
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
 <20250520223108.2672023-7-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20250520223108.2672023-7-kees@kernel.org>
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
X-Exim-ID: 1uHVnL-00000001711-3dD6
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.27]) [177.238.17.151]:45184
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHxPBh10o2qGf/wnu4YlScWfubgHpH15kGe3wXhHz4lqkRpOL+UWGTP02NFY20qujzb7L5q/+CdHL3G/xo3JCFRPhVFNSpL7wM7Cfjr1WS5+aJcSc6YG
 HnAKa3OCbiIOyey3aCJbOqHvi3yMnFyu6QtZ7J+M6sP3c7GLoM7ImD3TD7+fxm3l0zPlyEwv8yJ5ukraENfnhTqcAA6qVV5YB3DnVllNrHFaibxmimNB+sc8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_190151_639971_76F34241 
X-CRM114-Status: GOOD (  15.88  )
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
> Instead of a heap allocating a variably sized struct sockaddr and lying
> about the type in the call to netif_set_mac_address(), use a stack
> allocated struct sockaddr_storage. This lets us drop the cast and avoid
> the allocation.
> 
> Putting "ss" on the stack means it will get a reused stack slot since
> it is the same size (128B) as other existing single-scope stack variables,
> like the vfinfo array (128B), so no additional stack space is used by
> this function.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-Gustavo

> ---
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Ido Schimmel <idosch@nvidia.com>
> Cc: <netdev@vger.kernel.org>
> ---
>   net/core/rtnetlink.c | 19 ++++---------------
>   1 file changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 9743f1c2ae3c..f9a35bdc58ad 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -3080,17 +3080,7 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
>   	}
>   
>   	if (tb[IFLA_ADDRESS]) {
> -		struct sockaddr *sa;
> -		int len;
> -
> -		len = sizeof(sa_family_t) + max_t(size_t, dev->addr_len,
> -						  sizeof(*sa));
> -		sa = kmalloc(len, GFP_KERNEL);
> -		if (!sa) {
> -			err = -ENOMEM;
> -			goto errout;
> -		}
> -		sa->sa_family = dev->type;
> +		struct sockaddr_storage ss = { };
>   
>   		netdev_unlock_ops(dev);
>   
> @@ -3098,10 +3088,9 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
>   		down_write(&dev_addr_sem);
>   		netdev_lock_ops(dev);
>   
> -		memcpy(sa->sa_data, nla_data(tb[IFLA_ADDRESS]),
> -		       dev->addr_len);
> -		err = netif_set_mac_address(dev, (struct sockaddr_storage *)sa, extack);
> -		kfree(sa);
> +		ss.ss_family = dev->type;
> +		memcpy(ss.__data, nla_data(tb[IFLA_ADDRESS]), dev->addr_len);
> +		err = netif_set_mac_address(dev, &ss, extack);
>   		if (err) {
>   			up_write(&dev_addr_sem);
>   			goto errout;


