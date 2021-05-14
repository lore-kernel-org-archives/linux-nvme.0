Return-Path: <SRS0=3vHZ=KJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AC8C433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 17:46:07 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83749613E9
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 17:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83749613E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jTYOA+wIlmDKEWJz3Vt3OBThyzByGSdLAactAUsrHxo=; b=hHwP0RDM3J3OsKn1YF1tUyeYT
	eyuH7tDh6kXunsavBIZIuHf/kCIZzsnLQlhpxS353lCgbsmOlOpAhLAVboMlnkvhkO6SEla0ptESX
	Ptd9YMUP2NsPl6nQvA2Hmecd6vkvYodcwxO7Sm/apaoRIiE+mE63Ym1KAJj0i4QX8WqGS6m4VZU0G
	RgzVqi6k6TKTvw/H/jCh5mmWetjHcaGySj5j+SE1AoR7plMyM66OyRoxDC9OChKv8oYaVDculzs04
	sWvBpcrNLE6Lcwrk+wS5Sh/wsuqH29SizNdeZJ+VBfzlW0OyvMVLDtaq2j0TakeUYi7ArQwzDWG8f
	If7M8CJWw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhbsl-008cf4-4V; Fri, 14 May 2021 17:45:51 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhbsj-008cer-6u
 for linux-nvme@desiato.infradead.org; Fri, 14 May 2021 17:45:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=v25PI+WuRXdLLUkQkjvLpg6AUElTHRMnbySnvWyJTL8=; b=t4kJbrwbubQy+UvuzKSDZzmzIT
 nOUfzYhWEckyJpROe4gLNDdcSKN+qF+ofn8HtFeZ5PuZ+7joLFa/QDPkNhtVhrSA/xSMWoLabeS21
 wu27uWZKsb7u/f4VA+50GVoehyA49VmSApTskUk1FOzKB13vBqbqZ9PeJs1i7fNTP7lBtbW2+3LCC
 IaurcTAAdlOl65Uq5ryAN41aKaEjbFyYE6IP7VLKir2zfvucq8bmbLP8XcSjM+B/9SK/tWCM977oh
 rXbFhIHiFqzxO9X/ChiP4A/cJIx4MrptGSRGXiFZJGjuW3S7znwKKDxNI0FiZg1Q7EQpmzvmnXR/y
 QKSHwGkA==;
Received: from mail-pl1-f179.google.com ([209.85.214.179])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhbsf-00C9tU-DZ
 for linux-nvme@lists.infradead.org; Fri, 14 May 2021 17:45:47 +0000
Received: by mail-pl1-f179.google.com with SMTP id p6so671792plr.11
 for <linux-nvme@lists.infradead.org>; Fri, 14 May 2021 10:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v25PI+WuRXdLLUkQkjvLpg6AUElTHRMnbySnvWyJTL8=;
 b=syo0+vd2Kwp1WeHgcnWYsBUfAwKfmGINWLNoXvy0HbCc/0yRJ8S4aL+nbDv7qpfbk3
 bmFKuhXhdfrbevHD/ZNHNlQFa6Tto+LACN/sorDVOQ6TZeFMd/BSDFuk5LcuOPjdivuu
 JmjlDGITgIehwTpCAWOGT7xGVyYCkrg3XwkEnaqoWzUeEgtQHDeIDLxdE5hew7eXi3e3
 noaTz2Yk4SvIcK+3JZLJCTLS+pnmUwbnjKs5TMAnWlm8tLCj+usPNf/DmC1ruqaAPjki
 ukvGESzK5C8oLoBJvGzIermSpCRSodHUSX17IrfqzWZnQdva9A50hRYY4lTCcgVtfzH6
 L1qQ==
X-Gm-Message-State: AOAM5317zj8yaooAr2PfldGxUS7nOMG9tsBqZ+heHNxABW3k7Peo+UPv
 I+bB6a+XRpUZtNxtgxMpGS8=
X-Google-Smtp-Source: ABdhPJxNRzOAXUlsAGy3dwNGwKzkgbiDf2j7GF/XbK5ojW1ylGXcOkLVEqx/FzGgbTzq7fMadevpXg==
X-Received: by 2002:a17:90b:2307:: with SMTP id
 mt7mr12023393pjb.131.1621014343673; 
 Fri, 14 May 2021 10:45:43 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:7268:613:2b37:5fbc?
 ([2601:647:4802:9070:7268:613:2b37:5fbc])
 by smtp.gmail.com with ESMTPSA id c12sm4493619pfr.154.2021.05.14.10.45.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 May 2021 10:45:42 -0700 (PDT)
Subject: Re: [PATCHv5 1/1] nvme-tcp: Add option to set the physical interface
 to be used when connecting over TCP sockets.
To: Martin Belanger <nitram_67@hotmail.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de,
 Martin Belanger <martin.belanger@dell.com>
References: <BL0PR13MB4291BFA1BAFE07D706D486A29C509@BL0PR13MB4291.namprd13.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1cf06695-930f-798c-0320-f6cdeef258aa@grimberg.me>
Date: Fri, 14 May 2021 10:45:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <BL0PR13MB4291BFA1BAFE07D706D486A29C509@BL0PR13MB4291.namprd13.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210514_104545_510899_A0D8C4D6 
X-CRM114-Status: GOOD (  55.07  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 5/14/21 4:46 AM, Martin Belanger wrote:
> From: Martin Belanger <martin.belanger@dell.com>
> 
> Addressed reviews from PATCHv4.
> 
> In our application, we need a way to force TCP connections to go out a
> specific IP interface instead of letting Linux select the interface
> based on the routing tables. This patch adds the option 'host-iface'
> to allow specifying the interface to use. Note that corresponding
> changes to the nvme-cli utility will follow.
> 
> When the option host-iface is specified, the driver uses the specified
> interface to set the option SO_BINDTODEVICE on the TCP socket before
> connecting.
> 
> This new option is needed in addtion to the existing host-traddr for
> the following reasons:
> 
> Specifying an IP interface by its associated IP address is less
> intuitive than specifying the actual interface name and, in some cases,
> simply doesn't work. That's because the association between interfaces
> and IP addresses is not predictable. IP addresses can be changed or can
> change by themselves over time (e.g. DHCP). Interface names are
> predictable [1] and will persist over time. Consider the following
> configuration.
> 
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state ...
>      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>      inet 100.0.0.100/24 scope global lo
>         valid_lft forever preferred_lft forever
> 2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc ...
>      link/ether 08:00:27:21:65:ec brd ff:ff:ff:ff:ff:ff
>      inet 100.0.0.100/24 scope global enp0s3
>         valid_lft forever preferred_lft forever
> 3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc ...
>      link/ether 08:00:27:4f:95:5c brd ff:ff:ff:ff:ff:ff
>      inet 100.0.0.100/24 scope global enp0s8
>         valid_lft forever preferred_lft forever
> 
> The above is a VM that I configured with the same IP address
> (100.0.0.100) on all interfaces. Doing a reverse lookup to identify the
> unique interface associated with 100.0.0.100 does not work here. And
> this is why the option host_iface is required. I understand that the
> above config does not represent a standard host system, but I'm using
> this to prove a point: "We can never know how users will configure
> their systems". By te way, The above configuration is perfectly fine
> by Linux.
> 
> The current TCP implementation for host_traddr performs a
> bind()-before-connect(). This is a common construct to set the source
> IP address on a TCP socket before connecting. This has no effect on how
> Linux selects the interface for the connection. That's because Linux
> uses the Weak End System model as described in RFC1122 [2]. On the other
> hand, setting the Source IP Address has benefits and should be supported
> by linux-nvme. In fact, setting the Source IP Address is a mandatory
> FedGov requirement (e.g. connection to a RADIUS/TACACS+ server).
> Consider the following configuration.
> 
> $ ip addr list dev enp0s8
> 3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc ...
>      link/ether 08:00:27:4f:95:5c brd ff:ff:ff:ff:ff:ff
>      inet 192.168.56.101/24 brd 192.168.56.255 scope global enp0s8
>         valid_lft 426sec preferred_lft 426sec
>      inet 192.168.56.102/24 scope global secondary enp0s8
>         valid_lft forever preferred_lft forever
>      inet 192.168.56.103/24 scope global secondary enp0s8
>         valid_lft forever preferred_lft forever
>      inet 192.168.56.104/24 scope global secondary enp0s8
>         valid_lft forever preferred_lft forever
> 
> Here we can see that several addresses are associated with interface
> enp0s8. By default, Linux always selects the default IP address,
> 192.168.56.101, as the source address when connecting over interface
> enp0s8. Some users, however, want the ability to specify a different
> source address (e.g., 192.168.56.102, 192.168.56.103, ...). The option
> host_traddr can be used as-is to perform this function.
> 
> In conclusion, I believe that we need 2 options for TCP connections.
> One that can be used to specify an interface (host-iface). And one that
> can be used to set the source address (host-traddr). Users should be
> allowed to use one or the other, or both, or none. Of course, the
> documentation for host_traddr will need some clarification. It should
> state that when used for TCP connection, this option only sets the
> source address. And the documentation for host_iface should say that
> this option is only available for TCP connections.
> 
> References:
> [1] https://www.freedesktop.org/wiki/Software/systemd/\
> PredictableNetworkInterfaceNames/
> [2] https://tools.ietf.org/html/rfc1122
> 
> Tested both IPv4 and IPv6 connections.
> 
> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
> ---
>   drivers/nvme/host/core.c    |  5 ++++
>   drivers/nvme/host/fabrics.c | 14 +++++++++++
>   drivers/nvme/host/fabrics.h |  6 ++++-
>   drivers/nvme/host/tcp.c     | 48 ++++++++++++++++++++++++++++++++++++-
>   4 files changed, 71 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 762125f2905f..f98255eb7deb 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4067,6 +4067,11 @@ static int nvme_class_uevent(struct device *dev, struct kobj_uevent_env *env)
> 
>   		ret = add_uevent_var(env, "NVME_HOST_TRADDR=%s",
>   				opts->host_traddr ?: "none");
> +		if (ret)
> +			return ret;
> +
> +		ret = add_uevent_var(env, "NVME_HOST_IFACE=%s",
> +				opts->host_iface ?: "none");
>   	}
>   	return ret;
>   }
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index a2bb7fc63a73..76dc3eaf46f3 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -112,6 +112,9 @@ int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
>   	if (ctrl->opts->mask & NVMF_OPT_HOST_TRADDR)
>   		len += scnprintf(buf + len, size - len, "%shost_traddr=%s",
>   				(len) ? "," : "", ctrl->opts->host_traddr);
> +	if (ctrl->opts->mask & NVMF_OPT_HOST_IFACE)
> +		len += scnprintf(buf + len, size - len, "%shost_iface=%s",
> +				(len) ? "," : "", ctrl->opts->host_iface);
>   	len += scnprintf(buf + len, size - len, "\n");
> 
>   	return len;
> @@ -545,6 +548,7 @@ static const match_table_t opt_tokens = {
>   	{ NVMF_OPT_KATO,		"keep_alive_tmo=%d"	},
>   	{ NVMF_OPT_HOSTNQN,		"hostnqn=%s"		},
>   	{ NVMF_OPT_HOST_TRADDR,		"host_traddr=%s"	},
> +	{ NVMF_OPT_HOST_IFACE,		"host_iface=%s"		},
>   	{ NVMF_OPT_HOST_ID,		"hostid=%s"		},
>   	{ NVMF_OPT_DUP_CONNECT,		"duplicate_connect"	},
>   	{ NVMF_OPT_DISABLE_SQFLOW,	"disable_sqflow"	},
> @@ -754,6 +758,15 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   			kfree(opts->host_traddr);
>   			opts->host_traddr = p;
>   			break;
> +		case NVMF_OPT_HOST_IFACE:
> +			p = match_strdup(args);
> +			if (!p) {
> +				ret = -ENOMEM;
> +				goto out;
> +			}
> +			kfree(opts->host_iface);
> +			opts->host_iface = p;
> +			break;
>   		case NVMF_OPT_HOST_ID:
>   			p = match_strdup(args);
>   			if (!p) {
> @@ -938,6 +951,7 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
>   	kfree(opts->trsvcid);
>   	kfree(opts->subsysnqn);
>   	kfree(opts->host_traddr);
> +	kfree(opts->host_iface);
>   	kfree(opts);
>   }
>   EXPORT_SYMBOL_GPL(nvmf_free_options);
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index d7f7974dc208..c31dad69a773 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -66,6 +66,7 @@ enum {
>   	NVMF_OPT_NR_POLL_QUEUES = 1 << 18,
>   	NVMF_OPT_TOS		= 1 << 19,
>   	NVMF_OPT_FAIL_FAST_TMO	= 1 << 20,
> +	NVMF_OPT_HOST_IFACE	= 1 << 21,
>   };
> 
>   /**
> @@ -83,7 +84,9 @@ enum {
>    * @trsvcid:	The transport-specific TRSVCID field for a port on the
>    *              subsystem which is adding a controller.
>    * @host_traddr: A transport-specific field identifying the NVME host port
> - *              to use for the connection to the controller.
> + *     to use for the connection to the controller.
> + * @host_iface: A transport-specific field identifying the NVME host
> + *     interface to use for the connection to the controller.
>    * @queue_size: Number of IO queue elements.
>    * @nr_io_queues: Number of controller IO queues that will be established.
>    * @reconnect_delay: Time between two consecutive reconnect attempts.
> @@ -108,6 +111,7 @@ struct nvmf_ctrl_options {
>   	char			*traddr;
>   	char			*trsvcid;
>   	char			*host_traddr;
> +	char			*host_iface;
>   	size_t			queue_size;
>   	unsigned int		nr_io_queues;
>   	unsigned int		reconnect_delay;
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 0222e23f5936..32e44527afaa 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -123,6 +123,7 @@ struct nvme_tcp_ctrl {
>   	struct blk_mq_tag_set	admin_tag_set;
>   	struct sockaddr_storage addr;
>   	struct sockaddr_storage src_addr;
> +	struct net_device	*ndev;
>   	struct nvme_ctrl	ctrl;
> 
>   	struct work_struct	err_work;
> @@ -1454,6 +1455,20 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
>   		}
>   	}
> 
> +	if (nctrl->opts->mask & NVMF_OPT_HOST_IFACE) {
> +		char *iface = nctrl->opts->host_iface;
> +		sockptr_t optval = KERNEL_SOCKPTR(iface);
> +
> +		ret = sock_setsockopt(queue->sock, SOL_SOCKET, SO_BINDTODEVICE,
> +				      optval, strlen(iface));
> +		if (ret) {
> +			dev_err(nctrl->device,
> +			  "failed to bind to interface %s queue %d err %d\n",
> +			  iface, qid, ret);
> +			goto err_sock;
> +		}
> +	}
> +
>   	queue->hdr_digest = nctrl->opts->hdr_digest;
>   	queue->data_digest = nctrl->opts->data_digest;
>   	if (queue->hdr_digest || queue->data_digest) {
> @@ -2514,6 +2529,37 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
>   		}
>   	}
> 
> +	if (opts->mask & NVMF_OPT_HOST_IFACE) {
> +		ctrl->ndev = dev_get_by_name(&init_net, opts->host_iface);
> +		if (!ctrl->ndev) {
> +			pr_err("invalid interface passed: %s\n",
> +			       opts->host_iface);
> +			ret = -ENODEV;
> +			goto out_free_ctrl;
> +		}
> +	}
> +
> +	/* For IPv6 HOST_TRADDR, check if scope ID is specified. If not, set
> +	 * HOST_TRADDR's scope ID to the scope ID of HOST_IFACE or the scope
> +	 * ID of TRADDR
> +	 */

Not sure I follow what this is doing. the binding is taken from either
host_traddr, host_iface or traddr? What are the rules here?

> +	if ((opts->mask & NVMF_OPT_HOST_TRADDR) &&
> +	    (ctrl->src_addr.ss_family == AF_INET6)) {
> +		struct sockaddr_in6 *src_addr6 =
> +			(struct sockaddr_in6 *)&ctrl->src_addr;
> +
> +		if (src_addr6->sin6_scope_id == 0) {
> +			if (ctrl->ndev && (ctrl->ndev->ifindex != 0)) {
> +				src_addr6->sin6_scope_id = ctrl->ndev->ifindex;
> +			} else {
> +				struct sockaddr_in6 *addr6 =
> +					(struct sockaddr_in6 *)&ctrl->addr;
> +
> +				src_addr6->sin6_scope_id = addr6->sin6_scope_id;
> +			}
> +		}
> +	}
> +
>   	if (!opts->duplicate_connect && nvme_tcp_existing_controller(opts)) {
>   		ret = -EALREADY;
>   		goto out_free_ctrl;
> @@ -2570,7 +2616,7 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
>   			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
>   			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
>   			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
> -			  NVMF_OPT_TOS,
> +			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE,
>   	.create_ctrl	= nvme_tcp_create_ctrl,
>   };
> 
> --
> 2.30.2
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
